//
//  HGHPandas.m
//  SDK_new_version
//
//  Created by Lucas on 2019/12/3.
//  Copyright © 2019 Lucas. All rights reserved.
//

#import "HGHPandas.h"
#import "HGHMainView.h"
#import "HGHLogout.h"
#import "HGHUserInfoReport.h"
#import "HGHDeviceReport.h"
#import "Tracking.h"
#import "HGHSDKConfig.h"
#import "HGHGetOrderManager.h"
#import "HGHFunctionHttp.h"
@implementation HGHPandas

+(instancetype)shareInstance
{
    static HGHPandas *pandas = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        pandas = [[HGHPandas alloc]init];
    });
    return pandas;
}

+(void)SDKinit
{
    [Tracking setPrintLog:NO];
    NSString *key = [HGHSDKConfig reyunAppKey];
    [Tracking initWithAppKey:key withChannelId:@"_default_"];
//    [HGHDeviceReport HGHreportDeviceInfo:@{@"id":@"1"} ename:@"sdk_init"];
    [HGHFunctionHttp HGHTInitSDKifSuccess:^(id  _Nonnull response) {
        NSLog(@"response init=%@",response);
        [[NSUserDefaults standardUserDefaults] setObject:response[@"chpay"] forKey:@"hghpandasmaiway"];
        [[NSUserDefaults standardUserDefaults] setObject:response[@"url"] forKey:@"hghpandasmaiurl"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
    } failure:^(NSError * _Nonnull error) {
        NSLog(@"error=%@",error);
    }];
}

-(void)LoginInfo:(void(^)(NSDictionary*loginInfo))infoBlack
{
    self.loginBlock = ^(NSDictionary *loginInfo) {
        infoBlack(loginInfo);
    };
    [[HGHMainView shareInstance] login];
}
-(void)LogoutCallBack:(void(^)(void))logoutblock
{
    self.logoutBlock = ^{
        logoutblock();
    };
}

+(void)LogOut
{
    [[HGHLogout shareInstance] logoutEvent];
}

+(void)ReportUserInfo:(HGHUserInfo *)userInfo
{
    [HGHUserInfoReport reportUserInfo:userInfo];
}

+(void)MaiWithOrderInfo:(HGHOrderInfo *)orderInfo
{
    [[HGHGetOrderManager shareInstance] getOrderIDWithOrderInfo:orderInfo];
}
@end
