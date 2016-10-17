//
//  PMONumberStatsModelController.m
//  MaltCoLottery
//
//  Created by Peter Molnar on 12/10/2016.
//  Copyright © 2016 Peter Molnar. All rights reserved.
//

#import "PMONumberStatsModelController.h"
#import "PMONumberStat.h"
#import "PMODrawDataProtocol.h"

@interface PMONumberStatsModelController()

/**
 NSMutableDictionary to hold the number statistical information
 */
@property (strong, nonatomic, nonnull) NSMutableDictionary <NSNumber *,PMONumberStat *> *numberStats;

/**
 To store the number's count for the game
 */
@property (strong, nonatomic, nonnull) NSNumber *numbersInGame;

@property (nonatomic) NSInteger arraySizeForStatistics;

@end

@implementation PMONumberStatsModelController

#pragma mark - Initializers
- (instancetype)initWithNumberCount:(NSNumber *)numbersInGame arraySizeForStatistics:(NSInteger)arraySize {
    if (numbersInGame) {
        self = [super init];
        if (self) {
            _numbersInGame = numbersInGame;
            if (arraySize > 0) {
                _arraySizeForStatistics = arraySize;
            } else {
                _arraySizeForStatistics = 5;
            }
            [self createEmptyStorageForNumberOfStatistics];
        }
    } else {
        @throw [NSException exceptionWithName:@"Nil value passed to a nonnull paramter"
                                       reason:@"Use [[PMONumberStatsModelController alloc] initWithNumberCount:arraySizeForStatistics:]"
                                     userInfo:nil];
        self = nil;
    }
    
    return self;
}

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-designated-initializers"
- (instancetype)init
{
    @throw [NSException exceptionWithName:@"Not designated initializer"
                                   reason:@"Use [[PMONumberStatsModelController alloc] initWithNumberCount:arraySizeForStatistics: ]"
                                 userInfo:nil];
    return nil;
}
#pragma clang diagnostic pop

#pragma mark - Public API
- (void)updateStatisticFromNumberStorage:(id<PMODrawStorageProtocol>)storage {
    
    [self createEmptyStorageForNumberOfStatistics];
    // TODO: parse the storage
}

#pragma mark - Helpers
- (void)createEmptyStorageForNumberOfStatistics {
    NSMutableDictionary *newNumberStats = [[NSMutableDictionary alloc] init];
    for (int i = 1; i < [self.numbersInGame intValue]+1; i++ ) {
        PMONumberStat *numberStat = [[PMONumberStat alloc] initWithNumber:[NSNumber numberWithInt:i] drawDates:nil];
        [newNumberStats setObject:numberStat forKey:numberStat.number];
    }
    _numberStats = newNumberStats;
}

- (void)parseStorage:(id<PMODrawStorageProtocol>)storage {
    
    for (id<PMODrawDataProtocol> draw in [[storage models] allValues]) {
        for (NSNumber *number in [draw numbers]) {
            NSMutableArray *drawDates =[NSMutableArray arrayWithArray:_numberStats[number].drawDates];
            [drawDates addObject:[draw drawDate]];
            PMONumberStat *newNumberStat = [[PMONumberStat alloc] initWithNumber:number drawDates:drawDates];
            _numberStats[number] = newNumberStat;
        }
    }
}

#pragma mark - Statistical methods
- (nullable NSArray *)lastRecentlyDrawn {
    /* The last recently drawn list.
     1. startaegy: Go thorugh all of the numbers, and see if the
     maximum of the drawdates is bigger than the minimum of the drawdates in the lastRecentlyDrawn, or the array has free space. If yes, exchange/add the number.
     2. startaegy: built another dictionary with number:lastdrawdate. Order it by lastdrawdate, and get the first X. Same can apply for the leastRecent, but get the last X.
     */
    return nil;
}
- (nullable NSArray *)leastRecentlyDrawn{
    /* The least recently drawn list.
     1. startaegy: Go thorugh all of the numbers, and see if the
     minimum of the drawdates is bigger than the minimum of the drawdates in the lastRecentlyDrawn, or the array has free space. If yes, exchange/add the number.
     2. startaegy: built another dictionary with number:lastdrawdate. Order it by lastdrawdate, and get the first X. Same can apply for the leastRecent, but get the last X.
     */
    return nil;
}

- (nullable NSArray *)statisticalyLowInThisYear {
    
    return nil;
}

- (nullable NSArray *)statisticalyHighInThisYear {
    return nil;
}

- (nullable NSArray *)statisticalyLow {
    /* get the ones, where the count of the draws are the minimum
     */
    return nil;
}
- (nullable NSArray *)statisticalyHigh {
    /* get the ones, where the count of the draws are the maximum
     */
    return nil;
}

- (nullable NSNumber *)minValueFromDate:(nonnull NSDate *)fromDate toDate:(nonnull NSDate *)toDate {
    return nil;
}

- (nullable NSNumber *)maxValueFromDate:(nonnull NSDate *)fromDate toDate:(nonnull NSDate *)toDate {
    return nil;
}

- (NSInteger)drawCountForThisYear:(nonnull NSNumber *)number {
    return 0;
}

- (NSInteger)drawCountAllTimesForNumber:(nonnull NSNumber *)number {
    /* get back the count of draws of the number*/
    return 0;
}


@end
