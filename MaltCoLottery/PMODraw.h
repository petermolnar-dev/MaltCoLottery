//
//  PMODraw.h
//  MaltCoLottery
//
//  Created by Peter Molnar on 07/08/2016.
//  Copyright © 2016 Peter Molnar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PMODraw : NSObject
@property (strong, nonatomic, nonnull) NSString *drawID;
@property (strong, nonatomic, nullable) NSArray<NSNumber*> *numbers;

@end
