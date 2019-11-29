//
//  HGHFunctionHttp.h
//  SDK_new_version
//
//  Created by Lucas on 2019/11/29.
//  Copyright © 2019 Lucas. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HGHFunctionHttp : NSObject
//账号注册
+(void)HGHAccountRegisterWithUserID:(NSString *)userID pwd:(NSString *)pwd ifSuccess:(void(^)(id response))success failure:(void(^)(NSError *error))failure;
//手机注册
+(void)HGHPhoneRegisterWithPhoneno:(NSString *)phoneNO code:(NSString *)code pwd:(NSString *)pwd ifSuccess:(void(^)(id response))success failure:(void(^)(NSError *error))failure;
//登录
+(void)HGHLoginUserID:(NSString *)userID pwd:(NSString *)pwd type:(NSString *)type phoneNO:(NSString *)phoneNO ifSuccess:(void(^)(id response))success failure:(void(^)(NSError *error))failure;
//短信验证码
+(void)HGHGetCaptcha:(NSString)
@end

NS_ASSUME_NONNULL_END
