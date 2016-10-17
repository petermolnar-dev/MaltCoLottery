//
//  PMODrawStorageProtocol.h
//  MaltCoLottery
//
//  Created by Peter Molnar on 13/10/2016.
//  Copyright © 2016 Peter Molnar. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol PMODrawStorageProtocol <NSObject>

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
