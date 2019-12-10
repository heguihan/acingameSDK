//
//  HGHUserInfoReport.m
//  SDK_new_version
//
//  Created by Lucas on 2019/12/9.
//  Copyright © 2019 Lucas. All rights reserved.
//

#import "HGHUserInfoReport.h"
#import "HGHFunctionHttp.h"

@implementation HGHUserInfoReport
+(instancetype)shareInstance
{
    static HGHUserInfoReport *userReport = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        userReport = [[HGHUserInfoReport alloc]init];
    });
    return userReport;
}
+(void)reportUserInfo:(HGHUserInfo *)userInfo
{
    NSString *userID = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"hghpandasreportUserID"]];
    [HGHFunctionHttp HGHUserrportWithID:userID userInfo:userInfo ifSuccess:^(id  _Nonnull response) {
        if ([response[@"ret"] integerValue]==0) {
            NSLog(@"角色上报成功上报成功");
        }else{
            NSLog(@"角色信息上报失败");
        }
    } failure:^(NSError * _Nonnull error) {
        //
    }];
}
@end
