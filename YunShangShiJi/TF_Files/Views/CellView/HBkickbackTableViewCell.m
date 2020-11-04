//
//  HBkickbackTableViewCell.m
//  YunShangShiJi
//
//  Created by ios-1 on 16/1/26.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import "HBkickbackTableViewCell.h"
#import "GlobalTool.h"
@implementation HBkickbackTableViewCell

- (void)awakeFromNib {

    self.titlelab.font = [UIFont systemFontOfSize:ZOOM(40)];
    self.orderlab.font = [UIFont systemFontOfSize:ZOOM(40)];
    self.namelab.font = [UIFont systemFontOfSize:ZOOM(40)];
    self.timelab.font = [UIFont systemFontOfSize:ZOOM(40)];
    self.moneylab.font = [UIFont systemFontOfSize:ZOOM(70)];
    
    self.frame = CGRectMake(0, 0, kScreenWidth, self.frame.size.height);
    
    self.backimage.frame = CGRectMake(self.backimage.frame.origin.x, self.backimage.frame.origin.y, kScreenWidth, self.backimage.frame.size.height);
    self.moneylab.frame = CGRectMake(kScreenWidth-ZOOM(100*3.4), self.moneylab.frame.origin.y, ZOOM(90*3.4), self.moneylab.frame.size.height);
    
    self.namelab.hidden = NO;
    
//    self.contentView.backgroundColor=[UIColor groupTableViewBackgroundColor];
}

- (void)receiveDataModel:(KickBackModel *)model
{
    self.orderlab.frame = CGRectMake(self.orderlab.frame.origin.x, self.orderlab.frame.origin.y, self.orderlab.frame.size.width, 25);

    self.backimage.clipsToBounds = YES;
    self.moneylab.clipsToBounds = YES;
    
    self.moneylab.textAlignment = NSTextAlignmentCenter;
    
    self.backimage.backgroundColor = [UIColor clearColor];
    self.moneylab.textColor = [UIColor whiteColor];
    self.titlelab.textColor = [UIColor whiteColor];
    self.namelab.textColor = [UIColor whiteColor];
    self.orderlab.textColor = [UIColor whiteColor];
    self.timelab.textColor = [UIColor whiteColor];
    
    if ([model.is_free intValue] == 1) { //解冻
        
//        self.backview.backgroundColor = COLOR_ROSERED;
        
        self.backimage.image = [UIImage imageNamed:@"返现1"];
        self.titlelab.text = @"成功";
        self.moneylab.text = [NSString stringWithFormat:@"+%.2f",[model.money doubleValue]];
        
    } else if ([model.is_free intValue] == 0) {

//        self.backview.backgroundColor = kBackgroundColor;
        
        self.backimage.image = [UIImage imageNamed:@"返现2"];
        
        if(model.status.intValue == 1)
        {
            self.titlelab.text = @"已退款";
        }
        else if (model.status.intValue == 2)
        {
            self.titlelab.text = @"退款中";
        }
        else if (model.status.intValue == 3)
        {
            self.titlelab.text = @"还未收到货";
        }
        else if (model.status.intValue == 4)
        {
            self.titlelab.text = @"无效";
        }
        else{
            self.titlelab.text = @"冻结";
        }
       
        self.moneylab.text = [NSString stringWithFormat:@"+%.2f",[model.money doubleValue]];
    }
    
    
    //时间
    self.timelab.text = [self calculationSecFor1970:[model.add_date longLongValue]/1000.0];
    self.orderlab.text = [NSString stringWithFormat:@"订单号%@",model.order_code];
    
    //惊喜任务签到翻倍
    if([model.type intValue] == 8)
    {
        self.orderlab.text = @"惊喜任务签到翻倍";
        if([model.is_free intValue]==0)//冻结
        {
            self.titlelab.text = @"冻结";
        }else if([model.is_free intValue]==1){//未冻结
            self.backimage.backgroundColor = RGBCOLOR_I(237, 70, 47);
            self.titlelab.text = @"成功";
        }
        
        self.orderlab.frame = CGRectMake(self.orderlab.frame.origin.x, self.orderlab.frame.origin.y, self.orderlab.frame.size.width, 50);
        self.namelab.hidden = YES;
    }else if([model.type intValue] == 9) {
        self.orderlab.text = [model.is_free intValue]==0?@"邀请好友——好友未提现奖励":@"邀请好友——好友提现奖励";
        self.titlelab.text = [model.is_free intValue]==0?@"冻结":@"成功";
        if([model.is_free intValue]==1)
            self.backimage.backgroundColor = RGBCOLOR_I(237, 70, 47);
        self.orderlab.frame = CGRectMake(self.orderlab.frame.origin.x, self.orderlab.frame.origin.y, self.orderlab.frame.size.width, 50);
        self.namelab.hidden = YES;
    }else if ([model.type intValue]==10) {
        NSArray *arr=@[@"免单第一次返现(签收商品后)",
                       @"免单第二次返现(签收后一个月)",
                       @"免单第三次返现(签收后二个月)",
                       @"免单第四次返现(签收后三个月)",
                       @"免单第五次返现(签收后四个月)"];
        self.orderlab.text = arr[[model.is_buy intValue]];
//        self.titlelab.text = [model.is_free intValue]==0?@"冻结":@"成功";
        if([model.is_free intValue]==1)
            self.backimage.backgroundColor = RGBCOLOR_I(237, 70, 47);
        self.orderlab.frame = CGRectMake(self.orderlab.frame.origin.x, self.orderlab.frame.origin.y, self.orderlab.frame.size.width, 50);
        self.namelab.hidden = YES;
        self.moneylab.text = [NSString stringWithFormat:@"¥%.2f",[model.money doubleValue]];
    }else if([model.type intValue] == 11) {
//        self.orderlab.text = @"0元购返现";
        self.titlelab.text = [model.is_free intValue]==0?@"0元购返现冻结":@"0元购返现解冻";
        if([model.is_free intValue]==1)
            self.backimage.backgroundColor = RGBCOLOR_I(237, 70, 47);
        self.orderlab.frame = CGRectMake(self.orderlab.frame.origin.x, self.orderlab.frame.origin.y, self.orderlab.frame.size.width, 50);
        self.namelab.hidden = YES;
    }

    
//    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
//    NSString *username = [user objectForKey:USER_NAME];
    NSString *username = model.user_name;
    MyLog(@"model.user_name = %@",username);
    
    self.namelab.text = [NSString stringWithFormat:@"%@    ￥%.2f",username,[model.order_price floatValue]];
}

#pragma mark - 计算一个日期与1970计算日期
- (NSString *)calculationSecFor1970:(long long)theDate
{
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd  HH:mm:ss"];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:theDate];
    NSString *showtimeNew = [dateFormatter stringFromDate:date];
    return showtimeNew;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];


}

@end
