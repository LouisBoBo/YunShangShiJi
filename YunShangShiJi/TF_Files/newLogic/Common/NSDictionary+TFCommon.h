//
//  NSDictionary+TFCommon.h
//  YunShangShiJi
//
//  Created by jingaiweiyi on 16/7/12.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (TFCommon)

/**
 *  key和value 拼接url
 *
 *  @return <#return value description#>
 */
- (NSString *)getStringFromDictionaryKeysAndValues;

/**
 *  将字典中的null值全部替换为空字符串
 *
 *  @param myObj <#myObj description#>
 *
 *  @return <#return value description#>
 */
+(id)changeType:(id)myObj;

@end
