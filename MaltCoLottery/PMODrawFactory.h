//
//  PMODrawFactory.h
//  MaltCoLottery
//
//  Created by Peter Molnar on 08/08/2016.
//  Copyright © 2016 Peter Molnar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PMODraw.h"
#import "PMOCalendarOperatedAbstract.h"

@interface PMODrawFactory : PMOCalendarOperatedAbstract

- (PMODraw *)createDraw:(NSDate *)drawDate;

@end
