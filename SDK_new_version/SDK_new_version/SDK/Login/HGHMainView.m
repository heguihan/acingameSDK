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

    NSInteger logintype = [[[NSUserDefaults standardUserDefaults] objectForKey:@"hghpandaslogintype"] integerValue];
    
    NSLog(@"loginType=%ld",(long)logintype);
    if (logintype==2) {
        //账号登录
        NSString *userID = [[NSUserDefaults standardUserDefaults] objectForKey:@"accounthghpandasuser"];
        NSString *pwd = [[NSUserDefaults standardUserDefaults] objectForKey:@"accounthghpandaspwd"];
        [[HGHAccountLogin shareInstance] accountLoginRequestWithUserID:userID pwd:pwd];
        return;
    }else if (logintype==1){
        //手机号登录
        NSString *phoneNO = [[NSUserDefaults standardUserDefaults] objectForKey:@"phonehghpandasphoneno"];
        NSString *pwd = [[NSUserDefaults standardUserDefaults] objectForKey:@"phonehghpandaspwd"];
        [[HGHPhoneLogin shareInstance] phoneLoginRequestWithPhoneNO:phoneNO pwd:pwd];
        return;
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        UIViewController *currentVC = [HGHTools getCurrentVC];
        self.baseView.backgroundColor = [UIColor grayColor];
        [currentVC.view addSubview:self.baseView];
        [[HGHAccountLogin shareInstance] showAccountLogin];
    });

    
}

-(void)showRenzhengViewWithUserInfo:(NSDictionary *)userInfo
{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        UIViewController *currentVC = [HGHTools getCurrentVC];
        self.baseView.backgroundColor = [UIColor grayColor];
        [currentVC.view addSubview:self.baseView];
        [HGHRenzheng shareInstance].pushedBy =@"login";
        [[HGHRenzheng shareInstance] showRenzhengViewWithUserinfo:userInfo];
    });

}
-(void)showAccountBindViewWithUserInfo:(NSDictionary *)userInfo
{
//    dispatch_async(dispatch_get_main_queue(), ^{
//
//        UIViewController *currentVC = [HGHTools getCurrentVC];
//        self.baseView.backgroundColor = [UIColor grayColor];
//        [currentVC.view addSubview:self.baseView];
//        [HGHBindPhoneNO shareInstance].pushedBy =@"login";
//        [[HGHBindPhoneNO shareInstance] showAccountBindViewAndUserInfo:userInfo];
//    });
    UIViewController *currentVC = [HGHTools getCurrentVC];
    self.baseView.backgroundColor = [UIColor grayColor];
    [currentVC.view addSubview:self.baseView];
    [HGHBindPhoneNO shareInstance].pushedBy =@"login";
    [[HGHBindPhoneNO shareInstance] showAccountBindViewAndUserInfo:userInfo];

}
-(void)showGuestBindViewWithUserInfo:(NSDictionary *)userInfo
{
    dispatch_async(dispatch_get_main_queue(), ^{
        
        UIViewController *currentVC = [HGHTools getCurrentVC];
        self.baseView.backgroundColor = [UIColor grayColor];
        [currentVC.view addSubview:self.baseView];
        [HGHGuestBindPhoneNO shareInstance].pushedBy = @"login";
        [[HGHGuestBindPhoneNO shareInstance] showGuestBindViewAndUserInfo:userInfo];
    });

}

-(void)showRenzhengView
{
    dispatch_async(dispatch_get_main_queue(), ^{
        
        UIViewController *currentVC = [HGHTools getCurrentVC];
        self.baseView.backgroundColor = [UIColor grayColor];
        [currentVC.view addSubview:self.baseView];
        [HGHRenzheng shareInstance].pushedBy =@"accountCenter";
        [[HGHRenzheng shareInstance] showRenzhengView];
    });
}
-(void)showAccountBindView
{
    dispatch_async(dispatch_get_main_queue(), ^{
        
        UIViewController *currentVC = [HGHTools getCurrentVC];
        self.baseView.backgroundColor = [UIColor grayColor];
        [currentVC.view addSubview:self.baseView];
        [HGHBindPhoneNO shareInstance].pushedBy =@"accountCenter";
        [[HGHBindPhoneNO shareInstance] showAccountBindView];
    });
}
-(void)showGuestBindView
{
    dispatch_async(dispatch_get_main_queue(), ^{
        
        UIViewController *currentVC = [HGHTools getCurrentVC];
        self.baseView.backgroundColor = [UIColor grayColor];
        [currentVC.view addSubview:self.baseView];
        [HGHGuestBindPhoneNO shareInstance].pushedBy = @"accountCenter";
        [[HGHGuestBindPhoneNO shareInstance] showGuestBindView];
    });
    
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
    [[HGHBindPhoneNO shareInstance] showAccountBindView];
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
