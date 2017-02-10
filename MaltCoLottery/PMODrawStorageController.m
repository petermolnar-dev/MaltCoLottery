//
//  PMODrawStorageController.m
//  MaltCoLottery
//
//  Created by Peter Molnar on 29/09/2016.
//  Copyright © 2016 Peter Molnar. All rights reserved.
//

#import "PMODrawStorageController.h"
#import "PMOParsingStateNotifications.h"

@interface PMODrawStorageController()
@property (strong, nonatomic, nullable) NSMutableDictionary <NSDate *,PMODrawModelController *> *privateModels;
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
    __block NSMutableArray *failedDates = [[NSMutableArray alloc] init];
    __block NSInteger failedCount = 0;
    
    NSInteger modelsCount = modelsNeedsToBeProcessedCount;
    NSArray *allModelKeys = [self.privateModels allKeys];
    NSOperationQueue *parsingQueue = [[NSOperationQueue alloc] init];
    
    [parsingQueue addOperationWithBlock:^{
        __typeof__(self) strongSelf = weakSelf;
        for (NSDate * currModelControllerID in allModelKeys) {
            PMODrawModelController *currModelController = [self.privateModels objectForKey:currModelControllerID];
            
            
            if (currModelController && currModelController.drawDate) {
                void (^addModelControllerToStorage)(BOOL,  NSArray * _Nullable ) = ^(BOOL wasSuccessfull, NSArray *downloadedNumbers) {
                    

                    modelsNeedsToBeProcessedCount--;
                    float percentage = (modelsCount*1.0-modelsNeedsToBeProcessedCount*1.0)/modelsCount*1.0;
                    [strongSelf.progressDelegate updateProgressWithPercentage:percentage];
                    if (wasSuccessfull && downloadedNumbers) {
                        [strongSelf.privateModels setObject:currModelController forKey:currModelController.drawDate];
                    } else {
                        [strongSelf.privateModels removeObjectForKey:currModelController.drawDate];
                        NSLog(@"Date: %@: Download wasn't succesfull or the numbers list is empty", currModelController.drawDate);
                        [failedDates addObject:currModelController.drawDate];
                        failedCount++;
                    }
                    if (modelsNeedsToBeProcessedCount == 0) {
                        strongSelf.isAllModelParsed = true;
                        NSLog(@"Failed count: %ld", (long)failedCount);
                        NSLog(@"Failed dates: %@",[failedDates sortedArrayUsingSelector:@selector(compare:)]);
                        [strongSelf notifyObservers];
                    }
                };
                // Give some rest to the server, otherwise our request considered
                // as a hacking activity
                [NSThread sleepForTimeInterval:.1];
                [currModelController startPopulateDrawNumbersWithCompletionHandler:addModelControllerToStorage];
            }
        }
        
    }];
    
}

#pragma mark - Notifications
- (void)notifyObservers {
    NSLog(@"Final drawcount: %ld", (long)[self modelCount]);
    [[NSNotificationCenter defaultCenter] postNotificationName:PMODrawStorageFilledUp
                                                        object:self
                                                      userInfo:nil];
}



@end
