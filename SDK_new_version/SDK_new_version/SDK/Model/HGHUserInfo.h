//
//  HGHUserInfo.h
//  SDK_new_version
//
//  Created by Lucas on 2019/12/2.
//  Copyright © 2019 Lucas. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HGHUserInfo : NSObject
@property(nonatomic,strong)NSString *ID;
@property(nonatomic,strong)NSString *deviceID;
@property(nonatomic,strong)NSString *opType;
@property(nonatomic,strong)NSString *roleID;
@property(nonatomic,strong)NSString *roleLevel;
@property(nonatomic,strong)NSString *roleName;
@property(nonatomic,strong)NSString *serverID;
@property(nonatomic,strong)NSString *serverName;
@end

NS_ASSUME_NONNULL_END
