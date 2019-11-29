//
//  HGHHttpRequest.h
//  SDK_new_version
//
//  Created by Lucas on 2019/11/29.
//  Copyright © 2019 Lucas. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HGHHttpRequest : NSObject
+(void)POSTNEW:(NSString*)URL paramString:(NSDictionary*)dict ifSuccess:(void(^)(id response))success failure:(void(^)(NSError *error))failure;
@end

NS_ASSUME_NONNULL_END
