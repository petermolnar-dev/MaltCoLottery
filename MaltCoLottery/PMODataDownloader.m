//
//  PMODataDownloader.m
//  Parallels-test
//
//  Created by Peter Molnar on 06/05/2016.
//  Copyright © 2016 Peter Molnar. All rights reserved.
//

#import "PMODataDownloader.h"

@interface PMODataDownloader()
- (NSDictionary *)userInforForErrorNotification:(NSError *)error;
@end

@implementation PMODataDownloader



#pragma mark - Main function
- (void)downloadDataFromURL:(NSURL *)sourceURL {
    
    NSURLRequest *request = [NSURLRequest requestWithURL:sourceURL];
    
    NSURLSessionDataTask *downloadTask = [self.session dataTaskWithRequest:request completionHandler:
                                          ^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                                              if (error) {
                                                  [self notifyObserverWithError:error];
                                              } else {
                                                  [self notifyObserverWithProcessedData:data];
                                              }
                                          }];
    [downloadTask resume];
    
}

#pragma mark - Accessors
- (NSURLSession *)session {
    
    // Session can be injected, but if not initialized a default config is provided.
    if (!_session) {
        NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
        [sessionConfiguration setTimeoutIntervalForRequest:PMODownloaderRequestTimeout];
        [sessionConfiguration setTimeoutIntervalForResource:PMODownloaderResourceTimeout];
        _session = [NSURLSession sessionWithConfiguration:sessionConfiguration
                                                 delegate:nil
                                            delegateQueue:nil];
        
    }
    
    return _session;
}

#pragma mark - Notifications
- (void)notifyObserverWithProcessedData:(NSData *)data {
    NSDictionary *userInfo = @{@"data" : data };
    [[NSNotificationCenter defaultCenter] postNotificationName:PMODataDownloaderDidDownloadEnded
                                                        object:self
                                                      userInfo:userInfo];
}

#pragma mark - Customizable for userInfo in case of error
- (NSDictionary *)userInforForErrorNotification:(NSError *)error {
    NSDictionary *userInfo = @{@"error" : error };
    return userInfo;
}

- (void)notifyObserverWithError:(NSError *)error {
    NSDictionary *userInfo = [self userInforForErrorNotification:error];
    [[NSNotificationCenter defaultCenter] postNotificationName:PMODataDownloaderError
                                                        object:self
                                                      userInfo:userInfo];
}
@end
