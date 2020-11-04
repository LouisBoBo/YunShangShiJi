//
//  ShoppingViewModel.h
//  YunShangShiJi
//
//  Created by jingaiweiyi on 16/7/6.
//  Copyright © 2016年 ios-1. All rights reserved.
//  购物VM

#import "PublicViewModel.h"


/**
 *  购物数据模型
 */

@interface TFShoppingVM : PublicViewModel

@property (strong, nonatomic) NSNumber *typeID;
@property (copy, nonatomic) NSString *typeName;

// 处理网络获取的数据
- (void)handleDataWithFromType:(NSString *)fromType pageNum:(NSInteger)pageNum Success:(void (^)(NSArray *modelArray, Response *response))success failure:(void(^)(NSError *error))failure;

//加了排序条件
- (void)handleDataWithFromType:(NSString *)fromType pageNum:(NSInteger)pageNum Sort:(NSString*)sort Success:(void (^)(NSArray *modelArray, Response *response))success failure:(void(^)(NSError *error))failure;

- (void)netWorkGetBrowsePageListWithReduceMoneySuccess:(void (^)(NSDictionary *data, Response *response))success failure:(void(^)(NSError *error))failure;
@end

