//
//  RedHongBaoHeadView.m
//  YunShangShiJi
//
//  Created by hebo on 2019/1/23.
//  Copyright © 2019年 ios-1. All rights reserved.
//

#import "RedHongBaoHeadView.h"
#import "OneYuanModel.h"
#import "GlobalTool.h"

#define kYellowColor RGBA(255, 207, 0, 1)
@implementation RedHongBaoHeadView

- (instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        self.cutdowntime = 1800;
        self.coupon = 6;
        self.cond = 1;
        
        [OneYuanModel GetCouponDataSuccess:^(id data) {
            OneYuanModel *model = data;
            if(model.status == 1)
            {
                self.coupon = model.price > 0 ? model.price:6;
                self.cond = model.cond > 0 ? model.cond:1;
            }
            
            [self creatHeadView];
        }];
        
    }
    return self;
}
- (void)creatHeadView
{
    self.HongbaoHeadview = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width,ZOOM6(300))];
//    [self.HongbaoHeadview sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[NSObject baseURLStr_XCX_Upy],@"small-iconImages/heboImg/newest_30yuanHongBao.png"]]];
    [self.HongbaoHeadview sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[NSObject baseURLStr_XCX_Upy],@"small-iconImages/heboImg/backGround_shoppingCoupon.jpg"]]];
    self.HongbaoHeadview.userInteractionEnabled = YES;
    [self addSubview:self.HongbaoHeadview];
    
    UITapGestureRecognizer *tap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(linghongBao:)];
    [self.HongbaoHeadview addGestureRecognizer:tap];
    
    self.redMoneyLab = [[UILabel alloc]init];
    self.redMoneyLab.textColor = kYellowColor;
    self.redMoneyLab.font = [UIFont systemFontOfSize:ZOOM6(30)];
    self.redMoneyLab.textAlignment = NSTextAlignmentCenter;
    self.redMoneyLab.text = @"会员专享199元购物券已入账";
//    self.redMoneyLab.text = [NSString stringWithFormat:@"￥%@现金红包已入账",@"20"];
    [self addSubview:self.redMoneyLab];
    
    self.redTimeLab = [[UILabel alloc]init];
    self.redTimeLab.textColor = kYellowColor;
    self.redTimeLab.font = [UIFont systemFontOfSize:ZOOM6(30)];
    self.redTimeLab.textAlignment = NSTextAlignmentCenter;
    self.redTimeLab.text = [NSString stringWithFormat:@"%@后红包过期",@"00:00:00"];
    [self addSubview:self.redTimeLab];
    
    self.redCouponLab = [[UILabel alloc]init];
    self.redCouponLab.textColor = kYellowColor;
    self.redCouponLab.font = [UIFont systemFontOfSize:ZOOM6(30)];
    self.redCouponLab.textAlignment = NSTextAlignmentCenter;
    self.redCouponLab.text = @"以下商品用券免费领";
//    self.redCouponLab.text = [NSString stringWithFormat:@"以下商品满%.0f元用红包立减%.0f元",self.cond,self.coupon];
    [self addSubview:self.redCouponLab];
    
//    self.redTixianLab = [[UILabel alloc]init];
//    self.redTixianLab.textColor = kYellowColor;
//    self.redTixianLab.font = [UIFont systemFontOfSize:ZOOM6(30)];
//    self.redTixianLab.textAlignment = NSTextAlignmentCenter;
//    self.redTixianLab.text = [NSString stringWithFormat:@"拼团成功后可提现%.0f元",20-self.coupon];
//    [self addSubview:self.redTixianLab];
    
    [self.redMoneyLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(ZOOM6(70));
        make.width.equalTo(self);
        make.height.offset(ZOOM6(50));
    }];
    
    [self.redTimeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.redMoneyLab.mas_bottom).offset(ZOOM6(10));
        make.width.equalTo(self);
        make.height.offset(ZOOM6(50));
    }];
    
    [self.redCouponLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.redTimeLab.mas_bottom).offset(ZOOM6(30));
        make.width.equalTo(self);
        make.height.offset(ZOOM6(40));
    }];
    
//    [self.redTixianLab mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.redCouponLab.mas_bottom).offset(ZOOM6(10));
//        make.width.equalTo(self);
//        make.height.offset(ZOOM6(40));
//    }];
    
    [self cutDownTime];
    [self getTextemutable:self.redMoneyLab Text:@"199元购物券" FromIndex:3 Font:ZOOM6(40)];
    [self getTextemutable:self.redCouponLab Text:@"免费领" FromIndex:3 Font:ZOOM6(40)];
//    [self getTextemutable:self.redTixianLab Text:[NSString stringWithFormat:@"%.0f",20-self.coupon] FromIndex:8 Font:ZOOM6(40)];

}

- (void)linghongBao:(UITapGestureRecognizer*)tap
{
    if(self.lingHongBaoBlock)
    {
        self.lingHongBaoBlock(self.coupon);
    }
}
- (void)cutDownTime
{
    self.mytimer= [NSTimer weakTimerWithTimeInterval:1.0 target:self selector:@selector(timerFireMethod1) userInfo:nil repeats:YES];
}

//.倒计时的实现
- (void)timerFireMethod1
{
    self.cutdowntime --;
    NSDate *today = [NSDate date];//当前时间
    NSDate *lastTwoHour = [today dateByAddingTimeInterval:self.cutdowntime];//结束时间
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy.MM.dd HH:mm:ss"];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    unsigned int unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    NSDateComponents *d = [calendar components:unitFlags fromDate:today toDate:lastTwoHour options:0];//计算时间差
    
    NSString* day=[NSString stringWithFormat:@"%zd",[d day]];
    NSString* hour=[NSString stringWithFormat:@"%zd",[d hour]];
    NSString* min=[NSString stringWithFormat:@"%zd",[d minute]];
    NSString* sec=[NSString stringWithFormat:@"%zd",[d second]];
    
    if(self.cutdowntime <= 0)
    {
        self.redTimeLab.text=[NSString stringWithFormat:@"%02d:%02d:%02d后红包过期",0,0,0];
        [self.mytimer invalidate];
        return;
    }else{
    
        self.redTimeLab.text=[NSString stringWithFormat:@"%02d:%02d:%02d后红包过期",hour.intValue,min.intValue,sec.intValue];
    }
}

- (void)getTextemutable:(UILabel*)lab Text:(NSString*)text FromIndex:(int)index Font:(CGFloat)font
{
    NSRange range = [lab.text rangeOfString:text];
    if(range.length > 0)
    {
        NSMutableAttributedString *mutable = [[NSMutableAttributedString alloc]initWithString:lab.text];
        if(lab == self.redCouponLab)
        {
            [mutable addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Helvetica-Bold" size:font] range:NSMakeRange(range.location, text.length)];
        }else{
            [mutable addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Helvetica-Bold" size:font] range:NSMakeRange(range.location, text.length)];
        }
        
        [lab setAttributedText:mutable];
    }
}
@end
