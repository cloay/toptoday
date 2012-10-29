//
//  News.m
//  ReferenceNews
//
//  Created by cloay on 12-10-29.
//  Copyright (c) 2012年 Cloay. All rights reserved.
//

#import "News.h"

@implementation News

@synthesize title, newsDate, summary, urlStr;


- (id)initWithDictionary:(NSDictionary *)dictionary{
    self = [super init];
    
    title = [dictionary objectForKey:@"title"];
    newsDate = [NSDate dateWithTimeIntervalSince1970:[[dictionary objectForKey:@"date"] integerValue]];
    summary = [dictionary objectForKey:@"summary"];
    urlStr = [dictionary objectForKey:@"url"];
    
    return self;
}
@end
