//
//  PMODrawModelController.h
//  MaltCoLottery
//
//  Created by Peter Molnar on 08/08/2016.
//  Copyright © 2016 Peter Molnar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PMODraw.h"
#import "PMODrawDataProtocol.h"
#import "PMOCalendarOperatedAbstract.h"
#import "PMODrawProtocol.h"

/**
 The PMODrawModelController is a Controller layer on the top of the PMODraw. PMODraw is just a pure data structure, which can be accessed via PMODrawModelController.
 */
@interface PMODrawModelController : PMOCalendarOperatedAbstract <PMODrawDataProtocol>


/**
 Convenience initializer of the ModelController

 @param drawDate  the draw date..
 @param drawURL the full URL where the draw is available on the MAltCo site. Keep in mind, that not all of the generated URL's are valid (due to public holidays).

 @return PMOModellController
 */
- (nullable instancetype)initWithDrawDate:(nonnull NSDate *)drawDate;

/**
 Designated initializer, injecting an existing draw.

 @param drawDate the draw date.
 @param drawURL  the full URL where the draw is available on the MAltCo site. Keep in mind, that not all of the generated URL's are valid (due to public holidays).
 @param draw     the draw, which should be used the internal draw for this modelcontroller

 @return PMOModelcontroller
 */
- (nullable instancetype)initWithExisitingDraw:(nullable id<PMODrawProtocol>)draw NS_DESIGNATED_INITIALIZER;

/**
 Start fetching down the HTTP request, and parse the page in order to fill up with the numbers.
 */
- (void)startPopulateDrawNumbersWithCompletionHandler:(void (^_Nonnull)(BOOL wasSuccessfull,  NSArray <NSNumber*>* _Nullable numbers))callback;


/**
 The date of the draw with the following format: yyyymmdd.
 
 @return DrawID, example: 20160405
 */
- (nonnull NSDate *)drawDate;


/**
 The year or the draw.

 @return returns the year part of the draw date as an integer
 */
- (NSInteger)drawYear;


/**
 The minimum among the numbers.

 @return minimum number of the draw set
 */
- (NSInteger)minNumber;


/**
 The maximum among the numbers.

 @return maximum number of the draw set
 */
- (NSInteger)maxNumber;

/**
 Populate the model controller dataset with a given instance of draw.

 @param draw Any object, wich comlpies PMODrawProtocol.
 */
- (void)populateDrawFromDraw:(nonnull id<PMODrawProtocol>)draw;

@end
