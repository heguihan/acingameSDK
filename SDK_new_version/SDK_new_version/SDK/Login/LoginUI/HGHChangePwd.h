//
//  HGHChangePwd.h
//  SDK_new_version
//
//  Created by Lucas on 2019/12/5.
//  Copyright © 2019 Lucas. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HGHBaseview.h"
#import "HGHbaseUITextField.h"
NS_ASSUME_NONNULL_BEGIN

@interface HGHChangePwd : NSObject
@property(nonatomic, strong)UIImageView *imageView;
@property(nonatomic,strong)HGHbaseUITextField *phoneTF;
@property(nonatomic,strong)HGHbaseUITextField *pwdTF;
@property(nonatomic,strong)HGHbaseUITextField *codeTF;
+(instancetype)shareInstance;
-(void)showChangePwdView;

    

@end

NS_ASSUME_NONNULL_END
