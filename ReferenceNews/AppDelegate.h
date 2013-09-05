//
//  AppDelegate.h
//  ReferenceNews
//
//  Created by cloay on 12-10-25.
//  Copyright (c) 2012年 Cloay. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GADInterstitial.h"
#import "jpush/APService.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate, GADInterstitialDelegate>

@property (strong, nonatomic)IBOutlet UIWindow *window;
//@property (strong, nonatomic)IBOutlet UITabBarController *tabBarController;
@end
