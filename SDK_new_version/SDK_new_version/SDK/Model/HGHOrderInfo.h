//
//  HGHOrderInfo.h
//  SDK_new_version
//
//  Created by Lucas on 2019/12/2.
//  Copyright © 2019 Lucas. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HGHOrderInfo : NSObject
@property(nonatomic,strong)NSString *cpOrderID;
@property(nonatomic,strong)NSString *extension;
@property(nonatomic,strong)NSString *gameCallbackUrl;
@property(nonatomic,strong)NSString *money;
@property(nonatomic,strong)NSString *productID;
@property(nonatomic,strong)NSString *serverID;
@property(nonatomic,strong)NSString *serverName;
@property(nonatomic,strong)NSString *roleID;
@property(nonatomic,strong)NSString *roleName;
@property(nonatomic,strong)NSString *productName;
@property(nonatomic,strong)NSString *productDesc;
@end

NS_ASSUME_NONNULL_END
