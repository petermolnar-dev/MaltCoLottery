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
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSDateComponents *components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:[NSDate date]];
    [components setDay:-1];
    NSDate *yesterday = [calendar dateByAddingComponents:components toDate:[NSDate date] options:0];

    self.draw = [[PMODraw alloc] initWithDrawDate:yesterday];
    self.draw.numbers = @[@3, @7, @46, @23, @13];
    
}

- (void)tearDown {
    self.draw = nil;
    [super tearDown];
}



- (void)testNumbersNotEmpty {
    XCTAssertNotNil(self.draw.drawDate);
}

- (void)testNumbersNotNil {
    XCTAssertNotNil(self.draw.numbers);
}
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wnonnull"
- (void)testWithEmptyDate {
    XCTAssertThrows([[PMODraw alloc] initWithDrawDate:nil]);
}
#pragma clang diagnostic pop

- (void)testWithDefaultinitializer {
    XCTAssertThrows([[PMODraw alloc] init]);
}
@end
