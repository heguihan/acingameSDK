//
//  HGHTools.m
//  iOS_SDK_chonggou
//
//  Created by Lucas on 2019/11/25.
//  Copyright © 2019 Lucas. All rights reserved.
//

#import "HGHTools.h"
#import <CommonCrypto/CommonDigest.h>

#define  KEYCHAIN @"pandashghApple"
@implementation HGHTools
+(instancetype)shareInstance
{
    static HGHTools *tools = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        tools = [[HGHTools alloc]init];
    });
    return tools;
}
+(NSString *)getUUID
{
    NSString * strUUID = (NSString *)[self load:@"pandashghApple"];
    if ([strUUID isEqualToString:@""] || !strUUID)
    {
        //生成一个uuid的方法
        CFUUIDRef uuidRef = CFUUIDCreate(kCFAllocatorDefault);
        
        strUUID = (NSString *)CFBridgingRelease(CFUUIDCreateString (kCFAllocatorDefault,uuidRef));
        
        //将该uuid保存到keychain
        [self save:KEYCHAIN data:strUUID];
        
    }
    return strUUID;
}

+ (NSMutableDictionary *)getKeychainQuery:(NSString *)service {
    return [NSMutableDictionary dictionaryWithObjectsAndKeys:
            (id)kSecClassGenericPassword,(id)kSecClass,
            service, (id)kSecAttrService,
            service, (id)kSecAttrAccount,
            (id)kSecAttrAccessibleAfterFirstUnlock,(id)kSecAttrAccessible,
            nil];
}

+ (void)save:(NSString *)service data:(id)data {
    //Get search dictionary
    NSMutableDictionary *keychainQuery = [self getKeychainQuery:service];
    //Delete old item before add new item
    SecItemDelete((CFDictionaryRef)keychainQuery);
    //Add new object to search dictionary(Attention:the data format)
    [keychainQuery setObject:[NSKeyedArchiver archivedDataWithRootObject:data] forKey:(id)kSecValueData];
    //Add item to keychain with the search dictionary
    SecItemAdd((CFDictionaryRef)keychainQuery, NULL);
}

+ (id)load:(NSString *)service {
    id ret = nil;
    NSMutableDictionary *keychainQuery = [self getKeychainQuery:service];
    
    [keychainQuery setObject:(id)kCFBooleanTrue forKey:(id)kSecReturnData];
    [keychainQuery setObject:(id)kSecMatchLimitOne forKey:(id)kSecMatchLimit];
    CFDataRef keyData = NULL;
    if (SecItemCopyMatching((CFDictionaryRef)keychainQuery, (CFTypeRef *)&keyData) == noErr) {
        @try {
            ret = [NSKeyedUnarchiver unarchiveObjectWithData:(__bridge NSData *)keyData];
        } @catch (NSException *e) {
            NSLog(@"Unarchive of %@ failed: %@", service, e);
        } @finally {
        }
    }
    if (keyData)
        CFRelease(keyData);
    return ret;
}

+ (void)deleteKeyData:(NSString *)service {
    NSMutableDictionary *keychainQuery = [self getKeychainQuery:service];
    SecItemDelete((CFDictionaryRef)keychainQuery);
}

+ (void)removeViews:(UIView *)futherView
{
    dispatch_async(dispatch_get_main_queue(), ^{
        for (UIView *view in futherView.subviews) {
            [view removeFromSuperview];
        }
        [futherView removeFromSuperview];
    });

}
+(NSString *)getCurrentUserID
{
    NSString *currentUserID = [[NSUserDefaults standardUserDefaults] objectForKey:@"pandasUserID"];
    return currentUserID;
    
}
+(NSString *)getCurrentYingID
{
    NSString *yingID = [[NSUserDefaults standardUserDefaults] objectForKey:@"pandasYingID"];
    return yingID;
}
+(UIViewController *)getCurrentVC
{
    UIViewController *result = nil;
    
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    if ([nextResponder isKindOfClass:[UIViewController class]])
    result = nextResponder;
    else
    result = window.rootViewController;
    return result;
}

+(NSString *)getCurrentTimeString
{
    NSString *dateStr = [NSString stringWithFormat:@"%d", (int)[[NSDate date] timeIntervalSince1970]];
    return dateStr;
}
//md5加密
+(NSString *) md5String:(NSString *)str
{
    const char *original_str = [str UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(original_str, strlen(original_str), result);
    NSMutableString *hash = [NSMutableString string];
    for (int i = 0; i < 16; i++)
        [hash appendFormat:@"%02X", result[i]];
    return [hash lowercaseString];
}
+(NSString *)sortHttpString:(NSMutableDictionary *)dic
{
    
    NSString *str = nil;
    NSMutableArray *parameters_array = [NSMutableArray arrayWithArray:[dic allKeys]];
    [parameters_array sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [obj1 compare:obj2];
        return [obj2 compare:obj1];//降序
    } ];
    
    for (int i = 0; i<parameters_array.count; i++) {
        
        
        NSString *key = [parameters_array objectAtIndex: i];
        NSString * value = [dic objectForKey:key];
        value = [self URLEncodeString:value];
        if (i==0) {
            str = [NSString stringWithFormat:@"%@=%@",key,value] ;
        }else{
            str = [NSString stringWithFormat:@"%@&%@=%@",str,key,value];
        }
        
    }
    
    return str;
}


+(NSString*)URLEncodeString:(NSString*)unencodedString{
    
    //    NSString *encodedString=nil;
    //    if ([[[UIDevice currentDevice] systemVersion] floatValue] > 9.0f) {
    
    
    NSString *encodedString = (NSString *)
    CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                              (CFStringRef)unencodedString,
                                                              NULL,
                                                              (CFStringRef)@"!*'(); :@&=+$,/?%#[]",
                                                              kCFStringEncodingUTF8));
    //  }
    
    encodedString = [encodedString stringByReplacingOccurrencesOfString:@"%20" withString:@"+"];
    
    return encodedString;
}
@end
