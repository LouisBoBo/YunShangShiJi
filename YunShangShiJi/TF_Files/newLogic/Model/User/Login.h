//
//  Login.h
//  YunShangShiJi
//
//  Created by jingaiweiyi on 16/7/14.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

#define kLoginStatus @"login_status"
#define kLoginUserDict @"user_dict"
#define kLoginDataListPath @"login_data_list_path.plist"
/**< 用户偏好 */
#define kLoginUserPreferenceDict @"user_preference_dict"
#define kLoginUserPreferenceDataListPath @"preference_data_list_path.plist"
/**< 公共数据 */
#define kLoginPublicPreferenceDict @"public_preference_dict"
#define kLoginPublicDataListPath @"public_data_list_path.plist"
@interface Login : NSObject

- (NSString *)toPath;

/**
 *  是否登录
 *
 *  @return <#return value description#>
 */
+ (BOOL)isLogin;

/**
 *  当前用户
 *
 *  @return <#return value description#>
 */
+ (User *)curLoginUser;

/**
 *  登录
 *
 *  @param loginData <#loginData description#>
 */
+ (void)doLogin:(NSDictionary *)loginData;
+ (void)doLogout;

+(BOOL)isLoginUserToken:(NSString *)token;

/**
 *  获取token
 *
 *  @return <#return value description#>
 */
- (NSString *)getCurrLoginUserToken;

/**
 *  通过uid获取用户
 *
 *  @param userid <#userid description#>
 *<#return value description#>
 *  @return 
 */
+ (User *)userWithUserid:(NSString *)userid;

+ (void)clearUserInfoForKey:(NSString *)key;

+ (void)clearAlllUserInfo;

@end
