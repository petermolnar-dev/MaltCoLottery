//
//  PMODrawFactory.m
//  MaltCoLottery
//
//  Created by Peter Molnar on 08/08/2016.
//  Copyright © 2016 Peter Molnar. All rights reserved.
//

#import "PMODrawModelControllerFactory.h"


@implementation PMODrawModelControllerFactory

#pragma mark - Factory method
+ (PMODrawModelController *)buildDrawModellControllerFromDrawDate:(NSDate *)drawDate {
    
    if (drawDate) {
        PMODrawModelController *modelController = [[PMODrawModelController alloc] initWithDrawDate:drawDate];
        
        return modelController;
    } else {
        @throw [NSException exceptionWithName:@"Can't be initialised with null parameter"
                                       reason:@"Use buildDrawModellControllerFromDrawDate:drawDate"
                                     userInfo:nil];
        return nil;
    }
    
}

+ (PMODrawModelController *)buildDrawModelControllerFromExistingDraw:(id<PMODrawProtocol>)draw {
    if (draw.drawDate) {
        if (draw.numbers) {
            PMODrawModelController *modelController = [[PMODrawModelController alloc] initWithExisitingDraw:draw];
            return modelController;
        } else {
            return [PMODrawModelControllerFactory buildDrawModellControllerFromDrawDate:draw.drawDate];
            
        }
    } else {
        @throw [NSException exceptionWithName:@"Can't be initialised with null parameter"
                                       reason:@"Use buildDrawModelControllerFromExistingDraw"
                                     userInfo:nil];
        return nil;
    }
}



@end
