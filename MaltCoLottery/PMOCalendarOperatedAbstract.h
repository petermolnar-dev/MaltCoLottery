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

@property (nonatomic, strong, nonnull) NSDate *firstDrawDate;
@property (strong, nonatomic, nonnull) NSCalendar *calendar;

- (nonnull NSString *)adjustNumberFor2Spaces:(NSUInteger)number;
- (nonnull NSDate *)createDateFromComponentsWithYear:(NSInteger)year withMonth:(NSInteger)month withDay:(NSInteger)day;
- (BOOL)isDateHoliday:(nonnull NSDate *)date;

@end
