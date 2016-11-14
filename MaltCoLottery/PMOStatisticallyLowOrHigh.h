//
//  PMOStatisticallyLowOrHigh.h
//  MaltCoLottery
//
//  Created by Peter Molnar on 14/11/2016.
//  Copyright © 2016 Peter Molnar. All rights reserved.
//

#import "PMOStatisticAbstract.h"
#import "PMOStatisticProtocol.h"

@interface PMOStatisticallyLowOrHigh : PMOStatisticAbstract <PMOStatisticProtocol>


- (nullable NSArray *)statisticalyHighCountFromTheEnd:(BOOL)countFromTheEnd fromNumberStatsDictionary:(nonnull NSDictionary <NSNumber *, PMONumberStat *>*)numberStatsDictionary  resultArraySize:(NSInteger)resultArraySize;

@end
