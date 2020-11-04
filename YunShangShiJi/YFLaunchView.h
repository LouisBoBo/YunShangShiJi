//
//  YFLaunchView.h
//  YunShangShiJi
//
//  Created by zgl on 16/7/4.
//  Copyright © 2016年 ios-1. All rights reserved.
//  启动图片

#import <UIKit/UIKit.h>

@interface YFLaunchView : UIView

/// 显示启动图
+ (void)show;
/// 更新启动图
+ (void)update;

/// 点击
- (void)settouchesEndedBlock:(dispatch_block_t)block;

@end
