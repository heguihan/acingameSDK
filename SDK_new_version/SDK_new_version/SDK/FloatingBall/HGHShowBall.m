//
//  HGHShowBall.m
//  testFunc
//
//  Created by Lucas on 2019/11/29.
//  Copyright © 2019 Lucas. All rights reserved.
//

#import "HGHShowBall.h"

@implementation HGHShowBall
+(instancetype)shareInstance
{
    static HGHShowBall *ball = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        ball = [[HGHShowBall alloc]init];
    });
    return ball;
}

+(void)showFloatingball
{
    [HGHShowBall shareInstance].floatBall = [[HGHFloatingBall alloc]initWithFrame:CGRectMake(0, 100, 50, 50)];
    UIViewController *vc = [[UIViewController alloc]init];
    [[HGHShowBall shareInstance].floatBall setRootViewController:vc];
    [[HGHShowBall shareInstance].floatBall makeKeyAndVisible];
}
@end
