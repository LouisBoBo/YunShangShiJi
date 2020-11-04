//
//  NSString+helper.h
//  YunShangShiJi
//
//  Created by zgl on 16/6/2.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, TimeStrStyle) {
    TimeStrStyleDefault = 0, // yyyy年MM月dd日
    TimeStrStyleArticle = 1,// 文章发表时间（“刚刚”、“3分钟前”、“3小时前”、“今天 09:00”、“6月12日 12:00”、“2015年6月12日”）
    TimeStrStyleMessage = 2
};

@interface NSString (helper)

/// 计算文字高度
+ (CGFloat)heightWithString:(NSString *)string font:(UIFont *)font constrainedToWidth:(CGFloat)width;
/// 计算文字宽度
+ (CGFloat)widthWithString:(NSString *)string font:(UIFont *)font constrainedToHeight:(CGFloat)height;
/// 根据时间戳返回与当前时间比较后的字符串
+ (NSString*)getTimeStyle:(TimeStrStyle)style time:(long long)time;
/// 当需要改变Label中一段字体属性时调用
+ (NSMutableAttributedString *)getOneColorInLabel:(NSString *)allstring ColorString:(NSString *)string Color:(UIColor*)color fontSize:(float)size;
+ (NSMutableAttributedString *)getAllColorStringInLabel:(NSString *)allstring ColorString:(NSString *)string Color:(UIColor*)color fontSize:(float)size;
+ (NSMutableAttributedString *)getOneColorInLabel:(NSString *)allstring ColorString:(NSString *)string Color:(UIColor*)color font:(UIFont *)font;
/// 当需要改变Label中多段字体属性时调用
+ (NSMutableAttributedString *)getOneColorInLabel:(NSString *)allstring strs:(NSArray *)strs Color:(UIColor*)color fontSize:(float)size;
+ (NSMutableAttributedString *)getOneColorInLabel:(NSString *)allstring strs:(NSArray *)strs Color:(UIColor*)color font:(UIFont *)font;

/// 设置文章正文字体段距、行间距以及字体大小
+ (NSAttributedString *)attributedStringWithString:(NSString *)string paragraphSpacing:(CGFloat)paragraphSpacing lineSpacing:(CGFloat)lineSpacing fontSize:(CGFloat)size color:(UIColor *)color;

+ (NSMutableAttributedString *)paragraphLineSpaceAttrWithString:(NSString *)fullStr
                                                      lineSpace:(CGFloat)lineSpace;
@end
