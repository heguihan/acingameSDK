//
//  HGHShowLogView.m
//  SDK_new_version
//
//  Created by Lucas on 2019/12/9.
//  Copyright © 2019 Lucas. All rights reserved.
//

#import "HGHShowLogView.h"
#import "HGHTools.h"
#import "HGHbaseUILabel.h"

#define MSG_REGULAR_PHOENNO @"请输入正确的手机号"
#define MSG_REGULAR_PASSWORD @"密码应是8-16为数字字母组合"
#define MSG_REGULAR_USERNAME @"账号应是6-18位数字字母组合"
#define MSG_CODE @"请输入验证码"
#define MSG_IDCARD @"身份证不符合要求"

@implementation HGHShowLogView
+(instancetype)shareInstance
{
    static HGHShowLogView *showlog = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        showlog = [[HGHShowLogView alloc]init];
    });
    return showlog;
}

-(HGHbaseUIImageView *)showLogView
{
    if (!_showLogView) {
        CGFloat showViewHeight = 60;
        _showLogView = [[HGHbaseUIImageView alloc]initWithFrame:CGRectMake((SCREENWIDTH-MAINVIEWWIDTH)/2, (SCREENHEIGHT - showViewHeight)/2, MAINVIEWWIDTH, showViewHeight)];
        _showLogView.layer.cornerRadius = 3;
    }
    return _showLogView;
}

-(void)showLogsWithMsg:(NSString *)msg
{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self creatTimer];
        UIViewController *vc = [HGHTools getCurrentVC];
        [vc.view addSubview:self.showLogView];
        self.showLogView.image = [UIImage imageNamed:@"hgh_background.png"];
        self.showLogView.userInteractionEnabled = YES;
        HGHbaseUILabel *showLab = [[HGHbaseUILabel alloc]initWithFrame:self.showLogView.bounds];
        [self.showLogView addSubview:showLab];
        showLab.numberOfLines = 0;
        showLab.text =msg;
        showLab.backgroundColor =[UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1];
        showLab.textAlignment = NSTextAlignmentCenter;
        showLab.font = [UIFont systemFontOfSize:14];
    });
}


-(void)creatTimer
{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(showAlert) userInfo:nil repeats:NO];
}

-(void)showAlert
{
    [self.showLogView removeFromSuperview];
    [self.timer invalidate];
     self.timer = nil;
}
@end
