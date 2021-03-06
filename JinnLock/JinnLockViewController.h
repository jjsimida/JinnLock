/***************************************************************************************************
 **  Copyright © 2016年 Jinn Chang. All rights reserved.
 **  Giuhub: https://github.com/jinnchang
 **
 **  FileName: JinnLockViewController.h
 **  Description: 解锁密码控制器
 **
 **  Author:  jinnchang
 **  Date:    2016/9/22
 **  Version: 1.0.0
 **  Remark:  Create New File
 **************************************************************************************************/

#import "JinnLockTool.h"
#import "JinnLockSudoko.h"
#import "JinnLockIndicator.h"

/**
 控制器类型
 */
typedef NS_ENUM(NSInteger, JinnLockType)
{
    JinnLockTypeCreate, ///< 创建密码控制器
    JinnLockTypeModify, ///< 修改密码控制器
    JinnLockTypeVerify, ///< 验证密码控制器
    JinnLockTypeRemove  ///< 移除密码控制器
};

typedef NS_ENUM(NSInteger, JinnLockAppearMode)
{
    JinnLockAppearModePush,
    JinnLockAppearModePresent
};

@class JinnLockViewController;

@protocol JinnLockViewControllerDelegate <NSObject>

@optional

/**
 密码创建成功

 @param passcode passcode
 */
- (void)passcodeDidCreate:(NSString *)passcode;

/**
 密码修改成功

 @param passcode passcode
 */
- (void)passcodeDidModify:(NSString *)passcode;

/**
 密码验证成功

 @param passcode passcode
 */
- (void)passcodeDidVerify:(NSString *)passcode;

/**
 密码移除成功
 */
- (void)passcodeDidRemove;

@end

@interface JinnLockViewController : UIViewController

- (instancetype)initWithDelegate:(id<JinnLockViewControllerDelegate>)delegate
                            type:(JinnLockType)type
                      appearMode:(JinnLockAppearMode)appearMode;

@end
