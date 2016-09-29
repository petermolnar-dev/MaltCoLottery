//
//  PMONumberStats.h
//  MaltCoLottery
//
//  Created by Peter Molnar on 12/08/2016.
//  Copyright © 2016 Peter Molnar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PMONumberStats : NSObject
@property (strong, nonatomic, nonnull) NSNumber *number;
@property (strong, nonatomic, nullable) NSArray<NSDate *> *drawDates;
@property (strong, nonatomic, nullable) NSDate *lastDrawDay;

- (nullable NSNumber *)drawCount;
- (nullable NSNumber *)drawCountInYear:(nonnull NSNumber *)year;

@end
