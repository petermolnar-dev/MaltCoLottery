//
//  PMODrawStorageController.m
//  MaltCoLottery
//
//  Created by Peter Molnar on 29/09/2016.
//  Copyright © 2016 Peter Molnar. All rights reserved.
//

#import "PMODrawStorageController.h"

@interface PMODrawStorageController()
@property (strong, nonatomic, nullable) NSMutableDictionary <NSDate *,PMODrawModelController *> *privateModels;
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
                if ([_privateModels objectForKey:[currModelController drawDate]]) {
                    NSLog(@"There is already a draw with that date");
                } else {
                    [_privateModels setObject:currModelController forKey:currModelController.drawDate];
                }
            }
        } else {
            // NO models passed
            _isAllModelParsed = true;
        }
    }
    
    return self;
    
}

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-designated-initializers"
- (instancetype)init
{
    @throw [NSException exceptionWithName:@"Not designated initializer"
                                   reason:@"Use [[PMODrawStorageController alloc] initWithModelControllers:]"
                                 userInfo:nil];
    return nil;
}
#pragma clang diagnostic pop


#pragma mark - Accessors
- (NSDictionary *)models {
    return _privateModels;
}


- (NSInteger)modelCount {
    return [_privateModels count];
}

#pragma mark - Helpers
- (void)populateDrawsNumbers {
    if (!_isAllModelParsed) {
        [self downloadAndParseDrawNumbers];
    } else {
        [self notifyObservers];
    }
    
}


- (void)downloadAndParseDrawNumbers {
    __weak __typeof__(self) weakSelf = self;
    __block NSInteger modelsNeedsToBeProcessedCount = [self.privateModels count];
    NSArray *allModelKeys = [self.privateModels allKeys];
    
    for (NSDate * currModelControllerID in allModelKeys) {
        PMODrawModelController *currModelController = [self.privateModels objectForKey:currModelControllerID];
        
        if (currModelController && currModelController.drawDate) {
            void (^addModelControllerToStorage)(BOOL,  NSArray * _Nullable ) = ^(BOOL wasSuccessfull, NSArray *downloadedNumbers) {
                __typeof__(self) strongSelf = weakSelf;
                modelsNeedsToBeProcessedCount--;
                NSLog(@"InitialsModelCount = %ld /n", (long)modelsNeedsToBeProcessedCount);
                if (wasSuccessfull && downloadedNumbers) {
                    [strongSelf.privateModels setObject:currModelController forKey:currModelController.drawDate];
                } else {
                    [strongSelf.privateModels removeObjectForKey:currModelController.drawDate];
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
