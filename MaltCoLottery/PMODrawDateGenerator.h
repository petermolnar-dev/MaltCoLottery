//
//  PMODateGenerator.h
//  MaltCoLottery
//
//  Created by Peter Molnar on 20/05/2016.
//  Copyright © 2016 Peter Molnar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PMOCalendarOperatedAbstract.h"

/*!
Generates the possible draw dates for the MaltCo lottery (on every Wednesday).

The following methodes are declared:

@p- (NSArray *)drawDaysUntilToday;

@p- (NSArray *)drawDaysFromDate:(NSDate *)fromDate toDate:(NSDate *)toDate;

 */
@interface PMODrawDateGenerator : PMOCalendarOperatedAbstract

/*!
 @brief Generate draw days from self.firstDarawDate until today
 
 @return Array of NSDates
 */
- (nullable NSArray <NSDate *>*)drawDaysUntilToday;

/*!
 @brief Generate draw days between two dates

 @param (NSDate *)fromDate: Startdate for the generation range
 @param (NSDate *)toDate: End date for the genration range

 @return Array of NSDates
 */
- (nullable NSArray <NSDate *>*)drawDaysFromDate:(nonnull NSDate *)fromDate toDate:(nonnull NSDate *)toDate;

@end
