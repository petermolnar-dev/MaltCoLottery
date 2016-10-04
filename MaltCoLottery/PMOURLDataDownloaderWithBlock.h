//
//  PMODataDownloader.h
//  MaltCoLottery
//
//  Created by Peter Molnar on 26/09/2016.
//  Copyright © 2016 Peter Molnar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PMOURLDataDownloaderWithBlock : NSObject


/**
 Initializer with NSURLSession injection.

 @param session Can be nil, in that case the class genreates a default session with the parameters from PMOURLSessionDefaults.h.

 @return An instance of the downloader
 */
- (nonnull instancetype)initWithSession:(nullable NSURLSession *)session NS_DESIGNATED_INITIALIZER;

/**
 The main method of the class. Downloads the data from the sourceURL and calling back the requestr class via the callback block.

 @param sourceURL The url of the downloadable data in NSURL format
 @param callback  The callback block on the requester. ^(wasSuccessfull, downloadadData)
 */
- (void)downloadDataFromURL:(nonnull NSURL *)sourceURL completion:(void(^_Nonnull)(BOOL wasSuccessfull, NSData * _Nullable downloadedData))callback;

@end
