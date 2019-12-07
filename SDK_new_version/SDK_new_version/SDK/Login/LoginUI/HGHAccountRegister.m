//
//  HGHAccountRegister.m
//  SDK_new_version
//
//  Created by Lucas on 2019/12/3.
//  Copyright © 2019 Lucas. All rights reserved.
//

#import "HGHAccountRegister.h"
#import "HGHTools.h"
#import "HGHMainView.h"
#import <UIKit/UIKit.h>
#import "HGHbaseUITextField.h"
#import "HGHbaseUIButton.h"
#import "HGHFunctionHttp.h"
#import "HGHResponse.h"
#import "HGHAlertview.h"
#import "HGHbaseUIButton.h"
#import "HGHPhoneRegister.h"
#import "HGHAccountLogin.h"
#import "HGHregular.h"
@implementation HGHAccountRegister

+(instancetype)shareInstance
{
    static HGHAccountRegister *regist = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        regist = [[HGHAccountRegister alloc]init];
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

-(void)showAccountRegister
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
    
    
    HGHbaseUITextField *userTF = [[HGHbaseUITextField alloc]initWithFrame:CGRectMake(uilayerX, backBtn.baseBottom+30, TFWIDTH, TFHEIGHT)];
    userTF.placeholder = @"账号";
    self.userTF = userTF;
    [self.imageView addSubview:userTF];
    
    
    HGHbaseUITextField *pwdTF = [[HGHbaseUITextField alloc]initWithFrame:CGRectMake(uilayerX, userTF.baseBottom+DISTANCE2, TFWIDTH, TFHEIGHT)];
    pwdTF.placeholder = @"密码";
    [self.imageView addSubview:pwdTF];
    self.pwdTF = pwdTF;
    
    HGHbaseUIButton *registerBtn = [[HGHbaseUIButton alloc]initWithFrame:CGRectMake(uilayerX, pwdTF.baseBottom+DISTANCE2, TFWIDTH, TFHEIGHT)];
    [self.imageView addSubview:registerBtn];
//    registerBtn.backgroundColor = [UIColor redColor];
//    [registerBtn setImage:[UIImage imageNamed:@"hgh_longBtn.png"] forState:UIControlStateNormal];
    [registerBtn setBackgroundImage:[UIImage imageNamed:@"hgh_longBtn.png"] forState:UIControlStateNormal];
    [registerBtn setTitle:@"立即注册" forState:UIControlStateNormal];
    [registerBtn addTarget:self action:@selector(registerClick:) forControlEvents:UIControlEventTouchUpInside];
    
    CGFloat otherBtnWidth = 110;
    CGFloat x1 = uilayerX+(TFWIDTH/2-otherBtnWidth)/2;
    CGFloat x2 = uilayerX+TFWIDTH/2+(TFWIDTH/2-otherBtnWidth)/2;
    
    HGHbaseUIButton *phoneLoginBtn = [HGHbaseUIButton buttonWithType:UIButtonTypeCustom];
    phoneLoginBtn.frame = CGRectMake(x1, registerBtn.baseBottom+DISTANCE2, otherBtnWidth, 40);
    [phoneLoginBtn setImage:[UIImage imageNamed:@"hgh_accountlogin.png"] forState:UIControlStateNormal];
    [phoneLoginBtn setTitle:@"账号登录" forState:UIControlStateNormal];
    [phoneLoginBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    phoneLoginBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [phoneLoginBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 5, 0, 0)];
    [phoneLoginBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 5)];
    [self.imageView addSubview:phoneLoginBtn];
    [phoneLoginBtn addTarget:self action:@selector(accountLogin:) forControlEvents:UIControlEventTouchUpInside];
    
    
    HGHbaseUIButton *fastLoginBtn = [HGHbaseUIButton buttonWithType:UIButtonTypeCustom];
    fastLoginBtn.frame = CGRectMake(x2, registerBtn.baseBottom+DISTANCE2, otherBtnWidth, 40);
    [fastLoginBtn setImage:[UIImage imageNamed:@"hgh_phone.png.png"] forState:UIControlStateNormal];
    [fastLoginBtn setTitle:@"手机注册" forState:UIControlStateNormal];
    [fastLoginBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    fastLoginBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [fastLoginBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 5, 0, 0)];
    [fastLoginBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 5)];
    [self.imageView addSubview:fastLoginBtn];
    [fastLoginBtn addTarget:self action:@selector(phoneRegister:) forControlEvents:UIControlEventTouchUpInside];
    
}

-(void)registerClick:(UIButton *)sender
{
    NSString *userName = self.userTF.text;
    NSString *pwd = self.pwdTF.text;
    NSLog(@"userName=%@,pwd=%@",userName,pwd);
    [self checktuserName:userName pwd:pwd];
}

-(void)clickBack:(UIButton *)sender
{
    [self.imageView removeFromSuperview];
}

-(void)accountLogin:(UIButton *)sender
{
    [[HGHAccountLogin shareInstance] showAccountLogin];
}

-(void)phoneRegister:(UIButton *)sender
{
    [[HGHPhoneRegister shareInstance] showPhoneRegister];
}

-(void)checktuserName:(NSString *)userName pwd:(NSString *)pwd
{
//    if (code.length<1) {
//            //请输入验证码;
//        return;
//    }
    if (![HGHregular regularUserName:userName]) {
        //userName 6-18位数字字母
        return;
    }
    if (![HGHregular regularPassword:pwd]) {
        //密码8-16位数字和字母组合
        return;
    }
    
    
    [self registerAccountRequestWithUserName:userName pwd:pwd];
}

-(void)registerAccountRequestWithUserName:(NSString *)userName pwd:(NSString *)pwd
{
    [HGHFunctionHttp HGHAccountRegisterWithUserID:userName pwd:pwd ifSuccess:^(id  _Nonnull response) {
        NSLog(@"response=%@",response);
        if ([response[@"ret"] intValue]==0) {
            [HGHResponse loginsuccessWithUserData:response logintype:@"2" type:@"register"];
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
