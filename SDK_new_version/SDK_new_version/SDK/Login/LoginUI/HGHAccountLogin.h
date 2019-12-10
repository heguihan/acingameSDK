//
//  HGHAccountLogin.h
//  SDK_new_version
//
//  Created by Lucas on 2019/12/3.
//  Copyright © 2019 Lucas. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HGHBaseview.h"
#import "HGHbaseUITextField.h"
NS_ASSUME_NONNULL_BEGIN

@interface HGHAccountLogin : NSObject
//@property(nonatomic,strong)HGHBaseview *AccountView;
@property(nonatomic, strong)UIImageView *imageView;
@property(nonatomic,strong)HGHbaseUITextField *userTF;
@property(nonatomic,strong)HGHbaseUITextField *pwdTF;
+(instancetype)shareInstance;
-(void)showAccountLogin;
//快速登录调用
-(void)accountLoginRequestWithUserID:(NSString *)user pwd:(NSString *)pwd;
@end

NS_ASSUME_NONNULL_END
