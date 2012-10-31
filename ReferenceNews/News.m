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
    newsDate = [dictionary objectForKey:@"pubDate"];
    summary = [dictionary objectForKey:@"description"];
    urlStr = [dictionary objectForKey:@"link"];
    
    return self;
}
@end
