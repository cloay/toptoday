//
//  NewsViewController.m
//  ReferenceNews
//
//  Created by cloay on 12-10-28.
//  Copyright (c) 2012年 Cloay. All rights reserved.
//

#import "NewsViewController.h"
#import "News.h"
 
@interface NewsViewController ()

@end

@implementation NewsViewController

@synthesize tag;
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
    self.title = [Constant getTitleWithTag:self.tag];
    CLog(@"Url------>%@", [Constant getUrlWithTag:self.tag]);
    newsArray = [[NSMutableArray alloc] init];
    //获取新闻
    [self getNews];
}

- (void)getNews{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"正在加载...";
    NSURL *url = [NSURL URLWithString:[Constant getUrlWithTag:self.tag]];
    httpRequest = [ASIHTTPRequest requestWithURL:url];
    [httpRequest setDelegate:self];
    [httpRequest startAsynchronous];
}

- (void)dealloc{
    [httpRequest clearDelegatesAndCancel];
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

- (float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [newsArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CellNews";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    News *news = [newsArray objectAtIndex:[indexPath row]];
    cell.textLabel.text = news.title;
    cell.detailTextLabel.text = news.summary;
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
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

#pragma mark - ASIHTTPRequest delegate methods
- (void)requestFinished:(ASIHTTPRequest *)request{
    NSData *data = [[request responseString] dataUsingEncoding:NSUTF8StringEncoding];
    XmlParseUtil *parseUtil = [[XmlParseUtil alloc] initWithData:data];
    [parseUtil setDelegate:self];
    [parseUtil startParse];
}

- (void)requestFailed:(ASIHTTPRequest *)request{
    [MKInfoPanel showPanelInView:self.view type:MKInfoPanelTypeInfo title:@"提示" subtitle:@"加载数据失败，请稍后重试！" hideAfter:3];
}

#pragma mark - XmlParserUtil delegate
- (void)xmlParseFinishedWithData:(NSArray *)data{
    [newsArray addObjectsFromArray:data];
    [self.tableView reloadData];
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    [MKInfoPanel showPanelInView:self.view type:MKInfoPanelTypeInfo title:@"提示" subtitle:[NSString stringWithFormat:@"共有%i条新闻更新！", [data count]] hideAfter:3];
}
@end
