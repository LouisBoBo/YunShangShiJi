//
//  ShopCarManager.h
//  YunShangShiJi
//
//  Created by zgl on 16/8/5.
//  Copyright © 2016年 ios-1. All rights reserved.
//  购物车本地化

#import <Foundation/Foundation.h>
#import "ShopCarModel.h"
#import "ShopSaleModel.h"

typedef NS_OPTIONS(NSInteger, ShopCarType) {
    ShopCarTypeCar =    1 <<  0,//购物车
    ShopCarTypeSale =   1 <<  1 //特卖
};

@interface ShopCarManager : NSObject

@property (nonatomic, assign, readonly) NSInteger s_count; //特卖商品数量
@property (nonatomic, assign, readonly) NSInteger p_count; //购物商品数量
@property (nonatomic, assign, readonly) NSInteger s_deadline; //特卖商品倒计时(0-30*60秒)
@property (nonatomic, assign, readonly) NSInteger p_deadline; //购物商品倒计时(0-30*60秒)
@property (nonatomic, strong, readonly) NSArray<ShopSaleModel *> *sData; //特卖未失效商品
@property (nonatomic, strong, readonly) NSArray<ShopSaleModel *> *seData;//特卖失效商品
@property (nonatomic, strong, readonly) NSArray<ShopCarModel *> *pData; //购物未失效商品
@property (nonatomic, strong, readonly) NSArray<ShopCarModel *> *peData;//购物失效商品

+ (instancetype)sharedManager;
+ (instancetype)new __attribute__((unavailable("new 不可用,请调用sharedManager")));
- (instancetype)init __attribute__((unavailable("init 不可用,请调用sharedManager")));

/// 同步网络数据
+ (void)loadDataNetwork;

/// 插入数据
+ (BOOL)insertToDB:(NSObject *)model;
/// 批量插入
+ (void)insertToDBWidthArray:(NSArray *)array;
/// 更新数据
+ (BOOL)updateToDB:(NSObject *)model;
/// 批量更新
+ (void)updateToDBWidthArray:(NSArray *)array;
/// 删除数据
+ (BOOL)deleteToDB:(NSObject *)model;
/// 批量删除
+ (void)deleteToDBWidthArray:(NSArray *)array;
/// 失效商品重新加入
+ (BOOL)againdateToDBWidthType:(ShopCarType)type ID:(NSString *)ID;
/// 失效商品批量重新加入
+ (void)againdateToDBWidthType:(ShopCarType)type Array:(NSArray *)array;

/**
 @brief 更新商品数量
 @param type         购物车类型
 @param ID           购物车ID
 @param shopNum      数量
 @return YES／NO
 */
+ (BOOL)updateToDBWidthType:(ShopCarType)type ID:(NSString *)ID shopNum:(NSInteger)shopNum;

/**
 @brief 通过购物车ID删除数据(失效商品删除)
 @param type         购物车类型
 @param ID           购物车ID
 @return YES／NO
 */
+ (BOOL)deleteToDBWidthType:(ShopCarType)type ID:(NSString *)ID;

/**
 @brief 通过购物车ID移除数据(有效商品删除)
 @param type         购物车类型
 @param ID           购物车ID
 @return YES／NO
 */
+ (BOOL)removeToDBWidthType:(ShopCarType)type ID:(NSString *)ID;

/**
 @brief 删除所有数据
 @param type         购物车类型(ShopCarTypeCar:购物车,ShopCarTypeSale:特卖,ShopCarTypeCar|ShopCarTypeSale:购物车和特卖）
 */
+ (void)deleteAllWidthType:(ShopCarType)type;

/**
 @brief 通过商品编号与库存ID判断商品是否已加入购物车
 @param type         购物车类型
 @param shopCode     商品编号
 @param stid         库存ID
 @return  nil不存在，存在则返回对应model
 */
+ (id)isExistsWithType:(ShopCarType)type shopCode:(NSString *)shopCode andStid:(NSString *)stid;

@end
