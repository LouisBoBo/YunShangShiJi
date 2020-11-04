//
//  PhotoOperate.m
//  YunShangShiJi
//
//  Created by jingaiweiyi on 16/8/23.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import "PhotoOperate.h"
#import <UIKit/UIKit.h>
#import <CoreGraphics/CGImage.h>
#import "AFNetworking.h"
#import "MyMD5.h"
static PhotoOperate* mPhotoOperate = nil;


@implementation PhotoOperate
/*
 *  单例模式
 */
+ (id) sharedPhotoOperate{
    @synchronized(self){
        if(nil == mPhotoOperate){
            mPhotoOperate = [[self alloc] init];
        }
    }
    return mPhotoOperate;
}

/*
 *  截图并且保存
 */
- (BOOL) screenshotAndSavePath:(NSString *) fileFullPath{
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(640, 960), YES, 0);
    UIWindow* window = [[UIApplication sharedApplication] keyWindow];
    UIGraphicsBeginImageContext(window.frame.size);
    [window.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    CGImageRef imageRef = viewImage.CGImage;
    CGRect rect = [[UIScreen mainScreen] bounds];
    CGImageRef imageRefRect =CGImageCreateWithImageInRect(imageRef, rect);
    UIImage *sendImage = [[UIImage alloc] initWithCGImage:imageRefRect];
    //保存为png格式
    //    NSData *imageViewData = UIImagePNGRepresentation(sendImage);
    //保存为jpeg格式(此种格式可以压缩)
    NSData *imageViewData = UIImageJPEGRepresentation(sendImage,1.0);
    //保存截图文件到/Document/CrabScreenshot目录,文件名用时间，避免覆盖
    BOOL ret = [imageViewData writeToFile:fileFullPath atomically:YES];
    CGImageRelease(imageRefRect);
    return ret;
}

/*
 *  上传图片到服务器
 */
- (BOOL) uploadPhotoWithDomain:(NSString *) domain URI:(NSString *) uri fileFullPath:(NSString *) fileFullPath
{
    
    UIImage* image = [UIImage imageWithContentsOfFile:fileFullPath];
    NSData* data = UIImageJPEGRepresentation(image, 1.0);
    
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    // AFHTTPResponseSerializer就是正常的HTTP请求响应结果:NSData
    // 当请求的返回数据不是JSON,XML,PList,UIImage之外,使用AFHTTPResponseSerializer
    // 例如返回一个html,text...
    //
    // 实际上就是AFN没有对响应数据做任何处理的情况
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager POST:domain parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        [formData appendPartWithFileData:data name:@"file" fileName:[NSString stringWithFormat:@"%@.png", uri] mimeType:@"image/png"];
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"Success!");
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"failure!");
    }];
    
    return YES;
}

- (BOOL) downloadPhotoWithURL:(NSString *)url cachesFilePath:(NSString *) filePath  progress:(void(^)(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead))progress success:(void(^)(UIImage *image, NSString *photoPath))success failure:(void(^)(NSError *error))failure
{
    
    __block BOOL save = NO;
    
    NSString *fileFullPath = [self productFileFullPathWithSubDirectory:filePath fileName:[NSString stringWithFormat:@"%@.data", [MyMD5 md5:url]]];
    
    //NSLog(@"fileFullPath: %@", fileFullPath);
    if (filePath) {
        NSFileManager *fileManager = [NSFileManager defaultManager];
        if ([fileManager fileExistsAtPath:fileFullPath]) {
            NSData *imageData = [NSData dataWithContentsOfFile:fileFullPath];
            UIImage *image = [UIImage imageWithData:imageData];
            if (success) {
                success(image, filePath == nil? nil: fileFullPath);
            }
            return YES;
        }
    }
    
    NSURL* nsurl = [NSURL URLWithString:url];
    NSURLRequest* request = [NSURLRequest requestWithURL:nsurl];
    AFHTTPRequestOperation* operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    // 断点下载
    //[operation setOutputStream:[NSOutputStream outputStreamToFileAtPath:fileFullPath append:NO]];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        //MyLog(@"responseObject: %@", responseObject);
        if (filePath) {
            NSData *imageData = (NSData *)responseObject;
            save = [imageData writeToFile:fileFullPath atomically:YES];
        }
        
        UIImage *image = [UIImage imageWithData:responseObject];
        if (success) {
            success(image, filePath == nil? nil: fileFullPath);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //NSLog(@"Failure");
        if (failure) {
            failure(error);
        }
        save = NO;
    }];
    
    [operation setDownloadProgressBlock:^(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead) {
        //bytesRead: 当前读取速度
        //totalBytesRead: 已经读取
        //totalBytesExpectedToRead: 总共大小
        //NSLog(@"bytesRead = %lu, totalBytesRead = %lld, totalBytesExpectedToRead = %lld", (unsigned long)bytesRead, totalBytesRead, totalBytesExpectedToRead);
        
        if (progress) {
            progress(bytesRead, totalBytesRead, totalBytesExpectedToRead);
        }
    }];
    
    [operation start];
    return save;
}

/*
 *  在cache目录下创建一个子目录,创建成功则返回目录的路径，失败返回nil
 */
- (NSString *) createDirectoryOnDocumentWithSubDirectory:(NSString *)subDir{
    //在~/cache目录下创建一个子目录
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *screenshotDirectory = [documentsDirectory stringByAppendingPathComponent:subDir];
    NSFileManager *fm = [NSFileManager defaultManager];
    NSError *error;
    if (![fm createDirectoryAtPath: screenshotDirectory withIntermediateDirectories: YES attributes:nil error: &error]) {
        //如果创建目录失败则直接returns
        return nil;
    }
    return screenshotDirectory;
}

/*
 *  传入子目录名字和文件名，生成一个文件的全路径,成功返回全路径，失败则返回nil
 */
- (NSString *)productFileFullPathWithSubDirectory:(NSString *)subDir fileName:(NSString *) fileName{
    //在~/caches目录下创建一个子目录/subDir/fileName
    NSString* screenshotDirectory = [self createDirectoryOnDocumentWithSubDirectory:subDir];
    if (nil == screenshotDirectory) {
        return nil;
    }
    NSString *fileFullPath = [screenshotDirectory stringByAppendingPathComponent:fileName];
    return fileFullPath;
}

@end
