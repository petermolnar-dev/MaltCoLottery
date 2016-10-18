//
//  PMODraw.m
//  MaltCoLottery
//
//  Created by Peter Molnar on 07/08/2016.
//  Copyright © 2016 Peter Molnar. All rights reserved.
//

#import "PMODraw.h"

@implementation PMODraw

#pragma mark - Initializers
- (instancetype)initWithDrawDate:(NSDate *)drawDate{
    self = [super init];
    
    if (self && drawDate) {
        _drawDate = drawDate;
    } else {
        @throw [NSException exceptionWithName:@"Draw date is missing"
                                       reason:@"Use [[PMODraw alloc] initWithDrawDate:]"
                                     userInfo:nil];
        return nil;

    }
    return self;
}

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-designated-initializers"
- (instancetype)init
{
    @throw [NSException exceptionWithName:@"Not a designated initializer"
                                   reason:@"Use [[PMODraw alloc] initWithDrawDate:]"
                                 userInfo:nil];
    return nil;
}
#pragma clang diagnostic pop


@end
