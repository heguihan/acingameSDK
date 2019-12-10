//
//  HGHUIConfig.m
//  SDK_new_version
//
//  Created by Lucas on 2019/12/3.
//  Copyright © 2019 Lucas. All rights reserved.
//

#import "HGHUIConfig.h"

@implementation HGHUIConfig
+(CGFloat)ScreenWidth
{
    return [[UIScreen mainScreen] bounds].size.width;
}
+(CGFloat)Screenheight
{
    return [[UIScreen mainScreen] bounds].size.height;
}

+(CGFloat)MainViewWidth
{
    return 300;
}
+(CGFloat)mainViewHeight
{
//    NSLog(@"mainH=%f",222/375*[self Screenheight]);
    return 300;
}
+(CGFloat)FloatScreenWidth:(CGFloat)width
{
//    NSLog(@"screen=%f",[self ScreenWidth]);
    return [self ScreenWidth]/667;
}
+(CGFloat)TFWidth
{
    return 240;
}
+(CGFloat)TFHeight
{
    return 40;
}
+(CGFloat)DistanceHeight1
{
    return 10;
}
+(CGFloat)DistanceHeight2
{
    return 20;
}

+(CGFloat)AccountCenterHeight
{
    return 250;
}
@end
