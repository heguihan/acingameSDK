//
//  HGHTools.h
//  iOS_SDK_chonggou
//
//  Created by Lucas on 2019/11/25.
//  Copyright © 2019 Lucas. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface HGHTools : NSObject
+(instancetype)shareInstance;
+(UIViewController *)getCurrentVC;
+(NSString *)getCurrentTimeString;
+(NSString *) md5String:(NSString *)str;
+(NSString *)sortHttpString:(NSMutableDictionary *)dic;
+(NSString *)getCurrentUserID;
+(NSString *)getCurrentYingID;
+ (void)removeViews:(UIView *)futherView;
+(NSString *)getUUID;
@end

NS_ASSUME_NONNULL_END
