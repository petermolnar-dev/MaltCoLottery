//
//  PMOCalendarOperatedAbstract.h
//  MaltCoLottery
//
//  Created by Peter Molnar on 14/08/2016.
//  Copyright © 2016 Peter Molnar. All rights reserved.
//

#import <Foundation/Foundation.h>

// Abstract class, do not instantiate 
@interface PMOCalendarOperatedAbstract : NSObject

@property (nonatomic, strong) NSDate *firstDrawDate;
@property (strong, nonatomic) NSCalendar *calendar;

- (NSString *)adjustNumberFor2Spaces:(NSUInteger)number;
- (NSDate *)createDateFromComponentsWithYear:(NSInteger)year withMonth:(NSInteger)month withDay:(NSInteger)day;
- (BOOL)isDateHoliday:(NSDate *)date;

@end
