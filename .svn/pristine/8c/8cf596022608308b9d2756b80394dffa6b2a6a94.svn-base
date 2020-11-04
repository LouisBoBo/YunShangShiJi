//
//  DianpuTableViewCell.m
//  YunShangShiJi
//
//  Created by ios-1 on 15/4/20.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//

#import "DianpuTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "GlobalTool.h"
@implementation DianpuTableViewCell

- (void)awakeFromNib {
    // Initialization code
}
-(void)creashData:(DianpuModel*)model
{
    self.Titlelabel.numberOfLines=0;
    
    self.Titlelabel.text=model.title;
    self.saleprice.text=model.SellingPrice;
    self.shouprice.text=model.DepPreice;

}

-(void)creashBestlikeData:(DianpuModel*)model
{
    self.Titlelabel.text=model.shop_name;
    self.saleprice.text=[NSString stringWithFormat:@"已降价%.2f元",[model.shop_price floatValue]];
//    [self.HeadImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",PHOTOhttp,model.show_pic]]];
    
    NSURL *imgUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",PHOTOhttp,model.show_pic]];
    __block float d = 0;
    __block BOOL isDownlaod = NO;
    [self.HeadImage sd_setImageWithURL:imgUrl placeholderImage:nil options:SDWebImageRetryFailed progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        d = (float)receivedSize/expectedSize;
        isDownlaod = YES;
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (image != nil && isDownlaod == YES) {
            self.HeadImage.alpha = 0;
            [UIView animateWithDuration:0.5 animations:^{
                self.HeadImage.alpha = 1;
            } completion:^(BOOL finished) {
            }];
        } else if (image != nil && isDownlaod == NO) {
            self.HeadImage.image = image;
        }
    }];
    
    self.shouprice.text=[NSString stringWithFormat:@"￥%.2f",[model.shop_se_price floatValue]];

}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
