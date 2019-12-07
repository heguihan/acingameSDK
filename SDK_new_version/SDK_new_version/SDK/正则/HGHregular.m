//
//  HGHregular.m
//  SDK_new_version
//
//  Created by Lucas on 2019/12/3.
//  Copyright © 2019 Lucas. All rights reserved.
//

#import "HGHregular.h"

@implementation HGHregular
+(BOOL)regularPhoneNO:(NSString *)phoneNO
{
    NSString * MOBILE = @"^1\\d{10}$";
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    if ([regextestmobile evaluateWithObject:phoneNO] == YES)
    {
        return YES;
    }
    return NO;
}
+(BOOL)regularUserName:(NSString *)userName
{
    BOOL result = false;
    if ([userName length] >= 6){
        // 判断长度大于8位后再接着判断是否同时包含数字和字符
        NSString * regex = @"^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{6,18}$";
        NSString * regexx = @"^\d{15,17}[x|X]?";
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
        result = [pred evaluateWithObject:userName];
    }
    return result;
}
+(BOOL)regularPassword:(NSString *)password
{
    BOOL result = false;
    if ([password length] >= 8){
        // 判断长度大于8位后再接着判断是否同时包含数字和字符
        NSString * regex = @"^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{8,16}$";
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
        result = [pred evaluateWithObject:password];
    }
    return result;
}

+(BOOL)regularIdCardNum:(NSString *)idCardNum
{
    BOOL result = false;
    if ([idCardNum length] >= 15){
        NSString * regex = @"^[0-9]{15}|[0-9]{17}[0-9|x|X]{1}$";
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
        result = [pred evaluateWithObject:idCardNum];
    }
    return result;
}

@end
