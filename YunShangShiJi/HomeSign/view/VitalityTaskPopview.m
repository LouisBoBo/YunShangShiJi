//
//  VitalityTaskPopview.m
//  YunShangShiJi
//
//  Created by ios-1 on 2016/11/17.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import "VitalityTaskPopview.h"
#import "GlobalTool.h"
#import "ShopDetailModel.h"
#import "TypeShareModel.h"
#import "SqliteManager.h"
@implementation VitalityTaskPopview

{
    CGFloat shareimageYY ;
    
    CGFloat invitcodeYY;                  //弹框初始y坐标
    CGFloat ShareInvitationCodeViewHeigh; //弹框的高度
    NSString *shop_supper_label;          //品牌商
}

- (instancetype)initWithFrame:(CGRect)frame VitalityType:(VitalityType)Vitalitytype valityGrade:(NSInteger)valityGrade YidouCount:(NSInteger)yidouCount;
{
    if(self = [super initWithFrame:frame])
    {
        self.vitalityTasktype = Vitalitytype;
        self.valityGrade = valityGrade;
        self.getYidouCount = yidouCount;
        
        //如果是疯抢中奖弹框 先获取品牌
        if(Vitalitytype == Raward_oneLuckPrize)
        {
            self.orderShopArray = [DataManager sharedManager].orderShopAarray;
            ShopDetailModel *shopModel;
//            if(self.orderShopArray.count)
            {
                shopModel = self.orderShopArray[0];
                [self getShopTypeDataFromShopcode:shopModel.shop_code];
            }
        }else{
            [self creaPopview];
        }
        
    }
    
    return self;
}


- (void)creaPopview
{
    _SharePopview = [[UIView alloc]initWithFrame:CGRectMake(0, 0,kScreenWidth, kScreenHeight)];
    
    _SharePopview.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
    _SharePopview.userInteractionEnabled = YES;
    
    invitcodeYY = (kScreenHeight - ZOOM6(600))/2;
    ShareInvitationCodeViewHeigh = ZOOM6(600);
    
    //弹框内容
    _ShareInvitationCodeView = [[UIView alloc]initWithFrame:CGRectMake(ZOOM(120), invitcodeYY, kScreenWidth-ZOOM(120)*2, ShareInvitationCodeViewHeigh)];
    
    _ShareInvitationCodeView.layer.cornerRadius = 5;
    _ShareInvitationCodeView.clipsToBounds = YES;
    _ShareInvitationCodeView.backgroundColor = [UIColor whiteColor];
    [_SharePopview addSubview:_ShareInvitationCodeView];
    
    //title
    _headlabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(_ShareInvitationCodeView.frame),ZOOM6(60))];
    _headlabel.textColor = [UIColor whiteColor];
    _headlabel.text = @"";
    _headlabel.backgroundColor = [UIColor clearColor];
    _headlabel.font = [UIFont systemFontOfSize:ZOOM6(40)];
    _headlabel.textAlignment = NSTextAlignmentCenter;
    _headlabel.clipsToBounds = YES;
    _headlabel.userInteractionEnabled = YES;
    
    if(self.vitalityTasktype != Raward_weixin_bingding && self.vitalityTasktype != Raward_oneLuckRule)
    {
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(disapper)];
        [_headlabel addGestureRecognizer:tap];
    }
    
    //关闭按钮
    CGFloat btnwidth = IMGSIZEW(@"icon_close")*1.2;
    
    _canclebtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _canclebtn.frame=CGRectMake(CGRectGetWidth(_ShareInvitationCodeView.frame)-btnwidth-ZOOM(30), ZOOM6(30), btnwidth, btnwidth);
    [_canclebtn setImage:[UIImage imageNamed:@"icon_close"] forState:UIControlStateNormal];
    _canclebtn.imageView.contentMode=UIViewContentModeScaleAspectFit;
    _canclebtn.layer.cornerRadius=btnwidth/2;
    [_canclebtn addTarget:self action:@selector(cancleClick) forControlEvents:UIControlEventTouchUpInside];
    
    [_ShareInvitationCodeView addSubview:_headlabel];
    [_ShareInvitationCodeView addSubview:_canclebtn];
    
    //弹框内容
    [self creatDuobao:_headlabel Value:nil];
    
    [self addSubview:_SharePopview];
    
    
    _ShareInvitationCodeView.transform = CGAffineTransformMakeScale(0.3, 0.3);
    _ShareInvitationCodeView.alpha = 0.5;
    
    _SharePopview.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
    
    [UIView animateWithDuration:0.5 animations:^{
        
        _SharePopview.backgroundColor = [[UIColor colorWithRed:0 green:0 blue:0 alpha:0] colorWithAlphaComponent:0.5];
        
        _ShareInvitationCodeView.transform = CGAffineTransformMakeScale(1, 1);
        _ShareInvitationCodeView.alpha = 1;
        
    } completion:^(BOOL finish) {
        
    }];
    
}

- (void)creatDuobao:(UIView*)headview Value:(NSString*)valuestr
{
    CGFloat imageWidth = 0;
    if(self.vitalityTasktype == Vitality_Onehundred)
    {
        imageWidth = IMAGEW(@"icon_vip_silver180X120");
    }else if (self.vitalityTasktype == Raward_twentyyidou)
    {
        imageWidth = IMAGEW(@"icon_+20yidou");
    }
    _titleimage = [[UIImageView alloc]initWithFrame:CGRectMake((CGRectGetWidth(_ShareInvitationCodeView.frame)-imageWidth)/2,ZOOM6(60), imageWidth, imageWidth*0.67)];
    
    _titlelab = [[UILabel alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(_titleimage.frame)+ZOOM6(20), CGRectGetWidth(_ShareInvitationCodeView.frame)-40, 20)];
    _titlelab.text = @"";
    _titlelab.textColor = RGBCOLOR_I(62, 62, 62);
    _titlelab.numberOfLines = 0;
    _titlelab.textAlignment = NSTextAlignmentCenter;
    _titlelab.font = [UIFont systemFontOfSize:ZOOM6(36)];
    
    _discriptionlab = [[UILabel alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(_titlelab.frame)+ZOOM6(20), CGRectGetWidth(_ShareInvitationCodeView.frame)-40, ZOOM6(120))];
    _discriptionlab.numberOfLines = 0;
    _discriptionlab.textColor = RGBCOLOR_I(125, 125, 125);
    _discriptionlab.font = [UIFont systemFontOfSize:ZOOM6(28)];
    _discriptionlab.text = @"";
    
    _bwlklab = [[UILabel alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(_discriptionlab.frame), CGRectGetWidth(_ShareInvitationCodeView.frame)-40, ZOOM6(160))];
    _bwlklab.numberOfLines = 0;
    _bwlklab.textColor = RGBCOLOR_I(125, 125, 125);
    _bwlklab.font = [UIFont systemFontOfSize:ZOOM6(28)];
    _bwlklab.text = @"";
    
    [_ShareInvitationCodeView addSubview:_titleimage];
    [_ShareInvitationCodeView addSubview:_titlelab];
    [_ShareInvitationCodeView addSubview:_discriptionlab];
    [_ShareInvitationCodeView addSubview:_bwlklab];
    
    CGFloat gobtnWidth = (CGRectGetWidth(_ShareInvitationCodeView.frame)-2*20-20)/2;
    CGFloat gobtnHeigh = ZOOM(36*3.4);
    
    for(int k =0;k<2;k++)
    {
        UIButton *gobtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        gobtn.frame = CGRectMake(20+(gobtnWidth+20)*k, CGRectGetMaxY(_bwlklab.frame)+ZOOM6(60), gobtnWidth, gobtnHeigh);
        gobtn.backgroundColor = tarbarrossred;
        gobtn.clipsToBounds = YES;
        gobtn.layer.cornerRadius = 5;
        gobtn.tag = 7788+k;
        [gobtn setTintColor:[UIColor whiteColor]];
        gobtn.titleLabel.font = [UIFont systemFontOfSize:ZOOM(51)];
        
        [self buttontitle:self.vitalityTasktype Button:gobtn];
        
        [gobtn addTarget:self action:@selector(goClick:) forControlEvents:UIControlEventTouchUpInside];
        [_ShareInvitationCodeView addSubview:gobtn];
    }
    
}

- (void)buttontitle:(VitalityType)type Button:(UIButton*)gobtn
{
    gobtn.hidden = NO;
    
    if (type == Vitality_Zero)//活力值0
    {
        _titlelab.text = @"活力值提示";
        
        _discriptionlab.text = @"当前活力值为0点，不可参与赚钱任务（1个必做任务消耗1点活力值），请立即补充活力值喔~";
        NSString *sstt = @"（1个必做任务消耗1点活力值），请立即补充活力值喔~";
        NSMutableAttributedString *nsmutable = [[NSMutableAttributedString alloc]initWithString:_discriptionlab.text];
        [nsmutable addAttribute:NSForegroundColorAttributeName value:tarbarrossred range:NSMakeRange(_discriptionlab.text.length-sstt.length, sstt.length)];
        [_discriptionlab setAttributedText:nsmutable];

        
        _bwlklab.frame = CGRectMake(20, CGRectGetMaxY(_discriptionlab.frame), CGRectGetWidth(_ShareInvitationCodeView.frame)-40, ZOOM6(160));
        _bwlklab.text = @"活力值需要购买商品（抽奖除外）才能补充，商品订单实付金额=活力值，例如：实付100元商品将会获得100点成长值。";
        
        if(gobtn.tag == 7788)
        {
            [gobtn setTitle:@"补充活力值" forState:UIControlStateNormal];
            gobtn.frame = CGRectMake(20, CGRectGetMaxY(_bwlklab.frame)+ZOOM6(60), CGRectGetWidth(_ShareInvitationCodeView.frame)-2*20, ZOOM(36*3.4));
        }else{
            gobtn.hidden = YES;
        }

       
    }else if (type == Stop_business)//暂停运营
    {
        _titlelab.text = @"温馨提示";
        [_canclebtn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];

        _discriptionlab.frame = CGRectMake(20, CGRectGetMaxY(_titlelab.frame)+ZOOM6(20), CGRectGetWidth(_ShareInvitationCodeView.frame)-40, ZOOM6(150));
        _discriptionlab.text = @"衣蝠IOS版本APP后台紧急维护中，请移步至衣蝠小程序。点下方按钮，分享衣蝠小程序给好友后，即可通过分享的链接直接进入衣蝠小程序。";
       
        _bwlklab.frame = CGRectMake(20, CGRectGetMaxY(_discriptionlab.frame), CGRectGetWidth(_ShareInvitationCodeView.frame)-40, 0);
       
        if(gobtn.tag == 7788)
        {
            [gobtn setTitle:@"去衣蝠小程序" forState:UIControlStateNormal];
            gobtn.frame = CGRectMake(20, CGRectGetMaxY(_bwlklab.frame)+ZOOM6(60), CGRectGetWidth(_ShareInvitationCodeView.frame)-2*20, ZOOM(36*3.4));
        }else{
            gobtn.hidden = YES;
        }

    }else if (type == Detail_comeBack)
    {
        _titlelab.text = @"温馨提示";
        [_canclebtn setImage:[UIImage imageNamed:@"icon_close"] forState:UIControlStateNormal];
        
        _discriptionlab.text = @"没能1元带走美衣？完成赚钱小任务，衣蝠送你20元。";
        
        _bwlklab.frame = CGRectMake(20, CGRectGetMaxY(_discriptionlab.frame), CGRectGetWidth(_ShareInvitationCodeView.frame)-40, 0);
        
        if(gobtn.tag == 7788)
        {
            [gobtn setTitle:@"确定" forState:UIControlStateNormal];
            gobtn.frame = CGRectMake(20, CGRectGetMaxY(_bwlklab.frame)+ZOOM6(60), CGRectGetWidth(_ShareInvitationCodeView.frame)-2*20, ZOOM(36*3.4));
        }else{
            gobtn.hidden = YES;
        }
    }
    else if (type == Vitality_Twenty)//活力值20
    {
        
        _titlelab.text = @"活力值提示";
        
        _discriptionlab.text = [NSString stringWithFormat:@"你的活力值不足20点，为了不影响你参与赚钱任务（1个必做任务消耗1点活力值），请及时补充活力值喔~"];
        NSString *sstt = @"（1个必做任务消耗1点活力值），请及时补充活力值喔~";
        NSMutableAttributedString *nsmutable = [[NSMutableAttributedString alloc]initWithString:_discriptionlab.text];
        [nsmutable addAttribute:NSForegroundColorAttributeName value:tarbarrossred range:NSMakeRange(_discriptionlab.text.length-sstt.length, sstt.length)];
        [_discriptionlab setAttributedText:nsmutable];

        
        _bwlklab.frame = CGRectMake(20, CGRectGetMaxY(_discriptionlab.frame), CGRectGetWidth(_ShareInvitationCodeView.frame)-40, ZOOM6(160));
        _bwlklab.text = @"活力值需要购买商品（抽奖除外）才能补充，商品订单实付金额=活力值，例如：实付100元商品将会获得100点成长值。";
        
        if(gobtn.tag == 7788)
        {
            [gobtn setTitle:@"补充活力值" forState:UIControlStateNormal];
            gobtn.frame = CGRectMake(20, CGRectGetMaxY(_bwlklab.frame)+ZOOM6(60), CGRectGetWidth(_ShareInvitationCodeView.frame)-2*20, ZOOM(36*3.4));
        }else{
            gobtn.hidden = YES;
        }

            
    }else if (type == Vitality_Onehundred)//活力值100
    {
        _titlelab.text = @"恭喜你!";
        
        NSString *grade = [self getValityGrade];
        
        _discriptionlab.text = [NSString stringWithFormat:@"你免费获得%@特权，并获得%ld点活力值，快来看看都有什么会员权益吧~",grade,(long)self.valityGrade];
        
        gobtn.frame = CGRectMake(20, CGRectGetMaxY(_discriptionlab.frame)+ZOOM6(60), CGRectGetWidth(_ShareInvitationCodeView.frame)-2*20, ZOOM(36*3.4));
        
        if(gobtn.tag == 7788)
        {
            [gobtn setTitle:@"查看我的会员" forState:UIControlStateNormal];
            
        }else{
            gobtn.hidden = YES;
        }
    }else if (type == Fightgroups_from)//拼团申请
    {
        _titlelab.text = @"拼团申请已发出";
        
        _discriptionlab.text = @"拼团申请已经发送到衣蝠平台，如果有其它平台用户加入你的拼团，此团才会生效哦~";
        
        _bwlklab.frame = CGRectMake(20, CGRectGetMaxY(_discriptionlab.frame), CGRectGetWidth(_ShareInvitationCodeView.frame)-40, 0);
        
        if(gobtn.tag == 7788)
        {
            [gobtn setTitle:@"知道了" forState:UIControlStateNormal];
            gobtn.frame = CGRectMake(20, CGRectGetMaxY(_bwlklab.frame)+ZOOM6(60), (CGRectGetWidth(_ShareInvitationCodeView.frame)-2*20-20)/2, ZOOM(36*3.4));
            gobtn.backgroundColor = [UIColor clearColor];
            gobtn.tintColor = tarbarrossred;
            gobtn.layer.borderColor = tarbarrossred.CGColor;
            gobtn.layer.borderWidth=1;
            
        }else{
            [gobtn setTitle:@"参与其它拼团" forState:UIControlStateNormal];
        }
    }else if (type == Fightgroups_success)//拼团成功
    {
        _titlelab.text = @"拼团成功啦~";
        
        _discriptionlab.text = [NSString stringWithFormat:@"用户%@参与了你的拼团【2016夏季最新款....￥80】，你的拼团现在已经正式成团。",@"Y***G"];
        
        _bwlklab.frame = CGRectMake(20, CGRectGetMaxY(_discriptionlab.frame), CGRectGetWidth(_ShareInvitationCodeView.frame)-40, ZOOM6(80));
        _bwlklab.text = @"平台会尽快把你心仪的美衣快递至你的身边哦~";
        
        if(gobtn.tag == 7788)
        {
            [gobtn setTitle:@"知道了" forState:UIControlStateNormal];
            gobtn.frame = CGRectMake(20, CGRectGetMaxY(_bwlklab.frame)+ZOOM6(60), (CGRectGetWidth(_ShareInvitationCodeView.frame)-2*20-20)/2, ZOOM(36*3.4));
            gobtn.backgroundColor = [UIColor clearColor];
            gobtn.tintColor = tarbarrossred;
            gobtn.layer.borderColor = tarbarrossred.CGColor;
            gobtn.layer.borderWidth=1;
            
        }else{
            [gobtn setTitle:@"逛逛其它拼团" forState:UIControlStateNormal];
        }
        
    }else if (type == Raward_getyidou)//获取衣豆
    {
        [_canclebtn setImage:[UIImage imageNamed:@"luck-icon_close-"] forState:UIControlStateNormal];
        
        _ShareInvitationCodeView.backgroundColor = RGBA(255, 0, 76, 1);
        
        _titlelab.text = @"如何获得衣豆?";
        _titlelab.textColor = RGBCOLOR_I(253, 204, 33);
        
        NSString *str = @"1.衣豆可以通过平台购买下单获得平台消费1元(不足1元将按1元计算)可获得1个衣豆；\n\n2.用户下单成功后，相应衣豆将会冻结在衣豆账户中，订单签收7天后(订单完结)，订单产生的衣豆将会解冻；如果发生退款退货，冻结衣豆将会被扣除；\n\n3.参与送衣豆任务，也可获得相应衣豆奖励。";
        
        CGFloat heigh = [self getRowHeigh:str fontSize:ZOOM6(28)];
        _discriptionlab.frame = CGRectMake(20, CGRectGetMaxY(_titlelab.frame)+ZOOM6(20), CGRectGetWidth(_ShareInvitationCodeView.frame)-40, heigh);
        _discriptionlab.text = [NSString stringWithFormat:@"%@",str];
        _discriptionlab.textColor = [UIColor whiteColor];
        
        _bwlklab.frame = CGRectMake(20, CGRectGetMaxY(_discriptionlab.frame), CGRectGetWidth(_ShareInvitationCodeView.frame)-40, 0);
        
        if(gobtn.tag == 7788)
        {
            [gobtn setTitle:@"买买买" forState:UIControlStateNormal];
            gobtn.frame = CGRectMake(20, CGRectGetMaxY(_bwlklab.frame)+ZOOM6(60), CGRectGetWidth(_ShareInvitationCodeView.frame)-2*20, ZOOM(36*3.4));
            [gobtn setTitleColor:RGBCOLOR_I(253, 33, 90) forState:UIControlStateNormal];
            gobtn.backgroundColor = RGBCOLOR_I(253, 204, 33);
            gobtn.titleLabel.font = [UIFont systemFontOfSize:ZOOM(44)];
        }else{
            gobtn.hidden = YES;
        }

    }else if (type == Raward_getyue)//获取余额
    {
        [_canclebtn setImage:[UIImage imageNamed:@"luck-icon_close-"] forState:UIControlStateNormal];
        
        _ShareInvitationCodeView.backgroundColor = RGBA(255, 0, 76, 1);
        
        _titlelab.text = @"如何获得余额?";
        _titlelab.textColor = RGBCOLOR_I(253, 204, 33);
        
        NSString *str = @"1.余额很重要哦，不仅能用来抵扣购衣款，抽提现现金，并且余额不足就不能提现呢。\n\n2.可通过完成每日必做任务及额外任务获得余额。记得每天都把全部任务完成哦。";
        
        CGFloat heigh = [self getRowHeigh:str fontSize:ZOOM6(28)];
        _discriptionlab.frame = CGRectMake(20, CGRectGetMaxY(_titlelab.frame)+ZOOM6(20), CGRectGetWidth(_ShareInvitationCodeView.frame)-40, heigh);
        _discriptionlab.text = [NSString stringWithFormat:@"%@",str];
        _discriptionlab.textColor = [UIColor whiteColor];
        
//        NSArray *findStrArray = @[@"购买美衣立即返全部金额入账户余额",@"通过惊喜提现任务及抽奖任务全额提现",@"平台将按首月返10%，次月返20%，第三个月返30%的比例"];
//        NSMutableAttributedString *mutable;
//        if(_discriptionlab.text)
//        {
//            mutable = [[NSMutableAttributedString alloc]initWithString:_discriptionlab.text];
//        }
//        for(NSString *findstr in findStrArray)
//        {
//            NSRange range = [str rangeOfString:findstr];
//            [mutable addAttribute:NSForegroundColorAttributeName value:RGBCOLOR_I(253, 204, 33) range:NSMakeRange(range.location, range.length)];
//        }
//        [_discriptionlab setAttributedText:mutable];

        _bwlklab.frame = CGRectMake(20, CGRectGetMaxY(_discriptionlab.frame), CGRectGetWidth(_ShareInvitationCodeView.frame)-40, 0);
        
        gobtn.titleLabel.font = [UIFont systemFontOfSize:ZOOM(44)];

        if(gobtn.tag == 7788)
        {
            [gobtn setTitle:@"去做任务" forState:UIControlStateNormal];
            gobtn.frame = CGRectMake(20, CGRectGetMaxY(_bwlklab.frame)+ZOOM6(60), CGRectGetWidth(_ShareInvitationCodeView.frame)-2*20, ZOOM(36*3.4));
            [gobtn setTitleColor:RGBCOLOR_I(253, 33, 90) forState:UIControlStateNormal];
            gobtn.backgroundColor = RGBCOLOR_I(253, 204, 33);
            
        }else{
            gobtn.hidden = YES;
        }
        
    }else if (type == Super_redZeroShopping)//红色超级0元购
    {
        [_canclebtn setImage:[UIImage imageNamed:@"luck-icon_close-"] forState:UIControlStateNormal];
        
        _ShareInvitationCodeView.backgroundColor = RGBA(255, 0, 76, 1);
        
        _titlelab.text = @"超级0元购";
        _titlelab.textColor = RGBCOLOR_I(253, 204, 33);
        
         NSString *str = @"1、购买美衣立即返全部金额入账户余额，还能抽取最高1000元提现红包大奖。\n\n2、1-3个月内每日登录衣蝠并完成全部任务，即可通过惊喜提现任务及抽奖任务全额提现。相当于在衣蝠买美衣永远白送。\n\n3、如3个月未能全额提现，且用户每日登陆衣蝠并完成全部任务，平台将按首月返10%，次月返20%，第三个月返30%的比例把首单购衣款打入提现额度。48小时内到账！";
        
        CGFloat heigh = [self getRowHeigh:str fontSize:ZOOM6(28)];
        _discriptionlab.frame = CGRectMake(20, CGRectGetMaxY(_titlelab.frame)+ZOOM6(20), CGRectGetWidth(_ShareInvitationCodeView.frame)-40, heigh);
        _discriptionlab.text = [NSString stringWithFormat:@"%@",str];
        _discriptionlab.textColor = [UIColor whiteColor];
        
        NSArray *findStrArray = @[@"购买美衣立即返全部金额入账户余额",@"通过惊喜提现任务及抽奖任务全额提现",@"平台将按首月返10%，次月返20%，第三个月返30%的比例"];
        NSMutableAttributedString *mutable;
        if(_discriptionlab.text)
        {
            mutable = [[NSMutableAttributedString alloc]initWithString:_discriptionlab.text];
        }
        for(NSString *findstr in findStrArray)
        {
            NSRange range = [str rangeOfString:findstr];
            [mutable addAttribute:NSForegroundColorAttributeName value:RGBCOLOR_I(253, 204, 33) range:NSMakeRange(range.location, range.length)];
        }
        [_discriptionlab setAttributedText:mutable];
        
        _bwlklab.frame = CGRectMake(20, CGRectGetMaxY(_discriptionlab.frame), CGRectGetWidth(_ShareInvitationCodeView.frame)-40, 0);
        
        gobtn.titleLabel.font = [UIFont systemFontOfSize:ZOOM(44)];
        
        if(gobtn.tag == 7788)
        {
            [gobtn setTitle:@"立即0元购美衣" forState:UIControlStateNormal];
            gobtn.frame = CGRectMake(20, CGRectGetMaxY(_bwlklab.frame)+ZOOM6(60), CGRectGetWidth(_ShareInvitationCodeView.frame)-2*20, ZOOM(36*3.4));
            [gobtn setTitleColor:RGBCOLOR_I(253, 33, 90) forState:UIControlStateNormal];
            gobtn.backgroundColor = RGBCOLOR_I(253, 204, 33);

        }else{
            gobtn.hidden = YES;
        }


    }
    else if (type == Raward_noenoughyidou)//衣豆不足
    {
        [_canclebtn setImage:[UIImage imageNamed:@"luck-icon_close-"] forState:UIControlStateNormal];
        
        _ShareInvitationCodeView.backgroundColor = RGBA(255, 0, 76, 1);
        
        _titlelab.text = @"余额及衣豆不足提示";
        _titlelab.textColor = RGBCOLOR_I(253, 204, 33);
        
        NSString *str = @"你当前的余额及衣豆不足，请及时补充哦~";
        
        CGFloat heigh = [self getRowHeigh:str fontSize:ZOOM6(28)];
        _discriptionlab.frame = CGRectMake(20, CGRectGetMaxY(_titlelab.frame)+ZOOM6(20), CGRectGetWidth(_ShareInvitationCodeView.frame)-40, heigh);
        _discriptionlab.text = [NSString stringWithFormat:@"%@",str];
        _discriptionlab.textColor = [UIColor whiteColor];
        
        _bwlklab.frame = CGRectMake(20, CGRectGetMaxY(_discriptionlab.frame), CGRectGetWidth(_ShareInvitationCodeView.frame)-40, 0);
        
        gobtn.titleLabel.font = [UIFont systemFontOfSize:ZOOM(44)];
        if(gobtn.tag == 7788)
        {
            [gobtn setTitle:@"补充余额" forState:UIControlStateNormal];
            gobtn.frame = CGRectMake(20, CGRectGetMaxY(_bwlklab.frame)+ZOOM6(60), (CGRectGetWidth(_ShareInvitationCodeView.frame)-2*20-20)/2, ZOOM(36*3.4));
            gobtn.backgroundColor = [UIColor whiteColor];
            gobtn.tintColor = RGBCOLOR_I(253, 33, 90);
            
        }else{
            [gobtn setTitle:@"补充衣豆" forState:UIControlStateNormal];
            [gobtn setTitleColor:RGBCOLOR_I(253, 33, 90) forState:UIControlStateNormal];
            gobtn.backgroundColor = RGBCOLOR_I(253, 204, 33);
            
        }

    }else if (type == Raward_fiveyidou)
    {
        [_canclebtn setImage:[UIImage imageNamed:@"luck-icon_close-"] forState:UIControlStateNormal];
        
        _ShareInvitationCodeView.backgroundColor = RGBA(255, 0, 76, 1);
        
        _titlelab.text = @"抽奖提示";
        _titlelab.textColor = RGBCOLOR_I(253, 204, 33);
        
        NSInteger twofoldness = [DataManager sharedManager].guidetwofoldness;
        int count = twofoldness>0?10/twofoldness:10;
        NSString *str = [NSString stringWithFormat:@"是否使用%d个衣豆或余额进行抽奖？",count];
        
        _discriptionlab.frame = CGRectMake(20, CGRectGetMaxY(_titlelab.frame)+ZOOM6(20), CGRectGetWidth(_ShareInvitationCodeView.frame)-40, ZOOM6(40));
        _discriptionlab.text = [NSString stringWithFormat:@"%@",str];
        _discriptionlab.textColor = [UIColor whiteColor];
        _discriptionlab.textAlignment = NSTextAlignmentCenter;
        
        _bwlklab.frame = CGRectMake(20, CGRectGetMaxY(_discriptionlab.frame)+ZOOM6(60), CGRectGetWidth(_ShareInvitationCodeView.frame)-40, ZOOM(40));
        _bwlklab.text = @"       下次不再弹窗直接抽奖";
        _bwlklab.textColor = RGBCOLOR_I(174, 5, 49);
        _bwlklab.userInteractionEnabled = YES;
        _bwlklab.font = [UIFont systemFontOfSize:ZOOM6(24)];
        
        [[NSUserDefaults standardUserDefaults] setObject:@"select" forKey:RAWARD_UP];
        UIButton *selectbtn = [[UIButton alloc]init];
        selectbtn.frame = CGRectMake(0, -ZOOM6(8), ZOOM6(40), ZOOM6(40));
        [selectbtn setBackgroundImage:[UIImage imageNamed:@"luck-cel"] forState:UIControlStateNormal];
        selectbtn.selected = YES;
        [selectbtn addTarget:self action:@selector(selectClick:) forControlEvents:UIControlEventTouchUpInside];
        [_bwlklab addSubview:selectbtn];
               
        gobtn.titleLabel.font = [UIFont systemFontOfSize:ZOOM(44)];
        gobtn.frame = CGRectMake(20, CGRectGetMaxY(_bwlklab.frame)+ZOOM6(60), CGRectGetWidth(_ShareInvitationCodeView.frame)-2*20, ZOOM(36*3.4));
        if(gobtn.tag == 7788)
        {
            [gobtn setTitle:@"确定" forState:UIControlStateNormal];
            gobtn.backgroundColor = RGBCOLOR_I(253, 204, 33);
        }else{
            gobtn.hidden = YES;
        }

    }else if (type == Raward_twentyyidou)
    {
        CGFloat imageWidth = IMAGEW(@"icon_+20yidou");
        
        _titleimage.frame = CGRectMake((CGRectGetWidth(_ShareInvitationCodeView.frame)-imageWidth)/2,ZOOM6(60), imageWidth, imageWidth*0.72);
        _titleimage.image = [UIImage imageNamed:@"icon_+20yidou"];
        
        _titlelab.text = @"恭喜你!";
        
        _discriptionlab.text = @"幸运女神降临，你已免费获得20个衣豆，使用衣豆抽奖，最高赢取1000元提现额度哦~";
        
        gobtn.frame = CGRectMake(20, CGRectGetMaxY(_discriptionlab.frame)+ZOOM6(60), CGRectGetWidth(_ShareInvitationCodeView.frame)-2*20, ZOOM(36*3.4));
        
        if(gobtn.tag == 7788)
        {
            [gobtn setTitle:@"立即抽取提现额度" forState:UIControlStateNormal];
            
        }else{
            gobtn.hidden = YES;
        }

    }else if (type == Raward_twentyChance)//抽奖机会
    {
        CGFloat imageWidth = IMAGEW(@"mandy_gongxini");
        CGFloat imageHeigh = IMAGEH(@"mandy_gongxini");
        
        _ShareInvitationCodeView.backgroundColor = RGBA(255, 0, 76, 1);
        _ShareInvitationCodeView.clipsToBounds = NO;
        
        _titleimage.frame = CGRectMake((CGRectGetWidth(_ShareInvitationCodeView.frame)-imageWidth)/2,-imageHeigh*0.6, imageWidth, imageHeigh);
        _titleimage.image = [UIImage imageNamed:@"mandy_gongxini"];
        
        _titlelab.frame = CGRectMake(20, CGRectGetMaxY(_titleimage.frame)+ZOOM6(20), CGRectGetWidth(_ShareInvitationCodeView.frame)-40, 20);
        _titlelab.text = [NSString stringWithFormat:@"获得%ld次疯狂抽奖机会",(long)self.valityGrade];
        _titlelab.textColor = RGBCOLOR_I(253, 204, 33);
        
        _discriptionlab.text = @"疯狂抽奖期间，中奖概率为平时300%！机会用完后，再下单可以继续享受疯狂抽奖！\n\n使用衣豆抽奖，中奖概率仍为平时的正常概率。";
        CGFloat heigh = [self getRowHeigh:_discriptionlab.text fontSize:ZOOM6(28)];
        _discriptionlab.frame = CGRectMake(20, CGRectGetMaxY(_titlelab.frame)+ZOOM6(20), CGRectGetWidth(_ShareInvitationCodeView.frame)-40, heigh);
        _discriptionlab.textColor = [UIColor whiteColor];
        
        gobtn.frame = CGRectMake(20, CGRectGetMaxY(_discriptionlab.frame)+ZOOM6(60), CGRectGetWidth(_ShareInvitationCodeView.frame)-2*20, ZOOM(36*3.4));
        
        if(gobtn.tag == 7788)
        {
            gobtn.backgroundColor = RGBCOLOR_I(253, 204, 33);
            gobtn.tintColor = RGBCOLOR_I(237, 73, 88);

            [gobtn setTitle:@"立即抽奖" forState:UIControlStateNormal];
            
        }else{
            gobtn.hidden = YES;
        }

    }else if (type == Raward_noenoughChance)//抽奖机会不足
    {
        [_canclebtn setImage:[UIImage imageNamed:@"luck-icon_close-"] forState:UIControlStateNormal];
        
        _ShareInvitationCodeView.backgroundColor = RGBA(255, 0, 76, 1);
        
        _titlelab.text = @"抽奖提示";
        _titlelab.textColor = RGBCOLOR_I(253, 204, 33);
        
        NSString *str = @"你的疯狂抽奖机会已使用完，继续下单领衣豆，获取双倍抽奖机会， 100%中奖！";
        
        CGFloat heigh = [self getRowHeigh:str fontSize:ZOOM6(28)];
        _discriptionlab.frame = CGRectMake(20, CGRectGetMaxY(_titlelab.frame)+ZOOM6(20), CGRectGetWidth(_ShareInvitationCodeView.frame)-40, heigh);
        _discriptionlab.text = [NSString stringWithFormat:@"%@",str];
        _discriptionlab.textColor = [UIColor whiteColor];
        
        _bwlklab.frame = CGRectMake(20, CGRectGetMaxY(_discriptionlab.frame), CGRectGetWidth(_ShareInvitationCodeView.frame)-40, 0);
        
        gobtn.titleLabel.font = [UIFont systemFontOfSize:ZOOM(44)];
        if(gobtn.tag == 7788)
        {
            gobtn.frame = CGRectMake(20, CGRectGetMaxY(_bwlklab.frame)+ZOOM6(60), CGRectGetWidth(_ShareInvitationCodeView.frame)-2*20, ZOOM(36*3.4));
            gobtn.backgroundColor = RGBCOLOR_I(253, 204, 33);
            gobtn.tintColor = RGBCOLOR_I(237, 73, 88);
            [gobtn setTitle:@"获取抽奖机会" forState:UIControlStateNormal];
            
        }else{
            gobtn.hidden = YES;
        }
    }else if (type == Deleate_shoppingcart)
    {
        _canclebtn.hidden = YES;
        _canclebtn.enabled = NO;
        _titlelab.text = @"确定要删除吗?";
        
        _discriptionlab.frame = CGRectMake(20, CGRectGetMaxY(_titlelab.frame)+ZOOM6(20), CGRectGetWidth(_ShareInvitationCodeView.frame)-40, 0);
        _bwlklab.frame = CGRectMake(20, CGRectGetMaxY(_discriptionlab.frame), CGRectGetWidth(_ShareInvitationCodeView.frame)-40, 0);
        
        if(gobtn.tag == 7788)
        {
            [gobtn setTitle:@"取消" forState:UIControlStateNormal];
            gobtn.frame = CGRectMake(20, CGRectGetMaxY(_bwlklab.frame)+ZOOM6(60), (CGRectGetWidth(_ShareInvitationCodeView.frame)-2*20-20)/2, ZOOM(36*3.4));
            gobtn.backgroundColor = [UIColor clearColor];
            gobtn.tintColor = tarbarrossred;
            gobtn.layer.borderColor = tarbarrossred.CGColor;
            gobtn.layer.borderWidth=1;

        }else{
            [gobtn setTitle:@"确定" forState:UIControlStateNormal];
            [gobtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            gobtn.backgroundColor = tarbarrossred;
        }

    }else if (type == Detail_Deductible)
    {
        _titlelab.text = @"余额抵扣说明";
        
        _discriptionlab.text = @"预充值的会员卡费与赚钱任务赢得的可提现现金，均可全额用于购买商品哦。";
        
        _bwlklab.frame = CGRectMake(20, CGRectGetMaxY(_discriptionlab.frame), CGRectGetWidth(_ShareInvitationCodeView.frame)-40, 0);
        
        if(gobtn.tag == 7788)
        {
            gobtn.frame = CGRectMake(20, CGRectGetMaxY(_bwlklab.frame)+ZOOM6(60), CGRectGetWidth(_ShareInvitationCodeView.frame)-2*20, ZOOM(36*3.4));
            gobtn.backgroundColor = tarbarrossred;
            gobtn.tintColor = [UIColor whiteColor];
            [gobtn setTitle:@"去赚余额" forState:UIControlStateNormal];
            
        }else{
            gobtn.hidden = YES;
        }

    }else if (type == Share_Deductible)
    {
        _titlelab.text = @"温馨提示";
        
        _discriptionlab.text = @"分享商品到微信，有人购买您立即得奖励金。可直接提现或用于购买商品。";
        
        _bwlklab.frame = CGRectMake(20, CGRectGetMaxY(_discriptionlab.frame), CGRectGetWidth(_ShareInvitationCodeView.frame)-40, 0);
        
        if(gobtn.tag == 7788)
        {
            gobtn.frame = CGRectMake(20, CGRectGetMaxY(_bwlklab.frame)+ZOOM6(60), CGRectGetWidth(_ShareInvitationCodeView.frame)-2*20, ZOOM(36*3.4));
            gobtn.backgroundColor = tarbarrossred;
            gobtn.tintColor = [UIColor whiteColor];
            [gobtn setTitle:@"我知道了" forState:UIControlStateNormal];
            
        }else{
            gobtn.hidden = YES;
        }
        
    }
    else if (type == Detail_OneYuanDeductible)
    {
        
        if(self.valityGrade==2)
        {
            _titlelab.text = @"本轮未点中哦";
        }else if (self.valityGrade==1)
        {
            _titlelab.text = @"疯抢返还说明";
        }else if (self.valityGrade==3)
        {
            _titlelab.text = @"免费领未成功通知";
        }else{
            _titlelab.text = @"余额抵扣说明";
        }
        
        if([_titlelab.text isEqualToString:@"本轮未点中哦"])
        {
//            _discriptionlab.text = @"拼团疯抢费已全额退款至你衣蝠账号的可提现余额中，可立即提现！或用来购买商品。";
            _discriptionlab.text = @"本轮未点中哦，尊贵的会员，您可以继续免费领，也可离开去浏览别的商品。";
        }else if ([_titlelab.text isEqualToString:@"疯抢返还说明"])
        {
            _discriptionlab.text = @"疯抢费已全额退款至你衣蝠账号的可提现余额中，可直接提现或用来购买商品。";
        }else if ([_titlelab.text isEqualToString:@"免费领未成功通知"])
        {
            _discriptionlab.text = @"因在规定时间内参团人数不足，你的免费领拼团未成功。本次免费领资格失效。下次再来吧。";
        }else{
           _discriptionlab.text = @"退还的疯抢费与赚钱任务赢得的可提现余额，均可全额抵扣商品价哦。";
        }
        
        CGFloat heigh = [self getRowHeigh:_discriptionlab.text fontSize:ZOOM6(28)];
        _discriptionlab.frame = CGRectMake(20, CGRectGetMaxY(_titlelab.frame)+ZOOM6(20), CGRectGetWidth(_ShareInvitationCodeView.frame)-40, heigh);
        

        if([_titlelab.text isEqualToString:@"免费领未成功通知"] || [_titlelab.text isEqualToString:@"本轮未点中哦"])
        {
           _bwlklab.frame = CGRectMake(20, CGRectGetMaxY(_discriptionlab.frame)+ZOOM6(30), CGRectGetWidth(_ShareInvitationCodeView.frame)-40, 0);
        }else{
            UILabel *labline = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_discriptionlab.frame)+ZOOM6(10), CGRectGetWidth(_ShareInvitationCodeView.frame), 1)];
            labline.backgroundColor = [UIColor groupTableViewBackgroundColor];
            [_ShareInvitationCodeView addSubview:labline];
            
           _bwlklab.frame = CGRectMake(20, CGRectGetMaxY(_discriptionlab.frame)+ZOOM6(30), CGRectGetWidth(_ShareInvitationCodeView.frame)-40, 40);
        }
        
        _bwlklab.text = [NSString stringWithFormat:@"累计已退%.1f元\n(可全额抵扣商品价格)",self.oneYuanDiKou];
        _bwlklab.textColor = tarbarrossred;
        _bwlklab.textAlignment = NSTextAlignmentCenter;
        _bwlklab.font = [UIFont fontWithName:@"Helvetica-Bold" size:ZOOM6(28)];
        
        if([_titlelab.text isEqualToString:@"免费领未成功通知"]){
            if(gobtn.tag == 7788)
            {
                gobtn.frame = CGRectMake(20, CGRectGetMaxY(_bwlklab.frame)+ZOOM6(60), CGRectGetWidth(_ShareInvitationCodeView.frame)-2*20, ZOOM(36*3.4));
                gobtn.backgroundColor = tarbarrossred;
                gobtn.tintColor = [UIColor whiteColor];
                [gobtn setTitle:@"继续免费领" forState:UIControlStateNormal];
    
            }else{
                gobtn.hidden = YES;
            }
        }else{
            if(gobtn.tag == 7788)
            {
                if([_titlelab.text isEqualToString:@"本轮未点中哦"])
                {
                    [gobtn setTitle:@"再点一轮" forState:UIControlStateNormal];
                }else if ([_titlelab.text isEqualToString:@"拼团疯抢已返还"])
                {
                    [gobtn setTitle:@"查看订单" forState:UIControlStateNormal];
                }
                else{
                    [gobtn setTitle:@"知道了" forState:UIControlStateNormal];
                }
                
                gobtn.frame = CGRectMake(20, CGRectGetMaxY(_bwlklab.frame)+ZOOM6(60), (CGRectGetWidth(_ShareInvitationCodeView.frame)-2*20-20)/2, ZOOM(36*3.4));
                if([_titlelab.text isEqualToString:@"本轮未点中哦"]){
                    gobtn.backgroundColor = tarbarrossred;
                    gobtn.tintColor = [UIColor whiteColor];
                }else{
                    gobtn.backgroundColor = [UIColor clearColor];
                    gobtn.tintColor = tarbarrossred;
                    gobtn.layer.borderColor = tarbarrossred.CGColor;
                    gobtn.layer.borderWidth=1;
                }
                
            }else{
                if([_titlelab.text isEqualToString:@"本轮未点中哦"])
                {
                    gobtn.backgroundColor = [UIColor clearColor];
                    gobtn.tintColor = tarbarrossred;
                    gobtn.layer.borderColor = tarbarrossred.CGColor;
                    gobtn.layer.borderWidth=1;
                    [gobtn setTitle:@"离开" forState:UIControlStateNormal];
                }else
                    [gobtn setTitle:@"去看余额" forState:UIControlStateNormal];
            }
        }
        
    }
    else if (type == Task_zero_BuyFinish){
        _titlelab.text = @"温馨提示";
        
        NSString * paymoney = [[NSUserDefaults standardUserDefaults]objectForKey:PAY_MONEY];
        _discriptionlab.text = [NSString stringWithFormat:@"抽中的提现额度与%.2f元购衣款已返现至账户余额，处于冻结状态，交易成功后即可解冻。",paymoney.floatValue];

        _bwlklab.frame = CGRectMake(20, CGRectGetMaxY(_discriptionlab.frame), CGRectGetWidth(_ShareInvitationCodeView.frame)-40, 0);
        
        if(gobtn.tag == 7788)
        {
            [gobtn setTitle:@"继续逛" forState:UIControlStateNormal];
            gobtn.frame = CGRectMake(20, CGRectGetMaxY(_bwlklab.frame)+ZOOM6(60), (CGRectGetWidth(_ShareInvitationCodeView.frame)-2*20-20)/2, ZOOM(36*3.4));
            gobtn.backgroundColor = [UIColor clearColor];
            gobtn.tintColor = tarbarrossred;
            gobtn.layer.borderColor = tarbarrossred.CGColor;
            gobtn.layer.borderWidth=1;
            
        }else{
            [gobtn setTitle:@"去看看" forState:UIControlStateNormal];
        }

    }else if (type == Topic_delateTopic)
    {
        _titlelab.text = @"确定删除该穿搭？";
        
        _discriptionlab.text = @"删除后点赞和评论将同时被删除，不可恢复哦~";
        
        _bwlklab.frame = CGRectMake(20, CGRectGetMaxY(_discriptionlab.frame), CGRectGetWidth(_ShareInvitationCodeView.frame)-40, 0);
        
        if(gobtn.tag == 7788)
        {
            [gobtn setTitle:@"取消" forState:UIControlStateNormal];
            gobtn.frame = CGRectMake(20, CGRectGetMaxY(_bwlklab.frame)+ZOOM6(60), (CGRectGetWidth(_ShareInvitationCodeView.frame)-2*20-20)/2, ZOOM(36*3.4));
            gobtn.backgroundColor = [UIColor clearColor];
            gobtn.tintColor = tarbarrossred;
            gobtn.layer.borderColor = tarbarrossred.CGColor;
            gobtn.layer.borderWidth=1;
            
        }else{
            [gobtn setTitle:@"确定" forState:UIControlStateNormal];
        }
    }else if (type == Raward_order_Tixian)
    {
        CGFloat imageWidth = IMAGEW(@"mandy_gongxini");
        CGFloat imageHeigh = IMAGEH(@"mandy_gongxini");
        
        _ShareInvitationCodeView.backgroundColor = RGBA(255, 0, 76, 1);
        _ShareInvitationCodeView.clipsToBounds = NO;
        
        _titleimage.frame = CGRectMake((CGRectGetWidth(_ShareInvitationCodeView.frame)-imageWidth)/2,-imageHeigh*0.6, imageWidth, imageHeigh);
        _titleimage.image = [UIImage imageNamed:@"mandy_gongxini"];
        
        _titlelab.frame = CGRectMake(20, CGRectGetMaxY(_titleimage.frame)+ZOOM6(20), CGRectGetWidth(_ShareInvitationCodeView.frame)-40, 0);
        _titlelab.textColor = RGBCOLOR_I(253, 204, 33);
        
        _discriptionlab.text = @"完成购买任务，任务奖励的提现额度已经发放到您账户~ 订单完成后可提现！";
        CGFloat heigh = [self getRowHeigh:_discriptionlab.text fontSize:ZOOM6(28)];
        _discriptionlab.frame = CGRectMake(20, CGRectGetMaxY(_titlelab.frame)+ZOOM6(20), CGRectGetWidth(_ShareInvitationCodeView.frame)-40, heigh);
        _discriptionlab.textColor = [UIColor whiteColor];
        
        gobtn.frame = CGRectMake(20, CGRectGetMaxY(_discriptionlab.frame)+ZOOM6(60), CGRectGetWidth(_ShareInvitationCodeView.frame)-2*20, ZOOM(36*3.4));
        
        if(gobtn.tag == 7788)
        {
            gobtn.backgroundColor = RGBCOLOR_I(253, 204, 33);
            gobtn.tintColor = RGBCOLOR_I(237, 73, 88);
            
            [gobtn setTitle:@"立即查看" forState:UIControlStateNormal];
            
        }else{
            gobtn.hidden = YES;
        }
    }else if (type == Raward_paySuccess_yidou)
    {
        _ShareInvitationCodeView.backgroundColor = RGBA(255, 0, 76, 1);
        [_canclebtn setImage:[UIImage imageNamed:@"luck-icon_close-"] forState:UIControlStateNormal];
        CGFloat imageWidth = IMAGEW(@"icon_+yidou-");
        
        _titleimage.frame = CGRectMake((CGRectGetWidth(_ShareInvitationCodeView.frame)-imageWidth)/2,ZOOM6(60), imageWidth, imageWidth*0.5);
        _titleimage.image = [UIImage imageNamed:@"icon_+yidou-"];
        
        _titlelab.frame = CGRectMake(20, CGRectGetMaxY(_titleimage.frame)+ZOOM6(30), CGRectGetWidth(_ShareInvitationCodeView.frame)-40, ZOOM6(100));
        _titlelab.textColor = RGBCOLOR_I(253, 204, 33);
        _titlelab.text = [NSString stringWithFormat:@"恭喜你!\n获得%zd个衣豆",self.getYidouCount];
        _discriptionlab.frame = CGRectMake(20, CGRectGetMaxY(_titlelab.frame)+ZOOM6(20), CGRectGetWidth(_ShareInvitationCodeView.frame)-40, ZOOM6(80));
        _discriptionlab.text = [NSString stringWithFormat:@"可以兑换%zd次抽奖机会\n本日抽奖最高可赢取1000元大奖",self.valityGrade];
        _discriptionlab.textAlignment = NSTextAlignmentCenter;
        _discriptionlab.textColor = [UIColor whiteColor];
        _discriptionlab.font = [UIFont systemFontOfSize:ZOOM6(28)];
        
        _bwlklab.frame = CGRectMake(20, CGRectGetMaxY(_discriptionlab.frame), CGRectGetWidth(_ShareInvitationCodeView.frame)-40, 0);
        gobtn.titleLabel.font = [UIFont systemFontOfSize:ZOOM(44)];
        if(gobtn.tag == 7788)
        {
            [gobtn setTitle:@"暂不抽奖" forState:UIControlStateNormal];
            gobtn.frame = CGRectMake(20, CGRectGetMaxY(_bwlklab.frame)+ZOOM6(60), (CGRectGetWidth(_ShareInvitationCodeView.frame)-2*20-20)/2, ZOOM(36*3.4));
            gobtn.backgroundColor = [UIColor whiteColor];
            gobtn.tintColor = RGBCOLOR_I(253, 33, 90);
            
        }else{
            [gobtn setTitle:@"立即抽奖" forState:UIControlStateNormal];
            [gobtn setTitleColor:RGBCOLOR_I(253, 33, 90) forState:UIControlStateNormal];
            gobtn.backgroundColor = RGBCOLOR_I(253, 204, 33);
            
        }
    }else if (type == Detail_Prompt_raward)
    {
        CGFloat imageWidth = IMAGEW(@"hongbao");
        CGFloat imageHeigh = IMAGEH(@"hongbao");
        
        _ShareInvitationCodeView.backgroundColor = RGBA(255, 0, 76, 1);
        _ShareInvitationCodeView.clipsToBounds = NO;
        
        [_canclebtn setImage:[UIImage imageNamed:@"luck-icon_close-"] forState:UIControlStateNormal];
        
        _titleimage.frame = CGRectMake((CGRectGetWidth(_ShareInvitationCodeView.frame)-imageWidth)/2,-imageHeigh*0.98, imageWidth, imageHeigh);
        _titleimage.image = [UIImage imageNamed:@"hongbao"];
        
        _titlelab.frame = CGRectMake(20, CGRectGetMaxY(_titleimage.frame)+ZOOM6(60), CGRectGetWidth(_ShareInvitationCodeView.frame)-40, 20);
        _titlelab.text = @"温馨提示";
        _titlelab.textColor = RGBCOLOR_I(253, 204, 33);
        
        _discriptionlab.text = @"本日购买商品成功可立即参与抽奖，中奖率为50%，最高奖金1000元。";
        CGFloat heigh = [self getRowHeigh:_discriptionlab.text fontSize:ZOOM6(28)];
        _discriptionlab.frame = CGRectMake(20, CGRectGetMaxY(_titlelab.frame)+ZOOM6(20), CGRectGetWidth(_ShareInvitationCodeView.frame)-40, heigh);
        _discriptionlab.textColor = [UIColor whiteColor];
        
        gobtn.frame = CGRectMake(20, CGRectGetMaxY(_discriptionlab.frame)+ZOOM6(60), CGRectGetWidth(_ShareInvitationCodeView.frame)-2*20, ZOOM(36*3.4));
        
        if(gobtn.tag == 7788)
        {
            gobtn.backgroundColor = RGBCOLOR_I(253, 204, 33);
            gobtn.tintColor = RGBCOLOR_I(237, 73, 88);
            
            [gobtn setTitle:@"知道了" forState:UIControlStateNormal];
            
        }else{
            gobtn.hidden = YES;
        }
    }else if (type == GuideOrder_paysuccess)
    {
        _ShareInvitationCodeView.backgroundColor = RGBA(255, 0, 76, 1);
        [_canclebtn setImage:[UIImage imageNamed:@"luck-icon_close-"] forState:UIControlStateNormal];
        CGFloat imageWidth = IMAGEW(@"icon_+yidou-");
        
        _titleimage.frame = CGRectMake((CGRectGetWidth(_ShareInvitationCodeView.frame)-imageWidth)/2,ZOOM6(60), imageWidth, imageWidth*0.5);
        _titleimage.image = [UIImage imageNamed:@"icon_+yidou-"];
        
        _titlelab.frame = CGRectMake(20, CGRectGetMaxY(_titleimage.frame)+ZOOM6(30), CGRectGetWidth(_ShareInvitationCodeView.frame)-40, ZOOM6(100));
        _titlelab.textColor = RGBCOLOR_I(253, 204, 33);
        _titlelab.text = [NSString stringWithFormat:@"恭喜你!\n获得%zd个衣豆",self.getYidouCount];
        _discriptionlab.frame = CGRectMake(20, CGRectGetMaxY(_titlelab.frame)+ZOOM6(20), CGRectGetWidth(_ShareInvitationCodeView.frame)-40, ZOOM6(80));
        _discriptionlab.text = [NSString stringWithFormat:@"并兑换了翻倍%zd次抽奖机会\n马上抽取今日大奖吧",self.valityGrade];
        _discriptionlab.textAlignment = NSTextAlignmentCenter;
        _discriptionlab.textColor = [UIColor whiteColor];
        _discriptionlab.font = [UIFont systemFontOfSize:ZOOM6(28)];
        
        _bwlklab.frame = CGRectMake(20, CGRectGetMaxY(_discriptionlab.frame), CGRectGetWidth(_ShareInvitationCodeView.frame)-40, 0);
        gobtn.titleLabel.font = [UIFont systemFontOfSize:ZOOM(44)];
        if(gobtn.tag == 7788)
        {
            [gobtn setTitle:@"暂不抽奖" forState:UIControlStateNormal];
            gobtn.frame = CGRectMake(20, CGRectGetMaxY(_bwlklab.frame)+ZOOM6(60), (CGRectGetWidth(_ShareInvitationCodeView.frame)-2*20-20)/2, ZOOM(36*3.4));
            gobtn.backgroundColor = [UIColor whiteColor];
            gobtn.tintColor = RGBCOLOR_I(253, 33, 90);
            
        }else{
            [gobtn setTitle:@"立即抽奖" forState:UIControlStateNormal];
            [gobtn setTitleColor:RGBCOLOR_I(253, 33, 90) forState:UIControlStateNormal];
            gobtn.backgroundColor = RGBCOLOR_I(253, 204, 33);
            
        }
    }else if (type == Order_red_fivieChance)
    {
        [_canclebtn setImage:[UIImage imageNamed:@"luck-icon_close-"] forState:UIControlStateNormal];
        
        _ShareInvitationCodeView.backgroundColor = RGBA(255, 0, 76, 1);
        
        _titlelab.text = @"恭喜你！";
        _titlelab.textColor = RGBCOLOR_I(253, 204, 33);
        
        
        NSString *str = [NSString stringWithFormat:@"获得%@次抽奖机会！",[[NSUserDefaults standardUserDefaults]objectForKey:@"RedMoneyLeastNum"]];
        
        CGFloat heigh = [self getRowHeigh:str fontSize:ZOOM6(28)];
        _discriptionlab.frame = CGRectMake(20, CGRectGetMaxY(_titlelab.frame)+ZOOM6(20), CGRectGetWidth(_ShareInvitationCodeView.frame)-40, heigh);
        _discriptionlab.text = [NSString stringWithFormat:@"%@",str];
        _discriptionlab.textAlignment = NSTextAlignmentCenter;
        _discriptionlab.textColor = [UIColor whiteColor];
        
        _bwlklab.frame = CGRectMake(20, CGRectGetMaxY(_discriptionlab.frame), CGRectGetWidth(_ShareInvitationCodeView.frame)-40, 0);
        
        gobtn.titleLabel.font = [UIFont systemFontOfSize:ZOOM(44)];
       
        if(gobtn.tag == 7788)
        {
            gobtn.frame = CGRectMake(20, CGRectGetMaxY(_bwlklab.frame)+ZOOM6(60), CGRectGetWidth(_ShareInvitationCodeView.frame)-2*20, ZOOM(36*3.4));
            gobtn.backgroundColor = RGBCOLOR_I(253, 204, 33);
            gobtn.tintColor = RGBCOLOR_I(237, 73, 88);
            [gobtn setTitle:@"马上抽奖" forState:UIControlStateNormal];
            
        }else{
            gobtn.hidden = YES;
        }

    }else if (type == Order_red_fiveOver)
    {
        [_canclebtn setImage:[UIImage imageNamed:@"luck-icon_close-"] forState:UIControlStateNormal];
        
        _ShareInvitationCodeView.backgroundColor = RGBA(255, 0, 76, 1);
        
        _titlelab.text = @"温馨提示";
        _titlelab.textColor = RGBCOLOR_I(253, 204, 33);
        
        NSString *str = [NSString stringWithFormat:@"嗨，%@次已经抽完了哦，你今天手气不错，共抽中了%.2f元余额。现在去购买心仪的美衣，付款后即可直接参与提现额度的抽奖，最高1000元。祝你好运~",[[NSUserDefaults standardUserDefaults]objectForKey:@"RedMoneyAllNum"],[[[NSUserDefaults standardUserDefaults]objectForKey:@"RedMoneyRaward"] floatValue]];
        NSString *findstr = @"提现额度";
        
        CGFloat heigh = [self getRowHeigh:str fontSize:ZOOM6(32)];
        _discriptionlab.frame = CGRectMake(20, CGRectGetMaxY(_titlelab.frame)+ZOOM6(20), CGRectGetWidth(_ShareInvitationCodeView.frame)-40, heigh);
        _discriptionlab.text = [NSString stringWithFormat:@"%@",str];
        _discriptionlab.textColor = [UIColor whiteColor];
        
        NSMutableAttributedString *nsmutable = [[NSMutableAttributedString alloc]initWithString:_discriptionlab.text];
        NSRange range = [_discriptionlab.text rangeOfString:findstr];
        [nsmutable addAttribute:NSForegroundColorAttributeName value:RGBCOLOR_I(253, 204, 33) range:NSMakeRange(range.location, findstr.length)];
        [nsmutable addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Helvetica-Bold" size:ZOOM6(30)] range:NSMakeRange(range.location, findstr.length)];
        [_discriptionlab setAttributedText:nsmutable];
        
        _bwlklab.frame = CGRectMake(20, CGRectGetMaxY(_discriptionlab.frame), CGRectGetWidth(_ShareInvitationCodeView.frame)-40, 0);
        
        gobtn.titleLabel.font = [UIFont systemFontOfSize:ZOOM(44)];
        
        if(gobtn.tag == 7788)
        {
            gobtn.frame = CGRectMake(20, CGRectGetMaxY(_bwlklab.frame)+ZOOM6(60), CGRectGetWidth(_ShareInvitationCodeView.frame)-2*20, ZOOM(36*3.4));
            gobtn.backgroundColor = RGBCOLOR_I(253, 204, 33);
            gobtn.tintColor = RGBCOLOR_I(237, 73, 88);
            [gobtn setTitle:@"去购买并抽奖" forState:UIControlStateNormal];
            
        }else{
            gobtn.hidden = YES;
        }

    }else if (type == Raward_weixin_bingding)
    {
        [_canclebtn setImage:[UIImage imageNamed:@"luck-icon_close-"] forState:UIControlStateNormal];
        
        _ShareInvitationCodeView.backgroundColor = RGBA(255, 0, 76, 1);
        
        _titlelab.text = @"温馨提示";
        _titlelab.textColor = RGBCOLOR_I(253, 204, 33);
        
        NSString *str = [NSString stringWithFormat:@"%@",@"你抽中的提现额度会在订单交易成功后自动解冻并提现到你绑定的微信提现账户。系统检测到你尚未绑定，请立即绑定微信提现账户。"];
        
        CGFloat heigh = [self getRowHeigh:str fontSize:ZOOM6(32)];
        _discriptionlab.frame = CGRectMake(20, CGRectGetMaxY(_titlelab.frame)+ZOOM6(20), CGRectGetWidth(_ShareInvitationCodeView.frame)-40, heigh);
        _discriptionlab.text = [NSString stringWithFormat:@"%@",str];
        _discriptionlab.textColor = [UIColor whiteColor];
        
        _bwlklab.frame = CGRectMake(20, CGRectGetMaxY(_discriptionlab.frame), CGRectGetWidth(_ShareInvitationCodeView.frame)-40, 0);
        
        gobtn.titleLabel.font = [UIFont systemFontOfSize:ZOOM(44)];
        
        if(gobtn.tag == 7788)
        {
            gobtn.frame = CGRectMake(20, CGRectGetMaxY(_bwlklab.frame)+ZOOM6(60), CGRectGetWidth(_ShareInvitationCodeView.frame)-2*20, ZOOM(36*3.4));
            gobtn.backgroundColor = RGBCOLOR_I(253, 204, 33);
            gobtn.tintColor = RGBCOLOR_I(237, 73, 88);
            [gobtn setTitle:@"现在去绑定" forState:UIControlStateNormal];
            
        }else{
            gobtn.hidden = YES;
        }

    }else if (type == Raward_howMuchChance)
    {
        [_canclebtn setImage:[UIImage imageNamed:@"luck-icon_close-"] forState:UIControlStateNormal];
        
        _ShareInvitationCodeView.backgroundColor = RGBA(255, 0, 76, 1);
        
        _titlelab.frame = CGRectMake(20, CGRectGetMaxY(_titleimage.frame)+ZOOM6(30), CGRectGetWidth(_ShareInvitationCodeView.frame)-40, ZOOM6(40));
        _titlelab.text = @"恭喜你！";
        _titlelab.textColor = RGBCOLOR_I(253, 204, 33);
        
        NSString *str = [NSString stringWithFormat:@"你有%zd次抽奖机会！",self.valityGrade];
        
        CGFloat heigh = [self getRowHeigh:str fontSize:ZOOM6(28)];
        _discriptionlab.frame = CGRectMake(20, CGRectGetMaxY(_titlelab.frame)+ZOOM6(20), CGRectGetWidth(_ShareInvitationCodeView.frame)-40, heigh);
        _discriptionlab.text = [NSString stringWithFormat:@"%@",str];
        _discriptionlab.textAlignment = NSTextAlignmentCenter;
        _discriptionlab.textColor = [UIColor whiteColor];
        
        _bwlklab.frame = CGRectMake(20, CGRectGetMaxY(_discriptionlab.frame), CGRectGetWidth(_ShareInvitationCodeView.frame)-40, 0);
        
        gobtn.titleLabel.font = [UIFont systemFontOfSize:ZOOM(44)];
        
        if(gobtn.tag == 7788)
        {
            gobtn.frame = CGRectMake(20, CGRectGetMaxY(_bwlklab.frame)+ZOOM6(60), CGRectGetWidth(_ShareInvitationCodeView.frame)-2*20, ZOOM(36*3.4));
            gobtn.backgroundColor = RGBCOLOR_I(253, 204, 33);
            gobtn.tintColor = RGBCOLOR_I(237, 73, 88);
            [gobtn setTitle:@"马上抽奖" forState:UIControlStateNormal];
            
        }else{
            gobtn.hidden = YES;
        }
    }else if (type == Super_zeroShopping)
    {
        [_canclebtn setImage:[UIImage imageNamed:@"icon_close"] forState:UIControlStateNormal];
        
        _ShareInvitationCodeView.backgroundColor = [UIColor whiteColor];
        
        _titlelab.frame = CGRectMake(20, CGRectGetMaxY(_titleimage.frame), CGRectGetWidth(_ShareInvitationCodeView.frame)-40, ZOOM6(40));
        _titlelab.text = @"超级0元购";
        
        NSString *str = @"1、购买美衣立即返全部金额入账户余额，还能抽取最高1000元提现红包大奖。\n\n2、1-3个月内每日登录衣蝠并完成全部任务，即可通过惊喜提现任务及抽奖任务全额提现。相当于在衣蝠买美衣永远白送。\n\n3、如3个月未能全额提现，且用户每日登陆衣蝠并完成全部任务，平台将按首月返10%，次月返20%，第三个月返30%的比例把首单购衣款打入提现额度。48小时内到账！";
        CGFloat heigh = [self getRowHeigh:str fontSize:ZOOM6(28)];
        _discriptionlab.frame = CGRectMake(20, CGRectGetMaxY(_titlelab.frame)+ZOOM6(20), CGRectGetWidth(_ShareInvitationCodeView.frame)-40, heigh);
        _discriptionlab.text = [NSString stringWithFormat:@"%@",str];
        _discriptionlab.textColor = RGBCOLOR_I(125, 125, 125);
        
        NSArray *findStrArray = @[@"购买美衣立即返全部金额入账户余额",@"通过惊喜提现任务及抽奖任务全额提现",@"平台将按首月返10%，次月返20%，第三个月返30%的比例"];
        NSMutableAttributedString *mutable;
        if(_discriptionlab.text)
        {
            mutable = [[NSMutableAttributedString alloc]initWithString:_discriptionlab.text];
        }
        for(NSString *findstr in findStrArray)
        {
            NSRange range = [str rangeOfString:findstr];
            [mutable addAttribute:NSForegroundColorAttributeName value:tarbarrossred range:NSMakeRange(range.location, range.length)];
        }
        [_discriptionlab setAttributedText:mutable];
        
        _bwlklab.frame = CGRectMake(20, CGRectGetMaxY(_discriptionlab.frame), CGRectGetWidth(_ShareInvitationCodeView.frame)-40, 0);
        
        if(gobtn.tag == 7788)
        {
            [gobtn setTitle:@"立即0元购美衣" forState:UIControlStateNormal];
            gobtn.frame = CGRectMake(20, CGRectGetMaxY(_bwlklab.frame)+ZOOM6(60), CGRectGetWidth(_ShareInvitationCodeView.frame)-2*20, ZOOM(36*3.4));
            [gobtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            gobtn.backgroundColor = tarbarrossred;
            gobtn.titleLabel.font = [UIFont systemFontOfSize:ZOOM(44)];
        }else{
            gobtn.hidden = YES;
        }
    }else if(type == Raward_oneLuckRule)//1元抽奖规则
    {
        [_canclebtn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        _canclebtn.enabled = NO;
        
        _ShareInvitationCodeView.backgroundColor = RGBA(255, 0, 76, 1);
        
        _titlelab.text = @"活动规则";
        _titlelab.textColor = RGBCOLOR_I(253, 204, 33);
        
        NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
        NSInteger robCount = [user integerForKey:@"oneluckCount"];
        robCount = robCount<=0?0:robCount;
        
        NSString *str = [NSString stringWithFormat:@"1、会员用户可免费领商品，点转盘中央“开始”，转盘指针开始转动。\n\n2、点“停”，如转盘指针停在中央指针处，即成功领走商品。\n\n3、本轮你有%zd次点停机会。",robCount];
        CGFloat heigh = [self getRowHeigh:str fontSize:ZOOM6(30)];
        _discriptionlab.frame = CGRectMake(20, CGRectGetMaxY(_titlelab.frame)+ZOOM6(20), CGRectGetWidth(_ShareInvitationCodeView.frame)-40, heigh);
        _discriptionlab.text = [NSString stringWithFormat:@"%@",str];
        _discriptionlab.textColor = [UIColor whiteColor];
        
        NSString *countstr = [NSString stringWithFormat:@"%zd次",robCount];
        NSArray *findStrArray = @[@"开始",@"停",@"中央指针处",@"全额退款",countstr];
        NSMutableAttributedString *mutable;
        if(_discriptionlab.text) 
        {
            mutable = [[NSMutableAttributedString alloc]initWithString:_discriptionlab.text];
        }
        for(NSString *findstr in findStrArray)
        {
            NSRange range = [str rangeOfString:findstr];
            [mutable addAttribute:NSForegroundColorAttributeName value:RGBCOLOR_I(253, 204, 33) range:NSMakeRange(range.location, range.length)];
            if([findstr isEqualToString:@"1"])
            {
                [mutable addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Helvetica-Bold" size:ZOOM6(32)] range:NSMakeRange(range.location, range.length)];
            }
        }
        [_discriptionlab setAttributedText:mutable];
        
        _bwlklab.frame = CGRectMake(20, CGRectGetMaxY(_discriptionlab.frame), CGRectGetWidth(_ShareInvitationCodeView.frame)-40, 0);
        
        gobtn.titleLabel.font = [UIFont systemFontOfSize:ZOOM(44)];
        if(gobtn.tag == 7788)
        {
            gobtn.frame = CGRectMake(20, CGRectGetMaxY(_bwlklab.frame)+ZOOM6(60), CGRectGetWidth(_ShareInvitationCodeView.frame)-2*20, ZOOM(36*3.4));
            gobtn.backgroundColor = RGBCOLOR_I(253, 204, 33);
            gobtn.tintColor = RGBCOLOR_I(237, 73, 88);
            [gobtn setTitle:@"开始" forState:UIControlStateNormal];
            
        }else{
            gobtn.hidden = YES;
        }
    }else if (type == Raward_oneLuckPrize)//1元购中奖
    {
        [_canclebtn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        _canclebtn.enabled = NO;
        _canclebtn.userInteractionEnabled = NO;
        
        _ShareInvitationCodeView.backgroundColor = RGBA(255, 0, 76, 1);
        
        _titlelab.text = @"点中啦！";
        _titlelab.textColor = RGBCOLOR_I(253, 204, 33);
        
        _discriptionlab.text = @"太厉害了，请收下我的膝盖。";
        _discriptionlab.textColor = [UIColor whiteColor];
        _discriptionlab.textAlignment = NSTextAlignmentCenter;
        

        //取出
        self.orderShopArray = [DataManager sharedManager].orderShopAarray;
        
        ShopDetailModel *shopModel;
        if(self.orderShopArray.count)
        {
            shopModel = self.orderShopArray[0];
        }
        
        NSString *shopnameStr = (self.type_data !=nil && ![self.type_data isEqual:[NSNull class]])?self.type_data:shopModel.shop_name;
        
        NSString *str = [NSString stringWithFormat:@"恭喜免费领走了价值%.2f元的%@，请联系客服发货。",[shopModel.shop_se_price floatValue],(self.type_data !=nil && ![self.type_data isEqual:[NSNull class]])?self.type_data:shopModel.shop_name];
        
        if(self.type_data !=nil && ![self.type_data isEqual:[NSNull class]])
        {

            str = [NSString stringWithFormat:@"恭喜免费领走了价值%.2f元的%@%@，请联系客服发货。",[shopModel.shop_se_price floatValue],(shop_supper_label !=nil && ![shop_supper_label isEqual:[NSNull class]])?shop_supper_label:@"衣蝠",self.type_data];
            shopnameStr = [NSString stringWithFormat:@"%@%@",(shop_supper_label !=nil && ![shop_supper_label isEqual:[NSNull class]])?shop_supper_label:@"衣蝠",self.type_data];
        }
        str = [NSString stringWithFormat:@"恭喜您以%.2f元的价格买走了价值%.2f元的%@",[shopModel.app_shop_group_price floatValue],[shopModel.shop_price floatValue],shopModel.shop_name];
        
        CGFloat heigh = [self getRowHeigh:str fontSize:ZOOM6(30)];
       
        _bwlklab.frame = CGRectMake(20, CGRectGetMaxY(_discriptionlab.frame), CGRectGetWidth(_ShareInvitationCodeView.frame)-40, heigh);
        _bwlklab.text = [NSString stringWithFormat:@"%@",str];
        _bwlklab.textColor = [UIColor whiteColor];
        
        NSString *shopse_pricestr = [NSString stringWithFormat:@"%.2f元",[shopModel.app_shop_group_price floatValue]];
        NSString *shoppricestr = [NSString stringWithFormat:@"价值%.2f元",[shopModel.shop_price floatValue]];
        
        if(shopse_pricestr !=nil && shoppricestr != nil && shopnameStr !=nil)
        {
            NSArray *findStrArray = @[shopse_pricestr,shoppricestr,shopnameStr];
            NSMutableAttributedString *mutable;
            if(_bwlklab.text)
            {
                mutable = [[NSMutableAttributedString alloc]initWithString:_bwlklab.text];
            }
            for(NSString *findstr in findStrArray)
            {
                NSRange range = [str rangeOfString:findstr];
                [mutable addAttribute:NSForegroundColorAttributeName value:RGBCOLOR_I(253, 204, 33) range:NSMakeRange(range.location, range.length)];
            }
            [_bwlklab setAttributedText:mutable];
        }
        
        gobtn.titleLabel.font = [UIFont systemFontOfSize:ZOOM(44)];
        if(gobtn.tag == 7788)
        {
            gobtn.frame = CGRectMake(20, CGRectGetMaxY(_bwlklab.frame)+ZOOM6(60), CGRectGetWidth(_ShareInvitationCodeView.frame)-2*20, ZOOM(36*3.4));
            gobtn.backgroundColor = RGBCOLOR_I(253, 204, 33);
            gobtn.tintColor = RGBCOLOR_I(237, 73, 88);
            [gobtn setTitle:@"我知道了" forState:UIControlStateNormal];
        }else{
            gobtn.hidden = YES;
        }
    }
    else if (type == Raward_oneLuckMore)//1元抽奖再来一次
    {
        [_canclebtn setImage:[UIImage imageNamed:@"luck-icon_close-"] forState:UIControlStateNormal];
        
        _ShareInvitationCodeView.backgroundColor = RGBA(255, 0, 76, 1);
        
        _titlelab.text = @"很遗憾!";
        _titlelab.textColor = RGBCOLOR_I(253, 204, 33);
        
        NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
        NSInteger robCount = [user integerForKey:@"oneluckCount"];
        
        NSString *str = [NSString stringWithFormat:@"只差一点点哦~再眼明手快些吧。\n您还有%zd次机会",robCount];
        
        CGFloat heigh = ZOOM6(80);
        
        _discriptionlab.frame = CGRectMake(20, CGRectGetMaxY(_titlelab.frame)+ZOOM6(20), CGRectGetWidth(_ShareInvitationCodeView.frame)-40, heigh);
        _discriptionlab.text = [NSString stringWithFormat:@"%@",str];
        _discriptionlab.textColor = [UIColor whiteColor];
        _discriptionlab.numberOfLines = 0;
        
        NSArray *findStrArray = @[[NSString stringWithFormat:@"%zd",robCount]];
        NSMutableAttributedString *mutable;
        if(_discriptionlab.text)
        {
            mutable = [[NSMutableAttributedString alloc]initWithString:_discriptionlab.text];
        }
        for(NSString *findstr in findStrArray)
        {
            NSRange range = [str rangeOfString:findstr];
            [mutable addAttribute:NSForegroundColorAttributeName value:RGBCOLOR_I(253, 204, 33) range:NSMakeRange(range.location, range.length)];
            [mutable addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Helvetica-Bold" size:ZOOM6(32)] range:NSMakeRange(range.location, range.length)];
        }
        [_discriptionlab setAttributedText:mutable];
        _bwlklab.frame = CGRectMake(20, CGRectGetMaxY(_discriptionlab.frame), CGRectGetWidth(_ShareInvitationCodeView.frame)-40, 0);
        
        gobtn.titleLabel.font = [UIFont systemFontOfSize:ZOOM(44)];
        if(gobtn.tag == 7788)
        {
            gobtn.frame = CGRectMake(20, CGRectGetMaxY(_bwlklab.frame)+ZOOM6(60), CGRectGetWidth(_ShareInvitationCodeView.frame)-2*20, ZOOM(36*3.4));
            gobtn.backgroundColor = RGBCOLOR_I(253, 204, 33);
            gobtn.tintColor = RGBCOLOR_I(237, 73, 88);
            [gobtn setTitle:@"再抢一轮" forState:UIControlStateNormal];
            
        }else{
            gobtn.hidden = YES;
        }
    }else if (type == Fight_luckSuccess)//拼团成功
    {
        _titlelab.text = @"恭喜你";
        [_canclebtn setImage:[UIImage imageNamed:@"icon_close"] forState:UIControlStateNormal];
        
        NSString *username = [[NSUserDefaults standardUserDefaults] objectForKey:@"fightSuccessUser"];
        _discriptionlab.frame = CGRectMake(20, CGRectGetMaxY(_titlelab.frame)+ZOOM6(20), CGRectGetWidth(_ShareInvitationCodeView.frame)-40, ZOOM6(80));
        _discriptionlab.text = [NSString stringWithFormat:@"恭喜您与%@拼团成功!现在可以立即去免费领走商品啦！",username];
        _discriptionlab.numberOfLines = 0;
        
        NSMutableAttributedString *mutable;
        if(_discriptionlab.text)
        {
            mutable = [[NSMutableAttributedString alloc]initWithString:_discriptionlab.text];
            
            NSRange range = [_discriptionlab.text rangeOfString:username];
            [mutable addAttribute:NSForegroundColorAttributeName value:tarbarrossred range:NSMakeRange(range.location, range.length)];
            [mutable addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Helvetica-Bold" size:ZOOM6(30)] range:NSMakeRange(range.location, range.length)];
        }
        
        [_discriptionlab setAttributedText:mutable];
        
        _bwlklab.frame = CGRectMake(20, CGRectGetMaxY(_discriptionlab.frame), CGRectGetWidth(_ShareInvitationCodeView.frame)-40, 0);
        
        if(gobtn.tag == 7788)
        {
            [gobtn setTitle:@"去免费领商品" forState:UIControlStateNormal];
            gobtn.frame = CGRectMake(20, CGRectGetMaxY(_bwlklab.frame)+ZOOM6(60), CGRectGetWidth(_ShareInvitationCodeView.frame)-2*20, ZOOM(36*3.4));
        }else{
            gobtn.hidden = YES;
        }
    }else if (type == Fight_rawardSuccess){//奖励金入账
        _titlelab.text = @"恭喜你";
        [_canclebtn setImage:[UIImage imageNamed:@"icon_close"] forState:UIControlStateNormal];
        
        NSString *rawardmoney = [[NSUserDefaults standardUserDefaults] objectForKey:@"rawardMoney"];
        _discriptionlab.frame = CGRectMake(20, CGRectGetMaxY(_titlelab.frame)+ZOOM6(20), CGRectGetWidth(_ShareInvitationCodeView.frame)-40, ZOOM6(80));
        _discriptionlab.text = [NSString stringWithFormat:@"您已有下级好友成为付费会员，%@元奖励金已存入账户，可立即提现。",rawardmoney];
        _discriptionlab.numberOfLines = 0;
        
        NSMutableAttributedString *mutable;
        if(_discriptionlab.text)
        {
            mutable = [[NSMutableAttributedString alloc]initWithString:_discriptionlab.text];
            
            NSRange range = [_discriptionlab.text rangeOfString:rawardmoney];
            [mutable addAttribute:NSForegroundColorAttributeName value:tarbarrossred range:NSMakeRange(range.location, range.length+1)];
            [mutable addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Helvetica-Bold" size:ZOOM6(30)] range:NSMakeRange(range.location, range.length+1)];
        }
        
        [_discriptionlab setAttributedText:mutable];
        
        _bwlklab.frame = CGRectMake(20, CGRectGetMaxY(_discriptionlab.frame), CGRectGetWidth(_ShareInvitationCodeView.frame)-40, 0);
        
        if(gobtn.tag == 7788)
        {
            [gobtn setTitle:@"立即提现" forState:UIControlStateNormal];
            gobtn.frame = CGRectMake(20, CGRectGetMaxY(_bwlklab.frame)+ZOOM6(60), CGRectGetWidth(_ShareInvitationCodeView.frame)-2*20, ZOOM(36*3.4));
        }else{
            gobtn.hidden = YES;
        }
    }else if (type == Fight_rawardClear)//奖励金清空
    {
        _titlelab.text = @"温馨提示";
        [_canclebtn setImage:[UIImage imageNamed:@"icon_close"] forState:UIControlStateNormal];
        
        NSString *rawardmoney = [[NSUserDefaults standardUserDefaults] objectForKey:@"rawardMoney"];
        _discriptionlab.frame = CGRectMake(20, CGRectGetMaxY(_titlelab.frame)+ZOOM6(20), CGRectGetWidth(_ShareInvitationCodeView.frame)-40, ZOOM6(120));
        _discriptionlab.text = [NSString stringWithFormat:@"您已有%@元奖励金被清0，请尽快成为会员，否则接下来的奖励金收益会在5日后再次清0。",rawardmoney];
        _discriptionlab.numberOfLines = 0;
        
        NSMutableAttributedString *mutable;
        if(_discriptionlab.text)
        {
            mutable = [[NSMutableAttributedString alloc]initWithString:_discriptionlab.text];
            
            NSRange range = [_discriptionlab.text rangeOfString:rawardmoney];
            [mutable addAttribute:NSForegroundColorAttributeName value:tarbarrossred range:NSMakeRange(range.location, range.length+1)];
            [mutable addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Helvetica-Bold" size:ZOOM6(30)] range:NSMakeRange(range.location, range.length+1)];
        }
        
        [_discriptionlab setAttributedText:mutable];
        _bwlklab.frame = CGRectMake(20, CGRectGetMaxY(_discriptionlab.frame), CGRectGetWidth(_ShareInvitationCodeView.frame)-40, 0);
        gobtn.titleLabel.font = [UIFont systemFontOfSize:ZOOM(44)];
        if(gobtn.tag == 7788)
        {
            [gobtn setTitle:@"查看清空详情" forState:UIControlStateNormal];
            gobtn.frame = CGRectMake(20, CGRectGetMaxY(_bwlklab.frame)+ZOOM6(60), (CGRectGetWidth(_ShareInvitationCodeView.frame)-2*20-20)/2, ZOOM(36*3.4));
            gobtn.backgroundColor = [UIColor whiteColor];
            gobtn.tintColor = RGBCOLOR_I(253, 33, 90);
            gobtn.clipsToBounds = YES;
            gobtn.layer.borderWidth =1;
            gobtn.layer.borderColor = tarbarrossred.CGColor;
            
        }else{
            [gobtn setTitle:@"立即成为会员" forState:UIControlStateNormal];
            [gobtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            gobtn.backgroundColor = tarbarrossred;
        }
    }
    else if (type == Robot_Fight_luckSuccess)//机器人拼团成功
    {
        _titlelab.text = @"恭喜你";
        [_canclebtn setImage:[UIImage imageNamed:@"icon_close"] forState:UIControlStateNormal];
        
        _discriptionlab.frame = CGRectMake(20, CGRectGetMaxY(_titlelab.frame)+ZOOM6(20), CGRectGetWidth(_ShareInvitationCodeView.frame)-40, ZOOM6(80));
        
        NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
        NSString * str = [user objectForKey:@"Fight_userName"];
        _discriptionlab.text = [NSString stringWithFormat:@"恭喜您与%@拼团成功!现在可以立即去免费领走商品啦！",str];
        _discriptionlab.numberOfLines = 0;
        
        NSMutableAttributedString *mutable;
        if(_discriptionlab.text)
        {
            mutable = [[NSMutableAttributedString alloc]initWithString:_discriptionlab.text];
            
            NSRange range = [_discriptionlab.text rangeOfString:str];
            [mutable addAttribute:NSForegroundColorAttributeName value:tarbarrossred range:NSMakeRange(range.location, range.length)];
            [mutable addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Helvetica-Bold" size:ZOOM6(32)] range:NSMakeRange(range.location, range.length)];
        }
     
        [_discriptionlab setAttributedText:mutable];
        
        _bwlklab.frame = CGRectMake(20, CGRectGetMaxY(_discriptionlab.frame), CGRectGetWidth(_ShareInvitationCodeView.frame)-40, 0);
        
        if(gobtn.tag == 7788)
        {
            [gobtn setTitle:@"去免费领商品" forState:UIControlStateNormal];
            gobtn.frame = CGRectMake(20, CGRectGetMaxY(_bwlklab.frame)+ZOOM6(60), CGRectGetWidth(_ShareInvitationCodeView.frame)-2*20, ZOOM(36*3.4));
        }else{
            gobtn.hidden = YES;
        }
    }else if (type == Close_Fight_luckSuccess){
        _titlelab.text = @"温馨提示";
        
        NSString * paymoney = [[NSUserDefaults standardUserDefaults]objectForKey:PAY_MONEY];
        _discriptionlab.text = [NSString stringWithFormat:@"无人参团，您要申请关闭拼团吗？拼团费会在2个工作日内退还至您的付款账户。",paymoney.floatValue];
        
        _bwlklab.frame = CGRectMake(20, CGRectGetMaxY(_discriptionlab.frame), CGRectGetWidth(_ShareInvitationCodeView.frame)-40, 0);
        
        if(gobtn.tag == 7788)
        {
            [gobtn setTitle:@"申请关闭拼团" forState:UIControlStateNormal];
            gobtn.frame = CGRectMake(20, CGRectGetMaxY(_bwlklab.frame)+ZOOM6(60), (CGRectGetWidth(_ShareInvitationCodeView.frame)-2*20-20)/2, ZOOM(36*3.4));
            gobtn.backgroundColor = [UIColor clearColor];
            gobtn.tintColor = tarbarrossred;
            gobtn.layer.borderColor = tarbarrossred.CGColor;
            gobtn.layer.borderWidth=1;
            
        }else{
            [gobtn setTitle:@"继续拼团" forState:UIControlStateNormal];
        }
    }else if (type == BecomeMember_task)//成为会员才能做任务
    {
        _titlelab.text = @"温馨提示";
        [_canclebtn setImage:[UIImage imageNamed:@"icon_close"] forState:UIControlStateNormal];
        
        _discriptionlab.frame = CGRectMake(20, CGRectGetMaxY(_titlelab.frame)+ZOOM6(20), CGRectGetWidth(_ShareInvitationCodeView.frame)-40, ZOOM6(80));
        _discriptionlab.text = @"成为衣蝠会员才可以做任务赚现金哦。";
        _discriptionlab.numberOfLines = 0;
        
        _bwlklab.frame = CGRectMake(20, CGRectGetMaxY(_discriptionlab.frame), CGRectGetWidth(_ShareInvitationCodeView.frame)-40, 0);
        
        if(gobtn.tag == 7788)
        {
            [gobtn setTitle:@"了解如何成为会员" forState:UIControlStateNormal];
            gobtn.frame = CGRectMake(20, CGRectGetMaxY(_bwlklab.frame)+ZOOM6(30), CGRectGetWidth(_ShareInvitationCodeView.frame)-2*20, ZOOM(36*3.4));
        }else{
            gobtn.hidden = YES;
        }
    }else if (type == Raward_oneLuckNOPrize)//会员免费领未中奖
    {
        _titlelab.text = @"本轮未点中哦";
        [_canclebtn setImage:[UIImage imageNamed:@"icon_close"] forState:UIControlStateNormal];
        
        _discriptionlab.frame = CGRectMake(20, CGRectGetMaxY(_titlelab.frame)+ZOOM6(20), CGRectGetWidth(_ShareInvitationCodeView.frame)-40, ZOOM6(80));
        _discriptionlab.numberOfLines = 0;
        if(self.valityGrade == 11)
        {
            _discriptionlab.text = @"尊敬的用户，送您会员资格，可以再免费领一轮。且点中率大幅提升。";
        }else if (self.valityGrade == 13)
        {
            _discriptionlab.text = @"尊敬的用户，送您至尊会员资格，可以免费再抢一轮。且点中率大幅提升。";
        }else if (self.valityGrade == 12)
        {
            _discriptionlab.text = @"尊贵的会员用户，你可继续免费领，也可离开去浏览别的商品。";
        }else if (self.valityGrade == 14)
        {
            _discriptionlab.text = @"疯抢费已退至你的衣幅账户，将在1-2个工作日原路退款至你的支付账户。可在我的-订单列表里随时查看退款进度，请注意查收。";
            _discriptionlab.frame = CGRectMake(20, CGRectGetMaxY(_titlelab.frame)+ZOOM6(20), CGRectGetWidth(_ShareInvitationCodeView.frame)-40, ZOOM6(150));
        }else if (self.valityGrade == 15)
        {
            _discriptionlab.text = @"疯抢费已退至你的衣幅账户，将在1-2个工作日原路退款至你的支付账户。可在我的-订单列表里随时查看退款进度，请注意查收。";
            _discriptionlab.frame = CGRectMake(20, CGRectGetMaxY(_titlelab.frame)+ZOOM6(20), CGRectGetWidth(_ShareInvitationCodeView.frame)-40, ZOOM6(150));
        }
        
        
        _bwlklab.frame = CGRectMake(20, CGRectGetMaxY(_discriptionlab.frame), CGRectGetWidth(_ShareInvitationCodeView.frame)-40, 0);
        
        if(self.valityGrade == 11)
        {
            if(gobtn.tag == 7788)
            {
                [gobtn setTitle:@"再免费领一轮" forState:UIControlStateNormal];
                gobtn.frame = CGRectMake(20, CGRectGetMaxY(_bwlklab.frame)+ZOOM6(30), CGRectGetWidth(_ShareInvitationCodeView.frame)-2*20, ZOOM(36*3.4));
            }else{
                gobtn.hidden = YES;
            }
        }else if (self.valityGrade == 13)
        {
            if(gobtn.tag == 7788)
            {
                [gobtn setTitle:@"免费再抢一轮" forState:UIControlStateNormal];
                gobtn.frame = CGRectMake(20, CGRectGetMaxY(_bwlklab.frame)+ZOOM6(60), (CGRectGetWidth(_ShareInvitationCodeView.frame)-2*20-20)/2, ZOOM(36*3.4));
            }else{
                [gobtn setTitle:@"离开" forState:UIControlStateNormal];
                gobtn.backgroundColor = [UIColor clearColor];
                gobtn.tintColor = tarbarrossred;
                gobtn.layer.borderColor = tarbarrossred.CGColor;
                gobtn.layer.borderWidth=1;
            }
        }else if (self.valityGrade == 12)
        {
            if(gobtn.tag == 7788)
            {
                [gobtn setTitle:@"再点一轮" forState:UIControlStateNormal];
                gobtn.frame = CGRectMake(20, CGRectGetMaxY(_bwlklab.frame)+ZOOM6(60), (CGRectGetWidth(_ShareInvitationCodeView.frame)-2*20-20)/2, ZOOM(36*3.4));
            }else{
                [gobtn setTitle:@"离开" forState:UIControlStateNormal];
                gobtn.backgroundColor = [UIColor clearColor];
                gobtn.tintColor = tarbarrossred;
                gobtn.layer.borderColor = tarbarrossred.CGColor;
                gobtn.layer.borderWidth=1;
            }
        }else if (self.valityGrade == 14)
        {
            if(gobtn.tag == 7788)
            {
                [gobtn setTitle:@"退款进度" forState:UIControlStateNormal];
                gobtn.frame = CGRectMake(20, CGRectGetMaxY(_bwlklab.frame)+ZOOM6(60), (CGRectGetWidth(_ShareInvitationCodeView.frame)-2*20-20)/2, ZOOM(36*3.4));
            }else{
                [gobtn setTitle:@"0元再抢一轮" forState:UIControlStateNormal];
                gobtn.backgroundColor = [UIColor clearColor];
                gobtn.tintColor = tarbarrossred;
                gobtn.layer.borderColor = tarbarrossred.CGColor;
                gobtn.layer.borderWidth=1;
            }
        }else if (self.valityGrade == 15)
        {
            if(gobtn.tag == 7788)
            {
                [gobtn setTitle:@"退款进度" forState:UIControlStateNormal];
                gobtn.frame = CGRectMake(20, CGRectGetMaxY(_bwlklab.frame)+ZOOM6(60), (CGRectGetWidth(_ShareInvitationCodeView.frame)-2*20-20)/2, ZOOM(36*3.4));
            }else{
                [gobtn setTitle:@"再抢一轮" forState:UIControlStateNormal];
                gobtn.backgroundColor = [UIColor clearColor];
                gobtn.tintColor = tarbarrossred;
                gobtn.layer.borderColor = tarbarrossred.CGColor;
                gobtn.layer.borderWidth=1;
            }
        }
        
    }
    else if (type == CodeInvite_what)
    {
        _titlelab.text = @"什么是邀请码";
        
        _discriptionlab.text = @"邀请码是衣蝠注册用户的序列号，可确定好友关系。";
        
        _bwlklab.frame = CGRectMake(20, CGRectGetMaxY(_discriptionlab.frame), CGRectGetWidth(_ShareInvitationCodeView.frame)-40, 0);
        
        if(gobtn.tag == 7788)
        {
            gobtn.frame = CGRectMake(20, CGRectGetMaxY(_bwlklab.frame)+ZOOM6(60), CGRectGetWidth(_ShareInvitationCodeView.frame)-2*20, ZOOM(36*3.4));
            gobtn.backgroundColor = tarbarrossred;
            gobtn.tintColor = [UIColor whiteColor];
            [gobtn setTitle:@"我知道了" forState:UIControlStateNormal];
            
        }else{
            gobtn.hidden = YES;
        }
    }
    
    ShareInvitationCodeViewHeigh = CGRectGetMaxY(gobtn.frame)+ZOOM6(30);
    invitcodeYY = (kScreenHeight - ShareInvitationCodeViewHeigh)/2;
    _ShareInvitationCodeView.frame = CGRectMake(ZOOM(120), invitcodeYY, kScreenWidth-ZOOM(120)*2, ShareInvitationCodeViewHeigh);
}

- (void)selectClick:(UIButton*)sender
{
//    sender.selected = !sender.selected;
//    if(sender.selected == YES)
//    {
//        [sender setBackgroundImage:[UIImage imageNamed:@"luck-cel"] forState:UIControlStateNormal];
//        [[NSUserDefaults standardUserDefaults] setObject:@"select" forKey:RAWARD_UP];
//    }else{
//        [sender setBackgroundImage:[UIImage imageNamed:@"normal-"] forState:UIControlStateNormal];
//        [[NSUserDefaults standardUserDefaults] removeObjectForKey:RAWARD_UP];;
//    }
}

#pragma mark ******** 弹框点击事件 **********
- (void)goClick:(UIButton*)sender
{
    if([self.titlelab.text isEqualToString:@"免费领未成功通知"])
    {
        [self disapper];
        return;
    }
    
    if(sender.tag == 7788)
    {
        if(self.leftHideMindBlock)
        {
            self.leftHideMindBlock(sender.titleLabel.text);
        }

    }else{
        if(self.rightHideMindBlock)
        {
            self.rightHideMindBlock(sender.titleLabel.text);
        }
    }
    
    [self disapper];
}

#pragma mark 关闭弹框
- (void)cancleClick
{
    if(self.vitalityTasktype == Stop_business)
    {
        return;
    }
    
    if(self.closeMindBlock)
    {
        self.closeMindBlock();
    }
    [self remindViewHiden];
}

- (void)disapper
{
    if(self.vitalityTasktype == Stop_business)
    {
        return;
    }
    
    if(self.tapHideMindBlock)
    {
        self.tapHideMindBlock();
    }
    [self remindViewHiden];
}

#pragma mark 弹框消失
- (void)remindViewHiden
{
    [UIView animateWithDuration:0.5 animations:^{
        
        _SharePopview.backgroundColor = [[UIColor colorWithRed:0 green:0 blue:0 alpha:0] colorWithAlphaComponent:0];
        _ShareInvitationCodeView.transform = CGAffineTransformMakeScale(0.25, 0.25);
        _ShareInvitationCodeView.alpha = 0;
        
    } completion:^(BOOL finish) {
        
        [self removeFromSuperview];
    }];
    
}

#pragma mark Lable宽度
-(CGFloat)getRowWidth:(NSString *)text fontSize:(CGFloat)fontSize
{
    //文字高度
    CGFloat width = 0;
    if([[[UIDevice currentDevice]systemVersion] floatValue]>=7.0){
        
        CGRect rect=[text boundingRectWithSize:CGSizeMake(CGRectGetWidth(_ShareInvitationCodeView.frame), 10000) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:fontSize] forKey:NSFontAttributeName] context:nil];
        
        width=rect.size.width;
        
    }
    else{
        
    }
    
    return width;
}

#pragma mark 获取活力值等级
- (NSString*)getValityGrade
{
    NSMutableArray *vipNameArr = [NSMutableArray array];
    NSMutableArray *vipNumArr = [NSMutableArray array];
    NSArray *gradeKeyValue = [[NSUserDefaults standardUserDefaults]objectForKey:@"gradeKeyValue"];
    [gradeKeyValue enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSArray *arr=[(NSString *)obj componentsSeparatedByString:@","];
        [vipNameArr addObject:[NSString stringWithFormat:@"%@会员",arr[1]]];
        [vipNumArr addObject:arr[0]];
    }];
    
    NSArray *imageArr = @[@"icon_vip_Bronze270X180",@"icon_vip_Bronze270X180",@"icon_vip_silver180X120",@"icon_vip_gold270X180"];
    
    NSString *imageStr = @"";
    if([DataManager sharedManager].vipGrade < 4)
    {
        imageStr = imageArr[[DataManager sharedManager].vipGrade];
    }else{
        imageStr = @"icon_vip_gold270X180";
    }

    NSString *gradeStr = @"";
    if(vipNameArr.count > [DataManager sharedManager].vipGrade)
    {
        gradeStr = vipNameArr[[DataManager sharedManager].vipGrade];
    }
    _titleimage.image = [UIImage imageNamed:imageStr];
    return gradeStr;
}
#pragma mark Lable高度
-(CGFloat)getRowHeigh:(NSString *)text fontSize:(CGFloat)fontSize
{
    //文字高度
    CGFloat height = 0;
    if([[[UIDevice currentDevice]systemVersion] floatValue]>=7.0){
        
        CGRect rect=[text boundingRectWithSize:CGSizeMake(CGRectGetWidth(_ShareInvitationCodeView.frame)-40, 10000) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:fontSize] forKey:NSFontAttributeName] context:nil];
        
        height=rect.size.height;
        
    }
    else{
        
    }
    
    return height;
}

//获取订单商品的二级类目
- (void)getShopTypeDataFromShopcode:(NSString*)shopcode
{
    
    kWeakSelf(self);
    [TypeShareModel getTypeCodeWithShop_code:shopcode success:^(TypeShareModel *data) {
        
        if(data.status == 1)
        {
            [DataManager sharedManager].type_data = data.type2;
            
            SqliteManager *manager = [SqliteManager sharedManager];
            TypeTagItem *item = [manager getSuppLabelItemForId:data.supp_label_id];
            
            NSString *sqsupp_label = item != nil?item.class_name:@"";
            
            shop_supper_label = sqsupp_label;
            weakself.type_data = data.type2;
        }
        
        [weakself creaPopview];
    }];
    
}

- (void)setOneYuanDiKou:(CGFloat)oneYuanDiKou
{
    if(self.vitalityTasktype == Detail_OneYuanDeductible)
    {
        _oneYuanDiKou = oneYuanDiKou;
        
        _bwlklab.text = [NSString stringWithFormat:@"累计已退%.1f元\n(可全额抵扣购衣款)",oneYuanDiKou];
        _bwlklab.font = [UIFont fontWithName:@"Helvetica-Bold" size:ZOOM6(28)];
    }
    
//    if(_bwlklab.text)
//    {
//        mutable = [[NSMutableAttributedString alloc]initWithString:_bwlklab.text];
//
//        NSString *str = [NSString stringWithFormat:@"累计已退%.1f元",oneYuanDiKou];
//        NSRange range = [_bwlklab.text rangeOfString:str];
//
//        [mutable addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Helvetica-Bold" size:ZOOM6(32)] range:NSMakeRange(range.location, range.length)];
//        [_bwlklab setAttributedText:mutable];
//    }
    
}
- (void)setOneLuckCount:(NSInteger)oneLuckCount
{
    _oneLuckCount = oneLuckCount;
}
@end
