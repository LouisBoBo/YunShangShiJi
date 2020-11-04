//
//  FinishTaskPopview.m
//  YunShangShiJi
//
//  Created by ios-1 on 16/10/13.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import "FinishTaskPopview.h"
#import "GlobalTool.h"
#import "Signmanager.h"
#import "RawardTableViewCell.h"
#import "MyMD5.h"
@implementation FinishTaskPopview
{
    CGFloat shareimageYY ;
    
    CGFloat invitcodeYY;                  //弹框初始y坐标
    CGFloat ShareInvitationCodeViewHeigh; //弹框的高度
}

- (instancetype)initWithFrame:(CGRect)frame TaskType:(TaskPopType)tasktype TaskValue:(NSString*)taskvalue Title:(NSString*)title RewardValue:(NSString*)rewardValue RewardNumber:(int)num Rewardtype:(NSString*)rewardtype;

{
    if(self = [super initWithFrame:frame])
    {
        self.taskpoptype = tasktype;
        self.TaskValue = taskvalue;
        self.Tasktitle = title;
        self.Rewardvalue = rewardValue;
        self.Rewardtype = rewardtype;
        self.number = num;
        
        if(self.taskpoptype == Task_liulan_gouwushop)
        {
            if([[NSUserDefaults standardUserDefaults]boolForKey:@"is_read"] == YES)
            {
                self.second = [Signmanager SignManarer].now_second;
                self.minute = [Signmanager SignManarer].now_minute;
                
                NSLog(@"*******************1111111%zd",self.second);
            }else{
                self.minute = self.TaskValue.intValue;
                self.second = 0;
            }
        }else if (self.taskpoptype == Task_setHobbySuccess)
        {
            self.Rewardtype = rewardtype;
        }

        [self creaPopview];
    }
    
    return self;
}

- (void)creaPopview
{
    _SharePopview = [[UIView alloc]initWithFrame:CGRectMake(0, 0,kScreenWidth, kScreenHeight)];
    
    _SharePopview.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
    _SharePopview.userInteractionEnabled = YES;
    
    invitcodeYY = (kScreenHeight - ZOOM6(1000))/2;
    ShareInvitationCodeViewHeigh = ZOOM6(1000);
    
    //弹框内容
    _ShareInvitationCodeView = [[UIView alloc]initWithFrame:CGRectMake(ZOOM(120), invitcodeYY, kScreenWidth-ZOOM(120)*2, ShareInvitationCodeViewHeigh)];
    
    _ShareInvitationCodeView.layer.cornerRadius = 5;
    _ShareInvitationCodeView.clipsToBounds = YES;
    _ShareInvitationCodeView.backgroundColor = [UIColor whiteColor];
    [_SharePopview addSubview:_ShareInvitationCodeView];
    
    UIImageView *bgImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, _ShareInvitationCodeView.frame.size.width, ZOOM6(80))];
    bgImg.backgroundColor=tarbarrossred;
    
    if(self.taskpoptype == Task_Manufacturer_type || self.taskpoptype == Balance_notEnough || self.taskpoptype == OrderDetail_paySuccess || self.taskpoptype == RedHongBao_tixian)
    {
        bgImg.frame = CGRectMake(0, 0, _ShareInvitationCodeView.frame.size.width, 0);
    }else if (self.taskpoptype == Task_jizanSuccess_type || self.taskpoptype == Task_jizanFinish_type || self.taskpoptype == Task_jizanOver_type || self.taskpoptype == Task_yiduNoenough_type || self.taskpoptype == Task_DoubleActiveRule || self.taskpoptype == Task_ThousandYunRed || self.taskpoptype == OrderFreeling_paySuccess){
        bgImg.backgroundColor = [UIColor clearColor];
    }
    
    //title
    _headlabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(bgImg.frame), CGRectGetHeight(bgImg.frame))];
    _headlabel.textColor = [UIColor whiteColor];
    _headlabel.text = @"任务完成!";
    _headlabel.backgroundColor = [UIColor clearColor];
    _headlabel.font = [UIFont systemFontOfSize:ZOOM6(40)];
    _headlabel.textAlignment = NSTextAlignmentCenter;
    _headlabel.clipsToBounds = YES;
    _headlabel.userInteractionEnabled = YES;

    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(disapper)];
    [_headlabel addGestureRecognizer:tap];
    
    //关闭按钮
    CGFloat btnwidth = IMGSIZEW(@"qiandao_icon_close");
    CGFloat btnheigh = IMGSIZEH(@"qiandao_icon_close");
    
    _canclebtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _canclebtn.frame=CGRectMake(CGRectGetWidth(_ShareInvitationCodeView.frame)-btnwidth-ZOOM(30), (CGRectGetHeight(bgImg.frame) - btnheigh)/2, btnwidth, btnwidth);
    [_canclebtn setImage:[UIImage imageNamed:@"qiandao_icon_close"] forState:UIControlStateNormal];
    if(self.taskpoptype == Task_jizanSuccess_type || self.taskpoptype == Task_jizanFinish_type || self.taskpoptype == Task_jizanOver_type || self.taskpoptype == Task_yiduNoenough_type || self.taskpoptype == Task_DoubleActiveRule || self.taskpoptype == Task_ThousandYunRed)
    {
        [_canclebtn setImage:[UIImage imageNamed:@"TFWXWithdrawals_weixintixian_close_icon"] forState:UIControlStateNormal];
    }
    _canclebtn.imageView.contentMode=UIViewContentModeScaleAspectFit;
    _canclebtn.layer.cornerRadius=btnwidth/2;
    [_canclebtn addTarget:self action:@selector(cancleClick) forControlEvents:UIControlEventTouchUpInside];
    
    [_ShareInvitationCodeView addSubview:bgImg];
    [_ShareInvitationCodeView addSubview:_headlabel];
    [_ShareInvitationCodeView addSubview:_canclebtn];
    
    //弹框内容
    [self creatDuobao:bgImg Value:nil];
    
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
    _titlelab = [[UILabel alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(headview.frame)+ZOOM6(60), CGRectGetWidth(_ShareInvitationCodeView.frame)-40, 20)];
    _titlelab.text = @"";
    _titlelab.textColor = RGBCOLOR_I(62, 62, 62);
    _titlelab.numberOfLines = 0;
    _titlelab.font = [UIFont systemFontOfSize:ZOOM6(32)];
    
    _discriptionlab = [[UILabel alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(_titlelab.frame), CGRectGetWidth(_ShareInvitationCodeView.frame)-40, ZOOM6(80))];
    _discriptionlab.numberOfLines = 0;
    _discriptionlab.textColor = RGBCOLOR_I(125, 125, 125);
    _discriptionlab.font = [UIFont systemFontOfSize:ZOOM6(28)];
    _discriptionlab.text = @"";
    
    
    _bwlklab = [[UILabel alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(_discriptionlab.frame), CGRectGetWidth(_ShareInvitationCodeView.frame)-40, ZOOM6(40))];
    _bwlklab.numberOfLines = 0;
    _bwlklab.textColor = tarbarrossred;
    _bwlklab.font = [UIFont systemFontOfSize:ZOOM6(24)];
    _bwlklab.text = @"";
    
    _timelable = [[UILabel alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(_discriptionlab.frame), CGRectGetWidth(_titlelab.frame), 30)];
    _timelable.text = @"浏览剩余时间";
    _timelable.textColor = RGBCOLOR_I(62, 62, 62);
    _timelable.font = [UIFont systemFontOfSize:ZOOM6(28)];
    
    _minutelab = [[UILabel alloc]initWithFrame:CGRectMake(ZOOM6(180)+10, 0, 30, 30)];
    _minutelab.layer.cornerRadius = 3;
    _minutelab.clipsToBounds = YES;
    _minutelab.font = [UIFont systemFontOfSize:ZOOM6(36)];
    _minutelab.textColor = [UIColor whiteColor];
    _minutelab.textAlignment = NSTextAlignmentCenter;
    _minutelab.backgroundColor = [UIColor blackColor];
    
    UILabel *moddelab = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_minutelab.frame)+5, 0, 5, 30)];
    moddelab.font = [UIFont systemFontOfSize:ZOOM6(36)];
    moddelab.textAlignment = NSTextAlignmentCenter;
    moddelab.text = @":";
    
    _secondlab = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(moddelab.frame)+5, 0, 30, 30)];
    _secondlab.layer.cornerRadius = 3;
    _secondlab.clipsToBounds = YES;
    _secondlab.font = [UIFont systemFontOfSize:ZOOM6(36)];
    _secondlab.textColor = [UIColor whiteColor];
    _secondlab.textAlignment = NSTextAlignmentCenter;
    _secondlab.backgroundColor = [UIColor blackColor];
    
    _minutelab.text = [NSString stringWithFormat:@"%02d",(int)self.minute];
    _secondlab.text = [NSString stringWithFormat:@"%02d",(int)self.second];
    
    [_timelable addSubview:_minutelab];
    [_timelable addSubview:moddelab];
    [_timelable addSubview:_secondlab];
    
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
        
        [self buttontitle:self.taskpoptype Button:gobtn];

        [gobtn addTarget:self action:@selector(goClick:) forControlEvents:UIControlEventTouchUpInside];
        [_ShareInvitationCodeView addSubview:gobtn];
    }
    
    if(self.taskpoptype == Task_liulan_gouwushop && [[NSUserDefaults standardUserDefaults]boolForKey:@"is_read"] == YES)
    {
        
//        self.second = [Signmanager SignManarer].now_second;
//        self.minute = [Signmanager SignManarer].now_minute;

        NSLog(@"*******************22222222%zd",self.second);
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timeHeadle) userInfo:nil repeats:YES];
    }
}

- (void)buttontitle:(TaskPopType)type Button:(UIButton*)gobtn
{
    gobtn.hidden = NO;
    NSString *rewardvlue = self.Rewardvalue; //奖励值
    int rewardCount = (int)self.number; //分多少次奖励
    
    if (type == Task_order_type)//下单成功
    {
        _titlelab.text = @"下单成功~";
        _titlelab.textAlignment = NSTextAlignmentCenter;
        
        _discriptionlab.text = @"你本月的现金奖励将全部翻倍,记得坚持签到领取更多现金喔~";
        
        _bwlklab.frame = CGRectMake(20, CGRectGetMaxY(_discriptionlab.frame), CGRectGetWidth(_ShareInvitationCodeView.frame)-40, ZOOM6(80));
        _bwlklab.text = @"此外,订单若发生退货/退款,每月惊喜将会失效,需重新完成签到任务";

        if(gobtn.tag == 7788)
        {
            [gobtn setTitle:@"知道了" forState:UIControlStateNormal];
            gobtn.frame = CGRectMake(20, CGRectGetMaxY(_bwlklab.frame)+ZOOM6(60), (CGRectGetWidth(_ShareInvitationCodeView.frame)-2*20-20)/2, ZOOM(36*3.4));
            gobtn.backgroundColor = [UIColor clearColor];
            gobtn.tintColor = tarbarrossred;
            gobtn.layer.borderColor = tarbarrossred.CGColor;
            gobtn.layer.borderWidth=1;
            
        }else{
            [gobtn setTitle:@"再逛逛" forState:UIControlStateNormal];
            
        }
    }else if (type == Task_liulanFinish || type == Task_liulanChuanDaFinish)//浏览任务完成
    {
        _titlelab.text = self.Tasktitle;
        _titlelab.textAlignment = NSTextAlignmentCenter;
        
        rewardvlue = [NSString stringWithFormat:@"%f",rewardvlue.floatValue*rewardCount];
        NSString *sstt = [self getRewad_type:rewardvlue];
        _discriptionlab.text = [NSString stringWithFormat:@"%@奖励已存入你的账户,赶紧去买买买吧~",sstt];
        _bwlklab.frame = CGRectMake(20, CGRectGetMaxY(_discriptionlab.frame), CGRectGetWidth(_ShareInvitationCodeView.frame)-40, 0);
        
        NSMutableAttributedString *nsmutable = [[NSMutableAttributedString alloc]initWithString:_discriptionlab.text];
        [nsmutable addAttribute:NSForegroundColorAttributeName value:tarbarrossred range:NSMakeRange(0, sstt.length)];
        [_discriptionlab setAttributedText:nsmutable];
        
        
        if(gobtn.tag == 7788)
        {
            if(type == Task_liulanChuanDaFinish)
            {
                [gobtn setTitle:@"继续浏览" forState:UIControlStateNormal];
                gobtn.frame = CGRectMake(20, CGRectGetMaxY(_bwlklab.frame)+ZOOM6(60), (CGRectGetWidth(_ShareInvitationCodeView.frame)-2*20-20)/2, ZOOM(36*3.4));
                gobtn.backgroundColor = [UIColor clearColor];
                gobtn.tintColor = tarbarrossred;
                gobtn.layer.borderColor = tarbarrossred.CGColor;
                gobtn.layer.borderWidth=1;

            }else{
                [gobtn setTitle:@"一键做下个任务" forState:UIControlStateNormal];
                gobtn.frame = CGRectMake(20, CGRectGetMaxY(_bwlklab.frame)+ZOOM6(60), CGRectGetWidth(_ShareInvitationCodeView.frame)-2*20, ZOOM(36*3.4));
            }
        }else{
            if(type == Task_liulanChuanDaFinish)
            {
                [gobtn setTitle:@"一键做下个任务" forState:UIControlStateNormal];
                gobtn.titleLabel.font = [UIFont systemFontOfSize:ZOOM6(30)];
            }else
                gobtn.hidden = YES;
        }
        
    }else if (type == Task_liulan_type || type == Task_addCart_type || type == Task_addingCart_type || type == Task_shareShop_type ||type == Task_liulan_gouwushop)//任务提示
    {
        _headlabel.text = @"任务提示";
        
        _titlelab.frame =CGRectMake(20, CGRectGetMaxY(_headlabel.frame)+ZOOM6(60), CGRectGetWidth(_ShareInvitationCodeView.frame)-40, 0);
        
        _discriptionlab.frame = CGRectMake(20, CGRectGetMaxY(_titlelab.frame), CGRectGetWidth(_ShareInvitationCodeView.frame)-40, ZOOM6(80));
        
        if(type == Task_addCart_type)
        {
             _discriptionlab.text = @"将任意喜欢的衣服加入购物车,即可完成任务喔!";
        }else if (type == Task_addingCart_type)
        {
            NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
            NSString *count = [user objectForKey:TASK_ADD_SHOPCART];
            
            
            _discriptionlab.text = [NSString stringWithFormat:@"再加%d件商品到购物车可以完成任务喔~",(int)[Signmanager SignManarer].addShopCart - count.intValue];


        }else if (type == Task_shareShop_type)
        {
            NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
            NSString *count = [user objectForKey:TASK_SHARE_SHOPCOUNT];
            
            if(rewardCount > 0)
            {
                CGFloat rewardMoney = [rewardvlue floatValue];
                _discriptionlab.text = [NSString stringWithFormat:@"分享成功奖励%.2f元，还有%d次机会喔~",rewardMoney,(int)[Signmanager SignManarer].shareShopCart - count.intValue];
            }else{
                _discriptionlab.text = [NSString stringWithFormat:@"再分享%d件商品可以完成任务喔~",(int)[Signmanager SignManarer].shareShopCart - count.intValue];
            }
           
        }else if (type == Task_liulan_type)
        {
        
            NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
            NSString *count = [user objectForKey:TASK_LIULAN_SHOPCOUNT];
            
            if(rewardCount > 0)
            {
                CGFloat rewardMoney = [rewardvlue floatValue];
                _discriptionlab.text = [NSString stringWithFormat:@"浏览完成奖励%.2f元，还有%d次机会喔~",rewardMoney,(int)[Signmanager SignManarer].liulanShopCount - count.intValue];
                
            }else{
                _discriptionlab.text = [NSString stringWithFormat:@"再浏览%d件商品可以完成任务喔~",(int)[Signmanager SignManarer].liulanShopCount - count.intValue];
            }

        }else if(type == Task_liulan_gouwushop)
        {
            if([[NSUserDefaults standardUserDefaults]boolForKey:@"is_read"] == YES)
            {
                _headlabel.text = @"任务正在进行中...";
                
            }else{
                [[NSUserDefaults standardUserDefaults]setBool:NO forKey:@"is_newTask"];
            }
            [_ShareInvitationCodeView addSubview:_timelable];
            
            NSString *frtt = [NSString stringWithFormat:@"浏览%@",self.Tasktitle];
            NSString *tott = [NSString stringWithFormat:@"%@分钟",self.TaskValue];
            
            if([[NSUserDefaults standardUserDefaults]boolForKey:@"is_newTask"] == YES)
            {
                _discriptionlab.frame = CGRectMake(20, CGRectGetMaxY(_titlelab.frame), CGRectGetWidth(_ShareInvitationCodeView.frame)-40, ZOOM6(120));
                _discriptionlab.text = [NSString stringWithFormat:@"正在进行浏览%@%@分钟任务，只有完成该任务后,才可以开始其它同类型的任务哦~",self.Tasktitle,self.TaskValue];
                frtt = [NSString stringWithFormat:@"正在进行浏览%@",self.Tasktitle];
                
            }else{
                _discriptionlab.frame = CGRectMake(20, CGRectGetMaxY(_titlelab.frame), CGRectGetWidth(_ShareInvitationCodeView.frame)-40, ZOOM6(80));
                _discriptionlab.text = [NSString stringWithFormat:@"浏览%@%@分钟，就能领到bling bling的奖励完成任务哦~",self.Tasktitle,self.TaskValue];
            }
           
            NSMutableAttributedString *nsmutable = [[NSMutableAttributedString alloc]initWithString:_discriptionlab.text];
            [nsmutable addAttribute:NSForegroundColorAttributeName value:tarbarrossred range:NSMakeRange(frtt.length, tott.length)];
            [_discriptionlab setAttributedText:nsmutable];

        }
        if(type == Task_liulan_gouwushop)
        {
            _bwlklab.frame = CGRectMake(20, CGRectGetMaxY(_discriptionlab.frame), CGRectGetWidth(_ShareInvitationCodeView.frame)-40, 40);
        }else{
            _bwlklab.frame = CGRectMake(20, CGRectGetMaxY(_discriptionlab.frame), CGRectGetWidth(_ShareInvitationCodeView.frame)-40, 0);
        }
        
        
        if(gobtn.tag == 7788)
        {
            [gobtn setTitle:@"去浏览美衣~" forState:UIControlStateNormal];
            if (type == Task_shareShop_type)
            {
                [gobtn setTitle:@"一键做下一个任务" forState:UIControlStateNormal];
                
            }else if (type == Task_addCart_type || type == Task_addingCart_type)
            {
                [gobtn setTitle:@"去浏览美衣~~" forState:UIControlStateNormal];
            }
            gobtn.frame = CGRectMake(20, CGRectGetMaxY(_bwlklab.frame)+ZOOM6(60), CGRectGetWidth(_ShareInvitationCodeView.frame)-2*20, ZOOM(36*3.4));
        }else{
            gobtn.hidden = YES;
        }

    }
    else if (type == Task_dapeiFinish_type || type == Task_addCartSuccess)//完成搭配板块浏览
    {
        _titlelab.text = [NSString stringWithFormat:@"完成%@浏览~",[Signmanager SignManarer].liulan_taskvalue];
        if(type == Task_addCartSuccess)
        {
            self.Rewardtype = [Signmanager SignManarer].reward_type;
            rewardvlue = [Signmanager SignManarer].reward_value;
            rewardCount = (int)[Signmanager SignManarer].rewardNumber;
            _titlelab.text = @"成功加入购物车~";
        }
        _titlelab.textAlignment = NSTextAlignmentCenter;
        
        rewardvlue = [NSString stringWithFormat:@"%f",rewardvlue.floatValue*rewardCount];
        NSString *sstt = [self getRewad_type:rewardvlue];
        _discriptionlab.text = [NSString stringWithFormat:@"%@奖励已存入你的账户,如果喜欢这件美衣就带它回家吧~",sstt];
        NSMutableAttributedString *nsmutable = [[NSMutableAttributedString alloc]initWithString:_discriptionlab.text];
        [nsmutable addAttribute:NSForegroundColorAttributeName value:tarbarrossred range:NSMakeRange(0, sstt.length)];
        [_discriptionlab setAttributedText:nsmutable];

        
        _bwlklab.frame = CGRectMake(20, CGRectGetMaxY(_discriptionlab.frame), CGRectGetWidth(_ShareInvitationCodeView.frame)-40, 0);
        
        if(gobtn.tag == 7788)
        {
            if(type == Task_addCartSuccess)
            {
                [gobtn setTitle:@"去结算" forState:UIControlStateNormal];
                 gobtn.frame = CGRectMake(20, CGRectGetMaxY(_bwlklab.frame)+ZOOM6(60), (CGRectGetWidth(_ShareInvitationCodeView.frame)-2*20-20)/2, ZOOM(36*3.4));
            }else{
                [gobtn setTitle:@"继续浏览" forState:UIControlStateNormal];
                gobtn.frame = CGRectMake(20, CGRectGetMaxY(_bwlklab.frame)+ZOOM6(60), (CGRectGetWidth(_ShareInvitationCodeView.frame)-2*20-20)/2, ZOOM(36*3.4));
                gobtn.backgroundColor = [UIColor clearColor];
                gobtn.tintColor = tarbarrossred;
                gobtn.layer.borderColor = tarbarrossred.CGColor;
                gobtn.layer.borderWidth=1;
            }
        }else{
           
            [gobtn setTitle:@"一键做下个任务" forState:UIControlStateNormal];
            gobtn.titleLabel.font = [UIFont systemFontOfSize:ZOOM6(30)];
            
        }
        
    }else if(type == Task_Recommend_finish){
        _titlelab.text = @"任务完成";
        _titlelab.textAlignment = NSTextAlignmentCenter;
        
        self.Rewardtype = [Signmanager SignManarer].reward_type;
        rewardvlue = [NSString stringWithFormat:@"%f",[Signmanager SignManarer].reward_value.floatValue];
        
        NSString *sstt = [self getRewad_type:rewardvlue];
        _discriptionlab.text = [NSString stringWithFormat:@"%@奖励已存入你的账户,如果喜欢这件美衣就带它回家吧~",sstt];
        NSMutableAttributedString *nsmutable = [[NSMutableAttributedString alloc]initWithString:_discriptionlab.text];
        [nsmutable addAttribute:NSForegroundColorAttributeName value:tarbarrossred range:NSMakeRange(0, sstt.length)];
        [_discriptionlab setAttributedText:nsmutable];
        
        _bwlklab.frame = CGRectMake(20, CGRectGetMaxY(_discriptionlab.frame), CGRectGetWidth(_ShareInvitationCodeView.frame)-40, 0);
        
//        if(gobtn.tag == 7788)
//        {
//            [gobtn setTitle:@"知道了" forState:UIControlStateNormal];
//            gobtn.frame = CGRectMake(20, CGRectGetMaxY(_bwlklab.frame)+ZOOM6(60), CGRectGetWidth(_ShareInvitationCodeView.frame)-2*20, ZOOM(36*3.4));
//        }else{
//            gobtn.hidden = YES;
//        }

        if(gobtn.tag == 7788)
        {
            [gobtn setTitle:@"继续浏览" forState:UIControlStateNormal];
            gobtn.frame = CGRectMake(20, CGRectGetMaxY(_bwlklab.frame)+ZOOM6(60), (CGRectGetWidth(_ShareInvitationCodeView.frame)-2*20-20)/2, ZOOM(36*3.4));
            gobtn.backgroundColor = [UIColor clearColor];
            gobtn.tintColor = tarbarrossred;
            gobtn.layer.borderColor = tarbarrossred.CGColor;
            gobtn.layer.borderWidth=1;
            
        }else{
            [gobtn setTitle:@"一键做下个任务" forState:UIControlStateNormal];
            gobtn.titleLabel.font = [UIFont systemFontOfSize:ZOOM6(30)];
        }

    }else if(type == Task_duobao_type)//成功参与夺宝
    {
        _titlelab.text = @"参与成功~";
        _titlelab.textAlignment = NSTextAlignmentCenter;
        
        _discriptionlab.text = [NSString stringWithFormat:@"你的抽奖号为：%@",self.Tasktitle];
        
        _bwlklab.frame = CGRectMake(20, CGRectGetMaxY(_discriptionlab.frame), CGRectGetWidth(_ShareInvitationCodeView.frame)-40, ZOOM6(30));
        _bwlklab.text = @"听说买件美衣可以增加运气喔~快来选购吧";
        
        if(gobtn.tag == 7788)
        {
            [gobtn setTitle:@"买买买~" forState:UIControlStateNormal];
            gobtn.frame = CGRectMake(20, CGRectGetMaxY(_bwlklab.frame)+ZOOM6(60), CGRectGetWidth(_ShareInvitationCodeView.frame)-2*20, ZOOM(36*3.4));
        }else{
            gobtn.hidden = YES;
        }
        
    }else if (type == Task_shreSucess_type)//分享成功
    {
        _titlelab.text = @"分享成功~";
        _titlelab.textAlignment = NSTextAlignmentCenter;
        
        rewardvlue = [NSString stringWithFormat:@"%f",rewardvlue.floatValue*rewardCount];
        NSString *sstt = [self getRewad_type:rewardvlue];
//        _discriptionlab.text = [NSString stringWithFormat:@"%@奖励已存入你的帐户,赶紧去买买买吧~",sstt];
        _discriptionlab.text = @"任意好友点击后，任务奖励即到账。";
        
        NSMutableAttributedString *nsmutable = [[NSMutableAttributedString alloc]initWithString:_discriptionlab.text];
        [nsmutable addAttribute:NSForegroundColorAttributeName value:tarbarrossred range:NSMakeRange(0, sstt.length)];
        [_discriptionlab setAttributedText:nsmutable];

        
        _bwlklab.frame = CGRectMake(20, CGRectGetMaxY(_discriptionlab.frame), CGRectGetWidth(_ShareInvitationCodeView.frame)-40, 0);
        
        if(gobtn.tag == 7788)
        {
            [gobtn setTitle:@"一键做下个任务" forState:UIControlStateNormal];
            gobtn.frame = CGRectMake(20, CGRectGetMaxY(_bwlklab.frame)+ZOOM6(60), CGRectGetWidth(_ShareInvitationCodeView.frame)-2*20, ZOOM(36*3.4));
        }else{
            gobtn.hidden = YES;
        }
        
    }else if (type == Task_goldcupons_type || type == Task_goldticket_type || type == Task_double_type)//积分升级金币
    {
        _titlelab.text = @"积分已经升级为金币了哦~";
        
        _discriptionlab.frame = CGRectMake(20, CGRectGetMaxY(_titlelab.frame), CGRectGetWidth(_ShareInvitationCodeView.frame)-40, ZOOM6(120));
        _discriptionlab.text = @"金币购买衣服更实惠啦！\n例如:500金币可用于衣服满5.01元的订单消费";
        
        _bwlklab.frame = CGRectMake(20, CGRectGetMaxY(_discriptionlab.frame), CGRectGetWidth(_ShareInvitationCodeView.frame)-40, ZOOM6(30));
        _bwlklab.text = @"金币有效期只有24小时喔，快来买买吧~";
        
        
        if(type == Task_goldticket_type)
        {
            _titlelab.text = @"优惠劵已经升级为金券了哦~";
            _discriptionlab.text = @"金券购买衣服更实惠啦！\n例如:5元金券可用于衣服满5.01元的订单消费";
            _bwlklab.text = @"金券有效期只有24小时喔，快来买买吧~";
        }else if (type == Task_double_type)
        {
            _titlelab.text = @"你的余额已经翻倍了哦~";
            _discriptionlab.frame = CGRectMake(20, CGRectGetMaxY(_titlelab.frame), CGRectGetWidth(_ShareInvitationCodeView.frame)-40, ZOOM6(40));
            _discriptionlab.text = @"余额翻倍购买衣服更实惠啦!";
            _bwlklab.frame = CGRectMake(20, CGRectGetMaxY(_discriptionlab.frame), CGRectGetWidth(_ShareInvitationCodeView.frame)-40, ZOOM6(60));
            _bwlklab.text = @"余额翻倍有效期只有24小时喔，快来买买吧~";
        }

        if(gobtn.tag == 7788)
        {
            [gobtn setTitle:@"买买买" forState:UIControlStateNormal];
            gobtn.frame = CGRectMake(20, CGRectGetMaxY(_bwlklab.frame)+ZOOM6(60), (CGRectGetWidth(_ShareInvitationCodeView.frame)-2*20-20)/2, ZOOM(36*3.4));
            gobtn.backgroundColor = [UIColor clearColor];
            gobtn.tintColor = tarbarrossred;
            gobtn.layer.borderColor = tarbarrossred.CGColor;
            gobtn.layer.borderWidth=1;
            
        }else{
            [gobtn setTitle:@"查看金币" forState:UIControlStateNormal];
            if(type == Task_goldticket_type)
            {
                [gobtn setTitle:@"查看金券" forState:UIControlStateNormal];
            }else if (type == Task_double_type)
            {
                [gobtn setTitle:@"查看余额" forState:UIControlStateNormal];
            }
        }
    }else if (type == Task_supprise_type)//惊喜任务说明
    {
        _headlabel.text = @"惊喜任务说明";
        
        _titlelab.frame =CGRectMake(20, CGRectGetMaxY(_headlabel.frame)+ZOOM6(60), CGRectGetWidth(_ShareInvitationCodeView.frame)-40, 0);
        
        _discriptionlab.frame = CGRectMake(20, CGRectGetMaxY(_titlelab.frame), CGRectGetWidth(_ShareInvitationCodeView.frame)-40, ZOOM6(150));
        _discriptionlab.text = @"惊喜任务每月限做一次，完成惊喜任务后，当月签到现金奖励全部翻倍。\n本月完成全部任务，最高600元现金奖励在等着您哦！";
        
        _bwlklab.frame = CGRectMake(20, CGRectGetMaxY(_discriptionlab.frame), CGRectGetWidth(_ShareInvitationCodeView.frame)-40, 0);
        
        if(gobtn.tag == 7788)
        {
            [gobtn setTitle:@"买买买~" forState:UIControlStateNormal];
            gobtn.frame = CGRectMake(20, CGRectGetMaxY(_bwlklab.frame)+ZOOM6(60), CGRectGetWidth(_ShareInvitationCodeView.frame)-2*20, ZOOM(36*3.4));
        }else{
            gobtn.hidden = YES;
        }

    }else if (type == Task_goumai_type)
    {
        _headlabel.text = @"购买任务说明";
        
        _titlelab.frame =CGRectMake(20, CGRectGetMaxY(_headlabel.frame)+ZOOM6(60), CGRectGetWidth(_ShareInvitationCodeView.frame)-40, 0);
        
        _discriptionlab.frame = CGRectMake(20, CGRectGetMaxY(_titlelab.frame), CGRectGetWidth(_ShareInvitationCodeView.frame)-40, ZOOM6(180));
        _discriptionlab.text = @"只需购买一件商品即可完成任务，获得提现额度！提现额度在订单完结后（不可退货退款）才能使用哦~若同时购买多件商品，以购买的第一件为完成任务商品！";
        
        _bwlklab.frame = CGRectMake(20, CGRectGetMaxY(_discriptionlab.frame), CGRectGetWidth(_ShareInvitationCodeView.frame)-40, 0);
        
        if(gobtn.tag == 7788)
        {
            [gobtn setTitle:@"买买买~" forState:UIControlStateNormal];
            gobtn.frame = CGRectMake(20, CGRectGetMaxY(_bwlklab.frame)+ZOOM6(60), CGRectGetWidth(_ShareInvitationCodeView.frame)-2*20, ZOOM(36*3.4));
        }else{
            gobtn.hidden = YES;
        }

    }
    else if (type == Task_buyFinish_type)
    {
        _headlabel.text = @"温馨提示";

        _titlelab.frame =CGRectMake(20, CGRectGetMaxY(_headlabel.frame)+ZOOM6(60), CGRectGetWidth(_ShareInvitationCodeView.frame)-40, 0);
        
        _discriptionlab.frame = CGRectMake(20, CGRectGetMaxY(_titlelab.frame), CGRectGetWidth(_ShareInvitationCodeView.frame)-40, ZOOM6(150));
        
//        _discriptionlab.text = @"恭喜你完成购买任务，任务奖励的提现额度已经发放到你的帐户~订单完成后可提现！";
        NSString * paymoney = [[NSUserDefaults standardUserDefaults]objectForKey:PAY_MONEY];
        _discriptionlab.text = [NSString stringWithFormat:@"抽中的提现额度与%.2f元购衣款已返现至账户余额，处于冻结状态，交易成功后即可解冻。",paymoney.floatValue];
        _bwlklab.frame = CGRectMake(20, CGRectGetMaxY(_discriptionlab.frame), CGRectGetWidth(_ShareInvitationCodeView.frame)-40, ZOOM6(0));
        _bwlklab.text = @"如果同时完成多件订单，系统奖默认第一单可享有完成任务的奖励!";
        _bwlklab.textColor = tarbarrossred;
        
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

    }
    else if (type == Task_Manufacturer_type)
    {
        
        _titlelab.frame =CGRectMake(20, CGRectGetMaxY(_headlabel.frame)+ZOOM6(60), CGRectGetWidth(_ShareInvitationCodeView.frame)-40, ZOOM6(60));
        _titlelab.textAlignment = NSTextAlignmentCenter;
        _titlelab.text = [Signmanager SignManarer].suppstr;
        _titlelab.text = [NSString stringWithFormat:@"%@",[Signmanager SignManarer].suppstr];
        
        CGFloat height = [self getRowHeigh:[Signmanager SignManarer].content1 fontSize:ZOOM6(30)];
        _discriptionlab.frame = CGRectMake(20, CGRectGetMaxY(_titlelab.frame), CGRectGetWidth(_ShareInvitationCodeView.frame)-40, height);
        _discriptionlab.text = [Signmanager SignManarer].content1;
        
        CGFloat bwlkheigh = [self getRowHeigh:[Signmanager SignManarer].content2 fontSize:ZOOM6(30)];
        _bwlklab.frame = CGRectMake(20, CGRectGetMaxY(_discriptionlab.frame), CGRectGetWidth(_ShareInvitationCodeView.frame)-40, bwlkheigh);
        _bwlklab.text = [Signmanager SignManarer].content2;
        
        if(gobtn.tag == 7788)
        {
            [gobtn setTitle:@"知道了" forState:UIControlStateNormal];
            gobtn.frame = CGRectMake(20, CGRectGetMaxY(_bwlklab.frame)+ZOOM6(60), CGRectGetWidth(_ShareInvitationCodeView.frame)-2*20, ZOOM(36*3.4));
        }else{
            gobtn.hidden = YES;
        }
    }else if (type == Task_submitHobby)//提交喜好
    {
        _headlabel.text = @"任务提示";
        
        _titlelab.frame =CGRectMake(20, CGRectGetMaxY(_headlabel.frame)+ZOOM6(60), CGRectGetWidth(_ShareInvitationCodeView.frame)-40, 0);
        
        _discriptionlab.frame = CGRectMake(20, CGRectGetMaxY(_titlelab.frame), CGRectGetWidth(_ShareInvitationCodeView.frame)-40, ZOOM6(40));
        _discriptionlab.text = self.Tasktitle;
        _discriptionlab.textAlignment = NSTextAlignmentCenter;
        
        _bwlklab.frame = CGRectMake(20, CGRectGetMaxY(_discriptionlab.frame), CGRectGetWidth(_ShareInvitationCodeView.frame)-40, 0);
        
        if(gobtn.tag == 7788)
        {
            [gobtn setTitle:@"马上去填" forState:UIControlStateNormal];
            gobtn.frame = CGRectMake(20, CGRectGetMaxY(_bwlklab.frame)+ZOOM6(60), CGRectGetWidth(_ShareInvitationCodeView.frame)-2*20, ZOOM(36*3.4));
        }else{
            gobtn.hidden = YES;
        }
        
    }else if (type == Task_setHobbySuccess)
    {
        _titlelab.text = @"设置成功~";
        _titlelab.textAlignment = NSTextAlignmentCenter;
        
        rewardvlue = [NSString stringWithFormat:@"%f",rewardvlue.floatValue];
        NSString *sstt = [self getRewad_type:rewardvlue];
        _discriptionlab.text = [NSString stringWithFormat:@"%@奖励已存入余额,赶紧去买买买吧~",sstt];
        NSMutableAttributedString *nsmutable = [[NSMutableAttributedString alloc]initWithString:_discriptionlab.text];
        [nsmutable addAttribute:NSForegroundColorAttributeName value:tarbarrossred range:NSMakeRange(0, sstt.length)];
        [_discriptionlab setAttributedText:nsmutable];
        
        _bwlklab.frame = CGRectMake(20, CGRectGetMaxY(_discriptionlab.frame), CGRectGetWidth(_ShareInvitationCodeView.frame)-40, 0);
        
        if(gobtn.tag == 7788)
        {
            [gobtn setTitle:@"一键做下个任务" forState:UIControlStateNormal];
            gobtn.frame = CGRectMake(20, CGRectGetMaxY(_bwlklab.frame)+ZOOM6(60), CGRectGetWidth(_ShareInvitationCodeView.frame)-2*20, ZOOM(36*3.4));
        }else{
            gobtn.hidden = YES;
        }
    }else if (type == Task_jizan_type)
    {
        _headlabel.text = @"集赞任务说明";
        
        _titlelab.frame =CGRectMake(20, CGRectGetMaxY(_headlabel.frame)+ZOOM6(60), CGRectGetWidth(_ShareInvitationCodeView.frame)-40, 0);
        
        _discriptionlab.frame = CGRectMake(20, CGRectGetMaxY(_titlelab.frame), CGRectGetWidth(_ShareInvitationCodeView.frame)-40, ZOOM6(250));
        
        _discriptionlab.text = @"用户自己不能给自己点赞，所有给用户点赞的好友只能一天点一次赞。新用户点第一次赞，分享者可以获得1元提现额度；旧用户的第一次赞，分享者可以获得0.1元提现额度；以后的每天旧用户点一次赞，分享者都可以获得0.1元的提现额度。";
        
        _bwlklab.frame = CGRectMake(20, CGRectGetMaxY(_discriptionlab.frame), CGRectGetWidth(_ShareInvitationCodeView.frame)-40, 0);
        
        if(gobtn.tag == 7788)
        {
            [gobtn setTitle:@"去集赞" forState:UIControlStateNormal];
            gobtn.frame = CGRectMake(20, CGRectGetMaxY(_bwlklab.frame)+ZOOM6(60), (CGRectGetWidth(_ShareInvitationCodeView.frame)-2*20-20)/2, ZOOM(36*3.4));
            gobtn.backgroundColor = [UIColor clearColor];
            gobtn.tintColor = tarbarrossred;
            gobtn.layer.borderColor = tarbarrossred.CGColor;
            gobtn.layer.borderWidth=1;
            
        }else{
            [gobtn setTitle:@"集赞排名" forState:UIControlStateNormal];
        }
    }else if (type == Task_jizanFinish_type){
        
        _titlelab.frame =CGRectMake(20, CGRectGetMaxY(_headlabel.frame)-ZOOM6(20), CGRectGetWidth(_ShareInvitationCodeView.frame)-40, ZOOM6(50));
        _titlelab.textAlignment = NSTextAlignmentCenter;
        _titlelab.font = [UIFont systemFontOfSize:ZOOM6(36)];
        _titlelab.text = @"任务完成";
        
        _discriptionlab.frame = CGRectMake(20, CGRectGetMaxY(_titlelab.frame), CGRectGetWidth(_ShareInvitationCodeView.frame)-40, ZOOM6(80));
        _discriptionlab.text = @"恭喜你完成了为好友点赞任务~\n任务奖励已放到你账户里了哦！";
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
            [gobtn setTitle:@"查看余额" forState:UIControlStateNormal];
        }
    }else if (type == Task_jizanOver_type)
    {
        _titlelab.frame =CGRectMake(20, CGRectGetMaxY(_headlabel.frame)-ZOOM6(30), CGRectGetWidth(_ShareInvitationCodeView.frame)-40, ZOOM6(40));
        _titlelab.textAlignment = NSTextAlignmentCenter;
        _titlelab.font = [UIFont systemFontOfSize:ZOOM6(36)];
        _titlelab.text = @"温馨提示";

        _discriptionlab.frame = CGRectMake(20, CGRectGetMaxY(_titlelab.frame), CGRectGetWidth(_ShareInvitationCodeView.frame)-40, ZOOM6(120));
        
        _discriptionlab.text = @"你今日的免费点赞次数已经用完，可以花费5衣豆为上一次点赞的好友继续点赞";
        
        _bwlklab.frame = CGRectMake(20, CGRectGetMaxY(_discriptionlab.frame), CGRectGetWidth(_ShareInvitationCodeView.frame)-40, 0);
        
        if(gobtn.tag == 7788)
        {
            [gobtn setTitle:@"取 消" forState:UIControlStateNormal];
            gobtn.backgroundColor = [UIColor clearColor];
            gobtn.tintColor = tarbarrossred;
            gobtn.layer.borderColor = tarbarrossred.CGColor;
            gobtn.layer.borderWidth=1;
            gobtn.frame = CGRectMake(20, CGRectGetMaxY(_bwlklab.frame)+ZOOM6(60), (CGRectGetWidth(_ShareInvitationCodeView.frame)-2*20-20)/2, ZOOM(36*3.4));
            
        }else{
            [gobtn setTitle:@"确 定" forState:UIControlStateNormal];
        }
    }else if (type == Task_jizanSuccess_type)
    {
        _titlelab.frame =CGRectMake((CGRectGetWidth(_ShareInvitationCodeView.frame)-ZOOM6(50))/2, CGRectGetMaxY(_headlabel.frame)-ZOOM6(30), ZOOM6(50), ZOOM6(50));
        
        UIImageView *image = [[UIImageView alloc]init];
        image.frame = CGRectMake(0, 0, CGRectGetWidth(_titlelab.frame), CGRectGetHeight(_titlelab.frame));
        image.image = [UIImage imageNamed:@"成功"];
        [_titlelab addSubview:image];
        
        _discriptionlab.frame = CGRectMake(20, CGRectGetMaxY(_titlelab.frame)+ZOOM6(30), CGRectGetWidth(_ShareInvitationCodeView.frame)-40, ZOOM6(50));
        _discriptionlab.text = @"恭喜你！点赞成功!";
        _discriptionlab.font = [UIFont systemFontOfSize:ZOOM6(36)];
        _discriptionlab.textAlignment = NSTextAlignmentCenter;
        
        _bwlklab.frame = CGRectMake(20, CGRectGetMaxY(_discriptionlab.frame), CGRectGetWidth(_ShareInvitationCodeView.frame)-40, 0);
        
        if(gobtn.tag == 7788)
        {
            [gobtn setTitle:@"继续点赞" forState:UIControlStateNormal];
            gobtn.frame = CGRectMake(20, CGRectGetMaxY(_bwlklab.frame)+ZOOM6(60), CGRectGetWidth(_ShareInvitationCodeView.frame)-2*20, ZOOM(36*3.4));
        }else{
            gobtn.hidden = YES;
        }
    }else if (type == Task_yiduNoenough_type)
    {
        _titlelab.frame =CGRectMake(20, CGRectGetMaxY(_headlabel.frame)-ZOOM6(20), CGRectGetWidth(_ShareInvitationCodeView.frame)-40, ZOOM6(50));
        _titlelab.textAlignment = NSTextAlignmentCenter;
        _titlelab.font = [UIFont systemFontOfSize:ZOOM6(36)];
        _titlelab.text = @"衣豆不足提示";

        _discriptionlab.frame = CGRectMake(20, CGRectGetMaxY(_titlelab.frame), CGRectGetWidth(_ShareInvitationCodeView.frame)-40, ZOOM6(50));
        
        _discriptionlab.text = @"你当前的衣豆不足，请及时补充哦~";
        
        _bwlklab.frame = CGRectMake(20, CGRectGetMaxY(_discriptionlab.frame), CGRectGetWidth(_ShareInvitationCodeView.frame)-40, 0);
        
        if(gobtn.tag == 7788)
        {
            [gobtn setTitle:@"取 消" forState:UIControlStateNormal];
            gobtn.backgroundColor = [UIColor clearColor];
            gobtn.tintColor = tarbarrossred;
            gobtn.layer.borderColor = tarbarrossred.CGColor;
            gobtn.layer.borderWidth=1;
            gobtn.frame = CGRectMake(20, CGRectGetMaxY(_bwlklab.frame)+ZOOM6(60), (CGRectGetWidth(_ShareInvitationCodeView.frame)-2*20-20)/2, ZOOM(36*3.4));
            
        }else{
            [gobtn setTitle:@"确 定" forState:UIControlStateNormal];
        }
    }else if (type == Task_InvitationSuccess)
    {
        _titlelab.frame =CGRectMake(20, CGRectGetMaxY(_headlabel.frame)+ZOOM6(80), CGRectGetWidth(_ShareInvitationCodeView.frame)-40, 0);
        
        _discriptionlab.frame = CGRectMake(20, CGRectGetMaxY(_titlelab.frame), CGRectGetWidth(_ShareInvitationCodeView.frame)-40, ZOOM6(50));
        
        _discriptionlab.text = @"恭喜你完成了邀请好友集赞任务~";
        
        _bwlklab.frame = CGRectMake(20, CGRectGetMaxY(_discriptionlab.frame), CGRectGetWidth(_ShareInvitationCodeView.frame)-40, 0);
        
        if(gobtn.tag == 7788)
        {
            [gobtn setTitle:@"确 定" forState:UIControlStateNormal];
            gobtn.frame = CGRectMake(20, CGRectGetMaxY(_bwlklab.frame)+ZOOM6(60), CGRectGetWidth(_ShareInvitationCodeView.frame)-2*20, ZOOM(36*3.4));
        }else{
            gobtn.hidden = YES;
        }
    }else if (type == Task_liulan_tixian)
    {
        _headlabel.text = @"任务完成";
        
        _titlelab.frame =CGRectMake(20, CGRectGetMaxY(_headlabel.frame)+ZOOM6(60), CGRectGetWidth(_ShareInvitationCodeView.frame)-40, 0);
        
        _discriptionlab.frame = CGRectMake(20, CGRectGetMaxY(_titlelab.frame), CGRectGetWidth(_ShareInvitationCodeView.frame)-40, ZOOM6(30));
        _discriptionlab.text = @"完成专题栏目浏览";
        _discriptionlab.textAlignment = NSTextAlignmentCenter;
        
        _bwlklab.frame = CGRectMake(20, CGRectGetMaxY(_discriptionlab.frame), CGRectGetWidth(_ShareInvitationCodeView.frame)-40, ZOOM6(80));
        _bwlklab.text = @"今日的浏览奖励已达上限，记得明天再来";
        _bwlklab.textColor = tarbarrossred;
        
        if(gobtn.tag == 7788)
        {
            [gobtn setTitle:@"继续浏览" forState:UIControlStateNormal];
            gobtn.frame = CGRectMake(20, CGRectGetMaxY(_bwlklab.frame)+ZOOM6(60), (CGRectGetWidth(_ShareInvitationCodeView.frame)-2*20-20)/2, ZOOM(36*3.4));
            gobtn.backgroundColor = [UIColor clearColor];
            gobtn.tintColor = tarbarrossred;
            gobtn.layer.borderColor = tarbarrossred.CGColor;
            gobtn.layer.borderWidth=1;
            
        }else{
            [gobtn setTitle:@"一键做下个任务" forState:UIControlStateNormal];
            gobtn.titleLabel.font = [UIFont systemFontOfSize:ZOOM6(30)];
        }
    }else if (type == Task_duobao_kaijiang)
    {
        
        NSArray *valueArray = [self.TaskValue componentsSeparatedByString:@"^"];
        _headlabel.text = @"开奖啦！";
        
        NSString *title = [NSString stringWithFormat:@"您参与的第%@期%@元抽奖开奖啦！",valueArray[3],valueArray[4]];
        CGFloat titleheigh = [self getRowHeigh:title fontSize:ZOOM6(32)];
        _titlelab.frame =CGRectMake(20, CGRectGetMaxY(_headlabel.frame)+ZOOM6(60), CGRectGetWidth(_ShareInvitationCodeView.frame)-40, titleheigh);
        _titlelab.text = title;
        _titlelab.textColor = RGBCOLOR_I(62, 62, 62);
        _titlelab.textAlignment = NSTextAlignmentCenter;
        
        _discriptionlab.frame = CGRectMake(20, CGRectGetMaxY(_titlelab.frame)+ZOOM6(16), CGRectGetWidth(_ShareInvitationCodeView.frame)-40, ZOOM6(110));
        _discriptionlab.text = [NSString stringWithFormat:@"中奖号码为：%@\n中奖者:%@\n参与次数:%@次",valueArray[5],valueArray[2],valueArray[1]];
        if(self.Rewardvalue.intValue == 2)//拼团夺宝
        {
            _discriptionlab.text = [NSString stringWithFormat:@"中奖号码为：%@\n中奖者:%@的团\n参与团次:%@次",valueArray[5],valueArray[2],valueArray[1]];
        }
        _discriptionlab.textColor = RGBCOLOR_I(125, 125, 125);
        _discriptionlab.textAlignment = NSTextAlignmentCenter;
        

        _bwlklab.frame = CGRectMake(20, CGRectGetMaxY(_discriptionlab.frame)+ZOOM6(30), CGRectGetWidth(_ShareInvitationCodeView.frame)-40, ZOOM6(30));
        _bwlklab.text = @"快去看看吧~~说不定下一个就是你哦~";
        _bwlklab.textColor = tarbarrossred;
        _bwlklab.textAlignment = NSTextAlignmentCenter;
        
        if(gobtn.tag == 7788)
        {
            [gobtn setTitle:@"查看详情" forState:UIControlStateNormal];
            gobtn.frame = CGRectMake(20, CGRectGetMaxY(_bwlklab.frame)+ZOOM6(60), CGRectGetWidth(_ShareInvitationCodeView.frame)-2*20, ZOOM(36*3.4));
        }else{
            gobtn.hidden = YES;
        }
    }else if (type == Task_duobao_zongjiang)
    {
        NSArray *valueArray = [self.TaskValue componentsSeparatedByString:@"^"];
        
        _headlabel.text = @"恭喜你,中奖啦！";
        
        NSString *title = [NSString stringWithFormat:@"您参与的第%@期%@元抽奖开奖啦！",valueArray[3],valueArray[4]];
        if(self.Rewardvalue.intValue == 2)//拼团夺宝
        {
            title = [NSString stringWithFormat:@"您参与的第%@期提现抽奖开奖啦！",valueArray[3]];
        }
        CGFloat titleheigh = [self getRowHeigh:title fontSize:ZOOM6(32)];
        _titlelab.frame =CGRectMake(20, CGRectGetMaxY(_headlabel.frame)+ZOOM6(60), CGRectGetWidth(_ShareInvitationCodeView.frame)-40, titleheigh);
        _titlelab.text = title;
        _titlelab.textColor = RGBCOLOR_I(62, 62, 62);
        _titlelab.textAlignment = NSTextAlignmentCenter;
        
        _discriptionlab.frame = CGRectMake(20, CGRectGetMaxY(_titlelab.frame)+ZOOM6(16), CGRectGetWidth(_ShareInvitationCodeView.frame)-40, ZOOM6(40));
        _discriptionlab.text = [NSString stringWithFormat:@"中奖号码为：%@",valueArray[5]];
        _discriptionlab.textColor = RGBCOLOR_I(125, 125, 125);
        _discriptionlab.textAlignment = NSTextAlignmentCenter;
        
        _bwlklab.frame = CGRectMake(20, CGRectGetMaxY(_discriptionlab.frame)+ZOOM6(20), CGRectGetWidth(_ShareInvitationCodeView.frame)-40, ZOOM6(30));
        _bwlklab.text = @"快去看看吧，奖金已经发放到你的账户里了哦~";
        _bwlklab.textColor = tarbarrossred;
        _bwlklab.textAlignment = NSTextAlignmentCenter;

        if(gobtn.tag == 7788)
        {
            [gobtn setTitle:@"查看详情" forState:UIControlStateNormal];
            gobtn.frame = CGRectMake(20, CGRectGetMaxY(_bwlklab.frame)+ZOOM6(60), CGRectGetWidth(_ShareInvitationCodeView.frame)-2*20, ZOOM(36*3.4));
        }else{
            
            gobtn.hidden = YES;
        }
    }else if (type == Task_count_mention)
    {
        _headlabel.text = @"赚钱任务";
        
        NSArray *data = @[@"1、完成全部任务奖励余额与提现现金。",@"2、0元购美衣活动需要每日完成全部任务才能申请保底提现。",@"3、完成全部任务很重要，记得每天完成哦。"];
        [self.dataArray removeAllObjects];
        [self.dataArray addObjectsFromArray:data];
        
        [_ShareInvitationCodeView addSubview:self.mytableview];
        
        _titlelab.frame =CGRectMake(20, CGRectGetMaxY(_headlabel.frame)+ZOOM6(50), CGRectGetWidth(_ShareInvitationCodeView.frame)-40, 0);
        
        _discriptionlab.frame = CGRectMake(20, CGRectGetMaxY(_titlelab.frame), CGRectGetWidth(_ShareInvitationCodeView.frame)-40, ZOOM6(0));
        _discriptionlab.textAlignment = NSTextAlignmentLeft;
//        _discriptionlab.text = self.Tasktitle;
        
        _bwlklab.frame = CGRectMake(20, CGRectGetMaxY(self.mytableview.frame), CGRectGetWidth(_ShareInvitationCodeView.frame)-40, 0);
        
        if(gobtn.tag == 7788)
        {
            [gobtn setTitle:@"去做任务" forState:UIControlStateNormal];
            gobtn.backgroundColor = [UIColor clearColor];
            gobtn.tintColor = tarbarrossred;
            gobtn.layer.borderColor = tarbarrossred.CGColor;
            gobtn.layer.borderWidth=1;
            gobtn.frame = CGRectMake(20, CGRectGetMaxY(_bwlklab.frame)+ZOOM6(60), (CGRectGetWidth(_ShareInvitationCodeView.frame)-2*20-20)/2, ZOOM(36*3.4));

        }else{
            [gobtn setTitle:@"去0元购衣" forState:UIControlStateNormal];
        }
    }else if (type == Task_noFinish_mention)
    {
        _headlabel.text = @"任务提示";
        
        _titlelab.frame =CGRectMake(20, CGRectGetMaxY(_headlabel.frame)+ZOOM6(50), CGRectGetWidth(_ShareInvitationCodeView.frame)-40, ZOOM6(50));
        _titlelab.textAlignment = NSTextAlignmentCenter;
        _titlelab.font = [UIFont systemFontOfSize:ZOOM6(36)];
        _titlelab.text = @"你还有任务未完成哦！";
        
        _discriptionlab.frame = CGRectMake(20, CGRectGetMaxY(_titlelab.frame), CGRectGetWidth(_ShareInvitationCodeView.frame)-40, ZOOM6(150));
        
//        _discriptionlab.text = @"完成任务赢取余额可用来抽取提现额度。0元购美衣更是需要每日完成全部任务才能申请购衣款的保底提现哦。";
        
        _discriptionlab.text = @"完成任务可赢得余额用来抽取可提现现金哦。现在就去完成余下任务吧。";
        _bwlklab.frame = CGRectMake(20, CGRectGetMaxY(_discriptionlab.frame), CGRectGetWidth(_ShareInvitationCodeView.frame)-40, 0);
        
        if(gobtn.tag == 7788)
        {
            [gobtn setTitle:@"我先逛逛" forState:UIControlStateNormal];
            gobtn.backgroundColor = [UIColor clearColor];
            gobtn.tintColor = tarbarrossred;
            gobtn.layer.borderColor = tarbarrossred.CGColor;
            gobtn.layer.borderWidth=1;
            gobtn.frame = CGRectMake(20, CGRectGetMaxY(_bwlklab.frame)+ZOOM6(60), (CGRectGetWidth(_ShareInvitationCodeView.frame)-2*20-20)/2, ZOOM(36*3.4));
            
        }else{
            [gobtn setTitle:@"一键完成任务" forState:UIControlStateNormal];
        }
    }else if (type == Task_tixian_finish)
    {
        _titlelab.frame =CGRectMake(20, CGRectGetMaxY(_headlabel.frame)+ZOOM6(50), CGRectGetWidth(_ShareInvitationCodeView.frame)-40, ZOOM6(40));
        _titlelab.textAlignment = NSTextAlignmentCenter;
        _titlelab.textColor = RGBCOLOR_I(62, 62, 62);
        _titlelab.text = @"恭喜完成提现任务！";
        
        _discriptionlab.frame = CGRectMake(20, CGRectGetMaxY(_titlelab.frame), CGRectGetWidth(_ShareInvitationCodeView.frame)-40, ZOOM6(80));
        
        _discriptionlab.text = @"现在去完成额外任务，赚取更多余额与提现额度吧！";
        
        _bwlklab.frame = CGRectMake(20, CGRectGetMaxY(_discriptionlab.frame), CGRectGetWidth(_ShareInvitationCodeView.frame)-40, 0);
        
        if(gobtn.tag == 7788)
        {
            [gobtn setTitle:@"赚赚赚" forState:UIControlStateNormal];
            gobtn.backgroundColor = [UIColor clearColor];
            gobtn.tintColor = tarbarrossred;
            gobtn.layer.borderColor = tarbarrossred.CGColor;
            gobtn.layer.borderWidth=1;
            gobtn.frame = CGRectMake(20, CGRectGetMaxY(_bwlklab.frame)+ZOOM6(60), (CGRectGetWidth(_ShareInvitationCodeView.frame)-2*20-20)/2, ZOOM(36*3.4));
            
        }else{
            [gobtn setTitle:@"一键完成任务" forState:UIControlStateNormal];
        }

    }else if (type == Task_Finish_mention)
    {
        _titlelab.frame =CGRectMake(20, CGRectGetMaxY(_headlabel.frame)+ZOOM6(50), CGRectGetWidth(_ShareInvitationCodeView.frame)-40, ZOOM6(40));
        _titlelab.textAlignment = NSTextAlignmentCenter;
        _titlelab.textColor = RGBCOLOR_I(62, 62, 62);
        _titlelab.text = @"恭喜你今天完成了全部任务！";
        
        NSArray *countArray = @[@"15",@"16",@"17",@"18",@"19"];
        NSArray *moneyArray = @[@"25",@"30",@"35",@"40",@"45",@"50"];
        
        NSString *count = countArray[arc4random() % countArray.count];
        NSString *money = moneyArray[arc4random() % moneyArray.count];
        
        _discriptionlab.frame = CGRectMake(20, CGRectGetMaxY(_titlelab.frame), CGRectGetWidth(_ShareInvitationCodeView.frame)-40, ZOOM6(80));
        _discriptionlab.text = [NSString stringWithFormat:@"明天会更新%@个任务，共计%@元奖励，记得明天继续来哦！",count,money];
        
        _bwlklab.frame = CGRectMake(20, CGRectGetMaxY(_discriptionlab.frame), CGRectGetWidth(_ShareInvitationCodeView.frame)-40, 0);
        
        if(gobtn.tag == 7788)
        {
            [gobtn setTitle:@"知道了" forState:UIControlStateNormal];
            gobtn.frame = CGRectMake(20, CGRectGetMaxY(_bwlklab.frame)+ZOOM6(60), CGRectGetWidth(_ShareInvitationCodeView.frame)-2*20, ZOOM(36*3.4));
        }else{
            gobtn.hidden = YES;
        }

    }else if (type == Task_H5money_Remind)
    {
        _headlabel.text = @"温馨提示";
        
        _titlelab.frame =CGRectMake(20, CGRectGetMaxY(_headlabel.frame)+ZOOM6(50), CGRectGetWidth(_ShareInvitationCodeView.frame)-40, ZOOM6(0));
       
        _discriptionlab.frame = CGRectMake(20, CGRectGetMaxY(_titlelab.frame), CGRectGetWidth(_ShareInvitationCodeView.frame)-40, ZOOM6(80));
        
        _discriptionlab.text = @"你的签到奖金已放入账户余额。继续努力做任务赚钱吧。";
        
        _bwlklab.frame = CGRectMake(20, CGRectGetMaxY(_discriptionlab.frame), CGRectGetWidth(_ShareInvitationCodeView.frame)-40, 0);
        
        if(gobtn.tag == 7788)
        {
            [gobtn setTitle:@"知道了" forState:UIControlStateNormal];
            gobtn.frame = CGRectMake(20, CGRectGetMaxY(_bwlklab.frame)+ZOOM6(60), CGRectGetWidth(_ShareInvitationCodeView.frame)-2*20, ZOOM(36*3.4));
        }else{
            gobtn.hidden = YES;
        }
    }else if (type == Task_ThousandYunRed)
    {
        
        _titlelab.frame =CGRectMake(20, CGRectGetMaxY(_headlabel.frame)-ZOOM6(20), CGRectGetWidth(_ShareInvitationCodeView.frame)-40, ZOOM6(40));
        _titlelab.textAlignment = NSTextAlignmentCenter;
        _titlelab.text = @"天降千元红包雨";
        
        _discriptionlab.frame = CGRectMake(20, CGRectGetMaxY(_titlelab.frame), CGRectGetWidth(_ShareInvitationCodeView.frame)-40, ZOOM6(180));
        
        _discriptionlab.text = @"1、点千元红包雨任务，开启翻倍抽奖特权。\n\n2、付款后台立即抽奖，本日共有1000个1000元红包大奖哦。";
        
        _bwlklab.frame = CGRectMake(20, CGRectGetMaxY(_discriptionlab.frame), CGRectGetWidth(_ShareInvitationCodeView.frame)-40, 0);
        
        if(gobtn.tag == 7788)
        {
            [gobtn setTitle:@"立即开启特权" forState:UIControlStateNormal];
            gobtn.frame = CGRectMake(20, CGRectGetMaxY(_bwlklab.frame)+ZOOM6(50), CGRectGetWidth(_ShareInvitationCodeView.frame)-2*20, ZOOM(36*3.4));
        }else{
            gobtn.hidden = YES;
        }
    }else if (type == Task_DoubleActiveRule)
    {
        _titlelab.frame =CGRectMake(20, CGRectGetMaxY(_headlabel.frame)-ZOOM6(20), CGRectGetWidth(_ShareInvitationCodeView.frame)-40, ZOOM6(40));
        _titlelab.textAlignment = NSTextAlignmentCenter;
        _titlelab.text = @"活动规则";
        
        _discriptionlab.frame = CGRectMake(20, CGRectGetMaxY(_titlelab.frame), CGRectGetWidth(_ShareInvitationCodeView.frame)-40, ZOOM6(300));
        
        _discriptionlab.text = @"1.购买美衣返双倍购衣款至余额。\n\n2.买50返100 买200返400...以此类推。\n\n3.交易成功后，立即解冻。\n\n4.可同时参与保底提现60%的活动哦。";
        
        _bwlklab.frame = CGRectMake(20, CGRectGetMaxY(_discriptionlab.frame), CGRectGetWidth(_ShareInvitationCodeView.frame)-40, 0);
        
        if(gobtn.tag == 7788)
        {
            [gobtn setTitle:@"买买买" forState:UIControlStateNormal];
            gobtn.frame = CGRectMake(20, CGRectGetMaxY(_bwlklab.frame)+ZOOM6(50), CGRectGetWidth(_ShareInvitationCodeView.frame)-2*20, ZOOM(36*3.4));
        }else{
            gobtn.hidden = YES;
        }

    }else if (type == Task_newShareTixian)
    {
        _headlabel.text = @"任务完成！";
        
        _titlelab.frame =CGRectMake(20, CGRectGetMaxY(_headlabel.frame)+ZOOM6(50), CGRectGetWidth(_ShareInvitationCodeView.frame)-40, ZOOM6(40));
        _titlelab.textAlignment = NSTextAlignmentCenter;
        _titlelab.textColor = RGBCOLOR_I(62, 62, 62);
        _titlelab.text = @"分享成功~";
        
        _discriptionlab.frame = CGRectMake(20, CGRectGetMaxY(_titlelab.frame), CGRectGetWidth(_ShareInvitationCodeView.frame)-40, ZOOM6(80));
        
        _discriptionlab.text = @"好友来做赚钱任务或购买美衣后，你就能得到奖励哦。";
        
        _bwlklab.frame = CGRectMake(20, CGRectGetMaxY(_discriptionlab.frame), CGRectGetWidth(_ShareInvitationCodeView.frame)-40, 0);
        
        if(gobtn.tag == 7788)
        {
            [gobtn setTitle:@"继续分享" forState:UIControlStateNormal];
            gobtn.backgroundColor = [UIColor clearColor];
            gobtn.tintColor = tarbarrossred;
            gobtn.layer.borderColor = tarbarrossred.CGColor;
            gobtn.layer.borderWidth=1;
            gobtn.frame = CGRectMake(20, CGRectGetMaxY(_bwlklab.frame)+ZOOM6(60), (CGRectGetWidth(_ShareInvitationCodeView.frame)-2*20-20)/2, ZOOM(36*3.4));
            
        }else{
            [gobtn setTitle:@"继续做任务" forState:UIControlStateNormal];
        }

    }else if (type == Balance_notEnough)
    {
        
        UITapGestureRecognizer *cancletap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(cancleClick)];
        _SharePopview.userInteractionEnabled = YES;
        [_SharePopview addGestureRecognizer:cancletap];
        
        _headlabel.frame = CGRectZero;
        
        UIImageView *bigImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_headlabel.frame), CGRectGetWidth(_ShareInvitationCodeView.frame), CGRectGetWidth(_ShareInvitationCodeView.frame)*1.25)];
        bigImage.image = [self.Tasktitle isEqualToString:@"提现成功"]? [UIImage imageNamed:@"wx_tixian_complete.png"]:[UIImage imageNamed:@"tixian_no_tixian.png"];
        bigImage.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(addYueClick:)];
        [bigImage addGestureRecognizer:tap];
        [_ShareInvitationCodeView addSubview:bigImage];
        
//        _titlelab.frame =CGRectMake(20, CGRectGetMaxY(_headlabel.frame)+ZOOM6(30), CGRectGetWidth(_ShareInvitationCodeView.frame)-40, ZOOM6(60));
//        _titlelab.textAlignment = NSTextAlignmentCenter;
//        _titlelab.textColor = RGBCOLOR_I(62, 62, 62);
//        _titlelab.text = @"提现额度不足！";
//
//        NSArray *titleArray = @[@"衣蝠为你准备了20元提现现金，可以马上提现。",@"每日完成赚钱小任务都有机会赚取到2-5元不等的提现现金。",@"你也可以继续参与组团疯抢，未抢退还全部金额，可立即提现。",@"你也可以直接购买限时特价品，最低4块9还包邮哦。"];
//        NSArray *buttonArray = @[@"立即领取",@"赚钱任务",@"继续疯抢",@"限时特价"];
//
//        for(int i= 0;i<titleArray.count;i++)
//        {
//            UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(_titlelab.frame)+ZOOM6(200)*i, CGRectGetWidth(_ShareInvitationCodeView.frame)-40, ZOOM6(80))];
//            titleLab.textColor = RGBCOLOR_I(62, 62, 62);
//            titleLab.font = [UIFont systemFontOfSize:ZOOM6(26)];
//            titleLab.numberOfLines = 0;
//            titleLab.text = titleArray[i];
//
//            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//            button.frame = CGRectMake(20, CGRectGetMaxY(titleLab.frame)+ZOOM6(20), CGRectGetWidth(titleLab.frame), ZOOM6(80));
//            [button setTitle:buttonArray[i] forState:UIControlStateNormal];
//            button.backgroundColor = tarbarrossred;
//            button.clipsToBounds = YES;
//            button.layer.cornerRadius = 5;
//            button.tag = 10000+i;
//            button.titleLabel.font = [UIFont systemFontOfSize:ZOOM6(32)];
//            [button setTintColor:[UIColor whiteColor]];
//
//            [button addTarget:self action:@selector(balancClick:) forControlEvents:UIControlEventTouchUpInside];
//
//            [_ShareInvitationCodeView addSubview:titleLab];
//            [_ShareInvitationCodeView addSubview:button];
//        }
//
        if(gobtn.tag == 7788)
        {
            gobtn.frame = CGRectMake(20, CGRectGetMaxY(bigImage.frame)-ZOOM6(50), CGRectGetWidth(_ShareInvitationCodeView.frame)-2*20, ZOOM(0));

        }else{
            gobtn.frame = CGRectMake(20, CGRectGetMaxY(bigImage.frame)-ZOOM6(50), CGRectGetWidth(_ShareInvitationCodeView.frame)-2*20, ZOOM(0));
        }

    }else if (type == OrderDetail_paySuccess)
    {
        UITapGestureRecognizer *cancletap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(cancleClick)];
        _SharePopview.userInteractionEnabled = YES;
        [_SharePopview addGestureRecognizer:cancletap];
        
        _headlabel.frame = CGRectZero;
        
        _titlelab.frame =CGRectMake((CGRectGetWidth(_ShareInvitationCodeView.frame)-ZOOM6(180))/2, CGRectGetMaxY(_headlabel.frame)+ZOOM6(50), ZOOM6(160), ZOOM6(40));
        _titlelab.textAlignment = NSTextAlignmentCenter;
        _titlelab.textColor = RGBCOLOR_I(62, 62, 62);
        _titlelab.font = [UIFont systemFontOfSize:ZOOM6(32)];
        _titlelab.text = @"支付成功";
        
        UIImageView *titlemage = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_titlelab.frame),CGRectGetMinY(_titlelab.frame)+ZOOM6(2), ZOOM6(35), ZOOM6(35))];
        titlemage.image = [UIImage imageNamed:@"提现成功.png"];
        [_ShareInvitationCodeView addSubview:titlemage];
        
        UIImageView *remarmage = [[UIImageView alloc] initWithFrame:CGRectMake((CGRectGetWidth(_ShareInvitationCodeView.frame)-ZOOM6(40))/2, CGRectGetMaxY(_titlelab.frame)+ZOOM6(70), ZOOM6(40), ZOOM6(40))];
        remarmage.image = [UIImage imageNamed:@"go_next_down.png"];
        [_ShareInvitationCodeView addSubview:remarmage];
        
        UILabel *redtitleLab = [[UILabel alloc]init];
        redtitleLab.frame =CGRectMake(20, CGRectGetMaxY(remarmage.frame)+ZOOM6(70), CGRectGetWidth(_ShareInvitationCodeView.frame)-40, ZOOM6(50));
        redtitleLab.textAlignment = NSTextAlignmentCenter;
        redtitleLab.textColor = RGBCOLOR_I(62, 62, 62);
        redtitleLab.text = @"恭喜！获得现金红包";
        redtitleLab.font = [UIFont systemFontOfSize:ZOOM6(35)];
        [_ShareInvitationCodeView addSubview:redtitleLab];
        
        CGFloat rewardMoney = self.TaskValue.floatValue*0.5 > 50?50:self.TaskValue.floatValue*0.5;
        UILabel *redMoneyLab = [[UILabel alloc]init];
        redMoneyLab.frame =CGRectMake(20, CGRectGetMaxY(redtitleLab.frame), CGRectGetWidth(_ShareInvitationCodeView.frame)-40, ZOOM6(80));
        redMoneyLab.textAlignment = NSTextAlignmentCenter;
        redMoneyLab.textColor = tarbarrossred;
        redMoneyLab.font = [UIFont systemFontOfSize:ZOOM6(73)];
        redMoneyLab.text = [NSString stringWithFormat:@"￥%.1f",rewardMoney];
        [_ShareInvitationCodeView addSubview:redMoneyLab];
        
        NSMutableAttributedString *nsmutable = [[NSMutableAttributedString alloc]initWithString:redMoneyLab.text];
        [nsmutable addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:ZOOM6(36)] range:NSMakeRange(0, 1)];
        [redMoneyLab setAttributedText:nsmutable];
        
        UIImageView *remarmage1 = [[UIImageView alloc] initWithFrame:CGRectMake((CGRectGetWidth(_ShareInvitationCodeView.frame)-ZOOM6(40))/2, CGRectGetMaxY(redMoneyLab.frame)+ZOOM6(70), ZOOM6(40), ZOOM6(40))];
        remarmage1.image = [UIImage imageNamed:@"go_next_down.png"];
        [_ShareInvitationCodeView addSubview:remarmage1];
        
       
        _discriptionlab.frame = CGRectMake(20, CGRectGetMaxY(remarmage1.frame), CGRectGetWidth(_ShareInvitationCodeView.frame)-40, 0);
        
        _bwlklab.frame = CGRectMake(20, CGRectGetMaxY(_discriptionlab.frame), CGRectGetWidth(_ShareInvitationCodeView.frame)-40, 0);
        
        
        if(gobtn.tag == 7788)
        {
            [gobtn setTitle:@"立即领取" forState:UIControlStateNormal];
            gobtn.frame = CGRectMake(20, CGRectGetMaxY(_bwlklab.frame)+ZOOM6(50), CGRectGetWidth(_ShareInvitationCodeView.frame)-2*20, ZOOM(36*3.4));
        }else{
            gobtn.hidden = YES;
        }
    }else if (type == OrderFreeling_paySuccess){
        UITapGestureRecognizer *cancletap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(cancleClick)];
        _SharePopview.userInteractionEnabled = YES;
        [_SharePopview addGestureRecognizer:cancletap];
        
        _headlabel.frame = CGRectZero;
        
        _titlelab.frame =CGRectMake((CGRectGetWidth(_ShareInvitationCodeView.frame)-ZOOM6(180))/2, CGRectGetMaxY(_headlabel.frame)+ZOOM6(50), ZOOM6(160), ZOOM6(40));
        _titlelab.textAlignment = NSTextAlignmentCenter;
        _titlelab.textColor = RGBCOLOR_I(62, 62, 62);
        _titlelab.font = [UIFont systemFontOfSize:ZOOM6(32)];
        _titlelab.text = @"支付成功";
        
        UIImageView *titlemage = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_titlelab.frame),CGRectGetMinY(_titlelab.frame)+ZOOM6(2), ZOOM6(35), ZOOM6(35))];
        titlemage.image = [UIImage imageNamed:@"提现成功.png"];
        [_ShareInvitationCodeView addSubview:titlemage];
        
        
        _discriptionlab.frame = CGRectMake(20, CGRectGetMaxY(_titlelab.frame)+ZOOM6(20), CGRectGetWidth(_ShareInvitationCodeView.frame)-40, ZOOM6(80));
        _discriptionlab.text = @"恭喜您成功参与免费领美衣活动，请点击下方按钮，联系客服发货。";
        
        _bwlklab.frame = CGRectMake(20, CGRectGetMaxY(_discriptionlab.frame), CGRectGetWidth(_ShareInvitationCodeView.frame)-40, 0);
        
        if(gobtn.tag == 7788)
        {
            [gobtn setTitle:@"接通微信客服" forState:UIControlStateNormal];
            gobtn.frame = CGRectMake(20, CGRectGetMaxY(_bwlklab.frame)+ZOOM6(50), CGRectGetWidth(_ShareInvitationCodeView.frame)-2*20, ZOOM(36*3.4));
        }else{
            gobtn.hidden = YES;
        }
    } else if (type == RedHongBao_tixian){
        
        _canclebtn.hidden = YES;
        _headlabel.frame = CGRectZero;
        
        _titlelab.frame =CGRectMake((CGRectGetWidth(_ShareInvitationCodeView.frame)-ZOOM6(360))/2, CGRectGetMaxY(_headlabel.frame)+ZOOM6(50), ZOOM6(360), ZOOM6(40));
        _titlelab.textAlignment = NSTextAlignmentCenter;
        _titlelab.textColor = RGBCOLOR_I(62, 62, 62);
        _titlelab.font = [UIFont systemFontOfSize:ZOOM6(40)];
        _titlelab.text = @"20元红包已入账";
        
        
        UIImageView *remarmage = [[UIImageView alloc] initWithFrame:CGRectMake((CGRectGetWidth(_ShareInvitationCodeView.frame)-ZOOM6(40))/2, CGRectGetMaxY(_titlelab.frame)+ZOOM6(70), ZOOM6(40), ZOOM6(40))];
        remarmage.image = [UIImage imageNamed:@"go_next_down.png"];
        [_ShareInvitationCodeView addSubview:remarmage];
        
        CGFloat rewardMoney = self.Rewardvalue.floatValue > 0?self.Rewardvalue.floatValue:6;
        NSString *couponMoney = [NSString stringWithFormat:@"%.0f",rewardMoney];
        NSString *tixianMoney = [NSString stringWithFormat:@"%.0f",20-rewardMoney];
        
        UILabel *redtitleLab = [[UILabel alloc]init];
        redtitleLab.frame =CGRectMake(20, CGRectGetMaxY(remarmage.frame)+ZOOM6(70), CGRectGetWidth(_ShareInvitationCodeView.frame)-40, ZOOM6(50));
        redtitleLab.textAlignment = NSTextAlignmentCenter;
        redtitleLab.textColor = RGBCOLOR_I(62, 62, 62);
        redtitleLab.text = [NSString stringWithFormat:@"拼团任意商品立减%.0f元",rewardMoney];
        redtitleLab.font = [UIFont systemFontOfSize:ZOOM6(30)];
        [_ShareInvitationCodeView addSubview:redtitleLab];
        
        NSMutableAttributedString *nsmutable1 = [[NSMutableAttributedString alloc]initWithString:redtitleLab.text];
        [nsmutable1 addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Helvetica-Bold" size:ZOOM6(40)] range:NSMakeRange(8, couponMoney.length)];
        [nsmutable1 addAttribute:NSForegroundColorAttributeName value:tarbarrossred range:NSMakeRange(8, couponMoney.length)];
        [redtitleLab setAttributedText:nsmutable1];
        
        
        UILabel *redMoneyLab = [[UILabel alloc]init];
        redMoneyLab.frame =CGRectMake(20, CGRectGetMaxY(redtitleLab.frame), CGRectGetWidth(_ShareInvitationCodeView.frame)-40, ZOOM6(80));
        redMoneyLab.textAlignment = NSTextAlignmentCenter;
        redMoneyLab.textColor = RGBCOLOR_I(62, 62, 62);
        redMoneyLab.font = [UIFont systemFontOfSize:ZOOM6(30)];
        redMoneyLab.text = [NSString stringWithFormat:@"并可提现%@元",tixianMoney];
        [_ShareInvitationCodeView addSubview:redMoneyLab];
        
        NSMutableAttributedString *nsmutable2 = [[NSMutableAttributedString alloc]initWithString:redMoneyLab.text];
        [nsmutable2 addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Helvetica-Bold" size:ZOOM6(40)] range:NSMakeRange(4, tixianMoney.length)];
        [nsmutable2 addAttribute:NSForegroundColorAttributeName value:tarbarrossred range:NSMakeRange(4, tixianMoney.length)];
        [redMoneyLab setAttributedText:nsmutable2];
        
        UIImageView *remarmage1 = [[UIImageView alloc] initWithFrame:CGRectMake((CGRectGetWidth(_ShareInvitationCodeView.frame)-ZOOM6(40))/2, CGRectGetMaxY(redMoneyLab.frame)+ZOOM6(70), ZOOM6(40), ZOOM6(40))];
        remarmage1.image = [UIImage imageNamed:@"go_next_down.png"];
        [_ShareInvitationCodeView addSubview:remarmage1];
        
        
        _discriptionlab.frame = CGRectMake(20, CGRectGetMaxY(remarmage1.frame), CGRectGetWidth(_ShareInvitationCodeView.frame)-40, 0);
        
        _bwlklab.frame = CGRectMake(20, CGRectGetMaxY(_discriptionlab.frame), CGRectGetWidth(_ShareInvitationCodeView.frame)-40, 0);
        
        
        if(gobtn.tag == 7788)
        {
            [gobtn setTitle:@"立即开启提现" forState:UIControlStateNormal];
            gobtn.frame = CGRectMake(20, CGRectGetMaxY(_bwlklab.frame)+ZOOM6(50), CGRectGetWidth(_ShareInvitationCodeView.frame)-2*20, ZOOM(36*3.4));
        }else{
            gobtn.hidden = YES;
        }
    }
    
    ShareInvitationCodeViewHeigh = CGRectGetMaxY(gobtn.frame)+ZOOM6(50);
    invitcodeYY = (kScreenHeight - ShareInvitationCodeViewHeigh)/2;
    _ShareInvitationCodeView.frame = CGRectMake(ZOOM(120), invitcodeYY, kScreenWidth-ZOOM(120)*2, ShareInvitationCodeViewHeigh);
}

- (NSString*)getRewad_type:(NSString*)rewardvalue
{
    NSString *str = @"";
    if([self.Rewardtype isEqualToString:DAILY_TASK_JIFEN])
    {
        str = [NSString stringWithFormat:@"%.0f积分",[rewardvalue floatValue]];
    }else if ([self.Rewardtype isEqualToString:DAILY_TASK_XIANJING])
    {
        str = [NSString stringWithFormat:@"%.2f元",[rewardvalue floatValue]];
    }else if ([self.Rewardtype isEqualToString:DAILY_TASK_YOUHUI])
    {
        str = [NSString stringWithFormat:@"%.0f元优惠劵",[rewardvalue floatValue]];
    }else if ([self.Rewardtype isEqualToString:DAILY_TASK_YIDOU])
    {
        str = [NSString stringWithFormat:@"%.d个衣豆",rewardvalue.intValue];
    }
    
    return str;
}

#pragma mark ******** 弹框点击事件 **********
- (void)goClick:(UIButton*)sender
{
    if(sender.tag == 7788)//左
    {
        if(self.leftHideMindBlock)
        {
            if(self.taskpoptype == Task_liulan_gouwushop)
            {
                
//                if([[NSUserDefaults standardUserDefaults]boolForKey:@"is_read"] == YES)
//                {
//                    self.second = [Signmanager SignManarer].now_second;
//                    self.minute = [Signmanager SignManarer].now_minute;
//                }
                
                if(self.timer == nil && [[NSUserDefaults standardUserDefaults]boolForKey:@"is_read"] == YES)
                {
                    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timeHeadle) userInfo:nil repeats:YES];
                }
            }

            self.leftHideMindBlock(sender.titleLabel.text);
        }
        
    }else if (sender.tag == 7789)//右
    {
        if(self.leftHideMindBlock)
        {
            self.rightHideMindBlock(sender.titleLabel.text);
        }
    }
    
    [self disapper];
}

- (void)addYueClick:(UITapGestureRecognizer*)tap
{
    if(self.balanceHideMindBlock)
    {
        self.balanceHideMindBlock(10001);
    }
    [self cancleClick];
}
- (void)balancClick:(UIButton*)sender
{
    if(self.balanceHideMindBlock)
    {
        self.balanceHideMindBlock(sender.tag);
    }
    [self cancleClick];
    
}
#pragma mark 关闭弹框
- (void)cancleClick
{
    [self disapper];
}

- (void)disapper
{
    if(self.tapHideMindBlock)
    {
        self.tapHideMindBlock();
    }
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
    CGFloat width;
    if([[[UIDevice currentDevice]systemVersion] floatValue]>=7.0){
        
        CGRect rect=[text boundingRectWithSize:CGSizeMake(CGRectGetWidth(_ShareInvitationCodeView.frame), 10000) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:fontSize] forKey:NSFontAttributeName] context:nil];
        
        width=rect.size.width;
        
    }
    else{
        
    }
    
    return width;
}


#pragma mark Lable高度
-(CGFloat)getRowHeigh:(NSString *)text fontSize:(CGFloat)fontSize
{
    //文字高度
    CGFloat height;
    CGFloat space = 40;
    if([[[UIDevice currentDevice]systemVersion] floatValue]>=7.0){
        
        CGRect rect=[text boundingRectWithSize:CGSizeMake(CGRectGetWidth(_ShareInvitationCodeView.frame)-space, 10000) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:fontSize] forKey:NSFontAttributeName] context:nil];
        
        height=rect.size.height;
        
    }
    else{
        
    }
    
    return height;
}

//倒计时
- (void)timeHeadle{
    
    self.second--;
    if (self.second==-1 && self.minute>0)
    {
        self.second=59;
        self.minute--;
    }
    
    if (self.second <=0 && self.minute==0) {
        [self.timer invalidate];
        self.timer = nil;
        
        if(_SharePopview)
        {
            [self remindViewHiden];
        }
        
        [[NSUserDefaults standardUserDefaults]setBool:NO forKey:@"is_read"];
    }
    

    _minutelab.text = [NSString stringWithFormat:@"%02d",(int)self.minute];
    _secondlab.text = [NSString stringWithFormat:@"%02d",(int)self.second];
}
#pragma mark ********************tableview***************

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat Heigh = [self getRowHeigh:self.dataArray[indexPath.row] fontSize:ZOOM6(26)];
    return Heigh+8;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if(!cell)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
        cell.backgroundColor=[UIColor clearColor];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    NSMutableString *str = self.dataArray[indexPath.row];
   
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@",str];
    cell.detailTextLabel.numberOfLines = 0;
    cell.detailTextLabel.font = [UIFont systemFontOfSize:ZOOM6(24)];
    cell.detailTextLabel.textColor = RGBCOLOR_I(125, 125, 125);
    
    //lable的行间距
    NSMutableAttributedString * attributedString1 = [[NSMutableAttributedString alloc] initWithString:cell.detailTextLabel.text];
    NSMutableParagraphStyle * paragraphStyle1 = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle1 setLineSpacing:4];
    
    [attributedString1 addAttribute:NSParagraphStyleAttributeName value:paragraphStyle1 range:NSMakeRange(0, [cell.detailTextLabel.text length])];
    
    [cell.detailTextLabel setAttributedText:attributedString1];
    [cell.detailTextLabel sizeToFit];
    
    return cell;
}

- (UIView*)tableHeadview
{
    NSString *title1 = @"";
    NSString *title2 = @"";
    NSArray *titlearr = [self.Tasktitle componentsSeparatedByString:@"\n"];
    if(titlearr.count == 2)
    {
        title1 = titlearr[0];
        title2 = titlearr[1];
    }
    UIView *headview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(_headlabel.frame), ZOOM6(150))];
    
    UILabel *dislabel0 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.mytableview.frame), ZOOM6(50))];
    dislabel0.textColor = RGBCOLOR_I(62, 62, 62);
    dislabel0.font = [UIFont systemFontOfSize:ZOOM6(30)];
    dislabel0.textAlignment = NSTextAlignmentCenter;
    dislabel0.numberOfLines = 0;
    dislabel0.text = [NSString stringWithFormat:@"%@",title1];

    UILabel *dislabel1 = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(dislabel0.frame), CGRectGetWidth(self.mytableview.frame), ZOOM6(50))];
    dislabel1.textColor = RGBCOLOR_I(62, 62, 62);
    dislabel1.font = [UIFont systemFontOfSize:ZOOM6(30)];
    dislabel1.textAlignment = NSTextAlignmentCenter;
    dislabel1.numberOfLines = 0;
    dislabel1.text = [NSString stringWithFormat:@"%@",title2];
    
    NSString *discription = @"小TIPS";
    UILabel *dislabel2 = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(dislabel1.frame)+ZOOM6(10), CGRectGetWidth(self.mytableview.frame), ZOOM6(50))];
    dislabel2.textColor = RGBCOLOR_I(125, 125, 125);
    dislabel2.textAlignment = NSTextAlignmentCenter;
    dislabel2.font = [UIFont systemFontOfSize:ZOOM6(30)];
    dislabel2.text = [NSString stringWithFormat:@"%@",discription];

    [headview addSubview:dislabel0];
    [headview addSubview:dislabel1];
    [headview addSubview:dislabel2];
    return headview;
}
- (UITableView*)mytableview
{
    if(_mytableview == nil)
    {
        _mytableview = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_headlabel.frame)+ZOOM6(40), CGRectGetWidth(_headlabel.frame), ZOOM6(230)) style:UITableViewStylePlain];
        _mytableview.delegate = self;
        _mytableview.dataSource = self;
        _mytableview.separatorStyle = UITableViewCellSeparatorStyleNone;
        _mytableview.showsVerticalScrollIndicator = YES;

        _mytableview.tableHeaderView = [self tableHeadview];
    }
    return _mytableview;
}
- (NSMutableArray*)dataArray
{
    if(_dataArray == nil)
    {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
- (void)dealloc
{
     [[NSUserDefaults standardUserDefaults]setBool:NO forKey:@"is_newTask"];
}
@end
