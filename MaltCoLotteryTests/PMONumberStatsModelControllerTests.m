//
//  PMONumberStatsModelControllerTests.m
//  MaltCoLottery
//
//  Created by Peter Molnar on 12/10/2016.
//  Copyright © 2016 Peter Molnar. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "PMONumberStatsModelController.h"
#import "PMODrawStorageController.h"

@interface PMONumberStatsModelControllerTests : XCTestCase


@end

@implementation PMONumberStatsModelControllerTests


- (void)testNonDesignatedInitializer {

    XCTAssertThrows( [[PMONumberStatsModelController alloc] init]);
}

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wnonnull"
- (void)testDesignatedInitializerNil {
   XCTAssertThrows([[PMONumberStatsModelController alloc] initWithNumberCount:nil arraySizeForStatistics:0]);
}
#pragma clang diagnostic pop

- (void)testDesignatedInitializer {
    PMONumberStatsModelController *statsModelController = [[PMONumberStatsModelController alloc] initWithNumberCount:@45 arraySizeForStatistics:6];
    XCTAssertNotNil(statsModelController);
}


- (void)testUpdatingStatisticsWithoutValidDraw {
    
//    PMODrawModelController *modelController1 = [[PMODrawModelController alloc] initWithDrawDate:drawDate fromURL:[NSURL URLWithString:@"http://www.maltco.com/super/results_draws_sep.php?year=2016&month=9&day=7"]];
    
//    PMODrawStorageController *storageController = [[PMODrawStorageController alloc] initWithModelControllers:(NSArray<PMODrawModelController *> *)];
    
    PMONumberStatsModelController *statsModelController = [[PMONumberStatsModelController alloc] initWithNumberCount:@45 arraySizeForStatistics:4];
//    [statsModelController updateStatisticFromNumberStorage:storageController];
    
}


- (void)testUpdatingStatisticsWithValidDraws {
    
    PMONumberStatsModelController *statsModelController = [[PMONumberStatsModelController alloc] initWithNumberCount:@45 arraySizeForStatistics:5];
    
}

@end
