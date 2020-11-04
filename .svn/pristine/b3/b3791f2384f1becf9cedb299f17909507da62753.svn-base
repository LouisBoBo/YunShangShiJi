//
//  NSString+TFCommon.h
//  YunShangShiJi
//
//  Created by jingaiweiyi on 16/7/12.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (TFCommon)

//获取随机昵称
+(NSString *)userNameRandomProduce;
//获取随机头像
+(NSString *)userHeadRandomProduce;
//获取随机头像不重复数组
+ (NSArray *)userImgArrRandomProduce;

// 获取iOS设备
+(NSString *)stringCurrentDeviceModel;

- (CGSize)getSizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size;
- (CGFloat)getHeightWithFont:(UIFont *)font constrainedToSize:(CGSize)size;
- (CGFloat)getWidthWithFont:(UIFont *)font constrainedToSize:(CGSize)size;

-(BOOL)containsEmoji;
- (BOOL)isEmpty;

//判断是否为整形
- (BOOL)isPureInt;
//判断是否为浮点形
- (BOOL)isPureFloat;
//判断是否是手机号码或者邮箱
- (BOOL)isPhoneNo;
- (BOOL)isEmail;
// 判断是否为身份证号
- (BOOL)isIdCard;

+ (NSMutableAttributedString *)attributedSourceString:(NSString *)string targetString:(NSString *)targetString addAttributes:(NSDictionary *)addAttributes;
@end
