//
//  ViewController.m
//  MaltCoLottery
//
//  Created by Peter Molnar on 20/05/2016.
//  Copyright © 2016 Peter Molnar. All rights reserved.
//

#import "ViewController.h"
#import "PMODrawStorageFactory.h"
#import "PMONumberStatsModelController.h"

#define MAX_NUMBERS_IN_GAME @45
#define COUNT_OF_NUMBERS_PROPOSED 5


@interface ViewController()

@property (strong, nonatomic, nonnull) PMODrawStorageController *storageController;
@property (strong, nonatomic, nonnull) PMONumberStatsModelController *numberStatsController;
@property (weak, nonatomic) IBOutlet UIButton *getStatistics;
@property (weak, nonatomic) IBOutlet UIView *statisticsView;
@property (weak, nonatomic) IBOutlet UITextView *finalStatisticsText;


@property (weak, nonatomic) IBOutlet UIProgressView *progressView;
@property (weak, nonatomic) IBOutlet UILabel *percentageLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.finalStatisticsText setHidden:YES];
    [self.progressView setHidden:YES];
    [self.statisticsView setHidden:YES];
    [self.percentageLabel setHidden:YES];
    self.progressView.progress = 0.0;
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didStorageFilledUp)
                                                 name:PMODrawStorageFilledUp
                                               object:nil];
    
    
}

- (PMODrawStorageController *)storageController {
    if (!_storageController) {
        PMODrawStorageFactory *storageFactory = [[PMODrawStorageFactory alloc] init];
        _storageController = [storageFactory buildStorage];
        _storageController.progressDelegate = self;
    }
    
    return _storageController;
}

- (PMONumberStatsModelController *)numberStatsController {
    if (!_numberStatsController) {
        _numberStatsController = [[PMONumberStatsModelController alloc] initWithNumberCount:MAX_NUMBERS_IN_GAME arraySizeForStatistics:COUNT_OF_NUMBERS_PROPOSED];
    }
    return _numberStatsController;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)didStorageFilledUp {
    [self.numberStatsController updateStatisticFromNumberStorage:self.storageController];
    
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        
        NSMutableString *statisticString = [NSMutableString stringWithFormat:@"last Draw: %@\n least Draw: %@\n statisticalyLow: %@\n statisticalyHigh: %@\n statisticalyLow in This year: %@\n statisticalyHigh in This year: %@",[self.numberStatsController lastRecentlyDrawn], [self.numberStatsController leastRecentlyDrawn],[self.numberStatsController statisticalyLow], [self.numberStatsController statisticalyHigh],[self.numberStatsController statisticalyLowInThisYear],[self.numberStatsController statisticalyHighInThisYear]];
        
        self.finalStatisticsText.text = statisticString;
        [self showStatisticView];
    }];
    

    NSDate *today = [NSDate date];
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitYear fromDate:today];
    NSInteger year = [components year];
    
    NSDateComponents *firstDayOfThisYearComponents = [NSDateComponents new];
    [firstDayOfThisYearComponents setDay:7];
    [firstDayOfThisYearComponents setMonth:1];
    [firstDayOfThisYearComponents setYear:year];
    NSDate *firstDayOfThisYear = [[NSCalendar currentCalendar] dateFromComponents:firstDayOfThisYearComponents];
    
    
    NSLog(@"last Draw: %@", [self.numberStatsController lastRecentlyDrawn]);
    NSLog(@"least Draw: %@", [self.numberStatsController leastRecentlyDrawn]);
    NSLog(@"statisticalyLow: %@", [self.numberStatsController statisticalyLow]);
    NSLog(@"statisticalyHigh: %@", [self.numberStatsController statisticalyHigh]);
    NSLog(@"statisticalyLow in This year: %@", [self.numberStatsController statisticalyLowInThisYear]);
    NSLog(@"statisticalyHigh in This year: %@", [self.numberStatsController statisticalyHighInThisYear]);
    NSLog(@"minValue in This year: %@", [self.numberStatsController minValueFromDate:firstDayOfThisYear toDate:[NSDate date]]);
    
    NSLog(@"maxValue in This year: %@", [self.numberStatsController maxValueFromDate:firstDayOfThisYear toDate:[NSDate date]]);
    
}

- (IBAction)downloadAndBuildStatistics:(UIButton *)sender {
    [sender setHidden:YES];
    [self showProgress];
    [self.storageController populateDrawsNumbers];
}

- (void)updateProgressWithPercentage:(float)percentage {
    
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        [_progressView setProgress:percentage animated:YES];
        [_percentageLabel setText:[NSString stringWithFormat:@"Downloaded %.1f %%",percentage*100]];
    }];
    
}

- (void)showStatisticView {
    [self.getStatistics setHidden:YES];
    [self.percentageLabel setHidden:YES];
    [self.progressView setHidden:YES];
    [self.finalStatisticsText setHidden:NO];
}

- (void)showProgress {
    [self.getStatistics setHidden:YES];
    [self.percentageLabel setHidden:NO];
    [self.progressView setHidden:NO];
    [self.finalStatisticsText setHidden:YES];
}




@end
