//
//  PMOStatisticAbstract.m
//  MaltCoLottery
//
//  Created by Peter Molnar on 14/11/2016.
//  Copyright © 2016 Peter Molnar. All rights reserved.
//

#import "PMOStatisticAbstract.h"


#define CALL_ORIGIN NSLog(@"Origin: [%@]", [[[[NSThread callStackSymbols] objectAtIndex:1] componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"[]"]] objectAtIndex:1])

@interface PMOStatisticAbstract()

@end

@implementation PMOStatisticAbstract

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


- (NSDate *)firstDayOfYearFromDate:(NSDate *)date {
    NSDateComponents *resultDate = [NSDateComponents new];
    [resultDate setDay:1];
    [resultDate setMonth:1];
    [resultDate setYear:[self yearFromDate:date]];
    
    NSDate *firstDayOfYear = [self.calendar dateFromComponents:resultDate];
    return firstDayOfYear;
    
}


@end
