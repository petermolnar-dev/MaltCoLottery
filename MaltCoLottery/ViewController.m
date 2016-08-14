//
//  ViewController.m
//  MaltCoLottery
//
//  Created by Peter Molnar on 20/05/2016.
//  Copyright © 2016 Peter Molnar. All rights reserved.
//

#import "ViewController.h"
#import "PMODrawDateGenerator.h"
#import "PMODrawStorageFactory.h"


@interface ViewController()
@property (strong, nonatomic) PMODrawDateGenerator *generator;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.generator =[[PMODrawDateGenerator alloc] init];
    PMODrawStorageFactory *factory = [[PMODrawStorageFactory alloc] init];
    NSDate *fromDate = [self.generator createDateFromComponentsWithYear:2004 withMonth:1 withDay:7];
    NSDate *toDate =[self.generator createDateFromComponentsWithYear:2004 withMonth:1 withDay:21];
    
    NSArray *shortList = [self.generator drawDaysFromDate:fromDate toDate:toDate];
    
    NSArray *draws = [factory buildStorage];
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
