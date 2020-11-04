//
//  UIViewController+chatList.h
//  YunShangShiJi
//
//  Created by zgl on 16/5/11.
//  Copyright © 2016年 ios-1. All rights reserved.
//  ViewController扩展（常用功能扩展）

#import <UIKit/UIKit.h>

@class ShopDetailModel;

@interface UIViewController (chatList)

/// 跳转消息列表
- (void)presentChatList;

/**
 @brief 打开会话
 @param suppid        会话id
 @param title         聊天标题
 @param model         当前商品数据
 @param detailType    是会员列表
 @param imageurl      图片链接
 */
- (void)messageWithSuppid:(NSString *)suppid
                    title:(NSString *)title
                    model:(ShopDetailModel *)model
               detailType:(NSString *)detailType
                 imageurl:(NSString *)imageurl;

/// 登录容云
+ (void)loginRongCloub;

/// 判断登录
- (void)loginVerifySuccess:(void (^)())success;
/// 登录
- (void)loginSuccess:(void (^)())success;

/**
 登录

 @param pro     条件 参数
 @param success success description
 */
- (void)loginWithPro:(NSString *)pro Success:(void (^)())success;

/// 导航栏返回按钮
- (UIBarButtonItem *)barBackButton;
/// 设置导航栏及标题
- (UIView *)setNavigationBackWithTitle:(NSString *)title;
/// 设置导航栏及标题、右侧按钮文字
- (void)setNavigationWithTitle:(NSString *)title rightBtnTitle:(NSString *)btnTitle;
/// 返回上级页面
- (void)leftBarButtonItemPressed;
/// 导航栏右侧按钮点击（子类重写）
- (void)rightButtonClick;

/// 当加载失败时显示默认标题和图片
- (void)loadingDataFail;
/// 当无数据时显示默认标题和图片
- (void)loadingDataBlank;
/// 加载成功
- (void)loadingDataSuccess;
/// 加载数据背景图片及文字
- (void)loadingDataBackgroundView:(UIView *)view img:(UIImage *)img text:(NSString *)text;

/// 重新加载按钮回调
- (void)loadFailBtnBlock:(dispatch_block_t)block;

/**
 *  改变购物车tabbar上的数量
 */
-(void)changeTabbarCartNum;


- (void)loadSmileView:(UIView *)view;
- (void)loadNormalView:(UIView *)view;

//重新加载密友圈数据
- (void)reloadSecretFriendViewController;

@end
