//
//  ShopCartTableViewCell.m
//  YunShangShiJi
//
//  Created by ios-1 on 15/4/27.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//

#import "ShopCartTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "GlobalTool.h"
#import "MyMD5.h"
#import "DefaultImgManager.h"

#define firstFont [UIFont systemFontOfSize:ZOOM(46)]
#define spaceHeight [self calculateSpaceHeight]
#define kGrayColor [UIColor lightGrayColor]
#define DefaultImg(size) [[DefaultImgManager sharedManager] defaultImgWithSize:(size)]

@implementation ShopCartTableViewCell

-(CGFloat)calculateSpaceHeight
{
    return (ZOOM(350)-30-23*3)/3;
}
- (void)awakeFromNib {
    
    
    self.numlable.layer.borderColor=lineGreyColor.CGColor;
    self.numTextField.layer.borderColor=lineGreyColor.CGColor;
    self.plusBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    self.shop_content.font = firstFont;
    self.shop_color_size.font = [UIFont systemFontOfSize:ZOOM(44)];
    self.shop_se_price.font=firstFont;
    self.shop_price.font=firstFont;
    self.shop_depreciate.font=firstFont;
//    self.afterDiscout.font=firstFont;
    self.shop_num.font=firstFont;
    self.changNumLabel.font=[UIFont systemFontOfSize:ZOOM(42)];
    _editeBtn.titleLabel.font=firstFont;
//    _deleteImg.titleLabel.font=firstFont;
    
    self.shop_headimage.frame=CGRectMake(ZOOM(20)+ZOOM(54)+20, ZOOM(62), ZOOM(230), ZOOM(320));
    
    _grayLabel.frame=CGRectMake(CGRectGetMinX(_shop_headimage.frame),CGRectGetMaxY(_shop_headimage.frame)-ZOOM(80), _shop_headimage.frame.size.width, ZOOM(80));
//    _shop_headimage.contentMode=UIViewContentModeScaleAspectFit;
    
//    self.shareBtn.frame = CGRectMake(self.frame.size.width-ZOOM(42)-IMGSIZEW(@"智能分享"), self.shop_headimage.frame.origin.y, IMGSIZEW(@"智能分享"), IMGSIZEH(@"智能分享"));
    self.editeBtn.frame=CGRectMake(kScreenWidth-ZOOM(200), self.shop_headimage.frame.origin.y-ZOOM(150)/3, ZOOM(200), ZOOM(150));
    self.editeBtn.contentEdgeInsets=UIEdgeInsetsMake(0, 0, 0, 0);
    [self.editeBtn setTitleColor:kMainTitleColor forState:UIControlStateNormal];
//    _editeBtn.backgroundColor=DRandomColor;
    
//    self.shareBtn.contentMode=UIViewContentModeScaleAspectFit;
//    self.shareBtn.layer.cornerRadius=5;
//    self.shareBtn.clipsToBounds = YES;
//    self.minusBtn.frame = CGRectMake(self.minusBtn.frame.origin.x, self.minusBtn.frame.origin.y, IMGSIZEW(@"减_默认"), IMGSIZEH(@"减_默认"));
    self.minusBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;

//    _shop_content.backgroundColor = COLOR_RANDOM;
    
    _shop_content.frame = CGRectMake(_shop_headimage.frame.origin.x+_shop_headimage.frame.size.width+ZOOM(32),_shop_headimage.frame.origin.y, kScreenWidth-CGRectGetMaxX(_shop_headimage.frame)-ZOOM(32)-_editeBtn.frame.size.width,ZOOM(56));

    _shop_color_size.frame=CGRectMake(_shop_content.frame.origin.x,CGRectGetMidY(_shop_headimage.frame)-_shop_color_size.frame.size.height/2 , _shop_color_size.frame.size.width, _shop_color_size.frame.size.height);
    
    NSString *string = @"超值套餐";
    CGSize size=[string boundingRectWithSize:CGSizeMake(100, 30) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:ZOOM(42)]} context:nil].size;
    
    self.zeroShoppingLabel.frame=CGRectMake(_shop_content.frame.origin.x,CGRectGetMidY(_shop_headimage.frame)-_zeroShoppingLabel.frame.size.height/2 , (int)size.width+5, (int)size.height+5);
//    _zeroShoppingLabel.frame=CGRectMake(_shop_content.frame.origin.x,CGRectGetMidY(_shop_headimage.frame)-_zeroShoppingLabel.frame.size.height/2 , _zeroShoppingLabel.frame.size.width, _zeroShoppingLabel.frame.size.height);
    
//    _shop_color_size.backgroundColor = COLOR_RANDOM;
    
    _shop_se_price.frame=CGRectMake(_shop_content.frame.origin.x, CGRectGetMaxY(_shop_headimage.frame)-_shop_se_price.frame.size.height , _shop_se_price.frame.size.width, _shop_se_price.frame.size.height);
    _shop_price.frame=CGRectMake(_shop_se_price.frame.origin.x+_shop_se_price.frame.size.width+3, _shop_se_price.frame.origin.y, _shop_price.frame.size.width, _shop_price.frame.size.height);
    _minusBtn.frame=CGRectMake(_shop_content.frame.origin.x,CGRectGetMaxY(_shop_headimage.frame)-_minusBtn.frame.size.height, _minusBtn.frame.size.width, _minusBtn.frame.size.height);
    _numlable.frame=CGRectMake(_minusBtn.frame.origin.x+_minusBtn.frame.size.width+3, _minusBtn.frame.origin.y, _numlable.frame.size.width, _numlable.frame.size.height);
    _numTextField.frame=CGRectMake(_minusBtn.frame.origin.x+_minusBtn.frame.size.width+3, _minusBtn.frame.origin.y, _numlable.frame.size.width, _numlable.frame.size.height);
    _plusBtn.frame=CGRectMake(_numlable.frame.origin.x+_numlable.frame.size.width+3, _minusBtn.frame.origin.y, _plusBtn.frame.size.width, _plusBtn.frame.size.height);
    _shop_depreciate.frame=CGRectMake(_shop_headimage.frame.origin.x, _shop_headimage.frame.origin.y+_shop_headimage.frame.size.height+ZOOM(62), _shop_depreciate.frame.size.width, _shop_depreciate.frame.size.height);
    _changNumLabel.frame=CGRectMake(kScreenWidth-ZOOM(42)-_changNumLabel.frame.size.width, _shop_depreciate.frame.origin.y, ZOOM(120), _changNumLabel.frame.size.height);
    _shop_num.frame=CGRectMake(kScreenWidth-ZOOM(10)-_shop_num.frame.size.width-_changNumLabel.frame.size.width-ZOOM(42), _shop_depreciate.frame.origin.y, _shop_num.frame.size.width, _shop_num.frame.size.height);

    self.deleteImg.frame = CGRectMake(kScreenWidth-ZOOM(42)-_deleteImg.frame.size.width,CGRectGetMaxY(_minusBtn.frame)-_deleteImg.frame.size.height, _deleteImg.frame.size.width,_deleteImg.frame.size.height);
//    self.deleteImg.contentMode =UIViewContentModeScaleAspectFit;
//    self.deleteBtn.frame = CGRectMake(self.frame.size.width-ZOOM(84)-_minusBtn.frame.size.width, self.minusBtn.frame.origin.y, _minusBtn.frame.size.width+ZOOM(84),_minusBtn.frame.size.height+ZOOM(42));
//    self.deleteBtn.backgroundColor=DRandomColor;
//    self.shareBtn.frame=CGRectMake(self.frame.size.width-ZOOM(84)-_minusBtn.frame.size.width, self.minusBtn.frame.origin.y, _minusBtn.frame.size.width+ZOOM(84),_minusBtn.frame.size.height+ZOOM(42));
    
//    _selectbtn.frame=CGRectMake(0,0,ZOOM(70)+ZOOM(30), ZOOM(62)*2+ZOOM(350));
//    _selectbtn.imageEdgeInsets = UIEdgeInsetsMake(0,ZOOM(30),0.0f,0.2f);
//    _selectbtn.backgroundColor=DRandomColor;
    
    _bottomLine.frame=CGRectMake(0, _shop_depreciate.frame.origin.y+_shop_depreciate.frame.size.height+ZOOM(62), kScreenWidth, 1);
    _bottomLine.backgroundColor=kTableLineColor;
}
-(void)changFrame:(NSString *)str
{
    NSString * labelStr = str;
    //    CGSize labelSize = {0, 0};
    //    labelSize = [labelStr sizeWithFont:[UIFont systemFontOfSize:ZOOM(46)]
    //                     constrainedToSize:CGSizeMake(200.0, 5000)
    //                         lineBreakMode:UILineBreakModeWordWrap];
//    NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:ZOOM(46)]};
//    CGSize textSize = [labelStr boundingRectWithSize:CGSizeMake(_shop_content.frame.size.width, 100) options:NSStringDrawingTruncatesLastVisibleLine attributes:attributes context:nil].size;
    
    //14 为UILabel的字体大小
    
    //200为UILabel的宽度，5000是预设的一个高度，表示在这个范围内
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    NSDictionary *attributes1 = @{NSFontAttributeName:[UIFont systemFontOfSize:ZOOM(46)], NSParagraphStyleAttributeName:paragraphStyle.copy};
    
    CGSize labelSize = [labelStr boundingRectWithSize:CGSizeMake(_shop_content.frame.size.width, 999) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes1 context:nil].size;
    
    _shop_content.numberOfLines = 0;//表示label可以多行显示
    
//    _shop_content.lineBreakMode = UILineBreakModeCharacterWrap;//换行模式，与上面的计算保持一致。
//    //textsize%f",labelSize.height);
    _shop_content.frame = CGRectMake(_shop_content.frame.origin.x, ZOOM(62), _shop_content.frame.size.width, labelSize.height);//保持原来Label的位置和宽度，只是改变高度
    

    _shop_color_size.frame=CGRectMake(_shop_content.frame.origin.x, _shop_content.frame.origin.y+_shop_content.frame.size.height+ZOOM(10), _shop_color_size.frame.size.width, _shop_color_size.frame.size.height);
    _shop_se_price.frame=CGRectMake(_shop_content.frame.origin.x, _shop_color_size.frame.origin.y+_shop_color_size.frame.size.height+ZOOM(10), _shop_se_price.frame.size.width, _shop_se_price.frame.size.height);
    _shop_price.frame=CGRectMake(_shop_se_price.frame.origin.x+_shop_se_price.frame.size.width+10, _shop_se_price.frame.origin.y, _shop_price.frame.size.width, _shop_price.frame.size.height);
    _minusBtn.frame=CGRectMake(_shop_content.frame.origin.x, _shop_se_price.frame.origin.y+_shop_se_price.frame.size.height+ZOOM(10), _minusBtn.frame.size.width, _minusBtn.frame.size.height);
    _numlable.frame=CGRectMake(_minusBtn.frame.origin.x+_minusBtn.frame.size.width+3, _minusBtn.frame.origin.y, _numlable.frame.size.width, _numlable.frame.size.height);
    _numTextField.frame=CGRectMake(_minusBtn.frame.origin.x+_minusBtn.frame.size.width+3, _minusBtn.frame.origin.y, _numlable.frame.size.width, _numlable.frame.size.height);
    _plusBtn.frame=CGRectMake(_numlable.frame.origin.x+_numlable.frame.size.width+3, _minusBtn.frame.origin.y, _plusBtn.frame.size.width, _plusBtn.frame.size.height);
//    self.editbutton.frame = CGRectMake(self.frame.size.width-ZOOM(42)-_minusBtn.frame.size.width, self.minusBtn.frame.origin.y, _minusBtn.frame.size.width,_minusBtn.frame.size.height);

    
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
    self.shop_se_price.text=@"";
    self.shop_price.text=@"";
    self.shop_num.textColor=tarbarrossred;
    NSMutableAttributedString *noteStr =[[NSMutableAttributedString alloc]initWithString: [NSString stringWithFormat:@"总价:¥%.1f",model.price.floatValue]];
    NSRange redRange = NSMakeRange(0, [[noteStr string] rangeOfString:@":"].location+1);
    [noteStr addAttributes:@{NSForegroundColorAttributeName:kMainTitleColor} range:redRange];
    [self.shop_num setAttributedText:noteStr];
    
    
    self.line.hidden=YES;
    self.zeroShoppingLabel.hidden=YES;
    _shop_se_price.hidden=YES;_shop_price.hidden=YES;
    
    if (model.shop_list.count==1) {
        self.zeroShoppingLabel.text=@"超值单品";
    }else
        self.zeroShoppingLabel.text=@"超值套餐";
    for (int i=0; i<model.shop_list.count; i++) {
        if (i==0) {
            ShopDetailModel* colorModel=model.shop_list[0];
            self.shop_color_size.text=[NSString stringWithFormat:@"商品1:%@",colorModel.shop_color];
//            self.shop_color_size.text=[NSString stringWithFormat:@"商品1:%@",model.shop_list[0][@"color"]];
            
        }else if (i==1){
            _shop_price.hidden=NO;
            ShopDetailModel* colorModel=model.shop_list[1];
            self.shop_price.text=[NSString stringWithFormat:@"商品2:%@",colorModel.shop_color];

//            self.shop_price.text=[NSString stringWithFormat:@"商品2:%@",model.shop_list[1][@"color"]];
            _shop_price.textColor=_shop_color_size.textColor;
        }else if(i==2){
            _shop_se_price.hidden=NO;
            ShopDetailModel* colorModel=model.shop_list[2];
            self.shop_se_price.text=[NSString stringWithFormat:@"商品3:%@",colorModel.shop_color];

//            self.shop_se_price.text=[NSString stringWithFormat:@"商品3:%@",model.shop_list[2][@"color"]];
            _shop_se_price.textColor=_shop_color_size.textColor;
        }
    }
    self.shop_depreciate.text=[NSString stringWithFormat:@"共%lu件商品",(unsigned long)model.shop_list.count];
    [self changeColor1:(model.isGray.intValue||model.is_del.intValue)];
    CGFloat width = CGRectGetMinX(_deleteImg.frame)-_shop_se_price.frame.origin.x;
    _shop_color_size.frame=CGRectMake(_shop_content.frame.origin.x,CGRectGetMinY(_shop_headimage.frame)+CGRectGetHeight(_shop_headimage.frame)/4 ,width, ZOOM(70));
    _shop_price.frame=CGRectMake(_shop_se_price.frame.origin.x,CGRectGetMinY(_shop_headimage.frame)+CGRectGetHeight(_shop_headimage.frame)*2/4, width, ZOOM(70));
    _shop_se_price.frame=CGRectMake(_shop_content.frame.origin.x, CGRectGetMinY(_shop_headimage.frame)+CGRectGetHeight(_shop_headimage.frame)*3/4, width, ZOOM(70));
    
   
    _shop_depreciate.frame=CGRectMake(_shop_headimage.frame.origin.x, _shop_headimage.frame.origin.y+_shop_headimage.frame.size.height+ZOOM(62),[self getWidth:_shop_depreciate.text], _shop_depreciate.frame.size.height);
    _changNumLabel.frame=CGRectMake(kScreenWidth-ZOOM(42)-_changNumLabel.frame.size.width, _shop_depreciate.frame.origin.y, _changNumLabel.frame.size.width, _changNumLabel.frame.size.height);
    _shop_num.frame=CGRectMake(CGRectGetMinX(_changNumLabel.frame)-[self getWidth:_shop_num.text], _shop_depreciate.frame.origin.y, [self getWidth:_shop_num.text], _shop_num.frame.size.height);
    
    //    _shop_num.frame=CGRectMake(CGRectGetMaxX(_shop_depreciate.frame)+ZOOM(42), _shop_depreciate.frame.origin.y, [self getWidth:_shop_num.text], _shop_num.frame.size.height);
}
-(void)changeColor:(int)vaild
{
    
    _shop_content.textColor=vaild ? kGrayColor : [UIColor blackColor];
    _shop_price.textColor=vaild ? kGrayColor : [UIColor lightGrayColor];
    _shop_se_price.textColor=vaild ? kGrayColor : [UIColor blackColor];
    _shop_color_size.textColor=vaild ? kGrayColor : kTextColor;
    _shop_depreciate.textColor=vaild ? kGrayColor : [UIColor blackColor];
    _shop_num.textColor=vaild ? kGrayColor : [UIColor blackColor];
    _grayLabel.hidden=!vaild;
//    [_deleteImg setBackgroundColor:vaild ? kGrayColor : tarbarrossred];
    
    if (vaild) {
        _shop_num.textColor=kGrayColor;
    }
}
-(void)changeColor1:(int)vaild
{
    
    _shop_content.textColor=vaild ? kGrayColor : kMainTitleColor;
    _shop_price.textColor=vaild ? kGrayColor : kTextColor;
    _shop_se_price.textColor=vaild ? kGrayColor : kTextColor;
    _shop_color_size.textColor=vaild ? kGrayColor : kTextColor;
    _shop_depreciate.textColor=vaild ? kGrayColor : kMainTitleColor;
    _shop_num.textColor=vaild ? kGrayColor : kMainTitleColor;
    _grayLabel.hidden=!vaild;
//    [_deleteImg setBackgroundColor:vaild ? kGrayColor : tarbarrossred];
    
    if (vaild) {
        _shop_num.textColor=kGrayColor;
    }
}
-(void)refreshData:(ShopDetailModel*)model
{
//    [self.shop_headimage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[NSObject baseURLStr_Upy],model.def_pic]]];
    NSURL *imgUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@/%@/%@!180",[NSObject baseURLStr_Upy],[MyMD5 pictureString:model.shop_code],model.def_pic]];

//    NSURL *imgUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@!180",[NSObject baseURLStr_Upy],model.def_pic]];
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
    self.shop_num.textColor=tarbarrossred;
    NSMutableAttributedString *noteStr =[[NSMutableAttributedString alloc]initWithString: [NSString stringWithFormat:@"折后价:¥%.1f",model.shop_se_price.floatValue]];
    NSRange redRange = NSMakeRange(0, [[noteStr string] rangeOfString:@":"].location+1);
    [noteStr addAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor]} range:redRange];
    [self.shop_num setAttributedText:noteStr];
//    self.shop_num.text=[NSString stringWithFormat:@"折后价:￥%@",model.shop_se_price];
    

//    CGSize size=[self.shop_price.text sizeWithFont:[UIFont systemFontOfSize:17.0] constrainedToSize:CGSizeMake(210.0f,1000.0f ) lineBreakMode:NSLineBreakByWordWrapping];

    NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:ZOOM(46)]};
    CGSize textSize = [self.shop_price.text boundingRectWithSize:CGSizeMake(1000, 1000) options:NSStringDrawingTruncatesLastVisibleLine attributes:attributes context:nil].size;
    
    self.line.frame = CGRectMake(self.shop_price.frame.origin.x, self.shop_price.frame.origin.y+_shop_price.frame.size.height/2, textSize.width, self.line.frame.size.height);
    
    
    if (model.p_code!=nil&&model.p_type!=nil) {

        self.shop_color_size.hidden=YES;
        self.zeroShoppingLabel.hidden=NO;

//        self.shop_depreciate.text=@"共3件商品";
        
    }else{

        self.shop_color_size.hidden=NO;
        self.zeroShoppingLabel.hidden=YES;
        self.shop_color_size.text=[NSString stringWithFormat:@"颜色:%@ 尺码:%@",str,model.shop_size];
        CGFloat kickback=[model.kickback floatValue];
        if(kickback<1)
        {
            self.shop_depreciate.text=[NSString stringWithFormat:@"商品返佣现金%.1f元",kickback *[model.shop_se_price floatValue]];
        }else{
            self.shop_depreciate.text=[NSString stringWithFormat:@"商品返佣现金%.1f元",kickback];
        }
    }
    _shop_depreciate.frame=CGRectMake(_shop_headimage.frame.origin.x, _shop_headimage.frame.origin.y+_shop_headimage.frame.size.height+ZOOM(62),[self getWidth:_shop_depreciate.text], _shop_depreciate.frame.size.height);
    _changNumLabel.frame=CGRectMake(kScreenWidth-ZOOM(42)-_changNumLabel.frame.size.width, _shop_depreciate.frame.origin.y, _changNumLabel.frame.size.width, _changNumLabel.frame.size.height);
    _shop_num.frame=CGRectMake(CGRectGetMinX(_changNumLabel.frame)-[self getWidth:_shop_num.text], _shop_depreciate.frame.origin.y, [self getWidth:_shop_num.text], _shop_num.frame.size.height);

    
    [self changeColor:model.isGray.intValue];

//    _shop_num.frame=CGRectMake(CGRectGetMaxX(_shop_depreciate.frame)+ZOOM(42), _shop_depreciate.frame.origin.y, [self getWidth:_shop_num.text], _shop_num.frame.size.height);
}
-(CGFloat)getWidth:(NSString *)str
{
    CGSize labelSize = [str boundingRectWithSize:CGSizeMake(1000, 999) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:ZOOM(60)] } context:nil].size;
    return labelSize.width;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

- (IBAction)editbtn:(id)sender {
    
    
}
@end
