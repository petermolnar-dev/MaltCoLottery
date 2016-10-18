//
//  PMODrawModelController.m
//  MaltCoLottery
//
//  Created by Peter Molnar on 08/08/2016.
//  Copyright © 2016 Peter Molnar. All rights reserved.
//

#import "PMODrawModelController.h"
#import "PMOURLDataDownloaderWithBlock.h"
#import "PMOHTMLParser.h"
#import "PMODrawURLGenerator.h"

@interface PMODrawModelController()

@property (strong, nonatomic, nonnull) PMODraw *draw;
@property (strong, nonatomic, nonnull) NSURL *drawURL;

@end

@implementation PMODrawModelController

- (instancetype)initWithDrawDate:(NSDate *)drawDate {
    PMODraw *draw = [[PMODraw alloc] initWithDrawDate:drawDate];
    self = [self initWithExisitingDraw:draw];
    
    PMODrawURLGenerator *urlGenerator = [[PMODrawURLGenerator alloc] init];
    NSURL *drawURL = [urlGenerator generateDrawURLFromDate:drawDate];
    self.drawURL = drawURL;

    
    return self;
}

- (instancetype)initWithExisitingDraw:(id<PMODrawProtocol>)draw {
    self = [super init];
    
    if (self && draw && draw.drawDate) {
        _draw = draw;
    } else {
        @throw [NSException exceptionWithName:@"Not designated initializer"
                                       reason:@"Use [[PMODrawModelController alloc] initWithDrawID: fromURL:]"
                                     userInfo:nil];
    }
    
    return self;
    
}


#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-designated-initializers"
- (instancetype)init
{
    @throw [NSException exceptionWithName:@"Not designated initializer"
                                   reason:@"Use [[PMODrawModelController alloc] initWithDrawID: fromURL:]"
                                 userInfo:nil];
    return nil;
}
#pragma clang diagnostic pop

#pragma mark - Accessors

- (PMODraw *)draw {
    if (!_draw) {
        _draw = [[PMODraw alloc] init];
    }
    
    return _draw;
}


- (NSDate *)drawDate {
    
    return self.draw.drawDate;
}

- (NSInteger)drawYear {
    NSDateComponents *components = [self.calendar components:NSCalendarUnitYear fromDate:self.draw.drawDate];
    return [components year];
}

- (NSArray *)numbers {
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

#pragma mark - Public API
- (void)startPopulateDrawNumbersWithCompletionHandler:(void (^)(BOOL wasSuccessfull, NSArray <NSNumber*> *numbers))callback {
    PMOURLDataDownloaderWithBlock *downloader = [[PMOURLDataDownloaderWithBlock alloc] initWithSession:nil];
    
    void (^parseDownloadedData)(BOOL,  NSData * _Nullable ) = ^(BOOL wasSuccessfull, NSData *downloadedData) {
        if (wasSuccessfull) {
            NSArray *numbers = [PMOHTMLParser drawNumbersFromRawData:downloadedData];
            self.draw.numbers = numbers;
            //            NSLog(@"Numbers Arrived: %@", self.numbers);
            if ([numbers count] >0) {
                callback(TRUE, numbers);
            } else {
                callback(FALSE, nil);
            }
            
        }
    };
    if (self.drawURL) {
        [downloader downloadDataFromURL:self.drawURL completionHandler:parseDownloadedData];
    }
}


- (NSInteger)minNumber {
    NSNumber *minNumber = [self.draw.numbers valueForKeyPath:@"@min.self"];
    return  [minNumber integerValue];
}

- (NSInteger)maxNumber {
    NSNumber *maxNumber = [self.draw.numbers valueForKeyPath:@"@max.self"];
    return  [maxNumber integerValue];
    
}

- (void)populateDrawFromDraw:(id<PMODrawProtocol>)draw {
    //    TODO: Protect it from hacking, like nil csheck on the numbers.
    //    Other draw can be easily inserted and can be faking as the original one.
    if (draw) {
        self.draw = draw;
    }
}

@end
