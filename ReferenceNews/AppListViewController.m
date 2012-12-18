//
//  AppListViewController.m
//  ReferenceNews
//
//  Created by cloay on 12-12-18.
//  Copyright (c) 2012年 Cloay. All rights reserved.
//

#import "AppListViewController.h"
#import "WapsOffer/Appconnect.h"

@interface AppListViewController ()

@end

@implementation AppListViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [AppConnect showOffers:self];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onOfferClosed:) name:WAPS_OFFER_CLOSED object:nil];
}

-(void)onOfferClosed:(NSNotification*)notifyObj{
    CLog(@"Offer列表已关闭");
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
