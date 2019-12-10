//
//  BPMaiweb.m
//  ShuZhiZhangSDK
//
//  Created by SkyGame on 2018/6/27.
//  Copyright © 2018年 John Cheng. All rights reserved.
//

#import "BPMaiweb.h"
#import "BPMaiWebview.h"
#import "HGHSDKConfig.h"
#import "HGHTools.h"
@implementation BPMaiweb

+(instancetype)shareInstance
{
    static BPMaiweb *mai =nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        mai = [[BPMaiweb alloc]init];
    });
    return mai;
}
-(void)BPMaiurl:(NSString *)url andparms:(HGHOrderInfo *)orderInfo
{
    NSLog(@"进来了");
    
    /*
     *   渠道参数
     */
    NSString  *appid = [HGHSDKConfig currentAppID];
    NSString  *appsecret = [HGHSDKConfig currentChannelID];
    NSString *userID = [[NSUserDefaults standardUserDefaults] objectForKey:@"pandasUserID"];
    NSString *yingID = [[NSUserDefaults standardUserDefaults] objectForKey:@"hghpandasyingid"];
    // 平台数据
    NSDictionary *platformDic =@{
                                 @"subject":orderInfo.productName,
                                 @"body":orderInfo.productID
                                 };
    NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:platformDic options:NSJSONWritingPrettyPrinted error:&parseError];
    NSString *payPlatformDataStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
//    NSData *jsonDatahot = [NSJSONSerialization dataWithJSONObject:@{@"ReYun":deviceInfo} options:NSJSONWritingPrettyPrinted error:&parseError];
//    NSString *payPlatformDataStrhot = [[NSString alloc] initWithData:jsonDatahot encoding:NSUTF8StringEncoding];
    // 3.设置请求体
    NSDictionary *jsonDict = @{
                               @"cpOrderID" : orderInfo.cpOrderID,
                               @"extension" :orderInfo.extension,
                               @"gameCallbackUrl": orderInfo.gameCallbackUrl,
                               @"userID" : userID,
                               @"yingID":yingID,
                               @"serverID":orderInfo.serverID,
                               @"serverName":orderInfo.serverName,
                               @"roleID":orderInfo.roleID,
                               @"roleName":orderInfo.roleName,
                               @"money":orderInfo.money,
                               @"productID" :orderInfo.productID,
                               @"channelID":[HGHSDKConfig currentChannelID],
                               @"ts":[NSString stringWithFormat:@"%d",(int)[[NSDate date] timeIntervalSince1970]],
                               @"payPlatformData": payPlatformDataStr
                               };
    
    NSString *payStr = [self getHttpSing:[NSMutableDictionary dictionaryWithDictionary:jsonDict]];
    NSString * payString = [NSString stringWithFormat:@"%@&key=%@",payStr,appsecret];
    //  NSLog(@"BeforeMD5 Str = %@",payString);
    
    NSString *str_sign = [HGHTools md5String:payString];  //md5
    // NSLog(@"str_sign = %@",str_sign);

    NSString *urlStr = [NSString stringWithFormat:@"%@?%@&sign=%@&signType=rsa",url,payStr,str_sign ];
    
        ////////NSLog(@"urlStr222 = %@",urlStr);
        ////////NSLog(@"the end");
    BPMaiWebview *maiwebview = [[BPMaiWebview alloc]init];
    [maiwebview showPurchaseMethodChooseView:urlStr];
}
    
-(void)payh5:(HGHOrderInfo *)orderInfo dict:(NSDictionary *)jsonDict url:(NSString *)url
{
    NSString  *appid = [HGHSDKConfig currentAppID];
    NSString  *appsecret = [HGHSDKConfig currentChannelID];
    NSString *productHgh = orderInfo.productID;
    NSString *payStr = [self getHttpSing:[NSMutableDictionary dictionaryWithDictionary:jsonDict]];
    NSString * payString = [NSString stringWithFormat:@"%@&key=%@",payStr,appsecret];
    
    NSLog(@"before md5 : %@",payString);
//    [Tracking setDD:orderInfo.cpOrderID hbType:@"CNY" hbAmount:[orderInfo.money floatValue]];
    NSString *str_sign = [HGHTools md5String:payString];  //md5
    
    NSString *urlStr = [NSString stringWithFormat:@"%@%@/%@?%@&sign=%@&signType=rsa",url,@"",@"appstore",payStr,str_sign ];
    
    NSLog(@"下单url = %@",urlStr);
    
    [ShuZhiZhangHttpsNetworkHelper postWithUrlString:urlStr parameters:nil success:^(NSDictionary *data) {
        NSLog(@"SDK server下单返回 data= %@",data);
        
        if (data && [[data objectForKey:@"ret"] intValue] == 0) {
            dispatch_async(dispatch_get_main_queue(), ^{
                
                
                BPMaiWebview *maiwebview = [[BPMaiWebview alloc]init];
                [maiwebview showPurchaseMethodChooseView:data[@"url"]];
            });


        }else{
            [BPCustomNoticeBox showCenterWithText:data[@"msg"] duration:2.0];
        }
    } failure:^(NSError *error) {
        
    }];
}

-(NSString*)encodeString:(NSString*)unencodedString{
    
    // CharactersToBeEscaped = @":/?&=;+!@#$()~',*";
    // CharactersToLeaveUnescaped = @"[].";
    NSString *encodedString=nil;
    if ([[[UIDevice currentDevice] systemVersion] floatValue] > 9.0f) {
        encodedString = (NSString *)
        CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                                  (CFStringRef)unencodedString,
                                                                  NULL,
                                                                  (CFStringRef)@"!*'(); :@&=+$,/?%#[]",
                                                                  kCFStringEncodingUTF8));
    }
    
    encodedString = [encodedString stringByReplacingOccurrencesOfString:@"%20" withString:@"+"];
    
    return encodedString;
}

- (NSString *)getHttpSing:(NSMutableDictionary *)dic
{
    
    NSString *str = nil;
    
    NSMutableArray *parameters_array = [NSMutableArray arrayWithArray:[dic allKeys]];
    
    [parameters_array sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [obj1 compare:obj2]; // 升序
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



@end
