/***************************************************************************************************
 **  Copyright © 2016年 Jinn Chang. All rights reserved.
 **  Giuhub: https://github.com/jinnchang
 **
 **  FileName: JinnLockPassword.m
 **  Description: 密码管理操作
 **
 **  History
 **  -----------------------------------------------------------------------------------------------
 **  Author: jinnchang
 **  Date: 16/4/28
 **  Version: 1.0.0
 **  Remark: Create
 **************************************************************************************************/

#import "JinnLockPassword.h"
#import "JinnLockConfig.h"

@implementation JinnLockPassword

+ (BOOL)isEncrypted
{
    NSString *password = [[NSUserDefaults standardUserDefaults] objectForKey:JINN_LOCK_PASSWORD];
    
    if (password == nil)
    {
        return NO;
    }
    else
    {
        return YES;
    }
}

+ (BOOL)setNewPassword:(NSString *)password
{
    if (password == nil || [password isEqualToString:@""] || [password isEqualToString:@"(null)"])
    {
        return NO;
    }
    
    [[NSUserDefaults standardUserDefaults] setObject:password forKey:JINN_LOCK_PASSWORD];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    return YES;
}

+ (NSString *)oldPassword
{
    NSString *password = [[NSUserDefaults standardUserDefaults] objectForKey:JINN_LOCK_PASSWORD];
    
    if (password != nil && ![password isEqualToString:@""] && ![password isEqualToString:@"(null)"])
    {
        return password;
    }
    
    return nil;
}

+ (void)removePassword
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:JINN_LOCK_PASSWORD];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end