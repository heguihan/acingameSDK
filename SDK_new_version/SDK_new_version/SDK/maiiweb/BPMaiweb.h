//
//  BPMaiweb.h
//  ShuZhiZhangSDK
//
//  Created by SkyGame on 2018/6/27.
//  Copyright © 2018年 John Cheng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HGHOrderInfo.h"

@interface BPMaiweb : NSObject
+(instancetype)shareInstance;
-(void)BPMaiurl:(NSString *)url andparms:(HGHOrderInfo *)orderInfo;

@end
