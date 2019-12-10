//
//  HGHLogout.m
//  SDK_new_version
//
//  Created by Lucas on 2019/12/9.
//  Copyright © 2019 Lucas. All rights reserved.
//

#import "HGHLogout.h"
#import "HGHMainView.h"
@implementation HGHLogout
+(instancetype)shareInstance
{
    static HGHLogout *logout = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        logout = [[HGHLogout alloc]init];
    });
    return logout;
}
-(void)logoutEvent
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"pandasUserID"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"hghpandaslogintype"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [[HGHMainView shareInstance] login];
}
@end
