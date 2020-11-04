//
//  OrderDetailTableViewCell.m
//  YunShangShiJi
//
//  Created by ios-1 on 15/4/28.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//

#import "OrderDetailTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "GlobalTool.h"
@implementation OrderDetailTableViewCell

- (void)awakeFromNib {
    // Initialization code
}
-(void)refreshData:(OrderDetailModel*)model
{
//    [self.headimage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",PHOTOhttp,model.shop_pic]]];
    
    NSURL *imgUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",PHOTOhttp,model.shop_pic]];
    __block float d = 0;
    __block BOOL isDownlaod = NO;
    [self.headimage sd_setImageWithURL:imgUrl placeholderImage:nil options:SDWebImageRetryFailed progress:^(NSInteger receivedSize, NSInteger expectedSize) {
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

    
    self.shopdescription.text=[NSString stringWithFormat:@"%@",model.message];
    self.clorOrsize.text=[NSString stringWithFormat:@"颜色:%@尺码:%@",model.color,model.size];
    self.shopprice.text=[NSString stringWithFormat:@"¥%@",model.shop_price];
    self.shopnumber.text=[NSString stringWithFormat:@"x%@",model.shop_num];
    
    if(model.status.intValue==2)
    {
        [self.clickbtn setTitle:@"申请退款" forState:UIControlStateNormal];
        self.clickbtn.backgroundColor=tarbarrossred;
    }

    if(model.status.intValue==3)
    {
        [self.clickbtn setTitle:@"申请退款" forState:UIControlStateNormal];
        self.clickbtn.backgroundColor=tarbarrossred;
    }

    if(model.status.intValue==4)
    {
        [self.clickbtn setTitle:@"申请售后" forState:UIControlStateNormal];
        self.clickbtn.backgroundColor=tarbarrossred;
    }
    
   
    [self.clickbtn setTintColor:[UIColor whiteColor]];
    
    [self.clickbtn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
}

-(void)refreshData1:(OrderDetailModel*)model
{
    [self.headimage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[NSObject baseURLStr_Upy],model.shop_pic]]];
//    self.shopdescription.text=[NSString stringWithFormat:@"%@",model.message];
    self.clorOrsize.text=[NSString stringWithFormat:@"颜色:%@尺码:%@",model.color,model.size];
    self.shopprice.text=[NSString stringWithFormat:@"¥%@",model.shop_price];
    self.shopnumber.text=[NSString stringWithFormat:@"x%@",model.shop_num];
}

-(void)click:(UIButton*)sender
{
    if(_delegate &&[_delegate respondsToSelector:@selector(Addcircle:)])
    {
        [_delegate Addcircle:_row];
    }

}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
