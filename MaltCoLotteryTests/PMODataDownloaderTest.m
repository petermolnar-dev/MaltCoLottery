//
//  PMODataDownloaderTest.m
//  Parallels-test
//
//  Created by Peter Molnar on 09/05/2016.
//  Copyright © 2016 Peter Molnar. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "PMOURLDataDownloaderWithBlock.h"

@interface PMODataDownloaderTest : XCTestCase
@property (strong, nonatomic) PMOURLDataDownloaderWithBlock *downloader;
@end

@implementation PMODataDownloaderTest

- (void)setUp {
    [super setUp];
    self.downloader =[[PMOURLDataDownloaderWithBlock alloc] initWithSession:nil];
    
}

-(void)tearDown {
    [super tearDown];
    _downloader = nil;
}


#pragma mark - Tests
- (void)testDownloadCompleted {
    
    
    NSURL *testDownloadURL = [NSURL URLWithString:@"https://upload.wikimedia.org/wikipedia/commons/c/ca/1x1.png"];
    XCTestExpectation *expectation = [self expectationWithDescription:@"Download Successfull"];
    
    void (^callbackTest)(BOOL,NSData *) = ^(BOOL wasDownloadSuccessfull, NSData *data) {
        if (wasDownloadSuccessfull) {
            XCTAssert([data length] > 0);
            [expectation fulfill];
        }
    };
    
    [self.downloader downloadDataFromURL:testDownloadURL completionHandler:callbackTest];
    [self waitForExpectationsWithTimeout:5.0 handler:^(NSError *error) {
        if (error) {
            NSLog(@"Timeout Error: %@", error);
        }
    }];
}

- (void)testDownloadFailure {
    NSURL *testDownloadURL = [NSURL URLWithString:@"http://fdafdsafdsa.ji/web/wwdc/items.json"];
    XCTestExpectation *expectation = [self expectationWithDescription:@"Download Successfull"];
    
    void (^callbackTest)(BOOL,NSData *) = ^(BOOL wasDownloadSuccessfull, NSData *data) {
        XCTAssert(!wasDownloadSuccessfull);
        [expectation fulfill];
        
    };
    
    [self.downloader downloadDataFromURL:testDownloadURL completionHandler:callbackTest];
    [self waitForExpectationsWithTimeout:5.0 handler:^(NSError *error) {
        if (error) {
            NSLog(@"Timeout Error: %@", error);
        }
    }];
}


@end
