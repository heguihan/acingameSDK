//
//  HGHShowBall.h
//  testFunc
//
//  Created by Lucas on 2019/11/29.
//  Copyright © 2019 Lucas. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HGHFloatingBall.h"
NS_ASSUME_NONNULL_BEGIN

@interface HGHShowBall : NSObject
@property(nonatomic,strong)HGHFloatingBall *floatBall;
+(instancetype)shareInstance;
+(void)showFloatingball;
@end

NS_ASSUME_NONNULL_END
