//
//  HGHGetOrderManager.h
//  SDK_new_version
//
//  Created by Lucas on 2019/12/7.
//  Copyright © 2019 Lucas. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HGHOrderInfo.h"
NS_ASSUME_NONNULL_BEGIN

@interface HGHGetOrderManager : NSObject
+(instancetype)shareInstance;
-(void)getOrderIDWithOrderInfo:(HGHOrderInfo *)orderInfo;

@end

NS_ASSUME_NONNULL_END
