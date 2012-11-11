//
//  ChinaViewController.m
//  ReferenceNews
//
//  Created by cloay on 12-10-27.
//  Copyright (c) 2012年 Cloay. All rights reserved.
//

#import "ChinaViewController.h"
#import "News.h"
#import "DateUtil.h"
#import "MatchUtil.h"

@interface ChinaViewController ()

@end

@implementation ChinaViewController
@synthesize newsArray;

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
    
    refreshBtn = [[DAReloadActivityButton alloc] init];
    [refreshBtn addTarget:self action:@selector(refreshBtnDidTaped) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:refreshBtn];
    
    if (_refreshHeaderView == nil) {
		
		EGORefreshTableHeaderView *view = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0.0f - self.tableView.bounds.size.height, self.view.frame.size.width, self.tableView.bounds.size.height)];
		view.delegate = self;
		[self.tableView addSubview:view];
		_refreshHeaderView = view;
		
	}
    
    CLog(@"see_china_url------->%@", [Constant getTitleWithTag:SEECHINATAG]);
    self.newsArray = [[NSMutableArray alloc] init];
    
    //获取新闻
    [self getNews];
}

- (void)refreshBtnDidTaped{
    [refreshBtn startAnimating];
    [self getNews];
}

- (void)getNews{
    if (!isPullDown) {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.labelText = @"正在加载...";
    }
    
    NSURL *url = [NSURL URLWithString:[Constant getUrlWithTag:SEECHINATAG]];
    httpRequest = [ASIHTTPRequest requestWithURL:url];
    [httpRequest setDelegate:self];
    [httpRequest startAsynchronous];
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
    return [self.newsArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 1;
}

- (float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 90.0;
}

- (float)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 25;
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section{
    News *news = [newsArray objectAtIndex:section];
    NSString *title = [DateUtil getFormatDateWithString:news.newsDate withformat:@"EEE','d' 'MMM' 'yyyy' 'HH':'mm':'ss zzz"];
    return [NSString stringWithFormat:@"                                    %@", title];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CellChinaNews";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        [cell setBackgroundColor:[UIColor clearColor]];
        [cell.detailTextLabel setNumberOfLines:3];
    }
    
    // Configure the cell...
    News *news = [self.newsArray objectAtIndex:[indexPath section]];
    cell.textLabel.text = news.title;
    
    NSString *result = [MatchUtil stringWithoutHtmltag:news.summary];
    CLog(@"result----->%@", result);
    cell.detailTextLabel.text = result;
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
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    ContentViewController *detailViewController = [[ContentViewController alloc] initWithNibName:@"ContentViewController" bundle:nil];
    detailViewController.news = [newsArray objectAtIndex:[indexPath section]];
    detailViewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:detailViewController animated:YES];
}

#pragma mark - ASIHTTPRequest delegate methods
- (void)requestFinished:(ASIHTTPRequest *)request{
    NSData *data = [[request responseString] dataUsingEncoding:NSUTF8StringEncoding];
    XmlParseUtil *parseUtil = [[XmlParseUtil alloc] initWithData:data];
    [parseUtil setDelegate:self];
    [parseUtil startParse];
}

- (void)requestFailed:(ASIHTTPRequest *)request{
    [refreshBtn stopAnimating];
    isPullDown = NO;
    [self doneLoadingTableViewData];
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    [MKInfoPanel showPanelInView:self.view type:MKInfoPanelTypeError title:@"提示" subtitle:@"加载数据失败，请稍后重试！" hideAfter:3];
}

#pragma mark - XmlParserUtil delegate
- (void)xmlParseFinishedWithData:(NSArray *)data{
    if (refreshBtn.isAnimating) {
        [self.newsArray removeAllObjects];
    }
    [self.newsArray addObjectsFromArray:data];
    [self.tableView reloadData];
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    [refreshBtn stopAnimating];
    isPullDown = NO;
    [self doneLoadingTableViewData];
    [MKInfoPanel showPanelInView:self.view type:MKInfoPanelTypeInfo title:@"提示" subtitle:[NSString stringWithFormat:@"共有%i条新闻更新！", [data count]] hideAfter:3];
}

#pragma mark -
#pragma mark Data Source Loading / Reloading Methods

- (void)reloadTableViewDataSource{
	//  should be calling your tableviews data source model to reload
    isPullDown = YES;
    [self refreshBtnDidTaped];
}

- (void)doneLoadingTableViewData{
	
	//  model should call this when its done loading
    [self.tableView reloadData];
	[_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self.tableView];
	
}


#pragma mark -
#pragma mark UIScrollViewDelegate Methods

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
	
	[_refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
    
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
	
	[_refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
	
}


#pragma mark -
#pragma mark EGORefreshTableHeaderDelegate Methods

- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view{
	
	[self reloadTableViewDataSource];
	
}

- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view{
	
	return refreshBtn.isAnimating; // should return if data source model is reloading
	
}

- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view{
	
	return [NSDate date]; // should return date data source was last changed
	
}
@end
