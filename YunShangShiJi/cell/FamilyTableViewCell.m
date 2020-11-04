//
//  FamilyTableViewCell.m
//  YunShangShiJi
//
//  Created by ios-1 on 15/4/23.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//

#import "FamilyTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "GlobalTool.h"
@implementation FamilyTableViewCell

- (void)awakeFromNib {
    // Initialization code
    self.headimage.clipsToBounds = YES;
    
    self.headimage.frame=CGRectMake(ZOOM(62), self.headimage.frame.origin.y, self.headimage.frame.size.width, self.headimage.frame.size.height);
    
    CGFloat width =CGRectGetMaxX(self.headimage.frame);
    
    self.title.frame = CGRectMake(width+ZOOM(40), self.title.frame.origin.y, self.title.frame.size.width, self.title.frame.size.height);
    self.content.frame = CGRectMake(self.title.frame.origin.x, self.content.frame.origin.y, self.content.frame.size.width, self.content.frame.size.height);
    
    self.pinglunImg.frame = CGRectMake(self.content.frame.origin.x, self.pinglunImg.frame.origin.y, self.pinglunImg.frame.size.width, self.pinglunImg.frame.size.height);
    
    CGFloat c_countY = CGRectGetMaxX(self.pinglunImg.frame);
    self.c_count.frame = CGRectMake(c_countY +ZOOM(30), self.c_count.frame.origin.y, self.c_count.frame.size.width, self.c_count.frame.size.height);

}
-(void)refreshData:(ForumModel*)model
{
    NSURL *imgUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@!280",[NSObject baseURLStr_Upy],model.pic]];
    if ([model.pic hasPrefix:@"http://"]) {
        imgUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@",model.pic]];
    }
    __block float d = 0;
    __block BOOL isDownlaod = NO;
    [self.headimage sd_setImageWithURL:imgUrl placeholderImage:[UIImage imageNamed:@"默认头像.jpg"] options:SDWebImageRetryFailed progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        d = (float)receivedSize/expectedSize;
        isDownlaod = YES;
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (image != nil && isDownlaod == YES) {
            self.headimage.alpha = 0;
            [UIView animateWithDuration:0.5 animations:^{
                self.headimage.alpha = 1;
            } completion:^(BOOL finished) {
            }];
        } else if (image != nil && isDownlaod == NO) {
            self.headimage.image = image;
        }
    }];
    
    self.headimage.clipsToBounds=YES;
    self.headimage.layer.cornerRadius=self.headimage.frame.size.width/2;
    
    
    self.title.text=[NSString stringWithFormat:@"%@",model.title];
    self.title.font = [UIFont systemFontOfSize:ZOOM(50)];
    
    self.content.text=[NSString stringWithFormat:@"%@",model.content];
    self.content.textColor=kTextColor;
    self.content.font = [UIFont systemFontOfSize:ZOOM(44)];
    
    self.c_count.text=[NSString stringWithFormat:@"%@",model.n_count];
    self.c_count.font = [UIFont systemFontOfSize:ZOOM(40)];
    
    self.u_content.text=[NSString stringWithFormat:@"%@",model.u_count];
    self.u_content.font = [UIFont systemFontOfSize:ZOOM(40)];
    
    self.pinglunImg.image=[UIImage imageNamed:@"评论-1"];
//    self.liulanImg.image=[UIImage imageNamed:@"人数"];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
