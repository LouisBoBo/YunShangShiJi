//
//  TFBrowseShopVM.m
//  YunShangShiJi
//
//  Created by jingaiweiyi on 16/7/6.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import "TFBrowseShopVM.h"
#import "TFShoppingM.h"
#import "CollocationMainModel.h"
@implementation TFBrowseShopVM

- (void)handleDataWithFromPageNum:(NSInteger)pageNum Success:(void (^)(NSArray *modelArray, Response *response))success failure:(void(^)(NSError *error))failure
{
    [[APIClient sharedManager] netWorkGetBrowsePageListWithPageSize:10 pageNum:pageNum success:^(id data, Response *response) {
        NSMutableArray *tmpArr = [NSMutableArray array];
        for (NSDictionary *subDic in (NSArray *)[data valueForKey:@"list"]) {
            TFShoppingM *model=[TFShoppingM yy_modelWithJSON:subDic];
            [tmpArr addObject:model];
        }
        success(tmpArr, response);
    } failure:^(NSError *error) {
        failure(error);
    }];
}
- (void)handleDataWithFromPageNum:(NSInteger)pageNum Sort:(NSString*)sort Success:(void (^)(NSArray *modelArray, Response *response))success failure:(void(^)(NSError *error))failure;
{
    [[APIClient sharedManager] netWorkGetBrowsePageListWithPageSize:10 Sort:sort pageNum:pageNum success:^(id data, Response *response) {
        
        NSMutableArray *tmpArr = [NSMutableArray array];
        for (NSDictionary *subDic in (NSArray *)[data valueForKey:@"list"]) {
            TFShoppingM *model=[TFShoppingM yy_modelWithJSON:subDic];
            [tmpArr addObject:model];
        }
        success(tmpArr, response);

    } failure:^(NSError *error) {
        failure(error);
    }];
}
- (void)handleCollocationDataWithFromPageNum:(NSInteger)pageNum curPager:(NSInteger)curPager success:(void (^)(id data))success
{
    [CollocationMainModel getLedBrowseCollocationMainModelWithPageSize:pageNum curPager:curPager success:^(id data) {
       
        if (success) {
            success(data);
        }
    }];
}

- (void)handleActivityShopDataWithFromPageNum:(NSInteger)pageNum curPager:(NSInteger)curPager success:(void (^)(NSArray *modelArray, Response *response))success failure:(void(^)(NSError *error))failure
{
    NSDictionary *parameter = @{@"curPage": [NSNumber numberWithInteger:curPager],
                                @"pageSize": [NSNumber numberWithInteger:pageNum]};
    [[APIClient sharedManager] netWorkGeneralRequestWithApi:kApi_shop_queryShopActivity parameter:parameter caches:NO cachesTimeInterval:0*TFMinute token:YES success:^(id data, Response *response) {
        MyLog(@"data: %@", data);
        
        NSMutableArray *tmpArr = [NSMutableArray array];
        for (NSDictionary *subDic in (NSArray *)[data valueForKey:@"list"]) {
            TFShoppingM *model=[TFShoppingM yy_modelWithJSON:subDic];
            [tmpArr addObject:model];
        }
        success(tmpArr, response);

    } failure:^(NSError *error) {
        failure(error);
    }];
}

- (void)handleActivityShopDataWithFromPageNum:(NSInteger)pageNum curPager:(NSInteger)curPager Sort:(NSString*)sort success:(void (^)(NSArray *modelArray, Response *response))success failure:(void(^)(NSError *error))failure;
{
    NSDictionary *parameter = @{@"curPage": [NSNumber numberWithInteger:curPager],
                                @"pageSize": [NSNumber numberWithInteger:pageNum],
                                @"sort": sort};
    [[APIClient sharedManager] netWorkGeneralRequestWithApi:kApi_shop_queryShopActivity parameter:parameter caches:NO cachesTimeInterval:0*TFMinute token:YES success:^(id data, Response *response) {
        MyLog(@"data: %@", data);
        
        NSMutableArray *tmpArr = [NSMutableArray array];
        for (NSDictionary *subDic in (NSArray *)[data valueForKey:@"list"]) {
            TFShoppingM *model=[TFShoppingM yy_modelWithJSON:subDic];
            [tmpArr addObject:model];
        }
        success(tmpArr, response);
        
    } failure:^(NSError *error) {
        failure(error);
    }];

}
- (TFCollectionViewService *)service
{
    if (!_service) {
        _service = [[TFCollectionViewService alloc] init];

    }
    return _service;
}

- (TFTableViewService *)tableViewService
{
    if (!_tableViewService) {
        _tableViewService = [[TFTableViewService alloc] init];
    }
    return _tableViewService;
}

@end
