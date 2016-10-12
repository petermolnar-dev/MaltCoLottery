//
//  PMODrawStorageController.h
//  MaltCoLottery
//
//  Created by Peter Molnar on 29/09/2016.
//  Copyright © 2016 Peter Molnar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PMODrawModelController.h"

static NSString *const _Nonnull PMODrawStorageFilledUp = @"PMODrawStorageFilledUp";

@interface PMODrawStorageController : NSObject

@property (unsafe_unretained, nonatomic) BOOL isAllModelParsed;
/**
 Designated initializer of PMODrawStorageController
 
 @param models A nullable array of PMODrawModelController
 
 @return PMODrawStorageController with the PMODrawModelControllers passed on.
 */
- (nullable instancetype)initWithModelControllers:(nullable NSArray <PMODrawModelController *>*) models;

/**
 Start populating the numbers for each modelcontroller
 */
- (void)populateDrawsNumbers;

/**
 Returns the current storage as a Dictionary

 @return dictionary of the PMODrawModels
 */
- (nullable NSDictionary *)models;


/**
 The count of the modelcontrollers stored in the storage

 @return the count of the models
 */
- (NSInteger)modelCount;


@end
