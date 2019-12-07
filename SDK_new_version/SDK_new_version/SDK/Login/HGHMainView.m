//
//  HGHMainView.m
//  iOS_SDK_chonggou
//
//  Created by Lucas on 2019/11/25.
//  Copyright © 2019 Lucas. All rights reserved.
//

#import "HGHMainView.h"

#import "HGHTools.h"
#import <UIKit/UIKit.h>
#import "HGHBaseview.h"
#import "HGHbaseUITextField.h"
#import "HGHbaseUIButton.h"
#import "HGHbaseUILabel.h"
#import "HGHAccountLogin.h"
#import "HGHPhoneLogin.h"
#import "HGHAccountRegister.h"
#import "HGHPhoneRegister.h"
#import "HGHChangePwd.h"
#import "HGHBindPhoneNO.h"
#import "HGHRenzheng.h"
#import "HGHGuestBindPhoneNO.h"
#import "HGHRenzheng.h"
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

-(UIView *)baseView
{
    if (!_baseView) {
        _baseView =[[HGHBaseview alloc]initWithFrame:CGRectMake((SCREENWIDTH-MAINVIEWWIDTH)/2, (SCREENHEIGHT - MAINVIEWHEIGHT)/2, MAINVIEWWIDTH, MAINVIEWHEIGHT)];
        _baseView.layer.cornerRadius = 10;
    }
    return _baseView;
}
-(void)login
{

    UIViewController *currentVC = [HGHTools getCurrentVC];
    self.baseView.backgroundColor = [UIColor grayColor];
    [currentVC.view addSubview:self.baseView];
    
     [[HGHAccountLogin shareInstance] showAccountLogin];
    
    NSArray *btnTitles = @[@"账号绑定",@"账号",@"游客绑定"];
    CGFloat btnW = 60;
    for (int i=0; i<3; i++) {
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(30+(30+btnW)*i, 80, btnW, btnW)];
//        [self.baseView addSubview:btn];
        btn.tag = 160+i;
        btn.backgroundColor = [UIColor greenColor];
        [btn setTitle:btnTitles[i] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(ClickBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:@"hgh_phone.png"] forState:UIControlStateNormal];
    [button setTitle:@"左边文字，右边图片" forState:UIControlStateNormal];
    [button setTitleEdgeInsets:UIEdgeInsetsMake(0, - button.imageView.image.size.width, 0, button.imageView.image.size.width)];
    [button setImageEdgeInsets:UIEdgeInsetsMake(0, button.titleLabel.bounds.size.width, 0, -button.titleLabel.bounds.size.width)];
    
//    [self.baseView addSubview:button];
    
}

-(void)showRenzhengView
{
    UIViewController *currentVC = [HGHTools getCurrentVC];
    self.baseView.backgroundColor = [UIColor grayColor];
    [currentVC.view addSubview:self.baseView];
    
    [[HGHRenzheng shareInstance] showRenzhengView];
}
-(void)showAccountBindView
{
    UIViewController *currentVC = [HGHTools getCurrentVC];
    self.baseView.backgroundColor = [UIColor grayColor];
    [currentVC.view addSubview:self.baseView];
    
    [[HGHBindPhoneNO shareInstance] showChangePwdView];
}
-(void)showGuestBindView
{
    UIViewController *currentVC = [HGHTools getCurrentVC];
    self.baseView.backgroundColor = [UIColor grayColor];
    [currentVC.view addSubview:self.baseView];
    
    [[HGHGuestBindPhoneNO shareInstance] showGuestBindView];
}



-(void)ClickBtn:(UIButton *)sender
{
    switch (sender.tag) {
        case 160:
            [self geustlogin];
            break;
        case 161:
            [self accountlogin];
            break;
        case 162:
            [self phonelogin];
            break;
            
        default:
            break;
    }
}

-(void)geustlogin
{
    NSLog(@"游客登录");
//    [[HGHPhoneLogin shareInstance] showPhoneLogin];
//    [[HGHPhoneRegister shareInstance] showPhoneRegister];
    [[HGHBindPhoneNO shareInstance] showChangePwdView];
}

-(void)accountlogin
{
    NSLog(@"账号登录");
    [[HGHAccountLogin shareInstance] showAccountLogin];
//    [[HGHAccountRegister shareInstance] showAccountRegister];
}

-(void)phonelogin
{
    NSLog(@"手机登录");
//    [[HGHPhoneLogin shareInstance] showPhoneLogin];
//    [[HGHChangePwd shareInstance] showChangePwdView];
//    [[HGHBindPhoneNO shareInstance] showChangePwdView];
    
//    [[HGHRenzheng shareInstance] showRenzhengView];
    [[HGHGuestBindPhoneNO shareInstance] showGuestBindView];
}
@end
