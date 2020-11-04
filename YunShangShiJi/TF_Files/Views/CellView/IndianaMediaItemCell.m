//
//  IndianaMediaItemCell.m
//  YunShangShiJi
//
//  Created by jingaiweiyi on 16/6/2.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import "IndianaMediaItemCell.h"

@interface IndianaMediaItemCell ()


@end

@implementation IndianaMediaItemCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSrcUrl:(NSString *)srcUrl
{
    if (!_imgView) {
        _imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kIndianaMediaItemCell_Width, kIndianaMediaItemCell_Width)];
        _imgView.contentMode = UIViewContentModeScaleAspectFill;
        _imgView.clipsToBounds = YES;
        [self.contentView addSubview:_imgView];
    }
    
    if (_srcUrl != srcUrl) {
        _srcUrl = srcUrl;
//        [self.imgView sd_setImageWithURL:[NSURL URLWithString:_srcUrl] placeholderImage:nil  options:SDWebImageRetryFailed];
        
        [self.imgView setImageWithURL:[NSURL URLWithString:_srcUrl] placeholderImage:nil progress:^(float downloaderProgress) {
            
        } completed:^{
            
        }];
        
    }
}

- (void)setSrcUrl:(NSString *)srcUrl withCount:(NSInteger)count {
    if (!_imgView) {
        _imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kICMediaItemCell_Width, kICMediaItemCell_Width)];
        _imgView.contentMode = UIViewContentModeScaleAspectFill;
        _imgView.clipsToBounds = YES;
        [self.contentView addSubview:_imgView];
        
        if (count == 2 || count == 4) {
            _imgView.frame = CGRectMake(0, 0, kICMediaItemCell2_Width, kICMediaItemCell2_Width);
        }
    }
    
    if (count == 2 || count == 4) {
        _imgView.frame = CGRectMake(0, 0, kICMediaItemCell2_Width, kICMediaItemCell2_Width);
    } else {
        _imgView.frame = CGRectMake(0, 0, kICMediaItemCell_Width, kICMediaItemCell_Width);
    }
    
    if (_srcUrl != srcUrl) {
        _srcUrl = srcUrl;
        
//        [self.imgView sd_setImageWithURL:[NSURL URLWithString:_srcUrl] placeholderImage:nil  options:SDWebImageRetryFailed];
        
        NSString *picSize= @"";
        if(![_srcUrl containsString:@"!"])
        {
            if (kDevice_Is_iPhone6Plus) {
                picSize = @"!382";
            } else {
                picSize = @"!280";
            }
        }
        
        [self.imgView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",_srcUrl,picSize]] placeholderImage:[UIImage imageDefaultWithSize:CGSizeMake(kICMediaItemCell_Width, kICMediaItemCell_Width)] progress:^(float downloaderProgress) {
            
        } completed:^{
            
        }];
        
    }
}


- (void)layoutSubviews{
    [super layoutSubviews];
}

+(CGSize)ccellSizeWithObj:(id)obj{
    CGSize itemSize;
    if ([obj isKindOfClass:[IndianaModel class]]) {
        itemSize = CGSizeMake(floor(kIndianaMediaItemCell_Width), floor(kIndianaMediaItemCell_Width));
    }
    return itemSize;
}

+(CGSize)cellSizeWithObj:(id)obj {
    CGSize itemSize;
    if ([obj isKindOfClass:[IntimateCircleModel class]]) {
        
        IntimateCircleModel *model = (IntimateCircleModel *)obj;
        if (model.srcArray.count == 2 || model.srcArray.count == 4) {
            itemSize = CGSizeMake(floor(kICMediaItemCell2_Width),
                                  floor(kICMediaItemCell2_Width));
        } else {
            itemSize = CGSizeMake(floor(kICMediaItemCell_Width), floor(kICMediaItemCell_Width));
        }
    }
    return itemSize;
}

@end
