//
//  HGHPhoneLogin.h
//  SDK_new_version
//
//  Created by Lucas on 2019/12/3.
//  Copyright © 2019 Lucas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HGHBaseview.h"
#import "HGHbaseUITextField.h"
NS_ASSUME_NONNULL_BEGIN

@interface HGHPhoneLogin : UIImageView
@property(nonatomic, strong)UIImageView *imageView;
@property(nonatomic,strong)HGHbaseUITextField *phoneTF;
@property(nonatomic,strong)HGHbaseUITextField *pwdTF;
+(instancetype)shareInstance;
-(void)showPhoneLogin;
@end

NS_ASSUME_NONNULL_END
