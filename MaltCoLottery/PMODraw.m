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

#pragma mark - Helpers
- (NSArray *)sortedNumbers {
    NSArray *sortedNumbers = [self.numbers sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        if ([(NSNumber *)obj1 integerValue] < [(NSNumber *)obj2 integerValue] ) {
            return NSOrderedAscending;
        } else if ([(NSNumber *)obj2 integerValue] < [(NSNumber *)obj1 integerValue] ) {
            return NSOrderedDescending;
        } else {
            return NSOrderedSame;
        }
    }];
    
    return sortedNumbers;
}

- (NSNumber *)minNumber {
    return [[self sortedNumbers] firstObject];
}

- (NSNumber *)maxNumber {
    return [[self sortedNumbers] lastObject];
}


@end
