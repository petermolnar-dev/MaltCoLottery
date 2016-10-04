//
//  PMODrawMOdelControllerFactoryTests.m
//  MaltCoLottery
//
//  Created by Peter Molnar on 19/09/2016.
//  Copyright © 2016 Peter Molnar. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "PMODrawModelControllerFactory.h"

@interface PMODrawModelControllerFactoryTests : XCTestCase
@property (strong, nonatomic) PMODrawModelControllerFactory *factory;
@end

@implementation PMODrawModelControllerFactoryTests

- (void)setUp {
    [super setUp];
    self.factory = [[PMODrawModelControllerFactory alloc] init];
}

- (void)tearDown {
    self.factory = nil;
    [super tearDown];
}

- (void)testControllerCreation {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat =@"yyyyMMdd";
    
    NSDate *resultDate = [dateFormatter dateFromString:@"20160907"];
    
    PMODrawModelController *controller =  [self.factory buildDrawModellControllerFromDrawDate:resultDate];
    
    BOOL controllerIsNotNil = controller;
    BOOL controllerIsValid = [controller.drawID isEqualToString:@"20160907"];
    
    XCTAssertTrue(controllerIsNotNil && controllerIsValid);
}

//Save the diagnostic state
#pragma clang diagnostic push
//Ignore -Wnonnull warnings
#pragma clang diagnostic ignored "-Wnonnull"
- (void)testWithNullParameter {
    XCTAssertThrows([self.factory buildDrawModellControllerFromDrawDate:nil]);
}
//Restore the diagnostic state
#pragma clang diagnostic pop

@end
