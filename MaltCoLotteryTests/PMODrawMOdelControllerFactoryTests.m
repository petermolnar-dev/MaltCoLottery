//
//  PMODrawMOdelControllerFactoryTests.m
//  MaltCoLottery
//
//  Created by Peter Molnar on 19/09/2016.
//  Copyright © 2016 Peter Molnar. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "PMODrawModelControllerFactory.h"

@interface PMODrawMOdelControllerFactoryTests : XCTestCase
@property (strong, nonatomic) PMODrawModelControllerFactory *factory;
@end

@implementation PMODrawMOdelControllerFactoryTests

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
    
    PMODrawModelController *controller =  [self.factory createDrawModellController:resultDate];
    
    BOOL controllerIsNotNil = controller;
    BOOL controllerIsValid = [controller.drawID isEqualToString:@"20160907"];
    
    XCTAssertTrue(controllerIsNotNil && controllerIsValid);
}

@end
