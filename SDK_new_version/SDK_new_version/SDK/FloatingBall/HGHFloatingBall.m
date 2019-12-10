//
//  HGHFloatingBall.m
//  testFunc
//
//  Created by Lucas on 2019/11/29.
//  Copyright © 2019 Lucas. All rights reserved.
//

#import "HGHFloatingBall.h"
#import "HGHDeviceType.h"
#import "HGHAccountManager.h"
@implementation HGHFloatingBall
static CGPoint originPoint;
+(instancetype)shareInstance
{
    static HGHFloatingBall *floating = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        floating = [[HGHFloatingBall alloc]init];
    });
    return floating;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        self.frame = frame;
        self.backgroundColor = [UIColor clearColor];
        self.windowLevel = UIWindowLevelAlert+1;
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(gesturPan:)];
        [self addGestureRecognizer:pan];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(gesturTap:)];
        [self addGestureRecognizer:tap];
        UIImageView *imageV = [[UIImageView alloc]initWithFrame:self.bounds];
        [self addSubview:imageV];
        imageV.image = [UIImage imageNamed:@"apple_icon.png"];
        self.isHalfHidden = NO;
    }
    return self;
}


-(void)gesturPan:(UIPanGestureRecognizer *)sender
{
    UIView *testView = sender.view;
    CGPoint startPoint;
    //    __block CGPoint originPoint = CGPointZero;
    NSLog(@"xxxxxxxaa");
    if (sender.state == UIGestureRecognizerStateBegan) {
        NSLog(@"start point");
        startPoint = [sender locationInView:sender.view];
        originPoint = testView.center;
        NSLog(@"startPoint=%f,%f,originPoint=%f,%f",startPoint.x,startPoint.y,originPoint.x,originPoint.y);
    }else if (sender.state == UIGestureRecognizerStateChanged){
        NSLog(@" state Changed");
        CGPoint newPoint = [sender locationInView:sender.view];
        CGFloat deltaX = newPoint.x-startPoint.x;
        CGFloat deltaY = newPoint.y-startPoint.y;
        testView.center = CGPointMake(testView.center.x+deltaX, testView.center.y+deltaY);
        originPoint = testView.center;
        NSLog(@"ChangedOriginPoint%f,%f",originPoint.x,originPoint.y);
    }else if (sender.state == UIGestureRecognizerStateEnded){
        NSLog(@"state ended");
        NSLog(@"OutOriginPoint%f,%f",originPoint.x,originPoint.y);
        [UIView animateWithDuration:0.5 animations:^{
            NSLog(@"xxxoriginPoint%f,%f",originPoint.x,originPoint.y);
            if (originPoint.x-testView.frame.size.width/2<=0) {
                originPoint.x = testView.frame.size.width/2 +10;
            }
            if (originPoint.y - testView.frame.size.height/2  <=0) {
                originPoint.y = testView.frame.size.height/2 +10;
            }
            if (originPoint.x >= [UIScreen mainScreen].bounds.size.width - testView.frame.size.width/2) {
                originPoint.x = [UIScreen mainScreen].bounds.size.width - testView.frame.size.width/2 -10;
            }
            if (originPoint.y >=[UIScreen mainScreen].bounds.size.height - testView.frame.size.height/2) {
                originPoint.y = [UIScreen mainScreen].bounds.size.height - testView.frame.size.height/2 - 10;
            }
            if (originPoint.x>[UIScreen mainScreen].bounds.size.width/2) {
                if ([HGHDeviceType DeviceLiuhai]&&[HGHDeviceType DeviceOrientation]==1&&[HGHDeviceType isInLiuhai:originPoint.y-testView.frame.size.height/2])//刘海在左
                {
                    originPoint.x = [UIScreen mainScreen].bounds.size.width - testView.frame.size.width/2 -30;//刘海高度34
                }else{
                    originPoint.x = [UIScreen mainScreen].bounds.size.width - testView.frame.size.width/2;
                }
                
            }else{
                if ([HGHDeviceType DeviceLiuhai]&&[HGHDeviceType DeviceOrientation]==2&&[HGHDeviceType isInLiuhai:originPoint.y-testView.frame.size.height/2]){
                    NSLog(@"originPPPP.yyy=%f",originPoint.y);
                    originPoint.x = testView.frame.size.width/2+30;
                }else{
                    originPoint.x = testView.frame.size.width/2;
                }
                
            }
            NSLog(@"originPoint%f,%f",originPoint.x,originPoint.y);
            testView.center = originPoint;
            
        }];
        [self endPoint];
    }
}

-(void)endPoint
{
    NSLog(@"endPoint");
    NSLog(@"windowxxa center=%f,%f",self.frame.origin.x,self.frame.origin.y);
    [self halfHidden];
}

-(void)halfHidden
{
    self.isHalfHidden = YES;
    CGRect frame = self.frame;
    if (frame.origin.x>[UIScreen mainScreen].bounds.size.width/2) {
        frame = CGRectMake(frame.origin.x+frame.size.width/2, frame.origin.y, frame.size.width, frame.size.height);
    }else{
        frame = CGRectMake(frame.origin.x-frame.size.width/2, frame.origin.y, frame.size.width, frame.size.height);
    }
    self.frame = frame;
}

-(void)gesturTap:(UITapGestureRecognizer *)sender
{
    [[HGHAccountManager shareInstance] showAccountManager];
}

@end
