//
//  PMODrawStorageFactoryTests.m
//  MaltCoLottery
//
//  Created by Peter Molnar on 29/09/2016.
//  Copyright © 2016 Peter Molnar. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "PMODrawStorageFactory.h"
#import "PMODrawStorageController.h"

@interface PMODrawStorageFactoryTests : XCTestCase
@property (strong, nonatomic) PMODrawStorageFactory *factory;
@end

@implementation PMODrawStorageFactoryTests

- (void)setUp {
    [super setUp];
    self.factory = [[PMODrawStorageFactory alloc] init];
}

- (void)tearDown {
    self.factory = nil;
    [super tearDown];
}

- (void)testFactoryBuildsModelController {
    PMODrawStorageController *storage = [self.factory buildStorageWithExistingModelControllers:nil];
    XCTAssert(storage && [storage isKindOfClass:[PMODrawStorageController class]] );
    
}


- (void)testFactoryBuildsModelControllerWithDates {
    
    XCTestExpectation *expectation = [self expectationWithDescription:@"Downloading and building up the storage"];
    
    NSDateComponents *the20040107 = [NSDateComponents new];
    [the20040107 setDay:7];
    [the20040107 setMonth:1];
    [the20040107 setYear:2004];
    NSDate *fromDate = [[NSCalendar currentCalendar] dateFromComponents:the20040107];
    
    NSDateComponents *the20040207 = [NSDateComponents new];
    [the20040207 setDay:7];
    [the20040207 setMonth:2];
    [the20040207 setYear:2004];
    NSDate *toDate =  [[NSCalendar currentCalendar] dateFromComponents:the20040207];
    
    [self expectationForNotification:PMODrawStorageFilledUp
                              object:nil
                             handler:^BOOL(NSNotification * _Nonnull notification) {
                                 
                                 XCTAssert([notification.object modelCount]==5);
                                 XCTAssert([notification.object isKindOfClass:[PMODrawStorageController class]]);
                                 [expectation fulfill];
                                 return true;
                             }];
    
    
    PMODrawStorageController *storage = [self.factory buildStorageFromDate:fromDate toDate:toDate withExistingModelControllers:nil];
    [storage populateDrawsNumbers];
    
    NSLog(@"Storage created: %@", storage);
    
    [self waitForExpectationsWithTimeout:5.0 handler:^(NSError *error) {
        if (error) {
            NSLog(@"Timeout Error: %@ with expectation: %@", error, expectation.description);
        }
    }];
    
    
}




@end
