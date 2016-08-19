//
//  PMODrawFactory.m
//  MaltCoLottery
//
//  Created by Peter Molnar on 08/08/2016.
//  Copyright © 2016 Peter Molnar. All rights reserved.
//

#import "PMODrawFactory.h"
#import "PMODrawURLGenerator.h"
#import "PMOHTMLParser.h"
#import "PMODataDownloader.h"

@interface PMODrawFactory()

@property (strong, nonatomic) PMODraw *draw;

@end


@implementation PMODrawFactory

- (PMODraw *)createDraw:(NSDate *)drawDate {
    return nil;
}

- (NSString *)generateDrawIDFromDate:(NSDate *)drawDate {
    NSDateComponents *monthAndDay = [self.calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:drawDate];
    return [NSString stringWithFormat:@"%@%@%@",[self adjustNumberFor2Spaces:[monthAndDay year]],[self adjustNumberFor2Spaces:[monthAndDay month]],[self adjustNumberFor2Spaces:[monthAndDay day]]];
}


@end
