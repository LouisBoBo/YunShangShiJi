//
//  YFShareModel.m
//  YunShangShiJi
//
//  Created by zgl on 16/7/13.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import "YFShareModel.h"

@implementation YFShareModel

+ (void)getShareModelWithKey:(NSString *)key type:(StatisticalType)type tabType:(StatisticalTabType)tabType success:(void (^)(YFShareModel *))success {
    NSString *token=[[NSUserDefaults standardUserDefaults] objectForKey:USER_TOKEN]?:@"";
    NSString *path = nil;
    if (key == nil) {
        path = [NSString stringWithFormat:@"record/add?version=%@&token=%@&type=%ld&tab_type=%ld",VERSION, token, (long)type, (long)tabType];
    } else {
        path = [NSString stringWithFormat:@"record/add?version=%@&key=%@&token=%@&type=%ld&tab_type=%ld",VERSION, key, token, (long)type, (long)tabType];
    }
    [self getDataResponsePath:path success:success];
}

+ (void)getPhoneCodeWithPhone:(NSString *)phone codetype:(NSString *)codetype  vcode:(NSString *)vcode success:(void (^)(YFShareModel *))success
{
    NSString *token=[[NSUserDefaults standardUserDefaults] objectForKey:USER_TOKEN]?:@"";
    NSString *path = [NSString stringWithFormat:@"user/get_phone_code?version=%@&phone=%@&codetype=%@&token=%@&vcode=%@",VERSION, phone,codetype,token,vcode];
    [self getDataResponsePath:path success:success];
}

+ (void)WXGetPhoneCodeWithPhone:(NSString *)phone codetype:(NSString *)codetype success:(void (^)(YFShareModel *))success {
    NSString *token=[[NSUserDefaults standardUserDefaults] objectForKey:USER_TOKEN]?:@"";
    NSString *path = [NSString stringWithFormat:@"user/get_phone_code?version=%@&phone=%@&codetype=%@&token=%@&merge=1",VERSION, phone,codetype,token];
    [self getDataResponsePath:path success:success];
}

+ (void)getCheckCodeWithCode:(NSString *)code success:(void (^)(YFShareModel *))success {
    NSString *token=[[NSUserDefaults standardUserDefaults] objectForKey:USER_TOKEN]?:@"";
    NSString *path = [NSString stringWithFormat:@"user/checkCode?version=%@&token=%@&code=%@",VERSION, token,code];
    [self getDataResponsePath:path success:success];
}

+ (void)getUserCheckCodeWithCode:(NSString *)code Age:(NSString *)age success:(void (^)(YFShareModel *))success{    NSString *token=[[NSUserDefaults standardUserDefaults] objectForKey:USER_TOKEN]?:@"";
    NSString *path = [NSString stringWithFormat:@"user/checkCode?version=%@&token=%@&code=%@&ageGroup=%@",VERSION, token,code,age];
    [self getDataResponsePath:path success:success];
}

+ (void)getShopCartDelWidthID:(long)ID type:(NSInteger)type success:(void (^)(YFShareModel *))success {
    NSString *token=[[NSUserDefaults standardUserDefaults] objectForKey:USER_TOKEN]?:@"";
    NSString *del = type?@"delP":@"del";
    NSString *path = [NSString stringWithFormat:@"shopCart/%@?version=%@&token=%@&id=%ld",del,VERSION, token,ID];
    [self getDataResponsePath:path success:success];
}

@end
