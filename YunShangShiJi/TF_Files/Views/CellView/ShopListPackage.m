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
    self.packageNameLabel.font = kFont6px(28);
    self.packagePriceLabel.font = kFont6px(36);
    self.packageOriginalPariceLabel.font = kFont6px(24);
    self.shopNumberLabel.font = kFont6px(22);
    self.personLabel.font = kFont6px(26);
    self.personLabel.textColor = RGBCOLOR_I(125, 125, 125);
    self.H_shopBackground.constant = ZOOM6(14);
    self.W_shopBackground.constant = ZOOM6(280);
    self.H_goShopBtn.constant = ZOOM6(58);
    self.W_addImgV.constant = kZoom6pt(10);
    self.goShopBtn.titleLabel.font = kFont6px(30);
    self.S_price.constant = ZOOM6(18);
    self.shopSpaceView.backgroundColor = RGBCOLOR_I(240, 240, 240);
    self.shopHeadLine.backgroundColor = RGBCOLOR_I(229, 229, 229);
    self.shopPriceLine.backgroundColor = RGBCOLOR_I(168, 168, 168);
    self.shopNameLabel1.font = kFont6px(24);
    self.shopNameLabel2.font = kFont6px(24);
    self.shopNameLabel3.font = kFont6px(24);
    self.H_shopHeadLine.constant = 0.5;
    self.shopBeforeView.layer.masksToBounds = YES;
    self.shopBeforeView.layer.cornerRadius = ZOOM6(2);
    self.shopBackgroundView.layer.masksToBounds = YES;
    self.shopBackgroundView.layer.cornerRadius = ZOOM6(2);
    
    UIColor *color = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    
//    color = [UIColor clearColor];
    self.shopNameView1.backgroundColor = color;
    self.shopNameView2.backgroundColor = color;
    self.shopNameView3.backgroundColor = color;
    self.H_packageName.constant = ZOOM6(60);
}

- (void)receiveDataModel:(PListModel *)model
{
    self.myModel = model;
    
    NSInteger shopsCount = model.shopList.count;
    NSInteger r_num = [model.r_num intValue];
    
    //MyLog(@"add_date: %@", model.add_date);
    //2016/8/26 12:11:29
    
    NSTimeInterval systemTimeInterval = [model.add_date doubleValue]+48*3600*1000;
    //MyLog(@"systemTimeInterval: %f", systemTimeInterval);
    //2016/8/28 12:11:29
    NSTimeInterval currTimeInterval = [NSDate timeIntervalSince1970WithDate];
    //MyLog(@"currTimeInterval: %f", currTimeInterval);
    //2016/8/26 15:45:28
    NSTimeInterval diffTimeInterval = systemTimeInterval - currTimeInterval;
    MyDateFormatterStruct dateStruct = [NSDate dateComponentsWithTimeInterval:diffTimeInterval];
    //MyLog(@"dateStruct: %ld, %ld, %ld, %ld, %ld, %ld", (long)dateStruct.year,(long) dateStruct.month, (long)dateStruct.day, (long)dateStruct.hour, (long)dateStruct.minute, (long)dateStruct.second);
    
    
    if ([model.p_status integerValue] == 0) { // 1.活动状态
        if ([model.r_num intValue]>=0 && model.r_num!=nil) {
            if ([model.r_num intValue]> 0) { // 2. 库存
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
    
    if (model.content!=nil) {
        self.packageNameLabel.text = [NSString stringWithFormat:@"超值%d件套餐：%@", (int)shopsCount, model.content];
    } else {
        self.packageNameLabel.text = [NSString stringWithFormat:@"超值%d件套餐", (int)shopsCount];
    }
    
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
    
    NSString *price = [NSString stringWithFormat:@"¥%.1f", [model.price doubleValue]];
    NSMutableAttributedString *atStr = [[NSMutableAttributedString alloc] initWithString:price];
    [atStr addAttribute:NSFontAttributeName value:kFont6px(32) range:NSMakeRange(0, 1)];
    [atStr addAttribute:NSFontAttributeName value:kFont6px(42) range:NSMakeRange(1, price.length-1)];
    self.packagePriceLabel.attributedText = atStr;
    
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
//    self.postagePriceLabel.text = [NSString stringWithFormat:@"邮费%.1f", [model.postage doubleValue]];
    
    NSString *picSize;
    if (kDevice_Is_iPhone6Plus) {
        picSize = @"!382";
    } else {
        picSize = @"!280";
    }
    
    if (shopsCount >= 2) {
        
        TFShopModel *model1 = model.shopList[0];
        NSMutableString *code1 = [NSMutableString stringWithString:[NSString stringWithFormat:@"%@",model1.shop_code]];
        NSString *supcode1  = [code1 substringWithRange:NSMakeRange(1, 3)];
        NSString *codestr1 = [NSString stringWithFormat:@"%@/%@",supcode1,code1];
        NSURL *imgUrl1 = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@/%@%@",[NSObject baseURLStr_Upy],codestr1,model1.four_pic, picSize]];
        __block float d = 0;
        __block BOOL isDownlaod = NO;
        [self.packageImageView1 sd_setImageWithURL:imgUrl1 placeholderImage:[UIImage imageDefaultWithSize:CGSizeMake(kScreen_Width-kZoom6pt(10)*2-40, kScreen_Width-kZoom6pt(10)*2-40)] options:SDWebImageRetryFailed progress:^(NSInteger receivedSize, NSInteger expectedSize) {
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
        NSURL *imgUrl2 = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@/%@%@",[NSObject baseURLStr_Upy],codestr2,model2.four_pic, picSize]];
        __block float d2 = 0;
        __block BOOL isDownlaod2 = NO;
        [self.packageImageView2 sd_setImageWithURL:imgUrl2 placeholderImage:[UIImage imageDefaultWithSize:CGSizeMake(kScreen_Width-kZoom6pt(10)*2-40, kScreen_Width-kZoom6pt(10)*2-40)] options:SDWebImageRetryFailed progress:^(NSInteger receivedSize, NSInteger expectedSize) {
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
            
            
        } else if (shopsCount == 3) {
            self.addImageView2.hidden = NO;
            self.packageImageView3.hidden = NO;
            self.shopNameView3.hidden = NO;
            
            TFShopModel *model3 = model.shopList[2];
            NSMutableString *code3 = [NSMutableString stringWithString:[NSString stringWithFormat:@"%@",model3.shop_code]];
            NSString *supcode3  = [code3 substringWithRange:NSMakeRange(1, 3)];
            NSString *codestr3 = [NSString stringWithFormat:@"%@/%@",supcode3,code3];
            NSURL *imgUrl3 = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@/%@%@",[NSObject baseURLStr_Upy],codestr3,model3.four_pic, picSize]];
            
            
            __block float d3 = 0;
            __block BOOL isDownlaod3 = NO;
            [self.packageImageView3 sd_setImageWithURL:imgUrl3 placeholderImage:[UIImage imageDefaultWithSize:CGSizeMake(kScreen_Width-kZoom6pt(10)*2-40, kScreen_Width-kZoom6pt(10)*2-40)] options:SDWebImageRetryFailed progress:^(NSInteger receivedSize, NSInteger expectedSize) {
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
            
        }
    }
    if (self.isStock == NO) {
        self.personLabel.text = [NSString stringWithFormat:@"有0人正在抢"];
    } else {
        
        NSString *personText = [NSString stringWithFormat:@"有%ld人正在抢", (long)[model.virtual_sales integerValue]];
        NSMutableAttributedString *attPersonText = [[NSMutableAttributedString alloc] initWithString:personText];
        [attPersonText addAttribute:NSForegroundColorAttributeName value:COLOR_ROSERED range:NSMakeRange(1, personText.length-5)];
        
        self.personLabel.attributedText = attPersonText;
        
    }

    [self.goShopBtn addTarget:self action:@selector(goShopBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)setIsStock:(BOOL)isStock
{
    _isStock = isStock;
    
    if (_isStock == YES) {
        self.packageNameLabel.textColor = RGBCOLOR_I(62, 62, 62);
        
        self.packagePriceLabel.textColor = COLOR_ROSERED;
        self.packageOriginalPariceLabel.textColor = RGBCOLOR_I(168, 168, 168);
        self.shopPriceLine.backgroundColor = RGBCOLOR_I(168, 168, 168);
        self.postagePriceLabel.textColor = COLOR_ROSERED;
        self.postagePriceLabel.layer.cornerRadius = 3;
        self.postagePriceLabel.layer.borderColor = [COLOR_ROSERED CGColor];
        self.postagePriceLabel.layer.borderWidth = 1;
        
        [self.goShopBtn setBackgroundImage:[UIImage imageWithColor:COLOR_ROSERED] forState:UIControlStateNormal];
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
        self.packageNameLabel.textColor = RGBCOLOR_I(197, 197, 197);
        self.packageOriginalPariceLabel.textColor = RGBCOLOR_I(197, 197, 197);
        self.shopPriceLine.backgroundColor = RGBCOLOR_I(197, 197, 197);
        self.packagePriceLabel.textColor = RGBCOLOR_I(197, 197, 197);
        self.personLabel.textColor =  RGBCOLOR_I(197, 197, 197);
        
        self.postagePriceLabel.textColor = RGBCOLOR_I(197, 197, 197);
        self.postagePriceLabel.layer.cornerRadius = 3;
        self.postagePriceLabel.layer.borderColor = [RGBCOLOR_I(197, 197, 197) CGColor];
        self.postagePriceLabel.layer.borderWidth = 1;
        
        [self.goShopBtn setBackgroundImage:[UIImage imageWithColor:RGBCOLOR_I(197,197,197)] forState:UIControlStateNormal];
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
        
        self.shopBackgroundView.layer.borderColor = [RGBCOLOR_I(197,197,197) CGColor];
        self.shopBackgroundView.layer.borderWidth = 1;
        self.shopBackgroundView.backgroundColor = RGBCOLOR_I(197,197,197);
    }
    
}

- (void)goShopBtnClick:(UIButton *)sender
{
    if (self.goShopDetailBlock!=nil) {
        self.goShopDetailBlock();
    }
}

+ (CGFloat)cellHeight
{
    CGFloat f = (kScreenWidth-375)/3; // 图片增加的
    f = f > 0?ceil(f) : floor(f);
    CGFloat f2 = (ZOOM6(60)-30); // H_packageName 增加的
    f2 = f2 > 0?ceil(f2): floor(f2);
//            -(375-40-kZoom6pt(10)*2)/3;
    return 240+(f)+(f2);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
