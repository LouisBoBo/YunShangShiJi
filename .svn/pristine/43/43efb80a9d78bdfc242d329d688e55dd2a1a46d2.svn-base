//
//  OrderTableViewCell.m
//  YunShangShiJi
//
//  Created by ios-1 on 15/7/10.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//

#import "OrderTableViewCell.h"
#import "GlobalTool.h"
#import "UIImageView+WebCache.h"
#import "MyMD5.h"
#import "DefaultImgManager.h"

#define DefaultImg(size) [[DefaultImgManager sharedManager] defaultImgWithSize:(size)]

@implementation OrderTableViewCell

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
    
    self.changeNum.layer.borderWidth = 1;
    self.changeNum.layer.borderColor = lineGreyColor.CGColor;
    self.line.backgroundColor = lineGreyColor;

//    self.title.font = [UIFont systemFontOfSize:ZOOM(40)];
//    self.color_size.font = [UIFont systemFontOfSize:ZOOM(36)];
//    self.price.font = [UIFont systemFontOfSize:ZOOM(40)];
//    self.statue.font = [UIFont systemFontOfSize:ZOOM(36)];

    self.title.font = [UIFont systemFontOfSize:ZOOM(46)];
    self.color_size.font = [UIFont systemFontOfSize:ZOOM(42)];
    self.zeroLabel.font=[UIFont systemFontOfSize:ZOOM(42)];
    self.price.font = [UIFont systemFontOfSize:ZOOM(46)];
    self.statue.font = [UIFont systemFontOfSize:ZOOM(44)];
    self.number.font = [UIFont systemFontOfSize:ZOOM(44)];
    

    self.headimage.frame=CGRectMake(ZOOM(62), ZOOM(62), ZOOM(240), ZOOM(350));
    self.headimage.backgroundColor=kBackgroundColor;
//    _headimage.contentMode=UIViewContentModeScaleAspectFit;
    self.title.frame=CGRectMake(self.headimage.frame.origin.x+self.headimage.frame.size.width+ZOOM(32),ZOOM(62), kScreenWidth, ZOOM(56));
    self.color_size.frame=CGRectMake(self.title.frame.origin.x, ZOOM(62)+self.title.frame.size.height+ZOOM(32), self.color_size.frame.size.width, self.color_size.frame.size.height);
    self.interveneBtn.frame=CGRectMake(kScreenWidth-ZOOM(42)-_interveneBtn.frame.size.width, _color_size.frame.origin.y, _interveneBtn.frame.size.width, _interveneBtn.frame.size.height);
    NSString *string = @"超值套餐";
    CGSize size=[string boundingRectWithSize:CGSizeMake(100, 30) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:ZOOM(42)]} context:nil].size;
    
    self.zeroLabel.frame=CGRectMake(self.title.frame.origin.x, ZOOM(62)+self.title.frame.size.height+ZOOM(32), (int)size.width+5, (int)size.height+5);


    self.price.frame=CGRectMake(self.title.frame.origin.x, self.color_size.frame.origin.y+self.color_size.frame.size.height+ZOOM(32), self.price.frame.size.width, self.price.frame.size.height);
    self.number.frame=CGRectMake(kScreenWidth-ZOOM(42)-self.number.frame.size.width, self.color_size.frame.origin.y, self.number.frame.size.width, self.number.frame.size.height);
    self.statue.frame=CGRectMake(kScreenWidth-ZOOM(42)-self.statue.frame.size.width, ZOOM(62), _statue.frame.size.width, ZOOM(56));

    _groupBuyImg = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, ZOOM6(40), ZOOM6(40))];
    _groupBuyImg.backgroundColor = tarbarrossred;
    _groupBuyImg.textAlignment = NSTextAlignmentCenter;
    _groupBuyImg.textColor = [UIColor whiteColor];
    _groupBuyImg.text = @"拼";
    _groupBuyImg.font = kFont6px(30);
    _groupBuyImg.hidden = YES;
    [self.headimage addSubview:_groupBuyImg];
    
    _questionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _questionBtn.frame = CGRectMake(kScreenWidth-ZOOM(42)-ZOOM6(36), self.price.y+ZOOM6(6), ZOOM6(36), ZOOM6(36));
    _questionBtn.hidden = YES;
    [_questionBtn setImage:[UIImage imageNamed:@"shop_wenhao_red"] forState:UIControlStateNormal];
    [_questionBtn setImage:[UIImage imageNamed:@"shop_wenhao_red"] forState:UIControlStateSelected];
    [_questionBtn addTarget:self action:@selector(questionBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_questionBtn];

    _moneyLabel = [[UILabel alloc]initWithFrame:CGRectMake(_questionBtn.x-ZOOM6(250), _questionBtn.y, ZOOM6(250), _questionBtn.height)];
    _moneyLabel.textAlignment = NSTextAlignmentRight;
    _moneyLabel.font = kFont6px(24);
    _moneyLabel.textColor = tarbarrossred;
    _moneyLabel.hidden = YES;
    _moneyLabel.userInteractionEnabled = YES;
    [self.contentView addSubview:_moneyLabel];
    
    self.markLabel.textColor = tarbarrossred;
    self.moneyLabel.hidden = YES;
    self.markLabel.hidden = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(questionBtnClick)];
    [_moneyLabel addGestureRecognizer:tap];
    
}
- (void)questionBtnClick {
    if (self.questionBtnBlock) {
        self.questionBtnBlock();
    }
}
-(void)changFrame:(NSString *)str
{
    NSString * labelStr = str;
    //    CGSize labelSize = {0, 0};
    //    labelSize = [labelStr sizeWithFont:[UIFont systemFontOfSize:ZOOM(46)]
    //                     constrainedToSize:CGSizeMake(200.0, 5000)
    //                         lineBreakMode:UILineBreakModeWordWrap];
    NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:ZOOM(46)]};
    CGSize textSize = [labelStr boundingRectWithSize:CGSizeMake(100, 100) options:NSStringDrawingTruncatesLastVisibleLine attributes:attributes context:nil].size;
    
    //14 为UILabel的字体大小
    
    //200为UILabel的宽度，5000是预设的一个高度，表示在这个范围内
    
    
    _title.numberOfLines = 0;//表示label可以多行显示
    
    _title.lineBreakMode = UILineBreakModeCharacterWrap;//换行模式，与上面的计算保持一致。
//    //textsize%f",textSize.height);
    _title.frame = CGRectMake(_title.frame.origin.x, ZOOM(62), _title.frame.size.width, textSize.height);//保持原来Label的位置和宽度，只是改变高度
    self.statue.frame=CGRectMake(kApplicationWidth-ZOOM(42)-self.statue.frame.size.width, ZOOM(62), self.statue.frame.size.width,textSize.height);


}
- (NSString *)exchangeTextWihtString:(NSString *)text
{
//    //text  %@",text);
    if ([[NSString stringWithFormat:@"%@",text] isEqualToString:@"<null>"]) {
        return @"";
    }

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

-(void)statusChange:(ShopDetailModel *)model
{
    //%@",model.pay_status);
    if ([model.orderShopStatus intValue]==0 && model.orderShopStatus!=nil)
    {
        switch ([model.status intValue]) {
            case 1:
                
                [_statue setText:@"待付款"];
                break;
            case 2:
                if (model.whether_prize.intValue==2) {
                    [_statue setText:@"申请发货中"];
                }else
                    [_statue setText:@"待发货"];
                
                break;
            case 3:
                [_statue setText:@"待收货"];
                break;
            case 4:
                [_statue setText:@"待评价"];
                break;
            case 5:
                [_statue setText:@"已评价"];
                break;
            case 6:
                if(model.shop_from.intValue == 10)
                {
                    [_statue setText:@"免费领未点中"];
                }else
                    [_statue setText:@"交易成功"];
                break;
            case 7:
                [_statue setText:@"延长收货"];
                break;
            case 8:
                [_statue setText:@"退款成功"];
                break;
            case 9:
                if(model.shop_from.intValue == 13)
                {
                    [_statue setText:@"订单关闭"];
                }else
                    [_statue setText:@"取消订单"];
                break;
            case 10:
                [_statue setText:@"订单已过期"];
                break;
            case 11:
                 [_statue setText:@"拼团中"];
                break;
            case 12:
//                 [_statue setText:@"待疯抢"];
                [_statue setText:@"免费领"];
                break;
            case 13:
                 [_statue setText:@"拼团失败"];
                break;
            case 14:
                 [_statue setText:@"免费领未点中"];
                break;
            case 15:
                [_statue setText:@"拼团中"];
                break;
            case 16:
                [_statue setText:@"拼团关闭"];
                break;
            case 17://中奖订单 预中间显示
                if (model.whether_prize.intValue==2) {
                    [_statue setText:@"申请发货中"];
                }
//                if(model.new_free == 1)
//                {
//                    [_statue setText:@"未中奖"];
//                }
                break;
            case 21:
                [_statue setText:@"分享中"];
                break;
            case 9999:
                [_statue setText:@"分享中"];
                break;
            default:
                break;
        }
        
    }
    else if (model.orderShopStatus.intValue == 4)
    {
        if (model.shop_from.intValue==10) {
            [_statue setText:@"免费领未点中"];
        }else
            [_statue setText:@"交易成功"];
    }
    else{

        NSMutableString *string = [[NSMutableString alloc]init];
        switch ([model.change intValue]) {
            case 1:
                [string appendString:@"换货"];
                break;
            case 2:
                [string appendString:@"退货"];
                break;
            case 3:
                [string appendString:@"退款"];
                break;
        }
        switch ([model.orderShopStatus intValue]) {
            case 1:
                [string appendString:@"处理中"];
                break;
            case 2:
                [string appendString:@"被拒绝"];
                break;
            case 3:
                [string appendString:@"已成功"];
                break;
            case 4:
                [string appendString:@"已取消"];
                break;
            default:
                break;
        }
        
        [_statue setText:string];//显示换货状态，通过商品的status 和change字段来判断s
    }
}
-(void)refreshAfterSaleData:(ShopDetailModel *)model
{
    
    NSURL *imgUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@!180",[NSObject baseURLStr_Upy],model.shop_pic]];
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
    
    
    self.color_size.text=[NSString stringWithFormat:@"颜色:%@ 尺码:%@",model.shop_color,model.shop_size];
    
    self.price.text=[NSString stringWithFormat:@"¥%.2f",model.shop_price.floatValue];
    
    self.number.text=[NSString stringWithFormat:@"x%@",model.shop_num];
    
    self.statue.textColor=tarbarrossred;
    self.number.textColor=kTextColor;
    
    
    [self statusChange:model];
    
    NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:ZOOM(44)]};
    CGSize textSize = [_statue.text boundingRectWithSize:CGSizeMake(150, 100) options:NSStringDrawingUsesLineFragmentOrigin  attributes:attributes context:nil].size;
    //%f",textSize.width);
    self.statue.frame=CGRectMake(kScreenWidth-ZOOM(42)-textSize.width, ZOOM(62), textSize.width, 21);
    self.title.frame=CGRectMake(self.headimage.frame.origin.x+self.headimage.frame.size.width+ZOOM(32),ZOOM(62), kScreenWidth-CGRectGetMaxX(_headimage.frame)-textSize.width-ZOOM(32)-ZOOM(42), ZOOM(44));
    
    self.title.text=[self exchangeTextWihtString:model.shop_name];
        
}

-(int)compareWithAnotherDay:(ShopDetailModel *)model
{
    if (model.requestNow_time!=nil) {
        return model.lasttime.doubleValue<=model.requestNow_time.doubleValue?-1:0;
    }
    return 0;
//    NSDate *publishDate = [NSDate dateWithTimeIntervalSince1970:[model.lasttime doubleValue]/1000];
//    NSDate *curDate = [NSDate dateWithTimeIntervalSince1970:[model.requestNow_time doubleValue]/1000];
//    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//    [dateFormatter setDateFormat:@"dd-MM-yyyy HH:mm:ss"];
//    NSString *oneDayStr = [dateFormatter stringFromDate:publishDate];
//    NSString *anotherDayStr = [dateFormatter stringFromDate:curDate];
//    NSDate *dateA = [dateFormatter dateFromString:oneDayStr];
//    NSDate *dateB = [dateFormatter dateFromString:anotherDayStr];
//    NSComparisonResult result = [dateA compare:dateB];
//    MyLog(@"%@ %@   %@  %@",oneDayStr,anotherDayStr,model.lasttime,model.requestNow_time);
//    if (result == NSOrderedDescending) {
//        ////Date1  is in the future");
//        return 1;
//    }
//    else if (result == NSOrderedAscending){
//        ////Date1 is in the past");
//        return -1;
//    }
//    ////Both dates are the same");
//    return -1;
    
}
-(void)refreshZeroData:(ShopDetailModel*)model
{
    //    [self.headimage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[NSObject baseURLStr_Upy],model.shop_pic]]];
    
    NSURL *imgUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@!180",[NSObject baseURLStr_Upy],model.order_pic]];
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

//    if (model.shopsArray.count==1) {
//        self.zeroLabel.text=@"超值单品";
//    }else
//        self.zeroLabel.text=@"超值套餐";
    
    //    self.price.text=[NSString stringWithFormat:@"￥%.2f",model.shop_price.floatValue];
    self.price.text=[NSString stringWithFormat:@"¥%.2f",model.order_price.floatValue-model.postage.floatValue];
    
    self.number.text=[NSString stringWithFormat:@"x1"];
    
    //    self.headimage.frame=CGRectMake(ZOOM(62), self.headimage.frame.origin.y, self.headimage.frame.size.width, self.frame.size.height);
    
    //    self.statue.font=[UIFont systemFontOfSize:14];
    self.statue.textColor=tarbarrossred;
    self.number.textColor=kTextColor;
    
    [self statusChange:model];
   
    NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:ZOOM(44)]};
    CGSize textSize = [_statue.text boundingRectWithSize:CGSizeMake(150, 100) options:NSStringDrawingTruncatesLastVisibleLine attributes:attributes context:nil].size;
    self.statue.frame=CGRectMake(kApplicationWidth-ZOOM(42)-textSize.width, ZOOM(62), textSize.width, 21);
    self.title.frame=CGRectMake(self.headimage.frame.origin.x+self.headimage.frame.size.width+ZOOM(32),ZOOM(62), kScreenWidth-CGRectGetMaxX(_headimage.frame)-textSize.width-ZOOM(32)-ZOOM(42), ZOOM(56));
    
    self.title.text=[self exchangeTextWihtString: model.order_name];
        
}
//判断夺宝订单的状态
-(void)indianaStatus:(ShopDetailModel*)model
{
    if ([self compareWithAnotherDay:model]==-1){
        [_statue setText:@"已过期"];
        return;
    }
    switch (model.issue_status.intValue) {
        case 0:
            [_statue setText:@"参与中"];
            break;
        case 1:
            [_statue setText:@"退款"];
            break;
        case 2:
            [_statue setText:@"退款"];
            break;
        case 3:
            [_statue setText:@"中奖"];
            break;
        case 4:
            [_statue setText:@"未中奖"];
            break;
        default:
            break;
    }
    
}
-(void)refreshIndianaData:(ShopDetailModel*)model
{
    NSURL *imgUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@/%@/%@!180",[NSObject baseURLStr_Upy],[MyMD5 pictureString:model.bak],model.order_pic]];
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
    MyLog(@"%.2f",model.order_price.floatValue);
    self.price.text=[NSString stringWithFormat:@"¥%.2f",model.shop_price.floatValue-model.postage.floatValue];
    self.number.text=[NSString stringWithFormat:@"x1"];
    self.statue.textColor=tarbarrossred;
    self.number.textColor=kTextColor;
    
    [self indianaStatus:model];
    
    NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:ZOOM(44)]};
    CGSize textSize = [_statue.text boundingRectWithSize:CGSizeMake(150, 100) options:NSStringDrawingTruncatesLastVisibleLine attributes:attributes context:nil].size;
    self.statue.frame=CGRectMake(kApplicationWidth-ZOOM(42)-textSize.width, ZOOM(62), textSize.width, 21);
    self.title.frame=CGRectMake(self.headimage.frame.origin.x+self.headimage.frame.size.width+ZOOM(32),ZOOM(62), kScreenWidth-CGRectGetMaxX(_headimage.frame)-textSize.width-ZOOM(32)-ZOOM(42), ZOOM(56));
    
    self.title.text=[self exchangeTextWihtString: model.order_name];
    
}
-(void)refreshData:(ShopDetailModel*)model
{
    NSURL *imgUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@/%@/%@!180",[NSObject baseURLStr_Upy],[MyMD5 pictureString:model.shop_code],model.shop_pic]];

//    NSURL *imgUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@!180",[NSObject baseURLStr_Upy],model.shop_pic]];
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
    
    NSString *isTM = [NSString stringWithFormat:@"%@",model.isTM];
    
    if(isTM.intValue==0)
    {
        self.color_size.text=[NSString stringWithFormat:@"颜色:%@ 尺码:%@",model.shop_color,model.shop_size];
    }else{
        self.color_size.text=[NSString stringWithFormat:@"%@ %@",model.shop_color!=nil?model.shop_color:@"",model.shop_size!=nil?model.shop_size:@""];
    }
    
    if(model.original_price.floatValue >0)
    {
        self.price.text=[NSString stringWithFormat:@"¥%.2f",model.original_price.floatValue];
    }else{
        self.price.text=[NSString stringWithFormat:@"¥%.2f",model.shop_price.floatValue];
    }

    self.number.text=[NSString stringWithFormat:@"x%@",model.shop_num];
    
    self.statue.textColor=tarbarrossred;
    self.number.textColor=kTextColor;
    
    [self statusChange:model];

    NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:ZOOM(47)]};
    CGSize textSize = [_statue.text boundingRectWithSize:CGSizeMake(150, 100) options:NSStringDrawingTruncatesLastVisibleLine attributes:attributes context:nil].size;
    self.statue.frame=CGRectMake(kApplicationWidth-ZOOM(42)-textSize.width, ZOOM(62), textSize.width, 21);
    self.title.frame=CGRectMake(self.headimage.frame.origin.x+self.headimage.frame.size.width+ZOOM(32),ZOOM(62), kScreenWidth-CGRectGetMaxX(_headimage.frame)-textSize.width-ZOOM(32)-ZOOM(42), ZOOM(56));
    
    self.title.text=[self exchangeTextWihtString: model.shop_name];
    
    if(model.roll_name.length >0 && ![model.roll_name isEqual:[NSNull null]] && ![model.roll_name isEqualToString:@"(null)"])
    {
        self.moneyLabel.hidden = NO;
        self.markLabel.hidden = NO;
        self.markLabel.text = [NSString stringWithFormat:@"%@已参团，可立即免费领商品",model.roll_name];
    }else if (model.status.intValue==2 && model.whether_prize.intValue==2 && model.new_free == 1)
    {
        self.moneyLabel.hidden = NO;
        self.markLabel.hidden = NO;
        self.markLabel.text = @"免费领活动订单，请接通客服申请发货";
    }else if (model.status.intValue == 17 && model.whether_prize.intValue == 2 && model.new_free == 1)
    {
        self.moneyLabel.hidden = NO;
        self.markLabel.hidden = NO;
        self.markLabel.text = @"免费领活动订单，请接通客服申请发货";
    }else if ((model.status.intValue==2 || model.status.intValue == 17) && model.whether_prize.intValue == 2 && model.new_free != 1)
    {
        self.moneyLabel.hidden = NO;
        self.markLabel.hidden = NO;
        NSString *maxvipName = [[NSUserDefaults standardUserDefaults] objectForKey:@"ordermaxvipName"];
        self.markLabel.text = [NSString stringWithFormat:@"商品超出%@可免费领的价格区间，请联系客服申请发货",maxvipName];
    }
    else if (model.status.intValue == 9999)
    {
        self.moneyLabel.hidden = NO;
        self.markLabel.hidden = NO;
        self.markLabel.text = @"实付：￥0";
    }
    else{
        self.moneyLabel.hidden = YES;
        self.markLabel.hidden = YES;
        self.moneyLabel.text = @"";
        self.markLabel.text = @"";
    }
}

-(void)refreshData1:(ShopDetailModel*)model
{
//    [self.headimage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[NSObject baseURLStr_Upy],model.shop_pic]]];
    NSURL *imgUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@/%@/%@!180",[NSObject baseURLStr_Upy],[MyMD5 pictureString:model.shop_code],model.shop_pic]];

//    NSURL *imgUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@!180",[NSObject baseURLStr_Upy],model.shop_pic]];
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
    
//    self.title.text=[self exchangeTextWihtString: model.shop_name];
    

    self.color_size.text=[NSString stringWithFormat:@"颜色:%@ 尺码:%@",model.shop_color,model.shop_size];
    
    
//    self.price.text=[NSString stringWithFormat:@"￥%@",model.shop_price];
    self.price.text=[NSString stringWithFormat:@"¥%.2f",model.shop_price.floatValue];

    self.number.text=[NSString stringWithFormat:@"x%@",model.shop_num];
    
    //    self.statue.font=[UIFont systemFontOfSize:14];
    self.statue.textColor=tarbarrossred;
    self.number.textColor=kTextColor;
    
    /*
    //订单状态
    NSString *statue;
    statue=model.status;
    switch (statue.intValue) {
        case 1:
            self.statue.text=@"待付款";
            break;
        case 2:
            self.statue.text=@"购买成功";
            break;
        case 3:
            self.statue.text=@"已发货";
            break;
        case 4:
            self.statue.text=@"交易成功";
            break;
        case 5:
            self.statue.text=@"退款中";
            break;
        case 6:
            self.statue.text=@"已经完结";
            
            break;
        case 7:
            self.statue.text=@"已延长收货";
            break;
        case 8:
            self.statue.text=@"退款成功";
            break;
        case 9:
            self.statue.text=@"已取消";
            
            break;
        default:
            break;
    }
    */
    
    
    NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:ZOOM(44)]};
    CGSize textSize = [_statue.text boundingRectWithSize:CGSizeMake(150, 100) options:NSStringDrawingTruncatesLastVisibleLine attributes:attributes context:nil].size;
    self.statue.frame=CGRectMake(kApplicationWidth-ZOOM(42)-textSize.width, ZOOM(62), textSize.width, 21);
    self.title.frame=CGRectMake(self.headimage.frame.origin.x+self.headimage.frame.size.width+ZOOM(32),ZOOM(62), kScreenWidth-CGRectGetMaxX(_headimage.frame)-textSize.width-ZOOM(32)-ZOOM(42), ZOOM(56));
    
    self.title.text=[self exchangeTextWihtString: model.shop_name];
    
}

-(void)afterOrderStatus:(ShopDetailModel *)model
{
    _interveneBtn.hidden=YES;
    NSMutableString *sb = [[NSMutableString alloc]init];

    switch ([model.orderShopStatus integerValue]) {
        case 1:
            [sb appendString:@"换货"];
            break;
        case 2:
            [sb appendString:@"退货"];
            break;
        case 3:
            [sb appendString:@"退款"];
            break;
    }
//    1.待审核.2,审核通过.3.审核未通过.4.供应商已收到货(退货的时候用)5,买家取消6退款成功7,退款关闭8换货成功9我们平台审核退款10退换货,买家已寄快递11退款已提交至支付宝审核12支付宝审核退款失败
    
    switch ([model.change integerValue]) {
        case 1:
            [sb appendString:@"待审核"];
            break;
        case 2:
            [sb appendString:@"审核已通过"];
            break;
        case 3:
            [sb appendString:@"审核未通过"];
            break;
        case 4:
            [sb appendString:@"-供应商已收到货"];
            break;
        case 5:
            [sb appendString:@"-买家已取消"];
            break;
        case 6:
            [sb appendString:@"已成功"];
            break;
        case 7:
            [sb appendString:@"已关闭"];
            break;
        case 8:
            [sb appendString:@"成功"];
            break;
        case 9:
            [sb appendString:@"审核中"];
            break;
        case 10:
            [sb appendString:@"处理中"];
            break;
        case 11:
            [sb appendString:@"-已提交至支付宝审核"];
            break;
        case 12:
            [sb appendString:@"-支付宝审核退款失败"];
            break;
  
        default:
            break;
    }
    [_statue setText:sb];
    
}
//判断平台介入商品的状态
-(void)signStatus:(ShopDetailModel *)model
{
    //退货换货,供应商拒签,0否1是.默认0
    NSMutableString *sb = [[NSMutableString alloc]init];
//    switch ([model.orderShopStatus integerValue]) {
//        case 1:
//            [sb appendString:@"卖家拒绝换货"];
//            break;
//        case 2:
//            [sb appendString:@"卖家拒绝退货"];
//            break;
//        case 3:
//            [sb appendString:@"卖家拒绝退款"];
//            break;
//    }
    _interveneBtn.hidden=YES;
    switch (model.ys_intervene.integerValue) {//平台接入 0没有介入,1申请介入,2已经介入.3卖家赢,4买家赢.5不管了.6未申请介入,已自动完结
        case 0:
            [sb appendString:@"卖家拒绝签收"];
            _interveneBtn.hidden=NO;
            break;
        case 1:
            [sb appendString:@"平台处理中"];
            break;
        case 2:
            [sb appendString:@"平台处理中"];
            break;
        case 3:
            [sb appendString:@"交易成功"];
            break;
        case 4:
        {
            switch ([model.orderShopStatus integerValue]) {
                case 1:
                    [sb appendString:@"换货成功"];
                    break;
                case 2:
                    [sb appendString:@"退货成功"];
                    break;
                case 3:
                    [sb appendString:@"退款成功"];
                    break;
            }
        }
            break;
        case 5:
            [sb appendString:@"售后关闭"];
            break;
        case 6:
            [sb appendString:@"售后关闭"];
            break;
        default:
            [sb appendString:@"卖家拒绝签收"];
            _interveneBtn.hidden=NO;
            break;
    }
    [_statue setText:sb];
    
}
-(void)refreshData2:(ShopDetailModel*)model
{
//    [self.headimage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[NSObject baseURLStr_Upy],model.shop_pic]]];
    NSURL *imgUrl ;
    if (model.shop_from.intValue==-1) {
        self.number.text=[NSString stringWithFormat:@"x1"];
        self.zeroLabel.hidden=YES;
        self.color_size.hidden=YES;
        imgUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@!180",[NSObject baseURLStr_Upy],model.shop_pic]];
    }else{
        self.number.text=model.shop_from.intValue==-2?@"x1":[NSString stringWithFormat:@"x%@",model.shop_num];
        self.zeroLabel.hidden=YES;
        self.color_size.hidden=NO;
        imgUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@/%@/%@!180",[NSObject baseURLStr_Upy],[MyMD5 pictureString:model.shop_code],model.shop_pic]];

    }

//    NSURL *imgUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@!180",[NSObject baseURLStr_Upy],model.shop_pic]];
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
    
//    self.title.text=[self exchangeTextWihtString: model.shop_name];
//    if (model.shopsArray.count==1||model.shop_num.intValue==1) {
//        self.zeroLabel.text=@"超值单品";
//    }else
//        self.zeroLabel.text=@"超值套餐";
    
    self.color_size.text=model.shop_from.intValue==-2?@"":[NSString stringWithFormat:@"颜色:%@ 尺码:%@",model.shop_color,model.shop_size];
    
//    self.price.text=[NSString stringWithFormat:@"￥%@",model.shop_price];
    self.price.text=[NSString stringWithFormat:@"¥%.2f",model.shop_price.floatValue];


    //    self.statue.font=[UIFont systemFontOfSize:14];
    self.statue.textColor=tarbarrossred;
    self.number.textColor=kTextColor;
    
    if (model.supp_sign_status.integerValue==1) {
        [self signStatus:model];
    }else
        [self afterOrderStatus:model];
    
    NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:ZOOM(40)]};
    CGSize textSize = [_statue.text boundingRectWithSize:CGSizeMake(1500, 1000) options:NSStringDrawingTruncatesLastVisibleLine attributes:attributes context:nil].size;
    self.statue.frame=CGRectMake(kApplicationWidth-ZOOM(42)-textSize.width-20, ZOOM(62), textSize.width+20, ZOOM(40));
//    self.statue.backgroundColor = [UIColor cyanColor];
    
    self.title.frame=CGRectMake(self.headimage.frame.origin.x+self.headimage.frame.size.width+ZOOM(32),ZOOM(62), kScreenWidth-CGRectGetMaxX(_headimage.frame)-textSize.width-20-ZOOM(32)-ZOOM(42), ZOOM(44));
    
    self.title.text=[self exchangeTextWihtString: model.shop_name];
    
}
-(void)refreshData3:(ShopDetailModel*)model
{
    self.statue.hidden = YES;
    self.number.hidden =YES;
    
    NSURL *imgUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@/%@/%@!180",[NSObject baseURLStr_Upy],[MyMD5 pictureString:model.shop_code],model.shop_pic]];
//    NSURL *imgUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@!180",[NSObject baseURLStr_Upy],model.shop_pic]];
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
    
    self.title.text=[self exchangeTextWihtString: model.shop_name];

    self.color_size.text=[NSString stringWithFormat:@"颜色:%@ 尺码:%@",model.shop_color,model.shop_size];
    if(model.shop_from.intValue == 11)
    {
        self.color_size.text=[NSString stringWithFormat:@"%@ %@",model.shop_color,model.shop_size];
    }
    
    
    self.price.text=[NSString stringWithFormat:@"¥%.2f",model.shop_price.floatValue];
    
//    self.headimage.frame=CGRectMake(ZOOM(62), self.headimage.frame.origin.y, self.headimage.frame.size.width, self.frame.size.height);
//    self.title.frame = CGRectMake(self.title.frame.origin.x, self.title.frame.origin.y,self.title.frame.size.width+self.statue.frame.size.width, self.title.frame.size.height);

    self.title.frame=CGRectMake(self.headimage.frame.origin.x+self.headimage.frame.size.width+ZOOM(32),ZOOM(62), kScreenWidth-CGRectGetMaxX(_headimage.frame)-ZOOM(32)-ZOOM(42), ZOOM(56));

}
- (IBAction)minusBtnClick:(UIButton *)sender {
    if(self.changeNum.text.intValue>1)
    {
        self.changeNum.text=[NSString stringWithFormat:@"%d",self.changeNum.text.intValue-1];
        self.statue.text = [NSString stringWithFormat:@"%d",self.statue.text.intValue-1];
    }
}
- (IBAction)plusBtnClick:(UIButton *)sender {
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
