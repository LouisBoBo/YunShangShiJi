//
//  Tools.h
//  test
//
//  Created by ken on 15/1/2.
//  Copyright (c) 2015年 Ken. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "GlobalTool.h"
@interface Tools : NSObject
@property(nonatomic,strong)UIButton *rightButton;
@property(nonatomic,strong)UIButton *leftButton;




+ (Tools *)share;
- (UIBarButtonItem *)createRightBarButtonItem:(NSString *)title target:(id)obj selector:(SEL)selector ImageName:(NSString*)imageName;
- (UIBarButtonItem *)createLeftBarButtonItem:(NSString *)title target:(id)obj selector:(SEL)selector ImageName:(NSString*)imageName;

/**
 * 压缩图片
 */
+ (NSData *)dataWithcompressImage:(UIImage *)image;

/**
 * 判断字符串中是否包含表情
 */
- (BOOL)stringContainsEmoji:(NSString *)string;

/**
 * 获取当前日期
 */
- (NSString *)getDate;

/**
 * 获取当前时间
 */
- (NSString *)getTime;

/**
 * string：  文本
 * font：    字体大小
 * size：    范围宽高
 */
- (CGSize )getTextSizeWithString:(NSString *)string font:(UIFont *)font size:(CGSize )CustonSize;


/**
 * 弹框  1.5秒
 * str： 弹框文字
 */
- (void)showLoadingWithText:(NSString *)str WithView:(UIView *)view;

/**
 * 弹框
 * str：   弹框文字
 * delay ：持续时间
 * view：  界面
 */
- (void)showLoadingWithText:(NSString *)str afterDelay:(CGFloat)delay WithView:(UIView *)view;

/**
 * 取消弹框
 * view：  界面
 */
- (void)hideForView:(UIView *)view;

/**
 * 判断通知是否开启
 */
+(BOOL)enabledRemoteNotification;


+ (NSString *)projectTypeNameWithprojectType:(NSString*)projectType;

@end
