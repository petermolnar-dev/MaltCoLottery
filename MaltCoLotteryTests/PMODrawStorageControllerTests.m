//
//  PMOStorgeModelControllerTests.m
//  MaltCoLottery
//
//  Created by Peter Molnar on 07/10/2016.
//  Copyright © 2016 Peter Molnar. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "PMODrawStorageController.h"

@interface PMODrawStorageControllerTests : XCTestCase
@property (strong, nonatomic) PMODrawStorageController *storageController;
@end

@implementation PMODrawStorageControllerTests

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    self.storageController = nil;
    [super tearDown];
}

- (void)testCreationWithNulls {
    self.storageController =[[PMODrawStorageController alloc] initWithModelControllers:nil];
    
    XCTAssert(self.storageController);
    XCTAssertTrue([self.storageController modelCount]==0);
    XCTAssertNotNil([self.storageController models]);
}

- (void)testCreationWithOneModel {
    XCTestExpectation *expectation = [self expectationWithDescription:@"Downloading and presenting numbers"];
    NSMutableArray *mockModels = [NSMutableArray array];
    PMODrawModelController *mockModelController =[[PMODrawModelController alloc] initWithDrawID:@"20160907" fromURL:[NSURL URLWithString:@"http://www.maltco.com/super/results_draws_sep.php?year=2016&month=9&day=7"]];
    [mockModels addObject:mockModelController];
    
    [self expectationForNotification:PMODrawStorageFilledUp
                              object:nil
                             handler:^BOOL(NSNotification * _Nonnull notification) {
                                 XCTAssert([self.storageController modelCount]==1);
                                 [expectation fulfill];
                                 return true;
                             }];
    
    self.storageController = [[PMODrawStorageController alloc] initWithModelControllers:mockModels];
    [self.storageController populateDrawsNumbers];
    
    [self waitForExpectationsWithTimeout:5.0 handler:^(NSError *error) {
        if (error) {
            NSLog(@"Timeout Error: %@ with expectation: %@", error, expectation.description);
        }
    }];
    
}


@end
