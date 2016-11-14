//
//  PMOStatisticallyHighOrLowForThisYear.h
//  MaltCoLottery
//
//  Created by Peter Molnar on 14/11/2016.
//  Copyright © 2016 Peter Molnar. All rights reserved.
//

#import "PMOStatisticAbstract.h"
#import "PMOStatisticProtocol.h"

@interface PMOStatisticallyHighOrLowForThisYear : PMOStatisticAbstract <PMOStatisticProtocol>

- (nullable NSArray *)statisticalyHighThisYearCountFromTheEnd:(BOOL)countFromTheEnd fromNumberStatsDictionary:(nonnull NSDictionary <NSNumber *, PMONumberStat *>*)numberStatsDictionary  resultArraySize:(NSInteger)resultArraySize;
@end
