//
//  PMODateGenerator.h
//  MaltCoLottery
//
//  Created by Peter Molnar on 20/05/2016.
//  Copyright © 2016 Peter Molnar. All rights reserved.
//

#import <Foundation/Foundation.h>
/*!
Generates the possible draw dates for the MaltCo lottery (on every Wednesday).

The following methodes are declared:

@p- (NSArray *)drawDaysUntilToday;

@p- (NSArray *)drawDaysFromDate:(NSDate *)fromDate toDate:(NSDate *)toDate;

@p- (NSDate *)createDateFromComponentsWithYear:(NSInteger)year withMonth:(NSInteger)month withDay:(NSInteger)day;
 */
@interface PMODrawDateGenerator : NSObject

@property (strong, nonatomic) NSString *baseURLAsString;

- (NSArray *)drawDaysUntilToday;

/*!
 @brief Generate draw days between two dates
 @param (NSDate *)fromDate: Startdate for the generation range
 @param (NSDate *)toDate: End date for the genration range

 @return Array of NSDates
 */
- (NSArray *)drawDaysFromDate:(NSDate *)fromDate toDate:(NSDate *)toDate;
- (NSDate *)createDateFromComponentsWithYear:(NSInteger)year withMonth:(NSInteger)month withDay:(NSInteger)day;

@end
