//
//  PMOProgressDelegate.h
//  MaltCoLottery
//
//  Created by Peter Molnar on 30/10/2016.
//  Copyright © 2016 Peter Molnar. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol PMOProgressDelegate <NSObject>
- (void)updateProgressWithPercentage:(float)percentage;
@end
