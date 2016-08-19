//
//  PMOHTMLParserTests.m
//  MaltCoLottery
//
//  Created by Peter Molnar on 14/08/2016.
//  Copyright © 2016 Peter Molnar. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "PMOHTMLParser.h"

@interface PMOHTMLParserTests : XCTestCase
@property (strong, nonatomic) PMOHTMLParser *parser;
@end

@implementation PMOHTMLParserTests


- (void)testMaltCoSpecificParse {
    NSString *pageHTML = @"align=\"right\" cellpadding=\"0\" cellspacing=\"0\">     <tr>     <td width=\"358\" height=\"98\" background=\"images/res_in.gif\"><span class=\"date\">     &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;     &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;     &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;     &nbsp;&nbsp;&nbsp;     7th January 2004                        &nbsp;&nbsp;&nbsp; <br>     &nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;     &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;     &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;     &nbsp;&nbsp;&nbsp;Draw No:     <br>     </span>     <table width=\"234\" height=\"46\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" class=\"ergeb\">     <tr>     <td width=\"29\">&nbsp;</td>     <td width=\"44\">     10                              &nbsp;</td>     <td width=\"43\">     32                            </td>     <td width=\"44\">     21                            </td>     <td width=\"43\">     40                            </td>     <td width=\"31\"><div align=\"left\"><strong>     34                                </strong></div></td>     </tr>     </table></td>     </tr>     </table></td>     </tr>     </table>     <br>";
    NSData *rawData = [pageHTML dataUsingEncoding:NSUTF8StringEncoding];
    NSArray *drawNumbers = [PMOHTMLParser drawNumbersFromRawData:rawData];
    NSArray *testNumbers = @[@10,@21,@32,@34,@40];
    BOOL isEqual = true;
    // Test needs to be done on each number and not on the array.
    // Some numbers converted to (long) after the parse.
    for (int i=0; i< [testNumbers count]; i++) {
        if (![(NSNumber *)testNumbers[i] isEqualToNumber:drawNumbers[i]]) {
            isEqual =false;
        }
    }
    XCTAssertTrue(isEqual);
}
@end
