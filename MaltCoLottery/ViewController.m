//
//  ViewController.m
//  MaltCoLottery
//
//  Created by Peter Molnar on 20/05/2016.
//  Copyright © 2016 Peter Molnar. All rights reserved.
//

#import "ViewController.h"
#import "PMODrawModelController.h"


@interface ViewController()

@property (strong, nonatomic, nonnull) PMODrawModelController *modelController;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.modelController = [[PMODrawModelController alloc] initWithDrawID:@"20160907" fromURL:[NSURL URLWithString:@"http://www.maltco.com/super/results_draws_sep.php?year=2016&month=9&day=7"]];

    [self addObserver:self
           forKeyPath:@"modelController.numbers" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
    [self.modelController startPopulateDrawNumbers];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    NSLog(@"KVO triggered");
}

@end
