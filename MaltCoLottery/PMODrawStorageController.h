//
//  PMODrawStorageController.h
//  MaltCoLottery
//
//  Created by Peter Molnar on 29/09/2016.
//  Copyright © 2016 Peter Molnar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PMODrawModelController.h"

@interface PMODrawStorageController : NSObject

/**
 Designated initializer of PMODrawStorageController
 
 @param models A nullable array of PMODrawModelController
 
 @return PMODrawStorageController with the PMODrawModelControllers passed on.
 */
- (nullable instancetype)initWithModelControllers:(nullable NSArray <PMODrawModelController *>*) models;

- (nullable NSArray *)models;
- (NSInteger)modelCount;

@end
