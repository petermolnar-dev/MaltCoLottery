//
//  PMODrawModelControllerTests.m
//  MaltCoLottery
//
//  Created by Peter Molnar on 07/09/2016.
//  Copyright © 2016 Peter Molnar. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "PMODrawModelController.h"

@interface PMODrawModelControllerTests : XCTestCase
@property (strong, nonatomic) PMODrawModelController *modelController;

@end

@implementation PMODrawModelControllerTests

- (void)setUp {
    [super setUp];
    // Get the URL and drawDate
    NSDate *drawDate = [self createDateFromComponentsWithYear:2016 withMonth:9 withDay:7];
    self.modelController = [[PMODrawModelController alloc] initWithDrawDate:drawDate];
}

- (void)tearDown {
    self.modelController = nil;
    [super tearDown];
}

- (void)testDrawDate {
    
    XCTAssertTrue([[self.modelController drawDate] isEqualToDate:[self createDateFromComponentsWithYear:2016 withMonth:9 withDay:7]]);
    
}

- (void)testDrawDate2 {
    
    NSDate *resultDate = [self createDateFromComponentsWithYear:2016 withMonth:9 withDay:7];

    XCTAssertTrue([[self.modelController drawDate] isEqualToDate:resultDate]);
    
}


- (void)testDrawYear {
    XCTAssertTrue([self.modelController drawYear]==2016);
}

- (void)testNumbers {
    NSArray *referenceNumbers =@[ @7, @11, @12,@40,@43];
    
    XCTestExpectation *expectation = [self expectationWithDescription:@"Downloading and parsing out Numbers"];
    
    void (^processCallBack)(BOOL,  NSArray * _Nullable ) = ^(BOOL wasSuccessfull, NSArray *downloadedNumbers) {
        XCTAssert([downloadedNumbers isEqualToArray:referenceNumbers]);
        [expectation fulfill];

    };
    
    [self.modelController startPopulateDrawNumbersWithCompletionHandler:processCallBack];
    
    [self waitForExpectationsWithTimeout:5.0 handler:^(NSError *error) {
        if (error) {
            NSLog(@"Timeout Error: %@ with expectation: %@", error, expectation.description);
        }
    }];
}


- (void)testMinNumber {
    XCTestExpectation *expectation = [self expectationWithDescription:@"Downloading testing minimum number"];
    
     void (^processCallBack)(BOOL,  NSArray * _Nullable ) = ^(BOOL wasSuccessfull, NSArray *downloadedNumbers) {
        XCTAssert([self.modelController minNumber]==7);
        [expectation fulfill];
        
    };
    
    [self.modelController startPopulateDrawNumbersWithCompletionHandler:processCallBack];
   
    [self waitForExpectationsWithTimeout:5.0 handler:^(NSError *error) {
        if (error) {
            NSLog(@"Timeout Error: %@ with expectation: %@", error, expectation.description);
        }
    }];
}


- (void)testMaxNumber {
    XCTestExpectation *expectation = [self expectationWithDescription:@"Downloading testing maximum number"];
    
    void (^processCallBack)(BOOL,  NSArray * _Nullable ) = ^(BOOL wasSuccessfull, NSArray *downloadedNumbers) {
        XCTAssert([self.modelController maxNumber]==43);
        [expectation fulfill];
        
    };
    
    [self.modelController startPopulateDrawNumbersWithCompletionHandler:processCallBack];
    
    [self waitForExpectationsWithTimeout:5.0 handler:^(NSError *error) {
        if (error) {
            NSLog(@"Timeout Error: %@ with expectation: %@", error, expectation.description);
        }
    }];
    
}

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wnonnull"
/**
 Clang nonnull warning disabled. The test target is to test if the initializer crashes with nonnullable parameter set with nil.
 */
- (void)testNullDrawID {
    XCTAssertThrows([[PMODrawModelController alloc] initWithDrawDate:nil]);
}

#pragma clang diagnostic pop

#pragma mark - Helpers

- (void)testDesignatedInitializer {
    PMODraw *draw = [[PMODraw alloc] initWithDrawDate:[NSDate date]];
    NSArray *referenceNumbers = @[ @8, @13, @19,@20,@33, @97];
    draw.numbers = referenceNumbers;
    PMODrawModelController *controller = [[PMODrawModelController alloc] initWithExisitingDraw:draw];
    XCTAssertNotNil(controller);
    XCTAssertTrue([[controller numbers] isEqualToArray:referenceNumbers]);
}


- (NSDate *)createDateFromComponentsWithYear:(NSInteger)year withMonth:(NSInteger)month withDay:(NSInteger)day {
    
    NSCalendar *calendar = [[NSCalendar alloc]
                            initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    // Create a date from components
    
    NSDateComponents *firstDrawDateComponents = [[NSDateComponents alloc]init];
    
    firstDrawDateComponents.year = year;
    firstDrawDateComponents.month = month;
    firstDrawDateComponents.day = day;
    
    firstDrawDateComponents.hour = 13;
    
    
    return  [calendar dateFromComponents:firstDrawDateComponents];
}

@end
