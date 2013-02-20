//
//  HomeViewController.h
//  ReferenceNews
//
//  Created by cloay on 12-10-25.
//  Copyright (c) 2012年 Cloay. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *moreButton;
@property (weak, nonatomic) IBOutlet UIButton *mButton;
- (IBAction)homeButtonDidPressed:(id)sender;
@end
