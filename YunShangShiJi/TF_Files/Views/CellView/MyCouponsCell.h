//
//  MyCouponsCell.h
//  YunShangShiJi
//
//  Created by zgl on 16/5/20.
//  Copyright © 2016年 ios-1. All rights reserved.
//  我的卡券Cell类簇

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, MyCouponsCellType) {
    MyCouponsCellTypeVoucher = 0,      // 抵用券
    MyCouponsCellTypeCoupon = 1,       // 优惠券
    MyCouponsCellTypeCouponFail = 2    // 优惠券失效
};

@interface MyCouponsCell : UITableViewCell

/**
 @brief cell获取方法
 @param style       样式：0抵用券 1优惠券 2优惠券失效
 @param tableView   cell对应的TableView
 @return            返回对应cell对象
 */
+ (instancetype)cellWithType:(MyCouponsCellType)type tableView:(UITableView *)tableView;

/// 更新数据(抵用券传入VoucherModel，优惠券传入MyCardModel)
- (void)receiveDataModel:(id)model;

@end
