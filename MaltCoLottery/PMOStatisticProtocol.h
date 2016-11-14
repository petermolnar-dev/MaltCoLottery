//
//  PMOStatisticProtocol.h
//  MaltCoLottery
//
//  Created by Peter Molnar on 14/11/2016.
//  Copyright © 2016 Peter Molnar. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol PMOStatisticProtocol <NSObject>


- (NSArray <PMONumberStat *>*)filteredNumberStatisticsForThisYearFromNumberStatsDictionary:(NSDictionary <NSNumber *,PMONumberStat *>*)numberStatsDictionary;

- (NSArray <PMONumberStat *>*)filteredNumberStatisticsBetweenDates:(NSDate *)fromDate toDate:(NSDate *)toDate fromNumberStats:(NSArray <PMONumberStat *>*)numberStatsArray;

- (NSArray <PMONumberStat *>*)filterOutEmptyEntriesFromSourceArray:(NSArray <PMONumberStat *>*)drawsArray includeEmptyDates:(BOOL)includeEmptyDates;

- (NSArray <PMONumberStat *>*)orderedArrayByDrawDateCountsFromNumberStatsDictionary:(NSDictionary <NSNumber *,PMONumberStat *>*)numberStatsDictionary;

- (NSArray <PMONumberStat *>*)orderedArrayByLastDrawDateFromNumberStatsDictionary:(NSDictionary <NSNumber *,PMONumberStat *>*)numberStatsDictionary;

- (NSArray <PMONumberStat *>*)orderedArrayByNumberFromNumberStatsDictionary:(NSDictionary <NSNumber *,PMONumberStat *>*)numberStatsDictionary;

- (NSArray <PMONumberStat *>*)orderedArrayByDrawDateCountsFromNumberStats:(NSArray <PMONumberStat *>*)numberStatsArray;

- (NSArray <PMONumberStat *>*)orderedArrayFromNumberStats:(NSArray <PMONumberStat *>*)numberStatsArray sortByKey:(NSString *)sortByKey;

- (NSArray <PMONumberStat *>*)arrayRangeFromArray:(NSArray <PMONumberStat *>*)sourceArray countFromTheEnd:(BOOL)countFromTheEnd resultArraySize:(NSInteger)resultArraySize;

- (NSArray <NSNumber*>*)extractNumbersFromNumberStatsArray:(NSArray <PMONumberStat *>*)numberStats;

- (NSInteger)yearFromDate:(NSDate *)date;

- (NSDate *)firstDayOfYearFromDate:(NSDate *)date;

@end
