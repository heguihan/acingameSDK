//
//  HGHHttpRequest.m
//  SDK_new_version
//
//  Created by Lucas on 2019/11/29.
//  Copyright © 2019 Lucas. All rights reserved.
//

#import "HGHHttpRequest.h"
#import "HGHExchange.h"
#import "RSA.h"
@implementation HGHHttpRequest

+(void)POSTNEW:(NSString*)URL paramString:(NSDictionary*)dict ifSuccess:(void(^)(id response))success failure:(void(^)(NSError *error))failure
{
    NSMutableDictionary *mutabdict = [[NSMutableDictionary alloc]initWithDictionary:dict];
    NSString *resultParamStr = [HGHExchange getHttpSing:mutabdict];
    NSLog(@"resultParamStr=%@",resultParamStr);
    //rsa加密
    NSString *paramstr = [self getRsaParamStr:resultParamStr];
    NSMutableURLRequest*request=[NSMutableURLRequest requestWithURL:[NSURL URLWithString:URL] cachePolicy:(NSURLRequestUseProtocolCachePolicy) timeoutInterval:500];
    [request setHTTPMethod:@"POST"];
    
//    NSData*paraData=[resultParamStr dataUsingEncoding:NSUTF8StringEncoding];
    NSData*paraData=[paramstr dataUsingEncoding:NSUTF8StringEncoding];
    
    [request setHTTPBody:paraData];
    
    [self sendRequest:request ifSuccess:^(id response) {
        success(response);
    } failure:^(NSError *error) {
        failure(error);
    }];
}


+(void)test
{
    
}

+(void)sendRequest:(NSMutableURLRequest*)request ifSuccess:(void(^)(id response))success failure:(void (^)(NSError *error))failure
{
    
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *sessionDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSDictionary *resultDict = [self getresponseRsaDict:data];
        if (!data || data == nil) {
            
            return ;
        }
        if (error) {
            
            failure(error);
            
        } else {
            
            if (resultDict) {
                
                success(resultDict);
            }
        }
    }];
    [sessionDataTask resume];
}

+(NSDictionary *)getresponseRsaDict:(NSData *)responseData
{
    NSString *publicKey = @"MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCpl3QVq4zLvq7zwQo5z1hMRBqS0p5JCrYfIb8K833AQ5ghNaQQaOzuGrLg7r4NWl7sL0AUrFSg8VytJfxIUUGFAug6Ngk+ZZLfS3ql3XXCNGKAz91lcNF5MjIHh/x3P32YHfegFGd6Pg1xq7c2ft62+zkMb6VR26RI9yQd6AU/JQIDAQAB";
    NSString *dataStr = [[NSString alloc]initWithData:responseData encoding:NSUTF8StringEncoding];
//    NSLog(@"dataStr=%@",dataStr);
    NSArray *arr = [dataStr componentsSeparatedByString:@","];
    //NSLog(@"arr=%@",arr);
    NSMutableString *mutableResult = @"";
    for (NSString *subStr in arr) {
        NSString *subRsaStr = [RSA decryptString:subStr publicKey:publicKey];
        //NSLog(@"subStr=%@",subRsaStr);
        mutableResult = [mutableResult stringByAppendingString:subRsaStr];
    }
    //NSLog(@"mutaResultStr=%@",mutableResult);
    NSDictionary *resultDict = [self dictionaryWithJsonString:mutableResult];
    return resultDict;
}

+(NSString *)getRsaParamStr:(NSString *)paramstr
{
    NSMutableArray *mutabArr = [NSMutableArray array];
    for (int i=0; i<paramstr.length; i+=30) {
        NSInteger len =(paramstr.length-i)>30?30:paramstr.length-i;
        NSRange range ={i,len};
        [mutabArr addObject:[paramstr substringWithRange:range]];
    }
    NSString *publicKey = @"MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCpl3QVq4zLvq7zwQo5z1hMRBqS0p5JCrYfIb8K833AQ5ghNaQQaOzuGrLg7r4NWl7sL0AUrFSg8VytJfxIUUGFAug6Ngk+ZZLfS3ql3XXCNGKAz91lcNF5MjIHh/x3P32YHfegFGd6Pg1xq7c2ft62+zkMb6VR26RI9yQd6AU/JQIDAQAB";
    //NSLog(@"mutabArr=%@",mutabArr);
    NSMutableString *mutabSTr = @"";
    for (NSString *str in mutabArr) {
        NSString *rsaStr = [RSA encryptString:str publicKey:publicKey];
        if (rsaStr==nil||[rsaStr isEqualToString:@""]) {
            rsaStr=@"";
        }
        mutabSTr = [mutabSTr stringByAppendingString:rsaStr];
        mutabSTr = [mutabSTr stringByAppendingString:@","];
    }
    
    mutabSTr = [mutabSTr  substringToIndex:mutabSTr.length-1];
    return [mutabSTr copy];
    
}

+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    //////NSLog(@"json jiexi dic=%@",dic);
    //    if(err) {
    //        //////NSLog(@"json解析失败：%@",err);
    //        return nil;
    //    }
    return dic;
}


@end
