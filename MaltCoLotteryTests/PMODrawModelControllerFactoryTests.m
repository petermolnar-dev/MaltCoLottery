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

@end

@implementation PMODrawModelControllerFactoryTests

- (void)testControllerCreation {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat =@"yyyyMMdd";
    
    NSDate *resultDate = [dateFormatter dateFromString:@"20160907"];
    
    PMODrawModelController *controller =  [PMODrawModelControllerFactory buildDrawModellControllerFromDrawDate:resultDate];
    
    XCTAssert(controller);
    XCTAssert([controller.drawDate isEqualToDate:resultDate]);
}


- (void)testControllerCreationFromDraw {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat =@"yyyyMMdd";
    NSArray *referenceNumbers = @[@3, @5, @90];
    NSDate *resultDate = [dateFormatter dateFromString:@"20160907"];
    
    PMODraw *draw =[[PMODraw alloc] initWithDrawDate:[dateFormatter dateFromString:@"20160907"]];
    draw.numbers = @[@3, @5, @90];
    
    PMODrawModelController *controller =  [PMODrawModelControllerFactory buildDrawModelControllerFromExistingDraw:draw];
    
    XCTAssert(controller);
    XCTAssert([controller.drawDate isEqualToDate:resultDate]);
    XCTAssert([[controller numbers] isEqualToArray:referenceNumbers]);
}
//Save the diagnostic state
#pragma clang diagnostic push
//Ignore -Wnonnull warnings
#pragma clang diagnostic ignored "-Wnonnull"
- (void)testWithDateNullParameter {
    XCTAssertThrows([PMODrawModelControllerFactory buildDrawModellControllerFromDrawDate:nil]);
}

//Restore the diagnostic state
#pragma clang diagnostic pop

@end
