//
//  HGHDeviceType.m
//  testFunc
//
//  Created by Lucas on 2019/11/29.
//  Copyright © 2019 Lucas. All rights reserved.
//

#import "HGHDeviceType.h"

@implementation HGHDeviceType
+(BOOL)DeviceLiuhai
{
    CGFloat a = 0;
    if (@available(iOS 11.0, *)) {
        a = [[UIApplication sharedApplication] delegate].window.safeAreaInsets.bottom;
    } else {
        
    }
    if (a>0) {
        return YES;
    }
    return NO;
}
+(NSInteger)DeviceOrientation
{
    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
    if (orientation==UIInterfaceOrientationLandscapeLeft) {
        return 1;
    }else if (orientation==UIInterfaceOrientationLandscapeRight){
        return 2;
    }else{
        return 3;
    }
}

+(BOOL)isInLiuhai:(CGFloat)y
{
    if (y>38&&y<286) {
        return YES;
    }
    return NO;
}
@end
