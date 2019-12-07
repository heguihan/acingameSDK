//
//  HGHAlertview.m
//  haiwaiSDK
//
//  Created by Lucas on 2019/3/18.
//  Copyright © 2019 Lucas. All rights reserved.
//

#import "HGHAlertview.h"
#import <UIKit/UIKit.h>
@implementation HGHAlertview

+(instancetype)shareInstance
{
    static HGHAlertview *alert = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        alert = [[super alloc] init];
    });
    
    return alert;
}

+(void)showAlertViewWithMessage:(NSString *)msg
{
    NSLog(@"msg=%@",msg);
    dispatch_async(dispatch_get_main_queue(), ^{
        
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"警告" message:msg delegate:nil cancelButtonTitle:@"确认" otherButtonTitles:nil];
        [alertView show];
    });
    
}

@end
