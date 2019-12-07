//
//  HGHbaseUITextField.h
//  SDK_new_version
//
//  Created by Lucas on 2019/12/3.
//  Copyright © 2019 Lucas. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HGHbaseUITextField : UITextField
@property(nonatomic,assign)CGFloat baseX;
@property(nonatomic,assign)CGFloat baseY;
@property(nonatomic,assign)CGFloat baseWidth;
@property(nonatomic,assign)CGFloat baseHeight;
@property(nonatomic,assign)CGFloat baseBottom;
@property(nonatomic,assign)CGFloat baseLeft;


-(instancetype)initWithFrame:(CGRect)frame;
@end

NS_ASSUME_NONNULL_END
