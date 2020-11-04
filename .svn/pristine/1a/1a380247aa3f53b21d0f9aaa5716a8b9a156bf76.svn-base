//
//  MyorderTableViewCell.m
//  YunShangShiJi
//
//  Created by ios-1 on 15/4/21.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//

#import "MyorderTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "GlobalTool.h"
@implementation MyorderTableViewCell

- (void)awakeFromNib {
    // Initialization code
    

}
-(void)refreshData:(ShopDetailModel*)model
{
    
    NSURL *imgUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[NSObject baseURLStr_Upy],model.shop_pic]];
    __block float d = 0;
    __block BOOL isDownlaod = NO;
    [self.headImage sd_setImageWithURL:imgUrl placeholderImage:nil options:SDWebImageRetryFailed progress:^(NSInteger receivedSize, NSInteger expectedSize) {
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

    self.color_size.text=[NSString stringWithFormat:@"颜色:%@ 尺码:%@",model.shop_color,model.shop_size];
    
    self.price.text=[NSString stringWithFormat:@"￥%@",model.order_price];
    self.buynumber.text=[NSString stringWithFormat:@"x%@",model.shop_num];

    float price=model.shop_price.intValue;
    float number=model.shop_num.intValue;
    self.payprice.text=[NSString stringWithFormat:@"实付:￥%.2f",price*number];
    self.storestatue.textColor=tarbarrossred;
    
    
//  private Integer status;//订单货物状态1待付款2代发货3待收货4待评价5退款中6已完结
    self.statuebtn.hidden=NO;
    self.statuebtn2.hidden=NO;
    self.statuebtn3.hidden=NO;

    self.statuebtn3.userInteractionEnabled=YES;
    
    if([model.status isEqualToString:@"1"])//待付款
    {
        self.storestatue.text=@"待付款";
        [self.statuebtn setTitle:@"付款" forState:UIControlStateNormal];
        [self.statuebtn2 setTitle:@"取消订单" forState:UIControlStateNormal];
        [self.statuebtn3 setTitle:@"联系卖家" forState:UIControlStateNormal];
        


    }else if ([model.status isEqualToString:@"2"])//代发货
    {
         self.storestatue.text=@"购买成功";
        [self.statuebtn setTitle:@"提醒发货" forState:UIControlStateNormal];
        [self.statuebtn2 setTitle:@"退款" forState:UIControlStateNormal];

        
        self.statuebtn3.hidden=YES;

    }else if([model.status isEqualToString:@"3"])//待收货
    {
         self.storestatue.text=@"卖家已发货";
        [self.statuebtn setTitle:@"确认收货" forState:UIControlStateNormal];
        [self.statuebtn2 setTitle:@"查看物流" forState:UIControlStateNormal];
        [self.statuebtn3 setTitle:@"延长收货" forState:UIControlStateNormal];
        
    }else if ([model.status isEqualToString:@"4"])//待评价
    {
         self.storestatue.text=@"交易成功";
        [self.statuebtn setTitle:@"评价订单" forState:UIControlStateNormal];
        [self.statuebtn2 setTitle:@"查看物流" forState:UIControlStateNormal];
        [self.statuebtn3 setTitle:@"删除订单" forState:UIControlStateNormal];
        

    }else if ([model.status isEqualToString:@"5"])//退款中
    {
        self.storestatue.text=@"退款中";
        [self.statuebtn setTitle:@"钱款去向" forState:UIControlStateNormal];

        self.statuebtn2.hidden=YES;
        self.statuebtn3.hidden=YES;
        
    }else if([model.status isEqualToString:@"6"])//已完结
    {
         self.storestatue.text=@"已经完结";
        
        self.statuebtn.hidden=YES;
        self.statuebtn2.hidden=YES;
        self.statuebtn3.hidden=YES;
        
    }else if ([model.status isEqualToString:@"7"])//延长收货
    {
        self.storestatue.text=@"已延长收货";
        [self.statuebtn setTitle:@"确认收货" forState:UIControlStateNormal];
        [self.statuebtn2 setTitle:@"查看物流" forState:UIControlStateNormal];
        

        self.statuebtn3.hidden=YES;
        
    }else if ([model.status isEqualToString:@"8"])//退款成功
    {
        self.storestatue.text=@"退款成功";
        
        [self.statuebtn setTitle:@"钱款去向" forState:UIControlStateNormal];
        self.statuebtn2.hidden=YES;
        self.statuebtn3.hidden=YES;
        
    }else if ([model.status isEqualToString:@"9"])//取消定单
    {
        self.storestatue.text=@"已取消";
        
        self.statuebtn.hidden=YES;
        self.statuebtn2.hidden=YES;
        self.statuebtn3.hidden=YES;
        
    }
    
    
    [self.statuebtn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    [self.statuebtn2 addTarget:self action:@selector(click2:) forControlEvents:UIControlEventTouchUpInside];
    [self.statuebtn3 addTarget:self action:@selector(click3:) forControlEvents:UIControlEventTouchUpInside];
}

-(void)refreshData1:(ShopDetailModel *)model
{
//    [self.headImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",PHOTOhttp,model.shop_pic]]];
    
    NSURL *imgUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[NSObject baseURLStr_Upy],model.shop_pic]];
    __block float d = 0;
    __block BOOL isDownlaod = NO;
    [self.headImage sd_setImageWithURL:imgUrl placeholderImage:nil options:SDWebImageRetryFailed progress:^(NSInteger receivedSize, NSInteger expectedSize) {
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
    
    self.storetitle.text=model.shop_name;
    self.color_size.text=model.sizecolor;
    self.price.text=[NSString stringWithFormat:@"%@",model.shop_price];
    self.payprice.text=[NSString stringWithFormat:@"%@",model.money];
    self.buynumber.text=[NSString stringWithFormat:@"%@",model.shop_num];
    
    self.storestatue.text=@"退款成功";
    self.storestatue.textColor=tarbarrossred;
    self.statuebtn.layer.cornerRadius=5;
    [self.statuebtn setTitle:@"钱款去向" forState:UIControlStateNormal];
    
    [self.statuebtn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    

}

-(void)refreshData2:(ShopDetailModel*)model
{
//    [self.headImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[NSObject baseURLStr_Upy],model.shop_pic]]];
    
    NSURL *imgUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[NSObject baseURLStr_Upy],model.shop_pic]];
    __block float d = 0;
    __block BOOL isDownlaod = NO;
    [self.headImage sd_setImageWithURL:imgUrl placeholderImage:nil options:SDWebImageRetryFailed progress:^(NSInteger receivedSize, NSInteger expectedSize) {
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

    
    self.color_size.text=[NSString stringWithFormat:@"颜色:%@ 尺码:%@",model.shop_color,model.shop_size];
    
    self.price.text=[NSString stringWithFormat:@"￥%@",model.order_price];
    self.buynumber.text=[NSString stringWithFormat:@"x%@",model.shop_num];
    
    float price=model.shop_price.intValue;
    float number=model.shop_num.intValue;
    self.payprice.text=[NSString stringWithFormat:@"实付:￥%.2f",price*number];
    self.storestatue.textColor=tarbarrossred;

    
    //    private Integer status;//订单货物状态1待付款2代发货3待收货4待评价5退款中6已完结
    self.statuebtn.hidden=NO;
    self.statuebtn2.hidden=NO;
    self.statuebtn3.hidden=NO;

    if([model.status isEqualToString:@"1"])//待付款
    {
        self.storestatue.text=@"未付款";
        [self.statuebtn setTitle:@"联系买家" forState:UIControlStateNormal];
       
        self.statuebtn2.hidden=YES;
        self.statuebtn3.hidden=YES;
        
        
    }else if ([model.status isEqualToString:@"2"])//代发货
    {
        self.storestatue.text=@"未发货";
        [self.statuebtn setTitle:@"提醒发货" forState:UIControlStateNormal];

        
        self.statuebtn2.hidden=YES;
        self.statuebtn3.hidden=YES;
        
    }else if([model.status isEqualToString:@"3"])//待收货
    {
        self.storestatue.text=@"待收货";
        [self.statuebtn setTitle:@"查看物流" forState:UIControlStateNormal];

        self.statuebtn2.hidden=YES;
        self.statuebtn3.hidden=YES;
        
    }else if ([model.status isEqualToString:@"4"])//待评价
    {
        self.storestatue.text=@"交易成功";
        [self.statuebtn setTitle:@"评价客户" forState:UIControlStateNormal];
        [self.statuebtn2 setTitle:@"查看物流" forState:UIControlStateNormal];

        self.statuebtn3.hidden=YES;
        
    }else if ([model.status isEqualToString:@"5"])//退款中
    {
        self.storestatue.text=@"退款中";
        [self.statuebtn setTitle:@"钱款去向" forState:UIControlStateNormal];
        
        self.statuebtn2.hidden=YES;
        self.statuebtn3.hidden=YES;
        
    }else if([model.status isEqualToString:@"6"])//已完结
    {
        self.storestatue.text=@"已经完结";
        
        self.statuebtn.hidden=YES;
        self.statuebtn2.hidden=YES;
        self.statuebtn3.hidden=YES;
        
    }else if ([model.status isEqualToString:@"7"])//延长收货
    {
        self.storestatue.text=@"延长收货";
        [self.statuebtn setTitle:@"查看物流" forState:UIControlStateNormal];
        
        self.statuebtn2.hidden=YES;
        self.statuebtn3.hidden=YES;
        self.statuebtn3.userInteractionEnabled=NO;
        
    }else if ([model.status isEqualToString:@"8"])//退款成功
    {
        self.storestatue.text=@"退款成功";
        
        [self.statuebtn setTitle:@"钱款去向" forState:UIControlStateNormal];
        self.statuebtn2.hidden=YES;
        self.statuebtn3.hidden=YES;
        
    }else if ([model.status isEqualToString:@"9"])//已取消
    {
        self.storestatue.text=@"已取消";
        
        self.statuebtn.hidden=YES;
        self.statuebtn2.hidden=YES;
        self.statuebtn3.hidden=YES;
        
    }
    
    
    [self.statuebtn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    [self.statuebtn2 addTarget:self action:@selector(click2:) forControlEvents:UIControlEventTouchUpInside];
    [self.statuebtn3 addTarget:self action:@selector(click3:) forControlEvents:UIControlEventTouchUpInside];

}


-(void)click:(UIButton*)sender
{
    if (_delegate &&[_delegate respondsToSelector:@selector(changeTitle:)]) {
        
        
        [_delegate changeTitle:_row ];
        
    }

}

-(void)click2:(UIButton*)sender
{
    if (_delegate &&[_delegate respondsToSelector:@selector(changeTitle:)]) {
        
        
        [_delegate changeTitle2:_row ];
        
    }
    
}

-(void)click3:(UIButton*)sender
{
    if (_delegate &&[_delegate respondsToSelector:@selector(changeTitle:)]) {
        
        
        [_delegate changeTitle3:_row ];
        
    }
    
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
