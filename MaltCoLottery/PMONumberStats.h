//
//  PMONumberStats.h
//  MaltCoLottery
//
//  Created by Peter Molnar on 12/08/2016.
//  Copyright © 2016 Peter Molnar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PMONumberStats : NSObject
@property (strong, nonatomic) NSNumber *number;
@property (strong, nonatomic) NSArray *drawDates;
@property (strong, nonatomic) NSDate *lastDrawDay;

- (NSNumber *)drawCount;
- (NSNumber *)drawCountInYear:(NSNumber *)year;

@end
