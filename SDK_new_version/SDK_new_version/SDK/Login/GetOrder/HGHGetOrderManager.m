//
//  HGHGetOrderManager.m
//  SDK_new_version
//
//  Created by Lucas on 2019/12/7.
//  Copyright © 2019 Lucas. All rights reserved.
//

#import "HGHGetOrderManager.h"
#import "HGHFunctionHttp.h"

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
-(void)getOrderIDWithOrderInfo:(HGHOrderInfo *)orderInfo
{
    [HGHFunctionHttp HGHGetOrder:orderInfo ifSuccess:^(id  _Nonnull response) {
        NSLog(@"getOrder response=%@",response);
    } failure:^(NSError * _Nonnull error) {
        NSLog(@"getorder error=%@",error);
    }];
}
@end
