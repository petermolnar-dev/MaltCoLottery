//
//  PMODateGeneratorTests.m
//  MaltCoLottery
//
//  Created by Peter Molnar on 09/08/2016.
//  Copyright © 2016 Peter Molnar. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "PMODrawDateGenerator.h"

@interface PMODateGeneratorTests : XCTestCase
@property (nonatomic, strong) PMODrawDateGenerator *generator;
@end

@implementation PMODateGeneratorTests

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    self.generator = nil;
    [super tearDown];
}



@end
