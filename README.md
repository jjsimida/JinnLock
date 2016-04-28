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
You may custom the theme in the configuration file.
# Blog
http://blog.csdn.net/jinnchang