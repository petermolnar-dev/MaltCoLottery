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
#import "PMORecentlyDrawn.h"
#import "PMOStatisticallyLowOrHigh.h"
#import "PMOStatisticallyHighOrLowForThisYear.h"
#import "PMOStatisticallyMinMaxValue.h"

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
    
    PMORecentlyDrawn *recentlyDrawnStatistic = [[PMORecentlyDrawn alloc] init];

    return [recentlyDrawnStatistic recentlyDrawnCountFromEnd:NO fromNumberStatsDictionary:self.numberStats resultArraySize:self.arraySizeForStatistics];
}

- (nullable NSArray *)leastRecentlyDrawn {
        PMORecentlyDrawn *recentlyDrawnStatistic = [[PMORecentlyDrawn alloc] init];
    
    return [recentlyDrawnStatistic recentlyDrawnCountFromEnd:YES fromNumberStatsDictionary:self.numberStats resultArraySize:self.arraySizeForStatistics];
}


- (nullable NSArray *)statisticalyLowInThisYear {
    PMOStatisticallyHighOrLowForThisYear *statForThisYear = [[PMOStatisticallyHighOrLowForThisYear alloc] init];

    return [statForThisYear statisticalyHighThisYearCountFromTheEnd:NO fromNumberStatsDictionary:self.numberStats resultArraySize:self.arraySizeForStatistics];
}

- (nullable NSArray *)statisticalyHighInThisYear {
    PMOStatisticallyHighOrLowForThisYear *statForThisYear = [[PMOStatisticallyHighOrLowForThisYear alloc] init];
    
    return [statForThisYear statisticalyHighThisYearCountFromTheEnd:YES fromNumberStatsDictionary:self.numberStats resultArraySize:self.arraySizeForStatistics];
}


- (nullable NSArray *)statisticalyLow {
    PMOStatisticallyLowOrHigh *statLowOrHigh = [[PMOStatisticallyLowOrHigh alloc] init];
    
    return [statLowOrHigh statisticalyHighCountFromTheEnd:NO fromNumberStatsDictionary:self.numberStats resultArraySize:self.arraySizeForStatistics];
}
- (nullable NSArray *)statisticalyHigh {
    PMOStatisticallyLowOrHigh *statLowOrHigh = [[PMOStatisticallyLowOrHigh alloc] init];
    
    return [statLowOrHigh statisticalyHighCountFromTheEnd:YES fromNumberStatsDictionary:self.numberStats resultArraySize:self.arraySizeForStatistics];
}


- (nullable NSNumber *)minValueFromDate:(nonnull NSDate *)fromDate toDate:(nonnull NSDate *)toDate {
    PMOStatisticallyMinMaxValue *statMinMax = [[PMOStatisticallyMinMaxValue alloc] init];
    
    return [statMinMax maxOrMinValueFromDate:fromDate toDate:toDate countFromTheEnd:YES fromNumberStatsDictionary:self.numberStats];
}

- (nullable NSNumber *)maxValueFromDate:(nonnull NSDate *)fromDate toDate:(nonnull NSDate *)toDate {
    PMOStatisticallyMinMaxValue *statMinMax = [[PMOStatisticallyMinMaxValue alloc] init];
    
    return [statMinMax maxOrMinValueFromDate:fromDate toDate:toDate countFromTheEnd:NO fromNumberStatsDictionary:self.numberStats];
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

@end
