//
//  HGHResponse.h
//  SDK_new_version
//
//  Created by Lucas on 2019/12/4.
//  Copyright © 2019 Lucas. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HGHResponse : NSObject
+(instancetype)shareInstance;
+(void)loginsuccessWithUserData:(NSDictionary *)dict logintype:(NSString *)loginType type:(NSString *)type;
+(void)responseSuccess:(NSDictionary *)dict;
@end

NS_ASSUME_NONNULL_END
