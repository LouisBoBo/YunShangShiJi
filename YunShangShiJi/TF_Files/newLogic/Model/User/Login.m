//
//  Login.m
//  YunShangShiJi
//
//  Created by jingaiweiyi on 16/7/14.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import "Login.h"


static User *curLoginUser;
@implementation Login

- (NSString *)toPath{
    return @"user/login?";
}

+ (BOOL)isLogin{
    NSNumber *loginStatus = [[NSUserDefaults standardUserDefaults] objectForKey:kLoginStatus];
    if (loginStatus.boolValue && [Login curLoginUser]) {
        User *loginUser = [Login curLoginUser];
        if (loginUser.status && loginUser.status.integerValue != 1) {
            [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithBool:NO] forKey:kLoginStatus];
            return NO;
        }
        return YES;
    } else{
        [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithBool:NO] forKey:kLoginStatus];
        return NO;
    }
}

+ (User *)curLoginUser{
    NSNumber *loginStatus = [[NSUserDefaults standardUserDefaults] objectForKey:kLoginStatus];
    if (!curLoginUser && loginStatus.boolValue == YES) {
        
        NSData *loginData = [[NSUserDefaults standardUserDefaults] objectForKey:kLoginUserDict];
        
        curLoginUser = loginData? [NSObject objectOfClass:@"User" fromJSON:[NSJSONSerialization JSONObjectWithData:loginData options:NSJSONReadingAllowFragments error:nil]]: nil;

    }
    return curLoginUser;
}

+ (void)doLogin:(NSDictionary *)loginData{
    if (loginData) {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:[NSNumber numberWithBool:YES] forKey:kLoginStatus];
        NSData *data = [Login returnDataWithDictionary:[NSDictionary changeType:loginData]];
        [defaults setObject:data forKey:kLoginUserDict];
        curLoginUser = [NSObject objectOfClass:@"User" fromJSON:[NSDictionary changeType:loginData]];
        [defaults synchronize];
        
        [self saveLoginData:loginData];
    } else{
        [Login doLogout];
    }
}

/**
 *  退出登录
 */
+ (void)doLogout
{
//    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:[NSNumber numberWithBool:NO] forKey:kLoginStatus];
    [defaults synchronize];
    
    curLoginUser = nil;
    
    NSArray *cookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies];
    [cookies enumerateObjectsUsingBlock:^(NSHTTPCookie *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj.domain hasPrefix:@"www.52yifu."]) {
            [[NSHTTPCookieStorage sharedHTTPCookieStorage] deleteCookie:obj];
        }
    }];
}


+ (BOOL)saveLoginData:(NSDictionary *)loginData{
    BOOL saved = NO;
    if (loginData) {
        NSMutableDictionary *loginDataList = [self readLoginDataList];
        User *curUser = [NSObject objectOfClass:@"User" fromJSON:[NSDictionary changeType:loginData]];
        
        if (curUser.userinfo.user_id) {
            NSMutableDictionary *userDic = [NSMutableDictionary dictionaryWithDictionary:[NSDictionary changeType:loginData]];
            
            [loginDataList setObject:userDic forKey:[NSString stringWithFormat:@"%@",curUser.userinfo.user_id]];
            saved = YES;
            
        }
        if (saved) {
            saved = [loginDataList writeToFile:[self loginDataListPath] atomically:YES];
        }
    }
    return saved;
}

+ (NSMutableDictionary *)readLoginDataList{
    NSMutableDictionary *loginDataList = [NSMutableDictionary dictionaryWithContentsOfFile:[self loginDataListPath]];
    if (!loginDataList) {
        loginDataList = [NSMutableDictionary dictionary];
    }
    return loginDataList;
}

+ (NSString *)loginDataListPath{
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    return [documentPath stringByAppendingPathComponent:kLoginDataListPath];
}

+(BOOL)isLoginUserToken:(NSString *)token{
    if (token.length <= 0) {
        return NO;
    }
    return [[self curLoginUser].token isEqualToString:token];
}

- (NSString *)getCurrLoginUserToken
{
    return [Login curLoginUser].token;
}

+ (User *)userWithUserid:(NSString *)userid
{
    if (userid.length <= 0) {
        return nil;
    }
    NSMutableDictionary *loginDataList = [self readLoginDataList];
    NSDictionary *loginData = [loginDataList objectForKey:userid];
    return [NSObject objectOfClass:@"User" fromJSON:loginData];
}

+ (NSData*)returnDataWithDictionary:(NSDictionary*)dict
{
    NSError* error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    if ([jsonData length] > 0 && error == nil){
        return jsonData;
    }else{
        return nil;
    }
}

+ (void)clearUserInfoForKey:(NSString *)key;
{
    NSMutableDictionary *loginDataList = [Login readLoginDataList];
    [loginDataList removeObjectForKey:key];
    [loginDataList writeToFile:[self loginDataListPath] atomically:YES];
}

+ (void)clearAlllUserInfo
{
    NSMutableDictionary *muDic = [Login readLoginDataList];
    NSArray *allkeys = [muDic allKeys];
    for (NSString *key in allkeys) {
        [Login clearUserInfoForKey:key];
    }
}

@end
