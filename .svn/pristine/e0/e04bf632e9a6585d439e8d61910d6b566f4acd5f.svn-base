//
//  YFImageCache.h
//  YunShangShiJi
//
//  Created by zgl on 16/7/8.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * 将图片存放本地
 */
@interface YFImageCache : NSObject

+ (instancetype)sharedImageCache;

/**
 * 初始化新的存储与特定的命名空间
 *
 *@param ns 命名空间
 *@return   存储对象
 */
- (id)initWithNamespace:(NSString *)ns;

/**
 * 通过关键字存储图片
 *
 *@param image 需要存储的图片
 *@param key   关键字
 */
- (void)storeImage:(UIImage *)image forKey:(NSString *)key;

/**
 * 通过关键字取出图片
 *
 *@param key   关键字
 *@return 存储的图片
 */
- (UIImage *)diskImageForKey:(NSString *)key;

/**
 * 通过关键字移除图片
 */
- (void)removeImageForKey:(NSString *)key;

/**
 * 通过关键字判断图片是否存在
 */
- (BOOL)diskImageExistsWithKey:(NSString *)key;

@end
