/***************************************************************************************************
 **  Copyright © 2016年 Jinn Chang. All rights reserved.
 **  Giuhub: https://github.com/jinnchang
 **
 **  FileName: JinnLockViewController.h
 **  Description: 解锁密码控制器
 **
 **  History
 **  -----------------------------------------------------------------------------------------------
 **  Author: jinnchang
 **  Date: 16/4/28
 **  Version: 1.0.0
 **  Remark: Create
 **************************************************************************************************/

#import "JinnLockSudoko.h"
#import "JinnLockIndicator.h"
#import "JinnLockPassword.h"

/**
 *  控制器类型
 */
typedef NS_ENUM(NSInteger, JinnLockType)
{
    JinnLockTypeCreate = 0, ///< 创建密码控制器
    JinnLockTypeModify,     ///< 修改密码控制器
    JinnLockTypeVerify,     ///< 验证密码控制器
    JinnLockTypeRemove      ///< 移除密码控制器
};

typedef NS_ENUM(NSInteger, JinnLockAppearMode)
{
    JinnLockAppearModePush = 0,
    JinnLockAppearModePresent
};


@class JinnLockViewController;

@protocol JinnLockViewControllerDelegate <NSObject>

@optional

/**
 *  密码创建成功
 *
 *  @param newPassword 新密码
 */
- (void)passwordDidCreate:(NSString *)newPassword;

/**
 *  密码修改成功
 *
 *  @param newPassword 新密码
 */
- (void)passwordDidModify:(NSString *)newPassword;

/**
 *  密码验证成功
 *
 *  @param oldPassword 老密码
 */
- (void)passwordDidVerify:(NSString *)oldPassword;

/**
 *  密码移除成功
 */
- (void)passwordDidRemove;

@end

@interface JinnLockViewController : UIViewController

@property (nonatomic, weak) id<JinnLockViewControllerDelegate> delegate;
@property (nonatomic, assign) JinnLockType type;
@property (nonatomic, assign) JinnLockAppearMode appearMode;

- (instancetype)initWithType:(JinnLockType)type appearMode:(JinnLockAppearMode)appearMode;

@end