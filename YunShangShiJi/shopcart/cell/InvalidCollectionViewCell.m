//
//  InvalidCollectionViewCell.m
//  YunShangShiJi
//
//  Created by ios-1 on 2017/1/17.
//  Copyright © 2017年 ios-1. All rights reserved.
//

#import "InvalidCollectionViewCell.h"
#import "UIImageView+WebCache.h"
#import "DefaultImgManager.h"
#import "GlobalTool.h"
#import "MyMD5.h"

#define DefaultImg(size) [[DefaultImgManager sharedManager] defaultImgWithSize:(size)]
@implementation InvalidCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.shopName.font = [UIFont systemFontOfSize:ZOOM6(30)];
    self.shopName.textColor = RGBCOLOR_I(62, 62, 62);
    
    self.colorandsize.font = [UIFont systemFontOfSize:ZOOM6(24)];
    self.colorandsize.textColor = RGBCOLOR_I(152, 152, 152);
    
    self.saleprice.font = [UIFont systemFontOfSize:ZOOM6(30)];
    self.saleprice.textColor = RGBCOLOR_I(62, 62, 62);
    
    self.price.font = [UIFont systemFontOfSize:ZOOM6(24)];
    self.price.textColor = RGBCOLOR_I(152, 152, 152);
    
    self.line.backgroundColor = RGBCOLOR_I(152, 152, 152);
}
- (void)refreshData:(ShopDetailModel*)model
{
    self.shopName.text = model.shop_name;
    self.colorandsize.text = [NSString stringWithFormat:@"颜色:%@  尺码:%@",model.shop_color,model.shop_size];
    self.saleprice.text = [NSString stringWithFormat:@"￥%.1f",[model.shop_se_price floatValue]];
    CGFloat salepriceW = [self getRowWidth:self.saleprice.text fontSize:ZOOM6(30)];
    self.saleprice.frame = CGRectMake(self.saleprice.frame.origin.x, self.saleprice.frame.origin.y, salepriceW, self.saleprice.frame.size.height);
    
    self.price.text = [NSString stringWithFormat:@"￥%.1f",[model.shop_price floatValue]];
    CGFloat priceW = [self getRowWidth:self.price.text fontSize:ZOOM6(24)];
    self.price.frame = CGRectMake(CGRectGetMaxX(self.saleprice.frame)+10, self.price.frame.origin.y, priceW, self.price.frame.size.height);
    
    self.line.frame = CGRectMake(CGRectGetMinX(self.price.frame), self.line.frame.origin.y, priceW, 0.5);

    [self.closeBtn setImage:[UIImage imageNamed:@"icon_close"] forState:UIControlStateNormal];
    [self.closeBtn addTarget:self action:@selector(deleateShop) forControlEvents:UIControlEventTouchUpInside];
    self.overheaderImage.image = [UIImage imageNamed:@"sold-out@2x-min"];
    self.overheaderImage.hidden =!(model.isGray.intValue||model.is_del.intValue);
    
    NSURL *imgUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@/%@/%@!180",[NSObject baseURLStr_Upy],[MyMD5 pictureString:model.shop_code],model.def_pic]];
    
    __block float d = 0;
    __block BOOL isDownlaod = NO;
    [self.headImage sd_setImageWithURL:imgUrl placeholderImage:DefaultImg(self.headImage.bounds.size) options:SDWebImageRetryFailed progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        d = (float)receivedSize/expectedSize;
        isDownlaod = YES;
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (image != nil && isDownlaod == YES) {
            self.headImage.alpha = 0;
            [UIView animateWithDuration:0.5 animations:^{
                self.headImage.alpha = 1;
            } completion:^(BOOL finished) {
            }];
        } else if (image != nil && isDownlaod == NO) {
            self.headImage.image = image;
        }
    }];

}

-(CGFloat)getRowWidth:(NSString *)text fontSize:(CGFloat)fontSize
{
    //文字高度
    CGFloat width;
    if([[[UIDevice currentDevice]systemVersion] floatValue]>=7.0){
        
        CGRect rect=[text boundingRectWithSize:CGSizeMake(kScreenWidth, 10000) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:fontSize] forKey:NSFontAttributeName] context:nil];
        
        width=rect.size.width;
        
    }
    else{
        
    }
    
    return width;
}

- (void)deleateShop
{
    if(self.delateClick)
    {
        self.delateClick();
    }
}
@end
