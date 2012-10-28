//
//  HomeViewController.m
//  ReferenceNews
//
//  Created by cloay on 12-10-25.
//  Copyright (c) 2012年 Cloay. All rights reserved.
//

#import "HomeViewController.h"
#import "NewsViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (IBAction)homeButtonDidPressed:(id)sender{
    UIButton *button = (UIButton *)sender;
    NewsViewController *newsViewController = [[NewsViewController alloc] initWithNibName:@"NewsViewController" bundle:nil];
    CLog(@"tag----->%i", button.tag);
    newsViewController.tag = button.tag;
    newsViewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:newsViewController animated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationController.navigationBar.tintColor = NAV_BAR_COLOR;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
