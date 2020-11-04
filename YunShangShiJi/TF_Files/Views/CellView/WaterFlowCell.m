//
//  WaterFlowCell.m
//  YunShangShiJi
//
//  Created by 云商 on 15/8/5.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//

#import "WaterFlowCell.h"
#import "UIImageView+WebCache.h"
#import "CALayer+TFCommon.h"
#import "UIImageView+TFCommon.h"
#import "SqliteManager.h"
#import "ShopDetailViewModel.h"
@interface WaterFlowCell ()

@property (nonatomic , strong)CALayer *frameLayer;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *H_BottomPriceConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *B_BottomPriceConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *W_NewRePiriceConstraint;
@property (nonatomic , strong)ShopDetailViewModel *viewmodel;
@end

@implementation WaterFlowCell

- (void)awakeFromNib {
    // Initialization code
    
    [super awakeFromNib];
    self.viewmodel = [ShopDetailViewModel alloc];
    
    self.shop_kicback_new.font = kFont6pt(11);
    self.shop_name_new.font = kFont6pt(12);
    self.shop_price_new.font = [UIFont fontWithName:@"Helvetica-Bold" size:ZOOM6(28)];
    self.shop_old_price.font = kFont6pt(9);
    self.H_bottomView_new.constant = kZoom6pt(45);
    self.S_shop_name.constant = kZoom6pt(5);
    self.S_shop_price.constant = kZoom6pt(6);
    self.Y_defaultImageView.constant = kZoom6pt(45)*0.5;
    self.H_BottomPriceConstraint.constant = kZoom6pt(15);
    self.B_BottomPriceConstraint.constant = kZoom6pt(6);
    
    self.shop_name_new.backgroundColor = kWiteColor;
    self.shop_name_new.textColor = RGBCOLOR_I(125, 125, 125);
    
    //何波加的 2016-10-8
    self.ManufacturerLable.font = [UIFont systemFontOfSize:ZOOM6(24)];
    self.ManufacturerLable.backgroundColor = [UIColor colorWithWhite:0 alpha:0.4];
    self.ManufacturerLable.alpha = 0.8;
    self.ManufacturerLable.clipsToBounds = YES;
    self.ManufacturerLable.hidden = NO;
    self.ManufacturerLable.layer.cornerRadius = 10;
    self.ManufacturerLable.textColor = [UIColor whiteColor];
    
    /**< 活动商品 */
    self.shopSaleLabel.font = kFont6px(26);
    self.saleNumbelLabel.font = kFont6px(22);
    self.shopReductionLabel.font = kFont6px(20);
    self.reduce_Price_new.font = kFont6px(22);
    
    self.W_shopSaleImageV.constant = ZOOM6(70);
    self.W_saleNumbelLabel.constant = ZOOM6(120);
    self.W_reductionLabel.constant = ZOOM6(120);
    self.W_NewRePiriceConstraint.constant = ZOOM6(200);
    
    self.bottomPrice.font=[UIFont systemFontOfSize:ZOOM6(24)];
    self.bottomPrice.textColor= RGBCOLOR_I(62, 62, 62);
    self.reduce_Price_new.textColor= RGBCOLOR_I(168, 168, 168);
    
    self.diyongImageV.hidden = YES;
    self.priceImageV.hidden = YES;
    self.shop_kicback_new.hidden = YES;
    
    self.shopSaleLabel.hidden = YES;
    self.saleNumbelLabel.hidden = YES;
    self.shopSaleImageV.hidden = YES;
    
}

- (void)receiveDataModel:(ShopDetailModel *)model
{
    self.H_bottomView_new.constant = kZoom6pt(45)+self.H_BottomPriceConstraint.constant;
    self.S_shop_price.constant = kZoom6pt(6)+self.H_BottomPriceConstraint.constant;
//    self.bottomPrice.text=[NSString stringWithFormat:@"专柜价￥%.1f",[model.shop_price floatValue]];
//    self.reduce_Price_new.text = [NSString stringWithFormat:@"立省%.1f元", [model.shop_price doubleValue] - [model.shop_se_price doubleValue]];
//    self.bottomPrice.text= [NSString stringWithFormat:@"返￥%.1f元=0元",[model.shop_se_price floatValue]*0.9];
    self.bottomPrice.text= [NSString stringWithFormat:@"  %@", model.supp_label];
    if(![model.supp_label isEqual:[NSNull null]] && model.supp_label.length >0)
    {
        self.bottomPrice.hidden = NO;
    }else{
        self.bottomPrice.hidden = YES;
    }
    
    if ([DataManager sharedManager].is_OneYuan)
    {

        if(model.virtual_sales.floatValue >0)
        {
            self.reduce_Price_new.text = [NSString stringWithFormat:@"月销%@件", model.virtual_sales];
        }else{
            self.reduce_Price_new.text=[NSString stringWithFormat:@"原价￥%.1f",[model.shop_se_price floatValue]];
            
            if(model.app_shop_group_price == nil)
            {
                self.reduce_Price_new.text=[NSString stringWithFormat:@"原价￥%.1f",[model.shop_price floatValue]];
            }
        }
    }
    else{
        self.reduce_Price_new.text=[NSString stringWithFormat:@"原价￥%.1f",[model.shop_price floatValue]];
    }
    
    self.defaultImageView.hidden = NO;
    self.shop_pic.image = nil;
    
    NSMutableString *code = [NSMutableString stringWithString:[NSString stringWithFormat:@"%@",model.shop_code]];
    NSString *supcode  = [code substringWithRange:NSMakeRange(1, 3)];

    NSString *pic;
    if(model.shop_pic) {
        pic = [NSString stringWithFormat:@"%@/%@/%@",supcode,model.shop_code,model.shop_pic];
        
    } else if (model.def_pic) {
        if(model.isTM.integerValue == 1)
        {
            pic = [NSString stringWithFormat:@"%@",model.def_pic];
        }else{
            pic = [NSString stringWithFormat:@"%@/%@/%@",supcode,model.shop_code,model.def_pic];
        }
    }
    
    NSString *picSize;
    
    if (kDevice_Is_iPhone6Plus) {
        picSize = @"!382";
    } else {
        picSize = @"!280";
    }
    
    //!280
    NSURL *imgUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@",[NSObject baseURLStr_Upy],pic,picSize]];
    self.shop_pic.contentMode = UIViewContentModeScaleAspectFit;
    [self.shop_pic setImageWithURL:imgUrl placeholderImage:nil progress:^(float downloaderProgress) {
        self.defaultImageView.hidden = NO;
    } completed:^{
        self.defaultImageView.hidden = YES;
    }];
    
    self.shop_name_new.text = [self exchangeTextWihtString:model.shop_name];
    
    //新价格计算方式
    self.shop_price_new.text = [NSString stringWithFormat:@"￥%.1f",[model.shop_se_price floatValue]];
    
    if([DataManager sharedManager].is_OneYuan)
    {
        self.shop_price_new.text = [NSString stringWithFormat:@"￥%.1f",model.app_shop_group_price == nil?[model.shop_se_price floatValue]:model.app_shop_group_price.floatValue];
        if(model.isVip.integerValue == 1)
        {
            CGFloat price = [self.viewmodel get_discount_price:[model.shop_se_price floatValue] DiscountMoney:model.reduceMoney MaxViptype:model.maxType Shop_deduction:model.shop_deduction.floatValue];
            self.shop_price_new.text = [NSString stringWithFormat:@"￥%.1f",price];
        }
    }else{
        self.shop_price_new.text = [NSString stringWithFormat:@"￥%.1f",[model.shop_se_price floatValue]];
    }
    
    self.shop_old_price.text = [NSString stringWithFormat:@"¥%.1f", [model.shop_price doubleValue]];
    
    NSString *kicbackText;
    if (kUnNilAndNULL(model.kickback)) {
        kicbackText = [NSString stringWithFormat:@"%d元",[model.kickback intValue]*1];
    } else {
        kicbackText = [NSString stringWithFormat:@"%d元",0];
    }
    CGSize size = [kicbackText boundingRectWithSize:CGSizeMake(100, 20) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:kZoom6pt(11)]} context:nil].size;
    self.W_shopKicback.constant = size.width+10;
    self.H_shopKicback.constant = size.height+2;
    self.shop_kicback_new.text = kicbackText;
    
    UIImage *priceImage = [UIImage imageNamed:@"biankuang"];
    priceImage = [priceImage  stretchableImageWithLeftCapWidth:priceImage.size.width*0.5  topCapHeight:priceImage.size.height*0.5];
    self.priceImageV.image = priceImage;
    
    //何波加的 2016-10-8
    self.ManufacturerLable.text = [NSString stringWithFormat:@"%@",model.supp_label];
    CGFloat width = [self getRowWidth:self.ManufacturerLable.text fontSize:ZOOM6(24)]+20;
//    self.ManufacturerLable.frame = CGRectMake((kScreenWidth/2-5-width)/2, self.ManufacturerLable.frame.origin.y, width, self.ManufacturerLable.frame.size.height);
    self.W_BrandLabel.constant=width+5;

    if(![model.supp_label isEqual:[NSNull null]] && model.supp_label.length >0)
    {
        self.ManufacturerLable.hidden = NO;
    }else{
        self.ManufacturerLable.hidden = YES;
    }
    
}

- (void)receiveDataModel2:(TFShoppingM *)model
{
    if(model.supp_label_id !=nil && model.supp_label == nil)
    {
        SqliteManager *manager = [SqliteManager sharedManager];
        NSString *supp_label_id = [NSString stringWithFormat:@"%@", model.supp_label_id];
        model.supp_label = [NSString stringWithFormat:@"%@",[manager getSuppLabelItemForId:supp_label_id].class_name];
    }
    
    [self setupUI:model];
}

- (void)receiveDataModel3:(TFShoppingM *)model
{
    [self setupUI:model];
//    self.bottoView_HeightConstraint.constant=45;
//    self.shopPrice_BottomConstraint.constant=0;
    self.H_bottomView_new.constant = kZoom6pt(45);
    self.S_shop_price.constant = kZoom6pt(6);
    self.bottomPrice.hidden=YES;
    
    // 活动商品

//    self.diyongImageV.hidden = YES;
//    self.priceImageV.hidden = YES;
//    self.shop_kicback_new.hidden = YES;
//    self.reduce_Price_new.hidden=YES;
//    self.shopReductionLabel.hidden = NO;
    
    /**< 设置数据 */
    self.shopSaleLabel.hidden = YES;
    self.saleNumbelLabel.hidden = YES;
    self.shopSaleImageV.hidden = YES;
    
    self.shopSaleLabel.text = [NSString stringWithFormat:@"%.1f折", ([model.shop_se_price doubleValue]/ [model.shop_price doubleValue])*10];
    self.saleNumbelLabel.text = [NSString stringWithFormat:@"已售%@", model.virtual_sales];
    self.ManufacturerLable.hidden = model.supp_label.length ==0 ?:NO;
    self.ManufacturerLable.text = [NSString stringWithFormat:@"%@", model.supp_label];
    self.shopReductionLabel.text = [NSString stringWithFormat:@"立省%.1f", [model.shop_price doubleValue] - [model.shop_se_price doubleValue]];
    
}

- (void)receiveDataModel4:(TFShoppingM *)model {
    [self setupUI:model];
}

- (void)receiveDataModel5:(TFShoppingM *)model;
{
    [self setupUI:model];
    
    //    self.shopPrice_BottomConstraint.constant=0;
    self.H_bottomView_new.constant = kZoom6pt(45)+self.H_BottomPriceConstraint.constant;
    self.S_shop_price.constant = kZoom6pt(6)+self.H_BottomPriceConstraint.constant;;
    self.bottomPrice.hidden=NO;
    
    // 活动商品
    self.shopSaleImageV.hidden = YES;
    self.saleNumbelLabel.hidden = YES;
    self.shopSaleLabel.hidden = YES;
    
    //    self.diyongImageV.hidden = YES;
    //    self.priceImageV.hidden = YES;
    //    self.shop_kicback_new.hidden = YES;
    self.reduce_Price_new.hidden=YES;
    self.shopReductionLabel.hidden = NO;
    
//    self.bottomPrice.text= [NSString stringWithFormat:@"返￥%.1f元=0元",[model.shop_se_price floatValue]];
    self.bottomPrice.text= [NSString stringWithFormat:@"  %@", model.supp_label];
    if(![model.supp_label isEqual:[NSNull null]] && model.supp_label.length >0)
    {
        self.bottomPrice.hidden = NO;
    }else{
        self.bottomPrice.hidden = YES;
    }
    /**< 设置数据 */
    
    if([DataManager sharedManager].is_OneYuan)
    {
        self.shop_price_new.text = [NSString stringWithFormat:@"￥%.1f",model.app_shop_group_price.floatValue];
        
        if(model.isVip.integerValue == 1)
        {
            CGFloat price = [self.viewmodel get_discount_price:[model.shop_se_price floatValue] DiscountMoney:model.reduceMoney MaxViptype:model.maxType Shop_deduction:model.shop_deduction.floatValue];
            self.shop_price_new.text = [NSString stringWithFormat:@"￥%.1f",price];
        }
    }else{
        self.shop_price_new.text = [NSString stringWithFormat:@"￥%.1f",[model.shop_se_price floatValue]];
    }
    
    self.shopSaleLabel.text = [NSString stringWithFormat:@"%.1f折", ([model.shop_se_price doubleValue]/ [model.shop_price doubleValue])*10];
    self.saleNumbelLabel.text = [NSString stringWithFormat:@"已售%@", model.virtual_sales];
    self.ManufacturerLable.hidden = model.supp_label.length ==0 ?:NO;
    self.ManufacturerLable.text = [NSString stringWithFormat:@"%@", model.supp_label];
    self.shopReductionLabel.text = [NSString stringWithFormat:@"拼团价%.2f", [ model.roll_price doubleValue]];
    
    //拼团商品是否勾选
    if(model.isSelect)
    {
        self.sharebtn.hidden = NO;
    }else{
        self.sharebtn.hidden = YES;
    }
    CGFloat imageWith = ZOOM6(60);
    self.sharebtn.frame = CGRectMake((CGRectGetWidth(self.shop_pic.frame)-imageWith)/2,(CGRectGetHeight(self.shop_pic.frame)-imageWith)/2-self.H_bottomView_new.constant/2, imageWith, imageWith);
    self.sharebtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.sharebtn addTarget:self action:@selector(shareclick:) forControlEvents:UIControlEventTouchUpInside];
        self.sharebtn.selected = model.isSelect;
    [self.sharebtn setImage:[UIImage imageNamed:@"wodexihao_fengge_icon_weixuanzhong"] forState:UIControlStateNormal];
    [self.sharebtn setImage:[UIImage imageNamed:@"fight_icon_cel"] forState:UIControlStateSelected];
}
- (void)receiveDataModel6:(TFShoppingM *)model;
{
    [self setupUI:model];

    //    self.shopPrice_BottomConstraint.constant=0;
    self.H_bottomView_new.constant = kZoom6pt(45)+self.H_BottomPriceConstraint.constant;
    self.S_shop_price.constant = kZoom6pt(6)+self.H_BottomPriceConstraint.constant;;
    self.bottomPrice.hidden=NO;

    // 活动商品
    self.shopSaleImageV.hidden = YES;
    self.saleNumbelLabel.hidden = YES;
    self.shopSaleLabel.hidden = YES;

    //    self.diyongImageV.hidden = YES;
    //    self.priceImageV.hidden = YES;
    //    self.shop_kicback_new.hidden = YES;
//    self.reduce_Price_new.hidden=YES;
//    self.shopReductionLabel.hidden = NO;

    /**< 设置数据 */
    self.shopSaleLabel.text = [NSString stringWithFormat:@"%.1f折", ([model.shop_se_price doubleValue]/ [model.shop_price doubleValue])*10];
    self.saleNumbelLabel.text = [NSString stringWithFormat:@"已售%@", model.virtual_sales];
    self.ManufacturerLable.hidden = model.supp_label.length ==0 ?:NO;
    self.ManufacturerLable.text = [NSString stringWithFormat:@"%@", model.supp_label];
//    self.shopReductionLabel.text = [NSString stringWithFormat:@"拼团价%.2f", [ model.roll_price doubleValue]];
    self.shopReductionLabel.text = [NSString stringWithFormat:@"立省%.1f元", [model.shop_price doubleValue] - [model.shop_se_price doubleValue]];
//    self.reduce_Price_new.text = [NSString stringWithFormat:@"立省%.1f元", [model.shop_price doubleValue] - [model.shop_se_price doubleValue]];


    //拼团商品是否勾选
    if(model.isSelect)
    {
        self.sharebtn.hidden = NO;
    }else{
        self.sharebtn.hidden = YES;
    }
    CGFloat imageWith = ZOOM6(60);
    self.sharebtn.frame = CGRectMake((CGRectGetWidth(self.shop_pic.frame)-imageWith)/2,(CGRectGetHeight(self.shop_pic.frame)-imageWith)/2-self.H_bottomView_new.constant/2, imageWith, imageWith);
    self.sharebtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.sharebtn addTarget:self action:@selector(shareclick:) forControlEvents:UIControlEventTouchUpInside];
    self.sharebtn.selected = model.isSelect;
    [self.sharebtn setImage:[UIImage imageNamed:@"wodexihao_fengge_icon_weixuanzhong"] forState:UIControlStateNormal];
    [self.sharebtn setImage:[UIImage imageNamed:@"fight_icon_cel"] forState:UIControlStateSelected];
}

- (void)receiveDataModel7:(TFShoppingM *)model;
{
    [self setupUI:model];
    
    //    self.shopPrice_BottomConstraint.constant=0;
    self.H_bottomView_new.constant = kZoom6pt(45)+self.H_BottomPriceConstraint.constant;
    self.S_shop_price.constant = kZoom6pt(6)+self.H_BottomPriceConstraint.constant;;
    self.bottomPrice.hidden=NO;
    
    // 活动商品
    self.shopSaleImageV.hidden = YES;
    self.saleNumbelLabel.hidden = YES;
    self.shopSaleLabel.hidden = YES;
    
    //    self.diyongImageV.hidden = YES;
    //    self.priceImageV.hidden = YES;
    //    self.shop_kicback_new.hidden = YES;
//    self.reduce_Price_new.hidden=YES;
//    self.shopReductionLabel.hidden = NO;
//    self.bottomPrice.text=[NSString stringWithFormat:@"专柜价￥%.1f",[model.shop_price floatValue]];

//    self.bottomPrice.text= [NSString stringWithFormat:@"返￥%.1f元=0元",[model.shop_se_price floatValue]];
    
    self.bottomPrice.text= [NSString stringWithFormat:@"  %@", model.supp_label];
    if(![model.supp_label isEqual:[NSNull null]] && model.supp_label.length >0)
    {
        self.bottomPrice.hidden = NO;
    }else{
        self.bottomPrice.hidden = YES;
    }

    /**< 设置数据 */
    if([DataManager sharedManager].is_OneYuan)
    {
        self.shop_price_new.text = [NSString stringWithFormat:@"￥%.1f",model.app_shop_group_price.floatValue];
        if(model.isVip.integerValue == 1)
        {
            CGFloat price = [self.viewmodel get_discount_price:[model.shop_se_price floatValue] DiscountMoney:model.reduceMoney MaxViptype:model.maxType Shop_deduction:model.shop_deduction.floatValue];
            self.shop_price_new.text = [NSString stringWithFormat:@"￥%.1f",price];
        }
    }else{
        self.shop_price_new.text = [NSString stringWithFormat:@"￥%.1f",[model.shop_se_price floatValue]];
    }
    
    self.shopSaleLabel.text = [NSString stringWithFormat:@"%.1f折", ([model.shop_se_price doubleValue]/ [model.shop_price doubleValue])*10];
    self.saleNumbelLabel.text = [NSString stringWithFormat:@"已售%@", model.virtual_sales];
    self.ManufacturerLable.hidden = model.supp_label.length ==0 ?:NO;
    self.ManufacturerLable.text = [NSString stringWithFormat:@"%@", model.supp_label];
    //    self.shopReductionLabel.text = [NSString stringWithFormat:@"拼团价%.2f", [ model.roll_price doubleValue]];
    self.shopReductionLabel.text = [NSString stringWithFormat:@"立省%.1f元", [model.shop_price doubleValue] - [model.shop_se_price doubleValue]];
    //    self.reduce_Price_new.text = [NSString stringWithFormat:@"立省%.1f元", [model.shop_price doubleValue] - [model.shop_se_price doubleValue]];
    
    
    //拼团商品是否勾选
    if(model.isSelect)
    {
        self.sharebtn.hidden = NO;
    }else{
        self.sharebtn.hidden = YES;
    }
    CGFloat imageWith = ZOOM6(60);
    self.sharebtn.frame = CGRectMake((CGRectGetWidth(self.shop_pic.frame)-imageWith)/2,(CGRectGetHeight(self.shop_pic.frame)-imageWith)/2-self.H_bottomView_new.constant/2, imageWith, imageWith);
    self.sharebtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.sharebtn addTarget:self action:@selector(shareclick:) forControlEvents:UIControlEventTouchUpInside];
    self.sharebtn.selected = model.isSelect;
    [self.sharebtn setImage:[UIImage imageNamed:@"wodexihao_fengge_icon_weixuanzhong"] forState:UIControlStateNormal];
    [self.sharebtn setImage:[UIImage imageNamed:@"fight_icon_cel"] forState:UIControlStateSelected];
}

- (void)receiveDataModel8:(TFShoppingM *)model;
{
    [self setupUI:model];
    
    NSString *picSize;
    
    if (kDevice_Is_iPhone6Plus) {
        picSize = @"!382";
    } else {
        picSize = @"!280";
    }
    
    //!280
    NSURL *imgUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@",[NSObject baseURLStr_Upy],model.def_pic,picSize]];
    self.shop_pic.contentMode = UIViewContentModeScaleAspectFit;
    [self.shop_pic setImageWithURL:imgUrl placeholderImage:nil progress:^(float downloaderProgress) {
        self.defaultImageView.hidden = NO;
    } completed:^{
        self.defaultImageView.hidden = YES;
    }];
    
    self.bottomView_new.frame = CGRectMake(CGRectGetMinX(self.bottomView_new.frame), CGRectGetHeight(self.contentView.frame) -70, CGRectGetWidth(self.bottomView_new.frame), 70);
    
    self.shop_name_new.frame = CGRectMake(CGRectGetMinX(self.shop_name_new.frame), CGRectGetMinY(self.shop_name_new.frame), CGRectGetWidth(self.shop_name_new.frame), 45);
   
    self.shop_name_new.text = [NSString stringWithFormat:@"%@",model.shop_name];
    
    //行间距
    NSMutableAttributedString * attributedString1 = [[NSMutableAttributedString alloc] initWithString:self.shop_name_new.text];
    NSMutableParagraphStyle * paragraphStyle1 = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle1 setLineSpacing:ZOOM6(8)];
    [attributedString1 addAttribute:NSParagraphStyleAttributeName value:paragraphStyle1 range:NSMakeRange(0, [self.shop_name_new.text length])];
    [self.shop_name_new setAttributedText:attributedString1];
}


- (void)receiveshareModel:(BOOL)select
{
    self.selectBtn.hidden = YES;

    //勾选
    self.sharebtn.selected=select;
    [self.sharebtn setImage:[UIImage imageNamed:@"wodexihao_fengge_icon_weixuanzhong"] forState:UIControlStateNormal];
    [self.sharebtn setImage:[UIImage imageNamed:@"wodexihao_fengge_icon_xuanzhong"] forState:UIControlStateSelected];
    self.sharebtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.sharebtn addTarget:self action:@selector(shareclick:) forControlEvents:UIControlEventTouchUpInside];

}
+ (NSString *)exchangeShopName:(NSString *)text {
   return [self exchangeShopName:text];
}
- (NSString *)exchangeTextWihtString:(NSString *)text
{
    NSArray *arr = [text componentsSeparatedByString:@"】"];
    if (arr.count == 1) {
        return text;
    }
    NSString *textTemp;
    if (arr.count == 2) {
        textTemp = [NSString stringWithFormat:@"%@%@】", arr[1], arr[0]];
    }
    return textTemp;
}


- (void)setupUI:(TFShoppingM *)model
{

    self.H_bottomView_new.constant = kZoom6pt(45)+self.H_BottomPriceConstraint.constant;
    self.S_shop_price.constant = kZoom6pt(6)+self.H_BottomPriceConstraint.constant;
//    self.bottomPrice.text=[NSString stringWithFormat:@"专柜价￥%.1f",[model.shop_price floatValue]];
    self.bottomPrice.hidden=NO;
//    self.reduce_Price_new.text = [NSString stringWithFormat:@"立省%.1f元", [model.shop_price doubleValue] - [model.shop_se_price doubleValue]];
//    self.bottomPrice.text= [NSString stringWithFormat:@"返￥%.1f元=0元",[model.shop_se_price floatValue]*0.9];
    self.bottomPrice.text= [NSString stringWithFormat:@"  %@", model.supp_label];
    if(![model.supp_label isEqual:[NSNull null]] && model.supp_label.length >0)
    {
        self.bottomPrice.hidden = NO;
    }else{
        self.bottomPrice.hidden = YES;
    }
    
//    self.reduce_Price_new.text = [NSString stringWithFormat:@"原价￥%.1f",[model.shop_price floatValue]];
    if ([DataManager sharedManager].is_OneYuan)
    {
//        self.reduce_Price_new.text=[NSString stringWithFormat:@"原价￥%.1f",[model.shop_se_price floatValue]];
        
        if(self.freelingImageV.hidden == NO)
        {
            self.reduce_Price_new.text = [NSString stringWithFormat:@"已领%@件", model.virtual_sales];
        }else{
            self.reduce_Price_new.text = [NSString stringWithFormat:@"月销%@件", model.virtual_sales];
        }
    }
    else{
        self.reduce_Price_new.text=[NSString stringWithFormat:@"原价￥%.1f",[model.shop_price floatValue]];
    }
    
    self.defaultImageView.hidden = NO;
    self.shop_pic.image = nil;
    
    NSMutableString *code = [NSMutableString stringWithString:[NSString stringWithFormat:@"%@",model.shop_code]];
    NSString *supcode  = [code substringWithRange:NSMakeRange(1, 3)];
    
    NSString *pic = [NSString stringWithFormat:@"%@/%@/%@",supcode,model.shop_code,model.def_pic];
    
    NSString *picSize;
    
    if (kDevice_Is_iPhone6Plus) {
        picSize = @"!382";
    } else {
        picSize = @"!280";
    }
    
    //!280
    NSURL *imgUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@",[NSObject baseURLStr_Upy],pic,picSize]];
    
    self.shop_pic.contentMode = UIViewContentModeScaleAspectFit;
    [self.shop_pic setImageWithURL:imgUrl placeholderImage:nil progress:^(float downloaderProgress) {
        self.defaultImageView.hidden = NO;
    } completed:^{
        self.defaultImageView.hidden = YES;
    }];
    
    
    self.shop_name_new.text = [self exchangeTextWihtString:model.shop_name];

    //新的价格计算方式
    
    if([DataManager sharedManager].is_OneYuan)
    {
        self.shop_price_new.text = [NSString stringWithFormat:@"￥%.1f",model.app_shop_group_price.floatValue];
        if(model.isVip.integerValue == 1)
        {
            CGFloat price = [self.viewmodel get_discount_price:[model.shop_se_price floatValue] DiscountMoney:model.reduceMoney MaxViptype:model.maxType Shop_deduction:model.shop_deduction.floatValue];
            self.shop_price_new.text = [NSString stringWithFormat:@"￥%.1f",price];
        }
    }else{
        self.shop_price_new.text = [NSString stringWithFormat:@"￥%.1f",[model.shop_se_price floatValue]];
    }
    
    NSString *kicbackText;
    if (kUnNilAndNULL(model.kickback)) {
        kicbackText = [NSString stringWithFormat:@"%d元",[model.kickback intValue]*1];
    } else {
        kicbackText = [NSString stringWithFormat:@"%d元",0];
    }
    
    CGSize size = [kicbackText boundingRectWithSize:CGSizeMake(100, 20) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:kZoom6pt(11)]} context:nil].size;
    self.W_shopKicback.constant = size.width+10;
    self.H_shopKicback.constant = size.height+2;
    self.shop_kicback_new.text = kicbackText;
    
    UIImage *priceImage = [UIImage imageNamed:@"biankuang"];
    priceImage = [priceImage  stretchableImageWithLeftCapWidth:priceImage.size.width*0.5  topCapHeight:priceImage.size.height*0.5];
    self.priceImageV.image = priceImage;
    
    //何波加的 2016-10-8
    
    self.ManufacturerLable.text = [NSString stringWithFormat:@"%@",model.supp_label];
    CGFloat width = [self getRowWidth:self.ManufacturerLable.text fontSize:ZOOM6(24)]+20;
//    self.ManufacturerLable.frame = CGRectMake((kScreenWidth/2-5-width)/2, self.ManufacturerLable.frame.origin.y, width, self.ManufacturerLable.frame.size.height);
    self.W_BrandLabel.constant=width+5;
    if(![model.supp_label isEqual:[NSNull null]] && model.supp_label.length >0 && ![model.supp_label isEqualToString:@"(null)"])
    {
        self.ManufacturerLable.hidden = NO;
    }else{
        self.ManufacturerLable.hidden = YES;
    }
}


- (void)refreshDataModel:(LikeModel *)model
{
    self.H_bottomView_new.constant = kZoom6pt(45)+self.H_BottomPriceConstraint.constant;
    self.S_shop_price.constant = kZoom6pt(6)+self.H_BottomPriceConstraint.constant;
//    self.bottomPrice.text=[NSString stringWithFormat:@"专柜价￥%.1f",[model.shop_price floatValue]];
//    self.reduce_Price_new.text = [NSString stringWithFormat:@"立省%.1f元", [model.shop_price doubleValue] - [model.shop_se_price doubleValue]];
//    self.bottomPrice.text= [NSString stringWithFormat:@"返￥%.1f元=0元",[model.shop_se_price floatValue]*0.9];
    self.bottomPrice.text= [NSString stringWithFormat:@"  %@", model.supp_label];
    if(![model.supp_label isEqual:[NSNull null]] && model.supp_label.length >0)
    {
        self.bottomPrice.hidden = NO;
    }else{
        self.bottomPrice.hidden = YES;
    }
    
//    self.reduce_Price_new.text = [NSString stringWithFormat:@"原价￥%.1f",[model.shop_price floatValue]];
    if ([DataManager sharedManager].is_OneYuan)
    {
        self.reduce_Price_new.text=[NSString stringWithFormat:@"原价￥%.1f",[model.shop_se_price floatValue]];
    }
    else{
        self.reduce_Price_new.text=[NSString stringWithFormat:@"原价￥%.1f",[model.shop_price floatValue]];
    }
    self.defaultImageView.hidden = NO;
    self.selectBtn.hidden = YES;
    self.shop_pic.image = nil;
    
    NSMutableString *code = [NSMutableString stringWithString:[NSString stringWithFormat:@"%@",model.shop_code]];
    NSString *supcode  = [code substringWithRange:NSMakeRange(1, 3)];
    
    NSString *pic = [NSString stringWithFormat:@"%@/%@/%@",supcode,model.shop_code,model.show_pic];
    
    NSString *picSize;
    
    if (kDevice_Is_iPhone6Plus) {
        picSize = @"!382";
    } else {
        picSize = @"!280";
    }
    
    //!280
    NSURL *imgUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@",[NSObject baseURLStr_Upy],pic,picSize]];
    self.shop_pic.contentMode = UIViewContentModeScaleAspectFit;
    [self.shop_pic setImageWithURL:imgUrl placeholderImage:nil progress:^(float downloaderProgress) {
        self.defaultImageView.hidden = NO;
    } completed:^{
        self.defaultImageView.hidden = YES;
    }];
    
    
    self.shop_name_new.text = [self exchangeTextWihtString:model.shop_name];
    NSString *kickback =[NSString stringWithFormat:@"%.0f",model.shop_se_price.floatValue*0.1] ;

    //新价格计算方式
    
    if([DataManager sharedManager].is_OneYuan)
    {
        self.shop_price_new.text = [NSString stringWithFormat:@"￥%.1f",model.app_shop_group_price.floatValue];
        if(model.isVip.integerValue == 1)
        {
            CGFloat price = [self.viewmodel get_discount_price:[model.shop_se_price floatValue] DiscountMoney:model.reduceMoney MaxViptype:model.maxType.stringValue Shop_deduction:model.shop_deduction.floatValue];
            self.shop_price_new.text = [NSString stringWithFormat:@"￥%.1f",price];
        }
    }else{
        self.shop_price_new.text = [NSString stringWithFormat:@"￥%.1f",[model.shop_se_price floatValue]];
    }
    
    NSString *kicbackText;
    if (kUnNilAndNULL(model.shop_se_price)) {
        kicbackText = [NSString stringWithFormat:@"%.0f元",[model.shop_se_price intValue]*0.1];
    } else {
        kicbackText = [NSString stringWithFormat:@"%d元",0];
    }
    
    CGSize size = [kicbackText boundingRectWithSize:CGSizeMake(100, 20) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:kZoom6pt(11)]} context:nil].size;
    self.W_shopKicback.constant = size.width+10;
    self.H_shopKicback.constant = size.height+2;
    self.shop_kicback_new.text = kicbackText;
    
    UIImage *priceImage = [UIImage imageNamed:@"biankuang"];
    priceImage = [priceImage  stretchableImageWithLeftCapWidth:priceImage.size.width*0.5  topCapHeight:priceImage.size.height*0.5];
    self.priceImageV.image = priceImage;
    
    //何波加的 2016-10-8
    self.ManufacturerLable.text = [NSString stringWithFormat:@"%@制",model.supp_label];
    CGFloat width = [self getRowWidth:self.ManufacturerLable.text fontSize:ZOOM6(24)]+20;
//    self.ManufacturerLable.frame = CGRectMake((kScreenWidth/2-5-width)/2, self.ManufacturerLable.frame.origin.y, width, self.ManufacturerLable.frame.size.height);
    self.W_BrandLabel.constant=width+5;

    if(![model.supp_label isEqual:[NSNull null]] && model.supp_label.length >0 )
    {
        self.ManufacturerLable.hidden = NO;
    }else{
        self.ManufacturerLable.hidden = YES;
    }

}
- (void)refreshTopicShopModel:(TShoplistModel *)model
{
    self.H_bottomView_new.constant = kZoom6pt(45)+self.H_BottomPriceConstraint.constant;
    self.S_shop_price.constant = kZoom6pt(6)+self.H_BottomPriceConstraint.constant;
//    self.bottomPrice.text=[NSString stringWithFormat:@"专柜价￥%.1f",[model.shop_price floatValue]];
//    self.reduce_Price_new.text = [NSString stringWithFormat:@"立省%.1f元", [model.shop_price doubleValue] - [model.shop_se_price doubleValue]];
//    self.bottomPrice.text= [NSString stringWithFormat:@"返￥%.1f元=0元",[model.shop_se_price floatValue]*0.9];
    self.bottomPrice.text= [NSString stringWithFormat:@"  %@", model.supp_label];
//    self.reduce_Price_new.text = [NSString stringWithFormat:@"原价￥%.1f",[model.shop_price floatValue]];
    if ([DataManager sharedManager].is_OneYuan)
    {
        self.reduce_Price_new.text=[NSString stringWithFormat:@"原价￥%.1f",[model.shop_se_price floatValue]];
//        self.reduce_Price_new.text = [NSString stringWithFormat:@"已拼%@件", model.virtual_sales];

    }
    else{
        self.reduce_Price_new.text=[NSString stringWithFormat:@"原价￥%.1f",[model.shop_price floatValue]];
    }
    self.defaultImageView.hidden = NO;
    self.selectBtn.hidden = YES;
    self.shop_pic.image = nil;
    
    NSMutableString *code = [NSMutableString stringWithString:[NSString stringWithFormat:@"%@",model.shop_code]];
    NSString *supcode  = [code substringWithRange:NSMakeRange(1, 3)];
    
    NSString *pic = [NSString stringWithFormat:@"%@/%@/%@",supcode,model.shop_code,model.def_pic];
    
    NSString *picSize;
    
    if (kDevice_Is_iPhone6Plus) {
        picSize = @"!382";
    } else {
        picSize = @"!280";
    }
    
    //!280
    NSURL *imgUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@",[NSObject baseURLStr_Upy],pic,picSize]];
    self.shop_pic.contentMode = UIViewContentModeScaleAspectFit;
    [self.shop_pic setImageWithURL:imgUrl placeholderImage:nil progress:^(float downloaderProgress) {
        self.defaultImageView.hidden = NO;
    } completed:^{
        self.defaultImageView.hidden = YES;
    }];
    
    
    self.shop_name_new.text = [self exchangeTextWihtString:model.shop_name];
    NSString *kickback =[NSString stringWithFormat:@"%.0f",model.shop_se_price.floatValue*0.1] ;
//    self.shop_price_new.text = [NSString stringWithFormat:@"￥%.1f",[model.shop_se_price floatValue]-[kickback floatValue]];
    //新价格计算方式
    
    if([DataManager sharedManager].is_OneYuan)
    {
        self.shop_price_new.text = [NSString stringWithFormat:@"￥%.1f",model.app_shop_group_price.floatValue];
    }else{
        self.shop_price_new.text = [NSString stringWithFormat:@"￥%.1f",[model.shop_se_price floatValue]];
    }
    
    NSString *kicbackText;
    if (kUnNilAndNULL(model.shop_se_price)) {
        kicbackText = [NSString stringWithFormat:@"%.0f元",[model.shop_se_price intValue]*0.1];
    } else {
        kicbackText = [NSString stringWithFormat:@"%d元",0];
    }
    
    CGSize size = [kicbackText boundingRectWithSize:CGSizeMake(100, 20) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:kZoom6pt(11)]} context:nil].size;
    self.W_shopKicback.constant = size.width+10;
    self.H_shopKicback.constant = size.height+2;
    self.shop_kicback_new.text = kicbackText;
    
    UIImage *priceImage = [UIImage imageNamed:@"biankuang"];
    priceImage = [priceImage  stretchableImageWithLeftCapWidth:priceImage.size.width*0.5  topCapHeight:priceImage.size.height*0.5];
    self.priceImageV.image = priceImage;
    
    //何波加的 2016-10-8
    self.ManufacturerLable.text = [NSString stringWithFormat:@"%@",model.supp_label];
    CGFloat width = [self getRowWidth:self.ManufacturerLable.text fontSize:ZOOM6(24)]+20;
    //    self.ManufacturerLable.frame = CGRectMake((kScreenWidth/2-5-width)/2, self.ManufacturerLable.frame.origin.y, width, self.ManufacturerLable.frame.size.height);
    self.W_BrandLabel.constant=width+5;
    
    if(![model.supp_label isEqual:[NSNull null]] && model.supp_label.length >0 )
    {
        self.ManufacturerLable.hidden = NO;
    }else{
        self.ManufacturerLable.hidden = YES;
    }

}
- (void)shareclick:(UIButton*)sender
{
//    sender.selected = !sender.selected;
    if (self.selectBlock) {
        self.selectBlock();
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

/**
 CABasicAnimation * animation=[CABasicAnimation  animationWithKeyPath:@"opacity"];
 //设置透明度最小值
 [animation setFromValue:[NSNumber numberWithFloat:0.0]];
 //设置透明度最大值
 [animation setToValue:[NSNumber numberWithInt:1.0]];
 //播放速率
 [animation setDuration:0.3];
 //播放次数
 [animation setRepeatCount:1];
 //设置
 //[animation setDelegate:self];
 [animation setAutoreverses:YES];//默认的是NO，即透明完毕后立马恢复，YES是延迟恢复
 [self.shop_pic.layer addAnimation:animation forKey:@"img-opacity"];
 */

@end
