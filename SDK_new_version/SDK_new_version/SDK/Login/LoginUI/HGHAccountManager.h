//
//  HGHAccountManager.h
//  SDK_new_version
//
//  Created by Lucas on 2019/12/9.
//  Copyright © 2019 Lucas. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HGHAccountManager : NSObject

@property(nonatomic, strong)UIImageView *imageView;
+(instancetype)shareInstance;
-(void)showAccountManager;

@end

NS_ASSUME_NONNULL_END
