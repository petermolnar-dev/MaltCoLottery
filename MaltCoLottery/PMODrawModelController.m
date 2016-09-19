//
//  PMODrawModelController.m
//  MaltCoLottery
//
//  Created by Peter Molnar on 08/08/2016.
//  Copyright © 2016 Peter Molnar. All rights reserved.
//

#import "PMODrawModelController.h"
#import "PMODataDownloader.h"
#import "PMOHTMLParser.h"

@interface PMODrawModelController()

@property (strong, nonatomic) PMODraw *draw;

@end

@implementation PMODrawModelController

- (instancetype)initWithDrawID:(NSString *)drawID fromURL:(NSURL *)drawURL {
    self = [super init];
    
    if (self && drawID && drawURL) {
        self.draw.drawID = drawID;
        
        [self startPopulateDrawFromURL:drawURL];
    }
    
    return self;
}


#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-designated-initializers"
- (instancetype)init
{
    @throw [NSException exceptionWithName:@"Not designated initializer"
                                   reason:@"Use [[PMODrawModelController alloc] initWithFyberOptions:]"
                                 userInfo:nil];
    return nil;
}

#pragma mark - Accessors

- (PMODraw *)draw {
    if (!_draw) {
        _draw = [[PMODraw alloc] init];
    }
    
    return _draw;
}

- (NSString *)drawID {
    return self.draw.drawID;
}

- (NSDate *)drawDate {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat =@"yyyyMMdd";
    
    NSDate *resultDate = [dateFormatter dateFromString:self.draw.drawID];
    
    return resultDate;
}

- (NSInteger)drawYear {
    return [[self.draw.drawID substringToIndex:4] integerValue];
}

- (NSArray *)numbers {
    return [self sortedNumbers];
}

#pragma mark - Public API
- (NSInteger)minNumber {
    return [[[self sortedNumbers] firstObject] integerValue];
}

- (NSInteger)maxNumber {
    return [[[self sortedNumbers] lastObject] integerValue];
}

#pragma mark - Helpers
- (NSArray *)sortedNumbers {
    NSArray *sortedNumbers = [self.draw.numbers sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        if ([(NSNumber *)obj1 integerValue] < [(NSNumber *)obj2 integerValue] ) {
            return NSOrderedAscending;
        } else if ([(NSNumber *)obj2 integerValue] < [(NSNumber *)obj1 integerValue] ) {
            return NSOrderedDescending;
        } else {
            return NSOrderedSame;
        }
    }];
    
    return sortedNumbers;
}

- (void)startPopulateDrawFromURL:(NSURL *)drawURL {
    PMODataDownloader *downloader = [[PMODataDownloader alloc] initWithDrawID:self.drawID];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didReceiveDownloadNotification:)
                                                 name:PMODataDownloaderDidDownloadEnded
                                               object:nil];
    
    [downloader downloadDataFromURL:drawURL];
}

- (void)didReceiveDownloadNotification:(NSNotification *)notification {
    if ([[notification.userInfo objectForKey:@"drawID"] isEqualToString:self.drawID]) {
        [self removeObservers];
        NSArray *numbers = [PMOHTMLParser drawNumbersFromRawData:[notification.userInfo objectForKey:@"data"]];
        [self willChangeValueForKey:@"numbers"];
        self.draw.numbers = numbers;
        [self didChangeValueForKey:@"numbers"];
        
    }
}

- (void)removeObservers {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}

#pragma mark - dealloc
- (void)dealloc {
    [self removeObservers];
}

@end
