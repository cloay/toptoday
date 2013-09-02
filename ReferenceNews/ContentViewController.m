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
@synthesize news, forwardUrl, errorLabel;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization

    }
    return self;
}


- (void)initAdmob{
    // 在屏幕底部创建标准尺寸的视图。
    bannerView_ = [[GADBannerView alloc]
                   initWithFrame:CGRectMake(0.0,
                                            - 100,
                                            GAD_SIZE_320x50.width,
                                            GAD_SIZE_320x50.height)];
    
    // 指定广告的“单元标识符”，也就是您的 AdMob 发布商 ID。
    bannerView_.adUnitID = ADUINTID;
    bannerView_.delegate = self;
    // 告知运行时文件，在将用户转至广告的展示位置之后恢复哪个 UIViewController
    // 并将其添加至视图层级结构。
    bannerView_.rootViewController = self;
    [self.view addSubview:bannerView_];
    
    close_ad_btn = [UIButton buttonWithType:UIButtonTypeCustom];
    close_ad_btn.hidden = YES;
    [close_ad_btn setFrame:CGRectMake(290, - 50, 30, 30)];
    [close_ad_btn setImage:[UIImage imageNamed:@"close_btn"] forState:UIControlStateNormal];
    [close_ad_btn addTarget:self action:@selector(closeAdBtnDidTaped:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:close_ad_btn];
    // 启动一般性请求并在其中加载广告。
    [bannerView_ loadRequest:[GADRequest request]];
}

- (IBAction)closeAdBtnDidTaped:(id)sender{
    [UIView beginAnimations:@"BannerSlide" context:nil];
    [bannerView_ setCenter:CGPointMake(bannerView_.center.x, bannerView_.center.y - 100)];
    [close_ad_btn setCenter:CGPointMake(close_ad_btn.center.x, close_ad_btn.center.y - 95)];
    [UIView commitAnimations];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    titleLabel = [[AutoScrollLabel alloc] initWithFrame:CGRectMake(0, 0, 230, 25)];
    [titleLabel setTextColor:[UIColor whiteColor]];
    [titleLabel setFont:[UIFont boldSystemFontOfSize:20]];
    titleLabel.text = self.news.title;
    self.navigationItem.titleView = titleLabel;
    
    refreshBtn = [[DAReloadActivityButton alloc] init];
    [refreshBtn addTarget:self action:@selector(refreshBtnDidTaped) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:refreshBtn];
    
    [self.navigationController.toolbar setTintColor:NAV_BAR_COLOR];
    
    UIBarButtonItem *homeItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"btn_bar_home"] style:UIBarButtonItemStylePlain target:self action:@selector(toolBarItemTaped:)];
    [homeItem setWidth:40];
    homeItem.tag = 0;
    
    UIBarButtonItem *spaceItem = [[UIBarButtonItem alloc] initWithCustomView:[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 200, 44)]];
    [spaceItem setWidth:205];
    spaceItem.tag = 1;
    
    UIBarButtonItem *shareItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(toolBarItemTaped:)];
    [shareItem setWidth:75];
    shareItem.tag = 2;
    
    [self setToolbarItems:[NSArray arrayWithObjects:homeItem, spaceItem, shareItem, nil]];
    
    CLog(@"toolbarItems--->%@", self.toolbarItems);
    
    isCanClick = YES;
    CLog(@"contentUrl------>%@", news.urlStr);
//    _webView.scrollView.bounces = NO;
    [_webView.scrollView setShowsHorizontalScrollIndicator:NO];
    [self getNewsContent];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [titleLabel scroll];
    if (errorLabel.hidden) {
        [self.navigationController setToolbarHidden:NO animated:YES];
    }
}
- (void)getNewsContent{
    errorLabel.hidden = YES;
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
    }else if(barBtnItem.tag == 2){//分享
        [self showShareList];
    }
}

- (void)showShareList{
    NSString *shareText = [NSString stringWithFormat:@"#今日头条+#%@ appstore地址：https://itunes.apple.com/cn/app/jin-ri-tou-tiao+/id588693815?mt=8", [titleLabel.text stringByAppendingString:self.news.urlStr]];
    [UMSNSService showSNSActionSheetInController:self.navigationController appkey:UMKEY status:shareText image:nil];
}

- (void)showToolBar{
    [self.navigationController setToolbarHidden:NO animated:YES];
    [self initAdmob];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setToolbarHidden:YES animated:YES];
}

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
    [newsDic setObject:titleLabel.text forKey:@"title"];
    [newsDic setObject:[forwardUrl absoluteString] forKey:@"link"];
    News *forwardNews = [[News alloc] initWithDictionary:newsDic];
    forwardController.news = forwardNews;
    [self.navigationController pushViewController:forwardController animated:YES];
}
#pragma mark - ASIHTTPRequest delegate methods
- (void)requestFinished:(ASIHTTPRequest *)request{
    //更新标题 apple not support this way.
    /*TFHpple *hpple = [[TFHpple alloc] initWithData:[request responseData] isXML:NO];
    NSArray *elements = [hpple searchWithXPathQuery:@"//title"];
    if ([elements count] > 0) {
        TFHppleElement *element = [elements objectAtIndex:0];
        NSArray *children = element.children;
        if ([children count] > 0) {
            TFHppleElement *child = [children objectAtIndex:0];
            titleLabel.text = child.content;
        }
    }*/
    
    //更新新闻内容
    NSString *content = [MatchUtil stringNewsContent:[request responseString]];
    if (content) {
        [self showToolBar];
        [_webView loadHTMLString:[MatchUtil addStyleToNews:content] baseURL:nil];
    }else{
        errorLabel.hidden = NO;
        [MKInfoPanel showPanelInView:self.view type:MKInfoPanelTypeError title:@"提示" subtitle:@"加载数据失败，请稍后重试！" hideAfter:2];
    }
    [refreshBtn stopAnimating];
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
}

- (void)requestFailed:(ASIHTTPRequest *)request{
    [refreshBtn stopAnimating];
    [MKInfoPanel showPanelInView:self.view type:MKInfoPanelTypeError title:@"提示" subtitle:@"加载数据失败，请稍后重试！" hideAfter:2];
    self.errorLabel.hidden = NO;
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

#pragma mark - GADBannerView delegate method
- (void)adViewDidReceiveAd:(GADBannerView *)bannerView {
    close_ad_btn.hidden = NO;
    [UIView beginAnimations:@"BannerSlide" context:nil];
    if (bannerView_.center.y <= -50) {
        [bannerView_ setCenter:CGPointMake(bannerView_.center.x, bannerView_.center.y + 100)];
        [close_ad_btn setCenter:CGPointMake(close_ad_btn.center.x, close_ad_btn.center.y + 98)];
    }
    [UIView commitAnimations];
}

- (void)viewDidUnload {
    [self setErrorLabel:nil];
    [super viewDidUnload];
}
@end
