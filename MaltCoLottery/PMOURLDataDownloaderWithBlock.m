//
//  PMODataDownloader.m
//  MaltCoLottery
//
//  Created by Peter Molnar on 26/09/2016.
//  Copyright © 2016 Peter Molnar. All rights reserved.
//

#import "PMOURLDataDownloaderWithBlock.h"
#import "PMOURLSessionDefaults.h"

@interface PMOURLDataDownloaderWithBlock()

@property (strong, nonatomic, nonnull) NSURLSession *session;

@end

@implementation PMOURLDataDownloaderWithBlock

#pragma mark - Init
- (instancetype)initWithSession:(nullable NSURLSession *)session {
    self = [super init];
    
    if (self) {
        if (session) {
            _session = session;
        } else {
            _session = [self createDefaultSession];
        }
    }
    
    return self;
}

- (instancetype)init {
    self = [self initWithSession:nil];
    return self;
}

#pragma mark - Main method
- (void)downloadDataFromURL:(NSURL *)sourceURL completionHandler:(void (^)(BOOL wasSuccessfull, NSData  *downloadedData))callback {

    NSURLRequest *request = [NSURLRequest requestWithURL:sourceURL];
    
    NSURLSessionDataTask *downloadTask = [self.session dataTaskWithRequest:request completionHandler:
                                          ^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                                              if (!error) {
                                                  callback(YES,data);
                                              } else {
                                                  callback(NO,nil);
                                              }
                                          }];
    [downloadTask resume];
}

#pragma mark - Helpers

- (nonnull NSURLSession *)createDefaultSession {
    NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    [sessionConfiguration setTimeoutIntervalForRequest:PMODownloaderRequestTimeout];
    [sessionConfiguration setTimeoutIntervalForResource:PMODownloaderResourceTimeout];
    
    return [NSURLSession sessionWithConfiguration:sessionConfiguration
                                         delegate:nil
                                    delegateQueue:nil];
    
}

@end
