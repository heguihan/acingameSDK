//
//  HGHAccountRegister.h
//  SDK_new_version
//
//  Created by Lucas on 2019/12/3.
//  Copyright © 2019 Lucas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HGHBaseview.h"
#import "HGHbaseUITextField.h"
NS_ASSUME_NONNULL_BEGIN

@interface HGHAccountRegister : UIImageView
@property(nonatomic, strong)UIImageView *imageView;
@property(nonatomic,strong)HGHbaseUITextField *userTF;
@property(nonatomic,strong)HGHbaseUITextField *pwdTF;
+(instancetype)shareInstance;
-(void)showAccountRegister;
@end

NS_ASSUME_NONNULL_END
