/***************************************************************************************************
 **  Copyright © 2016年 Jinn Chang. All rights reserved.
 **  Giuhub: https://github.com/jinnchang
 **
 **  FileName: JinnLockPassword.h
 **  Description: 密码管理操作
 **
 **  History
 **  -----------------------------------------------------------------------------------------------
 **  Author: jinnchang
 **  Date: 16/4/28
 **  Version: 1.0.0
 **  Remark: Create
 **************************************************************************************************/

#import <Foundation/Foundation.h>

@interface JinnLockPassword : NSObject

+ (BOOL)isEncrypted;
+ (BOOL)setNewPassword:(NSString *)password;
+ (NSString *)oldPassword;
+ (void)removePassword;

@end