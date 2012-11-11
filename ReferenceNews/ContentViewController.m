//
//  ContentViewController.m
//  ReferenceNews
//
//  Created by cloay on 12-11-3.
//  Copyright (c) 2012年 Cloay. All rights reserved.
//

#import "ContentViewController.h"
#import "MatchUtil.h"
#import "TFHpple.h"
#import "UMSNSService.h"

@interface ContentViewController ()

@end

@implementation ContentViewController
@synthesize news, forwardUrl, toolBar;
@synthesize delegate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
//        [self.toolBar setCenter:CGPointMake(160, self.toolBar.center.y + 44)];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = news.title;
    
    refreshBtn = [[DAReloadActivityButton alloc] init];
    [refreshBtn addTarget:self action:@selector(refreshBtnDidTaped) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:refreshBtn];
    
    isCanClick = YES;
    CLog(@"contentUrl------>%@", news.urlStr);
    [_webView.scrollView setShowsHorizontalScrollIndicator:NO];
    [self getNewsContent];
}

- (void)getNewsContent{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"正在加载...";
    NSURL *url = [NSURL URLWithString:news.urlStr];
    httpRequest = [ASIHTTPRequest requestWithURL:url];
    [httpRequest setDelegate:self];
    [httpRequest startAsynchronous];
}

- (void)refreshBtnDidTaped{
    [refreshBtn startAnimating];
    [self getNewsContent];
}

- (IBAction)toolBarItemTaped:(id)sender{
    UIBarButtonItem *barBtnItem = (UIBarButtonItem *)sender;
    if (barBtnItem.tag == 0) {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }else{//分享
        [self showShareList];
    }
}

- (void)showShareList{
    NSString *shareText = [self.title stringByAppendingString:self.news.urlStr];
    [UMSNSService showSNSActionSheetInController:self appkey:UMKEY status:shareText image:nil];
}

- (void)showToolBar{
    [UIView animateWithDuration:0.8 animations:^{
        [self.toolBar setAlpha:1.0];
    }];
}

/* not needed
- (void)hideToolBar{
    [UIView animateWithDuration:0.5 animations:^{
        [self.toolBar setCenter:CGPointMake(160, self.toolBar.center.y + 44)];
    }];
}*/

- (void)dealloc{
    [httpRequest clearDelegatesAndCancel];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)goForward{
    ContentViewController *forwardController = [[ContentViewController alloc] initWithNibName:@"ContentViewController" bundle:nil];
    NSMutableDictionary *newsDic = [[NSMutableDictionary alloc] init];
    [newsDic setObject:@"正在加载..." forKey:@"title"];
    [newsDic setObject:[forwardUrl absoluteString] forKey:@"link"];
    News *forwardNews = [[News alloc] initWithDictionary:newsDic];
    forwardController.news = forwardNews;
    [self.navigationController pushViewController:forwardController animated:YES];
}
#pragma mark - ASIHTTPRequest delegate methods
- (void)requestFinished:(ASIHTTPRequest *)request{
    //更新标题
    TFHpple *hpple = [[TFHpple alloc] initWithData:[request responseData] isXML:NO];
    NSArray *elements = [hpple searchWithXPathQuery:@"//title"];
    if ([elements count] > 0) {
        TFHppleElement *element = [elements objectAtIndex:0];
        NSArray *children = element.children;
        if ([children count] > 0) {
            TFHppleElement *child = [children objectAtIndex:0];
            self.title = child.content;
        }
    }
    
    //更新新闻内容
    NSString *content = [MatchUtil stringNewsContent:[request responseString]];
    if (content) {
        [self showToolBar];
        [_webView loadHTMLString:content baseURL:nil];
    }else{
        [MKInfoPanel showPanelInView:self.view type:MKInfoPanelTypeError title:@"提示" subtitle:@"加载数据失败，请稍后重试！" hideAfter:3];
    }
    [refreshBtn stopAnimating];
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
}

- (void)requestFailed:(ASIHTTPRequest *)request{
    self.title = @"加载失败！";
    [refreshBtn stopAnimating];
    [MKInfoPanel showPanelInView:self.view type:MKInfoPanelTypeError title:@"提示" subtitle:@"加载数据失败，请稍后重试！" hideAfter:3];
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
}

#pragma mark - webview delegate method
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    self.forwardUrl = request.URL;
    if (isCanClick) {
        isCanClick = NO;
        return YES;
    }else{
        [self goForward];
        return NO;
    }
}
@end
