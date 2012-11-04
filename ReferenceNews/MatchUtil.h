//
//  MatchUtil.h
//  ReferenceNews
//
//  Created by cloay on 12-11-3.
//  Copyright (c) 2012年 Cloay. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MatchUtil : NSObject

+ (BOOL)isValidWitchMatch:(NSString *)matched toMatch:(NSString *)match;

/*替换符合math的字符串
 @parms:
 matchString: 待匹配的字符串
 match:匹配规则
 repStr:要替换为的字符串
 return

+ (NSString *)stringReplaceWithMatchString:(NSString *)matchString match:(NSString *)match repStr:(NSString *)repStr;*/

/*去除html标签
 @parm:
 originString: 原始字符串
 */

+ (NSString *)stringWithoutHtmltag:(NSString *)originString;

/*
 截取新闻原文
 @parm:
 originString:原始字符串
 */
+ (NSString *)stringNewsContent:(NSString *)originString;
@end
