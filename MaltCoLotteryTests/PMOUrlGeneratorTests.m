//
//  PMOUrlGeneratorTests.m
//  MaltCoLottery
//
//  Created by Peter Molnar on 07/08/2016.
//  Copyright © 2016 Peter Molnar. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "PMODrawURLGenerator.h"

@interface PMOUrlGeneratorTests : XCTestCase
@property (strong,  nonatomic) PMODrawURLGenerator *generator;
@end

@implementation PMOUrlGeneratorTests


- (void)setUp {
    [super setUp];
    self.generator =[[PMODrawURLGenerator alloc] init];
}

- (void)tearDown {
    self.generator = nil;
    [super tearDown];
}

- (void)testURLGeneration {
    
    NSDate *testDate = [self.generator createDateFromComponentsWithYear:2004 withMonth:1 withDay:7];
    
    NSString *referenceURLAsString =@"http://www.maltco.com/super/results_draws_jan.php?year=2004&month=1&day=7";
    
    NSURL *resultURL = [self.generator generateDrawURLFromDate:testDate];
    
    NSString *resultURLAsString = [resultURL absoluteString];
    
    BOOL isEqual = [resultURLAsString isEqualToString:referenceURLAsString];
    
    XCTAssertTrue(isEqual);
    
}


@end
