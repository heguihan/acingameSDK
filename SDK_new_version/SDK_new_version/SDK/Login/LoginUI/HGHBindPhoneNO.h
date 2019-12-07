//
//  HGHBindPhoneNO.h
//  SDK_new_version
//
//  Created by Lucas on 2019/12/6.
//  Copyright © 2019 Lucas. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HGHBaseview.h"
#import "HGHbaseUITextField.h"
NS_ASSUME_NONNULL_BEGIN

@interface HGHBindPhoneNO : NSObject
@property(nonatomic, strong)UIImageView *imageView;
@property(nonatomic,strong)HGHbaseUITextField *phoneTF;
@property(nonatomic,strong)HGHbaseUITextField *codeTF;
@property(nonatomic,strong)NSDictionary *userInfo;
+(instancetype)shareInstance;
-(void)showAccountBindView;
-(void)showAccountBindViewAndUserInfo:(NSDictionary *)userInfo;
@end

NS_ASSUME_NONNULL_END
