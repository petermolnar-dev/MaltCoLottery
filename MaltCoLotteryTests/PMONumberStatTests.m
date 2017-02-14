//
//  PMONumberStatsTests.m
//  MaltCoLottery
//
//  Created by Peter Molnar on 12/10/2016.
//  Copyright © 2016 Peter Molnar. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "PMONumberStat.h"


@interface PMONumberStatTests : XCTestCase
@property (strong, nonatomic) PMONumberStat *numberStats;
@end

@implementation PMONumberStatTests

- (void)setUp {
    [super setUp];
    self.numberStats = [PMONumberStat alloc];
}

- (void)tearDown {
    self.numberStats = nil;
    [super tearDown];
}


//Save the diagnostic state
#pragma clang diagnostic push
//Ignore -Wnonnull warnings
#pragma clang diagnostic ignored "-Wnonnull"
- (void)testDesignatedInitilizerWithNil {
    XCTAssertNil([self.numberStats initWithNumber:nil drawDates:nil]);
}
//Restore the diagnostic state
#pragma clang diagnostic pop


- (void)testDesignatedInitilizedOnlyWithNumber {
    NSNumber *theNumber = @5;

    XCTAssertNotNil([self.numberStats initWithNumber:theNumber drawDates:nil]);
    XCTAssert([[self.numberStats number] isEqual:@5]);
}

- (void)testDesignatedInitializerWithDates {
    NSNumber *theNumber = @7;
    
    NSDate *today = [NSDate date];
    NSArray *drawDates = @[today,
                           [today dateByAddingTimeInterval: -86400.0]
                           ];
    XCTAssertNotNil([self.numberStats initWithNumber:theNumber drawDates:drawDates]);
    XCTAssertTrue([[self.numberStats number] isEqual:@7]);
    XCTAssertTrue([[self.numberStats drawDates] count] == 2);
   
}

- (void)testLastDrawDate {
    NSNumber *theNumber = @13;
    
    NSDate *today = [NSDate date];
    NSArray *drawDates = @[today,
                           [today dateByAddingTimeInterval: -86400.0],
                           [today dateByAddingTimeInterval: 86400.0]
                           ];
    XCTAssertNotNil([self.numberStats initWithNumber:theNumber drawDates:drawDates]);
    XCTAssertTrue([[self.numberStats number] isEqual:@13]);
    XCTAssertTrue([[self.numberStats drawDates] count] == 3);
    XCTAssertTrue([[self.numberStats lastDrawDay] isEqualToDate:[today dateByAddingTimeInterval: 86400.0]]);
    
}



@end
