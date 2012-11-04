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

@interface ContentViewController : UIViewController<ASIHTTPRequestDelegate, UIWebViewDelegate>{
    ASIHTTPRequest *httpRequest;
    BOOL isCanClick;
}
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (nonatomic, strong) News *news;
@property (nonatomic, strong) NSURL *forwardUrl;
@property (weak, nonatomic) IBOutlet UIToolbar *toolBar;

- (IBAction)toolBarItemTaped:(id)sender;
@end
