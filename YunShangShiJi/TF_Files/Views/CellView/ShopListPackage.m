//
//  ShopListPackage.m
//  YunShangShiJi
//
//  Created by 云商 on 16/5/4.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import "ShopListPackage.h"
#import "TFShopModel.h"
@implementation ShopListPackage

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.packageNameLabel.font = TF_FONT(14*3.375);
    self.packagePriceLabel.font = TF_FONT(18*3.375);
    self.packageOriginalPariceLabel.font = TF_FONT(10*3.375);
    self.shopNumberLabel.font = TF_FONT(9*3.375);
    self.personLabel.font = TF_FONT(10*3.375);
    self.personLabel.textColor = RGBCOLOR_I(168, 168, 168);
    self.H_shopBackground.constant = ZOOM(7*3.375);
    self.W_shopBackground.constant = ZOOM(120*3.375);
    self.H_goShopBtn.constant = ZOOM(25*3.375);
    self.goShopBtn.titleLabel.font = TF_FONT(15*3.375);
    self.S_price.constant = ZOOM(10*3.375);
    
    self.shopSpaceView.backgroundColor = RGBCOLOR_I(240, 240, 240);
    self.shopHeadLine.backgroundColor = RGBCOLOR_I(229, 229, 229);
    self.shopPriceLine.backgroundColor = RGBCOLOR_I(168, 168, 168);
    self.shopNameLabel1.font = TF_FONT(12*3.375);
    self.shopNameLabel2.font = TF_FONT(12*3.375);
    self.shopNameLabel3.font = TF_FONT(12*3.375);
    self.H_shopHeadLine.constant = 0.5;
    self.shopHeadLine.backgroundColor = RGBCOLOR_I(200, 200, 200);
}

- (void)receiveDataModel:(PListModel *)model
{
    self.myModel = model;
    
    NSInteger shopsCount = model.shopList.count;
    
//    MyLog(@"shopList = %@", model.shopList);
    
    if ([model.r_num intValue]>=0 && model.r_num!=nil) {
        if ([model.r_num intValue]> 0) {
            self.isStock = YES;
        } else {
            self.isStock = NO;
        }
    } else {
        self.isStock = NO;
    }
    
    if (model.content!=nil) {
        self.packageNameLabel.text = [NSString stringWithFormat:@"超值%d件套餐：%@", (int)shopsCount, model.content];
    } else {
        self.packageNameLabel.text = [NSString stringWithFormat:@"超值%d件套餐", (int)shopsCount];
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
    
    NSString *price = [NSString stringWithFormat:@"¥%.1f", [model.price doubleValue]];
    NSMutableAttributedString *atStr = [[NSMutableAttributedString alloc] initWithString:price];
    [atStr addAttribute:NSFontAttributeName value:TF_FONT(14*3.374) range:NSMakeRange(0, 1)];
    [atStr addAttribute:NSFontAttributeName value:TF_FONT(18*3.374) range:NSMakeRange(1, price.length-1)];
    self.packagePriceLabel.attributedText = atStr;
    
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
//    self.postagePriceLabel.text = [NSString stringWithFormat:@"邮费%.1f", [model.postage doubleValue]];
    
    NSString *picSize;
    if (INCHES_5_5) {
        picSize = @"!382";
    } else {
        picSize = @"!280";
    }
    
    if (shopsCount >= 2) {
        
        TFShopModel *model1 = model.shopList[0];
        NSMutableString *code1 = [NSMutableString stringWithString:[NSString stringWithFormat:@"%@",model1.shop_code]];
        NSString *supcode1  = [code1 substringWithRange:NSMakeRange(1, 3)];
        NSString *codestr1 = [NSString stringWithFormat:@"%@/%@",supcode1,code1];
        NSURL *imgUrl1 = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@/%@%@",UPYHTTP,codestr1,model1.four_pic, picSize]];
        __block float d = 0;
        __block BOOL isDownlaod = NO;
        [self.packageImageView1 sd_setImageWithURL:imgUrl1 placeholderImage:nil options:SDWebImageRetryFailed progress:^(NSInteger receivedSize, NSInteger expectedSize) {
            d = (float)receivedSize/expectedSize;
            isDownlaod = YES;
//            self.defaultImageView.hidden = NO;
        } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            if (image != nil && isDownlaod == YES) {
                self.packageImageView1.alpha = 0;
//                self.defaultImageView.hidden = YES;
                [UIView animateWithDuration:0.5 animations:^{
                    self.packageImageView1.alpha = 1;
                } completion:^(BOOL finished) {
                    
                }];
            } else if (image != nil && isDownlaod == NO) {
                self.packageImageView1.image = image;
//                self.defaultImageView.hidden = YES;
            }
        }];
        self.shopNameLabel1.text = [NSString stringWithFormat:@"%@", model1.shop_name];
        
        TFShopModel *model2 = model.shopList[1];
        NSMutableString *code2 = [NSMutableString stringWithString:[NSString stringWithFormat:@"%@",model2.shop_code]];
        NSString *supcode2  = [code2 substringWithRange:NSMakeRange(1, 3)];
        NSString *codestr2 = [NSString stringWithFormat:@"%@/%@",supcode2,code2];
        NSURL *imgUrl2 = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@/%@%@",UPYHTTP,codestr2,model2.four_pic, picSize]];
        __block float d2 = 0;
        __block BOOL isDownlaod2 = NO;
        [self.packageImageView2 sd_setImageWithURL:imgUrl2 placeholderImage:nil options:SDWebImageRetryFailed progress:^(NSInteger receivedSize, NSInteger expectedSize) {
            d2 = (float)receivedSize/expectedSize;
            isDownlaod2 = YES;
            //            self.defaultImageView.hidden = NO;
        } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            if (image != nil && isDownlaod == YES) {
                self.packageImageView2.alpha = 0;
                //                self.defaultImageView.hidden = YES;
                [UIView animateWithDuration:0.5 animations:^{
                    self.packageImageView2.alpha = 1;
                } completion:^(BOOL finished) {
                    
                }];
            } else if (image != nil && isDownlaod2 == NO) {
                self.packageImageView2.image = image;
                //                self.defaultImageView.hidden = YES;
            }
        }];
        self.shopNameLabel2.text = [NSString stringWithFormat:@"%@", model2.shop_name];
        
        if (shopsCount == 2) {
            self.addImageView2.hidden = YES;
            self.packageImageView3.hidden = YES;
            self.shopNameView3.hidden = YES;
            
            self.packageOriginalPariceLabel.text = [NSString stringWithFormat:@"¥%.1f", ([model1.shop_price doubleValue]+[model2.shop_price doubleValue])*0.5];
            
            if (self.isStock == NO) {
                self.personLabel.text = [NSString stringWithFormat:@"有0人正在抢"];
            } else {
                
                NSString *personText = [NSString stringWithFormat:@"有%d人正在抢", ([model1.virtual_sales intValue]+[model2.virtual_sales intValue])/2];
                
                NSMutableAttributedString *attPersonText = [[NSMutableAttributedString alloc] initWithString:personText];
                [attPersonText addAttribute:NSForegroundColorAttributeName value:COLOR_ROSERED range:NSMakeRange(1, personText.length-5)];
                
                self.personLabel.attributedText = attPersonText;

            }
        } else if (shopsCount == 3) {
            self.addImageView2.hidden = NO;
            self.packageImageView3.hidden = NO;
            self.shopNameView3.hidden = NO;
            
            TFShopModel *model3 = model.shopList[2];
            NSMutableString *code3 = [NSMutableString stringWithString:[NSString stringWithFormat:@"%@",model3.shop_code]];
            NSString *supcode3  = [code3 substringWithRange:NSMakeRange(1, 3)];
            NSString *codestr3 = [NSString stringWithFormat:@"%@/%@",supcode3,code3];
            NSURL *imgUrl3 = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@/%@%@",UPYHTTP,codestr3,model3.four_pic, picSize]];
            __block float d3 = 0;
            __block BOOL isDownlaod3 = NO;
            [self.packageImageView3 sd_setImageWithURL:imgUrl3 placeholderImage:nil options:SDWebImageRetryFailed progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                d3 = (float)receivedSize/expectedSize;
                isDownlaod3 = YES;
                //            self.defaultImageView.hidden = NO;
            } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                if (image != nil && isDownlaod3 == YES) {
                    self.packageImageView3.alpha = 0;
                    //                self.defaultImageView.hidden = YES;
                    [UIView animateWithDuration:0.5 animations:^{
                        self.packageImageView3.alpha = 1;
                    } completion:^(BOOL finished) {
                        
                    }];
                } else if (image != nil && isDownlaod == NO) {
                    self.packageImageView3.image = image;
                    //                self.defaultImageView.hidden = YES;
                }
            }];
            self.shopNameLabel3.text = [NSString stringWithFormat:@"%@", model3.shop_name];
            self.packageOriginalPariceLabel.text = [NSString stringWithFormat:@"¥%.1f", ([model1.shop_price doubleValue]+[model2.shop_price doubleValue]+[model3.shop_price doubleValue])/3];
            
            if (self.isStock == NO) {
                self.personLabel.text = [NSString stringWithFormat:@"有0人正在抢"];
            } else {
                
                NSString *personText = [NSString stringWithFormat:@"有%d人正在抢", ([model1.virtual_sales intValue]+[model2.virtual_sales intValue]+[model3.virtual_sales intValue])/3];
                
                NSMutableAttributedString *attPersonText = [[NSMutableAttributedString alloc] initWithString:personText];
                [attPersonText addAttribute:NSForegroundColorAttributeName value:COLOR_ROSERED range:NSMakeRange(1, personText.length-5)];
                
                self.personLabel.attributedText = attPersonText;

            }
        }
    }
    [self.goShopBtn addTarget:self action:@selector(goShopBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)setIsStock:(BOOL)isStock
{
    _isStock = isStock;
    
    if (_isStock == YES) {
        self.packageNameLabel.textColor = RGBCOLOR_I(62, 62, 62);
        
        self.packagePriceLabel.textColor = COLOR_ROSERED;
        
        self.postagePriceLabel.textColor = COLOR_ROSERED;
        self.postagePriceLabel.layer.cornerRadius = 3;
        self.postagePriceLabel.layer.borderColor = [COLOR_ROSERED CGColor];
        self.postagePriceLabel.layer.borderWidth = 1;
        
        [self.goShopBtn setBackgroundImage:[self imageWithColor:COLOR_ROSERED] forState:UIControlStateNormal];
//        [self.goShopBtn setBackgroundImage:[self imageWithColor:COLOR_ROSERED] forState:UIControlStateHighlighted];
        self.goShopBtn.layer.masksToBounds = YES;
        self.goShopBtn.layer.cornerRadius = 4;
        
        self.soldOutImageView1.hidden = YES;
        self.soldOutImageView2.hidden = YES;
        self.soldOutImageView3.hidden = YES;
        
        self.shopBackgroundView.layer.borderColor = [COLOR_ROSERED CGColor];
        self.shopBackgroundView.layer.borderWidth = 1;
        self.shopBackgroundView.backgroundColor = [UIColor whiteColor];
        
    } else {
        self.packageNameLabel.textColor = COLOR_167;
        
        self.packagePriceLabel.textColor = COLOR_167;
        
        self.postagePriceLabel.textColor = COLOR_167;
        self.postagePriceLabel.layer.cornerRadius = 3;
        self.postagePriceLabel.layer.borderColor = [COLOR_167 CGColor];
        self.postagePriceLabel.layer.borderWidth = 1;
        
        [self.goShopBtn setBackgroundImage:[self imageWithColor:COLOR_197] forState:UIControlStateNormal];
        self.goShopBtn.layer.masksToBounds = YES;
        self.goShopBtn.layer.cornerRadius = 4;
        
        if (self.myModel.shopList.count == 2) {
            self.soldOutImageView1.hidden = NO;
            self.soldOutImageView2.hidden = NO;
            self.soldOutImageView3.hidden = YES;
        } else {
            self.soldOutImageView1.hidden = NO;
            self.soldOutImageView2.hidden = NO;
            self.soldOutImageView3.hidden = NO;
        }
        
        self.shopBackgroundView.layer.borderColor = [COLOR_197 CGColor];
        self.shopBackgroundView.layer.borderWidth = 1;
        self.shopBackgroundView.backgroundColor = COLOR_197;
    }
    
}

- (void)goShopBtnClick:(UIButton *)sender
{
    if (self.goShopDetailBlock!=nil) {
        self.goShopDetailBlock();
    }
}

- (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
