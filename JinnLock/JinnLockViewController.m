/***************************************************************************************************
 **  Copyright © 2016年 Jinn Chang. All rights reserved.
 **  Giuhub: https://github.com/jinnchang
 **
 **  FileName: JinnLockViewController.m
 **  Description: 解锁密码控制器
 **
 **  History
 **  -----------------------------------------------------------------------------------------------
 **  Author: jinnchang
 **  Date: 16/4/28
 **  Version: 1.0.0
 **  Remark: Create
 **************************************************************************************************/

#import "JinnLockViewController.h"
#import "JinnLockConfig.h"
#import "Masonry.h"

typedef NS_ENUM(NSInteger, JinnLockStep)
{
    JinnLockStepNone = 0,
    JinnLockStepCreateNew,
    JinnLockStepCreateAgain,
    JinnLockStepCreateNotMatch,
    JinnLockStepCreateReNew,
    JinnLockStepModifyOld,
    JinnLockStepModifyOldError,
    JinnLockStepModifyReOld,
    JinnLockStepModifyNew,
    JinnLockStepModifyAgain,
    JinnLockStepModifyNotMatch,
    JinnLockStepModifyReNew,
    JinnLockStepVerifyOld,
    JinnLockStepVerifyOldError,
    JinnLockStepVerifyReOld,
    JinnLockStepRemoveOld,
    JinnLockStepRemoveOldError,
    JinnLockStepRemoveReOld
};

@interface JinnLockViewController () <JinnLockSudokoDelegate>

@property (nonatomic, strong) JinnLockIndicator *indicator;
@property (nonatomic, strong) JinnLockSudoko *sudoko;
@property (nonatomic, strong) UILabel *noticeLabel;
@property (nonatomic, strong) UIButton *resetButton;

@property (nonatomic, assign) JinnLockStep step;
@property (nonatomic, strong) NSString *passwordTemp;

@end

@implementation JinnLockViewController

#pragma mark - Override

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setup];
    [self createViews];
    
    switch (self.type)
    {
        case JinnLockTypeCreate:
        {
            [self updateGuiForStep:JinnLockStepCreateNew];
        }
            break;
        case JinnLockTypeModify:
        {
            [self updateGuiForStep:JinnLockStepModifyOld];
        }
            break;
        case JinnLockTypeVerify:
        {
            [self updateGuiForStep:JinnLockStepVerifyOld];
        }
            break;
        case JinnLockTypeRemove:
        {
            [self updateGuiForStep:JinnLockStepRemoveOld];
        }
            break;
        default:
            break;
    }
}

#pragma mark - Init

- (instancetype)initWithType:(JinnLockType)type appearMode:(JinnLockAppearMode)appearMode
{
    self = [super init];
    
    if (self)
    {
        self.type = type;
        self.appearMode = appearMode;
    }
    
    return self;
}

- (void)setup
{
    self.view.backgroundColor = JINN_LOCK_COLOR_BACKGROUND;
    self.step = JinnLockStepNone;
}

- (void)createViews
{
    UILabel *noticeLabel = [[UILabel alloc] init];
    [noticeLabel setFont:[UIFont systemFontOfSize:14]];
    [noticeLabel setTextAlignment:NSTextAlignmentCenter];
    [self.view addSubview:noticeLabel];
    [self setNoticeLabel:noticeLabel];
    [noticeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.view).offset(60);
        make.height.mas_equalTo(20);
    }];
    
    JinnLockIndicator *indicator = [[JinnLockIndicator alloc] init];
    [self.view addSubview:indicator];
    [self setIndicator:indicator];
    [indicator mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(noticeLabel.mas_bottom).offset(30);
        make.size.mas_equalTo(CGSizeMake(JINN_LOCK_INDICATOR_SIDE_LENGTH, JINN_LOCK_INDICATOR_SIDE_LENGTH));
    }];
    
    JinnLockSudoko *sudoko = [[JinnLockSudoko alloc] init];
    [sudoko setDelegate:self];
    [self.view addSubview:sudoko];
    [self setSudoko:sudoko];
    [sudoko mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.centerX.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(JINN_LOCK_SUDOKO_SIDE_LENGTH, JINN_LOCK_SUDOKO_SIDE_LENGTH));
    }];
    
    UIButton *resetButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [resetButton setTitle:JINN_LOCK_RESET_TEXT forState:UIControlStateNormal];
    [resetButton setTitleColor:JINN_LOCK_COLOR_RESET forState:UIControlStateNormal];
    [resetButton.titleLabel setFont:[UIFont systemFontOfSize:12]];
    [resetButton addTarget:self action:@selector(resetButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:resetButton];
    [self setResetButton:resetButton];
    [resetButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-60);
        make.height.mas_equalTo(20);
    }];
}

#pragma mark - Private

- (void)updateGuiForStep:(JinnLockStep)step
{
    self.step = step;
    
    switch (step)
    {
        case JinnLockStepCreateNew:
        {
            self.noticeLabel.text = JINN_LOCK_NEW_TEXT;
            self.noticeLabel.textColor = JINN_LOCK_COLOR_NORMAL;
            self.indicator.hidden = YES;
            self.resetButton.hidden = YES;
        }
            break;
        case JinnLockStepCreateAgain:
        {
            self.noticeLabel.text = JINN_LOCK_AGAIN_TEXT;
            self.noticeLabel.textColor = JINN_LOCK_COLOR_NORMAL;
            self.indicator.hidden = NO;
            self.resetButton.hidden = NO;
        }
            break;
        case JinnLockStepCreateNotMatch:
        {
            self.noticeLabel.text = JINN_LOCK_NOT_MATCH_TEXT;
            self.noticeLabel.textColor = JINN_LOCK_COLOR_ERROR;
            self.indicator.hidden = YES;
            self.resetButton.hidden = YES;
        }
            break;
        case JinnLockStepCreateReNew:
        {
            self.noticeLabel.text = JINN_LOCK_RE_NEW_TEXT;
            self.noticeLabel.textColor = JINN_LOCK_COLOR_NORMAL;
            self.indicator.hidden = YES;
            self.resetButton.hidden = YES;
        }
            break;
        case JinnLockStepModifyOld:
        {
            self.noticeLabel.text = JINN_LOCK_OLD_TEXT;
            self.noticeLabel.textColor = JINN_LOCK_COLOR_NORMAL;
            self.indicator.hidden = YES;
            self.resetButton.hidden = YES;
        }
            break;
        case JinnLockStepModifyOldError:
        {
            self.noticeLabel.text = JINN_LOCK_OLD_ERROR_TEXT;
            self.noticeLabel.textColor = JINN_LOCK_COLOR_ERROR;
            self.indicator.hidden = YES;
            self.resetButton.hidden = YES;
        }
            break;
        case JinnLockStepModifyReOld:
        {
            self.noticeLabel.text = JINN_LOCK_RE_OLD_TEXT;
            self.noticeLabel.textColor = JINN_LOCK_COLOR_NORMAL;
            self.indicator.hidden = YES;
            self.resetButton.hidden = YES;
        }
            break;
        case JinnLockStepModifyNew:
        {
            self.noticeLabel.text = JINN_LOCK_NEW_TEXT;
            self.noticeLabel.textColor = JINN_LOCK_COLOR_NORMAL;
            self.indicator.hidden = YES;
            self.resetButton.hidden = YES;
        }
            break;
        case JinnLockStepModifyAgain:
        {
            self.noticeLabel.text = JINN_LOCK_AGAIN_TEXT;
            self.noticeLabel.textColor = JINN_LOCK_COLOR_NORMAL;
            self.indicator.hidden = NO;
            self.resetButton.hidden = NO;
        }
            break;
        case JinnLockStepModifyNotMatch:
        {
            self.noticeLabel.text = JINN_LOCK_NOT_MATCH_TEXT;
            self.noticeLabel.textColor = JINN_LOCK_COLOR_ERROR;
            self.indicator.hidden = YES;
            self.resetButton.hidden = YES;
        }
            break;
        case JinnLockStepModifyReNew:
        {
            self.noticeLabel.text = JINN_LOCK_RE_NEW_TEXT;
            self.noticeLabel.textColor = JINN_LOCK_COLOR_NORMAL;
            self.indicator.hidden = YES;
            self.resetButton.hidden = YES;
        }
            break;
        case JinnLockStepVerifyOld:
        {
            self.noticeLabel.text = JINN_LOCK_OLD_TEXT;
            self.noticeLabel.textColor = JINN_LOCK_COLOR_NORMAL;
            self.indicator.hidden = YES;
            self.resetButton.hidden = YES;
        }
            break;
        case JinnLockStepVerifyOldError:
        {
            self.noticeLabel.text = JINN_LOCK_OLD_ERROR_TEXT;
            self.noticeLabel.textColor = JINN_LOCK_COLOR_ERROR;
            self.indicator.hidden = YES;
            self.resetButton.hidden = YES;
        }
            break;
        case JinnLockStepVerifyReOld:
        {
            self.noticeLabel.text = JINN_LOCK_RE_OLD_TEXT;
            self.noticeLabel.textColor = JINN_LOCK_COLOR_NORMAL;
            self.indicator.hidden = YES;
            self.resetButton.hidden = YES;
        }
            break;
        case JinnLockStepRemoveOld:
        {
            self.noticeLabel.text = JINN_LOCK_OLD_TEXT;
            self.noticeLabel.textColor = JINN_LOCK_COLOR_NORMAL;
            self.indicator.hidden = YES;
            self.resetButton.hidden = YES;
        }
            break;
        case JinnLockStepRemoveOldError:
        {
            self.noticeLabel.text = JINN_LOCK_OLD_ERROR_TEXT;
            self.noticeLabel.textColor = JINN_LOCK_COLOR_ERROR;
            self.indicator.hidden = YES;
            self.resetButton.hidden = YES;
        }
            break;
        case JinnLockStepRemoveReOld:
        {
            self.noticeLabel.text = JINN_LOCK_RE_OLD_TEXT;
            self.noticeLabel.textColor = JINN_LOCK_COLOR_NORMAL;
            self.indicator.hidden = YES;
            self.resetButton.hidden = YES;
        }
        default:
            break;
    }
}

- (void)shakeAnimationForView:(UIView *)view
{
    CALayer *viewLayer = view.layer;
    CGPoint position = viewLayer.position;
    CGPoint left = CGPointMake(position.x - 10, position.y);
    CGPoint right = CGPointMake(position.x + 10, position.y);
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [animation setFromValue:[NSValue valueWithCGPoint:left]];
    [animation setToValue:[NSValue valueWithCGPoint:right]];
    [animation setAutoreverses:YES];
    [animation setDuration:0.08];
    [animation setRepeatCount:3];
    [viewLayer addAnimation:animation forKey:nil];
}

#pragma mark - Action

- (void)hide
{
    switch (self.appearMode)
    {
        case JinnLockAppearModePush:
        {
            [self.navigationController popViewControllerAnimated:YES];
        }
            break;
        case JinnLockAppearModePresent:
        {
            [self dismissViewControllerAnimated:YES completion:nil];
        }
            break;
        default:
            break;
    }
}

- (void)resetButtonClick
{
    if (self.type == JinnLockTypeCreate)
    {
        [self updateGuiForStep:JinnLockStepCreateNew];
    }
    else if (self.type == JinnLockTypeModify)
    {
        [self updateGuiForStep:JinnLockStepModifyNew];
    }
}

#pragma mark - JinnLockSudokoDelegate

- (void)sudoko:(JinnLockSudoko *)sudoko passwordDidCreate:(NSString *)password
{
    if ([password length] < JINN_LOCK_CONNECTION_MIN_NUM)
    {
        [self.noticeLabel setText:JINN_LOCK_NOT_ENOUGH];
        [self.noticeLabel setTextColor:JINN_LOCK_COLOR_ERROR];
        [self shakeAnimationForView:self.noticeLabel];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self updateGuiForStep:self.step];
        });
        
        return;
    }
    
    switch (self.step)
    {
        case JinnLockStepCreateNew:
        case JinnLockStepCreateReNew:
        {
            self.passwordTemp = password;
            [self updateGuiForStep:JinnLockStepCreateAgain];
        }
            break;
        case JinnLockStepCreateAgain:
        {
            if ([password isEqualToString:self.passwordTemp])
            {
                [JinnLockPassword setNewPassword:password];
                
                if ([self.delegate respondsToSelector:@selector(passwordDidCreate:)])
                {
                    [self.delegate passwordDidCreate:password];
                }
                
                [self hide];
            }
            else
            {
                [self updateGuiForStep:JinnLockStepCreateNotMatch];
                [self.sudoko showErrorPassword:password];
                [self shakeAnimationForView:self.noticeLabel];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self updateGuiForStep:JinnLockStepCreateReNew];
                });
            }
        }
            break;
        case JinnLockStepModifyOld:
        case JinnLockStepModifyReOld:
        {
            if ([password isEqualToString:[JinnLockPassword oldPassword]])
            {
                [self updateGuiForStep:JinnLockStepModifyNew];
            }
            else
            {
                [self updateGuiForStep:JinnLockStepModifyOldError];
                [self.sudoko showErrorPassword:password];
                [self shakeAnimationForView:self.noticeLabel];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self updateGuiForStep:JinnLockStepModifyReOld];
                });
            }
        }
            break;
        case JinnLockStepModifyNew:
        case JinnLockStepModifyReNew:
        {
            self.passwordTemp = password;
            [self updateGuiForStep:JinnLockStepModifyAgain];
        }
            break;
        case JinnLockStepModifyAgain:
        {
            if ([password isEqualToString:self.passwordTemp])
            {
                [JinnLockPassword setNewPassword:password];
                
                if ([self.delegate respondsToSelector:@selector(passwordDidModify:)])
                {
                    [self.delegate passwordDidModify:password];
                }
                
                [self hide];
            }
            else
            {
                [self updateGuiForStep:JinnLockStepModifyNotMatch];
                [self.sudoko showErrorPassword:password];
                [self shakeAnimationForView:self.noticeLabel];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self updateGuiForStep:JinnLockStepModifyReNew];
                });
            }
        }
            break;
        case JinnLockStepVerifyOld:
        case JinnLockStepVerifyReOld:
        {
            if ([password isEqualToString:[JinnLockPassword oldPassword]])
            {
                if ([self.delegate respondsToSelector:@selector(passwordDidVerify:)])
                {
                    [self.delegate passwordDidVerify:password];
                }
                
                [self hide];
            }
            else
            {
                [self updateGuiForStep:JinnLockStepVerifyOldError];
                [self.sudoko showErrorPassword:password];
                [self shakeAnimationForView:self.noticeLabel];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self updateGuiForStep:JinnLockStepVerifyReOld];
                });
            }
        }
            break;
        case JinnLockStepRemoveOld:
        case JinnLockStepRemoveReOld:
        {
            if ([password isEqualToString:[JinnLockPassword oldPassword]])
            {
                [JinnLockPassword removePassword];
                
                if ([self.delegate respondsToSelector:@selector(passwordDidRemove)])
                {
                    [self.delegate passwordDidRemove];
                }
                
                [self hide];
            }
            else
            {
                [self updateGuiForStep:JinnLockStepRemoveOldError];
                [self.sudoko showErrorPassword:password];
                [self shakeAnimationForView:self.noticeLabel];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self updateGuiForStep:JinnLockStepRemoveReOld];
                });
            }
        }
            break;
        default:
            break;
    }
    
    [self.indicator showPassword:password];
}

@end