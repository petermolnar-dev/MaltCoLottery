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
    NSDate *drawDate = [self createDateFromComponentsWithYear:2016 withMonth:9 withDay:7];
    PMODrawModelController *mockModelController =[[PMODrawModelController alloc] initWithDrawDate:drawDate];
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

- (void)testStorageSave {
    NSMutableArray *mockModels = [NSMutableArray array];
    NSDate *drawDate = [self createDateFromComponentsWithYear:2016 withMonth:9 withDay:7];
    PMODrawModelController *mockModelController =[[PMODrawModelController alloc] initWithDrawDate:drawDate];
    [mockModels addObject:mockModelController];

    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:mockModels];
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"drawModels"];
    
    NSData *dataRead = [[NSUserDefaults standardUserDefaults] objectForKey:@"drawModels"];
    
    NSArray *readDraws = [NSKeyedUnarchiver unarchiveObjectWithData:dataRead];
    PMODrawModelController *readController = [readDraws firstObject];
    NSLog(@"The readDraws.drawdte: %@", readController.drawDate);
    
    XCTAssertNotNil(readDraws);
    
}

@end
