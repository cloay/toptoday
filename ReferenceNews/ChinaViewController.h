//
//  ChinaViewController.h
//  ReferenceNews
//
//  Created by cloay on 12-10-27.
//  Copyright (c) 2012年 Cloay. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequest.h"
#import "XmlParseUtil.h"

@interface ChinaViewController : UITableViewController<ASIHTTPRequestDelegate, XmlParseUtilDelegate>{
    NSMutableArray *newsArray;
    ASIHTTPRequest *httpRequest;
}

@property (nonatomic, retain) NSMutableArray *newsArray;
@end
