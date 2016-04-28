//
//  ViewController.m
//  JinnLockExample
//
//  Created by jinnchang on 16/4/28.
//  Copyright © 2016年 Jinn Chang. All rights reserved.
//

#import "ViewController.h"
#import "Masonry.h"
#import "JinnLockViewController.h"

@interface ViewController () <JinnLockViewControllerDelegate>

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self createViews];
}

- (void)createViews
{
    UIButton *createButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [createButton.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [createButton setTitle:@"创建密码" forState:UIControlStateNormal];
    [createButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [createButton addTarget:self action:@selector(createButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:createButton];
    [createButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.centerY.equalTo(self.view).offset(-100);
        make.height.mas_equalTo(50);
    }];
    
    UIButton *modifyButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [modifyButton.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [modifyButton setTitle:@"修改密码" forState:UIControlStateNormal];
    [modifyButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [modifyButton addTarget:self action:@selector(modifyButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:modifyButton];
    [modifyButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.centerY.equalTo(self.view).offset(-50);
        make.height.mas_equalTo(50);
    }];
    
    UIButton *verifyButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [verifyButton.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [verifyButton setTitle:@"验证密码" forState:UIControlStateNormal];
    [verifyButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [verifyButton addTarget:self action:@selector(verifyButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:verifyButton];
    [verifyButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.centerY.equalTo(self.view);
        make.height.mas_equalTo(50);
    }];
    
    UIButton *removeButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [removeButton.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [removeButton setTitle:@"移除密码" forState:UIControlStateNormal];
    [removeButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [removeButton addTarget:self action:@selector(removeButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:removeButton];
    [removeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.centerY.equalTo(self.view).offset(50);
        make.height.mas_equalTo(50);
    }];
}

#pragma mark - Action

- (void)createButtonClicked
{
    JinnLockViewController *lockViewController = [[JinnLockViewController alloc] initWithType:JinnLockTypeCreate appearMode:JinnLockAppearModePresent];
    [lockViewController setDelegate:self];
    [self presentViewController:lockViewController animated:YES completion:nil];
}

- (void)modifyButtonClicked
{
    JinnLockViewController *lockViewController = [[JinnLockViewController alloc] initWithType:JinnLockTypeModify appearMode:JinnLockAppearModePresent];
    [lockViewController setDelegate:self];
    [self presentViewController:lockViewController animated:YES completion:nil];
}

- (void)verifyButtonClicked
{
    JinnLockViewController *lockViewController = [[JinnLockViewController alloc] initWithType:JinnLockTypeVerify appearMode:JinnLockAppearModePresent];
    [lockViewController setDelegate:self];
    [self presentViewController:lockViewController animated:YES completion:nil];
}

- (void)removeButtonClicked
{
    JinnLockViewController *lockViewController = [[JinnLockViewController alloc] initWithType:JinnLockTypeRemove appearMode:JinnLockAppearModePresent];
    [lockViewController setDelegate:self];
    [self presentViewController:lockViewController animated:YES completion:nil];
}

#pragma mark - JinnLockViewControllerDelegate

- (void)passwordDidCreate:(NSString *)newPassword
{
    NSLog(@"密码创建成功:%@", newPassword);
}

- (void)passwordDidModify:(NSString *)newPassword
{
    NSLog(@"密码修改成功:%@", newPassword);
}

- (void)passwordDidVerify:(NSString *)oldPassword
{
    NSLog(@"密码验证成功:%@", oldPassword);
}

- (void)passwordDidRemove
{
    NSLog(@"密码删除成功");
}

@end
