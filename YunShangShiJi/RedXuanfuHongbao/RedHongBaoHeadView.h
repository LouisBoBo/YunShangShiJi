//
//  RedHongBaoHeadView.h
//  YunShangShiJi
//
//  Created by hebo on 2019/1/23.
//  Copyright © 2019年 ios-1. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RedHongBaoHeadView : UIView
@property (nonatomic , strong) UIImageView *HongbaoHeadview;
@property (nonatomic , strong) UILabel *redMoneyLab;
@property (nonatomic , strong) UILabel *redTimeLab;
@property (nonatomic , strong) UILabel *redCouponLab;
@property (nonatomic , strong) UILabel *redTixianLab;
@property (nonatomic , strong) NSTimer *mytimer;
@property (nonatomic , assign) NSTimeInterval cutdowntime;
@property (nonatomic , assign) CGFloat coupon;
@property (nonatomic , assign) CGFloat cond;
@property (nonatomic , strong) void (^lingHongBaoBlock)(CGFloat coupon);
- (instancetype)initWithFrame:(CGRect)frame;

@end

NS_ASSUME_NONNULL_END
