//
//  PMODrawURLGenerator.h
//  MaltCoLottery
//
//  Created by Peter Molnar on 03/08/2016.
//  Copyright © 2016 Peter Molnar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PMOCalendarOperatedAbstract.h"

@interface PMODrawURLGenerator : PMOCalendarOperatedAbstract
/*! Generates a MaltCo Lottery Draw URL form the date
 
 The following methodes are declared:
 
 @p- (NSURL *)generateDrawURLFromDate:(NSDate *)drawDate;

 @return the draw URL based on the date
*/
- (NSURL *)generateDrawURLFromDate:(NSDate *)drawDate;

@end
