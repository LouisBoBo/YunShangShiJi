//
//  CartSaleCell.m
//  YunShangShiJi
//
//  Created by yssj on 16/8/24.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import "CartSaleCell.h"
#import "UIImageView+WebCache.h"
#import "GlobalTool.h"
#import "MyMD5.h"
#import "DefaultImgManager.h"

#define firstFont [UIFont systemFontOfSize:ZOOM(46)]
#define spaceHeight [self calculateSpaceHeight]
#define kGrayColor [UIColor lightGrayColor]
#define DefaultImg(size) [[DefaultImgManager sharedManager] defaultImgWithSize:(size)]


@implementation CartSaleCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        self.backgroundColor=[UIColor whiteColor];
        self.selectionStyle=UITableViewCellSelectionStyleNone;
        [self setUpSubViews];
    }
    return self;
}
-(void)setUpSubViews
{
    
    
    self.shop_headimage=[[UIImageView alloc]initWithFrame:CGRectMake(ZOOM(40), ZOOM6(30), ZOOM6(140), ZOOM6(140))];
    self.shop_headimage.frame=CGRectMake(ZOOM(40), ZOOM(62), ZOOM(230), ZOOM(320));
    self.grayImage=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"sold-out@2x-min"]];_grayImage.hidden=YES;
    self.grayImage.frame=CGRectMake(ZOOM(40), ZOOM(62), ZOOM(230), ZOOM(320));
    self.grayImage.contentMode=UIViewContentModeScaleAspectFit;
    
    _shop_headimage.contentMode=UIViewContentModeScaleAspectFill;
    _shop_headimage.clipsToBounds=YES;
    self.shop_content=[[UILabel alloc]initWithFrame:CGRectMake(_shop_headimage.frame.origin.x+_shop_headimage.frame.size.width+ZOOM(32),_shop_headimage.frame.origin.y, kScreenWidth-CGRectGetMaxX(_shop_headimage.frame)-ZOOM(32)-56,ZOOM(56))];
    self.shopOne=[[UILabel alloc]initWithFrame:CGRectMake(_shop_content.frame.origin.x,CGRectGetMinY(_shop_headimage.frame)+CGRectGetHeight(_shop_headimage.frame)/5 ,180, ZOOM(70))];
    

    self.shopThree=[[UILabel alloc]initWithFrame:CGRectMake(_shop_content.frame.origin.x, CGRectGetMaxY(_shop_headimage.frame)-21 , 72, 21)];
    self.shopTwo=[[UILabel alloc]initWithFrame:CGRectMake(_shopThree.frame.origin.x+_shopThree.frame.size.width+3, _shopThree.frame.origin.y, 60, 21)];
    
    self.shop_se_price=[[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth-ZOOM(35)-60, _shop_content.frame.origin.y, 60, _shop_content.frame.size.height)];
    self.shop_price=[[UILabel alloc]initWithFrame:CGRectMake(_shop_se_price.frame.origin.x, _shopOne.frame.origin.y, 60, _shopOne.frame.size.height)];
    _shop_se_price.textAlignment=NSTextAlignmentRight;
    _shop_price.textAlignment=NSTextAlignmentRight;
    self.shop_se_price.font=firstFont;
    self.shop_price.font=[UIFont systemFontOfSize:ZOOM6(24)];
    
    self.editeBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    self.editeBtn.frame=CGRectMake(kScreenWidth-ZOOM(200),CGRectGetMaxY(_shop_headimage.frame)-kZoom6pt(25), ZOOM(200), kZoom6pt(25));
    self.editeBtn.contentEdgeInsets=UIEdgeInsetsMake(0,ZOOM(80), 0, 0);
    _editeBtn.imageView.contentMode=UIViewContentModeScaleAspectFit;
    [_editeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_editeBtn setImage:[UIImage imageNamed:@"icon_close"] forState:UIControlStateNormal];
    [_editeBtn addTarget:self action:@selector(editeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    /*
    self.deleteImg=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.deleteImg.frame = CGRectMake(kScreenWidth-ZOOM(35)-80,CGRectGetMaxY(_shop_headimage.frame)-30, 80,30);
    [_deleteImg setTitle:@"重新加入" forState:UIControlStateNormal];
    [_deleteImg setTintColor:tarbarrossred];
    _deleteImg.layer.borderWidth=1;
    _deleteImg.layer.borderColor=tarbarrossred.CGColor;
    _deleteImg.layer.cornerRadius=3;
    [_deleteImg addTarget:self action:@selector(deleteImgClick) forControlEvents:UIControlEventTouchUpInside];
    */
    
    
    self.shop_num=[[UILabel alloc]init];
    _shop_num.textAlignment=NSTextAlignmentRight;
    _shop_num.textColor=kMainTitleColor;

    
    self.shop_depreciate=[[UILabel alloc]init];
    
    _line=[[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_shop_headimage.frame)+ZOOM6(30), kScreenWidth, 1)];
    _line.backgroundColor=kBackgroundColor;
    [self.contentView addSubview:_line];
    
    _bottomLine=[[UILabel alloc]init];
    _bottomLine.backgroundColor=kBackgroundColor;
    _changNumLabel=[[UILabel alloc]init];
    _changNumLabel.textAlignment=NSTextAlignmentRight;
    
    //    [self.contentView addSubview:_selectbtn];
    [self.contentView addSubview:_shop_headimage];
    [self.contentView addSubview:_grayImage];
    [self.contentView addSubview:_shop_content];
    [self.contentView addSubview:_shopOne];
    [self.contentView addSubview:_shopThree];
    [self.contentView addSubview:_shopTwo];
    [self.contentView addSubview:_shop_num];
    [self.contentView addSubview:_editeBtn];
    //[self.contentView addSubview:_deleteImg];
    //    [self.contentView addSubview:_minusBtn];
    //    [self.contentView addSubview:_plusBtn];
    //    [self.contentView addSubview:_numTextField];
    [self.contentView addSubview:_shop_depreciate];
    [self.contentView addSubview:_bottomLine];
    [self.contentView addSubview:_changNumLabel];
    [self.contentView addSubview:_shop_se_price];
    [self.contentView addSubview:_shop_price];
}

-(void)setFrame:(CGRect)frame
{
    super.frame = frame;
    
    
    self.numTextField.layer.borderColor=lineGreyColor.CGColor;
    self.plusBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    self.shop_content.font = firstFont;
    self.shopOne.font = [UIFont systemFontOfSize:ZOOM6(24)];
    self.shopThree.font=[UIFont systemFontOfSize:ZOOM6(24)];
    self.shopTwo.font=[UIFont systemFontOfSize:ZOOM6(24)];
    self.shop_depreciate.font=[UIFont systemFontOfSize:ZOOM6(24)];
    //    self.afterDiscout.font=firstFont;
    self.shop_num.font=[UIFont systemFontOfSize:ZOOM6(30)];
    self.changNumLabel.font=[UIFont systemFontOfSize:ZOOM(42)];
    _changNumLabel.textColor=kGrayColor;
    _editeBtn.titleLabel.font=firstFont;
    
    _grayLabel.frame=CGRectMake(CGRectGetMinX(_shop_headimage.frame),CGRectGetMaxY(_shop_headimage.frame)-ZOOM(80), _shop_headimage.frame.size.width, ZOOM(80));
    
    _shop_content.frame = CGRectMake(_shop_headimage.frame.origin.x+_shop_headimage.frame.size.width+ZOOM(32),_shop_headimage.frame.origin.y, kScreenWidth-CGRectGetMaxX(_shop_headimage.frame)-ZOOM(32)-_editeBtn.frame.size.width,ZOOM(56));
    _shop_content.textColor=kMainTitleColor;
    
    NSString *string = @"超值套餐";
    CGSize size=[string boundingRectWithSize:CGSizeMake(100, 30) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:ZOOM(42)]} context:nil].size;
    
    self.zeroShoppingLabel.frame=CGRectMake(_shop_content.frame.origin.x,CGRectGetMidY(_shop_headimage.frame)-_zeroShoppingLabel.frame.size.height/2 , (int)size.width+5, (int)size.height+5);
    
    _minusBtn.frame=CGRectMake(_shop_content.frame.origin.x,CGRectGetMaxY(_shop_headimage.frame)-_minusBtn.frame.size.height, _minusBtn.frame.size.width, _minusBtn.frame.size.height);
    
    _shop_depreciate.frame=CGRectMake(_shop_headimage.frame.origin.x,CGRectGetMaxY(_line.frame),200,ZOOM6(80));
    _changNumLabel.frame=CGRectMake(kScreenWidth-ZOOM(42)-ZOOM(120), _shop_depreciate.frame.origin.y, ZOOM(120), 21);
    _shop_num.frame=CGRectMake(kScreenWidth/2-ZOOM(42), _shop_depreciate.frame.origin.y, kScreenWidth/2, ZOOM6(80));
    
    
    CGFloat width = CGRectGetMinX(_editeBtn.frame)-_shopThree.frame.origin.x;
    _shopOne.frame=CGRectMake(_shop_content.frame.origin.x,CGRectGetMinY(_shop_headimage.frame)+CGRectGetHeight(_shop_headimage.frame)/5 ,width, ZOOM(70));
    _shopThree.frame=CGRectMake(_shop_content.frame.origin.x, CGRectGetMinY(_shop_headimage.frame)+CGRectGetHeight(_shop_headimage.frame)*3/5, width, ZOOM(70));
    _shopTwo.frame=CGRectMake(_shopThree.frame.origin.x,CGRectGetMinY(_shop_headimage.frame)+CGRectGetHeight(_shop_headimage.frame)*2/5, width, ZOOM(70));
    
    
    
    _bottomLine.frame=CGRectMake(0, _shop_depreciate.frame.origin.y+_shop_depreciate.frame.size.height, kScreenWidth, ZOOM6(20));
    
}

-(void)refreshCartData:(ShopDetailModel*)model
{
    NSURL *imgUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@/%@!180",[NSObject baseURLStr_Upy],model.def_pic]];
    
    __block float d = 0;
    __block BOOL isDownlaod = NO;
    [self.shop_headimage sd_setImageWithURL:imgUrl placeholderImage:DefaultImg(self.shop_headimage.bounds.size) options:SDWebImageRetryFailed progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        d = (float)receivedSize/expectedSize;
        isDownlaod = YES;
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (image != nil && isDownlaod == YES) {
            self.shop_headimage.alpha = 0;
            [UIView animateWithDuration:0.5 animations:^{
                self.shop_headimage.alpha = 1;
            } completion:^(BOOL finished) {
            }];
        } else if (image != nil && isDownlaod == NO) {
            self.shop_headimage.image = image;
        }
    }];
    
    
    self.shop_content.text = [NSString stringWithFormat:@"%@",[self exchangeTextWihtString:model.shop_name]];
    self.shopThree.text=@"";
    self.shopTwo.text=@"";
    
    /*
    self.shop_num.textColor=tarbarrossred;
    NSMutableAttributedString *noteStr =[[NSMutableAttributedString alloc]initWithString: [NSString stringWithFormat:@"总价:¥%.1f",model.price.floatValue]];
    NSRange redRange = NSMakeRange(0, [[noteStr string] rangeOfString:@":"].location+1);
    [noteStr addAttributes:@{NSForegroundColorAttributeName:kMainTitleColor} range:redRange];
    [self.shop_num setAttributedText:noteStr];
    */
    
    _shop_num.attributedText=[NSString getOneColorInLabel:[NSString stringWithFormat:@"总计:¥%.1f  X%@",[model.price floatValue],model.shop_num] ColorString:[NSString stringWithFormat:@"¥%.1f",[model.price floatValue]] Color:tarbarrossred fontSize:ZOOM6(30)];
    
    self.shop_se_price.text=[NSString stringWithFormat:@"¥%.1f",[model.shop_se_price floatValue]];
    NSString *oldPrice = [NSString stringWithFormat:@"¥%.1f",[model.shop_price floatValue]];
    NSUInteger length = [oldPrice length];
    NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:oldPrice];
    [attri addAttribute:NSStrikethroughStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlinePatternSolid | NSUnderlineStyleSingle] range:NSMakeRange(0, length)];
    [attri addAttribute:NSStrikethroughColorAttributeName value:[UIColor lightGrayColor] range:NSMakeRange(0, length)];
    [self.shop_price setAttributedText:attri];
    
    self.zeroShoppingLabel.hidden=YES;
    _shopThree.hidden=YES;_shopTwo.hidden=YES;
    
    if (model.shop_list.count==1) {
        self.zeroShoppingLabel.text=@"超值单品";
    }else
        self.zeroShoppingLabel.text=@"超值套餐";
    for (int i=0; i<model.shop_list.count; i++) {
        if (i==0) {
            ShopDetailModel* colorModel=model.shop_list[0];
            self.shopOne.text=[NSString stringWithFormat:@"商品1:%@",colorModel.shop_color];
        }else if (i==1){
            _shopTwo.hidden=NO;
            ShopDetailModel* colorModel=model.shop_list[1];
            self.shopTwo.text=[NSString stringWithFormat:@"商品2:%@",colorModel.shop_color];
            _shopTwo.textColor=_shopOne.textColor;
        }else if(i==2){
            _shopThree.hidden=NO;
            ShopDetailModel* colorModel=model.shop_list[2];
            self.shopThree.text=[NSString stringWithFormat:@"商品3:%@",colorModel.shop_color];
            _shopThree.textColor=_shopOne.textColor;
        }
    }
    self.shop_depreciate.text=[NSString stringWithFormat:@"共%lu件商品",(unsigned long)model.shop_list.count];
    [self changeColor1:(model.isGray.intValue||model.is_del.intValue)];
    
    /*
    CGFloat width = CGRectGetMinX(_deleteImg.frame)-_shopThree.frame.origin.x;
    _shopOne.frame=CGRectMake(_shop_content.frame.origin.x,CGRectGetMinY(_shop_headimage.frame)+CGRectGetHeight(_shop_headimage.frame)/5 ,width, ZOOM(70));
    _shopTwo.frame=CGRectMake(_shopThree.frame.origin.x,CGRectGetMinY(_shop_headimage.frame)+CGRectGetHeight(_shop_headimage.frame)*2/5, width, ZOOM(70));
    _shopThree.frame=CGRectMake(_shop_content.frame.origin.x, CGRectGetMinY(_shop_headimage.frame)+CGRectGetHeight(_shop_headimage.frame)*3/5, width, ZOOM(70));
    */
    
    _shop_depreciate.frame=CGRectMake(_shop_headimage.frame.origin.x, CGRectGetMaxY(_line.frame)+ZOOM6(30),[self getWidth:_shop_depreciate.text], _shop_depreciate.frame.size.height);
    _changNumLabel.frame=CGRectMake(kScreenWidth-ZOOM(42)-_changNumLabel.frame.size.width, _shop_depreciate.frame.origin.y, _changNumLabel.frame.size.width, _changNumLabel.frame.size.height);
    //_shop_num.frame=CGRectMake(CGRectGetMinX(_changNumLabel.frame)-[self getWidth:_shop_num.text], _shop_depreciate.frame.origin.y, [self getWidth:_shop_num.text], _shop_num.frame.size.height);
    
    //    _shop_num.frame=CGRectMake(CGRectGetMaxX(_shop_depreciate.frame)+ZOOM(42), _shop_depreciate.frame.origin.y, [self getWidth:_shop_num.text], _shop_num.frame.size.height);
}

-(void)editeBtnClick
{
    if (self.editeBlock) {
        self.editeBlock();
    }
}
-(void)deleteImgClick
{
    if (self.deleteBlock) {
        self.deleteBlock();
    }
}
-(void)changeColor1:(int)vaild
{
    
    _shop_content.textColor=vaild ? kGrayColor : kMainTitleColor;
    _shopTwo.textColor=vaild ? kGrayColor : kTextColor;
    _shopThree.textColor=vaild ? kGrayColor : kTextColor;
    _shopOne.textColor=vaild ? kGrayColor : kTextColor;
    _shop_price.textColor=vaild ? kGrayColor : kTextColor;
    _shop_se_price.textColor=vaild ? kGrayColor : kMainTitleColor;
    _shop_depreciate.textColor=vaild ? kGrayColor : kMainTitleColor;
    //_shop_num.textColor=vaild ? kGrayColor : kMainTitleColor;
    _grayLabel.hidden=!vaild;
    _grayImage.hidden=!vaild;
    //    [_deleteImg setBackgroundColor:vaild ? kGrayColor : tarbarrossred];
    
    if (vaild) {
    //    _shop_num.textColor=kGrayColor;
    }
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
-(CGFloat)getWidth:(NSString *)str
{
    CGSize labelSize = [str boundingRectWithSize:CGSizeMake(1000, 999) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:ZOOM(60)] } context:nil].size;
    return labelSize.width;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
