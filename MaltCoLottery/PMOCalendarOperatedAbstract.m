//
//  PMOCalendarOperatedAbstract.m
//  MaltCoLottery
//
//  Created by Peter Molnar on 14/08/2016.
//  Copyright © 2016 Peter Molnar. All rights reserved.
//

#import "PMOCalendarOperatedAbstract.h"

@interface PMOCalendarOperatedAbstract()

@end

@implementation PMOCalendarOperatedAbstract

#pragma mark - Accessors

- (NSCalendar *)calendar {
    if (!_calendar) {
        NSCalendar *calendar = [[NSCalendar alloc]
                                initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        _calendar = calendar;
    }
    return _calendar;
}

- (NSDate *)firstDrawDate {
    if (!_firstDrawDate) {
        _firstDrawDate = [self createDateFromComponentsWithYear:2004 withMonth:1 withDay:7];
    }
    
    return _firstDrawDate;
}

#pragma mark - Helper functions

- (NSString *)adjustNumberFor2Spaces:(NSUInteger)number {
    
    if (number < 10) {
        return [NSString stringWithFormat:@"0%ld", (unsigned long)number];
    } else {
        return [NSString stringWithFormat:@"%ld", (unsigned long)number];
    }
}


- (NSDate *)createDateFromComponentsWithYear:(NSInteger)year withMonth:(NSInteger)month withDay:(NSInteger)day {
    
    // Create a date from components
    
    NSDateComponents *firstDrawDateComponents = [[NSDateComponents alloc]init];
    
    firstDrawDateComponents.year = year;
    firstDrawDateComponents.month = month;
    firstDrawDateComponents.day = day;
    
    firstDrawDateComponents.hour = 13;
    
    
    return  [self.calendar dateFromComponents:firstDrawDateComponents];
}

- (BOOL)isDateHoliday:(NSDate *)date {
    BOOL result = false;
    NSDateComponents *monthAndDay = [self.calendar components:(NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
    //Malta Public holidays
    // 01/01	New Year
    if ([monthAndDay month] == 1 && [monthAndDay day] == 1) {
        result = true;
    }
    // 10/02	Saint Paul´s Shipwreck
    if ([monthAndDay month] == 2 && [monthAndDay day] == 10) {
        result = true;
    }
    //	19/03/2016	Saint Joseph
    if ([monthAndDay month] == 3 && [monthAndDay day] == 19) {
        result = true;
    }
    //    Thursday	31/03/2016	Freedom Day Malta
    if ([monthAndDay month] == 3 && [monthAndDay day] == 31) {
        result = true;
    }
    //    Sunday	01/05/2016	Labour Day
    if ([monthAndDay month] == 5 && [monthAndDay day] == 1) {
        result = true;
    }
    //    Tuesday	07/06/2016	National Holiday Malta
    if ([monthAndDay month] == 6 && [monthAndDay day] == 7) {
        result = true;
    }
    //    Wednesday	29/06/2016	Saint Peter & Saint Paul
    if ([monthAndDay month] == 6 && [monthAndDay day] == 26) {
        result = true;
    }
    //    Monday	15/08/2016	Assumption of Mary
    if ([monthAndDay month] == 8 && [monthAndDay day] == 15) {
        result = true;
    }
    //    Thursday	08/09/2016	Victory Day Malta
    if ([monthAndDay month] == 9 && [monthAndDay day] == 8) {
        result = true;
    }
    //    Wednesday	21/09/2016	Independence Day Malta
    if ([monthAndDay month] == 9 && [monthAndDay day] == 21) {
        result = true;
    }
    //    Thursday	08/12/2016	Immaculate Conception
    if ([monthAndDay month] == 12 && [monthAndDay day] == 8) {
        result = true;
    }
    //    Tuesday	13/12/2016	Republic Day Malta
    if ([monthAndDay month] == 12 && [monthAndDay day] == 13) {
        result = true;
    }
    //    Sunday	25/12/2016	Christmas
    if ([monthAndDay month] == 12 && [monthAndDay day] == 25) {
        result = true;
    }
    
    return result;
}

@end
