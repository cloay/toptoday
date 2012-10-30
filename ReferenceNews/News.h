//
//  News.h
//  ReferenceNews
//  新闻实体类，包含新闻标题、新闻日期、新闻概要、全文url
//  Created by cloay on 12-10-29.
//  Copyright (c) 2012年 Cloay. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface News : NSObject

//新闻标题
@property (nonatomic, readonly) NSString *title;

//新闻日期
@property (nonatomic, readonly) NSString *newsDate;

//概要
@property (nonatomic, readonly) NSString *summary;

//新闻全文Url
@property (nonatomic, readonly) NSString *urlStr;


- (id)initWithDictionary:(NSDictionary *)dictionary;
@end
