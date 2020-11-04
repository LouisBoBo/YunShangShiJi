//
//  TFShopCartVM.h
//  YunShangShiJi
//
//  Created by jingaiweiyi on 16/7/11.
//  Copyright © 2016年 ios-1. All rights reserved.
//  购物车商品数量VM

#import "PublicViewModel.h"
#import "PublicModel.h"
@class TFShopCartM;
@interface TFShopCartVM : PublicViewModel

+ (void)handleDataWithShopCartCountSuccess:(void (^)(TFShopCartM *model,Response *response))success failure:(void(^)(NSError *error))failure;


@end


@interface TFShopCartM : PublicModel

@property (nonatomic, strong) NSNumber *cart_count;
@property (nonatomic, strong) NSNumber *p_deadline;
@property (nonatomic, strong) NSNumber *s_time;
@property (nonatomic, strong) NSNumber *s_deadline;

@end