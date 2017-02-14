//
//  PMOPermanentStorage.m
//  MaltCoLottery
//
//  Created by Peter Molnar on 12/02/2017.
//  Copyright © 2017 Peter Molnar. All rights reserved.
//

#import "PMOPermanentStorage.h"

@implementation PMOPermanentStorage

+(void)saveModelStorage:(NSArray<PMODrawModelController *> *)modelControllers {
   
    NSData *dataToArchive = [NSKeyedArchiver archivedDataWithRootObject:modelControllers];
    [[NSUserDefaults standardUserDefaults] setObject:dataToArchive forKey:@"PMODrawStorage"];

}

+(nullable NSArray <PMODrawModelController *>*)loadModelStorage {
    NSData *dataToUnarchive = [[NSUserDefaults standardUserDefaults] objectForKey:@"PMODrawStorage"];
    NSArray *resultArray = [NSKeyedUnarchiver unarchiveObjectWithData:dataToUnarchive];
    
    return resultArray;
}

@end
