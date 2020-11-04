//
//  CartCell.m
//  YunShangShiJi
//
//  Created by yssj on 16/6/18.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import "CartCell.h"
#import "GlobalTool.h"
#import "MyMD5.h"
#import "UIImageView+WebCache.h"
#import "DefaultImgManager.h"
#import "MBProgressHUD+NJ.h"
#import "ShopCarManager.h"

#define firstFont [UIFont systemFontOfSize:ZOOM6(30)]
#define spaceHeight [self calculateSpaceHeight]
#define kGrayColor [UIColor lightGrayColor]
#define DefaultImg(size) [[DefaultImgManager sharedManager] defaultImgWithSize:(size)]

@implementation CartCell
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
    self.selectbtn=[UIButton buttonWithType:UIButtonTypeCustom];
    self.selectbtn.frame=CGRectMake(0,0,ZOOM(60)+ZOOM(30), ZOOM6(30)*2+ZOOM6(140));
    self.selectbtn.imageEdgeInsets = UIEdgeInsetsMake(0,ZOOM(30),0.0f,0.2f);
    [self.selectbtn setImage:[UIImage imageNamed:@"选中"] forState:UIControlStateSelected];
    self.selectbtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.selectbtn addTarget:self action:@selector(selectbtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    self.shop_headimage=[[UIImageView alloc]initWithFrame:CGRectMake(ZOOM(42), ZOOM6(30), ZOOM6(140), ZOOM6(140))];
    _shop_headimage.backgroundColor=kBackgroundColor;
    _shop_headimage.contentMode=UIViewContentModeScaleAspectFill;
    _shop_headimage.clipsToBounds=YES;
    
    self.grayImage=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"sold-out@2x-min"]];_grayImage.hidden=YES;
    self.grayImage.frame=CGRectMake(ZOOM(42), ZOOM6(30), ZOOM6(140), ZOOM6(140));


    self.shop_content=[[UILabel alloc]initWithFrame:CGRectMake(_shop_headimage.frame.origin.x+_shop_headimage.frame.size.width+ZOOM(32),_shop_headimage.frame.origin.y, kScreenWidth-CGRectGetMaxX(_shop_headimage.frame)-ZOOM(32)-60-ZOOM(35),ZOOM(56))];
    self.shop_color_size=[[UILabel alloc]initWithFrame:CGRectMake(_shop_content.frame.origin.x,CGRectGetMidY(_shop_headimage.frame)-18 , 180, 28)];
    //self.shop_se_price=[[UILabel alloc]initWithFrame:CGRectMake(_shop_content.frame.origin.x, CGRectGetMaxY(_shop_headimage.frame)-21 , 72, 21)];
    //self.shop_price=[[UILabel alloc]initWithFrame:CGRectMake(_shop_se_price.frame.origin.x+_shop_se_price.frame.size.width+3, _shop_se_price.frame.origin.y, 60, 21)];
    self.shop_se_price=[[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth-ZOOM(35)-60, _shop_content.frame.origin.y, 60, _shop_content.frame.size.height)];
    self.shop_price=[[UILabel alloc]initWithFrame:CGRectMake(_shop_se_price.frame.origin.x, _shop_color_size.frame.origin.y, 60, _shop_color_size.frame.size.height)];
    _shop_se_price.textAlignment=NSTextAlignmentRight;
    _shop_price.textAlignment=NSTextAlignmentRight;
    
    //_shop_content.backgroundColor=DRandomColor;_shop_se_price.backgroundColor=DRandomColor;
    
    self.minusBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    _minusBtn.frame=CGRectMake(_shop_content.frame.origin.x,CGRectGetMaxY(_shop_headimage.frame)-33, 33, 33);
    [_minusBtn setImage:[UIImage imageNamed:@"减_默认"] forState:UIControlStateNormal];
    self.minusBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.minusBtn addTarget:self action:@selector(minusBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    _stepperView = [[StepperView alloc] initWithFrame:CGRectMake(_shop_content.frame.origin.x, CGRectGetMaxY(_shop_headimage.frame)-kZoom6pt(25), kZoom6pt(100), kZoom6pt(25))];
    [self.contentView addSubview:_stepperView];
    //_stepperView.value = model.shopNumber;
    _stepperView.minimumValue = 1;
    _stepperView.maximumValue = 2;
    _stepperView.stepValue = 1;
    
    
    self.editeBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [_editeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _editeBtn.imageView.contentMode=UIViewContentModeScaleAspectFit;
    [_editeBtn setImage:[UIImage imageNamed:@"icon_close"] forState:UIControlStateNormal];
    [_editeBtn addTarget:self action:@selector(editeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    self.editeBtn.frame=CGRectMake(kScreenWidth-ZOOM(200), CGRectGetMaxY(_stepperView.frame)-kZoom6pt(25), ZOOM(200), kZoom6pt(25));
    self.editeBtn.contentEdgeInsets=UIEdgeInsetsMake(0,ZOOM(80), 0, 0);
    [self.contentView addSubview:self.editeBtn];
    
    /*
    self.editeBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    self.editeBtn.frame=CGRectMake(kScreenWidth-ZOOM(200), 0, ZOOM(200), ZOOM(120));
    self.editeBtn.titleEdgeInsets=UIEdgeInsetsMake(ZOOM(15), 0, 0, 0);
    [_editeBtn setTitleColor:kMainTitleColor forState:UIControlStateNormal];
    [_editeBtn setTitle:@"｜编辑" forState:UIControlStateNormal];
    [_editeBtn setTitle:@"｜完成" forState:UIControlStateSelected];
//    _editeBtn.backgroundColor=DRandomColor;
    [_editeBtn addTarget:self action:@selector(editeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    */
    
    self.deleteImg=[UIButton buttonWithType:UIButtonTypeCustom];
    self.deleteImg.frame = CGRectMake(kScreenWidth-ZOOM(35)-ZOOM6(80),CGRectGetMaxY(_minusBtn.frame)-ZOOM6(80), ZOOM6(80),ZOOM6(80));
    [_deleteImg setBackgroundColor:tarbarrossred];
    [_deleteImg setTitle:@"智能分享" forState:UIControlStateNormal];
    [_deleteImg setTitle:@"删除" forState:UIControlStateSelected];
    _deleteImg.lineBreakMode=NSLineBreakByWordWrapping;
    [_deleteImg addTarget:self action:@selector(deleteImgClick) forControlEvents:UIControlEventTouchUpInside];
    


    
    self.numTextField=[[UITextField alloc]initWithFrame:CGRectMake(_minusBtn.frame.origin.x+_minusBtn.frame.size.width+3, _minusBtn.frame.origin.y, 62, 33)];
    _numTextField.layer.borderWidth=1;
    _numTextField.textAlignment=NSTextAlignmentCenter;
    _numTextField.backgroundColor=[UIColor whiteColor];
    
    self.plusBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    _plusBtn.frame=CGRectMake(_numTextField.frame.origin.x+_numTextField.frame.size.width+3, _minusBtn.frame.origin.y, 33, 33);
    [_plusBtn setImage:[UIImage imageNamed:@"加_默认"] forState:UIControlStateNormal];
    [_plusBtn addTarget:self action:@selector(plusBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    self.shop_num=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(_deleteImg.frame)-80-ZOOM(42), _shop_se_price.frame.origin.y, 80, 21)];
    _shop_num.textAlignment=NSTextAlignmentRight;
    
    //[self.contentView addSubview:_selectbtn];
    [self.contentView addSubview:_shop_headimage];
    [self.contentView addSubview:_shop_content];
    [self.contentView addSubview:_shop_color_size];
    [self.contentView addSubview:_shop_se_price];
    [self.contentView addSubview:_shop_price];
    //[self.contentView addSubview:_shop_num];
    //[self.contentView addSubview:_editeBtn];
    //[self.contentView addSubview:_deleteImg];
    [self.contentView addSubview:_minusBtn];
    [self.contentView addSubview:_plusBtn];
    [self.contentView addSubview:_numTextField];
    [self.contentView addSubview:_grayImage];
    
    
    self.bottomView=[[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_shop_headimage.frame), kScreenWidth, ZOOM6(80)+ZOOM6(50))];
    
    UILabel *line=[[UILabel alloc]initWithFrame:CGRectMake(0, ZOOM6(30), kScreenWidth, 1)];
    line.backgroundColor=kTableLineColor;
    [_bottomView addSubview:line];
    
    self.bottomLabel=[[UILabel alloc]initWithFrame:CGRectMake(ZOOM(42), CGRectGetHeight(_bottomView.frame)-ZOOM6(80)-ZOOM6(20), kScreenWidth, ZOOM6(80))];
    _bottomLabel.textColor=kMainTitleColor;
    _bottomLabel.font=[UIFont systemFontOfSize:ZOOM6(24)];
    self.bottomMoney=[[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth/2-ZOOM(35), CGRectGetHeight(_bottomView.frame)-ZOOM6(80)-ZOOM6(20), kScreenWidth/2, ZOOM6(80))];
    _bottomMoney.textAlignment=NSTextAlignmentRight;
    _bottomMoney.textColor=kMainTitleColor;
    _bottomMoney.font=[UIFont systemFontOfSize:ZOOM6(30)];
    [_bottomView addSubview:_bottomLabel];
    [_bottomView addSubview:_bottomMoney];
    [self.contentView addSubview:_bottomView];
    
    UILabel *line2=[[UILabel alloc]initWithFrame:CGRectMake(0, _bottomView.frame.size.height-ZOOM6(20), kScreenWidth, ZOOM6(20))];
    line2.backgroundColor=kBackgroundColor;
    [_bottomView addSubview:line2];
    
}

-(void)setFrame:(CGRect)frame
{
    super.frame = frame;
    
    
    self.numTextField.layer.borderColor=lineGreyColor.CGColor;
    self.plusBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    self.shop_content.font = firstFont;
    self.shop_color_size.font = [UIFont systemFontOfSize:ZOOM6(24)];
    self.shop_se_price.font=firstFont;
    self.shop_price.font=[UIFont systemFontOfSize:ZOOM6(24)];
    self.shop_depreciate.font=firstFont;
    self.shop_num.font=[UIFont systemFontOfSize:ZOOM6(24)];
    self.changNumLabel.font=[UIFont systemFontOfSize:ZOOM(42)];
    _editeBtn.titleLabel.font=firstFont;
    _deleteImg.titleLabel.font=firstFont;
    
    
//    self.shop_content.textColor=kMainTitleColor;
//    self.shop_se_price.textColor=kMainTitleColor;
    
//    _grayLabel.frame=CGRectMake(CGRectGetMinX(_shop_headimage.frame),CGRectGetMaxY(_shop_headimage.frame)-ZOOM(80), _shop_headimage.frame.size.width, ZOOM(80));


}
-(void)plusBtnClick{
    if (self.addBlock) {
        self.addBlock();
    }
}
-(void)minusBtnClick{
    if (self.reduceBlock) {
        self.reduceBlock();
    }
}
-(void)selectbtnClick{
    if (self.btnSelectBlock) {
        self.btnSelectBlock();
    }
}
-(void)editeBtnClick{
    if (self.editeBlock) {
        self.editeBlock();
    }
}
-(void)deleteImgClick{
    if (self.deleteBlock) {
        self.deleteBlock();
    }
}


-(void)refreshData:(ShopDetailModel*)model
{
    NSURL *imgUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@/%@/%@!180",[NSObject baseURLStr_Upy],[MyMD5 pictureString:model.shop_code],model.def_pic]];
    
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
    self.shop_se_price.text=[NSString stringWithFormat:@"¥%.1f",[model.shop_se_price floatValue]];
    NSString *str = [model.shop_color stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    self.shop_price.text=[NSString stringWithFormat:@"¥%.1f",[model.shop_price floatValue]];

    _shop_num.text=[NSString stringWithFormat:@"x%d",[model.shop_num intValue]];
    _stepperView.value = [model.shop_num intValue];
    NSString *oldPrice = [NSString stringWithFormat:@"¥%.1f",[model.shop_price floatValue]];
    NSUInteger length = [oldPrice length];
    NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:oldPrice];
    [attri addAttribute:NSStrikethroughStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlinePatternSolid | NSUnderlineStyleSingle] range:NSMakeRange(0, length)];
    [attri addAttribute:NSStrikethroughColorAttributeName value:[UIColor lightGrayColor] range:NSMakeRange(0, length)];
    [self.shop_price setAttributedText:attri];
    
//    NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:ZOOM(46)]};
//    CGSize textSize = [self.shop_price.text boundingRectWithSize:CGSizeMake(1000, 1000) options:NSStringDrawingTruncatesLastVisibleLine attributes:attributes context:nil].size;
//    
//    self.line.frame = CGRectMake(self.shop_price.frame.origin.x, self.shop_price.frame.origin.y+_shop_price.frame.size.height/2, textSize.width, 1);
    
    
    if (model.p_code!=nil&&model.p_type!=nil) {
        self.shop_color_size.hidden=YES;
    }else{
        self.shop_color_size.hidden=NO;
        self.shop_color_size.text=[NSString stringWithFormat:@"颜色:%@ 尺码:%@",str,model.shop_size];
        float kickback=[model.kickback floatValue]*[model.shop_num integerValue];
//        if(kickback<1){
//            self.bottomLabel.text=[NSString stringWithFormat:@"可使用抵用券¥%.1f",kickback *[model.shop_se_price floatValue]];
//        }else{
            self.bottomLabel.text=[NSString stringWithFormat:@"可使用抵用券¥%d",(int)kickback];
//        }
    }
   
//    _bottomMoney.attributedText=[NSString getOneColorInLabel:[NSString stringWithFormat:@"总计:¥%.1f",[model.shop_se_price floatValue]] ColorString:[NSString stringWithFormat:@"¥%.1f",[model.shop_se_price floatValue]] Color:tarbarrossred fontSize:ZOOM6(30)];
    _bottomMoney.attributedText=[NSString getOneColorInLabel:[NSString stringWithFormat:@"总计:¥%.1f",[model.shop_num intValue]*[model.shop_se_price floatValue]] ColorString:[NSString stringWithFormat:@"¥%.1f",[model.shop_num intValue]*[model.shop_se_price floatValue]] Color:tarbarrossred fontSize:ZOOM6(30)];

    _shop_depreciate.frame=CGRectMake(_shop_headimage.frame.origin.x, _shop_headimage.frame.origin.y+_shop_headimage.frame.size.height+ZOOM6(30),[self getWidth:_shop_depreciate.text], _shop_depreciate.frame.size.height);
    _changNumLabel.frame=CGRectMake(kScreenWidth-ZOOM(42)-_changNumLabel.frame.size.width, _shop_depreciate.frame.origin.y, _changNumLabel.frame.size.width, _changNumLabel.frame.size.height);
//    _shop_num.frame=CGRectMake(CGRectGetMinX(_changNumLabel.frame)-[self getWidth:_shop_num.text], _shop_depreciate.frame.origin.y, [self getWidth:_shop_num.text], _shop_num.frame.size.height);
    
    [self changeColor:(model.isGray.intValue||model.is_del.intValue)];
    
}
-(CGFloat)getWidth:(NSString *)str
{
    CGSize labelSize = [str boundingRectWithSize:CGSizeMake(1000, 999) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:ZOOM(60)] } context:nil].size;
    return labelSize.width;
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
-(void)changeColor:(int)vaild
{
    
    _shop_content.textColor=vaild?kGrayColor:kMainTitleColor;
    _shop_price.textColor=vaild ? kGrayColor : kTextColor;
    _shop_se_price.textColor=vaild ? kGrayColor : kMainTitleColor;
    _shop_color_size.textColor=vaild ? kGrayColor : kTextColor;
    _shop_depreciate.textColor=vaild ? kGrayColor : [UIColor blackColor];
    _shop_num.textColor=vaild ? kGrayColor : [UIColor blackColor];
    _grayLabel.hidden=!vaild;
    _grayImage.hidden=!vaild;

    //    [_deleteImg setBackgroundColor:vaild ? kGrayColor : tarbarrossred];
    
    if (vaild) {
        _shop_num.textColor=kGrayColor;
    }
}
-(void)setNumberBlock:(void (^)(NSInteger))numberBlock{
    _stepperView.valueChangeBlock=numberBlock;
}

@end



@implementation StepperView
{
    UILabel *titleLabel;
    UIButton *incrementBtn;
    UIButton *decrementBtn;
}
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        incrementBtn = [self buttonWithImg:@"icon_jian" sImg:@"icon_jian_disable" tag:2001];
        decrementBtn = [self buttonWithImg:@"icon_jia" sImg:@"" tag:2002];
        titleLabel = [self labelWithString:@"20" color:[UIColor colorWithWhite:62/255. alpha:1.]];
        titleLabel.font = [UIFont systemFontOfSize:kZoom6pt(15)];
        [self addSubview:incrementBtn];
        [self addSubview:decrementBtn];
        [self addSubview:titleLabel];
        self.layer.borderWidth = 0.5f;
        self.layer.borderColor = [UIColor colorWithWhite:168/255. alpha:1.].CGColor;
        self.minimumValue = 0;
        self.maximumValue = 100;
        self.stepValue = 1;
        self.value = 0;
    }
    return self;
}

- (UILabel *)labelWithString:(NSString *)string color:(UIColor *)color{
    UILabel *label = [[UILabel alloc] init];
    label.textColor = color;
    label.textAlignment = NSTextAlignmentCenter;
    label.layer.borderWidth = 0.5f;
    label.layer.borderColor = [UIColor colorWithWhite:168/255. alpha:1.].CGColor;
    label.text = string;
    return label;
}

- (UIButton *)buttonWithImg:(NSString *)imgName sImg:(NSString *)sImgName tag:(NSInteger)tag {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:imgName] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:imgName] forState:UIControlStateNormal|UIControlStateHighlighted];
    if (sImgName.length) {
        [btn setImage:[UIImage imageNamed:sImgName] forState:UIControlStateSelected];
        [btn setImage:[UIImage imageNamed:sImgName] forState:UIControlStateSelected|UIControlStateHighlighted];
    }
    btn.tag = tag;
    [btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    return btn;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat width = self.frame.size.width;
    CGFloat height = self.frame.size.height;
    incrementBtn.frame = CGRectMake(0, 0, height, height);
    titleLabel.frame = CGRectMake(height, 0, width - height*2, height);
    decrementBtn.frame = CGRectMake(width - height, 0, height, height);
}

- (void)click:(UIButton *)sender {
    switch (sender.tag) {
        case 2001:
            if (!sender.selected) {
                self.value -= self.stepValue;
                if (_valueChangeBlock) {
                    _valueChangeBlock(self.value);
                }
            }
            break;
        case 2002:
            if (!sender.selected) {
                if ([ShopCarManager sharedManager].p_count<20) {
                    if (self.value >= self.maximumValue) {
                        [MBProgressHUD show:@"抱歉，数量有限，最多只能购买2件噢！" icon:nil view:nil];
                    }else{
                        self.value += self.stepValue;
                        if (_valueChangeBlock) {
                            _valueChangeBlock(self.value);
                        }
                    }
                }else
                    [MBProgressHUD show:@"亲,购物车最多只能放入20件商品" icon:nil view:nil];
            }
            break;
        default:
            break;
    }
    
}

- (void)setValue:(NSInteger)value {
    _value = value;
    titleLabel.text = [NSString stringWithFormat:@"%ld",(long)_value];
    incrementBtn.selected = NO;
    incrementBtn.userInteractionEnabled = YES;
    decrementBtn.selected = NO;
    decrementBtn.userInteractionEnabled = YES;
    if (_value <= _minimumValue) {
        incrementBtn.selected = YES;
        //incrementBtn.userInteractionEnabled = NO;
    }
    
    if (_value >= _maximumValue) {
       // decrementBtn.selected = YES;
        //decrementBtn.userInteractionEnabled = NO;
    }
}

- (void)setMinimumValue:(NSInteger)minimumValue {
    _minimumValue = minimumValue;
    if (_value < minimumValue) {
        _value = minimumValue;
    }
    [self setValue:_value];
}

- (void)setMaximumValue:(NSInteger)maximumValue {
    _maximumValue = maximumValue;
    if (_value > maximumValue) {
        _value = maximumValue;
    }
    [self setValue:_value];
}

- (void)setStepValue:(NSInteger)stepValue {
    _stepValue = stepValue;
    [self setValue:_value];
}

@end
