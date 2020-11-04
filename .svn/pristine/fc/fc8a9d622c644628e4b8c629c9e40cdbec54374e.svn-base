//
//  BaseModel.h
//  YIFUDemo
//
//  Created by hyj on 16/5/5.
//  Copyright © 2016年 ZhaoGuanLin. All rights reserved.
//
//  基础Model（封装有网络请求与json解析）
//  创建Model时继承至这个BaseModel
//
//  如果属性是数组则重写＋getMapping，写法如下：
//  + (NSMutableDictionary *)getMapping {
//      NSMutableDictionary *mapping =  [NSMutableDictionary dictionaryWithObjectsAndKeys:[xxxModel mappingWithKey:@"array"],
//      @"array",nil];
//      return mapping;
//  }
//  xxxModel为数组的基本元素的类，@“array” 为当前数组名;
//
//  对于修改属性名称(假如接口返回的是oldName，自己需要的是newName)，写法如下：
//  + (NSMutableDictionary *)getMapping {
//      NSMutableDictionary *mapping =  [NSMutableDictionary dictionaryWithObjectsAndKeys:@"newName",@"oldName", nil];
//      return mapping;
//  }

#import <Foundation/Foundation.h>
#import "NSObject+JTObjectMapping.h"
#import "AFNetworking.h"
#import "MyMD5.h"
#import "GlobalTool.h"
#import "LKDBHelper.h"

@interface BaseModel : NSObject

#pragma mark - DB
/// 用户相关数据库
+ (NSString *)getUserDBName;

#pragma mark - map
/// 获取映射表 子类重写
+ (NSMutableDictionary *)getMapping;

+ (id <JTValidMappingKey>)mappingWithKey:(NSString *)key;
+ (id <JTValidMappingKey>)mappingWithKey:(NSString *)key mapping:(NSMutableDictionary *)mapping;

#pragma mark - handle network data
/**
 @brief  接口请求后直接解析回调
 @param path            相对路径 （里面MD5加密过了，不需要再次加密。）
 @param success         请求成功之后的回调
 @return 操作对象
 */
+ (void)getDataResponsePath:(NSString *)path success:(void (^)(id data))success;

@end
