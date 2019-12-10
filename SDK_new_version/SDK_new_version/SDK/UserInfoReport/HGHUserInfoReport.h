//
//  HGHUserInfoReport.h
//  SDK_new_version
//
//  Created by Lucas on 2019/12/9.
//  Copyright © 2019 Lucas. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HGHUserInfo.h"
NS_ASSUME_NONNULL_BEGIN

@interface HGHUserInfoReport : NSObject
+(instancetype)shareInstance;
+(void)reportUserInfo:(HGHUserInfo *)userInfo;
@end

NS_ASSUME_NONNULL_END
