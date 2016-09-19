//
//  PMODraw.h
//  MaltCoLottery
//
//  Created by Peter Molnar on 07/08/2016.
//  Copyright © 2016 Peter Molnar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PMODraw : NSObject
@property (strong, nonatomic) NSString *drawID;
@property (strong, nonatomic) NSArray<NSNumber*> *numbers;

@end
