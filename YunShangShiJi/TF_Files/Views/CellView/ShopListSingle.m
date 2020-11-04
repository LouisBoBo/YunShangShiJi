//
//  ShopListSingle.m
//  YunShangShiJi
//
//  Created by 云商 on 16/5/3.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import "ShopListSingle.h"

@implementation ShopListSingle

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.shopNameLabel.font = kFont6px(28);
    self.shopPriceLabel.font = kFont6px(36);
    self.shopOriginalPariceLabel.font = kFont6px(24);
    self.shopNumberLabel.font = kFont6px(22);
    self.personLabel.font = kFont6px(26);
    self.personLabel.textColor = RGBCOLOR_I(125, 125, 125);
    self.H_shopBackground.constant = ZOOM6(14);
    self.W_shopBackground.constant = ZOOM6(280);
    self.H_goShopBtn.constant = ZOOM6(58);
    self.goShopBtn.titleLabel.font = kFont6px(30);
    self.S_goShopBtn.constant = ZOOM6(24);
    self.S_shopPrice.constant = ZOOM6(12);
    self.shopBeforeView.layer.masksToBounds = YES;
    self.shopBeforeView.layer.cornerRadius = ZOOM6(2);
    self.shopBackgroundView.layer.masksToBounds = YES;
    self.shopBackgroundView.layer.cornerRadius = ZOOM6(2);
}

- (void)receiveDataModel:(PListModel *)model
{
    self.myModel = model;
    
    MyLog(@"add_date: %@", model.add_date);
    
    NSInteger shopsCount = model.shopList.count;
    NSInteger r_num = [model.r_num intValue];
    NSTimeInterval systemTimeInterval = [model.add_date doubleValue]+48*3600*1000;
    NSTimeInterval currTimeInterval = [NSDate timeIntervalSince1970WithDate];
    NSTimeInterval diffTimeInterval = systemTimeInterval - currTimeInterval;
    MyDateFormatterStruct dateStruct = [NSDate dateComponentsWithTimeInterval:diffTimeInterval];
    
    if ([model.p_status integerValue] == 0) {
        if ([model.r_num intValue]>=0 && model.r_num!=nil) {
            if ([model.r_num intValue]> 0) {
                r_num = [model.r_num intValue];
                if (diffTimeInterval>0) { // 3. 时间
                    self.isStock = YES;
                } else {
                    self.isStock = NO;
                }
            } else {
                self.isStock = NO;
                r_num = 0;
            }
        } else {
            self.isStock = NO;
            r_num = 0;
        }
    } else {
        self.isStock = NO;
        r_num = 0;
    }
    
    model.isSaleOut = !self.isStock;
    
    if (self.isStock) {
        if(diffTimeInterval>0) {
            self.W_shopBefore.constant = (diffTimeInterval/1000)/(48*3600)*self.W_shopBackground.constant;
        } else {
            self.W_shopBefore.constant = self.W_shopBackground.constant*0;
        }
    } else {
        self.W_shopBefore.constant = self.W_shopBackground.constant*0;
    }
    
    if (diffTimeInterval>0) {
        if (!self.isStock) {
            self.shopNumberLabel.text = [NSString stringWithFormat:@"限时48小时，还剩0时0分"];
        } else {
            self.shopNumberLabel.text = [NSString stringWithFormat:@"限时48小时，还剩%02ld时%02ld分", (long)dateStruct.hour+(long)dateStruct.day*24, (long)dateStruct.minute];
        }
        
    } else {
        self.shopNumberLabel.text = [NSString stringWithFormat:@"限时48小时，还剩0时0分"];
    }
    
    NSString *postageText;
    if ([model.postage doubleValue] > 0.0f) {
        postageText = [NSString stringWithFormat:@"邮费%.1f", [model.postage doubleValue]];
    } else {
        postageText = @"包邮";
    }
    
    CGSize size = [postageText boundingRectWithSize:CGSizeMake(100, 20) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:ZOOM6(24)]} context:nil].size;
    self.W_postagePrice.constant = size.width+6;
    self.H_postagePrice.constant = size.height+2;
    self.postagePriceLabel.font = kFont6px(24);
    self.postagePriceLabel.text = postageText;
    
    NSString *picSize;
    if (kDevice_Is_iPhone6Plus) {
        picSize = @"!382";
    } else {
        picSize = @"!280";
    }
    
    if (shopsCount == 1) {
        TFShopModel *model1 = model.shopList[0];
        NSMutableString *code1 = [NSMutableString stringWithString:[NSString stringWithFormat:@"%@",model1.shop_code]];
        NSString *supcode1  = [code1 substringWithRange:NSMakeRange(1, 3)];
        NSString *codestr1 = [NSString stringWithFormat:@"%@/%@",supcode1,code1];
        NSURL *imgUrl1 = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@/%@%@",[NSObject baseURLStr_Upy],codestr1,model1.four_pic, picSize]];
        __block float d = 0;
        __block BOOL isDownlaod = NO;
        [self.shopImageView sd_setImageWithURL:imgUrl1 placeholderImage:[UIImage imageDefaultWithSize:CGSizeMake(ZOOM6(293)-20, ZOOM6(293)-20)] options:SDWebImageRetryFailed progress:^(NSInteger receivedSize, NSInteger expectedSize) {
            d = (float)receivedSize/expectedSize;
            isDownlaod = YES;
            //            self.defaultImageView.hidden = NO;
        } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            if (image != nil && isDownlaod == YES) {
                self.shopImageView.alpha = 0;
                //                self.defaultImageView.hidden = YES;
                [UIView animateWithDuration:0.5 animations:^{
                    self.shopImageView.alpha = 1;
                } completion:^(BOOL finished) {
                    
                }];
            } else if (image != nil && isDownlaod == NO) {
                self.shopImageView.image = image;
                //                self.defaultImageView.hidden = YES;
            }
        }];
        self.shopNameLabel.text = [NSString stringWithFormat:@"%@", model1.shop_name];
        
        NSString *price = [NSString stringWithFormat:@"¥%.1f", [model1.shop_se_price doubleValue]];
        NSMutableAttributedString *atStr = [[NSMutableAttributedString alloc] initWithString:price];
        [atStr addAttribute:NSFontAttributeName value:kFont6px(32) range:NSMakeRange(0, 1)];
        [atStr addAttribute:NSFontAttributeName value:kFont6px(42) range:NSMakeRange(1, price.length-1)];
        self.shopPriceLabel.attributedText = atStr;
        
        self.shopOriginalPariceLabel.text = [NSString stringWithFormat:@"¥%.1f", [model1.shop_price doubleValue]];
    }
    
    if (self.isStock == NO) {
        self.personLabel.text = [NSString stringWithFormat:@"有0人正在抢"];
    } else {
        NSString *personText = [NSString stringWithFormat:@"有%d人正在抢", [model.virtual_sales intValue]];
        NSMutableAttributedString *attPersonText = [[NSMutableAttributedString alloc] initWithString:personText];
        [attPersonText addAttribute:NSForegroundColorAttributeName value:COLOR_ROSERED range:NSMakeRange(1, personText.length-5)];
        self.personLabel.attributedText = attPersonText;
    }
    
    [self.goShopBtn addTarget:self action:@selector(goShopBtnClick:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)goShopBtnClick:(UIButton *)sender
{
    if (self.goShopDetailBlock!=nil) {
        self.goShopDetailBlock();
    }
}
- (void)setIsStock:(BOOL)isStock
{
    _isStock = isStock;
    
    if (_isStock == YES) {
        self.shopNameLabel.textColor = RGBCOLOR_I(62, 62, 62);
        
        self.shopPriceLabel.textColor = COLOR_ROSERED;
        self.shopOriginalPariceLabel.textColor = RGBCOLOR_I(168, 168, 168);
        self.oldPriceLine.backgroundColor = RGBCOLOR_I(168, 168, 168);
        self.postagePriceLabel.textColor = COLOR_ROSERED;
        self.postagePriceLabel.layer.cornerRadius = 3;
        self.postagePriceLabel.layer.borderColor = [COLOR_ROSERED CGColor];
        self.postagePriceLabel.layer.borderWidth = 1;
        
        [self.goShopBtn setBackgroundImage:[UIImage imageWithColor:COLOR_ROSERED] forState:UIControlStateNormal];
//        [self.goShopBtn setBackgroundImage:[self imageWithColor:COLOR_ROSERED] forState:UIControlStateHighlighted];
        self.goShopBtn.layer.masksToBounds = YES;
        self.goShopBtn.layer.cornerRadius = 4;
        
        self.soldOutImageView.hidden = YES;
        
        self.shopBackgroundView.layer.borderColor = [COLOR_ROSERED CGColor];
        self.shopBackgroundView.layer.borderWidth = 1;
        self.shopBackgroundView.backgroundColor = [UIColor whiteColor];
        
    } else {
        self.shopNameLabel.textColor = RGBCOLOR_I(197, 197, 197);
        self.shopOriginalPariceLabel.textColor = RGBCOLOR_I(197, 197, 197);
        self.oldPriceLine.backgroundColor = RGBCOLOR_I(197, 197, 197);
        self.shopPriceLabel.textColor = RGBCOLOR_I(197, 197, 197);
        self.personLabel.textColor =  RGBCOLOR_I(197, 197, 197);
        self.postagePriceLabel.textColor = RGBCOLOR_I(197, 197, 197);
        self.postagePriceLabel.layer.cornerRadius = 3;
        self.postagePriceLabel.layer.borderColor = [RGBCOLOR_I(197, 197, 197) CGColor];
        self.postagePriceLabel.layer.borderWidth = 1;
        
        [self.goShopBtn setBackgroundImage:[UIImage imageWithColor:RGBCOLOR_I(197,197,197)] forState:UIControlStateNormal];
        self.goShopBtn.layer.masksToBounds = YES;
        self.goShopBtn.layer.cornerRadius = 4;
        
        self.soldOutImageView.hidden = NO;
        
        self.shopBackgroundView.layer.borderColor = [RGBCOLOR_I(197,197,197) CGColor];
        self.shopBackgroundView.layer.borderWidth = 1;
        self.shopBackgroundView.backgroundColor = RGBCOLOR_I(197,197,197);
    }
}

+ (CGFloat)cellHeight
{
    return ZOOM6(293);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
