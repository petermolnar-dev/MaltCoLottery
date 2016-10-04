//
//  PMODrawFactory.h
//  MaltCoLottery
//
//  Created by Peter Molnar on 08/08/2016.
//  Copyright © 2016 Peter Molnar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PMODrawModelController.h"
#import "PMOCalendarOperatedAbstract.h"

@interface PMODrawModelControllerFactory : PMOCalendarOperatedAbstract

/**
 Factory method to create a new modelcontroller.

 @param drawDate The required |drawDate|. The Factory will genereate the corresponding url for the drawing.

 @return A newly created modelcontroller for the given |drawDate|
 */
- (nonnull PMODrawModelController *)buildDrawModellControllerFromDrawDate:(nonnull NSDate *)drawDate;

@end
