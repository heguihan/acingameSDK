//
//  HGHDeviceType.h
//  testFunc
//
//  Created by Lucas on 2019/11/29.
//  Copyright © 2019 Lucas. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN


@interface HGHDeviceType : NSObject

typedef enum Orientation{
    HGHPortrait,
    HGHLandscapeLeft,
    HGHLandscapeRight,
}Orientation;

+(BOOL)DeviceLiuhai;
+(NSInteger)DeviceOrientation;
+(BOOL)isInLiuhai:(CGFloat)y;
@end

NS_ASSUME_NONNULL_END
