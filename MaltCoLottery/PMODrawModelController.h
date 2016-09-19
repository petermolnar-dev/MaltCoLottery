//
//  PMODrawModelController.h
//  MaltCoLottery
//
//  Created by Peter Molnar on 08/08/2016.
//  Copyright © 2016 Peter Molnar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PMODraw.h"

@interface PMODrawModelController : NSObject

- (instancetype)initWithDrawID:(NSString *)drawID fromURL:(NSURL *)drawURL NS_DESIGNATED_INITIALIZER;

- (NSString *)drawID;
- (NSDate *)drawDate;
- (NSInteger)drawYear;
- (NSArray *)numbers;

- (NSInteger)minNumber;
- (NSInteger)maxNumber;
@end
