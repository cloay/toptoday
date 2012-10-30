//
//  XmlParseUtil.h
//  ReferenceNews
//  xml文件解析类
//  Created by cloay on 12-10-30.
//  Copyright (c) 2012年 Cloay. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol XmlParseUtilDelegate;
@interface XmlParseUtil : NSObject<NSXMLParserDelegate>{
    NSMutableArray *newsArray;
    NSData *_data;
    NSString *value;
    NSMutableDictionary *newsDic;
}

@property (nonatomic, strong) id<XmlParseUtilDelegate> delegate;

- (id)initWithData:(NSData *)data;

//开始解析
- (void)startParse;
//开始解析，必须初始化data
- (void)startParseWithData:(NSData *)data;
@end

@protocol XmlParseUtilDelegate <NSObject>

- (void)xmlParseFinishedWithData:(NSArray *)data;

@end