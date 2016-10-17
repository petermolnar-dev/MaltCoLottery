//
//  PMONumberStatsModelController.h
//  MaltCoLottery
//
//  Created by Peter Molnar on 12/10/2016.
//  Copyright © 2016 Peter Molnar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PMODrawStorageProtocol.h"

/**
 Modelcontroller serving the statistical data from the draws
 */
@interface PMONumberStatsModelController : NSObject


/**
  Designated initializer with the count of numbers in the game (like 45 or 90)

 @param numbersInGame the number's in the game
 @param arraySize     The count of how many numbers would be given back for the statistics

 @return can be nil or an instance of PMONumberStatsModelController
 */
- (nullable instancetype)initWithNumberCount:(nonnull NSNumber *)numbersInGame arraySizeForStatistics:(NSInteger)arraySize NS_DESIGNATED_INITIALIZER;


/**
 Update (erase and recreate) the statistics from the storage.

 @param storage Storage, which conforms the PMODrawStorageProtocol
 */
- (void)updateStatisticFromNumberStorage:(nonnull id<PMODrawStorageProtocol>)storage;


/**
 Get the last recantly drawn numbers. If the arraysize is 5, then you will get the numbers of the last draw.

 @return An array of maximum count of arraySize
 */
- (nullable NSArray *)lastRecentlyDrawn;
- (nullable NSArray *)leastRecentlyDrawn;

- (nullable NSArray *)statisticalyLowInThisYear;
- (nullable NSArray *)statisticalyHighInThisYear;
- (nullable NSArray *)statisticalyLow;
- (nullable NSArray *)statisticalyHigh;

- (nullable NSNumber *)minValueFromDate:(nonnull NSDate *)fromDate toDate:(nonnull NSDate *)toDate;
- (nullable NSNumber *)maxValueFromDate:(nonnull NSDate *)fromDate toDate:(nonnull NSDate *)toDate;
- (NSInteger)drawCountForThisYear:(nonnull NSNumber *)number;
- (NSInteger)drawCountAllTimesForNumber:(nonnull NSNumber *)number;

@end
