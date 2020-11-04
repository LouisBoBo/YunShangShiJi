//
//  UserInfo.h
//  YunShangShiJi
//
//  Created by ios-1 on 15/4/13.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UserInfo : NSObject<NSCoding>
//登录成功服务器返回的信息
@property (nonatomic ,retain)NSString *usertoken;
//手机用户
@property (nonatomic ,retain)NSString *userPhone;
@property (nonatomic ,retain)NSString *userName;
@property (nonatomic ,retain)NSString *userPassword;
//邮箱用户
@property (nonatomic ,retain)NSString *userEmail;
@property (nonatomic ,retain)NSString *EmailName;
@property (nonatomic ,retain)NSString *EmailPassword;
//第三方用户
@property (nonatomic ,retain)NSString *uid;
@property (nonatomic ,retain)NSString *nikeName;
@property (nonatomic ,retain)NSString *token;
@property (nonatomic ,retain)NSString *userType;

//商品信息
@property (nonatomic ,retain)NSString *shop_code;
@property (nonatomic ,retain)NSString *shop_name;
@property (nonatomic ,retain)NSString *shop_price;
@property (nonatomic ,retain)NSString *shop_pic;

@end
