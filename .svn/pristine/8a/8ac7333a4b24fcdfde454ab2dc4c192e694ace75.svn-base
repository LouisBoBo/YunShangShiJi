//
//  YFImageCache.m
//  YunShangShiJi
//
//  Created by zgl on 16/7/8.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import "YFImageCache.h"
#import <CommonCrypto/CommonDigest.h>

static unsigned char kPNGSignatureBytes[8] = {0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A};
static NSData *kPNGSignatureData = nil;

BOOL ImageDataHasPNGPreffix(NSData *data);

BOOL ImageDataHasPNGPreffix(NSData *data) {
    NSUInteger pngSignatureLength = [kPNGSignatureData length];
    if ([data length] >= pngSignatureLength) {
        if ([[data subdataWithRange:NSMakeRange(0, pngSignatureLength)] isEqualToData:kPNGSignatureData]) {
            return YES;
        }
    }
    
    return NO;
}


@interface YFImageCache ()

@property (strong, nonatomic) dispatch_queue_t ioQueue;
@property (strong, nonatomic) NSString *diskCachePath;

@end


@implementation YFImageCache {
    NSFileManager *_fileManager;
}

+ (instancetype)sharedImageCache {
    static dispatch_once_t once;
    static id instance;
    dispatch_once(&once, ^{
        instance = [self new];
        kPNGSignatureData = [NSData dataWithBytes:kPNGSignatureBytes length:8];
    });
    return instance;
}

- (id)init {
    return [self initWithNamespace:@"LaunchImage"];
}

- (id)initWithNamespace:(NSString *)ns {
    if ((self = [super init])) {
        NSString *fullNamespace = [@"com.yssjsz.YFImageCache." stringByAppendingString:ns];
         _ioQueue = dispatch_queue_create("com.yssjsz.YFImageCache", DISPATCH_QUEUE_SERIAL);
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
        _diskCachePath = [paths[0] stringByAppendingPathComponent:fullNamespace];
        dispatch_sync(_ioQueue, ^{
            _fileManager = [NSFileManager new];
        });
    }
    return self;
}

- (NSString *)cachePathForKey:(NSString *)key inPath:(NSString *)path {
    NSString *filename = [self cachedFileNameForKey:key];
    return [path stringByAppendingPathComponent:filename];
}

- (NSString *)defaultCachePathForKey:(NSString *)key {
    return [self cachePathForKey:key inPath:self.diskCachePath];
}

- (NSString *)cachedFileNameForKey:(NSString *)key {
    const char *str = [key UTF8String];
    if (str == NULL) {
        str = "";
    }
    unsigned char r[CC_MD5_DIGEST_LENGTH];
    CC_MD5(str, (CC_LONG)strlen(str), r);
    NSString *filename = [NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
                          r[0], r[1], r[2], r[3], r[4], r[5], r[6], r[7], r[8], r[9], r[10], r[11], r[12], r[13], r[14], r[15]];
    
    return filename;
}

- (void)storeImage:(UIImage *)image recalculateFromImage:(BOOL)recalculate imageData:(NSData *)imageData forKey:(NSString *)key{
    if (!image || !key) {
        return;
    }
    
    dispatch_async(self.ioQueue, ^{
        NSData *data = imageData;
        if (image && (recalculate || !data)) {
#if TARGET_OS_IPHONE
            BOOL imageIsPng = YES;
            if ([imageData length] >= [kPNGSignatureData length]) {
                imageIsPng = ImageDataHasPNGPreffix(imageData);
            }
            
            if (imageIsPng) {
                data = UIImagePNGRepresentation(image);
            }
            else {
                data = UIImageJPEGRepresentation(image, (CGFloat)1.0);
            }
#else
            data = [NSBitmapImageRep representationOfImageRepsInArray:image.representations usingType: NSJPEGFileType properties:nil];
#endif
        }
        
        if (data) {
            if (![_fileManager fileExistsAtPath:_diskCachePath]) {
                [_fileManager createDirectoryAtPath:_diskCachePath withIntermediateDirectories:YES attributes:nil error:NULL];
            }
            
            [_fileManager createFileAtPath:[self defaultCachePathForKey:key] contents:data attributes:nil];
        }
    });
}

- (void)storeImage:(UIImage *)image forKey:(NSString *)key {
    [self storeImage:image recalculateFromImage:YES imageData:nil forKey:key];
}

- (NSData *)diskImageDataBySearchingAllPathsForKey:(NSString *)key {
    NSString *defaultPath = [self defaultCachePathForKey:key];
    NSData *data = [NSData dataWithContentsOfFile:defaultPath];
    if (data) {
        return data;
    }
    return nil;
}

- (UIImage *)diskImageForKey:(NSString *)key {
    NSData *data = [self diskImageDataBySearchingAllPathsForKey:key];
    if (data) {
        UIImage *image = [UIImage imageWithData:data];
        return image;
    }
    else {
        return nil;
    }
}

- (void)removeImageForKey:(NSString *)key {
    if (key == nil) {
        return;
    }
    dispatch_async(self.ioQueue,^{
        [_fileManager removeItemAtPath:[self defaultCachePathForKey:key] error:nil];
    });
}

- (BOOL)diskImageExistsWithKey:(NSString *)key {
    BOOL exists = NO;
    exists = [[NSFileManager defaultManager] fileExistsAtPath:[self defaultCachePathForKey:key]];
    return exists;
}

@end
