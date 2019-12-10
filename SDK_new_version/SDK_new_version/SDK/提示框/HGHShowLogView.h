//
//  HGHShowLogView.h
//  SDK_new_version
//
//  Created by Lucas on 2019/12/9.
//  Copyright © 2019 Lucas. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HGHbaseUIImageView.h"
NS_ASSUME_NONNULL_BEGIN

@interface HGHShowLogView : NSObject
@property(nonatomic,strong)NSTimer *timer;
@property(nonatomic,strong)HGHbaseUIImageView *showLogView;
+(instancetype)shareInstance;
-(void)showLogsWithMsg:(NSString *)msg;
@end

NS_ASSUME_NONNULL_END
