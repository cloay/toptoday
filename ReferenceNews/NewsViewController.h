//
//  NewsViewController.h
//  ReferenceNews
//
//  Created by cloay on 12-10-28.
//  Copyright (c) 2012年 Cloay. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewsViewController : UITableViewController
//新闻类别，根据类别获取相应的新闻列表
@property (nonatomic, assign) NSInteger tag;
@end
