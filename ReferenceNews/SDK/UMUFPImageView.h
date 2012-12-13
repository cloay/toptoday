//
//  UMUFPImageView.h
//  UFP
//
//  Created by liu yu on 1/17/12.
//  Copyright (c) 2012 Realcent. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol delegate;

@interface UMUFPImageView : UIImageView {
@private
    NSURL   *_imageURL;
    UIImage *_placeholderImage;
    
    id<delegate> _dataLoadDelegate;
}

- (id)initWithPlaceholderImage:(UIImage*)anImage;

@property(nonatomic, retain) NSURL   *imageURL;
@property(nonatomic, retain) UIImage *placeholderImage;
@property(nonatomic, assign) id<delegate> dataLoadDelegate;

@end

@protocol delegate <NSObject>

@optional

- (void)didLoadFinish:(UMUFPImageView *)imageview; //releated image load finished
- (void)didLoadFailed:(UMUFPImageView *)imageview; //releated image load failed

@end