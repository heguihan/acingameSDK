//
//  HGHMainView.h
//  iOS_SDK_chonggou
//
//  Created by Lucas on 2019/11/25.
//  Copyright © 2019 Lucas. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HGHBaseview.h"
NS_ASSUME_NONNULL_BEGIN

@interface HGHMainView : NSObject
@property(nonatomic,strong)HGHBaseview *baseView;
+(instancetype)shareInstance;
-(void)login;
-(void)showRenzhengView;
-(void)showAccountBindView;
-(void)showGuestBindView;
@end

NS_ASSUME_NONNULL_END
