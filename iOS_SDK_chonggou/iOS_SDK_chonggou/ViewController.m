//
//  ViewController.m
//  iOS_SDK_chonggou
//
//  Created by Lucas on 2019/11/25.
//  Copyright © 2019 Lucas. All rights reserved.
//

#import "ViewController.h"

#import "HGHMainView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    [self.view setBackgroundColor:[UIColor redColor]];
    [self begin];
}

-(void)begin
{
    [self creatUI];
}

-(void)creatUI
{
    
    UIButton *testBtn = [[UIButton alloc]initWithFrame:CGRectMake(250, 100, 100, 100)];
    testBtn.backgroundColor = [UIColor orangeColor];
    [testBtn setTitle:@"测试" forState:UIControlStateNormal];
    [self.view addSubview:testBtn];
    [testBtn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    
    NSArray *titleArr = @[@"登录",@"支付",@"测试"];
    for (int i=0; i<3; i++) {
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(100, 50+i*70, 80, 40)];
        btn.backgroundColor = [UIColor orangeColor];
        [btn setTitle:titleArr[i] forState:UIControlStateNormal];
        [self.view addSubview:btn];
        btn.tag = 200+i;
        [btn addTarget:self action:@selector(clickTest:) forControlEvents:UIControlEventTouchUpInside];
    }
}

-(void)test
{
    [[HGHMainView shareInstance] login];
}


-(void)login
{
    
}

-(void)pay
{
    
}

-(void)test1
{
    
}

-(void)clickTest:(UIButton *)sender
{
    switch (sender.tag) {
        case 200:
            NSLog(@"登录");
            [self login];
            break;
        case 201:
            NSLog(@"支付");
            [self pay];
            break;
        case 202:
            NSLog(@"测试");
            [self test1];
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
