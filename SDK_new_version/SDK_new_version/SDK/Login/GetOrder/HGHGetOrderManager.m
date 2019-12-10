//
//  HGHGetOrderManager.m
//  SDK_new_version
//
//  Created by Lucas on 2019/12/7.
//  Copyright © 2019 Lucas. All rights reserved.
//

#import "HGHGetOrderManager.h"
#import "HGHFunctionHttp.h"
#import "HGHIAPManager.h"
#import "HGHAlertview.h"
#import "Tracking.h"

@implementation HGHGetOrderManager
+(instancetype)shareInstance
{
    static HGHGetOrderManager *orderManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        orderManager = [[HGHGetOrderManager alloc]init];
    });
    return orderManager;
}
/*
response={
    data =     (
    );
    msg = "\U6210\U529f";
    orderID = 126609628199028523008;
    productID = com;
    ret = 0;
    timestamp = 1575858163;
    userID = hghtest;
}
 
 */

-(void)getOrderIDWithOrderInfo:(HGHOrderInfo *)orderInfo
{
    //热云上报
    [Tracking setDD:orderInfo.cpOrderID hbType:@"CNY" hbAmount:[orderInfo.money floatValue]];
    
    NSString *maiway = [[NSUserDefaults standardUserDefaults] objectForKey:@"hghpandasmaiway"];
    if ([maiway integerValue]==1) {
        NSString *url = [[NSUserDefaults standardUserDefaults] objectForKey:@"hghpandasmaiurl"];
        [self getotherOrderWithorderInfo:orderInfo andurl:url];
        return;
    }
    
    [self getiaporderWithOrderInfo:orderInfo];//apple
}

-(void)getiaporderWithOrderInfo:(HGHOrderInfo *)orderInfo
{
    [HGHFunctionHttp HGHGetOrder:orderInfo ifSuccess:^(id  _Nonnull response) {
        NSLog(@"getOrder response=%@",response);
        if ([response[@"ret"] integerValue]==0) {
            NSString *orderID = response[@"orderID"];
            [[HGHIAPManager shareinstance] requestIAPWithOrderInfo:orderInfo andOrderID:orderID];
        }else{
            [HGHAlertview showAlertViewWithMessage:[response objectForKey:@"msg"]];
        }
    } failure:^(NSError * _Nonnull error) {
        NSLog(@"getorder error=%@",error);
    }];
}

/*
 response={
 msg = "\U6210\U529f";
 referer = "http://192.168.1.87:8082";
 ret = 0;
 timestamp = 1575982196;
 url = "http://192.168.1.87:8082/checkout/tCu5P4FZLIzYcUDTXI6VvUhfwg1mI1UJ9KSfZ7JNvmU";
 }
 */


-(void)getotherOrderWithorderInfo:(HGHOrderInfo *)orderInfo andurl:(NSString *)url
{
//    [[BPMaiweb shareInstance]BPMaiurl:url andparms:orderInfo];
    [HGHFunctionHttp HGHGetOtherOrder:orderInfo andUrl:url ifSuccess:^(id  _Nonnull response) {
        NSLog(@"response other order=%@",response);
    } failure:^(NSError * _Nonnull error) {
        NSLog(@"error=%@",error);
    }];
}
@end
