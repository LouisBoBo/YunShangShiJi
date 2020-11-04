//
//  TFPublicClass.h
//  YunShangShiJi
//
//  Created by 云商 on 16/3/31.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GlobalTool.h"

@interface TFPublicClass : NSObject

//将图片保存到本地
+ (void)saveImageToLocal:(UIImage*)image Keys:(NSString*)key;
//本地是否有相关图片
+ (BOOL)localHaveImage:(NSString*)key;
//从本地获取图片
+ (UIImage*)getImageFromLocal:(NSString*)key;
+ (BOOL)judgeChineseString:(NSString *)text;
+ (BOOL)stringContainsEmoji:(NSString *)string;


+ (void)saveTokenToLocal:(NSString *)token;
+ (NSString *)getTokenFromLocal;

+ (void)saveRealmToLocal:(NSString *)realm;
+ (NSString *)getRealmFromLocal;

+ (NSString *)getUIDFromLocal;
+ (void)saveUIDToLocal:(NSString *)uid;
@end
