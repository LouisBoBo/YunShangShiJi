//
//  AffirmOrderCell.m
//  YunShangShiJi
//
//  Created by yssj on 16/6/27.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import "AffirmOrderCell.h"
#import "GlobalTool.h"
#import "MyMD5.h"
#import "DefaultImgManager.h"

#define DefaultImg(size) [[DefaultImgManager sharedManager] defaultImgWithSize:(size)]

#define firstFont [UIFont systemFontOfSize:ZOOM6(30)]

@implementation AffirmOrderCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        self.backgroundColor=[UIColor whiteColor];
        self.selectionStyle=UITableViewCellSelectionStyleNone;
        [self setUpSubViews];
    }
    return self;
}
- (void)setUpSubViews {
    
    self.headimage=[[UIImageView alloc]initWithFrame:CGRectMake(ZOOM(62), ZOOM6(30), ZOOM6(140), ZOOM6(140))];
    _headimage.backgroundColor=kBackgroundColor;
    _headimage.contentMode=UIViewContentModeScaleAspectFill;
    _headimage.clipsToBounds=YES;
    self.title=[[UILabel alloc]init];
    self.color_size=[[UILabel alloc]init];
    self.price=[[UILabel alloc]init];
    self.number=[[UILabel alloc]init];
    self.line=[[UILabel alloc]init];
    self.shop_oldPrice=[[UILabel alloc]init];
    self.brand=[[UILabel alloc]init];
    self.payStatusLabel = [[UILabel alloc]init];
    
    [self.contentView addSubview:self.headimage];
    [self.contentView addSubview:_title];
    [self.contentView addSubview:_color_size];
    [self.contentView addSubview:_price];
    [self.contentView addSubview:_number];
    [self.contentView addSubview:_line];
    [self.contentView addSubview:_payStatusLabel];
    [self.contentView addSubview:_brand];
    
    self.title.textColor=kMainTitleColor;
    self.price.textColor=kMainTitleColor;
    self.number.textColor=kTextColor;
    self.payStatusLabel.textColor=tarbarrossred;
    self.line.backgroundColor = kTextColor;
    self.shop_oldPrice.textColor = kTextColor;
    self.brand.textColor=kTextColor;
    self.color_size.textColor = kTextColor;
    self.changeNum.layer.borderWidth = 1;
    self.changeNum.layer.borderColor = kbackgrayColor.CGColor;
    self.changeNumTextField.layer.borderWidth = 1;
    self.changeNumTextField.layer.borderColor = kbackgrayColor.CGColor;
    
    self.title.font=firstFont;
    self.color_size.font=[UIFont systemFontOfSize:ZOOM6(24)];
    self.shop_oldPrice.font=[UIFont systemFontOfSize:ZOOM6(24)];
    self.brand.font=[UIFont systemFontOfSize:ZOOM6(24)];
    self.price.font=[UIFont systemFontOfSize:ZOOM6(30)];
    self.number.font=[UIFont systemFontOfSize:ZOOM6(24)];
    self.payStatusLabel.font = [UIFont systemFontOfSize:ZOOM6(24)];
    self.number.textAlignment=NSTextAlignmentRight;
    self.brand.textAlignment=NSTextAlignmentRight;

    _title.frame=CGRectMake(_headimage.frame.origin.x+_headimage.frame.size.width+ZOOM(32), _headimage.frame.origin.y, kScreenWidth-CGRectGetMaxY(_headimage.frame)-42,ZOOM(50));
    self.color_size.frame=CGRectMake(_title.frame.origin.x,CGRectGetMidY(_headimage.frame)-10, kScreenWidth, 21);
    _price.frame=CGRectMake(_title.frame.origin.x,CGRectGetMaxY(_headimage.frame)-21 , kScreenWidth/2,21);
    _shop_oldPrice.frame=CGRectMake(_price.frame.origin.x+_price.frame.size.width+10, _price.frame.origin.y, 70, _price.frame.size.height);
    _brand.frame=CGRectMake(kScreenWidth/2-ZOOM(42), _price.frame.origin.y, kScreenWidth/2, 21);
    self.line.frame = CGRectMake(self.shop_oldPrice.frame.origin.x, self.shop_oldPrice.frame.origin.y+_shop_oldPrice.frame.size.height/2, _line.frame.size.width, 0.5);
    self.number.frame = CGRectMake(kScreenWidth-42-ZOOM(42), _title.frame.origin.y, 42, 21);
    
    self.payStatusLabel.frame = CGRectMake(kScreenWidth-42-ZOOM(42), _color_size.frame.origin.y, 42, 21);
    
    self.returnMoney = [[UILabel alloc]initWithFrame:CGRectMake(_color_size.x, _price.bottom+ZOOM6(10), 300, ZOOM6(40))];
    _returnMoney.textColor = kMainTitleColor;
    _returnMoney.font = kFont6px(28);
    _returnMoney.hidden = YES;
    [self.contentView addSubview:self.returnMoney];
    
    
}

- (void)loadDataModel:(ShopDetailModel *)model
{
    self.headimage.frame = CGRectMake(ZOOM6(30), ZOOM6(30), ZOOM6(140), ZOOM6(140));

    if(model.isTM.intValue == 1)
    {
        self.color_size.text=[NSString stringWithFormat:@"%@",model.shop_color];
    }else{
        self.color_size.text=[NSString stringWithFormat:@"颜色:%@  尺码:%@",model.shop_color,model.shop_size];
    }
    
    self.title.text=[NSString stringWithFormat:@"%@",[self exchangeTextWihtString:model.shop_name]];
    self.price.text=[NSString stringWithFormat:@"¥%.1f",[model.shop_price floatValue]];

    NSString *shop_seprice = [NSString stringWithFormat:@" ¥%.1f",[model.shop_price floatValue]];
    NSString *oldPrice = [NSString stringWithFormat:@" ¥%.1f",[model.shop_price floatValue]];
    if([DataManager sharedManager].is_OneYuan){
        shop_seprice = [NSString stringWithFormat:@" ¥%.1f",[model.shop_price floatValue]];
        oldPrice = [NSString stringWithFormat:@" ¥%.1f",[model.shop_price floatValue]];
    }

//    NSString *str=[NSString stringWithFormat:@"%@ %@",shop_seprice,oldPrice];
    NSString *str=[NSString stringWithFormat:@"%@ ",shop_seprice];
    NSMutableAttributedString *attriStr = [NSString getOneColorInLabel:str ColorString:oldPrice Color:kTextColor fontSize:ZOOM6(24)];

    [self.price setAttributedText:attriStr];
    self.brand.text = [model.supp_label isEqualToString:@"(null)"]||[model.supp_label isEqual:[NSNull null]]||model.supp_label.length==0
    ? @""
    : [NSString stringWithFormat:@"%@",model.supp_label];
    //    cell.shop_oldPrice.text=[NSString stringWithFormat:@"¥%.1f",[model.shop_price floatValue]];
    self.number.text=[NSString stringWithFormat:@"x%@",model.shop_num];

    if(model.noPay.intValue == 0 && ![model.noPay isEqual:[NSNull null]] && model.shop_from.intValue == 11)
    {
        self.payStatusLabel.text = @"未支付";
    }else{
        self.payStatusLabel.text = @" ";
    }
    
    NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:ZOOM(46)]};
    CGSize textSize = [[NSString stringWithFormat:@"¥%.1f",[model.shop_se_price floatValue]] boundingRectWithSize:CGSizeMake(100, 100) options:NSStringDrawingTruncatesLastVisibleLine attributes:attributes context:nil].size;
    self.line.frame = CGRectMake(self.price.frame.origin.x+textSize.width+ZOOM6(15), self.line.frame.origin.y, [NSString widthWithString:oldPrice font:kFont6px(24) constrainedToHeight:20], 0);
    self.line.backgroundColor = kTextColor;



    NSURL *imgUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@/%@/%@!180",[NSObject baseURLStr_Upy],[MyMD5 pictureString:model.shop_code],model.def_pic]];

    //    NSURL *imgUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@!180",[NSObject baseURLStr_Upy],model.def_pic]];
    __block float d = 0;
    __block BOOL isDownlaod = NO;
    [self.headimage sd_setImageWithURL:imgUrl placeholderImage:DefaultImg(self.headimage.bounds.size) options:SDWebImageRetryFailed progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        d = (float)receivedSize/expectedSize;
        isDownlaod = YES;
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (image != nil && isDownlaod == YES) {
            self.headimage.alpha = 0;
            [UIView animateWithDuration:0.5 animations:^{
                self.headimage.alpha = 1;
            } completion:^(BOOL finished) {
            }];
        } else if (image != nil && isDownlaod == NO) {
            self.headimage.image = image;
        }
    }];
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
    return text;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
}


@end
