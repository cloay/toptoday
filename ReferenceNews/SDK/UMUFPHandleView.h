//
//  UMUFPHandleView.h
//  UFP
//
//  Created by liu yu on 2/16/12.
//  Copyright (c) 2012 Realcent. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol UMUFPHandleViewDelegate;

typedef enum {
    ContentTypeApp = 0, //app list
    ContentTypeIconList = 1, //icon list
    ContentTypeDefault = ContentTypeApp,
} ContentType;

typedef enum {
    OrientationTypePortrait  = 0, 
    OrientationTypeLandscape,     
    OrientationTypeAll,
    OrientationTypeDefault = OrientationTypeAll,
} OrientationType;

@interface UMUFPHandleView : UIView {
@private
    ContentType _mContentType;
    id<UMUFPHandleViewDelegate> _delegate;
}

@property (nonatomic) BOOL  mAutoFill;
@property (nonatomic, copy) NSString *mKeywords; 
@property (nonatomic) ContentType mContentType;
@property (nonatomic) OrientationType mOrientationType;
@property (nonatomic, assign) id<UMUFPHandleViewDelegate> delegate; //delegate for banner view

/** 
 
 This method create and return a UMUFPHandleView object
 
 @param  frame frame for the UMUFPHandleView 
 @param  appkey appkey get from www.umeng.com
 @param  slotId slotId get from ufp.umeng.com
 @param  controller view controller releated to the view that the handle view added into
 
 @return a UMUFPHandleView object
 
*/

- (id)initWithFrame:(CGRect)frame appKey:(NSString *)appkey slotId:(NSString *)slotId currentViewController:(UIViewController *)controller;

/** 
 
 This method start the promoter data load in background, promoter data will be load until this method called
 
 */

- (void)requestPromoterDataInBackground;

/** 
 
 This method set a local background image for handle view, if not called, handle view load image set on the server
 
 */

- (void)setHandleViewBackgroundImage:(UIImage *)image;

/** 
 
 This method set channel for this app, the default channel is App Store, call this method if you want to set channel for another value, don't need to call this method among different views, only once is enough
 
 */

+ (void)setAppChannel:(NSString *)channel;

@end

@protocol UMUFPHandleViewDelegate <NSObject>

@optional

- (void)handleViewWillAppear:(UMUFPHandleView *)handleView; //called when handle will appear, implement this mothod if you want to change animation for the handle appear or do something else before handle appear

- (void)didClickHandleView:(UMUFPHandleView *)handleView; //for app, for ContentType is ContentTypeApp, implement this method if you want to handle handleview click event yourself, the default action is show app list in tableview

- (void)didClickHandleView:(UMUFPHandleView *)handleView urlToLoad:(NSURL *)url; //for wap, for ContentType is ContentTypeWap, implement this method if you want to handle handleview click event yourself, the default action is show app list in webview

- (void)didLoadDataFailWithError:(UMUFPHandleView *)handleView error:(NSError *)error; //call when promoter data load failed, default action is handleview will not shown

@end
