//
//  CartNoEditCollectionViewCell.m
//  FJWaterfallFlow
//
//  Created by ios-1 on 2017/1/16.
//  Copyright © 2017年 fujin. All rights reserved.
//

#import "CartNoEditCollectionViewCell.h"
#import "UIImageView+WebCache.h"
#import "DefaultImgManager.h"
#import "GlobalTool.h"
#import "MyMD5.h"

#define DefaultImg(size) [[DefaultImgManager sharedManager] defaultImgWithSize:(size)]
@implementation CartNoEditCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.shopName.font = [UIFont systemFontOfSize:ZOOM6(30)];
    self.shopName.textColor = RGBCOLOR_I(62, 62, 62);
    
    self.shopNumber.font = [UIFont systemFontOfSize:ZOOM6(30)];
    self.shopNumber.textColor = RGBCOLOR_I(62, 62, 62);
    
    self.colorAndSize.font = [UIFont systemFontOfSize:ZOOM6(24)];
    self.colorAndSize.textColor = RGBCOLOR_I(152, 152, 152);
    
    self.salePrice.font = [UIFont systemFontOfSize:ZOOM6(30)];
    self.salePrice.textColor = RGBCOLOR_I(62, 62, 62);
    
    self.price.font = [UIFont systemFontOfSize:ZOOM6(24)];
    self.price.textColor = RGBCOLOR_I(152, 152, 152);
    
    self.CashbackLab.font = [UIFont systemFontOfSize:ZOOM6(26)];
    self.CashbackLab.textColor = RGBCOLOR_I(62, 62, 62);
    
    self.makelab.font = [UIFont systemFontOfSize:ZOOM6(22)];
    self.makelab.textColor = RGBCOLOR_I(168, 168, 168);
    
    self.line.backgroundColor = RGBCOLOR_I(152, 152, 152);
    
    self.editColorAndSize.font = [UIFont systemFontOfSize:ZOOM6(24)];
    self.editColorAndSize.textColor = RGBCOLOR_I(152, 152, 152);
    
    self.numberLab.textColor =RGBCOLOR_I(62, 62, 62);
    self.numberLab.font = [UIFont systemFontOfSize:ZOOM6(24)];
    self.numberLab.textAlignment = NSTextAlignmentCenter;
    
    self.selectBtn.frame = CGRectMake(self.selectBtn.frame.origin.x, self.selectBtn.frame.origin.y, ZOOM6(40), ZOOM6(40));
}


- (void)refreshData:(ShopDetailModel*)model
{
    self.shopdetailModel = model;
    
    self.shopName.text = model.shop_name;
    self.shopNumber.text = [NSString stringWithFormat:@"x%@",model.shop_num];
    self.colorAndSize.text = [NSString stringWithFormat:@"颜色:%@  尺码:%@",model.shop_color,model.shop_size];
    
    self.salePrice.text = [NSString stringWithFormat:@"￥%.1f",[model.shop_se_price floatValue]];
    CGFloat salepriceW = [self getRowWidth:self.salePrice.text fontSize:ZOOM6(30)];
    self.salePrice.frame = CGRectMake(self.salePrice.frame.origin.x, self.salePrice.frame.origin.y, salepriceW, self.salePrice.frame.size.height);
    
    self.price.text = [NSString stringWithFormat:@"￥%.1f",[model.shop_price floatValue]];
    CGFloat priceW = [self getRowWidth:self.price.text fontSize:ZOOM6(24)];
    self.price.frame = CGRectMake(CGRectGetMaxX(self.salePrice.frame)+10, self.price.frame.origin.y, priceW, self.price.frame.size.height);
    
    NSString *cashstr = [NSString stringWithFormat:@"返%.1f元",[model.shop_se_price floatValue]];
    CGFloat CashbackLabW = [self getRowWidth:cashstr fontSize:ZOOM6(30)];
    self.CashbackLab.frame = CGRectMake(self.salePrice.frame.origin.x+ZOOM6(5), CGRectGetMaxY(self.salePrice.frame), CashbackLabW, self.CashbackLab.frame.size.height);
    self.CashbackLab.text = cashstr;
    
    self.line.frame = CGRectMake(CGRectGetMinX(self.price.frame), self.line.frame.origin.y, priceW, 0.5);
    
    self.linelab.backgroundColor = RGBCOLOR_I(239, 239, 239);
    
    (model.supp_label!=nil && ![model.supp_label isEqualToString:@"(null)"] && ![model.supp_label isEqual:[NSNull null]])?self.makelab.text = [NSString stringWithFormat:@"%@",model.supp_label]:nil;
    
    //是否勾选商品
    self.selectBtn.selected = model.selectShop?YES:NO;
    [self.selectBtn setImage:[UIImage imageNamed:@"icon_nor"] forState:UIControlStateNormal];
    [self.selectBtn setImage:[UIImage imageNamed:@"选中"] forState:UIControlStateSelected];
    
    [self.selectBtn addTarget:self action:@selector(selectShop:) forControlEvents:UIControlEventTouchUpInside];

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
    self.headImage.contentMode = UIViewContentModeScaleAspectFill;
    self.headImage.layer.masksToBounds = YES;
    
    //编辑页面
    self.editColorAndSize.text = [NSString stringWithFormat:@"颜色:%@  尺码:%@",model.shop_color,model.shop_size];
    self.editColorAndSize.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(changeShop)];
    [self.editColorAndSize addGestureRecognizer:tap];
    
    self.numberLab.text = [NSString stringWithFormat:@"%@",model.shop_num];
    self.numberLab.layer.borderWidth = 1;
    self.numberLab.layer.borderColor = lineGreyColor.CGColor;
    
    [self.reduceBtn addTarget:self action:@selector(reduceShop) forControlEvents:UIControlEventTouchUpInside];
    self.reduceBtn.layer.borderWidth = 1;
    self.reduceBtn.layer.borderColor = lineGreyColor.CGColor;
    model.shop_num.intValue >1?[self.reduceBtn setImage:[UIImage imageNamed:@"icon_jian"] forState:UIControlStateNormal]:
    [self.reduceBtn setImage:[UIImage imageNamed:@"icon_jian_disable"] forState:UIControlStateNormal];;

    
    [self.addBtn addTarget:self action:@selector(addShop) forControlEvents:UIControlEventTouchUpInside];
    self.addBtn.layer.borderWidth = 1;
    self.addBtn.layer.borderColor = lineGreyColor.CGColor;

    [self.changeBtn addTarget:self action:@selector(changeShop) forControlEvents:UIControlEventTouchUpInside];

    [self.deleateBtn setTintColor:[UIColor whiteColor]];
    [self.deleateBtn addTarget:self action:@selector(delateShop) forControlEvents:UIControlEventTouchUpInside];
    if(model.selectShop)
    {
        [self.deleateBtn setBackgroundColor:RGBCOLOR_I(237, 70, 56)];
        self.deleateBtn.userInteractionEnabled = YES;
    }else{
        [self.deleateBtn setBackgroundColor:RGBCOLOR_I(197, 197, 197)];
        self.deleateBtn.userInteractionEnabled = NO;
    }
}

//勾选商品
- (void)selectShop:(UIButton*)sender
{
    sender.selected = !sender.selected;
    if(self.selectClick)
    {
        self.selectClick();
    }
}
//删除商品
- (void)delateShop
{
    if(self.delateClick)
    {
        self.delateClick();
    }
}
//减数量
- (void)reduceShop
{
    if(self.shopdetailModel.shop_num.intValue >1)
    {
        self.shopdetailModel.shop_num = [NSString stringWithFormat:@"%d",[self.shopdetailModel.shop_num intValue]-1];
        
        self.numberLab.text = [NSString stringWithFormat:@"%@",self.shopdetailModel.shop_num];
    }
    
    if(self.reduiceClick)
    {
        self.reduiceClick();
    }

    [self.reduceBtn setImage:[UIImage imageNamed:@"icon_jian_disable"] forState:UIControlStateNormal];
}
//加数量
- (void)addShop
{
    self.shopdetailModel.shop_num = [NSString stringWithFormat:@"%d",[self.shopdetailModel.shop_num intValue]+1];
    
    if(self.addClick)
    {
        self.addClick();
    }
    
    if(self.shopdetailModel.shop_num.intValue >2)
    {
        self.shopdetailModel.shop_num = @"2";
    }
    
    self.numberLab.text = [NSString stringWithFormat:@"%@",self.shopdetailModel.shop_num];
    [self.reduceBtn setImage:[UIImage imageNamed:@"icon_jian"] forState:UIControlStateNormal];
}
//修改商品
- (void)changeShop
{
    if(self.changeClick)
    {
        self.changeClick();
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
