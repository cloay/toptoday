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
#import "EGORefreshTableHeaderView.h"
#import "ContentViewController.h"
@interface ChinaViewController : UITableViewController<ASIHTTPRequestDelegate, XmlParseUtilDelegate, EGORefreshTableHeaderDelegate>{
    NSMutableArray *newsArray;
    ASIHTTPRequest *httpRequest;
    DAReloadActivityButton *refreshBtn;
    EGORefreshTableHeaderView *_refreshHeaderView;
}
@property (nonatomic, retain) NSMutableArray *newsArray;
@end
