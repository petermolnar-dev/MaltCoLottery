//
//  PMODraw.h
//  MaltCoLottery
//
//  Created by Peter Molnar on 07/08/2016.
//  Copyright © 2016 Peter Molnar. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 PMODraw: a pure and immutable dataset of each draw.
 */
@interface PMODraw : NSObject

/**
 drawID: The date o the draw converted to NSString with the following date fromat mask:yyyymmdd.
 */
@property (strong, nonatomic, nonnull) NSString *drawID;

/**
 Numbers: Array of NSNumbers, representing the numbers were drawn on that particular day.

 Can be nil!
 */
@property (strong, nonatomic, nullable) NSArray<NSNumber*> *numbers;

@end
