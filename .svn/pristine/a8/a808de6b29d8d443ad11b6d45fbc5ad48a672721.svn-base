//
//  YFShareModel.h
//  YunShangShiJi
//
//  Created by zgl on 16/7/13.
//  Copyright © 2016年 ios-1. All rights reserved.
//  分享统计

#import "BaseModel.h"

@interface YFShareModel : BaseModel

@property (nonatomic, assign) NSInteger status;  //结果
@property (nonatomic, copy) NSString *message;   //结果信息

/**
 * 分享统计
 *
 * @param key       小店：店铺realm，商品：商品编号shop_code
 * @param type      分享类型
 * @param tabType   来源类型
 * @param success   成功回调
 */
+ (void)getShareModelWithKey:(NSString *)key
                        type:(StatisticalType)type
                     tabType:(StatisticalTabType)tabType
                     success:(void (^)(YFShareModel *data))success;

/**
 * 手机号获取验证码
 *
 * @param phone     手机号
 * @param codetype  类型(@"7",绑定新手机)
 * @param success   成功回调
 */
+ (void)getPhoneCodeWithPhone:(NSString *)phone
                     codetype:(NSString *)codetype
                        vcode:(NSString *)vcode
                      success:(void (^)(YFShareModel *data))success;
/**
 4622 【ios】第三方登录时绑定手机
        新用户登录时需绑定手机界面的获取验证码
 
 @param phone    <#phone description#>
 @param codetype <#codetype description#>
 @param success  <#success description#>
 */
+ (void)WXGetPhoneCodeWithPhone:(NSString *)phone codetype:(NSString *)codetype success:(void (^)(YFShareModel *))success;

/**
 * 绑定手机
 *
 * @param code      验证码
 * @param success   成功回调
 */
+ (void)getCheckCodeWithCode:(NSString *)code
                      success:(void (^)(YFShareModel *data))success;

/**
 * 绑定手机
 *
 * @param code      验证码
 * @param age       年龄
 * @param success   成功回调
 */
+ (void)getUserCheckCodeWithCode:(NSString *)code Age:(NSString *)age success:(void (^)(YFShareModel *))success;

/**
 * 购物车删除
 *
 * @param ID        购物车ID
 * @param type      类型(0：普通，1：特卖)
 * @param success   成功回调
 */
+ (void)getShopCartDelWidthID:(long)ID
                         type:(NSInteger)type
                      success:(void (^)(YFShareModel *data))success;

@end
