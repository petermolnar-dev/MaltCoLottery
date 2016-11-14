//
//  PMOStatisticallyMinMaxValue.h
//  MaltCoLottery
//
//  Created by Peter Molnar on 14/11/2016.
//  Copyright © 2016 Peter Molnar. All rights reserved.
//

#import "PMOStatisticAbstract.h"
#import "PMOStatisticProtocol.h"

@interface PMOStatisticallyMinMaxValue : PMOStatisticAbstract <PMOStatisticProtocol>

- (nullable NSNumber *)maxOrMinValueFromDate:(nonnull NSDate *)fromDate toDate:(nonnull NSDate *)toDate countFromTheEnd:(BOOL)countFromTheEnd fromNumberStatsDictionary:(nonnull NSDictionary <NSNumber *, PMONumberStat *>*)numberStatsDictionary;

@end
