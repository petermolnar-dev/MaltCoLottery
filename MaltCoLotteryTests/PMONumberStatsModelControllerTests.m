//
//  PMONumberStatsModelControllerTests.m
//  MaltCoLottery
//
//  Created by Peter Molnar on 12/10/2016.
//  Copyright © 2016 Peter Molnar. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "PMONumberStatsModelController.h"
#import "PMODrawStorageController.h"

@interface PMONumberStatsModelControllerTests : XCTestCase


@end

@implementation PMONumberStatsModelControllerTests



#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wnonnull"
- (void)testDesignatedInitializerNil {
   XCTAssertThrows([[PMONumberStatsModelController alloc] initWithNumberCount:nil arraySizeForStatistics:0]);
}
#pragma clang diagnostic pop

- (void)testDesignatedInitializer {
    PMONumberStatsModelController *statsModelController = [[PMONumberStatsModelController alloc] initWithNumberCount:@45 arraySizeForStatistics:6];
    XCTAssertNotNil(statsModelController);
}



- (void)testUpdatingStatisticsWithValidDraws {
    
    NSDate *today = [NSDate date];
    
    NSDateComponents *the20040107 = [NSDateComponents new];
    [the20040107 setDay:7];
    [the20040107 setMonth:1];
    [the20040107 setYear:2004];
    NSDate *firstDrawDate = [[NSCalendar currentCalendar] dateFromComponents:the20040107];
    
    NSDateComponents *the20040207 = [NSDateComponents new];
    [the20040207 setDay:7];
    [the20040207 setMonth:2];
    [the20040207 setYear:2004];
    NSDate *monthAfterFirstDrawDate =  [[NSCalendar currentCalendar] dateFromComponents:the20040207];
   
    NSArray *todaysNumbers = @[@40, @41, @42, @43, @44];
    NSArray *firstNumbers = @[@1, @2, @3, @44, @45];
    NSArray *monthafterFirstNumbers = @[@1, @20, @30, @40, @45];
    
    NSArray *leastDrawReference = @[@1, @2, @3, @20, @45];
    
    PMODraw *drawToday = [[PMODraw alloc] initWithDrawDate:today];
    drawToday.numbers = todaysNumbers;
    
    PMODraw *firstDraw = [[PMODraw alloc]initWithDrawDate:firstDrawDate];
    firstDraw.numbers = firstNumbers;
    
    PMODraw *monthAfterFirstDraw = [[PMODraw alloc] initWithDrawDate:monthAfterFirstDrawDate];
    monthAfterFirstDraw.numbers = monthafterFirstNumbers;
    
    PMODrawModelController *modelToday = [[PMODrawModelController alloc] initWithExisitingDraw:drawToday];
    PMODrawModelController *modelFirstDraw = [[PMODrawModelController alloc] initWithExisitingDraw:firstDraw];
    PMODrawModelController *modelMonthAfterFirstDraw = [[PMODrawModelController alloc] initWithExisitingDraw:monthAfterFirstDraw];
    NSArray <PMODrawModelController *> *controllers = @[modelToday, modelFirstDraw, modelMonthAfterFirstDraw];
    
    PMODrawStorageController *storageController = [[PMODrawStorageController alloc] initWithModelControllers:controllers];
    
    PMONumberStatsModelController *statsModelController = [[PMONumberStatsModelController alloc] initWithNumberCount:@45 arraySizeForStatistics:5];
    [statsModelController updateStatisticFromNumberStorage:storageController];

    XCTAssert([[statsModelController lastRecentlyDrawn] isEqualToArray:todaysNumbers]);
    XCTAssert([[statsModelController leastRecentlyDrawn] isEqualToArray:leastDrawReference]);

}


- (void)testStatisticallyHighAndLow {
    
    NSDate *today = [NSDate date];
    
    NSDateComponents *the20040107 = [NSDateComponents new];
    [the20040107 setDay:7];
    [the20040107 setMonth:1];
    [the20040107 setYear:2004];
    NSDate *firstDrawDate = [[NSCalendar currentCalendar] dateFromComponents:the20040107];
    
    NSDateComponents *the20040207 = [NSDateComponents new];
    [the20040207 setDay:7];
    [the20040207 setMonth:2];
    [the20040207 setYear:2004];
    NSDate *monthAfterFirstDrawDate =  [[NSCalendar currentCalendar] dateFromComponents:the20040207];
    
    NSArray *todaysNumbers = @[@40, @41, @42, @43, @45];
    NSArray *firstNumbers = @[@1, @20, @30, @42, @45];
    NSArray *monthafterFirstNumbers = @[@41, @20, @30, @40, @45, @43];
    
    
    PMODraw *drawToday = [[PMODraw alloc] initWithDrawDate:today];
    drawToday.numbers = todaysNumbers;
    
    PMODraw *firstDraw = [[PMODraw alloc]initWithDrawDate:firstDrawDate];
    firstDraw.numbers = firstNumbers;
    
    PMODraw *monthAfterFirstDraw = [[PMODraw alloc] initWithDrawDate:monthAfterFirstDrawDate];
    monthAfterFirstDraw.numbers = monthafterFirstNumbers;
    
    PMODrawModelController *modelToday = [[PMODrawModelController alloc] initWithExisitingDraw:drawToday];
    PMODrawModelController *modelFirstDraw = [[PMODrawModelController alloc] initWithExisitingDraw:firstDraw];
    PMODrawModelController *modelMonthAfterFirstDraw = [[PMODrawModelController alloc] initWithExisitingDraw:monthAfterFirstDraw];
    NSArray <PMODrawModelController *> *controllers = @[modelToday, modelFirstDraw, modelMonthAfterFirstDraw];
    
    PMODrawStorageController *storageController = [[PMODrawStorageController alloc] initWithModelControllers:controllers];
    
    PMONumberStatsModelController *statsModelController = [[PMONumberStatsModelController alloc] initWithNumberCount:@45 arraySizeForStatistics:1];
    [statsModelController updateStatisticFromNumberStorage:storageController];
    XCTAssert([[statsModelController statisticalyHigh] isEqualToArray:@[@45]]);
    XCTAssert([[statsModelController statisticalyLow] isEqualToArray:@[@1]]);
    
}

- (void)testStatisticallyHighAndLowForThisYear {
    
    NSDate *today = [NSDate date];
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitYear fromDate:today];
    NSInteger year = [components year];
    NSDateComponents *the20040107 = [NSDateComponents new];
    [the20040107 setDay:7];
    [the20040107 setMonth:1];
    [the20040107 setYear:2004];
    NSDate *firstDrawDate = [[NSCalendar currentCalendar] dateFromComponents:the20040107];
    
    NSDateComponents *the20040207 = [NSDateComponents new];
    [the20040207 setDay:7];
    [the20040207 setMonth:2];
    [the20040207 setYear:year];
    NSDate *sameYearDrawDate =  [[NSCalendar currentCalendar] dateFromComponents:the20040207];
    
    NSArray *highInThisYear = @[@40, @41, @43];
    NSArray *lowOnThisYear = @[@20, @30, @42];
    
    NSArray *firstNumbers = @[@1, @20, @30, @42, @40, @44];
 
    NSArray *sameYearNumbers = @[ @20, @30, @40, @41, @43];
    NSArray *todaysNumbers = @[@40, @41, @42, @43];
    
    
    PMODraw *drawToday = [[PMODraw alloc] initWithDrawDate:today];
    drawToday.numbers = todaysNumbers;
    
    PMODraw *firstDraw = [[PMODraw alloc]initWithDrawDate:firstDrawDate];
    firstDraw.numbers = firstNumbers;
    
    PMODraw *monthAfterFirstDraw = [[PMODraw alloc] initWithDrawDate:sameYearDrawDate];
    monthAfterFirstDraw.numbers = sameYearNumbers;
    
    PMODrawModelController *modelToday = [[PMODrawModelController alloc] initWithExisitingDraw:drawToday];
    PMODrawModelController *modelFirstDraw = [[PMODrawModelController alloc] initWithExisitingDraw:firstDraw];
    PMODrawModelController *modelMonthAfterFirstDraw = [[PMODrawModelController alloc] initWithExisitingDraw:monthAfterFirstDraw];
    NSArray <PMODrawModelController *> *controllers = @[modelToday, modelFirstDraw, modelMonthAfterFirstDraw];
    
    PMODrawStorageController *storageController = [[PMODrawStorageController alloc] initWithModelControllers:controllers];
    
    PMONumberStatsModelController *statsModelController = [[PMONumberStatsModelController alloc] initWithNumberCount:@45 arraySizeForStatistics:3];
    [statsModelController updateStatisticFromNumberStorage:storageController];
    NSLog(@"%@",[statsModelController statisticalyHighInThisYear]);
    XCTAssert([[statsModelController statisticalyHighInThisYear] isEqualToArray:highInThisYear]);
    XCTAssert([[statsModelController statisticalyLowInThisYear] isEqualToArray:lowOnThisYear]);

    
}


- (void)testMinimumAndMaximumDrawCount {
    
    NSDate *today = [NSDate date];
    
    NSDateComponents *the20040107 = [NSDateComponents new];
    [the20040107 setDay:7];
    [the20040107 setMonth:1];
    [the20040107 setYear:2004];
    NSDate *firstDrawDate = [[NSCalendar currentCalendar] dateFromComponents:the20040107];
    
    NSDateComponents *the20040207 = [NSDateComponents new];
    [the20040207 setDay:7];
    [the20040207 setMonth:2];
    [the20040207 setYear:2004];
    NSDate *monthAfterFirstDrawDate =  [[NSCalendar currentCalendar] dateFromComponents:the20040207];
    
    NSArray *todaysNumbers = @[@40, @41, @42, @43, @44];
    NSArray *firstNumbers = @[@1, @20, @30, @42, @45];
    NSArray *monthafterFirstNumbers = @[@41, @20, @30, @40, @43, @44];
    
    
    PMODraw *drawToday = [[PMODraw alloc] initWithDrawDate:today];
    drawToday.numbers = todaysNumbers;
    
    PMODraw *firstDraw = [[PMODraw alloc]initWithDrawDate:firstDrawDate];
    firstDraw.numbers = firstNumbers;
    
    PMODraw *monthAfterFirstDraw = [[PMODraw alloc] initWithDrawDate:monthAfterFirstDrawDate];
    monthAfterFirstDraw.numbers = monthafterFirstNumbers;
    
    PMODrawModelController *modelToday = [[PMODrawModelController alloc] initWithExisitingDraw:drawToday];
    PMODrawModelController *modelFirstDraw = [[PMODrawModelController alloc] initWithExisitingDraw:firstDraw];
    PMODrawModelController *modelMonthAfterFirstDraw = [[PMODrawModelController alloc] initWithExisitingDraw:monthAfterFirstDraw];
    NSArray <PMODrawModelController *> *controllers = @[modelToday, modelFirstDraw, modelMonthAfterFirstDraw];
    
    PMODrawStorageController *storageController = [[PMODrawStorageController alloc] initWithModelControllers:controllers];
    
    PMONumberStatsModelController *statsModelController = [[PMONumberStatsModelController alloc] initWithNumberCount:@45 arraySizeForStatistics:1];
    [statsModelController updateStatisticFromNumberStorage:storageController];

    XCTAssert([[statsModelController minValueFromDate:monthAfterFirstDrawDate toDate:[NSDate date]] isEqual:@20]);
    XCTAssert([[statsModelController maxValueFromDate:monthAfterFirstDrawDate toDate:[NSDate date]] isEqual:@44]);
    
    
}


- (void)testDrawCountByNumber {
    
    NSDate *today = [NSDate date];
    
    NSDateComponents *the20040107 = [NSDateComponents new];
    [the20040107 setDay:7];
    [the20040107 setMonth:1];
    [the20040107 setYear:2004];
    NSDate *firstDrawDate = [[NSCalendar currentCalendar] dateFromComponents:the20040107];
    
    NSDateComponents *the20040207 = [NSDateComponents new];
    [the20040207 setDay:7];
    [the20040207 setMonth:2];
    [the20040207 setYear:2004];
    NSDate *monthAfterFirstDrawDate =  [[NSCalendar currentCalendar] dateFromComponents:the20040207];
    
    NSArray *todaysNumbers = @[@40, @41, @42, @43, @44];
    NSArray *firstNumbers = @[@1, @20, @30, @43, @45];
    NSArray *monthafterFirstNumbers = @[@41, @20, @30, @40, @43, @44];
    
    
    PMODraw *drawToday = [[PMODraw alloc] initWithDrawDate:today];
    drawToday.numbers = todaysNumbers;
    
    PMODraw *firstDraw = [[PMODraw alloc]initWithDrawDate:firstDrawDate];
    firstDraw.numbers = firstNumbers;
    
    PMODraw *monthAfterFirstDraw = [[PMODraw alloc] initWithDrawDate:monthAfterFirstDrawDate];
    monthAfterFirstDraw.numbers = monthafterFirstNumbers;
    
    PMODrawModelController *modelToday = [[PMODrawModelController alloc] initWithExisitingDraw:drawToday];
    PMODrawModelController *modelFirstDraw = [[PMODrawModelController alloc] initWithExisitingDraw:firstDraw];
    PMODrawModelController *modelMonthAfterFirstDraw = [[PMODrawModelController alloc] initWithExisitingDraw:monthAfterFirstDraw];
    NSArray <PMODrawModelController *> *controllers = @[modelToday, modelFirstDraw, modelMonthAfterFirstDraw];
    
    PMODrawStorageController *storageController = [[PMODrawStorageController alloc] initWithModelControllers:controllers];
    
    PMONumberStatsModelController *statsModelController = [[PMONumberStatsModelController alloc] initWithNumberCount:@45 arraySizeForStatistics:1];
    [statsModelController updateStatisticFromNumberStorage:storageController];
    
    XCTAssert([statsModelController drawCountAllTimesForNumber:@44]==2);
    XCTAssert([statsModelController drawCountAllTimesForNumber:@2]==0);
    XCTAssert([statsModelController drawCountAllTimesForNumber:@43]==3);
    
}



@end
