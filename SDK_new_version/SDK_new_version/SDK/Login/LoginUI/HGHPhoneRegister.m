//
//  HGHPhoneRegister.m
//  SDK_new_version
//
//  Created by Lucas on 2019/12/3.
//  Copyright © 2019 Lucas. All rights reserved.
//

#import "HGHPhoneRegister.h"
#import "HGHTools.h"
#import "HGHMainView.h"
#import <UIKit/UIKit.h>
#import "HGHbaseUITextField.h"
#import "HGHbaseUIButton.h"
#import "HGHFunctionHttp.h"
#import "HGHResponse.h"
#import "HGHAlertview.h"
#import "HGHAccountRegister.h"
#import "HGHPhoneLogin.h"
#import "HGHregular.h"
@implementation HGHPhoneRegister

+(instancetype)shareInstance
{
    static HGHPhoneRegister *regist = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        regist = [[HGHPhoneRegister alloc]init];
    });
    return regist;
}
-(UIImageView *)imageView
{
    if (!_imageView) {
        _imageView =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, MAINVIEWWIDTH, MAINVIEWHEIGHT)];
    }
    return _imageView;
}

-(void)showPhoneRegister
{
        [[HGHMainView shareInstance].baseView addSubview:self.imageView];
    //    self.imageView.backgroundColor = [UIColor blueColor];
        self.imageView.image = [UIImage imageNamed:@"hgh_background.png"];
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
        
        HGHbaseUITextField *codeTF = [[HGHbaseUITextField alloc]initWithFrame:CGRectMake(uilayerX, phoneTF.baseBottom+DISTANCE1, 150, TFHEIGHT)];
    codeTF.placeholder = @"验证码";
        self.codeTF=codeTF;
        [self.imageView addSubview:codeTF];
        
        HGHbaseUIButton *codeBtn = [[HGHbaseUIButton alloc]initWithFrame:CGRectMake(codeTF.baseLeft+5, phoneTF.baseBottom+DISTANCE1, 80, TFHEIGHT)];
        [codeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        [codeBtn setBackgroundImage:[UIImage imageNamed:@"hgh_longBtn.png"] forState:UIControlStateNormal];
        codeBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [self.imageView addSubview:codeBtn];
    [codeBtn addTarget:self action:@selector(getCodeClick:) forControlEvents:UIControlEventTouchUpInside];
        
        HGHbaseUITextField *pwdTF = [[HGHbaseUITextField alloc]initWithFrame:CGRectMake(uilayerX, codeTF.baseBottom+DISTANCE1, TFWIDTH, TFHEIGHT)];
    pwdTF.placeholder = @"密码";
        [self.imageView addSubview:pwdTF];
        self.pwdTF = pwdTF;
        
        HGHbaseUIButton *registerBtn = [[HGHbaseUIButton alloc]initWithFrame:CGRectMake(uilayerX, pwdTF.baseBottom+DISTANCE1, TFWIDTH, TFHEIGHT)];
        [self.imageView addSubview:registerBtn];
//        registerBtn.backgroundColor = [UIColor redColor];
        [registerBtn setBackgroundImage:[UIImage imageNamed:@"hgh_longBtn.png"] forState:UIControlStateNormal];
        [registerBtn setTitle:@"手机立即注册" forState:UIControlStateNormal];
        [registerBtn addTarget:self action:@selector(registerClick:) forControlEvents:UIControlEventTouchUpInside];
        
        CGFloat otherBtnWidth = 110;
        CGFloat x1 = uilayerX+(TFWIDTH/2-otherBtnWidth)/2;
        CGFloat x2 = uilayerX+TFWIDTH/2+(TFWIDTH/2-otherBtnWidth)/2;
        
        HGHbaseUIButton *phoneLoginBtn = [HGHbaseUIButton buttonWithType:UIButtonTypeCustom];
        phoneLoginBtn.frame = CGRectMake(x1, registerBtn.baseBottom+DISTANCE1, otherBtnWidth, 40);
        [phoneLoginBtn setImage:[UIImage imageNamed:@"hgh_testPhone.png"] forState:UIControlStateNormal];
        [phoneLoginBtn setTitle:@"手机登录" forState:UIControlStateNormal];
        [phoneLoginBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        phoneLoginBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [phoneLoginBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 5, 0, 0)];
        [phoneLoginBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 5)];
        [self.imageView addSubview:phoneLoginBtn];
        [phoneLoginBtn addTarget:self action:@selector(phoneLogin:) forControlEvents:UIControlEventTouchUpInside];
        
        
        HGHbaseUIButton *fastLoginBtn = [HGHbaseUIButton buttonWithType:UIButtonTypeCustom];
        fastLoginBtn.frame = CGRectMake(x2, registerBtn.baseBottom+DISTANCE1, otherBtnWidth, 40);
        [fastLoginBtn setImage:[UIImage imageNamed:@"hgh_accountlogin.png.png"] forState:UIControlStateNormal];
        [fastLoginBtn setTitle:@"账号注册" forState:UIControlStateNormal];
        [fastLoginBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        fastLoginBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [fastLoginBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 5, 0, 0)];
        [fastLoginBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 5)];
        [self.imageView addSubview:fastLoginBtn];
        [fastLoginBtn addTarget:self action:@selector(accountRegister:) forControlEvents:UIControlEventTouchUpInside];
    
}

//获取验证码按钮
-(void)getCodeClick:(UIButton *)sender
{
    NSString *phoneNO = self.phoneTF.text;
    [self checkoutCodePhoneNO:phoneNO];
}
//手机注册按钮事件
-(void)registerClick:(UIButton *)sender
{
    NSString *phoneNO = self.phoneTF.text;
    NSString *pwd = self.pwdTF.text;
    NSString *code = self.codeTF.text;
    NSLog(@"userName=%@,pwd=%@,code=%@",phoneNO,pwd,code);
    [self checkoutRegisterPhoneNo:phoneNO code:code pwd:pwd];
}

-(void)clickBack:(UIButton *)sender
{
    [self.imageView removeFromSuperview];
}

-(void)phoneLogin:(UIButton *)sender
{
    [[HGHPhoneLogin shareInstance] showPhoneLogin];
}

-(void)accountRegister:(UIButton *)sender
{
    [[HGHAccountRegister shareInstance] showAccountRegister];
}

//获取验证码检测
-(void)checkoutCodePhoneNO:(NSString *)phoneNO
{
    if (![HGHregular regularPhoneNO:phoneNO]) {
        //请输入正确的手机号
        return;
    }
    [self getCodeRequest:phoneNO];
}

-(void)getCodeRequest:(NSString *)phoneNO
{
    [HGHFunctionHttp HGHGetCaptchaPhoneNO:phoneNO action:@"register" ifSuccess:^(id  _Nonnull response) {
        NSLog(@"register code response=%@",response);
            //验证码发送成功
    } failure:^(NSError * _Nonnull error) {
        NSLog(@"error=%@",error);
    }];
}



//手机注册检测
-(void)checkoutRegisterPhoneNo:(NSString*)phoneNO code:(NSString *)code pwd:(NSString *)pwd
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
    [self phoneRegisterRequestWithPhoneNO:phoneNO code:code pwd:pwd];
}

-(void)phoneRegisterRequestWithPhoneNO:(NSString *)phoneNO code:(NSString *)code pwd:(NSString *)pwd
{
    [HGHFunctionHttp HGHPhoneRegisterWithPhoneno:phoneNO code:code pwd:pwd ifSuccess:^(id  _Nonnull response) {
        NSLog(@"phone register response=%@",response);
        if ([response[@"ret"] intValue]==0) {
            NSLog(@"成功");
            [HGHResponse loginsuccessWithUserData:response logintype:@"1" type:@"register"];
            [HGHTools removeViews:[HGHMainView shareInstance].baseView];
        }else{
            NSString *msg = response[@"msg"];
            [HGHAlertview showAlertViewWithMessage:msg];
        }
    } failure:^(NSError * _Nonnull error) {
        NSLog(@"error=%@",error);
    }];
}

@end
