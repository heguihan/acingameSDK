//
//  HGHFunctionHttp.h
//  SDK_new_version
//
//  Created by Lucas on 2019/11/29.
//  Copyright © 2019 Lucas. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HGHUserInfo.h"
#import "HGHDeviceInfo.h"
#import "HGHOrderInfo.h"
NS_ASSUME_NONNULL_BEGIN





@interface HGHFunctionHttp : NSObject
//账号注册
+(void)HGHAccountRegisterWithUserID:(NSString *)userID pwd:(NSString *)pwd ifSuccess:(void(^)(id response))success failure:(void(^)(NSError *error))failure;
//手机注册
+(void)HGHPhoneRegisterWithPhoneno:(NSString *)phoneNO code:(NSString *)code pwd:(NSString *)pwd ifSuccess:(void(^)(id response))success failure:(void(^)(NSError *error))failure;
//登录
+(void)HGHLoginUserID:(NSString *)userID pwd:(NSString *)pwd type:(NSString *)type phoneNO:(NSString *)phoneNO ifSuccess:(void(^)(id response))success failure:(void(^)(NSError *error))failure;
//游客登录
+(void)HGHLoginDevice:(NSString *)device ifSuccess:(void(^)(id response))success failure:(void(^)(NSError *error))failure;
//短信验证码
+(void)HGHGetCaptchaPhoneNO:(NSString *)phoneNO action:(NSString *)action ifSuccess:(void(^)(id response))success failure:(void(^)(NSError *error))failure;
//修改密码
+(void)HGHChangePwd:(NSString *)pwd code:(NSString *)code phoneNO:(NSString *)phoneNO ifSuccess:(void(^)(id response))success failure:(void(^)(NSError *error))failure;
//绑定手机号
+(void)HGHBindPwd:(NSString *)pwd code:(NSString *)code phoneNO:(NSString *)phoneNO userID:(NSString *)userID ifSuccess:(void(^)(id response))success failure:(void(^)(NSError *error))failure;
//用户信息上报
+(void)HGHUserrportWithID:(NSString *)ID userInfo:(HGHUserInfo *)userInfo ifSuccess:(void(^)(id response))success failure:(void(^)(NSError *error))failure;
//设备信息上报
+(void)HGHDeviceReport:(HGHDeviceInfo *)deviceInfo userID:(NSString *)userID ifSuccess:(void(^)(id response))success failure:(void(^)(NSError *error))failure;
//下单
+(void)HGHGetOrder:(HGHOrderInfo *)orderInfo ifSuccess:(void(^)(id response))success failure:(void(^)(NSError *error))failure;
//实名认证
+(void)HGHRenzhengWithUserName:(NSString *)userName idCardNumber:(NSString *)idcardNumber ifSuccess:(void(^)(id response))success failure:(void(^)(NSError *error))failure;
@end

NS_ASSUME_NONNULL_END
