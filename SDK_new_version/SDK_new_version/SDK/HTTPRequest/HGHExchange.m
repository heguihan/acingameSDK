//
//  HGHExchange.m
//  haiwaiSDK
//
//  Created by Lucas on 2019/3/18.
//  Copyright © 2019 Lucas. All rights reserved.
//

#import "HGHExchange.h"

@implementation HGHExchange

+(NSString *)getHttpSing:(NSMutableDictionary *)dic
{
    NSString *str = nil;
    NSMutableArray *parameters_array = [NSMutableArray arrayWithArray:[dic allKeys]];
    [parameters_array sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [obj1 compare:obj2];
        //return [obj2 compare:obj1];//降序
    } ];
    for (int i = 0; i<parameters_array.count; i++) {
        NSString *key = [parameters_array objectAtIndex: i];
        NSString * value = [dic objectForKey:key];
        value = [self encodeString:value];
        if (i==0) {
            
            str = [NSString stringWithFormat:@"%@=%@",key,value] ;
            
        }else{
            
            str = [NSString stringWithFormat:@"%@&%@=%@",str,key,value];
        }
        
    }
    
    return str;
}
+(NSString*)encodeString:(NSString*)unencodedString{
    
    NSString *encodedString=nil;
    if ([[[UIDevice currentDevice] systemVersion] floatValue] > 9.0f) {
        
        encodedString = (NSString *)
        CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                                  (CFStringRef)unencodedString,
                                                                  NULL,
                                                                  (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                                  kCFStringEncodingUTF8));
    }
    
    encodedString = [encodedString stringByReplacingOccurrencesOfString:@"%20" withString:@"+"];
    return encodedString;
}

+ (NSString *)exchangeStringWithdict:(NSDictionary *)dict
{
//    NSArray *keysArray = [dict allKeys];
    NSLog(@"dict=%@",dict);
    
    NSString *paramStr = @"";
    for (NSString *key in dict) {
        NSLog(@"key=%@ andValue=%@",key,dict[key]);
        if (dict[key]==nil) {
            NSLog(@"kong key=%@",key);
            continue;
        }
        paramStr = [NSString stringWithFormat:@"%@%@=%@&",paramStr,key,dict[key]];
    }
    NSString *resutlStr = [paramStr substringWithRange:NSMakeRange(0, [paramStr length]-1)];
    return resutlStr;
}

+(NSString *)getSignStrWithDict:(NSDictionary *)dict
{
    NSArray *keys = dict.allKeys;
    NSLog(@"keys=%@",keys);
    
    keys = [keys sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        NSComparisonResult result = [obj1 compare:obj2];
        return result;
    }];
    NSLog(@"keys_new=%@",keys);
    NSString *resultStr = @"";
    for (NSString *key in keys) {
        NSLog(@"key=%@,value=%@",key,dict[key]);
        if (dict[key]==nil||[[NSString stringWithFormat:@"%@",dict[key]] isEqualToString:@""]) {
            NSLog(@"key=%@, and value=%@",key,dict[key]);
            continue;
        }
        resultStr = [NSString stringWithFormat:@"%@&%@=%@",resultStr,key,dict[key]];
    }
//    NSString *newResultStr=[resultStr dele]
    NSMutableString *mutableStr = [NSMutableString stringWithString:resultStr];
    [mutableStr deleteCharactersInRange:NSMakeRange(0, 1)];
    NSLog(@"mutableStr=%@",mutableStr);
//    NSLog(@"resultStr=%@",resultStr);
    return mutableStr;
    
}


+ (nullable NSString *)md5:(nullable NSString *)str {
    if (!str) return nil;
    
    const char *cStr = str.UTF8String;
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result);
    
    NSMutableString *md5Str = [NSMutableString string];
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; ++i) {
        [md5Str appendFormat:@"%02x", result[i]];
    }
    return md5Str;
}
@end
