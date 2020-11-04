//
//  UpdateView.h
//  YunShangShiJi
//
//  Created by zgl on 16/9/6.
//  Copyright © 2016年 ios-1. All rights reserved.
//  版本更新

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, UpdateViewType) {
    UpdateViewChooseType = 0, //选择更新
    UpdateVieWenforceType = 1 //强制更新
};

@interface UpdateView : UIView

/**
 * 版本更新
 *
 * @param type      类型：UpdateViewChooseType选择更新、UpdateVieWenforceType强制更新
 * @param title     标题
 * @param subtitle  副标题
 * @param text      更新内容
 * @param toView    添加的父视图
 * @param block     关闭弹窗回调
 */
+ (void)showType:(UpdateViewType)type
           title:(NSString *)title
        subtitle:(NSString *)subtitle
            text:(NSString *)text
          toView:(UIView *)view
     removeBlock:(dispatch_block_t)block;

@end
