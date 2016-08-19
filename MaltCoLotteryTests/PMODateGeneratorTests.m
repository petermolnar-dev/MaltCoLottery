//
//  PMODateGeneratorTests.m
//  MaltCoLottery
//
//  Created by Peter Molnar on 09/08/2016.
//  Copyright © 2016 Peter Molnar. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "PMODrawDateGenerator.h"

@interface PMODateGeneratorTests : XCTestCase
@property (nonatomic, strong) PMODrawDateGenerator *generator;
@end

@implementation PMODateGeneratorTests

- (void)setUp {
    [super setUp];
    self.generator = [[PMODrawDateGenerator alloc] init];
}

- (void)tearDown {
    self.generator = nil;
    [super tearDown];
}

- (void)testNormalRangeOfDates {
    NSDate *fromDate = [self.generator createDateFromComponentsWithYear:2004 withMonth:1 withDay:7];
    NSDate *toDate = [self.generator createDateFromComponentsWithYear:2004 withMonth:2 withDay:7];
    NSArray *generatedDates = [self.generator drawDaysFromDate:fromDate toDate:toDate];
    
    XCTAssertTrue([generatedDates count]==5);
}

- (void)testRangeWithPublicHolidays {
    NSDate *fromDate = [self.generator createDateFromComponentsWithYear:2016 withMonth:2 withDay:5];
    NSDate *toDate = [self.generator createDateFromComponentsWithYear:2016 withMonth:2 withDay:12];
    NSArray *generatedDates = [self.generator drawDaysFromDate:fromDate toDate:toDate];

    XCTAssertTrue([generatedDates count]==3);

}


@end
