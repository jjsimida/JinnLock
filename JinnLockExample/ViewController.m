//
//  ViewController.m
//  JinnLockExample
//
//  Created by jinnchang on 16/8/10.
//  Copyright © 2016年 Jinn Chang. All rights reserved.
//

#import "ViewController.h"
#import "Masonry.h"
#import "LockSettingViewController.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"设置";
    
    UITableView *settingTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    [settingTableView setShowsVerticalScrollIndicator:NO];
    [settingTableView setShowsHorizontalScrollIndicator:NO];
    [settingTableView setDataSource:self];
    [settingTableView setDelegate:self];
    [self.view addSubview:settingTableView];
    [settingTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.left.right.equalTo(self.view);
    }];
}

#pragma mark - UITableViewDataSource & UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *idendifier = @"SettingTableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:idendifier];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idendifier];
    }
    
    if (indexPath.row == 0)
    {
        cell.textLabel.text = @"应用加密";
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    else if (indexPath.row == 1)
    {
        cell.textLabel.text = @"版本信息";
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 0)
    {
        [self.navigationController pushViewController:[[LockSettingViewController alloc] init] animated:YES];
    }
}

@end