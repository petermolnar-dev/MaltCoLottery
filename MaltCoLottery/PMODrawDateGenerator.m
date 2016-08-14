//
//  PMODateGenerator.m
//  MaltCoLottery
//
//  Created by Peter Molnar on 20/05/2016.
//  Copyright © 2016 Peter Molnar. All rights reserved.
//

#import "PMODrawDateGenerator.h"

@interface PMODrawDateGenerator()

@property (strong, nonatomic) NSDate *firstDrawDate;
@property (strong, nonatomic) NSCalendar *calendar;

@end

@implementation PMODrawDateGenerator

- (NSDate *)createDateFromComponentsWithYear:(NSInteger)year withMonth:(NSInteger)month withDay:(NSInteger)day {
    
    // Create a date from components
    
    NSDateComponents *firstDrawDateComponents = [[NSDateComponents alloc]init];
    
    firstDrawDateComponents.year = year;
    firstDrawDateComponents.month = month;
    firstDrawDateComponents.day = day;
    
    
    return  [self.calendar dateFromComponents:firstDrawDateComponents];
}

-(instancetype)init {
    self = [super init];
    if (self) {
        
        self.firstDrawDate = [self createDateFromComponentsWithYear:2004 withMonth:1 withDay:7];
    }
    
    return self;
}

- (NSArray *)drawDaysUntilToday {
    
    NSDate *now = [NSDate date];
    NSDate *currentDate = self.firstDrawDate;
    
    return [self drawDaysFromDate:currentDate toDate:now];
    
}

- (NSArray *)drawDaysFromDate:(NSDate *)fromDate toDate:(NSDate *)toDate {
    
    NSMutableArray *resultArray = [[NSMutableArray alloc] init];
    
    while ([toDate compare:fromDate] == NSOrderedDescending) {
        [resultArray addObject:fromDate];
        if ([self isDateHoliday:fromDate]) {
            // Add the the day before and after to the array
            NSTimeInterval secondsPerDay = 24 * 60 * 60;
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

- (BOOL)isDateHoliday:(NSDate *)date {
    BOOL result = false;
    NSDateComponents *monthAndDay = [self.calendar components:(NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
    //Malta Public holidays
    // 01/01	New Year
    if ([monthAndDay day] == 1 && [monthAndDay month] == 1) {
        result = true;
    }
    // 10/02	Saint Paul´s Shipwreck
    if ([monthAndDay day] == 10 && [monthAndDay month] == 2) {
        result = true;
    }
    //	19/03/2016	Saint Joseph
    if ([monthAndDay day] == 19 && [monthAndDay month] == 3) {
        result = true;
    }
    //    Thursday	31/03/2016	Freedom Day Malta
    if ([monthAndDay day] == 31 && [monthAndDay month] == 3) {
        result = true;
    }
    //    Sunday	01/05/2016	Labour Day
    if ([monthAndDay day] == 1 && [monthAndDay month] == 5) {
        result = true;
    }
    //    Tuesday	07/06/2016	National Holiday Malta
    if ([monthAndDay day] == 7 && [monthAndDay month] == 6) {
        result = true;
    }
    //    Wednesday	29/06/2016	Saint Peter & Saint Paul
    if ([monthAndDay day] == 29 && [monthAndDay month] == 6) {
        result = true;
    }
    //    Monday	15/08/2016	Assumption of Mary
    if ([monthAndDay day] == 15 && [monthAndDay month] == 8) {
        result = true;
    }
    //    Thursday	08/09/2016	Victory Day Malta
    if ([monthAndDay day] == 8 && [monthAndDay month] == 9) {
        result = true;
    }
    //    Wednesday	21/09/2016	Independence Day Malta
    if ([monthAndDay day] == 21 && [monthAndDay month] == 9) {
        result = true;
    }
    //    Thursday	08/12/2016	Immaculate Conception
    if ([monthAndDay day] == 8 && [monthAndDay month] == 12) {
        result = true;
    }
    //    Tuesday	13/12/2016	Republic Day Malta
    if ([monthAndDay day] == 13 && [monthAndDay month] == 12) {
        result = true;
    }
    //    Sunday	25/12/2016	Christmas
    if ([monthAndDay day] == 25 && [monthAndDay month] == 12) {
        result = true;
    }
    
    return result;
}

- (NSCalendar *)calendar {
    if (!_calendar) {
        NSCalendar *calendar = [[NSCalendar alloc]
                                initWithCalendarIdentifier:NSCalendarIdentifierGregorian];\
        _calendar = calendar;
    }
    return _calendar;
}



@end
