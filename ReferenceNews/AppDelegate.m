//
//  AppDelegate.m
//  ReferenceNews
//
//  Created by cloay on 12-10-25.
//  Copyright (c) 2012年 Cloay. All rights reserved.
//

#import "AppDelegate.h"
#import "MobClick.h"
#import "NotificationUtil.h"
#import "HomeViewController.h"
#import "NewsViewController.h"

@implementation AppDelegate
@synthesize window;
//@synthesize tabBarController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    
    /*
    [tabBarController setSelectedIndex:0];
    self.window.rootViewController = tabBarController;*/
    
    HomeViewController *homeViewController = [[HomeViewController alloc] initWithNibName:@"HomeViewController" bundle:nil];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:homeViewController];
    UILocalNotification *notifi = [launchOptions objectForKey:UIApplicationLaunchOptionsLocalNotificationKey];
    if (notifi) {
        [application cancelAllLocalNotifications];
        application.applicationIconBadgeNumber = 0;
        
        NewsViewController *newsViewController = [[NewsViewController alloc] initWithNibName:@"NewsViewController" bundle:nil];
        [nav pushViewController:newsViewController animated:YES];
    }
    self.window.rootViewController = nav;
    [self.window makeKeyAndVisible];
    
    /*
     * version 1.0 Don't show ads.
     *
    GADInterstitial *splashInterstitial_ = [[GADInterstitial alloc] init];
    splashInterstitial_.adUnitID = ADUINTID;
    splashInterstitial_.delegate = self;
    [splashInterstitial_ loadAndDisplayRequest:[GADRequest request]
                                   usingWindow:self.window
                                  initialImage:[UIImage imageNamed:@"Default"]];
    */
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    [MobClick setAppVersion:version];
    [MobClick startWithAppkey:UMKEY reportPolicy:REALTIME channelId:nil];
    [MobClick checkUpdate];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    NSUserDefaults *settings = [NSUserDefaults standardUserDefaults];
    if ([settings objectForKey:KNOTIFICATION] == nil || [settings boolForKey:KNOTIFICATION]) {
        [NotificationUtil cancelLocalNotification]; //先清空旧的通知
        [NotificationUtil makeLocalNotification];
    }
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification{
    [application cancelAllLocalNotifications];
    application.applicationIconBadgeNumber = 0;

    NewsViewController *newsViewController = [[NewsViewController alloc] initWithNibName:@"NewsViewController" bundle:nil];
    [self.window.rootViewController.navigationController pushViewController:newsViewController animated:YES];
}

#pragma mark - GADInterstitial delegate method
- (void)interstitialDidReceiveAd:(GADInterstitial *)interstitial{
    if (interstitial.isReady) {
        [interstitial presentFromRootViewController:self.window.rootViewController];        
    }
}
@end
