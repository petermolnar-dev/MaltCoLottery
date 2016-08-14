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

@interface PMODataDownloader : UIViewController <PMOExecutionNotifier>

@property (strong, nonatomic) NSURLSession *session;

- (void)downloadDataFromURL:(NSURL *)sourceURL;

@end
