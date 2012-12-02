//
//  SettingsViewController.h
//  ReferenceNews
//
//  Created by cloay on 12-10-27.
//  Copyright (c) 2012年 Cloay. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingsViewController : UITableViewController{
    NSUserDefaults *settings;
    BOOL isNeedUpdate;
    NSString *itunesUrlStr;
}

@end
