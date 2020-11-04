//
//  UIViewController+TFCommon.h
//  YunShangShiJi
//
//  Created by jingaiweiyi on 16/7/12.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, ShowBackgroundType) {
    ShowBackgroundTypeListEmpty = 100,
    ShowBackgroundTypeNetError,
    ShowBackgroundTypeToLogin,
};

typedef NS_ENUM(NSUInteger, NetworkStates) {
    NetworkStatesNone = 100, // 没有网络
    NetworkStates2G, // 2G
    NetworkStates3G, // 3G
    NetworkStates4G, // 4G
    NetworkStatesWIFI // WIFI
};

extern NSString *const netStatusNotificationCenter;
typedef void(^NetStatusBlock)(NetworkStates networkState);

@interface UIViewController (TFCommon)

@property (copy, nonatomic) dispatch_block_t reloadDataBlock;
@property (copy, nonatomic) NetStatusBlock netStatusBlock;


- (void)showBackgroundType:(ShowBackgroundType)showType message:(NSString *)message superView:(UIView *)superView setSubFrame:(CGRect)subFrame;
- (void)cleanShowBackground;
- (void)showBackgroundTabBar:(BOOL)isTabBar type:(ShowBackgroundType)showType message:(NSString *)message;
- (void)showBackgroundTabBar:(BOOL)isTabBar setY:(CGFloat)y type:(ShowBackgroundType)showType message:(NSString *)message;

- (void)reloadDataBlock:(dispatch_block_t)block;
- (void)netStatusBlock:(NetStatusBlock)block;
@end
