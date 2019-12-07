//
//  HGHChangePwd.m
//  SDK_new_version
//
//  Created by Lucas on 2019/12/5.
//  Copyright © 2019 Lucas. All rights reserved.
//

#import "HGHChangePwd.h"
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
@implementation HGHChangePwd
+(instancetype)shareInstance
{
    static HGHChangePwd *changePwd = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        changePwd = [[HGHChangePwd alloc]init];
    });
    return changePwd;
}

-(UIImageView *)imageView
{
    if (!_imageView) {
        _imageView =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, MAINVIEWWIDTH, MAINVIEWHEIGHT)];
    }
    return _imageView;
}
    
-(void)showChangePwdView
{
    [[HGHMainView shareInstance].baseView addSubview:self.imageView];
    self.imageView.backgroundColor = [UIColor whiteColor];
    
    self.imageView.userInteractionEnabled = YES;
    HGHbaseUIButton *backBtn = [[HGHbaseUIButton alloc]initWithFrame:CGRectMake(20, 10, 16, 30)];
    [self.imageView addSubview:backBtn];
//    backBtn.backgroundColor = [UIColor redColor];
    [backBtn setImage:[UIImage imageNamed:@"hgh_goback.png"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(clickBack:) forControlEvents:UIControlEventTouchUpInside];
    CGFloat uilayerX = (MAINVIEWWIDTH - TFWIDTH)/2;
    HGHbaseUITextField *phoneTF = [[HGHbaseUITextField alloc]initWithFrame:CGRectMake(uilayerX, 50, TFWIDTH, TFHEIGHT)];
    phoneTF.placeholder = @"手机号";
    self.phoneTF = phoneTF;
    [self.imageView addSubview:phoneTF];
        
    HGHbaseUITextField *codeTF = [[HGHbaseUITextField alloc]initWithFrame:CGRectMake(uilayerX, phoneTF.baseBottom+DISTANCE2, 150, TFHEIGHT)];
    codeTF.placeholder = @"验证码";
    self.codeTF = codeTF;
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
        
    HGHbaseUIButton *changePwdBtn = [[HGHbaseUIButton alloc]initWithFrame:CGRectMake(uilayerX, pwdTF.baseBottom+DISTANCE2, TFWIDTH, TFHEIGHT)];
    [self.imageView addSubview:changePwdBtn];
    [changePwdBtn setBackgroundImage:[UIImage imageNamed:@"hgh_longBtn"] forState:UIControlStateNormal];
    [changePwdBtn setTitle:@"修改完成" forState:UIControlStateNormal];
    [changePwdBtn addTarget:self action:@selector(changePwd:) forControlEvents:UIControlEventTouchUpInside];
    
}

-(void)clickBack:(UIButton *)sender
{
    [self.imageView removeFromSuperview];
}

//获取验证码事件
-(void)getCodeClick:(UIButton *)sender
{
    NSString *phoneNO = self.phoneTF.text;
    [self checkoutPhoneNO:phoneNO];
    
}

-(void)checkoutPhoneNO:(NSString *)phoneNO
{
    if (![HGHregular regularPhoneNO:phoneNO]) {
        //请输入正确的手机号
        return;
    }
    [self getCodeRequestWithPhoneNO:phoneNO];
}

-(void)getCodeRequestWithPhoneNO:(NSString *)phoneNO
{
    [HGHFunctionHttp HGHGetCaptchaPhoneNO:phoneNO action:@"update" ifSuccess:^(id  _Nonnull response) {
        if ([response[@"ret"] integerValue]==0) {
            //验证码发送成功
        }
    } failure:^(NSError * _Nonnull error) {
        NSLog(@"error=%@",error);
    }];
}

//修改密码
-(void)changePwd:(UIButton *)sender
{
    NSString *phoneNO = self.phoneTF.text;
    NSString *code = self.codeTF.text;
    NSString *pwd = self.pwdTF.text;
    [self checkoutChangePWDWithPhoneNO:phoneNO code:code pwd:pwd];
    
}

-(void)checkoutChangePWDWithPhoneNO:(NSString *)phoneNO code:(NSString *)code pwd:(NSString *)pwd
{
    if (code.length<1) {
        //请输入验证码
        return;
    }
    if (![HGHregular regularPhoneNO:phoneNO]) {
        //请输入正确的手机号
        return;
    }
    if (![HGHregular regularPassword:pwd]) {
        //密码应在8-16位数字字母组合
        return;
    }
    [self changePwdRequestWithPhoneNO:phoneNO code:code pwd:pwd];
}
-(void)changePwdRequestWithPhoneNO:(NSString *)phone code:(NSString *)code pwd:(NSString *)pwd
{
    [HGHFunctionHttp HGHChangePwd:pwd code:code phoneNO:phone ifSuccess:^(id  _Nonnull response) {
        if ([response[@"ret"] integerValue]==0) {
            //修改密码成功
        }
    } failure:^(NSError * _Nonnull error) {
        NSLog(@"error=%@",error);
    }];
}

@end
