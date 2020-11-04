//
//  RejoinCartCell.m
//  YunShangShiJi
//
//  Created by yssj on 16/6/20.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import "RejoinCartCell.h"
#import "GlobalTool.h"
#import "MyMD5.h"
#import "UIImageView+WebCache.h"
#import "DefaultImgManager.h"

#define firstFont [UIFont systemFontOfSize:ZOOM6(30)]
#define spaceHeight [self calculateSpaceHeight]
#define kGrayColor [UIColor lightGrayColor]
#define DefaultImg(size) [[DefaultImgManager sharedManager] defaultImgWithSize:(size)]

@implementation RejoinCartCell

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
    self.shop_headimage=[[UIImageView alloc]init];
    self.grayImage=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"sold-out@2x-min"]];_grayImage.hidden=YES;
    
    _shop_headimage.contentMode=UIViewContentModeScaleAspectFill;
    _shop_headimage.clipsToBounds=YES;
    _shop_headimage.backgroundColor=kBackgroundColor;
    self.shop_content=[[UILabel alloc]init];
    self.shop_content.textColor=kMainTitleColor;
    self.shop_color_size=[[UILabel alloc]init];
    self.shop_se_price=[[UILabel alloc]init];
    self.shop_se_price.textColor=kMainTitleColor;
    self.shop_price=[[UILabel alloc]init];
    self.shop_num=[[UILabel alloc]init];
    self.editeBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [_editeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _editeBtn.imageView.contentMode=UIViewContentModeScaleAspectFit;
    [_editeBtn setImage:[UIImage imageNamed:@"icon_close"] forState:UIControlStateNormal];
        [_editeBtn addTarget:self action:@selector(editeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    self.editeBtn.contentEdgeInsets=UIEdgeInsetsMake(0,ZOOM(80), 0, 0);

    _shop_se_price.textAlignment=NSTextAlignmentRight;
    _shop_price.textAlignment=NSTextAlignmentRight;
    
    self.deleteImg=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    [_deleteImg setTitle:@"重新加入" forState:UIControlStateNormal];
    [_deleteImg setTintColor:tarbarrossred];
    _deleteImg.layer.borderWidth=1;
    _deleteImg.layer.borderColor=tarbarrossred.CGColor;
    _deleteImg.layer.cornerRadius=3;
    [_deleteImg addTarget:self action:@selector(deleteImgClick) forControlEvents:UIControlEventTouchUpInside];
    self.shop_headimage.frame=CGRectMake(ZOOM(42), ZOOM6(30), ZOOM6(140), ZOOM6(140));
    self.grayImage.frame=CGRectMake(ZOOM(42), ZOOM6(30), ZOOM6(140), ZOOM6(140));


    self.line=[[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_shop_headimage.frame)+ZOOM6(30)-1, kScreenWidth, 1)];
    _line.backgroundColor=kTableLineColor;
    [self.contentView addSubview:_line];

//    self.bottomView=[[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_shop_headimage.frame), kScreenWidth, ZOOM6(100))];
//    _bottomLabel=[[UILabel alloc]initWithFrame:CGRectMake(ZOOM(54), 0, kScreenWidth, _bottomView.frame.size.height)];
//    _bottomLabel.textColor=kMainTitleColor;
//    
//    _bottomBtn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
//    _bottomBtn.frame=CGRectMake(kScreenWidth-ZOOM(35)-ZOOM6(160),CGRectGetHeight(_bottomView.frame)/2-ZOOM6(50)/2, ZOOM6(160),ZOOM6(50));
//    [_bottomBtn setTitle:@"重新加入" forState:UIControlStateNormal];
//    [_bottomBtn addTarget:self action:@selector(bottomBtnClick) forControlEvents:UIControlEventTouchUpInside];
//    [_bottomBtn setTintColor:tarbarrossred];
//    _bottomBtn.layer.borderWidth=1;
//    _bottomBtn.layer.borderColor=tarbarrossred.CGColor;
//    _bottomBtn.layer.cornerRadius=3;
//    [_bottomView addSubview:_bottomLabel];
//    [_bottomView addSubview:_bottomBtn];
//    UIView *line=[[UIView alloc]initWithFrame:CGRectMake(0, _bottomView.frame.size.height-1, kScreenWidth, 1)];
//    line.backgroundColor=kTableLineColor;
//    [_bottomView addSubview:line];

    [self.contentView addSubview:_selectbtn];
    [self.contentView addSubview:_shop_headimage];
    [self.contentView addSubview:_grayImage];
    [self.contentView addSubview:_shop_content];
    [self.contentView addSubview:_shop_color_size];
    [self.contentView addSubview:_shop_se_price];
    [self.contentView addSubview:_shop_price];
    [self.contentView addSubview:_shop_num];
    [self.contentView addSubview:_editeBtn];
    [self.contentView addSubview:_deleteImg];

//    _bottomView.hidden=YES;
//    [self.contentView addSubview:_bottomView];

//    NSMutableAttributedString *string=[[NSMutableAttributedString alloc]init];
//    NSAttributedString *str=[RejoinCartCell getOneColorInLabel:@"总计：¥252.7" ColorString:@"¥252.7" Color:tarbarrossred fontSize:ZOOM6(30) withOrigalFontSize:ZOOM6(30)];
//    NSAttributedString *str2=[RejoinCartCell getOneColorInLabel:@"   搭配购买享受9折优惠" ColorString:@"9折" Color:tarbarrossred fontSize:ZOOM6(24) withOrigalFontSize:ZOOM6(24)];
//    [string appendAttributedString:str];
//    [string appendAttributedString:str2];
//    [_bottomLabel setAttributedText:string];
    
    
    self.shop_content.font = firstFont;
    self.shop_color_size.font = [UIFont systemFontOfSize:ZOOM6(24)];
    self.shop_se_price.font=firstFont;
    self.shop_price.font=[UIFont systemFontOfSize:ZOOM6(24)];
    self.shop_depreciate.font=firstFont;
    self.shop_num.font=[UIFont systemFontOfSize:ZOOM6(24)];
    self.changNumLabel.font=[UIFont systemFontOfSize:ZOOM(42)];
    _editeBtn.titleLabel.font=firstFont;
    
    
    self.selectbtn.frame=CGRectMake(0,0,ZOOM(70)+ZOOM(30), ZOOM6(30)*2+ZOOM6(140));
    self.selectbtn.imageEdgeInsets = UIEdgeInsetsMake(0,ZOOM(30),0.0f,0.2f);
    
    /*
    _grayLabel.frame=CGRectMake(CGRectGetMinX(_shop_headimage.frame),CGRectGetMaxY(_shop_headimage.frame)-ZOOM(80), _shop_headimage.frame.size.width, ZOOM(80));
    // self.editeBtn.frame=CGRectMake(kScreenWidth-ZOOM(200), self.shop_headimage.frame.origin.y-ZOOM(150)/3, ZOOM(200), ZOOM(150));
    self.editeBtn.frame=CGRectMake(kScreenWidth-ZOOM(200), CGRectGetMaxY(_shop_headimage.frame)-kZoom6pt(25), ZOOM(200), kZoom6pt(25));
    _shop_content.frame = CGRectMake(_shop_headimage.frame.origin.x+_shop_headimage.frame.size.width+ZOOM(32),_shop_headimage.frame.origin.y, kScreenWidth-CGRectGetMaxX(_shop_headimage.frame)-ZOOM(32)-60-ZOOM(35),ZOOM(50));
    
    
    _shop_color_size.frame=CGRectMake(_shop_content.frame.origin.x,CGRectGetMidY(_shop_headimage.frame)-13 , 180, 21);
    _shop_se_price.frame=CGRectMake(kScreenWidth-ZOOM(35)-60, _shop_content.frame.origin.y , 60, _shop_content.frame.size.height);
    _shop_price.frame=CGRectMake(_shop_se_price.frame.origin.x, _shop_color_size.frame.origin.y, 60, 21);
    //_shop_se_price.frame=CGRectMake(_shop_content.frame.origin.x, CGRectGetMaxY(_shop_headimage.frame)-21 , 72, 21);
    //_shop_price.frame=CGRectMake(_shop_se_price.frame.origin.x+_shop_se_price.frame.size.width+3, _shop_se_price.frame.origin.y, 60, 21);
    
    _shop_depreciate.frame=CGRectMake(_shop_headimage.frame.origin.x, _shop_headimage.frame.origin.y+_shop_headimage.frame.size.height+ZOOM6(30), 215, 21);
    _changNumLabel.frame=CGRectMake(kScreenWidth-ZOOM(42)-ZOOM(120), _shop_depreciate.frame.origin.y, ZOOM(120), 21);
    
    // self.deleteImg.frame = CGRectMake(kScreenWidth-ZOOM(35)-ZOOM6(180),CGRectGetMaxY(_shop_se_price.frame)-ZOOM6(60), ZOOM6(180),ZOOM6(60));
    self.deleteImg.frame = CGRectMake(_shop_content.frame.origin.x,CGRectGetMaxY(_shop_headimage.frame)-ZOOM6(50), ZOOM6(180),ZOOM6(60));
    */
    //_shop_content.backgroundColor=DRandomColor;
    //_shop_se_price.backgroundColor=DRandomColor;
    //_shop_color_size.backgroundColor=DRandomColor;
    //_shop_se_price.backgroundColor=DRandomColor;
    [_shop_headimage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset((ZOOM6(30)));
        make.left.offset(ZOOM(42));
        //make.width.height.offset(ZOOM6(140));
        make.bottom.offset(-ZOOM6(30));
        make.width.equalTo(_shop_headimage.mas_height);
    }];
    [_grayImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(_shop_headimage);
    }];
    [_shop_content mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_shop_headimage);
        make.left.equalTo(_shop_headimage.mas_right).offset(ZOOM(30));
    }];
    [_deleteImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_shop_content);
        make.bottom.equalTo(_shop_headimage.mas_bottom).offset(5);
        make.width.mas_equalTo(ZOOM6(180));
        make.height.mas_equalTo(ZOOM6(60));
    }];
    [_shop_color_size mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_shop_content.mas_bottom).offset(-ZOOM6(7));
        make.bottom.equalTo(_deleteImg.mas_top);
        make.left.equalTo(_shop_content);
        make.height.mas_equalTo(ZOOM6(60));
       // make.height.equalTo(_shop_content).offset(ZOOM6(7));
    }];
    [_shop_se_price mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_shop_content.mas_right);
        make.top.equalTo(_shop_content);
        make.right.offset(-ZOOM(35));
        make.width.mas_equalTo(60);
        make.height.equalTo(_shop_content);
    }];
    [_shop_price mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(_shop_se_price);
        make.centerY.equalTo(_shop_color_size.mas_centerY);
    }];
    [_editeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(0);
        make.bottom.equalTo(_shop_headimage);
        make.height.mas_equalTo(kZoom6pt(25));
        make.width.mas_equalTo(ZOOM(200));
    }];
    [_line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_shop_headimage.mas_bottom).offset(ZOOM6(30));
        make.left.right.offset(0);
        make.height.offset(1);
    }];
}
+ (NSMutableAttributedString *)getOneColorInLabel:(NSString *)allstring ColorString:(NSString *)string Color:(UIColor*)color fontSize:(float)size withOrigalFontSize:(float)OrigalSize
{
    NSMutableAttributedString *allString = [[NSMutableAttributedString alloc]initWithString:allstring];
    NSRange stringRange = [allstring rangeOfString:string];
    NSMutableDictionary *stringDict = [NSMutableDictionary dictionary];
    [stringDict setObject:color forKey:NSForegroundColorAttributeName];
    [stringDict setObject:[UIFont systemFontOfSize:size] forKey:NSFontAttributeName];
    [allString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:OrigalSize] range:NSMakeRange(0, allString.length)];
    [allString setAttributes:stringDict range:stringRange];
    
    return allString;
}
-(void)setFrame:(CGRect)frame
{
    super.frame = frame;
    

   

}

-(void)editeBtnClick
{
    if (self.DeleteBlock) {
        self.DeleteBlock();
    }
}
-(void)deleteImgClick
{
    if (self.RejoinBlock) {
        self.RejoinBlock();
    }
}
/*
-(void)bottomBtnClick
{
    if (self.bottomBtnBlock) {
        self.bottomBtnBlock();
    }
}
*/

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
    //    self.shop_num.textColor=tarbarrossred;
    //    NSMutableAttributedString *noteStr =[[NSMutableAttributedString alloc]initWithString: [NSString stringWithFormat:@"折后价:¥%.1f",model.shop_se_price.floatValue]];
    //    NSRange redRange = NSMakeRange(0, [[noteStr string] rangeOfString:@":"].location+1);
    //    [noteStr addAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor]} range:redRange];
    //    [self.shop_num setAttributedText:noteStr];
    
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
        CGFloat kickback=[model.kickback floatValue];
        if(kickback<1){
            self.shop_depreciate.text=[NSString stringWithFormat:@"商品返佣现金%.1f元",kickback *[model.shop_se_price floatValue]];
        }else{
            self.shop_depreciate.text=[NSString stringWithFormat:@"商品返佣现金%.1f元",kickback];
        }
    }
    /*
    _shop_depreciate.frame=CGRectMake(_shop_headimage.frame.origin.x, _shop_headimage.frame.origin.y+_shop_headimage.frame.size.height+ZOOM6(30),[self getWidth:_shop_depreciate.text], _shop_depreciate.frame.size.height);
    _changNumLabel.frame=CGRectMake(kScreenWidth-ZOOM(42)-_changNumLabel.frame.size.width, _shop_depreciate.frame.origin.y, _changNumLabel.frame.size.width, _changNumLabel.frame.size.height);
    _shop_num.frame=CGRectMake(CGRectGetMinX(_changNumLabel.frame)-[self getWidth:_shop_num.text], _shop_depreciate.frame.origin.y, [self getWidth:_shop_num.text], _shop_num.frame.size.height);
    */
    
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
    
    _shop_content.textColor=vaild ? kGrayColor : kMainTitleColor;
    _shop_price.textColor=vaild ? kGrayColor : [UIColor lightGrayColor];
    _shop_se_price.textColor=vaild ? kGrayColor : kMainTitleColor;
    _shop_color_size.textColor=vaild ? kGrayColor : kTextColor;
    _shop_depreciate.textColor=vaild ? kGrayColor : [UIColor blackColor];
    _shop_num.textColor=vaild ? kGrayColor : [UIColor blackColor];
    _grayLabel.hidden=!vaild;
    _grayImage.hidden=!vaild;
    [_deleteImg setTintColor:vaild ?kGrayColor :tarbarrossred];
    _deleteImg.layer.borderColor=vaild ?kGrayColor.CGColor :tarbarrossred.CGColor;
    
    _deleteImg.userInteractionEnabled=!vaild;
    
    if (vaild) {
        _shop_num.textColor=kGrayColor;
    }
}


@end
