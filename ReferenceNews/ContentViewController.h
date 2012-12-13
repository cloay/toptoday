//
//  ContentViewController.h
//  ReferenceNews
//
//  Created by cloay on 12-11-3.
//  Copyright (c) 2012年 Cloay. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "News.h"
#import "ASIHTTPRequest.h"
#import "AutoScrollLabel.h"
#import "GADBannerView.h"

@protocol ContentViewControllerDelegate;
@interface ContentViewController : UIViewController<ASIHTTPRequestDelegate, UIWebViewDelegate, GADBannerViewDelegate>{
    ASIHTTPRequest *httpRequest;
    BOOL isCanClick;
    DAReloadActivityButton *refreshBtn;
    AutoScrollLabel *titleLabel;
    
    GADBannerView *bannerView_;
}
@property (weak, nonatomic) IBOutlet UILabel *errorLabel;
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (nonatomic, strong) News *news;
@property (nonatomic, strong) NSURL *forwardUrl;
@property (weak, nonatomic) IBOutlet UIToolbar *toolBar;

@property (nonatomic, strong) id <ContentViewControllerDelegate> delegate;
- (IBAction)toolBarItemTaped:(id)sender;
@end

@protocol ContentViewControllerDelegate <NSObject>

- (void)backButtonDidTaped;
@end