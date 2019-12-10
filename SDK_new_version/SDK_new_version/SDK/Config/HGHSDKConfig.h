//
//  HGHSDKConfig.h
//  SDK_new_version
//
//  Created by Lucas on 2019/12/3.
//  Copyright © 2019 Lucas. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HGHSDKConfig : NSObject
+(NSString *)currentChannelID;
+(NSString *)currentAppID;
+(NSString *)currentAppKey;
+(NSString *)reyunAppKey;
+(NSString *)dmAppID;
+(NSString *)dmAppKey;
+(NSString *)SDKVersion;
@end

NS_ASSUME_NONNULL_END
