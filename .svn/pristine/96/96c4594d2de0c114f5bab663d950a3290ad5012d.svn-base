//
//  SalePurchaseShopListCell.m
//  YunShangShiJi
//
//  Created by 云商 on 15/12/2.
//  Copyright © 2015年 ios-1. All rights reserved.
//

#import "SalePurchaseShopListCell.h"

@implementation SalePurchaseShopListCell

- (void)awakeFromNib {
    // Initialization code
    
    self.packageLabel.layer.cornerRadius = 3;
    self.packageLabel.layer.masksToBounds = YES;
    self.H_progressView.constant = ZOOM(67);
    
    self.centerY_defaultImageView.constant = -1*ZOOM(67)*0.5;
    self.WH_defaultImageView.constant = ZOOM(150);
    
    self.titleLabel.font = [UIFont systemFontOfSize:ZOOM(48)];
    self.currPriceLabel.font = [UIFont systemFontOfSize:ZOOM(48)];
    self.oldPriceLabel.font = [UIFont systemFontOfSize:ZOOM(48)];
    self.packageLabel.font = [UIFont systemFontOfSize:ZOOM(40)];
    self.foreTitleLabel.font = [UIFont systemFontOfSize:ZOOM(48)];
    self.personLabel.font = [UIFont systemFontOfSize:ZOOM(40)];
    
    self.H_titleLabel.constant = ZOOM(135);
    
    self.headImageView.contentMode = UIViewContentModeScaleAspectFit;
    
}

- (void)receiveDataModel:(SaleShopListModel *)model
{
    self.defaultImageView.hidden = NO;
    
    NSString *picSize;
    if (kDevice_Is_iPhone6Plus) {
        picSize = @"!382";
    } else {
        picSize = @"!280";
    }
    
    NSMutableString *code = [NSMutableString stringWithString:[NSString stringWithFormat:@"%@",model.shop_code]];
    NSString *supcode  = [code substringWithRange:NSMakeRange(1, 3)];
    NSString *codestr = [NSString stringWithFormat:@"%@/%@",supcode,code];
    
    NSURL *imgUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@/%@%@",[NSObject baseURLStr_Upy],codestr,model.four_pic, picSize]];
    
    __block float d = 0;
    __block BOOL isDownlaod = NO;
    [self.headImageView sd_setImageWithURL:imgUrl placeholderImage:nil options:SDWebImageRetryFailed progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        d = (float)receivedSize/expectedSize;
        isDownlaod = YES;
        self.defaultImageView.hidden = NO;
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (image != nil && isDownlaod == YES) {
            self.headImageView.alpha = 0;
            self.defaultImageView.hidden = YES;
            [UIView animateWithDuration:0.5 animations:^{
                self.headImageView.alpha = 1;
            } completion:^(BOOL finished) {
                
            }];
        } else if (image != nil && isDownlaod == NO) {
            self.headImageView.image = image;
            self.defaultImageView.hidden = YES;
        }
    }];
    
    self.titleLabel.text = [NSString stringWithFormat:@"%@", model.shop_name];
    if ([self.type isEqualToString:@"1"]||[self.type isEqualToString:@"2"]||[self.type isEqualToString:@"3"]||[self.type isEqualToString:@"4"]) {
        self.progressView.hidden = YES;
        self.foreTitleLabel.hidden = YES;
        
        NSString *st = model.pModel.name;
        
//        if (model.pModel.shopNum == 1) {
//            st = @"超值单品";
//            self.packageLabel.hidden = YES;
//            
//        } else if (model.pModel.shopNum >1){
//            st = @"超值套餐";
//        }
        
//        //st = %@", st);
        
        
        CGSize size = [st boundingRectWithSize:CGSizeMake(100, 20) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:ZOOM(40)]} context:nil].size;
        self.W_package.constant = size.width+5;
        self.packageLabel.text = st;
        
        if ([self.type isEqualToString:@"1"]) {
            self.currPriceLabel.text = [NSString stringWithFormat:@"¥%.2f", [model.shop_se_price doubleValue]];
            self.P_packageLabel.constant = 10;
        } else {
            self.currPriceLabel.text = @"";
            self.P_packageLabel.constant = 0;
        }
        

    } else {
        self.progressView.hidden = NO;
        self.foreTitleLabel.hidden = NO;
        
        self.foreTitleLabel.text = [NSString stringWithFormat:@"剩余%@件",model.invertory_num];
        
        self.W_foreView.constant = ZOOM(420)-10;
        NSString *st = @"包邮";
        
        CGSize size = [st boundingRectWithSize:CGSizeMake(100, 20) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:ZOOM(40)]} context:nil].size;
        self.W_package.constant = size.width+5;
        
        self.packageLabel.text = st;

    }
    
    self.oldPriceLabel.text = [NSString stringWithFormat:@"¥%.2f",[model.shop_price doubleValue]];
    
    self.personLabel.text = [NSString stringWithFormat:@"%@人在抢", model.virtual_sales];
        
}

- (void)receiveDataModel:(SaleShopListModel *)sModel withPListModel:(SalePListModel *)pModel
{
    self.defaultImageView.hidden = NO;
    NSURL *imgUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[NSObject baseURLStr_Upy],sModel.def_pic]];
    
    //    //imgUrl = %@", imgUrl);
    __block float d = 0;
    __block BOOL isDownlaod = NO;
    [self.headImageView sd_setImageWithURL:imgUrl placeholderImage:nil options:SDWebImageRetryFailed progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        d = (float)receivedSize/expectedSize;
        isDownlaod = YES;
        self.defaultImageView.hidden = NO;
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (image != nil && isDownlaod == YES) {
            self.headImageView.alpha = 0;
            self.defaultImageView.hidden = YES;
            [UIView animateWithDuration:0.5 animations:^{
                self.headImageView.alpha = 1;
            } completion:^(BOOL finished) {
                
            }];
        } else if (image != nil && isDownlaod == NO) {
            self.headImageView.image = image;
            self.defaultImageView.hidden = YES;
        }
    }];
    
    self.titleLabel.text = [NSString stringWithFormat:@"%@", sModel.shop_name];
    if ([self.type isEqualToString:@"1"]||[self.type isEqualToString:@"2"]||[self.type isEqualToString:@"3"]||[self.type isEqualToString:@"4"]) {
        self.progressView.hidden = YES;
        self.foreTitleLabel.hidden = YES;
        
        
        NSString *st;
        if (pModel.shopNum == 1) {
            st = @"超值单品";
        } else if (pModel.shopNum >1){
            st = @"超值套餐";
        }
        
        CGSize size = [st boundingRectWithSize:CGSizeMake(100, 20) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:ZOOM(50)]} context:nil].size;
        self.W_package.constant = size.width+10;
        
        self.packageLabel.text = st;
    } else {
        self.progressView.hidden = NO;
        self.foreTitleLabel.hidden = NO;
        self.foreTitleLabel.text = [NSString stringWithFormat:@"剩余%@件",sModel.invertory_num];
        
        if ([sModel.invertory_num integerValue]<=[pModel.num integerValue]) {
            
            self.progressView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
            
            self.W_foreView.constant = (float)[sModel.invertory_num integerValue]/[pModel.num integerValue]*(ZOOM(420)-10);
        } else {
            self.W_foreView.constant = (ZOOM(420)-10);
        }
        NSString *st = @"包邮";
        CGSize size = [st boundingRectWithSize:CGSizeMake(100, 20) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:ZOOM(50)]} context:nil].size;
        self.W_package.constant = size.width+10;
        
        self.packageLabel.text = st;
    }
    
    self.oldPriceLabel.text = [NSString stringWithFormat:@"¥%.2f",[sModel.shop_price doubleValue]];
    self.personLabel.text = [NSString stringWithFormat:@"%@人在抢", sModel.virtual_sales];
    self.currPriceLabel.text = [NSString stringWithFormat:@"¥%.2f", [pModel.price doubleValue]];

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
    return text;}

@end
