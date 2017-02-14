//
//  PMONumberStats.h
//  MaltCoLottery
//
//  Created by Peter Molnar on 12/08/2016.
//  Copyright © 2016 Peter Molnar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PMONumberStat : NSObject
@property (strong, nonatomic, nonnull, readonly) NSNumber *number;
@property (strong, nonatomic, nullable, readonly) NSArray<NSDate *> *drawDates;
@property (strong, nonatomic, nullable, readonly) NSDate *lastDrawDay;


- (nullable instancetype)initWithNumber:(nonnull NSNumber *)number drawDates:(nullable NSArray <NSDate *>*)drawDates NS_DESIGNATED_INITIALIZER;

- (nullable instancetype)init NS_UNAVAILABLE;

@end
