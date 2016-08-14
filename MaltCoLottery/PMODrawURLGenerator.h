//
//  PMODrawURLGenerator.h
//  MaltCoLottery
//
//  Created by Peter Molnar on 03/08/2016.
//  Copyright © 2016 Peter Molnar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PMODrawURLGenerator : NSObject

@property (weak, nonatomic) NSArray<NSDate *> *drawDates;

- (NSDictionary *)drawURLs;

@end
