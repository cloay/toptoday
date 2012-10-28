//
//  NotificationUtil.h
//  ReferenceNews
//
//  Created by cloay on 12-10-27.
//  Copyright (c) 2012年 Cloay. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NotificationUtil : NSObject
//生成一个通知
+ (void)makeLocalNotification;

//取消通知
+ (void)cancelLocalNotification;
@end
