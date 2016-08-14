//
//  PMODrawURLGenerator.m
//  MaltCoLottery
//
//  Created by Peter Molnar on 03/08/2016.
//  Copyright © 2016 Peter Molnar. All rights reserved.
//
// Draw example: http://www.maltco.com/super/results_draws_aug.php?year=2016&month=8&day=3
#import "PMODrawURLGenerator.h"
#import "PMODrawDateGenerator.h"

@interface PMODrawURLGenerator()

@property (strong, nonatomic) NSCalendar *calendar;


@end

@implementation PMODrawURLGenerator

- (NSDictionary *)drawURLs {
    NSMutableDictionary *URLcontainer = [[NSMutableDictionary alloc] init];
    
    for (NSDate *currDate in self.drawDates) {
        NSURL *currURL = [self generateDrawURLFromDate:currDate];
        [URLcontainer setObject:currURL forKey:[self generateDrawIDFromDate:currDate]];
    }
    return URLcontainer;
    
    
}

- (NSURL *)generateDrawURLFromDate:(NSDate *)drawDate {
    NSDateComponents *monthAndDay = [self.calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:drawDate];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setLocale:[NSLocale currentLocale]];
    [formatter setDateFormat:@"MMM"];
    
    NSString *monthString = [formatter stringFromDate:drawDate];
    NSString *queryString = [@"http://www.maltco.com/super/results_draws_" stringByAppendingFormat:@"%@.php?year=%ld&month=%ld&day=%ld",[monthString lowercaseString],(long)[monthAndDay year],(long)[monthAndDay month],(long)[monthAndDay day]];
    return [NSURL URLWithString:queryString];
}

- (NSString *)generateDrawIDFromDate:(NSDate *)drawDate {
    NSDateComponents *monthAndDay = [self.calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:drawDate];
    return [NSString stringWithFormat:@"%@%@%@",[self adjustNumberFor2Spaces:[monthAndDay year]],[self adjustNumberFor2Spaces:[monthAndDay month]],[self adjustNumberFor2Spaces:[monthAndDay day]]];
}

- (NSString *)adjustNumberFor2Spaces:(NSUInteger)number {
    
    if (number < 10) {
        return [NSString stringWithFormat:@"0%ld", (unsigned long)number];
    } else {
        return [NSString stringWithFormat:@"%ld", (unsigned long)number];
    }
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
