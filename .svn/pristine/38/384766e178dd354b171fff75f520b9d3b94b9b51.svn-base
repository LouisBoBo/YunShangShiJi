//
//  ImageCollectionViewCell.m
//  FJWaterfallFlow
//
//  Created by ios-1 on 2016/12/26.
//  Copyright © 2016年 fujin. All rights reserved.
//

#import "ImageCollectionViewCell.h"
#import "UIImageView+WebCache.h"

@implementation ImageCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectmark.backgroundColor = [UIColor whiteColor];
    self.selectmark.layer.cornerRadius = self.selectmark.frame.size.height/2;
}

- (void)setCellData:(HobbyModel *)dataModel{
    
    if(dataModel.is_Select)
    {
        self.selectmark.image = [UIImage imageNamed:@"wodexihao_fengge_icon_xuanzhong"];
    }else{
        self.selectmark.image = [UIImage imageNamed:@"wodexihao_fengge_icon_weixuanzhong"];
    }
    
    dataModel.pic.length>10?([self.selectimage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[NSObject baseURLStr_Upy],dataModel.pic]]]):(self.selectimage.image = [UIImage imageNamed:[self getImage:dataModel.title]]);
    self.selectimage.clipsToBounds = YES;
    self.selectimage.layer.cornerRadius = 3;
    self.selectimage.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(click:)];
    [self.selectimage addGestureRecognizer:tap];
}

- (void)setPhotoData:(ShopShareModel *)dataModel
{
    if(dataModel.is_Select)
    {
        self.selectmark.image = [UIImage imageNamed:@"wodexihao_fengge_icon_xuanzhong"];
    }else{
        self.selectmark.image = [UIImage imageNamed:@"recommend_zuanzhong_normal"];
    }
    
    [self.selectimage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[NSObject baseURLStr_Upy],dataModel.show_pic]] placeholderImage:nil];
    self.selectimage.clipsToBounds = YES;
    self.selectimage.layer.cornerRadius = 3;
    self.selectimage.userInteractionEnabled = YES;
    self.selectimage.contentMode = UIViewContentModeScaleAspectFill;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(click:)];
    [self.selectimage addGestureRecognizer:tap];

}
- (NSString*)getImage:(NSString*)imgname
{
    NSString *imagestr = @"wodexihao_fengge_hanxi";
    if([imgname isEqualToString:@"韩系"])
    {
        imagestr = @"wodexihao_fengge_hanxi";
    }
    else if ([imgname isEqualToString:@"通勤名媛"])
    {
        imagestr = @"wodexihao_fengge_jianyue";
    }
    else if ([imgname isEqualToString:@"欧美街头"])
    {
        imagestr = @"wodexihao_fengge_oumei";
    }
    else if ([imgname isEqualToString:@"轻熟"])
    {
        imagestr = @"wodexihao_fengge_qishu";
    }
    else if ([imgname isEqualToString:@"日系"])
    {
        imagestr = @"wodexihao_fengge_rixi";
    }
    else if ([imgname isEqualToString:@"文艺复古"])
    {
        imagestr = @"wodexihao_fengge_wenyi";
    }
    else if ([imgname isEqualToString:@"学院风"])
    {
        imagestr = @"wodexihao_fengge_xueyuan";
    }
    else if ([imgname isEqualToString:@"运动休闲"])
    {
        imagestr = @"wodexihao_fengge_yundong";
    }
   
    return imagestr;
}
- (void)click:(UITapGestureRecognizer*)tap
{
    if(self.clickBlock)
    {
        self.clickBlock();
    }
}
@end
