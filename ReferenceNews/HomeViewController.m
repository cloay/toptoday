//
//  HomeViewController.m
//  ReferenceNews
//
//  Created by cloay on 12-10-25.
//  Copyright (c) 2012年 Cloay. All rights reserved.
//

#import "HomeViewController.h"
#import "NewsViewController.h"
#import "SettingsViewController.h"
#import "AboutUsViewController.h"
#import "MoreViewController.h"

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
    UIViewController *viewController;
    UIButton *button = (UIButton *)sender;
    if (button.tag < 5) {
        viewController = [[NewsViewController alloc] initWithNibName:@"NewsViewController" bundle:nil];
        ((NewsViewController *)viewController).tag = button.tag;
        
    }else if(button.tag == 5){
        viewController = [[SettingsViewController alloc] initWithNibName:@"SettingsViewController" bundle:nil];
    }else if(button.tag == 6){
        viewController = [[AboutUsViewController alloc] initWithNibName:@"AboutUsViewController" bundle:nil];
    }else if(button.tag == 7){
        viewController = [[MoreViewController alloc] initWithNibName:@"MoreViewController" bundle:nil];
    }
    [self.navigationController pushViewController:viewController animated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    self.navigationController.navigationBar.tintColor = NAV_BAR_COLOR;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
