//
//  HGHGuestBindPhoneNO.m
//  SDK_new_version
//
//  Created by Lucas on 2019/12/7.
//  Copyright © 2019 Lucas. All rights reserved.
//

#import "HGHGuestBindPhoneNO.h"
#import "HGHTools.h"
#import "HGHMainView.h"
#import <UIKit/UIKit.h>
#import "HGHbaseUITextField.h"
#import "HGHbaseUIButton.h"
#import "HGHAccountRegister.h"
#import "HGHFunctionHttp.h"
#import "HGHResponse.h"
#import "HGHAlertview.h"
#import "HGHregular.h"
@implementation HGHGuestBindPhoneNO

+(instancetype)shareInstance;
{
    static HGHGuestBindPhoneNO *guest = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        guest = [[HGHGuestBindPhoneNO alloc]init];
    });
    return guest;
}
-(UIImageView *)imageView
{
    if (!_imageView) {
        _imageView =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, MAINVIEWWIDTH, MAINVIEWHEIGHT)];
    }
    return _imageView;
}

-(void)showGuestBindViewAndUserInfo:(NSDictionary *)userInfo
{
    self.userInfo = userInfo;
    [self showGuestBindView];
}
-(void)showGuestBindView
{
    [[HGHMainView shareInstance].baseView addSubview:self.imageView];
    self.imageView.backgroundColor = [UIColor whiteColor];
    self.imageView.userInteractionEnabled = YES;
    
    HGHbaseUIButton *backBtn = [[HGHbaseUIButton alloc]initWithFrame:CGRectMake(MAINVIEWWIDTH-30, 10, 20, 20)];
    [self.imageView addSubview:backBtn];
    [backBtn setImage:[UIImage imageNamed:@"hgh_close.png"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(clickBack:) forControlEvents:UIControlEventTouchUpInside];
    
    
    CGFloat uilayerX = (MAINVIEWWIDTH - TFWIDTH)/2;
    HGHbaseUITextField *phoneTF = [[HGHbaseUITextField alloc]initWithFrame:CGRectMake(uilayerX, 50, TFWIDTH, TFHEIGHT)];
    phoneTF.placeholder = @"手机号";
    self.phoneTF = phoneTF;
    [self.imageView addSubview:phoneTF];
    
    HGHbaseUITextField *codeTF = [[HGHbaseUITextField alloc]initWithFrame:CGRectMake(uilayerX, phoneTF.baseBottom+DISTANCE2, 150, TFHEIGHT)];
    self.codeTF = codeTF;
    codeTF.placeholder = @"验证码";
    [self.imageView addSubview:codeTF];
    
    HGHbaseUIButton *codeBtn = [[HGHbaseUIButton alloc]initWithFrame:CGRectMake(codeTF.baseLeft+5, phoneTF.baseBottom+DISTANCE2, 80, TFHEIGHT)];
    [codeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [codeBtn setBackgroundImage:[UIImage imageNamed:@"hgh_longBtn.png"] forState:UIControlStateNormal];
    codeBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.imageView addSubview:codeBtn];
    [codeBtn addTarget:self action:@selector(getCodeClick:) forControlEvents:UIControlEventTouchUpInside];
    
    HGHbaseUITextField *pwdTF = [[HGHbaseUITextField alloc]initWithFrame:CGRectMake(uilayerX, codeTF.baseBottom+DISTANCE2, TFWIDTH, TFHEIGHT)];
    pwdTF.placeholder = @"设置新密码";
    [self.imageView addSubview:pwdTF];
            self.pwdTF = pwdTF;
    HGHbaseUIButton *bindBtn = [[HGHbaseUIButton alloc]initWithFrame:CGRectMake(uilayerX, pwdTF.baseBottom+DISTANCE2, TFWIDTH, TFHEIGHT)];
    [bindBtn setBackgroundImage:[UIImage imageNamed:@"hgh_longBtn.png"] forState:UIControlStateNormal];
    [bindBtn setTitle:@"立即绑定" forState:UIControlStateNormal];
    [self.imageView addSubview:bindBtn];
    [bindBtn addTarget:self action:@selector(bindNow:) forControlEvents:UIControlEventTouchUpInside];
    
    HGHbaseUIButton *nowarringAgainBtn = [[HGHbaseUIButton alloc]initWithFrame:CGRectMake(uilayerX, bindBtn.baseBottom+DISTANCE2, TFWIDTH, TFHEIGHT)];
//    [self.imageView addSubview:nowarringAgainBtn];
    nowarringAgainBtn.backgroundColor = [UIColor redColor];
    [nowarringAgainBtn setTitle:@"不再提示" forState:UIControlStateNormal];
    [nowarringAgainBtn addTarget:self action:@selector(notnoticeToday:) forControlEvents:UIControlEventTouchUpInside];
}

-(void)clickBack:(UIButton *)sender
{
    [HGHResponse responseSuccess:self.userInfo];
    [self.imageView removeFromSuperview];
    [[HGHMainView shareInstance].baseView removeFromSuperview];
}

    //获取验证码事件
-(void)getCodeClick:(UIButton *)sender
{
    NSString *phoneNO = self.phoneTF.text;
    [self checkoutGetCodeWithPhoneNO:phoneNO];
}
-(void)checkoutGetCodeWithPhoneNO:(NSString *)phoneNO
{
    if (![HGHregular regularPhoneNO:phoneNO]) {
            //请输入正确的手机号
        return;
    }
    [self getCodeRequestWithPhoneNO:phoneNO];
}

-(void)getCodeRequestWithPhoneNO:(NSString *)phoneNO
{
    [HGHFunctionHttp HGHGetCaptchaPhoneNO:phoneNO action:@"bind" ifSuccess:^(id  _Nonnull response) {
        if ([response[@"ret"] integerValue]==0) {
                //发送验证码成功
        }
    } failure:^(NSError * _Nonnull error) {
        NSLog(@"error=%@",error);
    }];
}

    //开始绑定
-(void)bindNow:(UIButton *)sender
{
    NSString *phoneNO = self.phoneTF.text;
    NSString *code = self.codeTF.text;
    NSString *pwd = self.pwdTF.text;
    [self checkoutBindWithPhoneNO:phoneNO code:code pwd:pwd];
}

-(void)checkoutBindWithPhoneNO:(NSString *)phoneNO code:(NSString *)code pwd:(NSString *)pwd
{
    if (code.length<1) {
            //请输入验证码
        return;
    }
    if (![HGHregular regularPhoneNO:phoneNO]) {
            //请输入正确的y手机号
        return;
    }
    [self bindRequestWithPhoneNO:phoneNO code:code pwd:pwd];
}
-(void)bindRequestWithPhoneNO:(NSString *)phoneNO code:(NSString *)code pwd:(NSString *)pwd
{
    NSString *userID=[[NSUserDefaults standardUserDefaults] objectForKey:@"pandasUserID"];
    NSLog(@"userID=%@",userID);
    __weak __typeof__(self) weakSelf = self;
    [HGHFunctionHttp HGHBindPwd:pwd code:code phoneNO:phoneNO userID:userID ifSuccess:^(id  _Nonnull response) {
        if ([response[@"ret"] integerValue]==0) {
            [HGHResponse responseSuccess:weakSelf.userInfo];
        }else{
            [HGHAlertview showAlertViewWithMessage:response[@"msg"]];
        }
    } failure:^(NSError * _Nonnull error) {
        NSLog(@"error=%@",error);
    }];
}

    //今日不再提示
-(void)notnoticeToday:(UIButton *)sender
{
    
}
@end
