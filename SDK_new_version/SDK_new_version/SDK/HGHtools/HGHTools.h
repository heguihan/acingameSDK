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
@end

NS_ASSUME_NONNULL_END
