//
//  AboutUsViewController.m
//  ReferenceNews
//
//  Created by cloay on 12-12-3.
//  Copyright (c) 2012年 Cloay. All rights reserved.
//

#import "AboutUsViewController.h"
#import "MobClick.h"
#import "AHAlertView.h"

@interface AboutUsViewController ()

@end

@implementation AboutUsViewController

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
    self.title = @"关于";
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(103, 20, 114, 114)];
    [imageView setImage:[UIImage imageNamed:@"icon@2x.png"]];
    
    UIView *tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 150)];
    [tableHeaderView addSubview:imageView];
    self.tableView.tableHeaderView = tableHeaderView;
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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"AboutCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
        [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    }
    
    if (indexPath.row == 0) {
        [cell setAccessoryType:UITableViewCellAccessoryNone];
        cell.textLabel.text = @"版本号";
        NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
        cell.detailTextLabel.text = version;
    }else if (indexPath.row == 1) {
        cell.textLabel.text = @"声明";
    }else if (indexPath.row == 2) {
        cell.textLabel.text = @"检查更新";
        if (!isNeedUpdate) {
            cell.textLabel.text = @"当前版本已是最新版本！";
        }
    }
    
    return cell;
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
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if (indexPath.row == 1) {  //声明
        NSString *title = @"声明：";
        NSString *message = @"本应用中的内容均来自参考消息官网，不代表本人支持或赞成其观点。如有疑问请发送Email到:\n\n shangrody@gmail.com \n\n谢谢您的支持！";
        
        AHAlertView *alert = [[AHAlertView alloc] initWithTitle:title message:message];
//        [alert setCancelButtonTitle:@"确定" block:^{
//            alert.dismissalStyle = AHAlertViewDismissalStyleTumble;
//        }];
        [alert addButtonWithTitle:@"确定" block:^{
            alert.dismissalStyle = AHAlertViewDismissalStyleTumble;
        }];
        [self applyCustomAlertAppearance];
        [alert show];

    }else if(indexPath.row == 2){//检查更新
        if (isNeedUpdate) {
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            hud.labelText = @"正在检查更新...";
            [MobClick checkUpdateWithDelegate:self selector:@selector(appUpdate:)];
        }
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
        NSString *itunesUrlStr = [appInfo objectForKey:@"path"];
        AHAlertView *alert = [[AHAlertView alloc] initWithTitle:@"有新的版本" message:update_log];
        [alert setCancelButtonTitle:@"以后再说" block:^{
            alert.dismissalStyle = AHAlertViewDismissalStyleTumble;
        }];
        [alert addButtonWithTitle:@"更新" block:^{
            alert.dismissalStyle = AHAlertViewDismissalStyleZoomDown;
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:itunesUrlStr]];
        }];
        [self applyCustomAlertAppearance];
        [alert show];
    }else{
        [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:2 inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
    }
}

- (void)applyCustomAlertAppearance
{
	[[AHAlertView appearance] setContentInsets:UIEdgeInsetsMake(12, 18, 12, 18)];
	
	[[AHAlertView appearance] setBackgroundImage:[UIImage imageNamed:@"custom-dialog-background"]];
	
	UIEdgeInsets buttonEdgeInsets = UIEdgeInsetsMake(20, 8, 20, 8);
	
	UIImage *cancelButtonImage = [[UIImage imageNamed:@"custom-cancel-normal"]
								  resizableImageWithCapInsets:buttonEdgeInsets];
	UIImage *normalButtonImage = [[UIImage imageNamed:@"custom-button-normal"]
								  resizableImageWithCapInsets:buttonEdgeInsets];
    
	[[AHAlertView appearance] setCancelButtonBackgroundImage:cancelButtonImage
													forState:UIControlStateNormal];
	[[AHAlertView appearance] setButtonBackgroundImage:normalButtonImage
											  forState:UIControlStateNormal];
	
	[[AHAlertView appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                      [UIFont boldSystemFontOfSize:18], UITextAttributeFont,
                                                      [UIColor whiteColor], UITextAttributeTextColor,
                                                      [UIColor blackColor], UITextAttributeTextShadowColor,
                                                      [NSValue valueWithCGSize:CGSizeMake(0, -1)], UITextAttributeTextShadowOffset,
                                                      nil]];
    
	[[AHAlertView appearance] setMessageTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                    [UIFont systemFontOfSize:14], UITextAttributeFont,
                    [UIColor colorWithWhite:0.8 alpha:1.0], UITextAttributeTextColor,
                    [UIColor blackColor], UITextAttributeTextShadowColor,
                    [NSValue valueWithCGSize:CGSizeMake(0, -1)], UITextAttributeTextShadowOffset,
                    nil]];
    
	[[AHAlertView appearance] setButtonTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                            [UIFont boldSystemFontOfSize:14], UITextAttributeFont,
                                                            [UIColor whiteColor], UITextAttributeTextColor,
                                                            [UIColor blackColor], UITextAttributeTextShadowColor,
                                                            [NSValue valueWithCGSize:CGSizeMake(0, -1)], UITextAttributeTextShadowOffset,
                                                            nil]];
}
@end
