//
//  PMOPermanentStorage.h
//  MaltCoLottery
//
//  Created by Peter Molnar on 12/02/2017.
//  Copyright © 2017 Peter Molnar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PMODrawModelController.h"

@interface PMOPermanentStorage : NSObject

+(void)saveModelStorage:(nullable NSArray <PMODrawModelController *>*)modelControllers;
+(nullable NSArray <PMODrawModelController *>*)loadModelStorage;

@end
