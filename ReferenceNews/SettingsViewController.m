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
#import "UMSNSService.h"
#import "AboutViewController.h"
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

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;

    self.navigationController.navigationBar.tintColor = NAV_BAR_COLOR;
    settings = [NSUserDefaults standardUserDefaults];
    UILabel * copyLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 30)];
    copyLabel.textColor = [UIColor grayColor];
    [copyLabel setBackgroundColor:[UIColor clearColor]];
    copyLabel.textAlignment = NSTextAlignmentCenter;
    [copyLabel setFont:[UIFont systemFontOfSize:14]];
    copyLabel.text = @"Copyright © 2012 Cloay. All rights reserved.";
    
    self.tableView.tableFooterView = copyLabel;
    isNeedUpdate = YES;
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
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    int number = 0;
    switch (section) {
        case 0:
            number = 1;
            break;
        case 1:
            number = 1;
            break;
        case 2:
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
    
    UISwitch *switchBtn = [[UISwitch alloc] initWithFrame:CGRectMake(210, 8, 50, 25)];
    [switchBtn addTarget:self action:@selector(switchBtnValueChanged:) forControlEvents:UIControlEventValueChanged];
    [switchBtn setOn:YES];
    //读取用户设置的状态，如果没有设置，默认为打开YES
    if ([settings objectForKey:KNOTIFICATION]) {
        [switchBtn setOn:[settings boolForKey:KNOTIFICATION]];
    }

    switch (section) {
        case 0:
            cell.textLabel.text = @"分享";
            break;
        case 1:
            [cell setAccessoryType:UITableViewCellAccessoryNone];
            cell.textLabel.text = @"打开或关闭通知";
            [cell.contentView addSubview:switchBtn];
            break;
        case 2:
            if (row == 0) {
                cell.textLabel.text = @"用户反馈";
            }else if (row == 1){
                cell.textLabel.text = @"关于";
            }else{
                cell.textLabel.text = @"检查更新";
                if (!isNeedUpdate) {
                    cell.textLabel.text = @"当前版本已是最新版本！";
                }
            }
        default:
            break;
    }
    return cell;
}

- (IBAction)switchBtnValueChanged:(id)sender{
    UISwitch *switchBtn = (UISwitch *)sender;
    [settings setBool:switchBtn.isOn forKey:KNOTIFICATION];
    if (switchBtn.isOn) {//生成通知
        [NotificationUtil makeLocalNotification];
    }else{//关闭通知
        [NotificationUtil cancelLocalNotification];
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
            [self showShareList];
            break;
        case 1:
            break;
        case 2:
            if (row == 0) {
                [UMFeedback showFeedback:self withAppkey:UMKEY];
            }else if(row == 1){//关于
                AboutViewController *aboutView = [[AboutViewController alloc] initWithNibName:@"AboutViewController" bundle:nil];
                aboutView.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:aboutView animated:YES];
            }else{
                if (isNeedUpdate) {
                    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                    hud.labelText = @"正在检查更新...";
                    [MobClick checkUpdateWithDelegate:self selector:@selector(appUpdate:)];
                }
            }
        default:
            break;
    }
}
#pragma mark -
#pragma MobClickDelegate method
- (void)appUpdate:(NSDictionary *)appInfo{
    CLog(@"appinfo ---->%@", appInfo);
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    isNeedUpdate = [[appInfo objectForKey:@"update"] boolValue];
    if (isNeedUpdate) { //If has a new version
        NSString *update_log = [appInfo objectForKey:@"update_log"];
        itunesUrlStr = [appInfo objectForKey:@"path"];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Update" message:update_log delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Goto store", nil];
        [alert show];
    }else{
        [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:2 inSection:2]] withRowAnimation:UITableViewRowAnimationFade];
    }
}

#pragma mark
- (void)showShareList{
    NSString *shareText = @"我正在使用参考消息iphone版看新闻，很方便，你也试一下吧！";
    UIImage *shareImage = [UIImage imageNamed:@"share_image"];
    [UMSNSService showSNSActionSheetInController:self appkey:UMKEY status:shareText image:shareImage];
}

@end
