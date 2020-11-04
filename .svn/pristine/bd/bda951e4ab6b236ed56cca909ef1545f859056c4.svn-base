//
//  BigImageCollectionViewCell.m
//  TestStickHeader
//
//  Created by ios-1 on 2017/2/15.
//  Copyright © 2017年 liqi. All rights reserved.
//

#import "BigImageCollectionViewCell.h"
#import "UIImageView+WebCache.h"
#import "UIView+ZYTagView.h"
#import "DefaultImgManager.h"
#import "GlobalTool.h"
#import "MyMD5.h"

#define DefaultImg(size) [[DefaultImgManager sharedManager] defaultImgWithSize:(size)]
@implementation BigImageCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.name.frame = CGRectMake(ZOOM6(20), self.name.frame.origin.y,self.name.frame.size.width, self.name.frame.size.height);
    self.name.textColor = [UIColor whiteColor];
    self.name.font = [UIFont systemFontOfSize:ZOOM6(30)];
    
    self.gobuy.backgroundColor = tarbarrossred;
    [self.gobuy setTitle:@"立即购买" forState:UIControlStateNormal];
    [self.gobuy setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.gobuy.layer.cornerRadius = 5;
    
    self.bigImage.contentMode = UIViewContentModeScaleAspectFill;
}
- (void)dealloc
{
    NSLog(@"释放了");
}
- (void)refreshData:(TdetailsModel*)model Index:(NSInteger)index;
{
    self.detailModel = model;
    
    NSURL *imgUrl;
    NSString *title;
    NSString *se_price;
    NSString *price;
    
    self.mengceng.hidden= self.seprice.hidden = self.price.hidden = self.name.hidden = self.gobuy.hidden = self.linelab.hidden = model.theme_type==1?NO:YES;
    
    NSString *st;
    if (kDevice_Is_iPhone6Plus) {
        st = @"!450";
    } else {
        st = @"!382";
    }

    if(model.theme_type==1)
    {
        
        TShoplistModel *shopmodel = model.shop_list[index];
        self.model = shopmodel;
        
        NSMutableString *code = [NSMutableString stringWithString:shopmodel.shop_code];
        
        NSString *supcode  = [code substringWithRange:NSMakeRange(1, 3)];
        MyLog(@"supcode =%@",supcode);
        
        NSString *imagestr = [NSString stringWithFormat:@"%@/%@/%@",supcode,shopmodel.shop_code,shopmodel.def_pic];
        
        imgUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@",[NSObject baseURLStr_Upy],imagestr,st]];
        title = [NSString stringWithFormat:@"%@",shopmodel.shop_name];

        if(title.length>12)
        {
            NSString *newstr = [title substringToIndex:12];
            title = [NSString stringWithFormat:@"...%@",newstr];
        }
        se_price = [NSString stringWithFormat:@"￥%.1f",[shopmodel.shop_se_price floatValue]];
        price = [NSString stringWithFormat:@"￥%.1f",[shopmodel.shop_price floatValue]];
        if(shopmodel.shop_status == 1)
        {
            self.gobuy.userInteractionEnabled = NO;
            self.gobuy.backgroundColor = RGBCOLOR_I(169, 169, 169);
        }else{
            self.gobuy.userInteractionEnabled = YES;
            self.gobuy.backgroundColor = tarbarrossred;
        }
        
    }else{

        NSArray *pic = [model.pics componentsSeparatedByString:@","];
        NSArray *picurl = [pic[index] componentsSeparatedByString:@":"];
        if(picurl.count)
        {
            imgUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@/myq/theme/%@/%@%@",[NSObject baseURLStr_Upy],model.user_id,picurl[0],st]];
        }
    }
    
    __block float d = 0;
    __block BOOL isDownlaod = NO;
   
    kSelfWeak;
    [self.bigImage sd_setImageWithURL:imgUrl placeholderImage:DefaultImg(self.bigImage.bounds.size) options:SDWebImageRetryFailed progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        d = (float)receivedSize/expectedSize;
        isDownlaod = YES;
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (image != nil && isDownlaod == YES) {
            weakSelf.bigImage.alpha = 0;
            [UIView animateWithDuration:0.5 animations:^{
                weakSelf.bigImage.alpha = 1;
            } completion:^(BOOL finished) {
            }];
        } else if (image != nil && isDownlaod == NO) {
            weakSelf.bigImage.image = image;
        }
    }];
    
    self.name.text = title;
    self.seprice.text = se_price;
    self.price.text = price;
    
    CGFloat salepriceW = [self getRowWidth:self.seprice.text fontSize:ZOOM6(30)];
    self.seprice.frame = CGRectMake(ZOOM6(20), self.seprice.frame.origin.y,salepriceW, self.seprice.frame.size.height);
    self.seprice.textColor = [UIColor whiteColor];
    self.seprice.font = [UIFont systemFontOfSize:ZOOM6(30)];
    
    CGFloat priceW = [self getRowWidth:self.price.text fontSize:ZOOM6(24)];
    self.price.frame = CGRectMake(CGRectGetMaxX(self.seprice.frame)+ZOOM6(20), self.price.frame.origin.y,priceW, self.price.frame.size.height);
    self.price.textColor = [UIColor whiteColor];
    self.price.textAlignment = NSTextAlignmentLeft;
    self.price.font = [UIFont systemFontOfSize:ZOOM6(24)];
    
    self.linelab.frame = CGRectMake(self.price.frame.origin.x+3,self.linelab.frame.origin.y, CGRectGetWidth(self.price.frame), 1);
    self.linelab.backgroundColor = [UIColor whiteColor];
    [self bringSubviewToFront:self.linelab];
    
    [self.gobuy addTarget:self action:@selector(gotobuy) forControlEvents:UIControlEventTouchUpInside];
}


//购买
- (void)gotobuy
{
    if(self.gotoBuyBlock)
    {
        self.gotoBuyBlock(self.model.shop_code);
    }
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

@end
