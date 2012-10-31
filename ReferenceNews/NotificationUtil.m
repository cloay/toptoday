//
//  NotificationUtil.m
//  ReferenceNews
//
//  Created by cloay on 12-10-27.
//  Copyright (c) 2012年 Cloay. All rights reserved.
//

#import "NotificationUtil.h"

@implementation NotificationUtil

//生成本地通知
+ (void)makeLocalNotification{
    //15 Just for test!
    NSDate *date = [NSDate dateWithTimeIntervalSinceNow:15];
    UILocalNotification *notifi = [[UILocalNotification alloc] init];
    if (notifi) {
        //提醒时间
        notifi.fireDate = date;
        notifi.timeZone = [NSTimeZone defaultTimeZone];
        //设置重复间隔，0表示不重复
        notifi.repeatInterval = NSQuarterCalendarUnit; //如果用户没有查看，每15分钟推送一次
        //推送声音
        notifi.soundName = UILocalNotificationDefaultSoundName;
        //推送信息
        notifi.alertBody = @"有新的新闻，点击确定查看详情！";
        
        //设置userInfo，作为通知的唯一表示
        //        NSString *activity_id = [NSString stringWithFormat:@"%i", activityId];
        //        NSDictionary *userInfo = [NSDictionary dictionaryWithObject:activity_id forKey:@"activityId"];
        //        notifi.userInfo = userInfo;
        
        //添加推送
        UIApplication *application = [UIApplication sharedApplication];
        //设置图标右上角小数字
        application.applicationIconBadgeNumber += 1;
        [application scheduleLocalNotification:notifi];
    }
}

//取消本地通知
+ (void)cancelLocalNotification{
    UIApplication *application = [UIApplication sharedApplication];
    application.applicationIconBadgeNumber = 0;
    [application cancelAllLocalNotifications];
}
@end