//
//  HGHDeviceReport.m
//  ShuZhiZhangSDK
//
//  Created by Lucas on 2019/11/5.
//  Copyright © 2019 John Cheng. All rights reserved.
//

#import "HGHDeviceReport.h"
#import "HGHDevice.h"
#import "HGHTools.h"
//#import "HGHConfig.h"
//#import "HGHDMHttp.h"
#import "HGHExchange.h"
#import "HGHHttpRequest.h"
@implementation HGHDeviceReport

+(void)HGHreportDeviceInfo:(NSDictionary *)deviceInfo ename:(NSString *)ename
{
    NSLog(@"deviceInfo=%@",deviceInfo);
    NSString *channelID = @"11111";
    NSString *deviceID = @"abctest";
    NSString *deviceDPI = [HGHDevice getWidthAndHeight];
    NSString *deviceType = [HGHDevice iphoneName];
    NSString *imei = @"abctest";
    NSString *deviceOS = @"2";
    NSString *device_osver = [HGHDevice SystemVersion];
    NSString *mac = [HGHDevice macAddress];
    NSString *ipadd = [HGHDevice deviceWANIPAdress]?[HGHDevice deviceWANIPAdress]:@"1234";
    NSString *network = [HGHDevice getNetconnType];
    NSString *sdkver =@"1.1.1";
    NSString *dm_appid = @"36";
    NSString *dm_appkey = @"3908738210623f39e4230512b083e0f8";
    NSString *signBefore = [NSString stringWithFormat:@"%@%@",dm_appid,dm_appkey];
    NSString *sign = [HGHExchange md5:signBefore];
    NSDictionary *dict = [NSDictionary dictionary];
    if ([ename isEqualToString:@"sdk_init"]) {
        dict = @{@"ename":ename,
                 @"app_id":dm_appid,
                 @"channel_id":channelID,
                 @"device_id":deviceID,
                 @"device_dpi":deviceDPI,
                 @"device_type":deviceType,
                 @"device_os":deviceOS,
                 @"device_osver":device_osver,
                 @"mac":mac,
                 @"ip":ipadd,
                 @"newwork":network,
                 @"sdkver":sdkver,
                 @"sign":sign
                 };
    }else{
        dict = @{@"ename":ename,
                 @"app_id":dm_appid,
                 @"channel_id":channelID,
                 @"userid":[NSString stringWithFormat:@"%@",deviceInfo[@"id"]],
                 @"device_id":deviceID,
                 @"device_dpi":deviceDPI,
                 @"device_type":deviceType,
                 @"device_os":deviceOS,
                 @"device_osver":device_osver,
                 @"mac":mac,
                 @"ip":ipadd,
                 @"newwork":network,
                 @"sdkver":sdkver,
                 @"sign":sign
                 };
    }
    NSLog(@"dict=%@",dict);
    NSString *dmurl = @"http://dm.acing.com/api/reports";
    [HGHHttpRequest POSTNEW:dmurl paramString:dict ifSuccess:^(id  _Nonnull response) {
        NSLog(@"response=%@",response);
    } failure:^(NSError * _Nonnull error) {
        NSLog(@"xxxx");
    }];
}

@end
