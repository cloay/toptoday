//
//  Constant.h
//  ReferenceNews
//
//  Created by cloay on 12-10-27.
//  Copyright (c) 2012年 Cloay. All rights reserved.
//

#import <Foundation/Foundation.h>

#define CHINATAG 0
#define WORLDTAG 1
#define FINANCIALTAG 2
#define VIEWTAG 3
#define MILITARYTAG 4
#define TANWANTAG 5
#define SEECHINATAG 6
#define HOTNEWSTAG 7
#define SERVER @"http://app.cankaoxiaoxi.com"
#define UMKEY @"508d2a0d527015234e000010"
@interface Constant : NSObject

//获取标题
+ (NSString *)getTitleWithTag:(NSInteger)tag;

//获取分类url
+ (NSString *)getUrlWithTag:(NSInteger)tag;
@end
