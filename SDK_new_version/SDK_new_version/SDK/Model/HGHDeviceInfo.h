//
//  HGHDeviceInfo.h
//  SDK_new_version
//
//  Created by Lucas on 2019/12/2.
//  Copyright © 2019 Lucas. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HGHDeviceInfo : NSObject
@property(nonatomic,strong)NSString *deviceID;
@property(nonatomic,strong)NSString *deviceDpi;
@property(nonatomic,strong)NSString *deviceImei;
@property(nonatomic,strong)NSString *deviceOS;
@property(nonatomic,strong)NSString *deviceType;
@property(nonatomic,strong)NSString *mac;
@end

NS_ASSUME_NONNULL_END
