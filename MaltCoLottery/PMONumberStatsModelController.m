//
//  PMONumberStatsModelController.m
//  MaltCoLottery
//
//  Created by Peter Molnar on 12/10/2016.
//  Copyright © 2016 Peter Molnar. All rights reserved.
//

#import "PMONumberStatsModelController.h"
#import "PMONumberStat.h"
#import "PMODrawDataProtocol.h"

#define CALL_ORIGIN NSLog(@"Origin: [%@]", [[[[NSThread callStackSymbols] objectAtIndex:1] componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"[]"]] objectAtIndex:1])


@interface PMONumberStatsModelController()

/**
 NSMutableDictionary to hold the number statistical information
 */
@property (strong, nonatomic, nonnull) NSMutableDictionary <NSNumber *,PMONumberStat *> *numberStats;

/**
 To store the number's count for the game
 */
@property (strong, nonatomic, nonnull) NSNumber *numbersInGame;

@property (nonatomic) NSInteger arraySizeForStatistics;



/**
 Initialize an empty mutable directory of numberStats
 */
- (void)createEmptyStorageForNumberOfStatistics;


@end

@implementation PMONumberStatsModelController

#pragma mark - Initializers
- (instancetype)initWithNumberCount:(NSNumber *)numbersInGame arraySizeForStatistics:(NSInteger)arraySize {
    if (numbersInGame) {
        self = [super init];
        if (self) {
            _numbersInGame = numbersInGame;
            if (arraySize > 0) {
                _arraySizeForStatistics = arraySize;
            } else {
                _arraySizeForStatistics = 5;
            }
            [self createEmptyStorageForNumberOfStatistics];
        }
    } else {
        @throw [NSException exceptionWithName:@"Nil value passed to a nonnull paramter"
                                       reason:@"Use [[PMONumberStatsModelController alloc] initWithNumberCount:arraySizeForStatistics:]"
                                     userInfo:nil];
        self = nil;
    }
    
    return self;
}

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-designated-initializers"
- (instancetype)init
{
    @throw [NSException exceptionWithName:@"Not designated initializer"
                                   reason:@"Use [[PMONumberStatsModelController alloc] initWithNumberCount:arraySizeForStatistics: ]"
                                 userInfo:nil];
    return nil;
}
#pragma clang diagnostic pop


#pragma mark - Accessors
- (NSInteger)arraySizeForStatistics {
    if (_arraySizeForStatistics == 0) {
        return 5;
    } else {
        return _arraySizeForStatistics;
    }
}

#pragma mark - Public API
- (void)updateStatisticFromNumberStorage:(id<PMODrawStorageProtocol>)storage {
    
    [self createEmptyStorageForNumberOfStatistics];
    [self parseStorage:storage];
}


#pragma mark - Statistical methods for recent elements
- (nullable NSArray *)lastRecentlyDrawn {
    
    return [self recentlyDrawnCountFromEnd:NO];
}

- (nullable NSArray *)leastRecentlyDrawn{
    
    return [self recentlyDrawnCountFromEnd:YES];
}

- (nullable NSArray *)recentlyDrawnCountFromEnd:(BOOL)countFromEnd {
    NSArray *orderedArray = [self orderedArrayByLastDrawDateFromNumberStatsDictionary:self.numberStats];
    NSArray *filteredArray = [self filterOutEmptyEntriesFromSourceArray:orderedArray includeEmptyDates:NO];
    NSArray *resultArray = [self arrayRangeFromArray:filteredArray countFromTheEnd:countFromEnd resultArraySize:self.arraySizeForStatistics];
    return [[self extractNumbersFromNumberStatsArray:resultArray] sortedArrayUsingSelector: @selector(compare:)];
    
}

- (nullable NSArray *)statisticalyLowInThisYear {
    return [self statisticalyHighThisYearCountFromTheEnd:NO];
}

- (nullable NSArray *)statisticalyHighInThisYear {
    
    return [self statisticalyHighThisYearCountFromTheEnd:YES];
}

- (nullable NSArray *)statisticalyHighThisYearCountFromTheEnd:(BOOL)countFromTheEnd {
    NSArray *filtereadArrayForThisYear = [self filteredNumberStatisticsForThisYearFromNumberStatsDictionary:self.numberStats];
    NSArray *orderedArray = [self orderedArrayByDrawDateCountsFromNumberStats:filtereadArrayForThisYear];
    NSArray *resultArray = [self arrayRangeFromArray:orderedArray countFromTheEnd:countFromTheEnd resultArraySize:self.arraySizeForStatistics];
    return [[self extractNumbersFromNumberStatsArray:resultArray] sortedArrayUsingSelector:@selector(compare:)];
}

- (nullable NSArray *)statisticalyLow {
    return [self statisticalyHighCountFromTheEnd:NO];
}
- (nullable NSArray *)statisticalyHigh {
    return [self statisticalyHighCountFromTheEnd:YES];
}

- (nullable NSArray *)statisticalyHighCountFromTheEnd:(BOOL)countFromTheEnd {
    NSArray *filtereadArray = [self filterOutEmptyEntriesFromSourceArray:[self.numberStats allValues] includeEmptyDates:NO];
    NSArray *orderedArray = [self orderedArrayByDrawDateCountsFromNumberStats:filtereadArray];
    NSArray *resultArray = [self arrayRangeFromArray:orderedArray countFromTheEnd:countFromTheEnd resultArraySize:self.arraySizeForStatistics];
    return [[self extractNumbersFromNumberStatsArray:resultArray] sortedArrayUsingSelector:@selector(compare:)];
}


- (nullable NSNumber *)minValueFromDate:(nonnull NSDate *)fromDate toDate:(nonnull NSDate *)toDate {
    return [self maxOrMinValueFromDate:fromDate toDate:toDate countFromTheEnd:YES];
}

- (nullable NSNumber *)maxValueFromDate:(nonnull NSDate *)fromDate toDate:(nonnull NSDate *)toDate {
    return [self maxOrMinValueFromDate:fromDate toDate:toDate countFromTheEnd:NO];
}

- (NSNumber *)maxOrMinValueFromDate:(nonnull NSDate *)fromDate toDate:(nonnull NSDate *)toDate countFromTheEnd:(BOOL)countFromTheEnd {
    NSArray *orderedArray = [self orderedArrayByNumberFromNumberStatsDictionary:self.numberStats];
    NSArray *filtereadArrayForThisYear = [self filteredNumberStatisticsBetweenDates:fromDate toDate:toDate fromNumberStats:orderedArray];
    
    return [self arrayRangeFromArray:filtereadArrayForThisYear countFromTheEnd:countFromTheEnd resultArraySize:1].firstObject.number;
}

- (NSInteger)drawCountAllTimesForNumber:(nonnull NSNumber *)number {
    return [[self.numberStats objectForKey:number].drawDates count];
}



#pragma mark - Helpers
- (void)createEmptyStorageForNumberOfStatistics {
    NSMutableDictionary *newNumberStats = [[NSMutableDictionary alloc] init];
    for (int i = 1; i < [self.numbersInGame intValue]+1; i++ ) {
        PMONumberStat *numberStat = [[PMONumberStat alloc] initWithNumber:[NSNumber numberWithInt:i] drawDates:nil];
        [newNumberStats setObject:numberStat forKey:numberStat.number];
    }
    _numberStats = newNumberStats;
}

- (void)parseStorage:(id<PMODrawStorageProtocol>)storage {
    
    for (id<PMODrawDataProtocol> draw in [[storage models] allValues]) {
        for (NSNumber *number in [draw numbers]) {
            NSMutableArray *drawDates =[NSMutableArray arrayWithArray:_numberStats[number].drawDates];
            [drawDates addObject:[draw drawDate]];
            PMONumberStat *newNumberStat = [[PMONumberStat alloc] initWithNumber:number drawDates:drawDates];
            _numberStats[number] = newNumberStat;
        }
    }
}

#pragma mark - Filtering helper functions
- (NSArray <PMONumberStat *>*)filteredNumberStatisticsForThisYearFromNumberStatsDictionary:(NSDictionary <NSNumber *,PMONumberStat *>*)numberStatsDictionary {
    NSArray *numberStats = [numberStatsDictionary allValues];
    NSDate *today = [NSDate date];
    NSDate *firstDayOfThisYear = [self firstDayOfYearFromDate:today];
    return [self filteredNumberStatisticsBetweenDates:firstDayOfThisYear toDate:today fromNumberStats:numberStats];
    
}


- (NSArray <PMONumberStat *>*)filteredNumberStatisticsBetweenDates:(NSDate *)fromDate toDate:(NSDate *)toDate fromNumberStats:(NSArray <PMONumberStat *>*)numberStatsArray {
    NSMutableArray *resultArray = [[NSMutableArray alloc] init];
    
    for (PMONumberStat *currNumStatistic in numberStatsArray) {
        if (currNumStatistic.drawDates) {
            NSPredicate *dateRangePredicate = [NSPredicate predicateWithFormat:@"self >= %@ AND self <= %@", fromDate,toDate];
            NSArray *filteredArray = [currNumStatistic.drawDates filteredArrayUsingPredicate:dateRangePredicate];
            if ([filteredArray count] >0) {
                PMONumberStat *numberStatWithDrawsBetweenDates = [[PMONumberStat alloc] initWithNumber:currNumStatistic.number drawDates:filteredArray];
                [resultArray addObject:numberStatWithDrawsBetweenDates];
            }
        }
    }
    return resultArray;
}

- (NSArray <PMONumberStat *>*)filterOutEmptyEntriesFromSourceArray:(NSArray <PMONumberStat *>*)drawsArray includeEmptyDates:(BOOL)includeEmptyDates {
    
    if (includeEmptyDates) {
        return drawsArray;
    } else {
        NSPredicate *drawsWithLastDrawDay = [NSPredicate predicateWithFormat:@"lastDrawDay != nil"];
        return  [drawsArray filteredArrayUsingPredicate:drawsWithLastDrawDay];
    }
}


#pragma mark - Ordering helper functions
- (NSArray <PMONumberStat *>*)orderedArrayByDrawDateCountsFromNumberStatsDictionary:(NSDictionary <NSNumber *,PMONumberStat *>*)numberStatsDictionary {
    NSArray *numberStats = [numberStatsDictionary allValues];
    return  [self orderedArrayByDrawDateCountsFromNumberStats:numberStats];
}


- (NSArray <PMONumberStat *>*)orderedArrayByLastDrawDateFromNumberStatsDictionary:(NSDictionary <NSNumber *,PMONumberStat *>*)numberStatsDictionary {
    NSArray *numberStats = [numberStatsDictionary allValues];
    return  [self orderedArrayFromNumberStats:numberStats sortByKey:@"lastDrawDay"];
}

- (NSArray <PMONumberStat *>*)orderedArrayByNumberFromNumberStatsDictionary:(NSDictionary <NSNumber *,PMONumberStat *>*)numberStatsDictionary {
    NSArray *numberStats = [numberStatsDictionary allValues];
    return  [self orderedArrayFromNumberStats:numberStats sortByKey:@"number"];
}


- (NSArray <PMONumberStat *>*)orderedArrayByDrawDateCountsFromNumberStats:(NSArray <PMONumberStat *>*)numberStatsArray {
    NSArray <PMONumberStat *>*sortedArray = [numberStatsArray sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        NSArray *obj1DrawDates = [obj1 valueForKey:@"drawDates"];
        NSArray *obj2DrawDates = [obj2 valueForKey:@"drawDates"];
        
        if ([obj1DrawDates count] > [obj2DrawDates count]) {
            return (NSComparisonResult)NSOrderedDescending;
        } else {
            return (NSComparisonResult)NSOrderedAscending;
        }
    }];
    
    return  sortedArray;
}

- (NSArray <PMONumberStat *>*)orderedArrayFromNumberStats:(NSArray <PMONumberStat *>*)numberStatsArray sortByKey:(NSString *)sortByKey {
    
    NSSortDescriptor *lastDrawDateDescriptor = [NSSortDescriptor
                                                sortDescriptorWithKey:sortByKey
                                                ascending:NO];
    
    NSArray *sortDescriptors = [NSArray arrayWithObjects:lastDrawDateDescriptor, nil];
    return  [numberStatsArray sortedArrayUsingDescriptors:sortDescriptors];
}


#pragma mark - Subarraying helper functions
- (NSArray <PMONumberStat *>*)arrayRangeFromArray:(NSArray <PMONumberStat *>*)sourceArray countFromTheEnd:(BOOL)countFromTheEnd resultArraySize:(NSInteger)resultArraySize {
    NSArray <PMONumberStat *>*resultSubArray;
    if ([sourceArray count]>0) {
        if (countFromTheEnd) {
            resultSubArray = [sourceArray subarrayWithRange:NSMakeRange(MAX(0, [sourceArray  count] - resultArraySize), MIN(resultArraySize, [sourceArray  count]))];
        } else {
            resultSubArray = [sourceArray subarrayWithRange:NSMakeRange(0, MIN([sourceArray  count],resultArraySize))];
        }
    } else {
        NSLog(@"Statistical Array is empty.");
        CALL_ORIGIN;
    
    }
    
    return resultSubArray;
}

#pragma mark - Extracing numbers helper
- (NSArray <NSNumber*>*)extractNumbersFromNumberStatsArray:(NSArray <PMONumberStat *>*)numberStats {
    NSMutableArray *numbersArray = [[NSMutableArray alloc] init];
    
    for (PMONumberStat *currStat in numberStats) {
        [numbersArray addObject:currStat.number];
    }
    return [numbersArray copy];
}

#pragma mark - Date helpers
- (NSInteger)yearFromDate:(NSDate *)date {
    NSDateComponents *components = [self.calendar components:NSCalendarUnitYear fromDate:date];
    NSInteger year = [components year];
    return year;
}


-(NSDate *)firstDayOfYearFromDate:(NSDate *)date {
    NSDateComponents *resultDate = [NSDateComponents new];
    [resultDate setDay:1];
    [resultDate setMonth:1];
    [resultDate setYear:[self yearFromDate:date]];
    
    NSDate *firstDayOfYear = [self.calendar dateFromComponents:resultDate];
    return firstDayOfYear;
    
}


@end
