//
//  PMONumberStats.m
//  MaltCoLottery
//
//  Created by Peter Molnar on 12/08/2016.
//  Copyright © 2016 Peter Molnar. All rights reserved.
//

#import "PMONumberStats.h"

@implementation PMONumberStats

- (NSNumber *)drawCount {
    return [NSNumber numberWithInteger:[self.drawDates count]];
}

- (NSNumber *)drawCountInYear:(NSNumber *)year {
    return nil;
}

@end
