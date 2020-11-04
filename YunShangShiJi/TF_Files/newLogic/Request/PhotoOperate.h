//
//  PhotoOperate.h
//  YunShangShiJi
//
//  Created by jingaiweiyi on 16/8/23.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface PhotoOperate : NSObject
/*
 *  单例模式
 */
+ (id) sharedPhotoOperate;
/*
 *  截图并且保存
 */
- (BOOL) screenshotAndSavePath:(NSString *) fileFullPath;
/*
 *  从指定路径上传图片到服务器
 */
- (BOOL) uploadPhotoWithDomain:(NSString *) domain URI:(NSString *) uri fileFullPath:(NSString *) fileFullPath;
/*
 *  从服务器下载图片并存入指定路径(URL方式)
 */
- (BOOL) downloadPhotoWithURL:(NSString *)url cachesFilePath:(NSString *) filePath  progress:(void(^)(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead))progress success:(void(^)(UIImage *image, NSString *photoPath))success failure:(void(^)(NSError *error))failure;
/*
 *  传入子目录名字和文件名，生成一个文件的全路径
 */
- (NSString *)productFileFullPathWithSubDirectory:(NSString *)subDir fileName:(NSString *) fileName;

@end
