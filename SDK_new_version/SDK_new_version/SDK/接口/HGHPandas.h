//
//  HGHPandas.h
//  SDK_new_version
//
//  Created by Lucas on 2019/12/3.
//  Copyright © 2019 Lucas. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HGHUserInfo.h"
#import "HGHOrderInfo.h"
NS_ASSUME_NONNULL_BEGIN

@interface HGHPandas : NSObject
@property (nonatomic,copy)void(^loginBlock)(NSDictionary*loginInfo);
@property(nonatomic,copy)void(^logoutBlock)(void);
+(void)SDKinit;
+(instancetype)shareInstance;
-(void)LoginInfo:(void(^)(NSDictionary*loginInfo))infoBlack;
+(void)LogOut;  //游戏退出调用SDK退出
-(void)LogoutCallBack:(void(^)(void))logoutblock; //SDK退出->游戏退到登录界面
+(void)ReportUserInfo:(HGHUserInfo *)userInfo;
+(void)MaiWithOrderInfo:(HGHOrderInfo *)orderInfo;
@end

NS_ASSUME_NONNULL_END
