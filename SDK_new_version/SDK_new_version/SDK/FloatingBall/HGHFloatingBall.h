//
//  HGHFloatingBall.h
//  testFunc
//
//  Created by Lucas on 2019/11/29.
//  Copyright © 2019 Lucas. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HGHFloatingBall : UIWindow
@property(nonatomic,assign)BOOL isHalfHidden;
+(instancetype)shareInstance;
@end

NS_ASSUME_NONNULL_END
