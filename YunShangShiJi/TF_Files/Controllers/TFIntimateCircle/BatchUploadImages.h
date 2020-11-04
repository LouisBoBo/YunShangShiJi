//
//  BatchUploadImages.h
//  YunShangShiJi
//
//  Created by jingaiweiyi on 2017/2/21.
//  Copyright © 2017年 ios-1. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^UploadSuccessBlock)(NSArray *saveImagePaths);
typedef void(^UploadFailBlock)(NSError *error);
typedef void(^UploadPrecessBlock)(CGFloat precess);
@interface BatchUploadImages : NSObject

@property (nonatomic, strong) NSArray *images;   // 上传图片数组
@property (nonatomic, copy) NSString *path;      // 上传路径
@property (nonatomic, copy) NSString *filePaths; // 上传文件夹

@property (nonatomic, copy) UploadPrecessBlock  precessBlock;
@property (nonatomic, copy) UploadFailBlock     failBlock;
@property (nonatomic, copy) UploadSuccessBlock  successBlock;
@property (nonatomic, assign) CGFloat precess;
- (void)setPrecessBlock:(UploadPrecessBlock)precessBlock successBlock:(UploadSuccessBlock)successBlock failBlock:(UploadFailBlock)failBlock;

- (void)uploadFile;

@end
