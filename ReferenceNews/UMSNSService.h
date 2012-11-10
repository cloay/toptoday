//
//  UMSNSService.h
//  SNS
//
//  Created by liu yu on 9/15/11.
//  Copyright 2011 Realcent. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@protocol UMSNSOauthDelegate;
@protocol UMSNSDataSendDelegate;
@protocol UMSNSViewDisplayDelegate;
@protocol UMSNSShowActionSheetDelegate;

/*
 All the possible returned result after share to the sns platform
 */

typedef enum {
    UMReturnStatusTypeUpdated = 0,			//成功发送一条微博
    UMReturnStatusTypeRepeated,				//短时间内重复发送微博
    UMReturnStatusTypeFileToLarge,			//发送的图片过大，超过微博平台限制，一般限制在2M以内
    UMReturnStatusTypeExtendSendLimit,		//发送次数超过每小时发送次数限制
	UMReturnStatusTypeAccessTokenInvalid,	//accessToken过期
    UMReturnStatusTypeUnknownError			//发送网络错误，或者其他错误
} UMReturnStatusType;

/*
 All the supported platform currently
 */

typedef enum {
    UMShareToTypeSina = 0,              //新浪微博
    UMShareToTypeTenc,                  //腾讯微博
    UMShareToTypeRenr,                  //人人网
    UMShareToTypeCount                  //count the number of sns,now is 3
} UMShareToType;

/**
 此SDK中用到的一些枚举类型
 
 ## 分享平台类型
 
     typedef enum {
     UMShareToTypeSina = 0,              //新浪微博
     UMShareToTypeTenc,                  //腾讯微博
     UMShareToTypeRenr,                  //人人网
     UMShareToTypeCount                  //count the number of sns,now is 3
     } UMShareToType;

 ## 分享完成状态
 
     typedef enum {
     UMReturnStatusTypeUpdated = 0,			//成功发送一条微博
     UMReturnStatusTypeRepeated,				//短时间内重复发送微博
     UMReturnStatusTypeFileToLarge,			//发送的图片过大，超过微博平台限制，一般限制在2M以内
     UMReturnStatusTypeExtendSendLimit,		//发送次数超过每小时发送次数限制
     UMReturnStatusTypeAccessTokenInvalid,	//accessToken过期
     UMReturnStatusTypeUnknownError			//发送网络错误，或者其他错误
     } UMReturnStatusType;

 */

@interface UMSNSService : NSObject


///---------------------------------------
/// @name 设置delegate对象
///---------------------------------------


/**  
 设置授权代理对象
 
 @param delegate 代理对象
 */
+ (void) setOauthDelegate:(id<UMSNSOauthDelegate>)delegate;

/**  
 设置数据发送代理对象
 
 @param delegate 数据发送代理对象
 */
+ (void) setDataSendDelegate:(id<UMSNSDataSendDelegate>)delegate;

/** 
 设置分享配置的代理对象
 
 @param delegate 设置分享设置的代理对象 
 */
+ (void) setViewDisplayDelegate:(id<UMSNSViewDisplayDelegate>)delegate;


/**  
 设置弹出sns列表ActionSheet的代理对象
 
 @param delegate 实现了`UMSNSShowActionSheetDelegate`协议的对象
 */
+ (void) setUMSNSActionSheetDelegate:(id<UMSNSShowActionSheetDelegate>)delegate;

#pragma mark -
#pragma mark - show UIActionSheet

///---------------------------------------
/// @name 弹出sns列表的UIActionSheet
///---------------------------------------


/**  
 在传入的UIViewController上弹出一个分享列表UIActionSheet
 
 @param  controller 要在上面显示的UIViewController
 @param  appkey     从友盟网站上得到的appkey
 @param  status     出现在分享编辑页面的内嵌文字
 @param  image      分享的图片，可以传nil
 */
+(void) showSNSActionSheetInController:(UIViewController *)controller
                                appkey:(NSString *)appkey
                                status:(NSString *)status
                                 image:(UIImage *)image;
    
/**  
 在传入的UIViewController上弹出一个分享列表UIActionSheet
 
 @param  controller       要在上面显示的UIViewController
 @param  appkey           从友盟网站上得到的appkey
 @param  contentTemplate  在友盟网站上设置的模板NSDictionary，例如你传入的两个key和对应的value，出现的内嵌文字就会按照你在友盟网站上出现的组织方式，例如网站上设置的模板为我正在听{song}… {}内是key，这里传入NSDictionary里面key为对应的值，value为@"Viva La Vida",出现效果是：我正在听Viva La Vida…
 @param  image            分享的图片，可以传nil
 */
+(void) showSNSActionSheetInController:(UIViewController *)controller
                                appkey:(NSString *)appkey
                       contentTemplate:(NSDictionary *)contentTmplate
                                 image:(UIImage *)image;
    

#pragma mark - present UIViewController

/**  
 弹出指定平台的分享编辑页面
 
 @param  controller 要在上面显示分享编辑页面的UIViewController
 @param  appkey     友盟网站上得到的appkey
 @param  status     分享编辑页面的内嵌文字
 @param  image      分享的图片，可以传nil
 @param  platform   要分享到的平台类型，例如UMShareToTypeRenr, UMShareToTypeSina, UMShareToTypeTenc其中一个
 */
+(void) presentSNSInController:(UIViewController *)controller
                        appkey:(NSString *)appkey
                        status:(NSString *)status
                         image:(UIImage *)image
                      platform:(UMShareToType)platform;


/** 
 传入一个模板NSDictionary来弹出一个指定分享平台的分享编辑页面
 
 @param  controller 要在上面显示分享编辑页面的UIViewController
 @param  appkey     友盟网站上得到的appkey
 @param  contentTemplate    在友盟网站上设置的模板NSDictionary，例如你传入的两个key和对应的value，出现的内嵌文字就会按照你在友盟网站上出现的组织方式
 @param  image              分享的图片，可以传nil
 @param  platform           要分享到的平台类型，例如UMShareToTypeRenr, UMShareToTypeSina, UMShareToTypeTenc其中一个
 */
+ (void) presentSNSInController:(UIViewController *)controller
                         appkey:(NSString *)appkey
                contentTemplate:(NSDictionary *)contentTemplate
                          image:(UIImage *)image
                       platform:(UMShareToType)platform;


/**  
 弹出一个指定平台的授权页面
 
 @param  controller  要在上面显示授权页面的UIViewController
 @param  appkey      友盟网站上得到的appkey
 @param  platform    要分享到的平台类型，例如UMShareToTypeRenr, UMShareToTypeSina, UMShareToTypeTenc其中一个
 */
+ (void) oauthInController:(UIViewController *)viewController
                    appkey:(NSString *)appkey
                  platform:(UMShareToType)platform;
#pragma mark -
#pragma mark - Data Interface

///---------------------------------------
/// @name 数据层接口
///---------------------------------------


/** 
 直接发送微博到指定平台
 
 @param  appkey     从友盟网站得到appkey
 @param  status     将要分享的文字内容
 @param  image      分享的图片，可以传nil 
 @param  uid        分享要用到的相应平台用户的uid
 @param  platform   要分享到的平台类型，例如UMShareToTypeRenr, UMShareToTypeSina, UMShareToTypeTenc其中一个
 @param  error      出现错误的error对象
 
 @return UMReturnStatusType 返回成功或者失败类型
 */
+ (UMReturnStatusType) updateStatusWithAppkey:(NSString *)appkey
                                       status:(NSString *)status
                                        image:(UIImage *)image
                                          uid:(NSString *)uid
                                     platform:(UMShareToType)platform
                                  error:(NSError *)error;

/** 
 使用内容模板的内容，来发送微博到指定平台
 
 @param  appkey           从友盟网站得到appkey
 @param  contentTemplate  在友盟网站上设置的模板NSDictionary，例如你传入的两个key和对应的value，分享文字就会按照你在友盟网站上出现的组织方式
 @param  image            分享的图片，可以传nil 
 @param  uid              分享要用到的相应平台用户的uid
 @param  platform         要分享到的平台类型，例如UMShareToTypeRenr, UMShareToTypeSina, UMShareToTypeTenc其中一个
 @param  error            出现错误的error对象
 
 @return UMReturnStatusType 返回成功或者失败类型
 */
+ (UMReturnStatusType) updateStatusWithAppkey:(NSString *)appkey
                              contentTemplate:(NSDictionary *)contentTemplate
                                        image:(UIImage *)image
                                          uid:(NSString *)uid
                                     platform:(UMShareToType)platform
                                        error:(NSError *)error;

#pragma mark -
#pragma mark - Other Utils Interface

///---------------------------------------
/// @name 其他方法
///---------------------------------------

/**  
 返回微博的热门话题
 
 @param  platform     要获取话题的微博平台
 @param  appkey       从友盟网站得到appkey
 @param  uid          分享要用到的相应平台用户的uid
 @param  error        出现错误的error对象
 
 @return NSArray     得到的话题数组，如果数组为空出现错误
 */
+ (NSArray *)  getTopicListWithPlatform:(UMShareToType)platform
                         appkey:(NSString *)appkey
                            uid:(NSString *)uid
                          error:(NSError *)error;

/** 
 返回你从友盟网站上设置的内容模板字符串
 
 @param  appkey       从友盟网站得到appkey
 @param  platform     要分享到的平台类型，例如UMShareToTypeRenr, UMShareToTypeSina, UMShareToTypeTenc其中一个
 @param  error        出现错误的error对象
 
 @return NSString 你在友盟网站上设置的内容模板字符串
 */
+ (NSString *) getContentTemplateWithAppkey:(NSString *)appkey
                                   platform:(UMShareToType)platform
                                      error:(NSError *)error;

/** 
 返回指定平台授权之后的uid字符串
 
 @param  appkey        从友盟网站得到appkey
 @param  platform      平台类型，例如UMShareToTypeRenr, UMShareToTypeSina, UMShareToTypeTenc其中一个
 @param  error         出现错误的error对象
 
 @return 用户的uid字符串，如果为nil则出现错误
 */
+ (NSString *) getUidWithAppkey:(NSString *)appkey
                       platform:(UMShareToType)platform
                          error:(NSError *)error;


/**  
 返回指定平台用户的昵称
 
 @param  appkey        从友盟网站得到appkey
 @param  uid           该用户的uid
 @param  platform      平台类型，例如UMShareToTypeRenr, UMShareToTypeSina, UMShareToTypeTenc其中一个
 @param  error         出现错误的error对象
 
 @return 用户昵称
 */
+ (NSString *) getNicknameWithAppkey:(NSString *)appkey
                                 uid:(NSString *)uid
                            platform:(UMShareToType)platform
                               error:(NSError *)error;

/** 
 发送私信到另外一个用户
 
 @param  appkey        友盟appkey
 @param  uid           发私信用户的uid号
 @param  invitedUid    接收用户的uid号
 @param  inviteContent 私信内容
 @param  platform      平台类型，例如UMShareToTypeRenr, UMShareToTypeSina, UMShareToTypeTenc其中一个
 @param  error         出现错误的error对象
 
 @return UMReturnStatusType 返回状态类型
 */
+ (UMReturnStatusType) sendInvitationWithAppkey:(NSString *)appkey
                                    uid:(NSString *)uid
                             invitedUid:(NSString *)invitedUid
                          inviteContent:(NSString *)inviteContent
                               platform:(UMShareToType)platform
                                  error:(NSError *)error;


/**  
 获取本地的accessToken
 
 @param  platform      平台类型，例如UMShareToTypeRenr, UMShareToTypeSina, UMShareToTypeTenc其中一个
 
 @return 返回的accessToken`NSDictionary`
 */
+ (NSDictionary *) getAccessToken:(UMShareToType)platform;


/** 
 解授权指定平台
 
 @param  platform      平台类型，例如UMShareToTypeRenr, UMShareToTypeSina, UMShareToTypeTenc其中一个
 */
+ (void) writeOffAccounts:(UMShareToType)platform;


/** 
 
 从本地获得指定平台用户的uid
 
 @param  platform      平台类型，例如UMShareToTypeRenr, UMShareToTypeSina, UMShareToTypeTenc其中一个
 */
+ (NSString *) getLocalUid:(UMShareToType)platform;


/**  
 返回SDK的版本号
 
 @return SDK版本号
 */
+ (NSString *) currentSDKVersion;

///---------------------------------------
/// @name 用户好友相关api
///---------------------------------------


#pragma mark - friendship releated
/** 
 返回用户好友列表
 
 @param  appkey        友盟appkey
 @param  platform      平台类型
 @param  uid           所查询好友用户的uid号
 @param  error         错误信息
 
 @return 返回好友列表
 */
+ (NSDictionary *) getFriendsListWithAppkey:(NSString *)appkey
                                   platform:(UMShareToType)platform
                                        uid:(NSString *)uid
                                      error:(NSError *)error;


/**  
 查询两个用户之间的关系
 
 @param  appkey        友盟appkey
 @param  platform      平台类型
 @param  uid           所查询好友用户的uid号
 @param  anotherUid    另外一个用户的uid号
 @param  error         错误信息
 
 @return 返回关系字符串
 */
+ (NSString *) getFriendshipWithAppkey:(NSString *)appkey
                              platform:(UMShareToType)platform
                                   uid:(NSString *)uid
                            anotherUid:(NSString *)anotherUid
                                 error:(NSError *)error;

/**  
 创建两个用户间的关系
 
 @param  appkey        友盟appkey
 @param  platform      平台类型
 @param  uid           一个用户的uid
 @param  anotherUid    另外一个用户的uid
 @param  error         错误信息
 
 @return result, nil when error occured
 */
+ (NSString *) createFriendshipWithAppkey:(NSString *)appkey
                                 platform:(UMShareToType)platform
                                      uid:(NSString *)uid
                               anotherUid:(NSString *)anotherUid
                                    error:(NSError *)error;


@end

#pragma mark -
#pragma mark - Protocol definition

/** 
 这个Delegate主要用在设置分享编辑页面的一些配置
 
 */

@protocol UMSNSViewDisplayDelegate <NSObject> 

@optional

/** 
 设置是否显示插入话题
 
 @param 平台类型
 
 @return 设置是否插入话题
 */
- (BOOL)insertTopicEnabled:(UMShareToType)platform;


/** 
 设置是否显示@好友
 
 @param 平台类型
 
 @return 设置是否显示@好友
 */
- (BOOL)atSomebodyEnabled:(UMShareToType)platform;


/** 
 设置是否插入表情
 
 @param 平台类型
 
 @return 设置是否插入表情
 */
- (BOOL)insertEmotionEnabled:(UMShareToType)platform;


/** 
 设置是否显示私信
 
 @param 平台类型
 
 @return 设置是否显示私信
 */
- (BOOL)priviteMessageEnabled:(UMShareToType)platform;


/**  
 设置是否开启检查字数
 
 @param 平台类型
 
 @return 设置是否开启检查字数
 */
- (BOOL)textCountCheckEnabled:(UMShareToType)platform;

/**  
 自定义UINavigationBar
 
 @param navBar 在SDK中用到的UINavigationBar
 @param viewController_  所在的UIViewController
 
 */
- (void)customNavigationBar:(UINavigationBar *)navBar withViewController:(UIViewController *)viewController_;
/**  
 自定义UINavigationBar中的label
 
 @param label_ UINavigationBar内显示的label
 
 */
- (void)customNavigationBarTitleView:(UILabel *)label_;
@end


/**
 
 授权协议
 
 */

@protocol UMSNSOauthDelegate <NSObject> 

@optional

/**
 授权完成，得到uid和token等
 
 @param uid 授权后的uid号
 @param accessToken 授权后得到的accessToken
 @param platform 平台类型
 */
- (void)oauthDidFinish:(NSString *)uid andAccessToken:(NSDictionary *)accessToken andPlatformType:(UMShareToType)platform;


/**  
 授权失败回调函数
 
 @param error 失败信息
 @param platform 平台类型
 */
- (void)oauthDidFailWithError:(NSError *)error andPlatformType:(UMShareToType)platform;

@end


/** 
 发送数据协议
 
 */
@protocol UMSNSDataSendDelegate <NSObject> 

@optional

/** 
 成功发送数据的回调函数
 
 @param viewController 发送数据的UIViewController
 @param returnStatus 发送的返回类型
 @param platform 发送平台类型
 */
- (void)dataSendDidFinish:(UIViewController *)viewController andReturnStatus:(UMReturnStatusType)returnStatus andPlatformType:(UMShareToType)platform;

/** 
 发送数据失败的回调函数
 
 @param error 错误信息
 @param platform 平台类型
 */
- (void)dataSendFailWithError:(NSError *)error andPlatformType:(UMShareToType)platform;

/** 
 发送私信内容
 
 @param  platform 平台类型
 
 @result 要发送私信的内容 
 */
- (NSString *)invitationContent:(UMShareToType)platform;


/**  
 设置是否显示app信息
 
 @param  platform 平台类型
 
 @result 是否显示平台类型
 */
- (BOOL)shouldShowAppInfor:(UMShareToType)platform;


/**  
 设置app的微博账号信息，必须包含下面字段@"name", @"location", @"description", @"uid"，uid号可以用来被用户添加官方微博
 
 @param  platform 平台类型
 
 @result appinfo, 设置的app微博信息
 */
- (NSDictionary *)appInfor:(UMShareToType)platform;


/** 
 当分享编辑页面出现时候调用该方法
 
 @param status 分享编辑页面的内嵌分享文字
 */
- (void)willSendStatus:(NSString *)status;

@end

/** 
 该代理协议，设置弹出的UIActionSheet中出现哪些sns平台
 
 */
@protocol UMSNSShowActionSheetDelegate <NSObject>

/**  
 设置出现的sns平台
 
 @param platform    要设置的sns平台
 @result            设置是否出现
 */
- (BOOL)shouldShowInActionSeet:(UMShareToType)platform;

@end