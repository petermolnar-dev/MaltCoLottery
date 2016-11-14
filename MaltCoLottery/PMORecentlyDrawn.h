//
//  PMORecentlyDrawn.h
//  MaltCoLottery
//
//  Created by Peter Molnar on 14/11/2016.
//  Copyright © 2016 Peter Molnar. All rights reserved.
//

#import "PMOStatisticAbstract.h"
#import "PMOStatisticProtocol.h"

@interface PMORecentlyDrawn : PMOStatisticAbstract <PMOStatisticProtocol>

- (nullable NSArray *)recentlyDrawnCountFromEnd:(BOOL)countFromEnd fromNumberStatsDictionary:(nonnull NSDictionary <NSNumber *, PMONumberStat *>*)numberStatsDictionary  resultArraySize:(NSInteger)resultArraySize;

@end
