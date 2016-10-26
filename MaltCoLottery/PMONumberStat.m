//
//  PMONumberStats.m
//  MaltCoLottery
//
//  Created by Peter Molnar on 12/08/2016.
//  Copyright © 2016 Peter Molnar. All rights reserved.
//

#import "PMONumberStat.h"

@implementation PMONumberStat

- (instancetype)initWithNumber:(NSNumber *)number drawDates:(NSArray<NSDate *> *)drawDates {
    self = [super init];
    
    if (self && number) {
        _number = number;
        _drawDates = drawDates;
        NSDate *lastDrawDate = [drawDates valueForKeyPath:@"@max.self"];
        _lastDrawDay = lastDrawDate;
    } else {
        return nil;
    }
    
    return self;
}

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-designated-initializers"
- (instancetype)init
{
    @throw [NSException exceptionWithName:@"Not a designated initializer"
                                   reason:@"Use [[PMONumberStats alloc] initWithNumber: drawDates:]"
                                 userInfo:nil];
    return nil;
}
#pragma clang diagnostic pop

- (NSString *)description {
    return [NSString stringWithFormat:@"Number: %@, drawcount:%lu, Drawdates: %@", self.number, [self.drawDates count], self.drawDates];
}
@end
