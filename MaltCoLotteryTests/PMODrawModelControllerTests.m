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
    // Get the URL and drawID
    self.modelController = [[PMODrawModelController alloc] initWithDrawID:@"20160907" fromURL:[NSURL URLWithString:@"http://www.maltco.com/super/results_draws_sep.php?year=2016&month=9&day=7"]];
}

- (void)tearDown {
    self.modelController = nil;
    [super tearDown];
}

- (void)testDrawID {
    
    XCTAssertTrue([[self.modelController drawID] isEqualToString:@"20160907"]);
    
}

- (void)testDrawDate {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat =@"yyyyMMdd";
    
    NSDate *resultDate = [dateFormatter dateFromString:@"20160907"];
    
    XCTAssertTrue([[self.modelController drawDate] isEqualToDate:resultDate]);
    
}


- (void)testDrawYear {
    XCTAssertTrue([self.modelController drawYear]==2016);
}

- (void)testNumbers {
    NSArray *referenceNumbers =@[ @7, @11, @12,@40,@43];
    __weak __typeof__(self) weakSelf = self;
    XCTestExpectation *expectation = [[XCTestExpectation alloc] init];
    expectation = [self keyValueObservingExpectationForObject:self.modelController
                                                                         keyPath:@"numbers"
                                                                         handler:^BOOL(id  _Nonnull observedObject, NSDictionary * _Nonnull change) {
                                                                             __typeof__(self) strongSelf = weakSelf;
                                                                             NSArray *calculatedArray = strongSelf.modelController.numbers;
                                                                             if (
                                                                                 [calculatedArray isEqualToArray:referenceNumbers]) {
                                                                                  [expectation fulfill];
                                                                                 return true;
                                                                                
                                                                             } else {
                                                                                 return false;
                                                                             }
                                                                         }];
    
    [self waitForExpectationsWithTimeout:5 handler:nil];
}


- (void)testMinNumber {
    __weak __typeof__(self) weakSelf = self;
    XCTestExpectation *expectation = [self keyValueObservingExpectationForObject:self.modelController
                                                                         keyPath:@"numbers"
                                                                         handler:^BOOL(id  _Nonnull observedObject, NSDictionary * _Nonnull change) {
                                                                             __typeof__(self) strongSelf = weakSelf;
                                                                             
                                                                             if ( [strongSelf.modelController minNumber] == 7
                                                                                 ) {
                                                                                  [expectation fulfill];
                                                                                 return true;
                                                                                
                                                                             } else {
                                                                                 return false;
                                                                             }
                                                                         }];
    
    [self waitForExpectationsWithTimeout:5 handler:nil];
    
}


- (void)testMaxNumber {
    __weak __typeof__(self) weakSelf = self;
    XCTestExpectation *expectation = [self keyValueObservingExpectationForObject:self.modelController
                                                                         keyPath:@"numbers"
                                                                         handler:^BOOL(id  _Nonnull observedObject, NSDictionary * _Nonnull change) {
                                                                             __typeof__(self) strongSelf = weakSelf;
                                                                             
                                                                             if ( [strongSelf.modelController maxNumber] == 43
                                                                                 ) {
                                                                                 [expectation fulfill];
                                                                                 return true;
                                                                                 
                                                                             } else {
                                                                                 return false;
                                                                             }
                                                                         }];
    
    [self waitForExpectationsWithTimeout:5 handler:nil];
}




@end
