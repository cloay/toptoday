//
//  SettingsViewController.m
//  ReferenceNews
//
//  Created by cloay on 12-10-27.
//  Copyright (c) 2012年 Cloay. All rights reserved.
//

#import "SettingsViewController.h"
#import "UMFeedback.h"
#import "NotificationUtil.h"
#import "AboutUsViewController.h"
#import "MobClick.h"


@interface SettingsViewController ()

@end

@implementation SettingsViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.title = @"设置";
    self.navigationController.navigationBar.tintColor = NAV_BAR_COLOR;
    settings = [NSUserDefaults standardUserDefaults];
    UILabel * copyLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 30)];
    copyLabel.textColor = [UIColor grayColor];
    [copyLabel setBackgroundColor:[UIColor clearColor]];
    copyLabel.textAlignment = NSTextAlignmentCenter;
    [copyLabel setFont:[UIFont systemFontOfSize:14]];
    copyLabel.text = @"Copyright © 2012 Cloay. All rights reserved.";
    
    self.tableView.tableFooterView = copyLabel;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    // Return the number of sections.
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    int number = 0;
    switch (section) {
        case 0:
            number = 2;
            break;
        case 1:
            number = 3;
            break;
        default:
            break;
    }
    return number;
}

- (float)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 28;
}
/* not needed
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    NSString *title = @"";
    switch (section) {
        case 0:
            title = @"分享";
            break;
        case 1:
            title = @"通知";
            break;
        case 2:
            title = @"其他";
            break;
        default:
            break;
    }
    return title;
}*/

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"SettingsCellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
        [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    }
    
    // Configure the cell...
    NSInteger section = [indexPath section];
    NSInteger row = [indexPath row];

    switch (section) {
        case 0:
            if (row == 0) {
                [cell.imageView setImage:[UIImage imageNamed:@"font_icon"]];
                [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
                [cell setAccessoryType:UITableViewCellAccessoryNone];
                cell.textLabel.text = @"设置字体大小";
                UISegmentedControl *sgControl = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:@"小", @"中", @"大", nil]];
                [sgControl setFrame:CGRectMake(200, 8, 90, 30)];
                int fontSize = [settings integerForKey:@"fontsize"];
                [sgControl setSelectedSegmentIndex:fontSize];
                [sgControl addTarget:self action:@selector(sgControlValueChanged:) forControlEvents:UIControlEventValueChanged];
                [cell.contentView addSubview:sgControl];
            }else if (row == 1) {
                [cell.imageView setImage:[UIImage imageNamed:@"notifi_icon"]];
                [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
                [cell setAccessoryType:UITableViewCellAccessoryNone];
                cell.textLabel.text = @"打开或关闭通知";
                UISwitch *switchBtn = [[UISwitch alloc] initWithFrame:CGRectMake(210, 10, 50, 25)];
                [switchBtn addTarget:self action:@selector(switchBtnValueChanged:) forControlEvents:UIControlEventValueChanged];
                [switchBtn setOn:YES];
                //读取用户设置的状态，如果没有设置，默认为打开YES
                if ([settings objectForKey:KNOTIFICATION]) {
                    [switchBtn setOn:[settings boolForKey:KNOTIFICATION]];
                }
                [cell.contentView addSubview:switchBtn];
            }else{
                [cell.imageView setImage:[UIImage imageNamed:@"share_icon"]];
                cell.textLabel.text = @"分享";
            }
            
            break;
        case 1:
            if (row == 0) {
            [cell.imageView setImage:[UIImage imageNamed:@"feedback_icon"]];                
                cell.textLabel.text = @"用户反馈";
            }else if (row == 1){
                [cell.imageView setImage:[UIImage imageNamed:@"about_icon"]];
                cell.textLabel.text = @"关于";
            }else if (row == 2){
                [cell.imageView setImage:[UIImage imageNamed:@"dafei_icon"]];
                cell.textLabel.text = @"评价打分一把";
            }
        default:
            break;
    }
    return cell;
}

- (IBAction)sgControlValueChanged:(UISegmentedControl *)sender{
    [settings setValue:[NSNumber numberWithInt:sender.selectedSegmentIndex] forKey:@"fontsize"];
}

- (IBAction)switchBtnValueChanged:(id)sender{
    UISwitch *switchBtn = (UISwitch *)sender;
    [settings setBool:switchBtn.isOn forKey:KNOTIFICATION];
    if (switchBtn.isOn) {//生成通知
//        [NotificationUtil makeLocalNotification];
    }else{//关闭通知
//        [NotificationUtil cancelLocalNotification];
    }
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSInteger section = [indexPath section];
    NSInteger row = [indexPath row];
    switch (section) {
        case 0: //分享
            if (row == 2) {
                [self showShareList];
            }
            break;
        case 1:
            if (row == 0) {
                [UMFeedback showFeedback:self withAppkey:UMKEY];
            }else if(row == 1){//关于
                AboutUsViewController *aboutView = [[AboutUsViewController alloc] initWithNibName:@"AboutUsViewController" bundle:nil];
                aboutView.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:aboutView animated:YES];
            }else if (row == 2){
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:APPSTORE]];
            }
            break;
        default:
            break;
    }
}


#pragma mark
- (void)showShareList{
//    NSString *shareText = @"#今日头条#我正在使用今日头条参考消息专版看新闻，很方便，你也试一下吧！appstore地址: https://itunes.apple.com/cn/app/jin-ri-tou-tiao+/id588693815?mt=8";
//    UIImage *shareImage = [UIImage imageNamed:@"share_home_image"];
}

@end
