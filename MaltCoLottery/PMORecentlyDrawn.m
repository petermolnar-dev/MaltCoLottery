//
//  PMORecentlyDrawn.m
//  MaltCoLottery
//
//  Created by Peter Molnar on 14/11/2016.
//  Copyright © 2016 Peter Molnar. All rights reserved.
//

#import "PMORecentlyDrawn.h"

@implementation PMORecentlyDrawn


- (nullable NSArray *)recentlyDrawnCountFromEnd:(BOOL)countFromEnd fromNumberStatsDictionary:(NSDictionary <NSNumber *,PMONumberStat *>*)numberStatsDictionary  resultArraySize:(NSInteger)resultArraySize {
    NSArray *orderedArray = [self orderedArrayByLastDrawDateFromNumberStatsDictionary:numberStatsDictionary];
    NSArray *filteredArray = [self filterOutEmptyEntriesFromSourceArray:orderedArray includeEmptyDates:NO];
    NSArray *resultArray = [self arrayRangeFromArray:filteredArray countFromTheEnd:countFromEnd resultArraySize:resultArraySize];
    return [[self extractNumbersFromNumberStatsArray:resultArray] sortedArrayUsingSelector: @selector(compare:)];
    
}

@end
