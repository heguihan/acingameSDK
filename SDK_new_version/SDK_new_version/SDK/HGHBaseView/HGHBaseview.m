//
//  HGHBaseview.m
//  iOS_SDK_chonggou
//
//  Created by Lucas on 2019/11/25.
//  Copyright © 2019 Lucas. All rights reserved.
//

#import "HGHBaseview.h"
#import <UIKit/UIKit.h>
@implementation HGHBaseview

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)setBaseX:(CGFloat)baseX
{
    CGRect frame = self.frame;
    frame.origin.x = baseX;
    self.frame = frame;
//    self.frame.origin.x = baseX;
    
}
-(void)setBaseY:(CGFloat)baseY
{
//    self.frame.origin.y = baseY;
    CGRect frame = self.frame;
    frame.origin.y = baseY;
    self.frame = frame;
}

-(void)setBaseWidth:(CGFloat)baseWidth
{
//    self.frame.size.width = baseWidth;
    CGRect frame = self.frame;
    frame.size.width = baseWidth;
    self.frame = frame;
}

-(void)setBaseHeight:(CGFloat)baseHeight
{
    CGRect frame = self.frame;
    frame.size.height = baseHeight;
    self.frame = frame;
}

//-(void)setBaseCenter:(CGPoint)baseCenter
//{
//    self.center = baseCenter;
//}

-(CGFloat)baseX
{
    return self.frame.origin.x;
}

-(CGFloat)baseY
{
    return self.frame.origin.y;
}

-(CGFloat)baseWidth
{
    return self.frame.size.width;
}

-(CGFloat)baseHeight
{
    return self.frame.size.height;
}

//-(CGPoint)baseCenter
//{
//    CGFloat centerx = [self baseX]+[self baseWidth]/2;
//    CGFloat centery = [self baseY]+[self baseHeight]/2;
//    CGPoint center = CGPointMake(centerx, centery);
//    return center;
//}
@end
