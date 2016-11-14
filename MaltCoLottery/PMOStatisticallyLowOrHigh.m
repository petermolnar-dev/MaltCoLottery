//
//  PMOStatisticallyLowOrHigh.m
//  MaltCoLottery
//
//  Created by Peter Molnar on 14/11/2016.
//  Copyright © 2016 Peter Molnar. All rights reserved.
//

#import "PMOStatisticallyLowOrHigh.h"

@implementation PMOStatisticallyLowOrHigh

- (nullable NSArray *)statisticalyHighCountFromTheEnd:(BOOL)countFromTheEnd fromNumberStatsDictionary:(nonnull NSDictionary <NSNumber *, PMONumberStat *>*)numberStatsDictionary  resultArraySize:(NSInteger)resultArraySize {
    NSArray *filtereadArray = [self filterOutEmptyEntriesFromSourceArray:[numberStatsDictionary allValues] includeEmptyDates:NO];
    NSArray *orderedArray = [self orderedArrayByDrawDateCountsFromNumberStats:filtereadArray];
    NSArray *resultArray = [self arrayRangeFromArray:orderedArray countFromTheEnd:countFromTheEnd resultArraySize:resultArraySize];
    return [[self extractNumbersFromNumberStatsArray:resultArray] sortedArrayUsingSelector:@selector(compare:)];
}

@end
