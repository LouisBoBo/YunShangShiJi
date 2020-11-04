//
//  RedXuanfuHongBao.h
//  YunShangShiJi
//
//  Created by hebo on 2019/1/22.
//  Copyright © 2019年 ios-1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Animation.h"
NS_ASSUME_NONNULL_BEGIN

@interface RedXuanfuHongBao : UIView<CAAnimationDelegate>
@property (nonatomic , strong) UIButton *xuanfuHongbaoview;

@property (nonatomic , strong) dispatch_block_t ClickMindBlock;
@property (nonatomic , assign) BOOL isNewUser; //是否是没有交易记录的新用户
@property (nonatomic , assign) NSInteger is_vip;//是否是会员
@property (nonatomic , assign) BOOL isShouYeThree;//是否是首页3
@property (nonatomic , strong) void (^lingHongBaoBlock)(BOOL isNewUser);
- (instancetype)initWithFrame:(CGRect)frame isShouYeThree:(BOOL)isShouYeThree ;
- (void)refreshXuanfuImage;
@end

NS_ASSUME_NONNULL_END
