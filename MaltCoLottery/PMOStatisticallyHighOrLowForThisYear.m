//
//  PMOStatisticallyHighOrLowForThisYear.m
//  MaltCoLottery
//
//  Created by Peter Molnar on 14/11/2016.
//  Copyright © 2016 Peter Molnar. All rights reserved.
//

#import "PMOStatisticallyHighOrLowForThisYear.h"

@implementation PMOStatisticallyHighOrLowForThisYear

- (NSArray *)statisticalyHighThisYearCountFromTheEnd:(BOOL)countFromTheEnd fromNumberStatsDictionary:(NSDictionary <NSNumber *, PMONumberStat *>*)numberStatsDictionary  resultArraySize:(NSInteger)resultArraySize {
    NSArray *filtereadArrayForThisYear = [self filteredNumberStatisticsForThisYearFromNumberStatsDictionary:numberStatsDictionary];
    NSArray *orderedArray = [self orderedArrayByDrawDateCountsFromNumberStats:filtereadArrayForThisYear];
    NSArray *resultArray = [self arrayRangeFromArray:orderedArray countFromTheEnd:countFromTheEnd resultArraySize:resultArraySize];
    return [[self extractNumbersFromNumberStatsArray:resultArray] sortedArrayUsingSelector:@selector(compare:)];
}

@end
