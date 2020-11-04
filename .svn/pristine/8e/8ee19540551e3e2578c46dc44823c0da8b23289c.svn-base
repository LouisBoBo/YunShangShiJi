//
//  CartViewModel.h
//  YunShangShiJi
//
//  Created by yssj on 16/6/25.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import "BaseModel.h"

@interface CartViewModel : BaseModel

@property (nonatomic, assign) NSInteger status;      //结果
@property (nonatomic, copy) NSString *message;       //结果信息
@property (nonatomic, copy) NSArray *list;

+ (void)RejoinShopWithPaired_code:(NSString *)code Success:(void (^)(id data))success;//搭配

+ (void)RejoinShopWithID:(NSString *)code Success:(void (^)(id data))success;//普通商品

+ (void)RejoinShopWithP_code:(NSString *)code Success:(void (^)(id data))success;//套餐

+ (void)RejoinShopWithShopCode:(NSString *)code Success:(void (^)(id))success;//普通商品重新

+ (void)CheckShopListWithShopCodes:(NSString *)code Success:(void (^)(id))success;//检测商品是否下架

+ (void)CheckShopListWithP_Codes:(NSString *)code Success:(void (^)(id))success;    //检测 特卖 商品是否下架

@end
