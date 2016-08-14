//
//  PMODrawStorageFactory.m
//  MaltCoLottery
//
//  Created by Peter Molnar on 09/08/2016.
//  Copyright © 2016 Peter Molnar. All rights reserved.
//

#import "PMODrawStorageFactory.h"
#import "PMODrawURLGenerator.h"
#import "PMODataDownloader.h"
#import "PMOHTMLParser.h"
#import "PMODraw.h"

@interface PMODrawStorageFactory()

@property (strong, nonatomic) PMODataDownloader *downloader;

@end

@implementation PMODrawStorageFactory

- (NSArray *)buildStorage {

    PMODrawURLGenerator *generator = [[PMODrawURLGenerator alloc] init];
    NSMutableArray *drawList = [[NSMutableArray alloc] init];
    
    self.downloader = [[PMODataDownloader alloc] init];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(dataDownloaded:)
                                                 name:PMODataDownloaderDidDownloadEnded
                                               object:self.downloader];
    // Testcode
    NSDictionary *drawURLList = [generator drawURLs];
    
    for (NSString *drawID in [drawURLList allKeys]) {
        NSData *drawHtmlData = [NSData dataWithContentsOfURL:[drawURLList objectForKey:drawID]];
        NSArray *numbers = [PMOHTMLParser drawNumbersFromRawData:drawHtmlData ];
        PMODraw *newDraw = [[PMODraw alloc] init];
        
        if (newDraw && [numbers count]>0) {
            newDraw.drawID = drawID;
            newDraw.numbers = numbers;
            [drawList addObject:newDraw];
        }
        
    }
    NSLog(@"Drawlist: %@", drawList);
    return drawList;
}

- (void)dataDownloaded:(NSData *)data {
    
}

@end
