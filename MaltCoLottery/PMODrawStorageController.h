//
//  PMODrawStorageController.h
//  MaltCoLottery
//
//  Created by Peter Molnar on 29/09/2016.
//  Copyright © 2016 Peter Molnar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PMODrawModelController.h"
#import "PMODrawStorageProtocol.h"

static NSString *const _Nonnull PMODrawStorageFilledUp = @"PMODrawStorageFilledUp";


/**
 A storage contoller, storing all of the draw information.
 */
@interface PMODrawStorageController : NSObject <PMODrawStorageProtocol>

@property (unsafe_unretained, nonatomic) BOOL isAllModelParsed;
/**
 Designated initializer of PMODrawStorageController
 
 @param models A nullable array of PMODrawModelController
 
 @return PMODrawStorageController with the PMODrawModelControllers passed on.
 */
- (nullable instancetype)initWithModelControllers:(nullable NSArray <PMODrawModelController *>*) models NS_DESIGNATED_INITIALIZER;

/**
 Start populating the numbers for each modelcontroller
 */
- (void)populateDrawsNumbers;



@end
