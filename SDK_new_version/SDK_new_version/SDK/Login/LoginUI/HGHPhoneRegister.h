//
//  HGHPhoneRegister.h
//  SDK_new_version
//
//  Created by Lucas on 2019/12/3.
//  Copyright © 2019 Lucas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HGHBaseview.h"
#import "HGHbaseUITextField.h"
NS_ASSUME_NONNULL_BEGIN

@interface HGHPhoneRegister : UIImageView
@property(nonatomic, strong)UIImageView *imageView;
@property(nonatomic,strong)HGHbaseUITextField *phoneTF;
@property(nonatomic,strong)HGHbaseUITextField *pwdTF;
@property(nonatomic,strong)HGHbaseUITextField *codeTF;
+(instancetype)shareInstance;
-(void)showPhoneRegister;
@end

NS_ASSUME_NONNULL_END
