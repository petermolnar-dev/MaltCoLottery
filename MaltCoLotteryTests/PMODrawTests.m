//
//  PMODrawTests.m
//  MaltCoLottery
//
//  Created by Peter Molnar on 12/08/2016.
//  Copyright © 2016 Peter Molnar. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "PMODraw.h"


@interface PMODrawTests : XCTestCase
@property (strong, nonatomic) PMODraw *draw;
@end

@implementation PMODrawTests

- (void)setUp {
    [super setUp];
    self.draw = [[PMODraw alloc] init];
    self.draw.drawID = @"20160812";
    self.draw.numbers = @[@3, @7, @46, @23, @13];
    
}

- (void)tearDown {
    self.draw = nil;
    [super tearDown];
}

- (void)testDrawMinNumber {
    XCTAssertTrue([[self.draw minNumber] intValue]==3);
}

- (void)testDrawMaxNumber {
    XCTAssertTrue([[self.draw maxNumber] intValue]==46);
}

- (void)testNumbersNotEmpty {
    XCTAssertNotNil(self.draw.drawID);
}

- (void)testNumbersNotNil {
    XCTAssertNotNil(self.draw.numbers);
}

@end
