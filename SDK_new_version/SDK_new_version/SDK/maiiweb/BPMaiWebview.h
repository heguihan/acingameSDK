//
//  BPMaiWebview.h
//  ShuZhiZhangSDK
//
//  Created by SkyGame on 2018/6/27.
//  Copyright © 2018年 John Cheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShuZhiZhangOrderInfo.h"

@interface BPMaiWebview : UIView

+(BPMaiWebview *)shareInstance;
-(void) showPurchaseMethodChooseView:(NSString *)orderInfo;

@end
