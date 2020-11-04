//
//  LaunchImageManager.m
//  YunShangShiJi
//
//  Created by zgl on 16/7/9.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import "LaunchImageManager.h"
#import "YFImageCache.h"
#import "SDWebImageDownloader.h"
#import "LaunchModel.h"

NSString * const LaunchLastImg = @"LaunchLastImg";
//最后一次启动图
NSString * const LaunchcurrentImgs = @"LaunchcurrentImgs";
//启动图数组（@{LaunchImgName:@"地址", LaunchImgBeginTime:@(开始时间), LaunchImgEndTime:@(结束时间)}）
NSString * const LaunchImgName = @"LaunchImgName";
//启动图地址(http://……/xxx.jpg)
NSString * const LaunchImgBeginTime = @"LaunchImgBeginTime";
//启动图开始时间(@(1111111111))
NSString * const LaunchImgEndTime = @"LaunchImgEndTime";
//启动图结束时间

@implementation LaunchImageManager

+ (UIImage *)launchImage {
    return [self imageInFile];
}

/// 从本地取出图片
+ (UIImage *)imageInFile {
    UIImage *image = nil;
    //已下载图片
    NSMutableArray *imgArry = [[[NSUserDefaults standardUserDefaults] objectForKey:LaunchcurrentImgs] mutableCopy];
    NSMutableArray *deleteArry = [NSMutableArray array];
    for (NSDictionary *dict in imgArry) {
        long long beginTime = [[dict objectForKey:LaunchImgBeginTime] longLongValue];
        long long endTime = [[dict objectForKey:LaunchImgEndTime] longLongValue];
        long long nowTime = [NSDate date].timeIntervalSince1970;
        NSString *fileName = [self fileNameWithSourcePath:[dict objectForKey:LaunchImgName]];
        
        if (nowTime <= endTime) {
            //需要显示的图片
            if (nowTime >= beginTime) {
                image = [[YFImageCache sharedImageCache] diskImageForKey:fileName];
                //存入当前显示图片，防止下次启动没有符合条件的图片时，继续显示这张图片
                if (image)
                    [[YFImageCache sharedImageCache] storeImage:image forKey:LaunchLastImg];
            }
            //查看图片有没有下载，没有就下载图片
            [self downloadImageWithPath:[dict objectForKey:LaunchImgName]];
        } else {
            //移除过期图片
            [[YFImageCache sharedImageCache] removeImageForKey:fileName];
            [deleteArry addObject:dict];
        }
        
    }
    
    //已下载图片没有符合条件
    if (image == nil) {
        //取出上一次显示的图片
        image = [[YFImageCache sharedImageCache] diskImageForKey:LaunchLastImg];
        //上面都不存在，则为首次打开，显示默认图片
        if (image == nil) {
            NSString *imgPath = [NSString stringWithFormat:@"%@/%@", [[NSBundle mainBundle] resourcePath], @"launch_1.jpg"];
            image = [UIImage imageWithContentsOfFile:imgPath];
            [[YFImageCache sharedImageCache] storeImage:image forKey:LaunchLastImg];
        }
    }
    
    //移除过期图片
    if (imgArry.count&&deleteArry.count) {
        [imgArry removeObjectsInArray:deleteArry];
        [[NSUserDefaults standardUserDefaults] setObject:[imgArry copy] forKey:LaunchcurrentImgs];
    }
    
    return image;
}

/// 更新启动图
+ (void)update {
//    NSArray *images = @[@{@"url":@"http://192.168.1.9/zentao/data/upload/1/201607/0411205603186f40.jpg",
//                          @"beginTime":@(1467907200),
//                          @"endTime":@(1467993599)},
//                        
//                        @{@"url":@"http://192.168.1.9/zentao/data/upload/1/201607/0411205616389m6e.jpg",
//                          @"beginTime":@(1467993600),
//                          @"endTime":@(1468079999)},
//                        
//                        @{@"url":@"http://192.168.1.9/zentao/data/upload/1/201607/0411205626595vm6.jpg",
//                          @"beginTime":@(1468080000),
//                          @"endTime":@(1468079999)},
//                        
//                        @{@"url":@"http://192.168.1.9/zentao/data/upload/1/201607/0411205636040dal.jpg",
//                          @"beginTime":@(1468166400),
//                          @"endTime":@(1468252799)},
//
//                        @{@"url":@"http://192.168.1.9/zentao/data/upload/1/201607/0411205646724fnv.jpg",
//                          @"beginTime":@(1468252800),
//                          @"endTime":@(1468339199)}];
    [LaunchModel getLaunchModelWithSuccess:^(LaunchModel *data) {
        if (data.status == 1) {
            [self storeImageWithData:data.data];
        }
    }];
}

/// 批量下载并保存图片
+ (void)storeImageWithData:(NSArray *)data {
    NSMutableArray *imgArry = [NSMutableArray arrayWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:LaunchcurrentImgs]];
    for (LaunchImgModel *model in data) {
        long long beginTime = model.time;
        long long endTime = model.time;
        NSString *path = model.pic;
 
        BOOL exist = [self downloadImageWithPath:path];
        //如果没下载过则将图片相关信息添加到启动图里
        if (!exist) {
            NSDictionary *dict = @{LaunchImgName:path, LaunchImgBeginTime:@(beginTime), LaunchImgEndTime:@(endTime)};
            [imgArry addObject:dict];
        }
    }
    [[NSUserDefaults standardUserDefaults] setObject:[imgArry copy] forKey:LaunchcurrentImgs];
}

/// 下载图片：path图片路径
+ (BOOL)downloadImageWithPath:(NSString *)path {
    //取出图片名
    NSString *key = [self fileNameWithSourcePath:path];
    //是否已经下载了
    BOOL exist = [[YFImageCache sharedImageCache] diskImageExistsWithKey:key];
    //没有下载则下载图片
    if (!exist) {
        SDWebImageDownloader *downImage = [SDWebImageDownloader sharedDownloader];
        [downImage downloadImageWithURL:[NSURL URLWithString:path] options:SDWebImageDownloaderContinueInBackground progress:nil completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished) {
            //将图片保存到本地
            [[YFImageCache sharedImageCache] storeImage:image forKey:key];
        }];
    }
    return exist;
}

/// 获取文件名称
+ (NSString *)fileNameWithSourcePath:(NSString *)sourcePath {
    NSString *fullFileName = [[sourcePath componentsSeparatedByString:@"/"] lastObject];
    return [[fullFileName componentsSeparatedByString:@"."] firstObject];
}

@end
