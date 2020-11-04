//
//  TagImageCollectionViewCell.m
//  YunShangShiJi
//
//  Created by ios-1 on 2017/4/14.
//  Copyright © 2017年 ios-1. All rights reserved.
//

#import "TagImageCollectionViewCell.h"
#import "UIImageView+WebCache.h"
#import "DefaultImgManager.h"
#define DefaultImg(size) [[DefaultImgManager sharedManager] defaultImgWithSize:(size)]
@implementation TagImageCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)refreshData:(TdetailsModel*)model
{
    self.detailModel = model;
    [self.contentView addSubview:self.tagImageView];
    
    NSURL *imgUrl;
    NSString *st = @"!450";
    if (kDevice_Is_iPhone6Plus) {
        st = @"!450";
    } else {
        st = @"!382";
    }

    NSArray *pic = [model.pics componentsSeparatedByString:@","];
    NSArray *picurl = [pic[0] componentsSeparatedByString:@":"];
    if(picurl.count)
    {
        imgUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@/myq/theme/%@/%@%@",[NSObject baseURLStr_Upy],model.user_id,picurl[0],st]];
    }

    __block float d = 0;
    __block BOOL isDownlaod = NO;
    kSelfWeak;
    [self.tagImageView sd_setImageWithURL:imgUrl placeholderImage:DefaultImg(self.bounds.size) options:SDWebImageRetryFailed progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        d = (float)receivedSize/expectedSize;
        isDownlaod = YES;
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (image != nil && isDownlaod == YES) {
            weakSelf.tagImageView.alpha = 0;
            [UIView animateWithDuration:0.5 animations:^{
                weakSelf.tagImageView.alpha = 1;
            } completion:^(BOOL finished) {
            }];
        } else if (image != nil && isDownlaod == NO) {
            weakSelf.tagImageView.image = image;
        }
    }];

}

- (ZYTagImageView *)tagImageView {
    if (_tagImageView==nil) {
        
        UIImage *image = [UIImage imageNamed:@""];
        _tagImageView = [[ZYTagImageView alloc] initWithImage:image];
        _tagImageView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        _tagImageView.delegate = self;
        _tagImageView.userInteractionEnabled = YES;
        [_tagImageView setAllTagsEditEnable:YES];
        
        // 添加标签
        NSArray *tagsArray = [self getTagsArray];
        NSMutableArray *tagsarr = [NSMutableArray array];
        for(int i =0; i <tagsArray.count;i++)
        {
            SupperLabelModel *supperModel = tagsArray[i];
            
            ZYTagInfo *info = [ZYTagInfo tagInfo];
            info.isShopTag= (supperModel.shop_code != nil && supperModel.shop_code.length >=8);   //当是商品标签时传yes
            info.index = i;
            CGFloat x = supperModel.label_x.floatValue<0?(self.frame.size.width*0.99):(self.frame.size.width*supperModel.label_x.floatValue);
            CGFloat y = supperModel.label_y.floatValue<0?(self.frame.size.height*0.99):(self.frame.size.height*supperModel.label_y.floatValue);
            if(supperModel.direction.intValue == 0)
            {
                info.direction = ZYTagDirectionLeft;
            }else if (supperModel.direction.intValue == 1)
            {
                info.direction = ZYTagDirectionRight;
            }
            
            info.point = CGPointMake(x,y);
            info.title = [self getTagTitle:[NSString stringWithFormat:@"%@",supperModel.label_id]];
            if(info.title == nil || [info.title isEqualToString:@""])
            {
                info.title = info.isShopTag?@"衣蝠精选":nil;
            }
            info.title.length>0?[tagsarr addObject:info]:nil;
        }
        
        [_tagImageView addTagsWithTagInfoArray:tagsarr];
    }
    return _tagImageView;
}

- (NSArray*)getTagsArray
{
    //数组去重
    NSMutableArray *tagsArray = [NSMutableArray array];
    for (int i = 0; i < [self.detailModel.supp_label_list count]; i++){
        
        SupperLabelModel *model1 = self.detailModel.supp_label_list[i];
        BOOL found = NO;
        for (SupperLabelModel *modle in tagsArray)
        {
            if(model1.only_id.intValue == modle.only_id.intValue)
            {
                found = YES;
                break;
            }
        }
        if(!found)
        {
            [tagsArray addObject:model1];
        }
    }
    return tagsArray;
}
- (NSString *)getTagTitle:(NSString*)tagid
{
    NSString *tagtitle = @"";
    for(int i =0;i<self.detailModel.tagsArray.count;i++)
    {
        TopicTagsModel *tagmodel = self.detailModel.tagsArray[i];
        if(tagid.intValue == tagmodel.ID.intValue)
        {
            tagtitle = tagmodel.title;
        }
    }
    return tagtitle;
}
#pragma mark - ZYTagImageViewDelegate 点击图片
- (void)tagImageView:(ZYTagImageView *)tagImageView activeTapGesture:(UITapGestureRecognizer *)tapGesture
{
    NSLog(@"点击图片");
}

- (void)tagImageView:(ZYTagImageView *)tagImageView tagViewActiveTapGesture:(ZYTagView *)tagView
{
    /** 可自定义点击手势的反馈 */
    if (tagView.isEditEnabled) {
        NSLog(@"编辑模式 -- 轻触");
    }else{
        NSLog(@"预览模式 -- 轻触");
    }
    
    SupperLabelModel *tagmodel = self.detailModel.supp_label_list[tagView.tagInfo.index];
    NSString *lableid = [NSString stringWithFormat:@"%@",tagmodel.label_id];
    if(tagmodel.label_type.intValue == 2)
    {
        lableid = [NSString stringWithFormat:@"%@",tagmodel.only_id];
    }
    if(self.tagsBlock)
    {
        self.tagsBlock(lableid,tagView.tagInfo.title,tagmodel.label_type.integerValue,tagmodel.shop_code);
    }
}

@end
