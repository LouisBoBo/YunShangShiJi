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
    self.shopNameLabel.font = TF_FONT(14*3.375);
    self.shopPriceLabel.font = TF_FONT(18*3.375);
    self.shopOriginalPariceLabel.font = TF_FONT(10*3.375);
    self.shopNumberLabel.font = TF_FONT(9*3.375);
    self.personLabel.font = TF_FONT(10*3.375);
    self.personLabel.textColor = RGBCOLOR_I(168, 168, 168);
    self.H_shopBackground.constant = ZOOM(7*3.375);
    self.W_shopBackground.constant = ZOOM(120*3.375);
    self.H_goShopBtn.constant = ZOOM(25*3.375);
    self.goShopBtn.titleLabel.font = TF_FONT(15*3.375);
    
    self.S_goShopBtn.constant = ZOOM(8*3.375);
    self.S_shopPrice.constant = ZOOM(8*3.375);
}

- (void)receiveDataModel:(PListModel *)model
{
    self.myModel = model;
    NSInteger shopsCount = model.shopList.count;
    
    if ([model.r_num intValue]>=0 && model.r_num!=nil) {
        if ([model.r_num intValue]> 0) {
            self.isStock = YES;
        } else {
            self.isStock = NO;
        }
    } else {
        self.isStock = NO;
    }
    
    if (self.isStock) {
        if([model.r_num intValue] !=0 && [model.num intValue]!=0) {
            self.W_shopBefore.constant = (float)[model.r_num intValue]/[model.num intValue]*self.W_shopBackground.constant;
        } else {
            self.W_shopBefore.constant = self.W_shopBackground.constant*0;
        }
    } else {
        self.W_shopBefore.constant = self.W_shopBackground.constant*0;
    }
    

    self.shopNumberLabel.text = [NSString stringWithFormat:@"限量%d件，还剩%d件", [model.num intValue], [model.r_num intValue]];
    
    NSString *postageText;
    if ([model.postage doubleValue] > 0.0f) {
        postageText = [NSString stringWithFormat:@"邮费%.1f", [model.postage doubleValue]];
    } else {
        postageText = @"包邮";
    }
    
    CGSize size = [postageText boundingRectWithSize:CGSizeMake(100, 20) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:ZOOM(12*3.375)]} context:nil].size;
    self.W_postagePrice.constant = size.width+8;
    self.H_postagePrice.constant = size.height+5;
    self.postagePriceLabel.font = TF_FONT(12*3.375);
    self.postagePriceLabel.text = postageText;
    
    NSString *picSize;
    if (INCHES_5_5) {
        picSize = @"!382";
    } else {
        picSize = @"!280";
    }
    
    if (shopsCount == 1) {
        TFShopModel *model1 = model.shopList[0];
        NSMutableString *code1 = [NSMutableString stringWithString:[NSString stringWithFormat:@"%@",model1.shop_code]];
        NSString *supcode1  = [code1 substringWithRange:NSMakeRange(1, 3)];
        NSString *codestr1 = [NSString stringWithFormat:@"%@/%@",supcode1,code1];
        NSURL *imgUrl1 = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@/%@%@",UPYHTTP,codestr1,model1.four_pic, picSize]];
        __block float d = 0;
        __block BOOL isDownlaod = NO;
        [self.shopImageView sd_setImageWithURL:imgUrl1 placeholderImage:nil options:SDWebImageRetryFailed progress:^(NSInteger receivedSize, NSInteger expectedSize) {
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
        [atStr addAttribute:NSFontAttributeName value:TF_FONT(14*3.374) range:NSMakeRange(0, 1)];
        [atStr addAttribute:NSFontAttributeName value:TF_FONT(18*3.374) range:NSMakeRange(1, price.length-1)];
        self.shopPriceLabel.attributedText = atStr;
        
        if (self.isStock == NO) {
            self.personLabel.text = [NSString stringWithFormat:@"有0人正在抢"];
        } else {
            
            NSString *personText = [NSString stringWithFormat:@"有%d人正在抢", [model1.virtual_sales intValue]];
            
            NSMutableAttributedString *attPersonText = [[NSMutableAttributedString alloc] initWithString:personText];
            [attPersonText addAttribute:NSForegroundColorAttributeName value:COLOR_ROSERED range:NSMakeRange(1, personText.length-5)];
            
            self.personLabel.attributedText = attPersonText;

        }
        
        self.shopOriginalPariceLabel.text = [NSString stringWithFormat:@"¥%.1f", [model1.shop_price doubleValue]];
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
        
        self.postagePriceLabel.textColor = COLOR_ROSERED;
        self.postagePriceLabel.layer.cornerRadius = 3;
        self.postagePriceLabel.layer.borderColor = [COLOR_ROSERED CGColor];
        self.postagePriceLabel.layer.borderWidth = 1;
        
        [self.goShopBtn setBackgroundImage:[self imageWithColor:COLOR_ROSERED] forState:UIControlStateNormal];
//        [self.goShopBtn setBackgroundImage:[self imageWithColor:COLOR_ROSERED] forState:UIControlStateHighlighted];
        self.goShopBtn.layer.masksToBounds = YES;
        self.goShopBtn.layer.cornerRadius = 4;
        
        self.soldOutImageView.hidden = YES;
        
        self.shopBackgroundView.layer.borderColor = [COLOR_ROSERED CGColor];
        self.shopBackgroundView.layer.borderWidth = 1;
        self.shopBackgroundView.backgroundColor = [UIColor whiteColor];
        
    } else {
        self.shopNameLabel.textColor = COLOR_167;
        
        self.shopPriceLabel.textColor = COLOR_167;
        
        self.postagePriceLabel.textColor = COLOR_167;
        self.postagePriceLabel.layer.cornerRadius = 3;
        self.postagePriceLabel.layer.borderColor = [COLOR_167 CGColor];
        self.postagePriceLabel.layer.borderWidth = 1;
        
        [self.goShopBtn setBackgroundImage:[self imageWithColor:COLOR_197] forState:UIControlStateNormal];
        self.goShopBtn.layer.masksToBounds = YES;
        self.goShopBtn.layer.cornerRadius = 4;
        
        self.soldOutImageView.hidden = NO;
        
        self.shopBackgroundView.layer.borderColor = [COLOR_197 CGColor];
        self.shopBackgroundView.layer.borderWidth = 1;
        self.shopBackgroundView.backgroundColor = COLOR_197;
    }
    

    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
