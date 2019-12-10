//
//  HGHFunctionHttp.m
//  SDK_new_version
//
//  Created by Lucas on 2019/11/29.
//  Copyright © 2019 Lucas. All rights reserved.
//

#import "HGHFunctionHttp.h"
#import "HGHHttpRequest.h"
#import "HGHSDKConfig.h"
#import "HGHTools.h"
//http://fshuet.acingame.com/
//#define URL_DOMAIN @"https://zhijie.acingame.com/"
//#define URL_DOMAIN @"http://fshuet.acingame.com/"
#define URL_DOMAIN @"http://192.168.1.87:8082/"
#define URL_REGISTER @"register/"
#define URL_LOGIN @"login/"
#define URL_SENDMSG @"sendSMS/"
#define URL_CHANGEPWD @"update/"
#define URL_BIND @"bind/"
#define URL_USERREPORT @"api/analytics/userLog/report/"
#define URL_DEVICEREPORT @"api/other/device/report/"
#define URL_GETORDER @"requestPay/"
#define URL_RENZHENG @"api/auth/idCard/"
#define URL_RECIEPT @"paycallback/"
#define URL_INIT @"channelPay/"
@implementation HGHFunctionHttp
//账号注册
+(void)HGHAccountRegisterWithUserID:(NSString *)userID pwd:(NSString *)pwd ifSuccess:(void(^)(id response))success failure:(void(^)(NSError *error))failure
{
    NSString *url = [NSString stringWithFormat:@"%@%@%@",URL_DOMAIN,URL_REGISTER,[HGHSDKConfig currentAppID]];
    NSDictionary *dict =@{@"type":@"2",
                          @"pwd":[HGHTools md5String:pwd],
                          @"userID":userID,
                          @"channelID":[HGHSDKConfig currentChannelID],
                          @"ts":[HGHTools getCurrentTimeString]
                          };
    NSMutableDictionary *mutabDict = [[NSMutableDictionary alloc]initWithDictionary:dict];
    NSString *sortStr = [HGHTools sortHttpString:mutabDict];
    NSString *signStr = [NSString stringWithFormat:@"%@&key=%@",sortStr,[HGHSDKConfig currentAppKey]];
    NSString *sign = [HGHTools md5String:signStr];
    [mutabDict setObject:sign forKey:@"sign"];
    [HGHHttpRequest POSTNEW:url paramString:[mutabDict copy] ifSuccess:^(id  _Nonnull response) {
        NSLog(@"account register response=%@",response);
        success(response);
    } failure:^(NSError * _Nonnull error) {
        NSLog(@"error=%@",error);
        failure(error);
    }];

}
//手机注册
+(void)HGHPhoneRegisterWithPhoneno:(NSString *)phoneNO code:(NSString *)code pwd:(NSString *)pwd ifSuccess:(void(^)(id response))success failure:(void(^)(NSError *error))failure
{
    NSString *url = [NSString stringWithFormat:@"%@%@%@",URL_DOMAIN,URL_REGISTER,[HGHSDKConfig currentAppID]];
    NSDictionary *dict = @{@"type":@"1",
                           @"phoneNumber":phoneNO,
                           @"pwd":[HGHTools md5String:pwd],
                           @"code":code,
                           @"channelID":[HGHSDKConfig currentChannelID],
                           @"ts":[HGHTools getCurrentTimeString]
                           };
    NSMutableDictionary *mutabDict = [[NSMutableDictionary alloc]initWithDictionary:dict];
    NSString *sortStr = [HGHTools sortHttpString:mutabDict];
    NSString *signStr = [NSString stringWithFormat:@"%@&key=%@",sortStr,[HGHSDKConfig currentAppKey]];
    NSString *sign = [HGHTools md5String:signStr];
    [mutabDict setObject:sign forKey:@"sign"];
    [HGHHttpRequest POSTNEW:url paramString:[mutabDict copy] ifSuccess:^(id  _Nonnull response) {
        NSLog(@"account register response=%@",response);
        success(response);
    } failure:^(NSError * _Nonnull error) {
        NSLog(@"error=%@",error);
        failure(error);
    }];
}
//登录
+(void)HGHLoginUserID:(NSString *)userID pwd:(NSString *)pwd type:(NSString *)type phoneNO:(NSString *)phoneNO ifSuccess:(void(^)(id response))success failure:(void(^)(NSError *error))failure
{
    NSString *url = [NSString stringWithFormat:@"%@%@%@",URL_DOMAIN,URL_LOGIN,[HGHSDKConfig currentAppID]];
    NSDictionary *dict = @{@"type":type,
                           @"phoneNumber":phoneNO,
                           @"pwd":[HGHTools md5String:pwd],
                           @"userID":userID,
                           @"channelID":[HGHSDKConfig currentChannelID],
                           @"ts":[HGHTools getCurrentTimeString]
                           };
    NSMutableDictionary *mutabDict = [[NSMutableDictionary alloc]initWithDictionary:dict];
    NSString *sortStr = [HGHTools sortHttpString:mutabDict];
    NSString *signStr = [NSString stringWithFormat:@"%@&key=%@",sortStr,[HGHSDKConfig currentAppKey]];
    NSString *sign = [HGHTools md5String:signStr];
    [mutabDict setObject:sign forKey:@"sign"];
    
    [HGHHttpRequest POSTNEW:url paramString:[mutabDict copy] ifSuccess:^(id  _Nonnull response) {
        NSLog(@"response=%@",response);
        success(response);
        NSString *userID = response[@"userID"];
        [[NSUserDefaults standardUserDefaults] setObject:userID forKey:@"pandasUserID"];
        [[NSUserDefaults standardUserDefaults] setObject:[response objectForKey:@"yingID"] forKey:@"pandasYingID"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    } failure:^(NSError * _Nonnull error) {
        NSLog(@"error=%@",error);
        failure(error);
    }];
}

//游客登录
+(void)HGHLoginDevice:(NSString *)device ifSuccess:(void(^)(id response))success failure:(void(^)(NSError *error))failure
{
    NSString *url = [NSString stringWithFormat:@"%@%@%@",URL_DOMAIN,URL_REGISTER,[HGHSDKConfig currentAppID]];
    NSDictionary *dict = @{@"type":@"3",
                           @"deviceID":device,
                           @"channelID":[HGHSDKConfig currentChannelID],
                           @"ts":[HGHTools getCurrentTimeString]
                           };
    NSMutableDictionary *mutabDict = [[NSMutableDictionary alloc]initWithDictionary:dict];
    NSString *sortStr = [HGHTools sortHttpString:mutabDict];
    NSString *signStr = [NSString stringWithFormat:@"%@&key=%@",sortStr,[HGHSDKConfig currentAppKey]];
    NSString *sign = [HGHTools md5String:signStr];
    [mutabDict setObject:sign forKey:@"sign"];
    
    [HGHHttpRequest POSTNEW:url paramString:[mutabDict copy] ifSuccess:^(id  _Nonnull response) {
        NSLog(@"response=%@",response);
        success(response);
        NSString *userID = response[@"userID"];
        [[NSUserDefaults standardUserDefaults] setObject:userID forKey:@"pandasUserID"];
        [[NSUserDefaults standardUserDefaults] setObject:[response objectForKey:@"yingID"] forKey:@"pandasYingID"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    } failure:^(NSError * _Nonnull error) {
        NSLog(@"error=%@",error);
        failure(error);
    }];
}

//短信验证码
+(void)HGHGetCaptchaPhoneNO:(NSString *)phoneNO action:(NSString *)action ifSuccess:(void(^)(id response))success failure:(void(^)(NSError *error))failure
{//action :register bind update
    NSString *url = [NSString stringWithFormat:@"%@%@%@",URL_DOMAIN,URL_SENDMSG,[HGHSDKConfig currentAppID]];
    NSDictionary *dict = @{@"action":action,
                           @"phoneNumber":phoneNO,
                           @"ts":[HGHTools getCurrentTimeString]
                           };
    NSMutableDictionary *mutabDict = [[NSMutableDictionary alloc]initWithDictionary:dict];
    NSString *sortStr = [HGHTools sortHttpString:mutabDict];
    NSString *signStr = [NSString stringWithFormat:@"%@&key=%@",sortStr,[HGHSDKConfig currentAppKey]];
    NSString *sign = [HGHTools md5String:signStr];
    [mutabDict setObject:sign forKey:@"sign"];
    
    [HGHHttpRequest POSTNEW:url paramString:[mutabDict copy] ifSuccess:^(id  _Nonnull response) {
        NSLog(@"response=%@",response);
        success(response);
    } failure:^(NSError * _Nonnull error) {
        NSLog(@"error=%@",error);
        failure(error);
    }];
}
//修改密码
+(void)HGHChangePwd:(NSString *)pwd code:(NSString *)code phoneNO:(NSString *)phoneNO ifSuccess:(void(^)(id response))success failure:(void(^)(NSError *error))failure
{
    NSString *url = [NSString stringWithFormat:@"%@%@%@",URL_DOMAIN,URL_CHANGEPWD,[HGHSDKConfig currentAppID]];
    NSDictionary *dict = @{@"pwd":[HGHTools md5String:pwd],
                           @"code":code,
                           @"phoneNumber":phoneNO,
                           @"ts":[HGHTools getCurrentTimeString]
                           };
    NSMutableDictionary *mutabDict = [[NSMutableDictionary alloc]initWithDictionary:dict];
    NSString *sortStr = [HGHTools sortHttpString:mutabDict];
    NSString *signStr = [NSString stringWithFormat:@"%@&key=%@",sortStr,[HGHSDKConfig currentAppKey]];
    NSString *sign = [HGHTools md5String:signStr];
    [mutabDict setObject:sign forKey:@"sign"];
    
    [HGHHttpRequest POSTNEW:url paramString:[mutabDict copy] ifSuccess:^(id  _Nonnull response) {
        NSLog(@"response=%@",response);
        success(response);
    } failure:^(NSError * _Nonnull error) {
        NSLog(@"error=%@",error);
        failure(error);
    }];
}
//绑定手机号
+(void)HGHBindPwd:(NSString *)pwd code:(NSString *)code phoneNO:(NSString *)phoneNO userID:(NSString *)userID ifSuccess:(void(^)(id response))success failure:(void(^)(NSError *error))failure
{
    NSString *url = [NSString stringWithFormat:@"%@%@%@",URL_DOMAIN,URL_BIND,[HGHSDKConfig currentAppID]];
    NSDictionary *dict = @{@"pwd":pwd,
                           @"code":code,
                           @"phoneNumber":phoneNO,
                           @"userID":userID,
                           @"ts":[HGHTools getCurrentTimeString]
                           };
    NSMutableDictionary *mutabDict = [[NSMutableDictionary alloc]initWithDictionary:dict];
    NSString *sortStr = [HGHTools sortHttpString:mutabDict];
    NSString *signStr = [NSString stringWithFormat:@"%@&key=%@",sortStr,[HGHSDKConfig currentAppKey]];
    NSString *sign = [HGHTools md5String:signStr];
    [mutabDict setObject:sign forKey:@"sign"];
    
    [HGHHttpRequest POSTNEW:url paramString:[mutabDict copy] ifSuccess:^(id  _Nonnull response) {
        NSLog(@"response=%@",response);
        success(response);
    } failure:^(NSError * _Nonnull error) {
        NSLog(@"error=%@",error);
        failure(error);
    }];
}
//用户信息上报
+(void)HGHUserrportWithID:(NSString *)ID userInfo:(HGHUserInfo *)userInfo ifSuccess:(void(^)(id response))success failure:(void(^)(NSError *error))failure
{
    NSString *url = [NSString stringWithFormat:@"%@%@%@",URL_DOMAIN,URL_USERREPORT,[HGHSDKConfig currentAppID]];
    NSDictionary *dict = @{@"id":ID,
                           @"appID":[HGHSDKConfig currentAppID],
                           @"channelID":[HGHSDKConfig currentChannelID],
                           @"deviceID":[HGHTools getUUID],
                           @"opType":userInfo.opType,
                           @"roleID":userInfo.roleID,
                           @"roleLevel":userInfo.roleLevel,
                           @"roleName":userInfo.roleName,
                           @"serverID":userInfo.serverID,
                           @"serverName":userInfo.serverName,
                           @"ts":[HGHTools getCurrentTimeString]
                           };
    NSMutableDictionary *mutabDict = [[NSMutableDictionary alloc]initWithDictionary:dict];
    NSString *sortStr = [HGHTools sortHttpString:mutabDict];
    NSString *signStr = [NSString stringWithFormat:@"%@&key=%@",sortStr,[HGHSDKConfig currentAppKey]];
    NSString *sign = [HGHTools md5String:signStr];
    [mutabDict setObject:sign forKey:@"sign"];
    
    [HGHHttpRequest POSTNEW:url paramString:[mutabDict copy] ifSuccess:^(id  _Nonnull response) {
        success(response);
    } failure:^(NSError * _Nonnull error) {
        failure(error);
    }];
}
//设备信息上报
+(void)HGHDeviceReport:(HGHDeviceInfo *)deviceInfo userID:(NSString *)userID ifSuccess:(void(^)(id response))success failure:(void(^)(NSError *error))failure
{
    NSString *url = [NSString stringWithFormat:@"%@%@%@",URL_DOMAIN,URL_DEVICEREPORT,[HGHSDKConfig currentAppID]];
    NSDictionary *dict = @{@"userID":userID,
                           @"channelID":[HGHSDKConfig currentChannelID],
                           @"deciceID":deviceInfo.deviceID,
                           @"deviceDpi":deviceInfo.deviceDpi,
                           @"deviceImei":deviceInfo.deviceImei,
                           @"deviceOS":deviceInfo.deviceOS,
                           @"deviceType":deviceInfo.deviceType,
                           @"mac":deviceInfo.mac,
                           @"ts":[HGHTools getCurrentTimeString]
                           };
    NSMutableDictionary *mutabDict = [[NSMutableDictionary alloc]initWithDictionary:dict];
    NSString *sortStr = [HGHTools sortHttpString:mutabDict];
    NSString *signStr = [NSString stringWithFormat:@"%@&key=%@",sortStr,[HGHSDKConfig currentAppKey]];
    NSString *sign = [HGHTools md5String:signStr];
    [mutabDict setObject:sign forKey:@"sign"];
    
    [HGHHttpRequest POSTNEW:url paramString:[mutabDict copy] ifSuccess:^(id  _Nonnull response) {
        NSLog(@"response=%@",response);
        success(response);
    } failure:^(NSError * _Nonnull error) {
        NSLog(@"error=%@",error);
        failure(error);
    }];
}
//下单
+(void)HGHGetOrder:(HGHOrderInfo *)orderInfo ifSuccess:(void(^)(id response))success failure:(void(^)(NSError *error))failure
{
    NSString *url = [NSString stringWithFormat:@"%@%@%@/%@",URL_DOMAIN,URL_GETORDER,[HGHSDKConfig currentAppID],@"appstore"];
    NSString  *appid = [HGHSDKConfig currentAppID];
    NSString  *appsecret = [HGHSDKConfig currentAppKey];
    // 平台数据
    NSDictionary *platformDic =@{
                                 @"subject" :orderInfo.productName,
                                 @"body":orderInfo.extension,
                                 };
    NSError *parseError = nil;
    NSString *userID = [HGHTools getCurrentUserID];
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:platformDic options:NSJSONWritingPrettyPrinted error:&parseError];
    NSString *payPlatformDataStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    NSString *dateStr = [NSString stringWithFormat:@"%d", (int)[[NSDate date] timeIntervalSince1970]];
    /***************************/
    
    /***************************/
    
    // 3.设置请求体  6892fb801a55dedf4703c9ff317d39fe hghtest
    NSDictionary *dict = @{
                               @"cpOrderID" : orderInfo.cpOrderID,
                               @"extension" :orderInfo.extension,
                               @"gameCallbackUrl": orderInfo.gameCallbackUrl,
                               @"userID" : userID,
                               @"yingID":[HGHTools getCurrentYingID],
                               @"serverID":orderInfo.serverID,
                               @"serverName":orderInfo.serverName,
                               @"roleID":orderInfo.roleID,
                               @"roleName":orderInfo.roleName,
                               @"money":orderInfo.money,
                               @"productID" :orderInfo.productID,
                               @"channelID":[HGHSDKConfig currentChannelID],
                               @"ts":dateStr,
                               @"payPlatformData": payPlatformDataStr
                               };
    NSMutableDictionary *mutabDict = [[NSMutableDictionary alloc]initWithDictionary:dict];
    NSString *sortStr = [HGHTools sortHttpString:mutabDict];
    NSLog(@"sortStr=%@",sortStr);
    NSString *signStr = [NSString stringWithFormat:@"%@&key=%@",sortStr,[HGHSDKConfig currentAppKey]];
    NSString *sign = [HGHTools md5String:signStr];
    [mutabDict setObject:sign forKey:@"sign"];
    [mutabDict setObject:@"rsa" forKey:@"signType"];
    NSLog(@"dictxx=%@",[mutabDict copy]);
    [HGHHttpRequest POSTNEW:url paramString:[mutabDict copy] ifSuccess:^(id  _Nonnull response) {
        NSLog(@"response=%@",response);
        success(response);
    } failure:^(NSError * _Nonnull error) {
        NSLog(@"error=%@",error);
        failure(error);
    }];
}

    //other下单
+(void)HGHGetOtherOrder:(HGHOrderInfo *)orderInfo andUrl:(NSString *)url ifSuccess:(void(^)(id response))success failure:(void(^)(NSError *error))failure
{
//    NSString *urlxx = [NSString stringWithFormat:@"%@/%@",url,@"appstore"];
    NSString  *appid = [HGHSDKConfig currentAppID];
    NSString  *appsecret = [HGHSDKConfig currentAppKey];
        // 平台数据
    NSDictionary *platformDic =@{
                                 @"subject" :orderInfo.productName,
                                 @"body":orderInfo.extension,
                                 };
    NSError *parseError = nil;
    NSString *userID = [HGHTools getCurrentUserID];
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:platformDic options:NSJSONWritingPrettyPrinted error:&parseError];
    NSString *payPlatformDataStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    NSString *dateStr = [NSString stringWithFormat:@"%d", (int)[[NSDate date] timeIntervalSince1970]];
    /***************************/
    
    /***************************/
    
        // 3.设置请求体  6892fb801a55dedf4703c9ff317d39fe hghtest
    NSDictionary *dict = @{
                           @"cpOrderID" : orderInfo.cpOrderID,
                           @"extension" :orderInfo.extension,
                           @"gameCallbackUrl": orderInfo.gameCallbackUrl,
                           @"userID" : userID,
                           @"yingID":[HGHTools getCurrentYingID],
                           @"serverID":orderInfo.serverID,
                           @"serverName":orderInfo.serverName,
                           @"roleID":orderInfo.roleID,
                           @"roleName":orderInfo.roleName,
                           @"money":orderInfo.money,
                           @"productID" :orderInfo.productID,
                           @"channelID":[HGHSDKConfig currentChannelID],
                           @"ts":dateStr,
                           @"payPlatformData": payPlatformDataStr
                           };
    NSMutableDictionary *mutabDict = [[NSMutableDictionary alloc]initWithDictionary:dict];
    NSString *sortStr = [HGHTools sortHttpString:mutabDict];
    NSLog(@"sortStr=%@",sortStr);
    NSString *signStr = [NSString stringWithFormat:@"%@&key=%@",sortStr,[HGHSDKConfig currentAppKey]];
    NSString *sign = [HGHTools md5String:signStr];
    [mutabDict setObject:sign forKey:@"sign"];
    [mutabDict setObject:@"rsa" forKey:@"signType"];
    NSLog(@"dictxx=%@",[mutabDict copy]);
    [HGHHttpRequest POSTNEW:url paramString:[mutabDict copy] ifSuccess:^(id  _Nonnull response) {
        NSLog(@"response=%@",response);
        success(response);
    } failure:^(NSError * _Nonnull error) {
        NSLog(@"error=%@",error);
        failure(error);
    }];
}


//实名认证
+(void)HGHRenzhengWithUserName:(NSString *)userName idCardNumber:(NSString *)idcardNumber ifSuccess:(void(^)(id response))success failure:(void(^)(NSError *error))failure
{
    NSString *url = [NSString stringWithFormat:@"%@%@%@",URL_DOMAIN,URL_RENZHENG,[HGHSDKConfig currentAppID]];
    NSDictionary *dict = @{@"realName":userName,
                           @"idCardNo":idcardNumber,
                           @"ts":[HGHTools getCurrentTimeString]
                           };
    NSMutableDictionary *mutabDict = [[NSMutableDictionary alloc]initWithDictionary:dict];
    NSString *sortStr = [HGHTools sortHttpString:mutabDict];
    NSString *signStr = [NSString stringWithFormat:@"%@&key=%@",sortStr,[HGHSDKConfig currentAppKey]];
    NSString *sign = [HGHTools md5String:signStr];
    [mutabDict setObject:sign forKey:@"sign"];
    
    [HGHHttpRequest POSTNEW:url paramString:[mutabDict copy] ifSuccess:^(id  _Nonnull response) {
        success(response);
    } failure:^(NSError * _Nonnull error) {
        failure(error);
    }];
}
//发送iap票据
+(void)HGHSendRecieptWithReceiptInfo:(NSMutableDictionary *)receipt ifSuccess:(void(^)(id response))success failure:(void(^)(NSError *error))failure
{
    NSString *url = [NSString stringWithFormat:@"%@%@%@/%@",URL_DOMAIN,URL_RECIEPT,[HGHSDKConfig currentAppID],@"appstore"];
    NSDictionary *dict = @{@"cpOrderID":receipt[@"sdkorderID"],
                           @"transactionReceipt":receipt[@"transaction"],
                           @"platformOrderID":receipt[@"platformOrderID"],
                           @"money":receipt[@"money"]
                           };
    NSMutableDictionary *mutabDict = [[NSMutableDictionary alloc]initWithDictionary:dict];
    NSString *sortStr = [HGHTools sortHttpString:mutabDict];
    NSString *signStr = [NSString stringWithFormat:@"%@&key=%@",sortStr,[HGHSDKConfig currentAppKey]];
    NSString *sign = [HGHTools md5String:signStr];
    [mutabDict setObject:sign forKey:@"sign"];
    
    [HGHHttpRequest POSTNEW:url paramString:[mutabDict copy] ifSuccess:^(id  _Nonnull response) {
        success(response);
    } failure:^(NSError * _Nonnull error) {
        NSLog(@"error=%@",error);
        failure(error);
    }];
}
    //初始化切支付
+(void)HGHTInitSDKifSuccess:(void(^)(id response))success failure:(void(^)(NSError *error))failure
{
    NSString *url = [NSString stringWithFormat:@"%@%@%@?channel_id=%@",URL_DOMAIN,URL_INIT,[HGHSDKConfig currentAppID],[HGHSDKConfig currentChannelID]];
    [HGHHttpRequest POSTNEW:url paramString:@{@"test":@"test"} ifSuccess:^(id  _Nonnull response) {
        success(response);
    } failure:^(NSError * _Nonnull error) {
        NSLog(@"error=%@",error);
        failure(error);
    }];
}
@end
