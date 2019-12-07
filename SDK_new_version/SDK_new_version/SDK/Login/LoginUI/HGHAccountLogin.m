//
//  HGHAccountLogin.m
//  SDK_new_version
//
//  Created by Lucas on 2019/12/3.
//  Copyright © 2019 Lucas. All rights reserved.
//

#import "HGHAccountLogin.h"
#import "HGHTools.h"
#import "HGHMainView.h"
#import <UIKit/UIKit.h>
#import "HGHbaseUITextField.h"
#import "HGHbaseUIButton.h"
#import "HGHAccountRegister.h"
#import "HGHFunctionHttp.h"
#import "HGHResponse.h"
#import "HGHAlertview.h"
#import "HGHbaseUILabel.h"
#import "HGHbaseUIImageView.h"
#import "HGHPhoneLogin.h"
@implementation HGHAccountLogin
+(instancetype)shareInstance
{
    static HGHAccountLogin *account = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        account = [[HGHAccountLogin alloc]init];
    });
    return account;
}
-(UIImageView *)imageView
{
    if (!_imageView) {
        _imageView =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, MAINVIEWWIDTH, MAINVIEWHEIGHT)];
    }
    return _imageView;
}

-(void)showAccountLogin
{
    [[HGHMainView shareInstance].baseView addSubview:self.imageView];
    self.imageView.image = [UIImage imageNamed:@"hgh_background.png"];
    self.imageView.userInteractionEnabled = YES;
    HGHbaseUIButton *backBtn = [[HGHbaseUIButton alloc]initWithFrame:CGRectMake(10, 10, 16, 30)];
//    [self.imageView addSubview:backBtn];
    [backBtn setImage:[UIImage imageNamed:@"hgh_goback.png"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(clickBack:) forControlEvents:UIControlEventTouchUpInside];
    
    
    CGFloat uilayerX = (MAINVIEWWIDTH-TFWIDTH)/2;
    HGHbaseUITextField *userTF = [[HGHbaseUITextField alloc]initWithFrame:CGRectMake(uilayerX, 50, TFWIDTH, TFHEIGHT)];
//    userTF.backgroundColor = [UIColor colorWithRed:242/255 green:242/255 blue:242/255 alpha:0.09];
    self.userTF = userTF;
    userTF.placeholder = @"请输入账号";
    [self.imageView addSubview:userTF];
    
    HGHbaseUITextField *pwdTF = [[HGHbaseUITextField alloc]initWithFrame:CGRectMake(uilayerX, userTF.baseBottom+DISTANCE1, TFWIDTH, TFHEIGHT)];
//    pwdTF.backgroundColor = [UIColor grayColor];
    [self.imageView addSubview:pwdTF];
    pwdTF.placeholder = @"请输入登录密码";
    self.pwdTF = pwdTF;
    CGFloat registWidth = 63;
    HGHbaseUIButton *registRightnow = [[HGHbaseUIButton alloc]initWithFrame:CGRectMake(uilayerX+TFWIDTH-registWidth, pwdTF.baseBottom+DISTANCE1/2, registWidth, 20)];
//    registRightnow.backgroundColor = [UIColor blueColor];
    [registRightnow setTitle:@"立即注册" forState:UIControlStateNormal];
    [registRightnow setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    registRightnow.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    registRightnow.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.imageView addSubview:registRightnow];
    [registRightnow addTarget:self action:@selector(registerClick:) forControlEvents:UIControlEventTouchUpInside];
    
    CGFloat noregisterWidth = 65;
    NSLog(@"registerbtn x=%f",registRightnow.baseLeft);
    UILabel *noregisterLab = [[UILabel alloc]initWithFrame:CGRectMake(registRightnow.baseX-noregisterWidth, pwdTF.baseBottom+DISTANCE1/2, noregisterWidth, 20)];
    noregisterLab.text = @"没有账号?";
    noregisterLab.font = [UIFont systemFontOfSize:14];
    [self.imageView addSubview:noregisterLab];
    
    HGHbaseUIButton *loginBtn = [[HGHbaseUIButton alloc]initWithFrame:CGRectMake(uilayerX, registRightnow.baseBottom+DISTANCE1/2, TFWIDTH, TFHEIGHT)];
    [self.imageView addSubview:loginBtn];
    [loginBtn setBackgroundImage:[UIImage imageNamed:@"hgh_longBtn.png"] forState:UIControlStateNormal];
    [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [loginBtn addTarget:self action:@selector(LoginClick:) forControlEvents:UIControlEventTouchUpInside];
    
    CGFloat otherLabWidth = 130;
    HGHbaseUILabel *otherLoginlab = [[HGHbaseUILabel alloc]initWithFrame:CGRectMake((MAINVIEWWIDTH-otherLabWidth)/2, loginBtn.baseBottom+DISTANCE1, otherLabWidth, 20)];
//    otherLoginlab.backgroundColor = [UIColor blueColor];
    otherLoginlab.text = @"请选择其他登录方式";
    [otherLoginlab setTextColor:[UIColor colorWithRed:82/255.0 green:82/255.0 blue:82/255.0 alpha:1]];
    otherLoginlab.font = [UIFont systemFontOfSize:14];
    [self.imageView addSubview:otherLoginlab];
    HGHbaseUIImageView *leftImageV = [[HGHbaseUIImageView alloc]initWithFrame:CGRectMake(uilayerX, otherLoginlab.center.y-1, (TFWIDTH-otherLabWidth)/2, 2)];
    [self.imageView addSubview:leftImageV];
    leftImageV.image = [UIImage imageNamed:@"hgh_line.png"];
    
    HGHbaseUIImageView *rightImageV = [[HGHbaseUIImageView alloc]initWithFrame:CGRectMake(otherLoginlab.baseLeft, otherLoginlab.center.y-1, (TFWIDTH-otherLabWidth)/2, 2)];
    [self.imageView addSubview:rightImageV];
    rightImageV.image = [UIImage imageNamed:@"hgh_line.png"];
    
    
    CGFloat otherBtnWidth = 110;
    CGFloat x1 = uilayerX+(TFWIDTH/2-otherBtnWidth)/2;
    CGFloat x2 = uilayerX+TFWIDTH/2+(TFWIDTH/2-otherBtnWidth)/2;
    
//    HGHbaseUIButton *phoneLoginBtn = [[HGHbaseUIButton alloc]initWithFrame:CGRectMake(x1, otherLoginlab.baseBottom+DISTANCE1, otherLabWidth, 40)];
    HGHbaseUIButton *phoneLoginBtn = [HGHbaseUIButton buttonWithType:UIButtonTypeCustom];
    phoneLoginBtn.frame = CGRectMake(x1, otherLoginlab.baseBottom+DISTANCE1, otherBtnWidth, 40);
    [phoneLoginBtn setImage:[UIImage imageNamed:@"hgh_testPhone.png"] forState:UIControlStateNormal];
    [phoneLoginBtn setTitle:@"手机登录" forState:UIControlStateNormal];
    [phoneLoginBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    phoneLoginBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [phoneLoginBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 5, 0, 0)];
    [phoneLoginBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 5)];
    [self.imageView addSubview:phoneLoginBtn];
    [phoneLoginBtn addTarget:self action:@selector(phoneLogin:) forControlEvents:UIControlEventTouchUpInside];
    
    
    HGHbaseUIButton *fastLoginBtn = [HGHbaseUIButton buttonWithType:UIButtonTypeCustom];
    fastLoginBtn.frame = CGRectMake(x2, otherLoginlab.baseBottom+DISTANCE1, otherBtnWidth, 40);
    [fastLoginBtn setImage:[UIImage imageNamed:@"hgh_fastlogin.png.png"] forState:UIControlStateNormal];
    [fastLoginBtn setTitle:@"一键登录" forState:UIControlStateNormal];
    [fastLoginBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    fastLoginBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [fastLoginBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 5, 0, 0)];
    [fastLoginBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 5)];
    [self.imageView addSubview:fastLoginBtn];
    [fastLoginBtn addTarget:self action:@selector(fastLogin:) forControlEvents:UIControlEventTouchUpInside];

}

-(void)LoginClick:(UIButton *)sender
{
    NSString *userName = self.userTF.text;
    NSString *pwd = self.pwdTF.text;
    NSLog(@"userName=%@,pwd=%@",userName,pwd);
    [self checkUser:userName pwd:pwd];
}
-(void)registerClick:(UIButton *)sender
{
    NSLog(@"register");
    [[HGHAccountRegister shareInstance] showAccountRegister];
}
-(void)clickBack:(UIButton *)sender
{
    [self.imageView removeFromSuperview];
}

-(void)checkUser:(NSString *)user pwd:(NSString *)pwd
{//type  1手机  2账号  3游客
    NSString *uuuu = @"hghtest";
    NSString *pppp = @"123456";
    [HGHFunctionHttp HGHLoginUserID:uuuu pwd:pppp type:@"2" phoneNO:@"" ifSuccess:^(id  _Nonnull response) {
        NSLog(@"response=%@",response);
        if ([response[@"ret"] intValue]==0) {
            NSLog(@"成功");
            [HGHResponse loginsuccessWithUserData:response logintype:@"2" type:@"login"];
            [HGHTools removeViews:[HGHMainView shareInstance].baseView];
        }else{
            NSString *msg = response[@"msg"];
            [HGHAlertview showAlertViewWithMessage:msg];
        }
        
    } failure:^(NSError * _Nonnull error) {
        
    }];
}
//快速登录
-(void)fastLogin:(UIButton *)sender
{
    [self guestLogin];
}

-(void)phoneLogin:(UIButton *)sender
{
    [[HGHPhoneLogin shareInstance] showPhoneLogin];
}



-(void)guestLogin
{
    NSString *deviceID = [HGHTools getUUID];
    [HGHFunctionHttp HGHLoginDevice:deviceID ifSuccess:^(id  _Nonnull response) {
        NSLog(@"response=%@",response);
        if ([response[@"ret"] intValue]==0) {
            [HGHResponse loginsuccessWithUserData:response logintype:@"3" type:@"login"];
            [HGHTools removeViews:[HGHMainView shareInstance].baseView];
        }else{
            NSString *msg = [response objectForKey:@"msg"];
            [HGHAlertview showAlertViewWithMessage:msg];
        }
    } failure:^(NSError * _Nonnull error) {
        NSLog(@"error=%@",error);
    }];
}

@end
