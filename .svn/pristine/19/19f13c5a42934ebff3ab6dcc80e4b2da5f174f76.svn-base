//
//  AddShopCarModel.m
//  YunShangShiJi
//
//  Created by zgl on 16/6/25.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import "AddShopCarModel.h"

@implementation AddShopCarModel

+ (void)getAddShopCarModelWithPairedCode:(NSString *)pairedCode cartJson:(NSArray *)cartJson success:(void (^)(id))success {
//    if (cartJson.count == 1) {
//        [self getAddShopCarModelWithPairedParameters:cartJson[0] success:success];
//    } else {
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:cartJson options:0 error:nil];
        NSString *jsonStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        NSString *token=[[NSUserDefaults standardUserDefaults] objectForKey:USER_TOKEN];
        NSString *url = [NSString stringWithFormat:@"shopCart/add?version=%@&token=%@&paired_code=%@&cartJson=%@",VERSION,token,pairedCode,jsonStr];
        [self getDataResponsePath:url success:success];
//    }
}

+ (void)getAddShopCarModelWithPairedParameters:(NSDictionary *)parameters success:(void (^)(id))success {
    NSString *token=[[NSUserDefaults standardUserDefaults] objectForKey:USER_TOKEN];
    NSString *user_id = [parameters objectForKey:@"user_id"];
    NSString *size = [parameters objectForKey:@"size"];
    NSString *color = [parameters objectForKey:@"color"];
    NSString *stock_type_id = [parameters objectForKey:@"stock_type_id"];
    NSString *shop_num = [parameters objectForKey:@"shop_num"];
    NSString *shop_name = [parameters objectForKey:@"shop_name"];
    NSString *shop_price = [parameters objectForKey:@"shop_price"];
    NSString *shop_se_price = [parameters objectForKey:@"shop_se_price"];
    NSString *def_pic = [parameters objectForKey:@"def_pic"];
    NSString *shop_code = [parameters objectForKey:@"shop_code"];
    NSString *supp_id = [parameters objectForKey:@"supp_id"];
    NSString *kickback = [parameters objectForKey:@"kickback"];
    NSString *original_price = [parameters objectForKey:@"original_price"];
    NSString *store_code = [parameters objectForKey:@"store_code"];
    NSString *url = [NSString stringWithFormat:@"shopCart/add?version=%@&token=%@&user_id=%@&size=%@&color=%@&stock_type_id=%@&shop_num=%@&shop_name=%@&shop_price=%@&shop_se_price=%@&def_pic=%@&shop_code=%@&store_code=%@&supp_id=%@&kickback=%@&original_price=%@",VERSION,token,user_id,size,color,stock_type_id,shop_num,shop_name,shop_price,shop_se_price,def_pic,shop_code,store_code,supp_id,kickback,original_price];
    [self getDataResponsePath:url success:success];
}

@end
