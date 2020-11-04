//
//  TFShopCartVM.m
//  YunShangShiJi
//
//  Created by jingaiweiyi on 16/7/11.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import "TFShopCartVM.h"

@implementation TFShopCartVM

+ (void)handleDataWithShopCartCountSuccess:(void (^)(TFShopCartM *model,Response *response))success failure:(void(^)(NSError *error))failure
{
    [[APIClient sharedManager] netWorkGeneralRequestWithApi:kApi_shopCart_shopCartCount caches:YES cachesTimeInterval:0*TFSecond token:YES success:^(id data, Response *response) {
        TFShopCartM *model = [TFShopCartM yy_modelWithJSON:data];
        
        success(model, response);
    } failure:^(NSError *error) {
        failure(error);
    }];
}


@end

@implementation TFShopCartM



@end
