//
//  TFBrowseShopVM.h
//  YunShangShiJi
//
//  Created by jingaiweiyi on 16/7/6.
//  Copyright © 2016年 ios-1. All rights reserved.
//  强制浏览数据VM

#import "PublicViewModel.h"

@interface TFBrowseShopVM : PublicViewModel

@property (nonatomic, strong) TFCollectionViewService *service;
@property (nonatomic, strong) TFTableViewService *tableViewService;

// 处理网络获取的数据
- (void)handleDataWithFromPageNum:(NSInteger)pageNum Success:(void (^)(NSArray *modelArray, Response *response))success failure:(void(^)(NSError *error))failure;

- (void)handleDataWithFromPageNum:(NSInteger)pageNum Sort:(NSString*)sort Success:(void (^)(NSArray *modelArray, Response *response))success failure:(void(^)(NSError *error))failure;

// 强制浏览搭配购
- (void)handleCollocationDataWithFromPageNum:(NSInteger)pageNum curPager:(NSInteger)curPager success:(void (^)(id data))success;

//// 强制浏览搭配购排序
//- (void)handleCollocationDataWithFromPageNum:(NSInteger)pageNum curPager:(NSInteger)curPager Sort:(NSString*)sort success:(void (^)(id data))success;

// 活动商品
- (void)handleActivityShopDataWithFromPageNum:(NSInteger)pageNum curPager:(NSInteger)curPager success:(void (^)(NSArray *modelArray, Response *response))success failure:(void(^)(NSError *error))failure;;

// 活动商品排序
- (void)handleActivityShopDataWithFromPageNum:(NSInteger)pageNum curPager:(NSInteger)curPager Sort:(NSString*)sort success:(void (^)(NSArray *modelArray, Response *response))success failure:(void(^)(NSError *error))failure;

@end
