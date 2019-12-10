//
//  BPMaiWebview.m
//  ShuZhiZhangSDK
//
//  Created by SkyGame on 2018/6/27.
//  Copyright © 2018年 John Cheng. All rights reserved.
//

#import "BPMaiWebview.h"

@interface BPMaiWebview ()<UIWebViewDelegate>

{
//    ShuZhiZhangOrderInfo *orderInfoList;
    
}

@end

@implementation BPMaiWebview



static BPMaiWebview *methodView =nil;

+(BPMaiWebview *)shareInstance{
    
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        
        methodView = [[BPMaiWebview alloc] init];
        
        
    });
    return methodView;
    
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.frame = CGRectMake(0, 0, REAL_SCREEN_WIDTH, REAL_SCREEN_HEIGHT);
        self.backgroundColor = [UIColor clearColor];
        self.tag = 757575;
//        orderInfoList = [[ShuZhiZhangOrderInfo alloc]init];
    }
    return self;
}



-(void) showPurchaseMethodChooseView:(NSString *)orderInfo
{
//    orderInfoList = orderInfo;
    self.backgroundColor = [UIColor redColor];
    [[ShuZhiZhangUtility getCurrentViewController].view addSubview:self];
    UIImageView * backImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ShuZhiZhang.bundle/gobackground.png"]];
//    backImageView.frame = CGRectMake((REAL_SCREEN_WIDTH - BPBackImageWidth)/2.0,(REAL_SCREEN_HEIGHT - BPBackImageHeight+100)/2.0, BPBackImageWidth, BPBackImageHeight-100);
    backImageView.frame = CGRectMake(0, 0, REAL_SCREEN_WIDTH, REAL_SCREEN_HEIGHT);
    backImageView.tag = 13100;
    backImageView.userInteractionEnabled = YES;
    backImageView.layer.masksToBounds = YES;
    backImageView.contentMode = UIViewContentModeScaleToFill;
    backImageView.layer.cornerRadius = 5;
    [self addSubview:backImageView];
    
    // 左上角小X按钮
    UIButton * leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftButton setImage:[UIImage imageNamed:@"ShuZhiZhang.bundle/BP_login_close.png"] forState:UIControlStateNormal];
    [leftButton setImage:[UIImage imageNamed:@"ShuZhiZhang.bundle/BP_login_close.png"] forState:UIControlStateHighlighted];
    leftButton.frame = CGRectMake(REAL_SCREEN_WIDTH-30, 5, 45, 45);
    [leftButton setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 20, 20)];
    [leftButton addTarget:self action:@selector(clickCancelButtonAction) forControlEvents:UIControlEventTouchUpInside];
   
    
    UIWebView *webview = [[UIWebView alloc]initWithFrame:backImageView.bounds];
    webview.delegate = self;
    [backImageView addSubview:webview];
    [backImageView addSubview:leftButton];
    NSLog(@"full url is =%@",orderInfo);
    NSURL *url = [NSURL URLWithString:orderInfo];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    
    NSString *urlEncode = [orderInfo stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"urlEncode=%@",urlEncode);
    NSMutableURLRequest *requestH = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:orderInfo] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
    [[UIApplication sharedApplication] openURL:requestH.URL];
//    [webview loadRequest:request];
    
    
}
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    NSLog(@"loading...");
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSLog(@"加载完成");
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    NSLog(@"加载失败");
}
-(void)clickCancelButtonAction
{
    NSLog(@"关闭");
    [UIView animateWithDuration:2 animations:^{
        
    } completion:^(BOOL finished) {
        
        [self removeFromSuperview];
        
    }];
}




@end
