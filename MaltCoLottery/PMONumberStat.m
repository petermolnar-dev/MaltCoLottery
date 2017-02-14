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


- (NSString *)description {
    return [NSString stringWithFormat:@"Number: %@, drawcount:%lu, Drawdates: %@", self.number, [self.drawDates count], self.drawDates];
}
@end
