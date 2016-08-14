//
//  PMODataDownloadNotifications.h
//  Parallels-test
//
//  Created by Peter Molnar on 18/05/2016.
//  Copyright © 2016 Peter Molnar. All rights reserved.
//

#ifndef PMODataDownloadNotifications_h
#define PMODataDownloadNotifications_h

// String constant for the NSNotificationCenter notification
static NSString *const PMODataDownloaderDidDownloadEnded = @"PMODataDownloaderDidDownloadEnded";
static NSString *const PMODataDownloaderError= @"PMODataDownloaderError";

// Integer constants for the timeout values
static NSUInteger PMODownloaderResourceTimeout = 60;
static NSUInteger PMODownloaderRequestTimeout = 60;


#endif /* PMODataDownloadNotifications_h */
