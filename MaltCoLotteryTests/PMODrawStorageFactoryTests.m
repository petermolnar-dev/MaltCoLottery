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
    PMODrawStorageController *storage = [self.factory buildStorage];
    XCTAssert(storage && [storage isKindOfClass:[PMODrawStorageController class]] );
    
}


- (void)testFactoryBuildsModelControllerWithDates {
    
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
    
    PMODrawStorageController *storage = [self.factory buildStorageFromDate:fromDate toDate:toDate];
    BOOL isModelCount5 = [storage modelCount]==5;
    XCTAssert([storage isKindOfClass:[PMODrawStorageController class]] && isModelCount5);
    
}




@end
