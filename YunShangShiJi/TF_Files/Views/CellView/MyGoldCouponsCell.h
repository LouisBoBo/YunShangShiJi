//
//  MyGoldCouponsCell.h
//  YunShangShiJi
//
//  Created by yssj on 2016/10/9.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyCardModel.h"


typedef NS_ENUM(NSInteger, MyGoldCouponsCellType) {
    MyGoldCouponsCellTypeVoucher = 0,      // 抵用券
    MyGoldCouponsCellTypeCoupon = 1,       // 优惠券
    MyGoldCouponsCellTypeCouponFail = 2,    // 优惠券失效
    MyGoldCouponsCellTypeGold = 3,       // 金券
    MyGoldCouponsCellTypeGoldFail = 4    // 金券失效
};


@interface MyGoldCouponsCell : UITableViewCell

/**
 @brief cell获取方法
 @param style       样式：0抵用券 1优惠券 2优惠券失效
 @param tableView   cell对应的TableView
 @return            返回对应cell对象
 */
+ (instancetype)cellWithType:(MyGoldCouponsCellType)type tableView:(UITableView *)tableView;

/// 更新数据(抵用券传入VoucherModel，优惠券传入MyCardModel)
- (void)receiveDataModel:(id)model;

@property (nonatomic,copy) void(^UseBtnBlock)();
@property (nonatomic,copy) void(^GoldTimeoutBlock)();

@property (nonatomic, strong) UIButton *userButton;  //使用按钮

@end
