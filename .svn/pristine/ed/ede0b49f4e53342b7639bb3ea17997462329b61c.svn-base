//
//  ShopDetailViewModel.h
//  YunShangShiJi
//
//  Created by hebo on 2019/6/3.
//  Copyright © 2019年 ios-1. All rights reserved.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ShopDetailViewModel : BaseModel
@property (nonatomic , assign) NSInteger status;
@property (nonatomic , copy)   NSString *message;
@property (nonatomic , copy)   NSString *maxType;

- (CGFloat)get_discount_price:(CGFloat)beforePrice DiscountMoney:(CGFloat)money MaxViptype:(NSString*)viptype Shop_deduction:(CGFloat)shop_deduction;

+ (void)addUserVipOrderSuccess:(void(^)(id))success;


@end

NS_ASSUME_NONNULL_END
