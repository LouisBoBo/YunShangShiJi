//
//  SpecialDetailModel.m
//  YunShangShiJi
//
//  Created by ios-1 on 2016/12/5.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import "SpecialDetailModel.h"

@implementation SpecialDetailModel

+ (NSMutableDictionary *)getMapping {
    NSMutableDictionary *mapping =  [NSMutableDictionary dictionaryWithObjectsAndKeys:[SpecialMainModel mappingWithKey:@"shop"],@"shop",nil];
    return mapping;
}

+(void)getSpecialDetailData:(NSString*)collocationCode Success:(void(^)(id data))success
{
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:USER_TOKEN];
    NSString *urlStr = [NSString stringWithFormat:@"collocationShop/query2?version=%@&token=%@&code=%@",VERSION,token,collocationCode];
    [self getDataResponsePath:urlStr success:success];

}
@end
