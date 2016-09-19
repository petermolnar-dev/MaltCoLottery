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

- (PMODrawModelController *)createDrawModellController:(NSDate *)drawDate;

@end
