//
//  PMODrawStorageFactory.h
//  MaltCoLottery
//
//  Created by Peter Molnar on 09/08/2016.
//  Copyright © 2016 Peter Molnar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PMODrawStorageController.h"

@interface PMODrawStorageFactory : NSObject

/**
 Build storage from the draws from default first date (01/01/2004) until today

 @return PMOStrorageController with all of the draws until today
 */
- (nonnull PMODrawStorageController *)buildStorage;

/**
 Build storage from the draws from |fromDate| until |toDate|

 @param fromDate The date from the draw dates will be genreated
 @param toDate   The date until the draw dates will be genreated

 @return PMOStrorageController with all of the draws between the fromDate toDate range
 */
- (nonnull PMODrawStorageController *)buildStorageFromDate:(nonnull NSDate *)fromDate toDate:(nonnull NSDate *)toDate;

@end
