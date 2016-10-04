//
//  PMODateGenerator.m
//  MaltCoLottery
//
//  Created by Peter Molnar on 20/05/2016.
//  Copyright © 2016 Peter Molnar. All rights reserved.
//

#import "PMODrawDateGenerator.h"

@implementation PMODrawDateGenerator

- (NSArray <NSDate *>*)drawDaysUntilToday {
    
    NSDate *now = [NSDate date];
    NSDate *currentDate = self.firstDrawDate;
    
    return [self drawDaysFromDate:currentDate toDate:now];
    
}

- (NSArray <NSDate *>*)drawDaysFromDate:(NSDate *)fromDate toDate:(NSDate *)toDate {
    NSTimeInterval secondsPerDay = 24 * 60 * 60;

    NSDateComponents *weekDayComponents = [self.calendar components:NSCalendarUnitWeekday fromDate:fromDate];
    NSInteger dayOfWeek = [weekDayComponents weekday];
    
    
    NSMutableArray <NSDate *>*resultArray = [[NSMutableArray alloc] init];
    
    while (dayOfWeek != 4) { // We are looking for the next Wednesday
        fromDate = [fromDate dateByAddingTimeInterval:secondsPerDay];
        weekDayComponents = [self.calendar components:NSCalendarUnitWeekday fromDate:fromDate];
        dayOfWeek = [weekDayComponents weekday];
    }
    
    while ([toDate compare:fromDate] == NSOrderedDescending || [toDate compare:fromDate] == NSOrderedSame) {
        [resultArray addObject:fromDate];
        if ([self isDateHoliday:fromDate]) {
            // Add the the day before and after to the array
            NSDate *dateBeforeCurrentDate = [fromDate dateByAddingTimeInterval:-secondsPerDay];
            [resultArray addObject:dateBeforeCurrentDate];
            NSDate *dateAfterCurrentDate = [fromDate dateByAddingTimeInterval:secondsPerDay];
            [resultArray addObject:dateAfterCurrentDate];
        }
        NSTimeInterval secondsInWeek = 7 * 24 * 60 * 60;
        fromDate = [fromDate dateByAddingTimeInterval:secondsInWeek];
    }
    
    return [resultArray copy];
    
}

@end
