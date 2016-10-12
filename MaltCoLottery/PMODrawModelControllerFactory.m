//
//  PMODrawFactory.m
//  MaltCoLottery
//
//  Created by Peter Molnar on 08/08/2016.
//  Copyright © 2016 Peter Molnar. All rights reserved.
//

#import "PMODrawModelControllerFactory.h"
#import "PMODrawURLGenerator.h"

@implementation PMODrawModelControllerFactory

#pragma mark - Factory method
- (PMODrawModelController *)buildDrawModellControllerFromDrawDate:(NSDate *)drawDate {
    if (drawDate) {
        NSString *drawID = [self generateDrawIDFromDate:drawDate];
        PMODrawURLGenerator *urlGenerator = [[PMODrawURLGenerator alloc] init];
        NSURL *drawURL = [urlGenerator generateDrawURLFromDate:drawDate];
        
        PMODrawModelController *modelController = [[PMODrawModelController alloc] initWithDrawID:drawID fromURL:drawURL];
        
        return modelController;
    } else {
        @throw [NSException exceptionWithName:@"Can't be initialised with null parameter"
                                       reason:@"Use buildDrawModellControllerFromDrawDate:drawDate"
                                     userInfo:nil];
        return nil;
    }
    
}

#pragma mark - helpers
- (NSString *)generateDrawIDFromDate:(NSDate *)drawDate {
    NSDateComponents *monthAndDay = [self.calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:drawDate];
    return [NSString stringWithFormat:@"%@%@%@",[self adjustNumberFor2Spaces:[monthAndDay year]],[self adjustNumberFor2Spaces:[monthAndDay month]],[self adjustNumberFor2Spaces:[monthAndDay day]]];
}


@end
