/***************************************************************************************************
 **  Copyright © 2016年 Jinn Chang. All rights reserved.
 **  Giuhub: https://github.com/jinnchang
 **
 **  FileName: JinnLockIndicator.h
 **  Description: 解锁密码指示器
 **
 **  History
 **  -----------------------------------------------------------------------------------------------
 **  Author: jinnchang
 **  Date: 16/4/28
 **  Version: 1.0.0
 **  Remark: Create
 **************************************************************************************************/

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface JinnLockIndicator : UIView

- (instancetype)init;

- (void)showPassword:(NSString *)password;
- (void)reset;

@end