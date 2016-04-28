/***************************************************************************************************
 **  Copyright © 2016年 Jinn Chang. All rights reserved.
 **  Giuhub: https://github.com/jinnchang
 **
 **  FileName: JinnLockSudoko.h
 **  Description: 解锁九宫格
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

@class JinnLockSudoko;

@protocol JinnLockSudokoDelegate <NSObject>

- (void)sudoko:(JinnLockSudoko *)sudoko passwordDidCreate:(NSString *)password;

@end

@interface JinnLockSudoko : UIView

@property (nonatomic, weak) id<JinnLockSudokoDelegate> delegate;

- (instancetype)init;
- (void)showErrorPassword:(NSString *)errorPassword;
- (void)reset;

@end