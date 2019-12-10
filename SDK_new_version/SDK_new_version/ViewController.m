//
//  ViewController.m
//  SDK_new_version
//
//  Created by Lucas on 2019/11/29.
//  Copyright © 2019 Lucas. All rights reserved.
//

#import "ViewController.h"
#import "HGHMainView.h"
#import "HGHDeviceReport.h"
#import "HGHPandas.h"
#import "HGHFunctionHttp.h"
#import "HGHOrderInfo.h"
#import "HGHTools.h"
#import "HGHRenzheng.h"
#import "HGHShowLogView.h"
#import "HGHShowBall.h"
#import "HGHAccountManager.h"
#import "HGHPandas.h"
#import "HGHGetOrderManager.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [HGHUIConfig TFWidth];
    [HGHUIConfig TFHeight];
    self.view.backgroundColor = [UIColor blueColor];
//    self.view.backgroundColor = [UIColor colorWithRed:246/255.0 green:83/255.0 blue:86/255.0 alpha:1];
    [self begin];
}

-(void)begin
{
    [self creatUI];
    [HGHPandas SDKinit];
}

-(void)creatUI
{
    
    UIButton *testBtn = [[UIButton alloc]initWithFrame:CGRectMake(250, 100, 100, 100)];
    testBtn.backgroundColor = [UIColor orangeColor];
    [testBtn setTitle:@"测试" forState:UIControlStateNormal];
    [self.view addSubview:testBtn];
    [testBtn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    
    NSArray *titleArr = @[@"账号绑定",@"游客绑定",@"实名认证",@"支付"];
    for (int i=0; i<4; i++) {
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(100, 50+i*70, 80, 40)];
        btn.backgroundColor = [UIColor orangeColor];
        [btn setTitle:titleArr[i] forState:UIControlStateNormal];
        [self.view addSubview:btn];
        btn.tag = 200+i;
        [btn addTarget:self action:@selector(clickTest:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = [UIColor redColor];
    button.frame = CGRectMake(250, 50, 110, 40);
    [button setImage:[UIImage imageNamed:@"hgh_testPhone.png"] forState:UIControlStateNormal];
    [button setTitle:@"左边文字" forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:14];
    [button setTitleEdgeInsets:UIEdgeInsetsMake(0, 5, 0, 0)];
    [button setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 5)];
    [self.view addSubview:button];
}

-(void)test
{
    
    [[HGHPandas shareInstance] LogoutCallBack:^{
        NSLog(@"游戏退出");
    }];
    
    [[HGHPandas shareInstance] LoginInfo:^(NSDictionary * _Nonnull loginInfo) {
        NSLog(@"loginfo=%@",loginInfo);
    }];
}

-(void)testFloatball
{
//    [HGHShowBall showFloatingball];
    [[HGHAccountManager shareInstance] showAccountManager];
}
-(void)testShowLog
{
    [[HGHShowLogView shareInstance] showLogsWithMsg:@"事实上四四试试"];
}


-(void)login
{
    [HGHDeviceReport HGHreportDeviceInfo:@{@"id":@"11"} ename:@"sdk_init"];
}

//@property(nonatomic,strong)NSString *cpOrderID;
//@property(nonatomic,strong)NSString *extension;
//@property(nonatomic,strong)NSString *gameCallbackUrl;
//@property(nonatomic,strong)NSString *money;
//@property(nonatomic,strong)NSString *productID;
//@property(nonatomic,strong)NSString *serverID;
//@property(nonatomic,strong)NSString *serverName;
//@property(nonatomic,strong)NSString *roleID;
//@property(nonatomic,strong)NSString *roleName;
//@property(nonatomic,strong)NSString *productName;
//@property(nonatomic,strong)NSString *productDesc;
-(void)pay
{
    
    HGHOrderInfo *orderInfo = [[HGHOrderInfo alloc]init];
    orderInfo.cpOrderID =[HGHTools getCurrentTimeString];
    orderInfo.extension = @"ttt";
    orderInfo.gameCallbackUrl = @"http://www.baidu.com";
    orderInfo.money = @"11";
    orderInfo.productID = @"ceshibaolong.1xx";
    orderInfo.serverID=@"10";
    orderInfo.serverName = @"one";
    orderInfo.roleID = @"123";
    orderInfo.roleName = @"ttttaaa";
    orderInfo.productName = @"80yuanbao";
    orderInfo.productDesc = @"yuanbao";
    
    
    [[HGHGetOrderManager shareInstance] getOrderIDWithOrderInfo:orderInfo];
//    [HGHFunctionHttp HGHGetOrder:orderInfo ifSuccess:^(id  _Nonnull response) {
//        NSLog(@"response=%@",response);
//    } failure:^(NSError * _Nonnull error) {
//        NSLog(@"error=%@",error);
//    }];
}
/*

@property(nonatomic,strong)NSString *opType; //类型: 2-创建角色,3-等级提升,5-进入游戏
@property(nonatomic,strong)NSString *roleID;
@property(nonatomic,strong)NSString *roleLevel;
@property(nonatomic,strong)NSString *roleName;
@property(nonatomic,strong)NSString *serverID;
@property(nonatomic,strong)NSString *serverName;
*/
-(void)accountBind
{
//    [[HGHMainView shareInstance] showAccountBindView];
    HGHUserInfo *userInfo = [[HGHUserInfo alloc]init];
    userInfo.opType = @"2";
    userInfo.roleID = @"123";
    userInfo.roleLevel = @"12";
    userInfo.roleName = @"测试";
    userInfo.serverID = @"1";
    userInfo.serverName = @"1服";
    [HGHPandas ReportUserInfo:userInfo];
    
}

-(void)guestBind
{
//    [[HGHMainView shareInstance] showGuestBindView];
}

-(void)test1
{
    [[HGHMainView shareInstance] showRenzhengViewWithUserInfo:@{@"test":@"test"}];
}

-(void)clickTest:(UIButton *)sender
{
    switch (sender.tag) {
        case 200:
            NSLog(@"账号绑定");
            [self accountBind];
            break;
        case 201:
            NSLog(@"游客绑定");
            [self guestBind];
            break;
        case 202:
            NSLog(@"实名认证");
            [self test1];
            break;
        case 203:
            NSLog(@"支付");
            [self pay];
            break;
            
            
        default:
            break;
    }
}

-(void)click:(UIButton *)sender
{
    [self test];
}

@end
