//
//  PMODrawStorageController.m
//  MaltCoLottery
//
//  Created by Peter Molnar on 29/09/2016.
//  Copyright © 2016 Peter Molnar. All rights reserved.
//

#import "PMODrawStorageController.h"

@interface PMODrawStorageController()
@property (strong, nonatomic, nullable) NSMutableDictionary <NSString *,PMODrawModelController *> *privateModels;
@property (unsafe_unretained, nonatomic) NSInteger failedCount;

@end

@implementation PMODrawStorageController


#pragma mark - Initializer
- (instancetype)initWithModelControllers:(nullable NSArray <PMODrawModelController *>*) models {
    self = [super init];
    
    if (self) {
        _isAllModelParsed = false;
        _privateModels = [[NSMutableDictionary alloc] init];

        if (models) {
            for (PMODrawModelController * currModelController in models) {
                [_privateModels setObject:currModelController forKey:currModelController.drawID];
            }
        } else {
            // NO models passed
            _isAllModelParsed = true;
            [self notifyObservers];
        }
    }
    
    return self;
    
}


#pragma mark - Accessors
- (NSDictionary *)models {
    return _privateModels;
}


- (NSInteger)modelCount {
    return [_privateModels count];
}

#pragma mark - Helpers
- (void)populateDrawsNumbers {
    __weak __typeof__(self) weakSelf = self;
    __block NSInteger modelsNeedsToBeProcessedCount = [self.privateModels count];
    NSArray *allModelKeys = [self.privateModels allKeys];
    
    for (NSString * currModelControllerID in allModelKeys) {
        PMODrawModelController *currModelController = [self.privateModels objectForKey:currModelControllerID];
        
        if (currModelController && currModelController.drawID) {
            void (^addModelControllerToStorage)(BOOL,  NSArray * _Nullable ) = ^(BOOL wasSuccessfull, NSArray *downloadedNumbers) {
                __typeof__(self) strongSelf = weakSelf;
                modelsNeedsToBeProcessedCount--;
                NSLog(@"InitialsModelCount = %ld /n", (long)modelsNeedsToBeProcessedCount);
                if (wasSuccessfull && downloadedNumbers) {
                    [strongSelf.privateModels setObject:currModelController forKey:currModelController.drawID];
                } else {
                    [strongSelf.privateModels removeObjectForKey:currModelController.drawID];
                    NSLog(@"Download wasn't succesfull or the numbers list is empty");
                    strongSelf.failedCount++;
                }
                if (modelsNeedsToBeProcessedCount == 0) {
                    strongSelf.isAllModelParsed = true;
                    NSLog(@"Failed count: %ld", strongSelf.failedCount);
                    [strongSelf notifyObservers];
                }
            };
            usleep(50000);
            [currModelController startPopulateDrawNumbersWithCompletionHandler:addModelControllerToStorage];
        }
    }
    
}

#pragma mark - Notifications
- (void)notifyObservers {
    NSLog(@"Final drawcount: %ld", (long)[self modelCount]);
    [[NSNotificationCenter defaultCenter] postNotificationName:PMODrawStorageFilledUp
                                                        object:self
                                                      userInfo:nil];
}

@end
