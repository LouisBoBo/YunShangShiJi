//
//  IndianaMediaItemSingleCell.m
//  YunShangShiJi
//
//  Created by jingaiweiyi on 16/6/2.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import "IndianaMediaItemSingleCell.h"
#import "ImageSizeManager.h"
#import "UIView+Frame.h"
#define kScreen_Height [UIScreen mainScreen].bounds.size.height
#define kScreen_Width [UIScreen mainScreen].bounds.size.width

#define kIndianaMediaItemSingleCell_Width KICContent_Width-kICUserInfoHeight-ZOOM6(10)// (0.6 *kScreen_Width)
#define kIndianaMediaItemSingleCell_MaxHeight kScreen_Height//(0.5 *kScreen_Height)



@implementation IndianaMediaItemSingleCell
@synthesize curMediaItem = _curMediaItem, imgView = _imgView, srcUrl = _srcUrl;
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)setSrcUrl:(NSString *)srcUrl
{
    if (!_imgView) {
        _imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kIndianaMediaItemSingleCell_Width, kIndianaMediaItemSingleCell_Width)];
        _imgView.contentMode = UIViewContentModeScaleAspectFill;
        _imgView.clipsToBounds = YES;
        //        _imgView.layer.masksToBounds = YES;
        //        _imgView.layer.cornerRadius = 2.0;
        [self.contentView addSubview:_imgView];
    }
    
    if (_srcUrl != srcUrl) {
        _srcUrl = srcUrl;
    }
    
    __weak typeof(self) weakSelf = self;
    CGSize reSize;
    
    reSize = [[ImageSizeManager shareManager] sizeWithSrc:_srcUrl originalWidth:kIndianaMediaItemSingleCell_Width maxHeight:kIndianaMediaItemSingleCell_MaxHeight];
//    
//    [_imgView sd_setImageWithURL:[NSURL URLWithString:_srcUrl] placeholderImage:nil options:SDWebImageRetryFailed completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//        if (image) {
//            if (![[ImageSizeManager shareManager] hasSrc:weakSelf.srcUrl]) {
//                [[ImageSizeManager shareManager] saveImage:weakSelf.srcUrl size:image.size];
//                if (weakSelf.refreshSingleCellBlock) {
//                    weakSelf.refreshSingleCellBlock();
//                }
//            }
//        }
//    }];
    
    [_imgView setImageWithURL:[NSURL URLWithString:_srcUrl] placeholderImage:[UIImage imageDefaultWithSize:reSize] progress:^(float downloaderProgress) {
        
    } completed:^{
//        kSelfStrong;
        if (![[ImageSizeManager shareManager] hasSrc:weakSelf.srcUrl]) {
            [[ImageSizeManager shareManager] saveImage:weakSelf.srcUrl size:weakSelf.imgView.image.size];
            if (weakSelf.refreshSingleCellBlock) {
                weakSelf.refreshSingleCellBlock();
            }
        }
    }];
    
    [_imgView setSize:reSize];
}


+(CGSize)ccellSizeWithObj:(id)obj
{
    CGSize itemSize;
    if ([obj isKindOfClass:[IndianaModel class]]) {
        IndianaModel *curMediaItem = (IndianaModel *)obj;
        
        itemSize = [[ImageSizeManager shareManager] sizeWithSrc:curMediaItem.srcArray.firstObject originalWidth:kIndianaMediaItemSingleCell_Width maxHeight:kIndianaMediaItemSingleCell_MaxHeight];
    }
    
    return itemSize;
}

+(CGSize)cellSizeWithObj:(id)obj
{
    CGSize itemSize;
    if ([obj isKindOfClass:[IntimateCircleModel class]]) {
        IntimateCircleModel *curMediaItem = (IntimateCircleModel *)obj;
        
        itemSize = [[ImageSizeManager shareManager] sizeWithSrc:curMediaItem.srcArray.firstObject originalWidth:kIndianaMediaItemSingleCell_Width maxHeight:kIndianaMediaItemSingleCell_MaxHeight];
        
    }
    
    return itemSize;
}

@end
