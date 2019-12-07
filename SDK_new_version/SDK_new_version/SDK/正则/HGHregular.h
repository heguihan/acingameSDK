//
//  HGHregular.h
//  SDK_new_version
//
//  Created by Lucas on 2019/12/3.
//  Copyright © 2019 Lucas. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HGHregular : NSObject
+(BOOL)regularPhoneNO:(NSString *)phoneNO;
+(BOOL)regularUserName:(NSString *)userName;
+(BOOL)regularPassword:(NSString *)password;
+(BOOL)regularIdCardNum:(NSString *)idCardNum;
@end

NS_ASSUME_NONNULL_END
