//
//  PMODownloadNotifier.h
//  Parallels-test
//
//  Created by Peter Molnar on 09/05/2016.
//  Copyright © 2016 Peter Molnar. All rights reserved.
//

@protocol PMOExecutionNotifier <NSObject>

- (void)notifyObserverWithProcessedData:(id)data;
@optional
- (void)notifyObserverWithError:(NSError *)error;
@end
