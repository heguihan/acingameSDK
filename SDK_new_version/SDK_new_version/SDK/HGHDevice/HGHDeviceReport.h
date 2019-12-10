//
//  HGHDeviceReport.h
//  ShuZhiZhangSDK
//
//  Created by Lucas on 2019/11/5.
//  Copyright © 2019 John Cheng. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HGHDeviceReport : NSObject
//登录和注册传一个id
+(void)HGHreportDeviceInfo:(NSDictionary *)deviceInfo ename:(NSString *)ename;
@end

NS_ASSUME_NONNULL_END
