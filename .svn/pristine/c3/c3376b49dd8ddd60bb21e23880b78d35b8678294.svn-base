//
//  ShopLinkModel.h
//  YunShangShiJi
//
//  Created by zgl on 16/5/11.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import "BaseModel.h"

@interface ShopLinkModel : BaseModel

/// 请求成功与否 1:成功 其他：失败
@property (nonatomic, assign) NSInteger status;
/// 商品链接
@property (nonatomic, copy) NSString *link;

/**
 @brief  接口请求后直接解析回调
 @param path            相对路径 
 @param success         请求成功之后的回调
 @return 操作对象
 */
+ (void)getShopLinkModelWithPath:(NSString *)path success:(void (^)(id data))success;

@end
