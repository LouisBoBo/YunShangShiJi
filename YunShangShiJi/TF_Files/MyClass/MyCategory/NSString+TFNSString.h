//
//  NSString+TFNSString.h
//  YunShangShiJi
//
//  Created by 云商 on 16/3/17.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (TFNSString)
/**
 *  此方法检测一个字符串是否含有emoji表情
 *
 *  @param string 待检测字符串
 *
 *  @return 是否有emoji符号
 */
+ (BOOL)stringContainsEmoji:(NSString *)string;

@end
