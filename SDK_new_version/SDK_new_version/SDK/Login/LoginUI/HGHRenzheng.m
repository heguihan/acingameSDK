//
//  HGHRenzheng.m
//  SDK_new_version
//
//  Created by Lucas on 2019/12/6.
//  Copyright © 2019 Lucas. All rights reserved.
//

#import "HGHRenzheng.h"
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
#import "HGHregular.h"
@implementation HGHRenzheng
+(instancetype)shareInstance
{
    static HGHRenzheng *renzheng = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        renzheng = [[HGHRenzheng alloc]init];
    });
    return renzheng;
}

-(UIImageView *)imageView
{
    if (!_imageView) {
        _imageView =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, MAINVIEWWIDTH, MAINVIEWHEIGHT)];
    }
    return _imageView;
}

-(void)showRenzhengViewWithUserinfo:(NSDictionary *)userInfo
{
    self.userInfo = userInfo;
    [self showRenzhengView];
}

-(void)showRenzhengView
{
    [[HGHMainView shareInstance].baseView addSubview:self.imageView];
//    self.imageView.backgroundColor = [UIColor whiteColor];
    self.imageView.image = [UIImage imageNamed:@"hgh_background.png"];
    self.imageView.userInteractionEnabled = YES;
        
    HGHbaseUIButton *backBtn = [[HGHbaseUIButton alloc]initWithFrame:CGRectMake(MAINVIEWWIDTH-30, 10, 20, 20)];
    [self.imageView addSubview:backBtn];
    [backBtn setImage:[UIImage imageNamed:@"hgh_close.png"] forState:UIControlStateNormal];
//    backBtn.backgroundColor = [UIColor redColor];        [backBtn setImage:[UIImage imageNamed:@"hgh_goback.png"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(clickBack:) forControlEvents:UIControlEventTouchUpInside];
    CGFloat uilayerX = (MAINVIEWWIDTH - TFWIDTH)/2;
    
    HGHbaseUILabel *topUserLab = [[HGHbaseUILabel alloc]initWithFrame:CGRectMake(uilayerX, backBtn.baseBottom+DISTANCE1, TFWIDTH, 12)];
    topUserLab.font = [UIFont systemFontOfSize:10];
    [self.imageView addSubview:topUserLab];
    topUserLab.text = @"尊敬的游戏用户:";
//    topUserLab.tintColor = [UIColor blueColor];
    [topUserLab setTextColor:[UIColor colorWithRed:82/255.0 green:82/255.0 blue:82/255.0 alpha:1]];
    
    HGHbaseUILabel *topLab = [[HGHbaseUILabel alloc]initWithFrame:CGRectMake(uilayerX, topUserLab.baseBottom+1, TFWIDTH, 50)];
    topLab.numberOfLines = 0;
    topLab.font = [UIFont systemFontOfSize:10];
    [topLab setTextColor:[UIColor colorWithRed:82/255.0 green:82/255.0 blue:82/255.0 alpha:1]];
//    topLab.backgroundColor = [UIColor orangeColor];
    topLab.text = @"您好,根据中华人民共和国文化部《互联网文化管理暂行规定》和《网络游戏管理暂行办法》对于移动网络游戏市场的相关规定及要求。游戏用户要登记如下个人信息：";
    NSMutableAttributedString* string = [[NSMutableAttributedString alloc] initWithString:topLab.text];
    [string addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:246/255.0 green:83/255.0 blue:86/255.0 alpha:1] range:NSMakeRange(15,13)];

    [string addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:246/255.0 green:83/255.0 blue:86/255.0 alpha:1] range:NSMakeRange(29,12)];

    topLab.attributedText = string;
    [self.imageView addSubview:topLab];
    
    
    HGHbaseUITextField *userTF = [[HGHbaseUITextField alloc]initWithFrame:CGRectMake(uilayerX, topLab.baseBottom+DISTANCE1/2, TFWIDTH, TFHEIGHT)];
    self.userTF = userTF;
    userTF.placeholder = @"真实姓名:请输入你身份证上对应的名字";
    [self.imageView addSubview:userTF];
    
    HGHbaseUITextField *idcardTF = [[HGHbaseUITextField alloc]initWithFrame:CGRectMake(uilayerX, userTF.baseBottom+DISTANCE1, TFWIDTH, TFHEIGHT)];
    self.idcardTF = idcardTF;
    idcardTF.placeholder = @"身份证号码:请输入你的二代身份证号码";
    [self.imageView addSubview:idcardTF];
    
    HGHbaseUIImageView *waringImageV = [[HGHbaseUIImageView alloc]initWithFrame:CGRectMake(uilayerX, idcardTF.baseBottom+DISTANCE1+2, 10, 10)];
    waringImageV.image = [UIImage imageNamed:@"hgh_waring.png"];
    [self.imageView addSubview:waringImageV];
    
    HGHbaseUILabel *bootmLab = [[HGHbaseUILabel alloc]initWithFrame:CGRectMake(waringImageV.baseLeft+1, idcardTF.baseBottom+DISTANCE1, TFWIDTH-waringImageV.baseWidth-1, 25)];
    [self.imageView addSubview:bootmLab];
    bootmLab.numberOfLines = 0;
    bootmLab.text = @"实名注册资料一旦填写确认，无法随意更改。该信息仅用于实名验证，不会泄露给任何第三方。";
    bootmLab.font = [UIFont systemFontOfSize:10];
    [bootmLab setTextColor:[UIColor colorWithRed:203/255.0 green:204/255.0 blue:208/255.0 alpha:1]];
//    bootmLab.backgroundColor = [UIColor orangeColor];
    
    HGHbaseUIButton *confirmBtn = [[HGHbaseUIButton alloc]initWithFrame:CGRectMake(uilayerX, bootmLab.baseBottom+DISTANCE1, TFWIDTH, TFHEIGHT)];
    [self.imageView addSubview:confirmBtn];
    [confirmBtn setBackgroundImage:[UIImage imageNamed:@"hgh_longBtn.png"] forState:UIControlStateNormal];
    [confirmBtn setTitle:@"确认" forState:UIControlStateNormal];
    [confirmBtn addTarget:self action:@selector(renzhengNow:) forControlEvents:UIControlEventTouchUpInside];
}

-(void)clickBack:(UIButton *)sender
{
    [HGHResponse responseSuccess:self.userInfo];
    [self.imageView removeFromSuperview];
    [[HGHMainView shareInstance].baseView removeFromSuperview];
}
//开始认证
-(void)renzhengNow:(UIButton *)sender
{
    NSString *realName = self.userTF.text;
    NSString *idCardNumber = self.idcardTF.text;
    [self checkoutRenzhengWithRealName:realName idCardNumber:idCardNumber];
}

-(void)checkoutRenzhengWithRealName:(NSString *)realName idCardNumber:(NSString *)idCardNumber
{
    if (realName.length<1) {
        //请输入姓名
        return;
    }
    if (![HGHregular regularIdCardNum:idCardNumber]) {
        //身份证违规
        return;
    }
}

-(void)renzhengRequestWithRealName:(NSString *)realName idCardNumber:(NSString *)idCardNumber
{
    __weak __typeof__(self) weakSelf = self;
    [HGHFunctionHttp HGHRenzhengWithUserName:realName idCardNumber:idCardNumber ifSuccess:^(id  _Nonnull response) {
        if ([response[@"ret"] integerValue]==0) {
            [HGHResponse responseSuccess:weakSelf.userInfo];
        }else{
            [HGHAlertview showAlertViewWithMessage:response[@"msg"]];
        }
    } failure:^(NSError * _Nonnull error) {
        NSLog(@"error=%@",error);
    }];
}
@end
