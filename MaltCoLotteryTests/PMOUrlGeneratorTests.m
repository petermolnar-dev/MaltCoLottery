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


@end
