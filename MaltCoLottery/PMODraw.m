//
//  PMODraw.m
//  MaltCoLottery
//
//  Created by Peter Molnar on 07/08/2016.
//  Copyright © 2016 Peter Molnar. All rights reserved.
//

#import "PMODraw.h"

@implementation PMODraw

#pragma mark - Method overrides
- (NSString *)description {
    return [NSString stringWithFormat:@"DrawId: %@, numbers: %@", self.drawID, self.numbers];
}

@end
