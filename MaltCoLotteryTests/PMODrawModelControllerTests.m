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
    
    XCTestExpectation *expectation = [self expectationWithDescription:@"Downloading and parsing out Numbers"];
    
    [self keyValueObservingExpectationForObject:self.modelController
                                        keyPath:@"numbers"
                                        handler:^BOOL(id  _Nonnull observedObject, NSDictionary * _Nonnull change) {
                                            XCTAssert([self.modelController.numbers isEqualToArray:referenceNumbers]);
                                            [expectation fulfill];
                                            return true;
                                        }];
    
    [self.modelController startPopulateDrawNumbers];
    
    [self waitForExpectationsWithTimeout:5.0 handler:^(NSError *error) {
        if (error) {
            NSLog(@"Timeout Error: %@ with expectation: %@", error, expectation.description);
        }
    }];
}


- (void)testMinNumber {
    XCTestExpectation *expectation = [self expectationWithDescription:@"Downloading testing minimum number"];
    
    [self keyValueObservingExpectationForObject:self.modelController
                                        keyPath:@"numbers"
                                        handler:^BOOL(id  _Nonnull observedObject, NSDictionary * _Nonnull change) {
                                            XCTAssert([self.modelController minNumber]==7);
                                            [expectation fulfill];
                                            return true;
                                        }];
    
    [self.modelController startPopulateDrawNumbers];
    
    [self waitForExpectationsWithTimeout:5.0 handler:^(NSError *error) {
        if (error) {
            NSLog(@"Timeout Error: %@ with expectation: %@", error, expectation.description);
        }
    }];
}


- (void)testMaxNumber {
    XCTestExpectation *expectation = [self expectationWithDescription:@"Downloading testing maximum number"];
    
    [self keyValueObservingExpectationForObject:self.modelController
                                        keyPath:@"numbers"
                                        handler:^BOOL(id  _Nonnull observedObject, NSDictionary * _Nonnull change) {
                                            XCTAssert([self.modelController maxNumber]==43);
                                            [expectation fulfill];
                                            return true;
                                        }];
    
    [self.modelController startPopulateDrawNumbers];
    
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
    PMODrawModelController *controller = [[PMODrawModelController alloc] initWithDrawID:nil fromURL:[NSURL URLWithString:@"http://www.maltco.com/super/results_draws_sep.php?year=2016&month=9&day=7"]];
    XCTAssertTrue(![controller drawID]);
}

- (void)testNullDrawURL {
    PMODrawModelController *controller = [[PMODrawModelController alloc] initWithDrawID:@"20160907" fromURL:nil];
    XCTAssertTrue(![controller drawID]);
}
#pragma clang diagnostic pop

@end
