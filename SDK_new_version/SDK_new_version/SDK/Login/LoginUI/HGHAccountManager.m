//
//  HGHAccountManager.m
//  SDK_new_version
//
//  Created by Lucas on 2019/12/9.
//  Copyright © 2019 Lucas. All rights reserved.
//

#import "HGHAccountManager.h"
#import "HGHTools.h"
#import "HGHbaseUITextField.h"
#import "HGHbaseUIButton.h"
#import "HGHbaseUILabel.h"
#import "HGHLogout.h"
#import "HGHPandas.h"
#import "HGHTools.h"
#import "HGHSDKConfig.h"
#import "HGHbaseUIImageView.h"
#import "HGHMainView.h"

@implementation HGHAccountManager
+(instancetype)shareInstance
{
    static HGHAccountManager *account = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        account = [[HGHAccountManager alloc]init];
    });
    return account;
}

-(UIImageView *)imageView
{
    if (!_imageView) {
        _imageView =[[UIImageView alloc]initWithFrame:CGRectMake((SCREENWIDTH-MAINVIEWWIDTH)/2, (SCREENHEIGHT - ACCOUNTCENTERHEIGHT)/2, MAINVIEWWIDTH, ACCOUNTCENTERHEIGHT)];
        _imageView.image = [UIImage imageNamed:@"hgh_background.png"];
        _imageView.userInteractionEnabled = YES;
    }
    return _imageView;
}

-(void)showAccountManager
{
    
    
    NSDictionary *dict = [[NSUserDefaults standardUserDefaults] objectForKey:@"hghpandasuserinfo"];
    NSString *accountType = dict[@"accountType"];
    NSString *phoneNo = dict[@"phoneNumber"];
    NSString *userID = dict[@"userID"];
    NSString *idCardAuth = dict[@"idCardAuth"];
    NSString *idCardNo = dict[@"idCardNo"];
    
    NSString *showType =@"账号";
    if ([accountType integerValue]==1) {
        showType = @"手机账号";
    }else if ([accountType integerValue]==2){
        showType = @"官方账号";
    }else if ([accountType integerValue]==3){
        showType = @"游客账号";
    }
    
    
    UIViewController *vc = [HGHTools getCurrentVC];
    [vc.view addSubview:self.imageView];
    
    HGHbaseUIButton *backBtn = [[HGHbaseUIButton alloc]initWithFrame:CGRectMake(MAINVIEWWIDTH-30, 10, 20, 20)];
    [self.imageView addSubview:backBtn];
    [backBtn setImage:[UIImage imageNamed:@"hgh_close.png"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(clickBack:) forControlEvents:UIControlEventTouchUpInside];
    
    CGFloat titleLabWidth = 200;
    HGHbaseUILabel *titleLab = [[HGHbaseUILabel alloc]initWithFrame:CGRectMake((MAINVIEWWIDTH-titleLabWidth)/2, 5, titleLabWidth, 40)];
    titleLab.text = @"用户中心";
    [self.imageView addSubview:titleLab];
    titleLab.font = [UIFont fontWithName:@"Helvetica-Bold" size:30];
    titleLab.textAlignment = NSTextAlignmentCenter;
    titleLab.textColor = [UIColor colorWithRed:255/255.0 green:183/255.0 blue:40/255.0 alpha:1];
    
    CGFloat uilayerX = (MAINVIEWWIDTH-TFWIDTH)/2;
    HGHbaseUILabel *loginTypeLab = [[HGHbaseUILabel alloc]initWithFrame:CGRectMake(uilayerX, backBtn.baseBottom+20, 180, 40)];
    loginTypeLab.text = [NSString stringWithFormat:@"%@:%@",showType,userID];
    loginTypeLab.backgroundColor = [UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1];
    [self.imageView addSubview:loginTypeLab];
    
    
    // 绑定
    HGHbaseUIButton *bindBtn = [[HGHbaseUIButton alloc]initWithFrame:CGRectMake(loginTypeLab.baseLeft+5, loginTypeLab.baseY, 70, 40)];
    [bindBtn setBackgroundImage:[UIImage imageNamed:@"hgh_longBtn.png"] forState:UIControlStateNormal];
    
    if ([phoneNo isEqualToString:@""]) {
        if ([accountType integerValue]==2) {
            bindBtn.tag = 1001;
        }else{
            bindBtn.tag = 1002;
        }
        [bindBtn setTitle:@"去绑定" forState:UIControlStateNormal];
        bindBtn.userInteractionEnabled = YES;
    }else{
        [bindBtn setTitle:@"已绑定" forState:UIControlStateNormal];
        bindBtn.userInteractionEnabled = NO;
    }
    [self.imageView addSubview:bindBtn];
    [bindBtn addTarget:self action:@selector(ClickBind:) forControlEvents:UIControlEventTouchUpInside];
    
    
    HGHbaseUILabel *realNameTypeLab = [[HGHbaseUILabel alloc]initWithFrame:CGRectMake(uilayerX, loginTypeLab.baseBottom+10, 180, 40)];
    
    realNameTypeLab.backgroundColor = [UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1];
    [self.imageView addSubview:realNameTypeLab];
    
    HGHbaseUIButton *realNameBtn = [[HGHbaseUIButton alloc]initWithFrame:CGRectMake(realNameTypeLab.baseLeft+5, loginTypeLab.baseBottom+10, 70, 40)];
    [realNameBtn setBackgroundImage:[UIImage imageNamed:@"hgh_longBtn.png"] forState:UIControlStateNormal];
    //0是未认证 1是已认证
    if ([idCardAuth integerValue]==0) {
        realNameTypeLab.text = @"尚未实名认证";
        [realNameBtn setTitle:@"去认证" forState:UIControlStateNormal];
        realNameBtn.userInteractionEnabled = YES;
    }else{
        realNameTypeLab.text = idCardNo;
        [realNameBtn setTitle:@"已认证" forState:UIControlStateNormal];
        realNameBtn.userInteractionEnabled = NO;
    }
    [realNameBtn addTarget:self action:@selector(clickRealName:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.imageView addSubview:realNameBtn];
    
    HGHbaseUIButton *logoutBtn = [[HGHbaseUIButton alloc]initWithFrame:CGRectMake(uilayerX, realNameBtn.baseBottom+10, 255, 40)];
    [logoutBtn setBackgroundImage:[UIImage imageNamed:@"hgh_longBtn.png"] forState:UIControlStateNormal];
    [logoutBtn setTitle:@"切换账号" forState:UIControlStateNormal];
    [self.imageView addSubview:logoutBtn];
    [logoutBtn addTarget:self action:@selector(clickLoutOut:) forControlEvents:UIControlEventTouchUpInside];
    
    CGFloat versionWidth = 120;
    HGHbaseUILabel *sdkVersion = [[HGHbaseUILabel alloc]initWithFrame:CGRectMake(uilayerX+logoutBtn.baseWidth-versionWidth, logoutBtn.baseBottom+5, versionWidth, 40)];
    sdkVersion.text = [NSString stringWithFormat:@"%@：%@",@"版本号",[HGHSDKConfig SDKVersion]];
    NSMutableAttributedString* string = [[NSMutableAttributedString alloc] initWithString:sdkVersion.text];
    [string addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:246/255.0 green:83/255.0 blue:86/255.0 alpha:1] range:NSMakeRange(4,6)];
    
    sdkVersion.attributedText = string;
    sdkVersion.textAlignment = NSTextAlignmentRight;
    [self.imageView addSubview:sdkVersion];
    
    
}


-(void)clickBack:(UIButton *)sender
{
    [HGHTools removeViews:self.imageView];
}

-(void)clickLoutOut:(UIButton *)sender
{
    [HGHTools removeViews:self.imageView];
    [[HGHLogout shareInstance] logoutEvent];
    [HGHPandas shareInstance].logoutBlock();
}

-(void)ClickBind:(UIButton *)sender
{
    [HGHTools removeViews:self.imageView];
    if (sender.tag == 1001) {
        [[HGHMainView shareInstance] showAccountBindView];
    }else{
        [[HGHMainView shareInstance] showGuestBindView];
    }
    
}

-(void)clickRealName:(UIButton *)sender
{
    [HGHTools removeViews:self.imageView];
    [[HGHMainView shareInstance] showRenzhengView];
}

@end
