//
//  HGHHttpRequest.m
//  SDK_new_version
//
//  Created by Lucas on 2019/11/29.
//  Copyright © 2019 Lucas. All rights reserved.
//

#import "HGHHttpRequest.h"
#import "HGHExchange.h"
@implementation HGHHttpRequest

+(void)POSTNEW:(NSString*)URL paramString:(NSDictionary*)dict ifSuccess:(void(^)(id response))success failure:(void(^)(NSError *error))failure
{

    NSString *resultParamStr = [HGHExchange exchangeStringWithdict:dict];
    NSLog(@"resultParamStr=%@",resultParamStr);
    NSMutableURLRequest*request=[NSMutableURLRequest requestWithURL:[NSURL URLWithString:URL] cachePolicy:(NSURLRequestUseProtocolCachePolicy) timeoutInterval:500];
    [request setHTTPMethod:@"POST"];
    
    NSData*paraData=[resultParamStr dataUsingEncoding:NSUTF8StringEncoding];
    
    [request setHTTPBody:paraData];
    
    [self sendRequest:request ifSuccess:^(id response) {
//        NSLog(@"response=%@",response);
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
        if (data) {
            NSDictionary*dict=[NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingMutableLeaves) error:nil];
            NSLog(@"%@",dict);
            dispatch_async(dispatch_get_main_queue(), ^{
                success(dict);
            });
        }else
        {
            NSLog(@"%@",error);
            failure(error);
        }
    }];
    [sessionDataTask resume];
}

@end
