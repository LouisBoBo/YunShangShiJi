//
//  QueryCartModel.m
//  YunShangShiJi
//
//  Created by zgl on 16/8/10.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import "QueryCartModel.h"
#import "ShopCarModel.h"
#import "ShopSaleModel.h"

@implementation QueryCartModel

+ (NSMutableDictionary *)getMapping {
    NSMutableDictionary *mapping =  [NSMutableDictionary dictionaryWithObjectsAndKeys:[ShopCarModel mappingWithKey:@"shop_list"],@"shop_list",[ShopSaleModel mappingWithKey:@"p_shop_list"],@"p_shop_list",nil];
    return mapping;
}

+ (void)getQueryCartWithSuccess:(void (^)(id))success {
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:USER_TOKEN];
    NSString *urlStr = [NSString stringWithFormat:@"shopCart/queryCart?version=%@&token=%@",VERSION,token];
    [self getDataResponsePath:urlStr success:success];
}

@end
