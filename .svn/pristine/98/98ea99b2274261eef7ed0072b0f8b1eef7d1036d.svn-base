//
//  BatchUploadImages.m
//  YunShangShiJi
//
//  Created by jingaiweiyi on 2017/2/21.
//  Copyright © 2017年 ios-1. All rights reserved.
//

#import "BatchUploadImages.h"
#import "UpYun.h"

@interface BatchUploadImages ()

@property (nonatomic, copy) NSString *fullPath;
@property (nonatomic, strong) NSMutableArray *saveImagePaths;
@property (nonatomic, strong) NSMutableArray *saveIndexs; 
@end

@implementation BatchUploadImages

- (instancetype)initWithPath:(NSString *)path filePaths:(NSString *)filePaths images:(NSArray *)images {
    if (self = [super init]) {
        _path = [path copy];
        _filePaths = [filePaths copy];
        _images = [images copy];
        _fullPath = [NSString stringWithFormat:@"%@%@", _path, _filePaths];
    }
    return self;
}


- (void)setPrecessBlock:(UploadPrecessBlock)precessBlock successBlock:(UploadSuccessBlock)successBlock failBlock:(UploadFailBlock)failBlock {
    _precessBlock = precessBlock;
    _successBlock = successBlock;
    _failBlock = failBlock;
}

/**
 开始上传
 */
- (void)uploadFile {
    if (self.path.length == 0) {
        NSError *error = [NSError errorWithDomain:NSMachErrorDomain code:100 userInfo:@{@"key": @"输入路径"}];
        if (self.failBlock) {
            self.failBlock(error);
        }
        return;
    }
    if (self.images.count == 0) {
        NSError *error = [NSError errorWithDomain:NSMachErrorDomain code:101 userInfo:@{@"key": @"需要传入图片"}];
        if (self.failBlock) {
            self.failBlock(error);
        }
        return;
    }
    if (!self.fullPath.length) {
        self.fullPath = [NSString stringWithFormat:@"%@%@", _path, _filePaths];
    }
    dispatch_queue_t myQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_sync(myQueue, ^{
            [self uploadImage:self.images.firstObject index:0];
    });
}

// 上传图片和编号
- (void)uploadImage:(UIImage *)uploadImage index:(NSInteger)index {
    
    [self.saveIndexs addObject:@(index)];
    UpYun *uy = [[UpYun alloc] init];
    NSInteger fileSize = 0;
    
    if (kDevice_Is_iPhone6Plus) {
        fileSize = 450*2*1024;
    } else {
        fileSize = 382*2*1024;
    }

    NSData *imageData = UIImageJPEGRepresentation(uploadImage, 1.0);
    NSLog(@"imagedata111111 = %lu",(unsigned long)imageData.length);
    
    if(imageData.length > fileSize)
    {
        if (kDevice_Is_iPhone6Plus) {
            uploadImage= [UIImage imageCompressForWidthSourceImage:uploadImage targetWidth:450];
        } else {
            uploadImage= [UIImage imageCompressForWidthSourceImage:uploadImage targetWidth:382];
        }

        NSData *imageData2 = UIImageJPEGRepresentation(uploadImage, 1);
        NSLog(@"imagedata222222 = %lu",(unsigned long)imageData2.length);
    }
    
    NSString *updateImagePath = [NSString stringWithFormat:@"%@%zd", self.fullPath, index];
    
    NSString *saveImagePath = [NSString stringWithFormat:@"%@:%.1f", updateImagePath,(CGFloat)(uploadImage.size.width) / uploadImage.size.height];
    
    CGFloat diff = (float)(1 / (float)self.images.count);
    uy.successBlocker = ^(id data) {
        [self.saveImagePaths addObject:saveImagePath];
        if (self.saveIndexs.count < self.images.count) {
            NSInteger nextIndex = [self.saveIndexs.lastObject integerValue] + 1;
            [self uploadImage:self.images[nextIndex] index:nextIndex];
            
        } else if (self.saveIndexs.count == self.images.count) {
            if (self.successBlock) {
                self.successBlock(self.saveImagePaths);
            }
        }
    };
    uy.failBlocker = ^(NSError * error) {
        if (self.failBlock) {
            self.failBlock(error);
        }
    };
    uy.progressBlocker = ^(CGFloat percent, long long requestDidSendBytes) {
        CGFloat currPercent = percent * diff + self.saveImagePaths.count * diff - 0.01;
        
        if (self.precessBlock) {
            self.precessBlock(currPercent);
        }
    };
    [uy uploadFile:uploadImage saveKey:updateImagePath];
}

- (NSMutableArray *)saveImagePaths {
    if (_saveImagePaths == nil) {
        _saveImagePaths = [NSMutableArray array];
    }
    return _saveImagePaths;
}
- (NSMutableArray *)saveIndexs {
    if (_saveIndexs == nil) {
        _saveIndexs = [NSMutableArray array];
    }
    return _saveIndexs;
}


@end
