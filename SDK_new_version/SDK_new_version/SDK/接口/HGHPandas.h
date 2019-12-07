//
//  HGHPandas.h
//  SDK_new_version
//
//  Created by Lucas on 2019/12/3.
//  Copyright © 2019 Lucas. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HGHUserInfo.h"
#import "HGHOrderInfo.h"
NS_ASSUME_NONNULL_BEGIN

@interface HGHPandas : NSObject
+(void)SDKinit;
+(void)shareInstance;
+(void)Login;
+(void)LogOut;
+(void)ReportUserInfo:(HGHUserInfo *)userInfo;
+(void)MaiWithOrderInfo:(HGHOrderInfo *)orderInfo;
@end

NS_ASSUME_NONNULL_END
