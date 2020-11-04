//
//  PageViewCollectionViewCell.m
//  YunShangShiJi
//
//  Created by 云商 on 15/7/24.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//

#import "PageViewCollectionViewCell.h"
#import "UIImageView+WebCache.h"
#import "GlobalTool.h"
#import "MyMD5.h"

@implementation PageViewCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
//    self.headImageView.frame = CGRectMake(ZOOM(60), ZOOM(40), ZOOM(210), ZOOM(280));
//    self.titleLabel.frame = CGRectMake(CGRectGetMaxX(self.headImageView.frame)+ZOOM(37), ZOOM(45), kScreenWidth-CGRectGetMaxX(self.headImageView.frame)-ZOOM(37)- ZOOM(60), ZOOM(120));
//    self.titleLabel.numberOfLines = 2;
//    self.colorLabel.frame = CGRectMake(CGRectGetMinX(self.titleLabel.frame), CGRectGetMaxY(self.titleLabel.frame)+ZOOM(22), (kScreenWidth-CGRectGetMaxX(self.headImageView.frame)+ZOOM(37)- ZOOM(60))/2, ZOOM(60));
//    self.sizeLabel.frame = CGRectMake(CGRectGetMaxX(self.colorLabel.frame), CGRectGetMinY(self.colorLabel.frame), (kScreenWidth-CGRectGetMaxX(self.headImageView.frame)+ZOOM(37)- ZOOM(60))/2, ZOOM(60));
//    self.moneyLabel.frame = CGRectMake(CGRectGetMinX(self.colorLabel.frame), CGRectGetMaxY(self.colorLabel.frame)+ZOOM(22), ZOOM(300), ZOOM(60));
    
    self.constraint_headImg_w.constant = ZOOM(220);
//    self.constraint_label_w.constant = ZOOM(200);
    
}


- (void)receiveDataModel:(TFShopModel *)model
{
//    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[NSObject baseURLStr_Upy],model.shop_pic]]];
    NSURL *imgUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@/%@/%@!180",[NSObject baseURLStr_Upy],[MyMD5 pictureString:model.shop_code],model.shop_pic]];

//    NSURL *imgUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[NSObject baseURLStr_Upy],model.shop_pic]];
    __block float d = 0;
    __block BOOL isDownlaod = NO;
    [self.headImageView sd_setImageWithURL:imgUrl placeholderImage:nil options:SDWebImageRetryFailed progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        d = (float)receivedSize/expectedSize;
        isDownlaod = YES;
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (image != nil && isDownlaod == YES) {
            self.headImageView.alpha = 0;
            [UIView animateWithDuration:0.5 animations:^{
                self.headImageView.alpha = 1;
            } completion:^(BOOL finished) {
            }];
        } else if (image != nil && isDownlaod == NO) {
            self.headImageView.image = image;
        }
    }];
    
    NSString *st = [NSString stringWithFormat:@"颜色:%@",model.color];
    
    CGSize size = [st boundingRectWithSize:CGSizeMake(1000,20) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:ZOOM(44)]} context:nil].size;
    
    self.constraint_label_w.constant = size.width+5;
    
//    self.titleLabel.text = model.shop_name;
    self.titleLabel.text = [self exchangeTextWihtString:model.shop_name];
    self.colorLabel.text = [NSString stringWithFormat:@"颜色:%@",model.color];
    self.sizeLabel.text = [NSString stringWithFormat:@"尺码:%@",model.size];
    self.moneyLabel.text = [NSString stringWithFormat:@"￥%.2f",[model.shop_price doubleValue]];
    
    self.titleLabel.font = [UIFont systemFontOfSize:ZOOM(44)];
    self.colorLabel.font = [UIFont systemFontOfSize:ZOOM(44)];
    self.sizeLabel.font = [UIFont systemFontOfSize:ZOOM(44)];
    self.moneyLabel.font = [UIFont systemFontOfSize:ZOOM(44)];
}
- (NSString *)exchangeTextWihtString:(NSString *)text
{
    if ([text rangeOfString:@"】"].location != NSNotFound){
        NSArray *arr = [text componentsSeparatedByString:@"】"];
        NSString *textStr;
        if (arr.count == 2) {
            textStr = [NSString stringWithFormat:@"%@%@】", arr[1], arr[0]];
        }
        return textStr;
    }
    return text;
}
@end
