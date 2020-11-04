//
//  AuthorView.h
//  YunShangShiJi
//
//  Created by zgl on 16/6/1.
//  Copyright © 2016年 ios-1. All rights reserved.
//  晒单详情用户信息

#import <UIKit/UIKit.h>

#define AuthorViewHeight 40

@interface AuthorView : UIView

@property (nonatomic, strong) UIImageView *iconImgView; // 头像
@property (nonatomic, strong) UILabel *nickLabel; // 昵称
@property (nonatomic, strong) UILabel *timeLabel; // 发布时间
@property (nonatomic, assign) BOOL isMember; // 是否是会员
@property(nonatomic, strong) UIButton *topLikeBtn;

- (void)setLikeBtnBlock:(void (^)(UIButton *))block;

@end
