//
//  PMOHTMLParser.m
//  MaltCoLottery
//
//  Created by Peter Molnar on 08/08/2016.
//  Copyright © 2016 Peter Molnar. All rights reserved.
//

#import "PMOHTMLParser.h"
#import "TFHpple.h"

@implementation PMOHTMLParser

+ (NSArray *)drawNumbersFromRawData:(NSData *)drawRawHTMLData {
    NSMutableArray *numbers = [[NSMutableArray alloc] init];
    
    NSNumberFormatter *numberFormatter =[[NSNumberFormatter alloc] init];
    numberFormatter.numberStyle = NSNumberFormatterDecimalStyle;
    
    TFHpple *parser = [TFHpple hppleWithHTMLData:drawRawHTMLData];
    NSString *drawXpathQueryString = @"//table[@class='ergeb']/tr/td";
    NSArray *numberNodes = [parser searchWithXPathQuery:drawXpathQueryString];
    
    for (TFHppleElement *element in numberNodes) {
        NSString *currNumAsString = [[[element firstChild] content] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        if ([currNumAsString length]>0) {
            NSNumber *currNumber = [numberFormatter numberFromString:currNumAsString];
            if (currNumber) {
                [numbers addObject:currNumber ];
            }
        }
        
    }
    
    NSArray *sortedNumbers = [numbers sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        if ([(NSNumber *)obj1 integerValue] < [(NSNumber *)obj2 integerValue] ) {
            return NSOrderedAscending;
        } else if ([(NSNumber *)obj2 integerValue] < [(NSNumber *)obj1 integerValue] ) {
            return NSOrderedDescending;
        } else {
            return NSOrderedSame;
        }
    }];
    
    return sortedNumbers;
}

@end
