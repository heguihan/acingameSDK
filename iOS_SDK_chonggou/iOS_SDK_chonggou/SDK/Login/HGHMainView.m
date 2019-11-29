//
//  HGHMainView.m
//  iOS_SDK_chonggou
//
//  Created by Lucas on 2019/11/25.
//  Copyright © 2019 Lucas. All rights reserved.
//

#import "HGHMainView.h"
#import "HGHBaseview.h"
#import "HGHTools.h"
#import <UIKit/UIKit.h>
@implementation HGHMainView
+(instancetype)shareInstance
{
    static HGHMainView *mainV = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        mainV = [[HGHMainView alloc]init];
    });
    return mainV;
}
-(void)login
{
    HGHBaseview *loginV = [[HGHBaseview alloc]initWithFrame:CGRectMake(100, 50, 200, 200)];
    UIViewController *currentVC = [HGHTools getCurrentVC];
    loginV.backgroundColor = [UIColor redColor];
    
    [currentVC.view addSubview:loginV];
    NSLog(@"x=%f,y=%f,width=%f,height=%f",loginV.baseX,loginV.baseY,loginV.baseWidth,loginV.baseHeight);
    
    HGHBaseview *otherV = [[HGHBaseview alloc]init];
//    otherV.baseX = 400;
//    otherV.baseY = 50;
    otherV.center = CGPointMake(500, 100);
    CGSize size = otherV.frame.size;
    size = CGSizeMake(200, 200);
    CGRect frame = otherV.frame;
    frame.size = size;
    otherV.frame = frame;
//    otherV.frame.size = size;
//    otherV.baseWidth = 200;
//    otherV.baseHeight = 100;
    otherV.backgroundColor = [UIColor greenColor];
    [currentVC.view addSubview:otherV];
    NSLog(@"x=%f,y=%f",otherV.baseX,otherV.baseY);
    NSLog(@"rcx=%f,rcy=%f",otherV.center.x,otherV.center.y);
}
@end
