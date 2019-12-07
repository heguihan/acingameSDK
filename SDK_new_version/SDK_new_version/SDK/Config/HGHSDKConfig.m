//
//  HGHSDKConfig.m
//  SDK_new_version
//
//  Created by Lucas on 2019/12/3.
//  Copyright © 2019 Lucas. All rights reserved.
//

#import "HGHSDKConfig.h"

@implementation HGHSDKConfig
+(NSString *)currentChannelID
{
    NSDictionary *dict = [self GetConfig];
    return dict[@"channelID"];
}
+(NSString *)currentAppID
{
    NSDictionary *dict = [self GetConfig];
    return dict[@"appID"];
}
+(NSString *)currentAppKey
{
    NSDictionary *dict = [self GetConfig];
    return dict[@"appKey"];
}
+(NSString *)renyunAppKey
{
    NSDictionary *dict = [self GetConfig];
    return dict[@"renyunKey"];
}
+(NSString *)dmAppID
{
    NSDictionary *dict = [self GetConfig];
    return dict[@"dm_appID"];
}
+(NSString *)dmAppKey
{
    NSDictionary *dict = [self GetConfig];
    return dict[@"dm_appKey"];
}

+(NSDictionary *)GetConfig
{
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"HGHPandas" ofType:@"plist"]];
    return dic;
}
@end
