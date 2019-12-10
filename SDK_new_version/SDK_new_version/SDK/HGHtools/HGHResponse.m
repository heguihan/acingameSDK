//
//  HGHResponse.m
//  SDK_new_version
//
//  Created by Lucas on 2019/12/4.
//  Copyright © 2019 Lucas. All rights reserved.
//

#import "HGHResponse.h"
#import "HGHShowBall.h"
#import "HGHMainView.h"
#import "HGHPandas.h"
#import "HGHTools.h"
#import "HGHDeviceReport.h"
#import "Tracking.h"

@implementation HGHResponse
+(instancetype)shareInstance
{
    static HGHResponse *response = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        response = [[HGHResponse alloc]init];
    });
    return response;
}
/*
 response={
 accountType = 2;
 id = 4564;
 msg = "\U6210\U529f";
 phoneNumber = "";
 ret = 0;
 timestamp = 1575710422;
 token = eyJpZGVudGlmaWVyIjoiYTNiODFlM2JmNzU2MmExNTZiMWM1OTlhYzNlNjU3ZTkiLCJleHBpcmUiOjE1NzU3Mjg0MjEsIm5vbmNlU3RyIjoiT3J1Q1dud2RlZXNYck9WcTVBM3pQUlBRNUpMd2NxbDMiLCJ0b2tlbiI6IjM5NTk5NDk4ZTgyOWYyZjRhOGRhZDM2NjVlMGY5Y2FhNjY0M2ZhN2U2NDc4MjY4YTUzZmY4ZjVjMzE3OTQxY2UifQ;
 tokenCreateTime = 1575710421;
 userID = hghtest;
 yingID = 6892fb801a55dedf4703c9ff317d39fe;
 
 accountType
 是
 string
 1
 登录类型
 
 
 idCardAuth
 是
 string
 0
 身份认证标识(0-未认证,1-已认证)
 
 
 realName
 是
 string
 张三
 真实姓名
 
 
 idCardNo
 是
 string
 11xxxxx98
 身份证号
 
 
 birthday
 是
 int
 1534217958
 出生日期
 
 
 age
 是
 int
 100
 年龄
 
 
 forceIdCardAuth
 是
 int
 1
 是否强制实名认证(0-否,1-是)
 
 }
 
 */

// logintype 登录类型  type login/register
+(void)loginsuccessWithUserData:(NSDictionary *)dict logintype:(NSString *)loginType type:(NSString *)type
{
//    sdk_login_cb   sdk_registe_cb  sdk_init
    
    
    if ([type isEqualToString:@"register"]) {
        //DM设备信息上报
        [HGHDeviceReport HGHreportDeviceInfo:@{@"id":dict[@"id"]} ename:@"sdk_registe_cb"];
        //热云上报
        [Tracking setRegisterWithAccountID:[dict objectForKey:@"userID"]];
    }else if ([type isEqualToString:@"login"]){
        //DM设备信息上报
        [HGHDeviceReport HGHreportDeviceInfo:@{@"id":dict[@"id"]} ename:@"sdk_login_cb"];
        //热云上报
        [Tracking setLoginWithAccountID:[dict objectForKey:@"userID"]];
    }
    
    NSMutableDictionary *mutableDict = [[NSMutableDictionary alloc]initWithDictionary:dict];
    [mutableDict setObject:loginType forKey:@"hghlogintype"];
    
    if ([dict[@"idCardAuth"] integerValue]==0) {
        [[HGHMainView shareInstance] showRenzhengViewWithUserInfo:[mutableDict copy]];
    }else if ([dict[@"phoneNumber"] isEqualToString:@""]){
        if (![HGHTools isNeedShowbind]) {
            [self responseSuccess:[mutableDict copy]];
            return;
        }
        
        if ([loginType integerValue]==2) {
            [[HGHMainView shareInstance] showAccountBindViewWithUserInfo:[mutableDict copy]];
        }else if ([loginType integerValue]==3){
            [[HGHMainView shareInstance] showGuestBindViewWithUserInfo:[mutableDict copy]];
        }else{
            NSLog(@"树是智障");
        }
        //show 绑定
    }else{
        [[HGHMainView shareInstance].baseView removeFromSuperview];
        [self responseSuccess:[mutableDict copy]];
    }
    
}

+(void)responseSuccess:(NSDictionary *)dict
{
    
    NSInteger logintype = [dict[@"hghlogintype"] integerValue];
    if (logintype==1) {
        //手机号登录
        
    }else if (logintype==2){
        //账号登录
    }
    NSLog(@"token callback=%@ dict=%@",dict[@"token"],dict);
    [[NSUserDefaults standardUserDefaults] setObject:dict[@"id"] forKey:@"hghpandasreportUserID"];
    [[NSUserDefaults standardUserDefaults] setObject:dict[@"userID"] forKey:@"pandasUserID"];
    [[NSUserDefaults standardUserDefaults] setObject:dict[@"hghlogintype"] forKey:@"hghpandaslogintype"];
    [[NSUserDefaults standardUserDefaults] setObject:dict forKey:@"hghpandasuserinfo"];
    [[NSUserDefaults standardUserDefaults] setObject:dict[@"yingID"] forKey:@"hghpandasyingid"];
    [[NSUserDefaults standardUserDefaults] setObject:dict[@"token"] forKey:@"hghpandastoken"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [HGHShowBall showFloatingball];
    [HGHPandas shareInstance].loginBlock(dict);
    
    
}
@end
