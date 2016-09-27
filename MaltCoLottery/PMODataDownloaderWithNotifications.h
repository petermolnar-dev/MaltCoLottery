//
//  PMODataDownloader.h
//  Parallels-test
//
//  Created by Peter Molnar on 06/05/2016.
//  Copyright © 2016 Peter Molnar. All rights reserved.
//

@import UIKit;

#import "PMOExecutionNotifier.h"
#import "PMODataDownloadNotifications.h"

@interface PMODataDownloaderWithNotifications : NSObject <PMOExecutionNotifier>

@property (strong, nonatomic) NSURLSession *session;
- (instancetype)initWithDrawID:(NSString *)drawID NS_DESIGNATED_INITIALIZER;
- (void)downloadDataFromURL:(NSURL *)sourceURL;

@end
