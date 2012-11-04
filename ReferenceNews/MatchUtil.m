//
//  MatchUtil.m
//  ReferenceNews
//
//  Created by cloay on 12-11-3.
//  Copyright (c) 2012年 Cloay. All rights reserved.
//

#import "MatchUtil.h"

@implementation MatchUtil

/**
 验证表单
 matched 待验证的数据
 match   正则
 */
+ (BOOL)isValidWitchMatch:(NSString *)matched toMatch:(NSString *)match{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", match];
    
    return [predicate evaluateWithObject:matched];
}


/*替换符合math的字符串
 @parms:
 matchString: 待匹配的字符串
 match:匹配规则
 repStr:要替换为的字符串
 return

+ (NSString *)stringReplaceWithMatchString:(NSString *)matchString match:(NSString *)match repStr:(NSString *)repStr{
    
    
    return nil;
} */

/*去除html标签
 @parm:
 originString: 原始字符串
 */

+ (NSString *)stringWithoutHtmltag:(NSString *)originString{
    //去掉<p>
    NSString *resultNoP = [originString stringByReplacingOccurrencesOfString:@"<p>" withString:@""];
    //去掉</p>
    resultNoP = [resultNoP stringByReplacingOccurrencesOfString:@"</p>" withString:@""];
    resultNoP = [resultNoP stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@""];
    resultNoP = [resultNoP stringByReplacingOccurrencesOfString:@"<a target='_blank' href='http://www.chinanews.com/' >" withString:@""];
    resultNoP = [resultNoP stringByReplacingOccurrencesOfString:@"<a target='_blank' href='http://www.chinanews.com/'>" withString:@""];
    resultNoP = [resultNoP stringByReplacingOccurrencesOfString:@"</a>" withString:@""];
    return resultNoP;
}

/*
 截取新闻原文
 @parm:
 originString:原始字符串
 */
+ (NSString *)stringNewsContent:(NSString *)originString{
    NSString *content = nil;
    NSRange startRange = [originString rangeOfString:@"来源："];
    if (startRange.location != NSNotFound) {
        NSRange endRange = [originString rangeOfString:@"到首页看看"];
        if (endRange.location != NSNotFound) {
            NSString *contentBeta = [originString substringWithRange:NSMakeRange(startRange.location, endRange.location - startRange.location)];
            NSRange endLink = [contentBeta rangeOfString:@"</span>"];
            NSString *fromWhere = [contentBeta substringWithRange:NSMakeRange(3, endLink.location + 4)];
            content = [contentBeta stringByReplacingOccurrencesOfString:fromWhere withString:@"参考消息网"];
        }
    }
    return content;
}
@end
