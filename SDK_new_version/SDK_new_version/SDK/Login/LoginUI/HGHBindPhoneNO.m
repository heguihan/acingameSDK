//
//  HGHBindPhoneNO.m
//  SDK_new_version
//
//  Created by Lucas on 2019/12/6.
//  Copyright © 2019 Lucas. All rights reserved.
//

#import "HGHBindPhoneNO.h"
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
#import "HGHShowLogView.h"
#import "HGHbaseUILabel.h"
@implementation HGHBindPhoneNO

+(instancetype)shareInstance
{
    static HGHBindPhoneNO *bind = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        bind = [[HGHBindPhoneNO alloc]init];
    });
    return bind;
}

-(UIImageView *)imageView
{
    if (!_imageView) {
        _imageView =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, MAINVIEWWIDTH, MAINVIEWHEIGHT)];
    }
    return _imageView;
}

-(void)showAccountBindViewAndUserInfo:(NSDictionary *)userInfo
{
    self.userInfo = userInfo;
    [self showAccountBindView];
}

-(void)showAccountBindView
{
    [[HGHMainView shareInstance].baseView addSubview:self.imageView];
    self.imageView.backgroundColor = [UIColor whiteColor];
    self.imageView.userInteractionEnabled = YES;
    
    HGHbaseUIButton *backBtn = [[HGHbaseUIButton alloc]initWithFrame:CGRectMake(MAINVIEWWIDTH-30, 10, 20, 20)];
    [self.imageView addSubview:backBtn];
    [backBtn setImage:[UIImage imageNamed:@"hgh_close.png"] forState:UIControlStateNormal];
    
    [backBtn addTarget:self action:@selector(clickBack:) forControlEvents:UIControlEventTouchUpInside];
    
    CGFloat titleLabWidth = 200;
    HGHbaseUILabel *titleLab = [[HGHbaseUILabel alloc]initWithFrame:CGRectMake((MAINVIEWWIDTH-titleLabWidth)/2, 5, titleLabWidth, 40)];
    titleLab.text = @"账号绑定";
    [self.imageView addSubview:titleLab];
    titleLab.font = [UIFont fontWithName:@"Helvetica-Bold" size:30];
    titleLab.textAlignment = NSTextAlignmentCenter;
    titleLab.textColor = [UIColor colorWithRed:255/255.0 green:183/255.0 blue:40/255.0 alpha:1];
    
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
    pwdTF.secureTextEntry = YES;
    [self.imageView addSubview:pwdTF];
//    self.pwdTF = pwdTF;
    HGHbaseUIButton *bindBtn = [[HGHbaseUIButton alloc]initWithFrame:CGRectMake(uilayerX, codeTF.baseBottom+DISTANCE2, TFWIDTH, TFHEIGHT)];
    [bindBtn setBackgroundImage:[UIImage imageNamed:@"hgh_longBtn.png"] forState:UIControlStateNormal];
    [bindBtn setTitle:@"立即绑定" forState:UIControlStateNormal];
    [self.imageView addSubview:bindBtn];
    [bindBtn addTarget:self action:@selector(bindNow:) forControlEvents:UIControlEventTouchUpInside];
    
    HGHbaseUIButton *nowarringAgainBtn = [[HGHbaseUIButton alloc]initWithFrame:CGRectMake(uilayerX, bindBtn.baseBottom+DISTANCE2, TFWIDTH, TFHEIGHT)];
    [self.imageView addSubview:nowarringAgainBtn];
    nowarringAgainBtn.backgroundColor = [UIColor redColor];
    [nowarringAgainBtn setTitle:@"不再提示" forState:UIControlStateNormal];
    [nowarringAgainBtn addTarget:self action:@selector(notnoticeToday:) forControlEvents:UIControlEventTouchUpInside];
}

-(void)clickBack:(UIButton *)sender
{
    
    [self.imageView removeFromSuperview];
    [[HGHMainView shareInstance].baseView removeFromSuperview];
    
    if (![self.pushedBy isEqualToString:@"accountCenter"]) {
        [HGHResponse responseSuccess:self.userInfo];
    }
    
}

//获取验证码事件
-(void)getCodeClick:(UIButton *)sender
{
    NSString *phoneNO = self.phoneTF.text;
    BOOL isPhoneNO = [self checkoutGetCodeWithPhoneNO:phoneNO];
    
    if (isPhoneNO) {
        __block int timeout = 10; //倒计时时间
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
        dispatch_source_set_timer(timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
        dispatch_source_set_event_handler(timer, ^{
            if(timeout <= 0)
                { //倒计时结束，关闭
                    dispatch_source_cancel(timer);
                    dispatch_async(dispatch_get_main_queue(), ^{
                        sender.userInteractionEnabled = YES;
                        sender.backgroundColor = [UIColor whiteColor];
                        [sender setTitle:@"获取验证码" forState:UIControlStateNormal];
                    });
                }
            else
                {
                dispatch_async(dispatch_get_main_queue(), ^{
                    sender.userInteractionEnabled = NO;
                    sender.backgroundColor = [UIColor lightGrayColor];
                    [sender setTitle:[NSString stringWithFormat:@"%ds",timeout] forState:UIControlStateNormal];
                });
                
                timeout--;
                
                }
        });
        dispatch_resume(timer);
    }
}
-(BOOL)checkoutGetCodeWithPhoneNO:(NSString *)phoneNO
{
    if (![HGHregular regularPhoneNO:phoneNO]) {
        [[HGHShowLogView shareInstance] showLogsWithMsg:@"请输入正确的手机号"];
        return NO;
    }
    [self getCodeRequestWithPhoneNO:phoneNO];
    return YES;
}

-(void)getCodeRequestWithPhoneNO:(NSString *)phoneNO
{
    [HGHFunctionHttp HGHGetCaptchaPhoneNO:phoneNO action:@"bind" ifSuccess:^(id  _Nonnull response) {
        if ([response[@"ret"] integerValue]==0) {
            if ([response[@"ret"] integerValue]==0) {
                //fas 验证码成功
            }else{
                [HGHAlertview showAlertViewWithMessage:response[@"msg"]];
            }
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
    [self checkoutBindWithPhoneNO:phoneNO code:code];
}

-(void)checkoutBindWithPhoneNO:(NSString *)phoneNO code:(NSString *)code
{
    if (code.length<1) {
        [[HGHShowLogView shareInstance] showLogsWithMsg:@"请输入验证码"];
        return;
    }
    if (![HGHregular regularPhoneNO:phoneNO]) {
        [[HGHShowLogView shareInstance] showLogsWithMsg:@"请输入正确的手机号"];
        return;
    }
    [self bindRequestWithPhoneNO:phoneNO code:code];
}
-(void)bindRequestWithPhoneNO:(NSString *)phoneNO code:(NSString *)code
{
    NSString *userID=[[NSUserDefaults standardUserDefaults] objectForKey:@"pandasUserID"];
    NSLog(@"userID=%@",userID);
    __weak __typeof__(self) weakSelf = self;
    [HGHFunctionHttp HGHBindPwd:@"" code:code phoneNO:phoneNO userID:userID ifSuccess:^(id  _Nonnull response) {
        if ([response[@"ret"] integerValue]==0) {
            [[HGHMainView shareInstance].baseView removeFromSuperview];
            if (![weakSelf.pushedBy isEqualToString:@"accountCenter"]) {
                [HGHResponse responseSuccess:weakSelf.userInfo];
            }
            
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
//    hghpandastodaynotnotice
    NSDate *clickDate = [NSDate date];
    NSTimeInterval clickSec = clickDate.timeIntervalSince1970;
    NSString *clickTime = [NSString stringWithFormat:@"%f",clickSec];
    [[NSUserDefaults standardUserDefaults] setObject:clickTime forKey:@"hghpandastodaynotnotice"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    [self.imageView removeFromSuperview];
    [[HGHMainView shareInstance].baseView removeFromSuperview];
    [HGHResponse responseSuccess:self.userInfo];
}
@end
