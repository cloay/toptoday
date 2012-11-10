//
//  NewsViewController.h
//  ReferenceNews
//
//  Created by cloay on 12-10-28.
//  Copyright (c) 2012年 Cloay. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequest.h"
#import "XmlParseUtil.h"
#import "EGORefreshTableHeaderView.h"
#import "ContentViewController.h"

@interface NewsViewController : UITableViewController<ASIHTTPRequestDelegate, XmlParseUtilDelegate, EGORefreshTableHeaderDelegate, ContentViewControllerDelegate>{
    NSMutableArray *newsArray;
    ASIHTTPRequest *httpRequest;
    DAReloadActivityButton *refreshBtn;
    EGORefreshTableHeaderView *_refreshHeaderView;
    NSInteger selectedRow;
}
//新闻类别，根据类别获取相应的新闻列表
@property (nonatomic, assign) NSInteger tag;
@property (nonatomic, retain) NSMutableArray *newsArray;
@property BOOL back;
@end
