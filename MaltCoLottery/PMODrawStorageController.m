//
//  PMODrawStorageController.m
//  MaltCoLottery
//
//  Created by Peter Molnar on 29/09/2016.
//  Copyright © 2016 Peter Molnar. All rights reserved.
//

#import "PMODrawStorageController.h"

@interface PMODrawStorageController()

@property (strong, nonatomic, nullable) NSMutableArray <PMODrawModelController *>* privateModels;

@end

@implementation PMODrawStorageController

#pragma mark - Initializer
- (instancetype)initWithModelControllers:(nullable NSArray <PMODrawModelController *>*) models {
    self = [super init];

    if (self) {
        if (models) {
            _privateModels = [[NSMutableArray alloc] init];
            for (PMODrawModelController * currModelController in models) {
                [_privateModels addObject:currModelController];
                [currModelController startPopulateDrawNumbers];
            }
        }
    }
    
    return self;
    
}


#pragma mark accessors
- (NSArray *)models {
    return _privateModels;
}

- (NSInteger)modelCount {
    return [_privateModels count];
}



@end
