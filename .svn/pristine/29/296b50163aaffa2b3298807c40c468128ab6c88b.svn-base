//
//  UIImageView+TFCommon.m
//  YunShangShiJi
//
//  Created by jingaiweiyi on 16/7/11.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import "UIImageView+TFCommon.h"


@implementation UIImageView (TFCommon)

- (void)setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder progress:(void(^)(float downloaderProgress))progress completed:(void(^)())completed
{
    
    __block BOOL isDownlaod = NO;
    [self sd_setImageWithURL:url placeholderImage:placeholder options:SDWebImageRetryFailed progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        isDownlaod = YES;
        
        float p = (float)receivedSize/expectedSize;
        if (progress) {
            progress(p);
        }
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
        if (image != nil && isDownlaod == YES) { /**< 网络下载 */
            self.alpha = 0;
            if (completed) {
                completed();
            }
            [UIView animateWithDuration:0.7 animations:^{
                self.alpha = 1;
            } completion:^(BOOL finished) {
                
            }];
        } else if (image != nil && isDownlaod == NO) { /**< 从缓存中拿 */
            
            self.image = image;
            if (completed) {
                completed();
            }
            
//            if (self.image != placeholder) { /**< 判断默认图片 */
//                self.image = image;
//                completed();
//            } else {
//                self.alpha = 0;
//                completed();
//                [UIView animateWithDuration:0.5 animations:^{
//                    self.alpha = 1;
//                } completion:^(BOOL finished) {
//                    
//                }];
//            }
        }
    }];

}

@end
