//
//  ViewController.m
//  MaltCoLottery
//
//  Created by Peter Molnar on 20/05/2016.
//  Copyright © 2016 Peter Molnar. All rights reserved.
//

#import "ViewController.h"
#import "PMODrawStorageFactory.h"



@interface ViewController()

@property (strong, nonatomic, nonnull) PMODrawModelController *modelController;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

//    NSMutableArray *mockModels = [NSMutableArray array];
//    PMODrawModelController *mockModelController =[[PMODrawModelController alloc] initWithDrawID:@"20160907" fromURL:[NSURL URLWithString:@"http://www.maltco.com/super/results_draws_sep.php?year=2016&month=9&day=7"]];
//    [mockModels addObject:mockModelController];
//    
//    
//    PMODrawStorageController *storageController = [[PMODrawStorageController alloc] initWithModelControllers:mockModels];
//    

//    PMODrawStorageFactory *storageFactory = [[PMODrawStorageFactory alloc] init];
//    PMODrawStorageController *storageController = [storageFactory buildStorage];
//    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
