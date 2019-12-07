//
//  HGHPhoneLogin.m
//  SDK_new_version
//
//  Created by Lucas on 2019/12/3.
//  Copyright © 2019 Lucas. All rights reserved.
//

#import "HGHPhoneLogin.h"
#import "HGHTools.h"
#import "HGHMainView.h"
#import <UIKit/UIKit.h>
#import "HGHbaseUITextField.h"
#import "HGHbaseUIButton.h"
#import "HGHPhoneRegister.h"
#import "HGHFunctionHttp.h"
#import "HGHResponse.h"
#import "HGHAlertview.h"
#import "HGHPhoneRegister.h"
#import "HGHAccountRegister.h"
#import "HGHChangePwd.h"
#import "HGHregular.h"
@implementation HGHPhoneLogin

+(instancetype)shareInstance
{
    static HGHPhoneLogin *phone = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        phone = [[HGHPhoneLogin alloc]init];
    });
    return phone;
}
-(UIImageView *)imageView
{
    if (!_imageView) {
        _imageView =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, MAINVIEWWIDTH, MAINVIEWHEIGHT)];
    }
    return _imageView;
}

-(void)showPhoneLogin
{
    [[HGHMainView shareInstance].baseView addSubview:self.imageView];
    //    self.imageView.backgroundColor = [UIColor blueColor];
    self.imageView.image = [UIImage imageNamed:@"hgh_background.png"];
    self.imageView.userInteractionEnabled = YES;
    HGHbaseUIButton *backBtn = [[HGHbaseUIButton alloc]initWithFrame:CGRectMake(10, 10, 16, 30)];
    [self.imageView addSubview:backBtn];
    //    backBtn.backgroundColor = [UIColor redColor];
    [backBtn setImage:[UIImage imageNamed:@"hgh_goback.png"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(clickBack:) forControlEvents:UIControlEventTouchUpInside];
    CGFloat uilayerX = (MAINVIEWWIDTH - TFWIDTH)/2;
    HGHbaseUITextField *phoneTF = [[HGHbaseUITextField alloc]initWithFrame:CGRectMake(uilayerX, backBtn.baseBottom+20, TFWIDTH, TFHEIGHT)];
    phoneTF.placeholder = @"手机号";
    self.phoneTF = phoneTF;
    [self.imageView addSubview:phoneTF];

    HGHbaseUITextField *pwdTF = [[HGHbaseUITextField alloc]initWithFrame:CGRectMake(uilayerX, phoneTF.baseBottom+DISTANCE2, TFWIDTH, TFHEIGHT)];
    pwdTF.placeholder = @"密码";
    [self.imageView addSubview:pwdTF];
    self.pwdTF = pwdTF;
    
    HGHbaseUIButton *forgotPwdBtn = [[HGHbaseUIButton alloc]initWithFrame:CGRectMake(uilayerX, pwdTF.baseBottom+DISTANCE1/2, 60, 15)];
    [forgotPwdBtn setTitle:@"忘记密码" forState:UIControlStateNormal];
    [self.imageView addSubview:forgotPwdBtn];
    forgotPwdBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [forgotPwdBtn setTitleColor:[UIColor colorWithRed:246/255.0 green:83/255.0 blue:86/255.0 alpha:1] forState:UIControlStateNormal];
    [forgotPwdBtn addTarget:self action:@selector(forgotPwd:) forControlEvents:UIControlEventTouchUpInside];
    
    HGHbaseUIButton *registerBtn = [[HGHbaseUIButton alloc]initWithFrame:CGRectMake(uilayerX, forgotPwdBtn.baseBottom+DISTANCE1/2, TFWIDTH, TFHEIGHT)];
    [self.imageView addSubview:registerBtn];
//    registerBtn.backgroundColor = [UIColor redColor];
    [registerBtn setBackgroundImage:[UIImage imageNamed:@"hgh_longBtn.png"] forState:UIControlStateNormal];
    [registerBtn setTitle:@"手机登录" forState:UIControlStateNormal];
    [registerBtn addTarget:self action:@selector(phoneLogin:) forControlEvents:UIControlEventTouchUpInside];
    
    CGFloat otherBtnWidth = 110;
    CGFloat x1 = uilayerX+(TFWIDTH/2-otherBtnWidth)/2;
    CGFloat x2 = uilayerX+TFWIDTH/2+(TFWIDTH/2-otherBtnWidth)/2;
    
    HGHbaseUIButton *phoneLoginBtn = [HGHbaseUIButton buttonWithType:UIButtonTypeCustom];
    phoneLoginBtn.frame = CGRectMake(x1, registerBtn.baseBottom+DISTANCE2, otherBtnWidth, 40);
    [phoneLoginBtn setImage:[UIImage imageNamed:@"hgh_testPhone.png"] forState:UIControlStateNormal];
    [phoneLoginBtn setTitle:@"手机注册" forState:UIControlStateNormal];
    [phoneLoginBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    phoneLoginBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [phoneLoginBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 5, 0, 0)];
    [phoneLoginBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 5)];
    [self.imageView addSubview:phoneLoginBtn];
    [phoneLoginBtn addTarget:self action:@selector(phoneRegister:) forControlEvents:UIControlEventTouchUpInside];
    
    
    HGHbaseUIButton *fastLoginBtn = [HGHbaseUIButton buttonWithType:UIButtonTypeCustom];
    fastLoginBtn.frame = CGRectMake(x2, registerBtn.baseBottom+DISTANCE2, otherBtnWidth, 40);
    [fastLoginBtn setImage:[UIImage imageNamed:@"hgh_fastlogin.png"] forState:UIControlStateNormal];
    [fastLoginBtn setTitle:@"一键登录" forState:UIControlStateNormal];
    [fastLoginBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    fastLoginBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [fastLoginBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 5, 0, 0)];
    [fastLoginBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 5)];
    [self.imageView addSubview:fastLoginBtn];
    [fastLoginBtn addTarget:self action:@selector(fastLogin:) forControlEvents:UIControlEventTouchUpInside];
}

//-(void)LoginClick:(UIButton *)sender
//{
//    NSString *phoneNO = self.phoneTF.text;
//    NSString *pwd = self.pwdTF.text;
//    NSLog(@"userName=%@,pwd=%@",phoneNO,pwd);
//    [self checkPhoneNO:phoneNO pwd:pwd];
//
//}
//-(void)registerClick:(UIButton *)sender
//{
//    NSLog(@"register");
//    [[HGHPhoneRegister shareInstance] showPhoneRegister];
//}
-(void)clickBack:(UIButton *)sender
{
    [self.imageView removeFromSuperview];
}

-(void)fastLogin:(UIButton *)sender
{
    //fastLogin
}

-(void)phoneLogin:(UIButton *)sender
{
//    [[HGHPhoneRegister shareInstance] showPhoneRegister];
    NSString *phoneNO = self.phoneTF.text;
    NSString *pwd = self.pwdTF.text;
    NSLog(@"userName=%@,pwd=%@",phoneNO,pwd);
    [self checkPhoneNO:phoneNO pwd:pwd];
}

-(void)phoneRegister:(UIButton *)sender
{
    [[HGHPhoneRegister shareInstance] showPhoneRegister];
}

-(void)forgotPwd:(UIButton *)sender
{
    [[HGHChangePwd shareInstance] showChangePwdView];
}

-(void)checkPhoneNO:(NSString *)phoneNo pwd:(NSString *)pwd
{
    if (![HGHregular regularPhoneNO:phoneNo]) {
        //请输入正确的手机号
        return;
    }
//    if (![HGHregular regularPassword:pwd]) {
//        //密码应是8-16位数字字母组合
//        return;
//    }
    [self phoneLoginRequestWithPhoneNO:phoneNo pwd:pwd];
}

-(void)phoneLoginRequestWithPhoneNO:(NSString *)phoneNO pwd:(NSString *)pwd
{
    [HGHFunctionHttp HGHLoginUserID:@"" pwd:pwd type:@"1" phoneNO:phoneNO ifSuccess:^(id  _Nonnull response) {
        NSLog(@"phone login response=%@",response);
        if ([response[@"ret"] intValue]==0) {
            NSLog(@"成功");
            [HGHResponse loginsuccessWithUserData:response logintype:@"1" type:@"login"];
            [HGHTools removeViews:[HGHMainView shareInstance].baseView];
        }else{
            NSString *msg = response[@"msg"];
            [HGHAlertview showAlertViewWithMessage:msg];
        }
    } failure:^(NSError * _Nonnull error) {
        NSLog(@"error");
    }];
}
@end
