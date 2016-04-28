# JinnLock
A gesture unlock view controller for iOS by jinnchang.
# Preview
![image](https://github.com/jinnchang/JinnLock/blob/master/Preview/preview.gif)
# Usage
```objective-c
#import "JinnLockViewController.h"
```
* JinnLockViewController
```objc
JinnLockViewController *lockViewController = [[JinnLockViewController alloc] initWithType:JinnLockTypeVerify appearMode:JinnLockAppearModePresent];
[lockViewController setDelegate:self];
[self presentViewController:lockViewController animated:YES completion:nil];
```
* JinnLockViewControllerDelegate
```objc
- (void)passwordDidCreate:(NSString *)newPassword;
- (void)passwordDidModify:(NSString *)newPassword;
- (void)passwordDidVerify:(NSString *)oldPassword;
- (void)passwordDidRemove;
```
* JinnLockPassword
```objc
+ (BOOL)isEncrypted;
+ (BOOL)setNewPassword:(NSString *)password;
+ (NSString *)oldPassword;
+ (void)removePassword;
```
* JinnLockConfig
```objc
You may custom the theme in the configuration file.

// 指示器大小
#define JINN_LOCK_INDICATOR_SIDE_LENGTH 30.0f

// 九宫格大小
#define JINN_LOCK_SUDOKO_SIDE_LENGTH 300.0f

// 圆圈边框粗细(指示器和九宫格的一样粗细)
#define JINN_LOCK_CIRCLE_WIDTH 0.5f

// 指示器轨迹粗细
#define JINN_LOCK_INDICATOR_TRACK_WIDTH 0.5f

// 九宫格轨迹粗细
#define JINN_LOCK_SUDOKO_TRACK_WIDTH 4.0f

// 圆圈选中效果中心点和圆圈比例
#define JINN_LOCK_CIRCLE_CENTER_RATIO 0.24f

// 背景颜色
#define JINN_LOCK_COLOR_BACKGROUND [UIColor whiteColor]

// 正常主题颜色
#define JINN_LOCK_COLOR_NORMAL [UIColor blackColor]

// 错误提示颜色
#define JINN_LOCK_COLOR_ERROR [UIColor redColor]

// 重设按钮颜色
#define JINN_LOCK_COLOR_RESET [UIColor grayColor]

// 最少连接个数
#define JINN_LOCK_CONNECTION_MIN_NUM 4

// 指示器标签基数(不建议更改)
#define JINN_LOCK_INDICATOR_LEVEL_BASE 1000

// 九宫格标签基数(不建议更改)
#define JINN_LOCK_SUDOKO_LEVEL_BASE 2000

// 密码键(不建议更改)
#define JINN_LOCK_PASSWORD @"JinnLockPassword"

// 提示文本
#define JINN_LOCK_RESET_TEXT     @"重新设置"
#define JINN_LOCK_NEW_TEXT       @"请设置新密码"
#define JINN_LOCK_AGAIN_TEXT     @"请再次确认新密码"
#define JINN_LOCK_NOT_MATCH_TEXT @"两次密码不匹配"
#define JINN_LOCK_RE_NEW_TEXT    @"请重新设置新密码"
#define JINN_LOCK_OLD_TEXT       @"请输入旧密码"
#define JINN_LOCK_OLD_ERROR_TEXT @"密码不正确"
#define JINN_LOCK_RE_OLD_TEXT    @"请重新输入旧密码"
#define JINN_LOCK_NOT_ENOUGH     [NSString stringWithFormat:@"最少连接%d个点，请重新输入", JINN_LOCK_CONNECTION_MIN_NUM]
```
# Blog
http://blog.csdn.net/jinnchang
