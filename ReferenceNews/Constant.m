//
//  Constant.m
//  ReferenceNews
//
//  Created by cloay on 12-10-27.
//  Copyright (c) 2012年 Cloay. All rights reserved.
//

#import "Constant.h"

@implementation Constant

/*
根据tag值获取相应标题
 @parm tag 
 */
+(NSString *)getTitleWithTag:(NSInteger)tag{
    NSString *title = @"";
    switch (tag) {
        case CHINATAG:
            title = @"国内焦点";
            break;
        case WORLDTAG:
            title = @"国际动态";
            break;
        case FINANCIALTAG:
            title = @"财经时讯";
            break;
        case MILITARYTAG:
            title = @"军事聚焦";
            break;
        case TANWANTAG:
            title = @"台海动态";
            break;
        case VIEWTAG:
            title = @"热门观点";
            break;
        case HOTNEWSTAG:
            title = @"今日头条";
            break;
        case SEECHINATAG:
            title = @"看中国";
            break;
        default:
            break;
    }
    return title;
}

/*
 根据不同分类的url
 @parm tag
 */
+ (NSString *)getUrlWithTag:(NSInteger)tag{
    NSString *urlStr = @"";
    switch (tag) {
        case CHINATAG:
            urlStr = [NSString stringWithFormat:@"%@/?app=rss&controller=index&action=feed&catid=1", SERVER];
            break;
        case WORLDTAG:
            urlStr = [NSString stringWithFormat:@"%@/?app=rss&controller=index&action=feed&catid=3", SERVER];
            break;
        case FINANCIALTAG:
            urlStr = [NSString stringWithFormat:@"%@/?app=rss&controller=index&action=feed&catid=14", SERVER];
            break;
        case MILITARYTAG:
            urlStr = [NSString stringWithFormat:@"%@/?app=rss&controller=index&action=feed&catid=29", SERVER];
            break;
        case TANWANTAG:
            urlStr = [NSString stringWithFormat:@"%@/?app=rss&controller=index&action=feed&catid=2", SERVER];
            break;
        case VIEWTAG:
            urlStr = [NSString stringWithFormat:@"%@/?app=rss&controller=index&action=feed&catid=37", SERVER];
            break;
        case SEECHINATAG:  //外国人看中国
            urlStr = [NSString stringWithFormat:@"%@/?app=rss&controller=index&action=feed&catid=52", SERVER];
            break;
        case HOTNEWSTAG:  //全部新闻
            urlStr = [NSString stringWithFormat:@"%@/?app=rss&controller=index&action=feed&catid=0", SERVER];
            break;
        default:
            break;
    }
    return urlStr;
}
@end
