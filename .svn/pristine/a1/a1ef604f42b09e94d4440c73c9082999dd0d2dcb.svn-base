//
//  UIViewController+TFCommon.m
//  YunShangShiJi
//
//  Created by jingaiweiyi on 16/7/12.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import "UIViewController+TFCommon.h"
#import <objc/runtime.h>
#import "GlobalTool.h"
#import "AFAppDotNetAPIClient.h"

static const char subViewFlagChar;
static const char subFrameFlagChar;
static const char showTypeFlagChar;
static const char reloadDataBlockFlagChar;
static const char netStatusFlagChar;

NSString *const netStatusNotificationCenter = @"netStatusNotificationCenter";

@interface UIViewController ()

@property (assign, nonatomic) ShowBackgroundType showType;
@property (strong, nonatomic) UIView *subView;
@property (assign, nonatomic) CGRect subFrame;

@end

@implementation UIViewController (TFCommon)

- (void)showBackgroundType:(ShowBackgroundType)showType message:(NSString *)message superView:(UIView *)superView setSubFrame:(CGRect)subFrame
{
    ESWeakSelf;
    UIView *V = superView == nil? self.view: superView;
    
    if (self.subView == nil) {
        UIView *subView = [UIView new];
        subView.tag = 10086;
        [V addSubview:self.subView = subView];
    } else {
        [self.subView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    }
    
    
    CGFloat y = subFrame.origin.y;
    CGFloat x = subFrame.origin.x;
    CGFloat w = subFrame.size.width;
    CGFloat h = subFrame.size.height;
    
    [self.subView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(x);
        make.top.mas_equalTo(y);
        make.size.mas_equalTo(CGSizeMake(w, h));
    }];
    
    CGFloat Margin = 2;
    switch (showType) {
        case ShowBackgroundTypeListEmpty:
        {
            NSString *messageExp = message == nil? @"亲，暂时没有相关数据哦": message;
            UIImageView *imageV = [UIImageView new];
            imageV.image = [UIImage imageNamed:@"笑脸21"];
            [self.subView addSubview:imageV];
            
            [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
                make.size.mas_equalTo(CGSizeMake(105, 80));
                make.centerX.equalTo(__weakSelf.subView.mas_centerX);
                make.bottom.equalTo(__weakSelf.subView.mas_centerY).offset(-Margin);
            }];
            
            UILabel *messageLab = [UILabel new];
            [self.subView addSubview:messageLab];
            messageLab.text = messageExp;
            messageLab.font = [UIFont systemFontOfSize:ZOOM6(28)];
            messageLab.textAlignment = NSTextAlignmentCenter;
            [messageLab mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.equalTo(__weakSelf.subView);
                make.top.equalTo(__weakSelf.subView.mas_centerY).offset(Margin);
                make.height.mas_equalTo(40);
            }];
        }
            break;
        case ShowBackgroundTypeNetError:
        {
            NSString *messageExp = message == nil? @"亲，网络连接失败，请重试": message;
            UIImageView *imageV = [UIImageView new];
            [self.subView addSubview:imageV];
            imageV.image = [UIImage imageNamed:@"哭脸"];
            [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
                make.size.mas_equalTo(CGSizeMake(100, 100));
                make.centerX.equalTo(__weakSelf.subView.mas_centerX);
                make.bottom.equalTo(__weakSelf.subView.mas_centerY).offset(-Margin);
            }];
            
            UILabel *messageLab = [UILabel new];
            [self.subView addSubview:messageLab];
            messageLab.text = messageExp;
            messageLab.textAlignment = NSTextAlignmentCenter;
            messageLab.font = [UIFont systemFontOfSize:ZOOM6(28)];
            [messageLab mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.equalTo(__weakSelf.subView);
                make.top.equalTo(__weakSelf.subView.mas_centerY).offset(Margin);
                make.height.mas_equalTo(40);
            }];
            
            NSString *text = @"重新加载";
            UIButton *tryBtn = [UIButton new];
            [self.subView addSubview:tryBtn];
            [tryBtn setTitle:text forState:UIControlStateNormal];
            [tryBtn setTitleColor:COLOR_ROSERED forState:UIControlStateNormal];
            tryBtn.layer.borderColor = [COLOR_ROSERED CGColor];
            tryBtn.layer.borderWidth = 1;
            tryBtn.layer.cornerRadius = ZOOM6(8);
            tryBtn.layer.masksToBounds = YES;
            tryBtn.titleLabel.font = [UIFont systemFontOfSize:ZOOM6(28)];
            [tryBtn addTarget:self action:@selector(tryBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            CGSize size = [text getSizeWithFont:[UIFont systemFontOfSize:ZOOM6(28)] constrainedToSize:CGSizeMake(2000, 30)];
            
            [tryBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(messageLab.mas_bottom).offset(Margin);
                make.centerX.equalTo(__weakSelf.subView.mas_centerX);
                make.size.mas_equalTo(CGSizeMake(size.width+10, size.height+10));
            }];
        }
            break;
        case ShowBackgroundTypeToLogin:
        {
            UIView *unLoginView = [[UIView alloc]initWithFrame:self.subView.frame];
            unLoginView.backgroundColor=[UIColor whiteColor];
            [self.subView addSubview:unLoginView];
//            self.subView.backgroundColor=tarbarrossred;
            [unLoginView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(__weakSelf.subView);
                make.centerX.equalTo(__weakSelf.subView);
//                make.size.equalTo(__weakSelf.subView);
                make.width.equalTo(__weakSelf.subView);
                make.height.equalTo(@(kScreenHeight-ZOOM6(80)-ZOOM6(57)-64-50));
            }];
            
            UILabel *textLabel = [[UILabel alloc]init];
            textLabel.text=@"立即登录，看蜜友们都分享了什么吧...";
            textLabel.textColor=kSubTitleColor;
            textLabel.textAlignment=NSTextAlignmentCenter;
            textLabel.font = [UIFont systemFontOfSize:ZOOM6(28)];
            [unLoginView addSubview:textLabel];
            
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.tag = 30013;
            btn.layer.cornerRadius = 4;
            btn.layer.borderColor = tarbarrossred.CGColor;
            btn.layer.borderWidth = 0.5;
            [btn setTitle:@"登录" forState:UIControlStateNormal];
            [btn setTitleColor:tarbarrossred forState:UIControlStateNormal];
            [btn.titleLabel setFont:[UIFont systemFontOfSize:ZOOM6(36)]];
            [btn setBackgroundColor:self.view.backgroundColor];
            [btn addTarget:self action:@selector(toLogin:) forControlEvents:UIControlEventTouchUpInside];
            [unLoginView addSubview:btn];
            
            [textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//                make.centerY.equalTo(unLoginView);
                make.top.equalTo(@(h/2-ZOOM6(100)));
                make.centerX.equalTo(__weakSelf.subView);
                make.width.equalTo(__weakSelf.subView);
                make.height.equalTo(@(38));
            }];
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(textLabel.mas_bottom).offset(Margin);
                make.centerX.equalTo(textLabel);
                make.width.equalTo(@(ZOOM6(210)));
                make.height.equalTo(@(ZOOM6(88)));
            }];
        }
        default:
            break;
    }

}

- (void)showBackgroundTabBar:(BOOL)isTabBar type:(ShowBackgroundType)showType message:(NSString *)message
{
    [self showBackgroundTabBar:isTabBar setY:0 type:showType message:message];
}

- (void)showBackgroundTabBar:(BOOL)isTabBar setY:(CGFloat)y type:(ShowBackgroundType)showType message:(NSString *)message
{
    CGFloat height = kScreenHeight-kNavigationheightForIOS7-y;
    if (isTabBar) {
        height -= kTabBarHeight;
    }
    CGRect frame = CGRectMake(0, kNavigationheightForIOS7+y, kScreenWidth, height);
    [self showBackgroundType:showType message:nil superView:nil setSubFrame:frame];
}

- (void)cleanShowBackground
{
    [self removeSubView];
}
- (void)toLogin:(UIButton *)sender {
    [self loginSuccess:nil];
}
- (void)tryBtnClick:(UIButton *)sender
{
    if (self.reloadDataBlock) {
        self.reloadDataBlock();
    }
    [self removeSubView];
}

- (void)removeSubView
{
    [self.subView removeFromSuperview];
    self.subView = nil;
}

// 判断网络类型
- (NetworkStates)getNetworkStates
{
    NSArray *subviews = [[[[UIApplication sharedApplication] valueForKeyPath:@"statusBar"] valueForKeyPath:@"foregroundView"] subviews];
    // 保存网络状态
    NetworkStates states = NetworkStatesNone;
    for (id child in subviews) {
        if ([child isKindOfClass:NSClassFromString(@"UIStatusBarDataNetworkItemView")]) {
            //获取到状态栏码
            int networkType = [[child valueForKeyPath:@"dataNetworkType"] intValue];
            switch (networkType) {
                case 0:
                    //无网模式
                    states = NetworkStatesNone;
                    break;
                case 1:
                    states = NetworkStates2G;
                    break;
                case 2:
                    states = NetworkStates3G;
                    break;
                case 3:
                    states = NetworkStates4G;
                    break;
                case 5:
                {
                    states = NetworkStatesWIFI;
                }
                    break;
                default:
                    break;
            }
        }
    }
    //根据状态选择
    return states;
}

#pragma mark - 关联属性
- (UIView *)subView
{
    return objc_getAssociatedObject(self, &subViewFlagChar);
}

- (void)setSubView:(UIView *)subView
{
    objc_setAssociatedObject(self, &subViewFlagChar, subView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (ShowBackgroundType)showType
{
     return [objc_getAssociatedObject(self, &showTypeFlagChar) integerValue];
}

- (void)setShowType:(ShowBackgroundType)showType
{
    objc_setAssociatedObject(self, &showTypeFlagChar, [NSNumber numberWithInteger:showType], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setSubFrame:(CGRect)subFrame
{
    objc_setAssociatedObject(self, &subFrameFlagChar, [NSValue valueWithCGRect:subFrame], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (CGRect)subFrame
{
    return [objc_getAssociatedObject(self, &subFrameFlagChar) CGRectValue];
}

- (void)setReloadDataBlock:(dispatch_block_t)reloadDataBlock
{
    objc_setAssociatedObject(self, &reloadDataBlockFlagChar, reloadDataBlock, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (dispatch_block_t)reloadDataBlock
{
    return objc_getAssociatedObject(self, &reloadDataBlockFlagChar);
}

- (void)setNetStatusBlock:(NetStatusBlock)netStatusBlock
{
    objc_setAssociatedObject(self, &netStatusFlagChar, netStatusBlock, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NetStatusBlock)netStatusBlock
{
    return objc_getAssociatedObject(self, &netStatusFlagChar);
}

- (void)netStatusNotificationCenter:(NSNotification *)sender
{
    NetworkStates network = 0;
    if ([sender.object isEqualToString:@"WLAN"]) {
        network = NetworkStatesWIFI;
    } else if ([sender.object isEqualToString:@"WWAN"]) {
        network = NetworkStates4G;
    } else {
        network = NetworkStatesNone;
    }
    
    if (self.netStatusBlock) {
        self.netStatusBlock(network);
    }
}

- (void)reloadDataBlock:(dispatch_block_t)block
{
    self.reloadDataBlock = block;
}
- (void)netStatusBlock:(NetStatusBlock)block
{
    self.netStatusBlock = block;
    NSNotificationCenter * center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(netStatusNotificationCenter:) name:netStatusNotificationCenter object:nil];
}


@end
