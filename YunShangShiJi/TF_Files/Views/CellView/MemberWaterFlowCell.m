//
//  MemberWaterFlowCell.m
//  YunShangShiJi
//
//  Created by 云商 on 16/2/27.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import "MemberWaterFlowCell.h"
#import "UIImageView+WebCache.h"
 
@implementation MemberWaterFlowCell

- (void)awakeFromNib {
    // Initialization code
    self.bottomView.backgroundColor = [[UIColor colorWithRed:22/255.0 green:22/255.0 blue:22/255.0 alpha:0.4] colorWithAlphaComponent:0.4];
    
    self.H_bottomView.constant = ZOOM(130);
    self.H_priceLabel.constant = ZOOM(130)*0.5;
    self.H_titleLabel.constant = ZOOM(130)*0.5;
    self.M_bottomView.constant = -self.H_bottomView.constant*0.5;
    
    self.titleLabel.font = [UIFont systemFontOfSize:ZOOM(50)];
    self.priceLabel.font = [UIFont systemFontOfSize:ZOOM(40)];
    
}

- (void)receiveDataModel:(TFShopModel *)model
{
    self.defaultImageView.hidden = NO;
    //    self.shop_pic.alpha = 0;
    self.headImageView.image = nil;
    
    NSMutableString *code = [NSMutableString stringWithString:[NSString stringWithFormat:@"%@",model.shop_code]];
    NSString *supcode  = [code substringWithRange:NSMakeRange(1, 3)];
    
    NSString *pic;
    if(model.shop_pic) {
        pic = [NSString stringWithFormat:@"%@/%@/%@",supcode,model.shop_code,model.shop_pic];
    } else if (model.def_pic) {

        pic = [NSString stringWithFormat:@"%@/%@/%@",supcode,model.shop_code,model.def_pic];
    }
    
    NSString *picSize;
    
    if (kDevice_Is_iPhone6Plus) {
        picSize = @"!382";
    } else {
        picSize = @"!280";
    }
    
    //!280
    NSURL *imgUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@",[NSObject baseURLStr_Upy],pic,picSize]];
    
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
    
    self.titleLabel.text = [NSString stringWithFormat:@"%@", [self exchangeTextWihtString:model.shop_name]];
    self.priceLabel.text = [NSString stringWithFormat:@"¥%.2f",[model.shop_se_price floatValue]];
    
}

- (NSString *)exchangeTextWihtString:(NSString *)text
{
    NSArray *arr = [text componentsSeparatedByString:@"】"];
    NSString *textStr;
    if (arr.count == 2) {
        textStr = [NSString stringWithFormat:@"%@%@】", arr[1], arr[0]];
    }
    return textStr;
}

@end
