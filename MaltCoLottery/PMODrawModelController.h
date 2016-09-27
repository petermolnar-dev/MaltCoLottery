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

/**
 Designated initializer of the ModelController

 @param drawID  the internal ID of the draw, built from the date, with yyyymmdd mask.
 @param drawURL the full URL where the draw is available on the MAltCo site. Keep in mind, that not all of the generated URL's are valid (due to public holidays).

 @return PMOModellController
 */
- (nonnull instancetype)initWithDrawID:(nonnull NSString *)drawID fromURL:(nonnull NSURL *)drawURL NS_DESIGNATED_INITIALIZER;

/**
 The date of the draw with the fillowing format: yyyymmdd
 
 @return DrawID, example: 20160405
 */
- (nonnull NSString *)drawID;

/**
 The draw date in native date format

 @return drawDate in date format
 */
- (nonnull NSDate *)drawDate;

/**
 The year or the draw

 @return returns the year part of the draw date as an integer
 */
- (NSInteger)drawYear;

/**
 The numbers, which were drawn on that specific date. 
 
 Please note, that can be nil!

 @return the array of 5 numers, were draw on that day. Can be null, if there were no draws on that day (for example: Public Holicay)
 */
- (nullable NSArray *)numbers;


/**
 The minimum among the numbers

 @return minimum number of the draw set
 */
- (NSInteger)minNumber;

/**
 The maximum among the numbers

 @return maximum number of the draw set
 */
- (NSInteger)maxNumber;
@end
