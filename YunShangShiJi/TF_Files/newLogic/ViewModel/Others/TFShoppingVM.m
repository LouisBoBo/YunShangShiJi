//
//  ShoppingViewModel.m
//  YunShangShiJi
//
//  Created by jingaiweiyi on 16/7/6.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import "TFShoppingVM.h"
#import "TFShoppingM.h"
@implementation TFShoppingVM

- (void)handleDataWithFromType:(NSString *)fromType pageNum:(NSInteger)pageNum Success:(void (^)(NSArray *modelArray, Response *response))success failure:(void(^)(NSError *error))failure
{
    [[APIClient sharedManager] netWorkGetHomePageListWithFromType:fromType pageSize:30 pageNum:pageNum typeID:self.typeID typeName:self.typeName success:^(id data, Response *response) {
        
        NSMutableArray *tmpArr = [NSMutableArray array];
        if([[data valueForKey:@"listShop"] count])
        {
            for (NSDictionary *subDic in (NSArray *)[data valueForKey:@"listShop"]) {
                TFShoppingM *model=[TFShoppingM yy_modelWithJSON:subDic];
                model.isVip = (NSNumber*)[NSString stringWithFormat:@"%@",data[@"isVip"]];
                model.maxType = [NSString stringWithFormat:@"%@",data[@"maxType"]];
                [tmpArr addObject:model];
            }

        }else if ([[data valueForKey:@"likes"] count]){
            for (NSDictionary *subDic in (NSArray *)[data valueForKey:@"likes"]) {
                TFShoppingM *model=[TFShoppingM yy_modelWithJSON:subDic];
                model.isVip = (NSNumber*)[NSString stringWithFormat:@"%@",data[@"isVip"]];
                model.maxType = [NSString stringWithFormat:@"%@",data[@"maxType"]];
                [tmpArr addObject:model];
            }
        }else if ([[data valueForKey:@"pList"] count])
        {
            for (NSDictionary *subDic in (NSArray *)[data valueForKey:@"pList"]) {
                TFShoppingM *model=[TFShoppingM yy_modelWithJSON:subDic];
                model.isVip = (NSNumber*)[NSString stringWithFormat:@"%@",@"1"];
                model.maxType = [NSString stringWithFormat:@"%@",data[@"maxType"]];
                for(NSDictionary *shopDic in subDic[@"shop_list"])
                {
                    model.shop_code = [NSString stringWithFormat:@"%@",shopDic[@"shop_code"]];
                    model.shop_name = [NSString stringWithFormat:@"%@",shopDic[@"shop_name"]];
                    model.shop_price = (NSNumber*)[NSString stringWithFormat:@"%@",shopDic[@"shop_price"]];
                    model.shop_se_price = (NSNumber*)[NSString stringWithFormat:@"%@",shopDic[@"shop_se_price"]];
                    [tmpArr addObject:model];
                }
            }
        }
        success(tmpArr, response);
    } failure:^(NSError *error) {
        failure(error);
    }];
    
    
}

- (void)handleDataWithFromType:(NSString *)fromType pageNum:(NSInteger)pageNum Sort:(NSString*)sort Success:(void (^)(NSArray *modelArray, Response *response))success failure:(void(^)(NSError *error))failure;
{
    [[APIClient sharedManager] netWorkGetHomePageListWithFromType:fromType pageSize:30 pageNum:pageNum typeID:self.typeID typeName:self.typeName Sort:sort success:^(id data, Response *response) {
        NSMutableArray *tmpArr = [NSMutableArray array];
        if([[data valueForKey:@"listShop"] count])
        {
            for (NSDictionary *subDic in (NSArray *)[data valueForKey:@"listShop"]) {
                TFShoppingM *model=[TFShoppingM yy_modelWithJSON:subDic];
                [tmpArr addObject:model];
            }
            
        }else if ([[data valueForKey:@"likes"] count]){
            for (NSDictionary *subDic in (NSArray *)[data valueForKey:@"likes"]) {
                TFShoppingM *model=[TFShoppingM yy_modelWithJSON:subDic];
                [tmpArr addObject:model];
            }
            
        }
        success(tmpArr, response);

    } failure:^(NSError *error) {
        
        failure(error);
    }];
}

- (void)netWorkGetBrowsePageListWithReduceMoneySuccess:(void (^)(NSDictionary *data, Response *response))success failure:(void(^)(NSError *error))failure;
{
    [[APIClient sharedManager] netWorkGetBrowsePageListWithReduceMoneysuccess:^(id data, Response *response) {
        if(data)
        {
            NSDictionary *dic = data;
            success(dic,response);
        }
    } failure:^(NSError *error) {
        
    }];
}

@end
