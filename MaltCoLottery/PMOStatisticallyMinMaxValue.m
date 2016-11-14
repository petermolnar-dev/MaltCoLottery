//
//  PMOStatisticallyMinMaxValue.m
//  MaltCoLottery
//
//  Created by Peter Molnar on 14/11/2016.
//  Copyright © 2016 Peter Molnar. All rights reserved.
//

#import "PMOStatisticallyMinMaxValue.h"

@implementation PMOStatisticallyMinMaxValue

- (NSNumber *)maxOrMinValueFromDate:(NSDate *)fromDate toDate:(NSDate *)toDate countFromTheEnd:(BOOL)countFromTheEnd fromNumberStatsDictionary:(NSDictionary <NSNumber *, PMONumberStat *>*)numberStatsDictionary {
    NSArray *orderedArray = [self orderedArrayByNumberFromNumberStatsDictionary:numberStatsDictionary];
    NSArray *filtereadArrayForThisYear = [self filteredNumberStatisticsBetweenDates:fromDate toDate:toDate fromNumberStats:orderedArray];
    
    return [self arrayRangeFromArray:filtereadArrayForThisYear countFromTheEnd:countFromTheEnd resultArraySize:1].firstObject.number;
}

@end
