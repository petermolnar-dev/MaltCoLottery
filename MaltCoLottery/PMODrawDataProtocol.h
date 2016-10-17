//
//  PMODrawProtocol.h
//  MaltCoLottery
//
//  Created by Peter Molnar on 14/10/2016.
//  Copyright © 2016 Peter Molnar. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol PMODrawDataProtocol <NSObject>

/**
 The draw date in date format.
 
 @return drawDate in date format
 */
- (nonnull NSDate *)drawDate;


/**
 The numbers, which were drawn on that specific date.
 
 Please note, that can be nil, if there were no draws on that day (for example: Public Holiday)!
 
 @return the array of numbers, were draw on that day.
 */
- (nullable NSArray *)numbers;

@end
