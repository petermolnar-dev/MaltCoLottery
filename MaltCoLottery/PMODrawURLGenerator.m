//
//  PMODrawURLGenerator.m
//  MaltCoLottery
//
//  Created by Peter Molnar on 03/08/2016.
//  Copyright © 2016 Peter Molnar. All rights reserved.
//
// Draw example: http://www.maltco.com/super/results_draws_aug.php?year=2016&month=8&day=3

#import "PMODrawURLGenerator.h"

@implementation PMODrawURLGenerator


- (NSURL *)generateDrawURLFromDate:(NSDate *)drawDate {
    NSDateComponents *monthAndDay = [self.calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:drawDate];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setLocale:[NSLocale currentLocale]];
    [formatter setDateFormat:@"MMM"];
    
    NSString *monthString = [formatter stringFromDate:drawDate];
    NSString *queryString = [@"http://www.maltco.com/super/results_draws_" stringByAppendingFormat:@"%@.php?year=%ld&month=%ld&day=%ld",[monthString lowercaseString],(long)[monthAndDay year],(long)[monthAndDay month],(long)[monthAndDay day]];
    return [NSURL URLWithString:queryString];
}



@end
