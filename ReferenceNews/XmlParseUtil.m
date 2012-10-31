//
//  XmlParseUtil.m
//  ReferenceNews
//
//  Created by cloay on 12-10-30.
//  Copyright (c) 2012年 Cloay. All rights reserved.
//

#import "XmlParseUtil.h"
#import "News.h"

@implementation XmlParseUtil
@synthesize delegate;
- (id)initWithData:(NSData *)data{
    newsArray = [[NSMutableArray alloc] init];
    _data = data;
    value = @"";
    return self;
}

- (void)startParse{
    if (_data) {
        NSXMLParser *parser = [[NSXMLParser alloc] initWithData:_data];
        [parser setDelegate:self];
        value = @"";
        newsArray = [[NSMutableArray alloc] init];
        [parser parse];
    }
}

- (void)startParseWithData:(NSData *)data{
    NSXMLParser *parser = [[NSXMLParser alloc] initWithData:data];
    [parser setDelegate:self];
    value = @"";
    newsArray = [[NSMutableArray alloc] init];
    [parser parse];
}

#pragma mark - parse delegate

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict{
    if ([@"item" isEqualToString:elementName]) {
        newsDic = [[NSMutableDictionary alloc] init];
    }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{
    value = string;
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName{
    if ([@"title" isEqualToString:elementName]) {
        [newsDic setValue:value forKey:elementName];
    }else if ([@"link" isEqualToString:elementName]) {
        [newsDic setValue:value forKey:elementName];
    }else if ([@"description" isEqualToString:elementName]) {
        [newsDic setValue:value forKey:elementName];
    }else if ([@"pubDate" isEqualToString:elementName]) {
        [newsDic setValue:value forKey:elementName];
    }
    
    if ([@"item" isEqualToString:elementName]) {
        News *news = [[News alloc] initWithDictionary:newsDic];
        [newsArray addObject:news];
        newsDic = nil;
    }
    
    if ([@"channel" isEqualToString:elementName]) {//解析结束，返回上级调用
        if ([delegate respondsToSelector:@selector(xmlParseFinishedWithData:)]) {
            [delegate xmlParseFinishedWithData:newsArray];
        }
    }
    value = nil;
}
@end
