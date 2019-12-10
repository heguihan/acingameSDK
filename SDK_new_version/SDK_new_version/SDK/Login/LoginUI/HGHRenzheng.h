//
//  HGHRenzheng.h
//  SDK_new_version
//
//  Created by Lucas on 2019/12/6.
//  Copyright © 2019 Lucas. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HGHBaseview.h"
#import "HGHbaseUITextField.h"
NS_ASSUME_NONNULL_BEGIN

@interface HGHRenzheng : NSObject
@property(nonatomic, strong)UIImageView *imageView;
@property(nonatomic,strong)HGHbaseUITextField *userTF;
@property(nonatomic,strong)HGHbaseUITextField *idcardTF;
@property(nonatomic,strong)NSDictionary *userInfo;
@property(nonatomic,strong)NSString *pushedBy;
+(instancetype)shareInstance;
-(void)showRenzhengView;
-(void)showRenzhengViewWithUserinfo:(NSDictionary *)userInfo;
@end

NS_ASSUME_NONNULL_END
