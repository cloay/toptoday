//
//  SettingsViewController.m
//  ReferenceNews
//
//  Created by cloay on 12-10-27.
//  Copyright (c) 2012年 Cloay. All rights reserved.
//

#import "SettingsViewController.h"
#define KNOTIFICATION @"SwitchStatus"
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
    copyLabel.text = @"Copyright © 2012 Cloay. All Rights Reserved.";
    
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
    return 3;
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
            number = 1;
            break;
        case 2:
            number = 2;
            break;
        default:
            break;
    }
    return number;
}

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
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"SettingsCellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
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
            if (row == 0) {
                cell.textLabel.text = @"分享";
            }else{
                cell.textLabel.text = @"账号绑定";
                cell.detailTextLabel.text = @"设置";
            }
            break;
        case 1:
            cell.textLabel.text = @"打开或关闭通知";
            [cell.contentView addSubview:switchBtn];
            break;
        case 2:
            if (row == 0) {
                cell.textLabel.text = @"用户反馈";
            }else{
                cell.textLabel.text = @"关于";
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
        
    }else{//关闭通知
        
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
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

@end
