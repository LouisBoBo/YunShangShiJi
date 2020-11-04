//
//  BrowseRemindView.m
//  YunShangShiJi
//
//  Created by ios-1 on 16/8/16.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import "BrowseRemindView.h"
#import "GlobalTool.h"
#import "SignModel.h"
#import "TFIndianaRecordViewController.h"
@implementation BrowseRemindView

- (instancetype)initWithFrame:(CGRect)frame andrewordType:(NSString*)rewordType MotaskList:(NSArray*)motaskList FinishList:(NSArray*)finishlist DataArray:(NSArray*)mydataArray SelectTag:(int)selectSigntag;
{
    if(self = [super initWithFrame:frame])
    {
        _rewordType = rewordType;
        _finishList = finishlist;
        _motaskList = motaskList;
        _MyDataArray = mydataArray;
        _selectSigntag = selectSigntag;
        
        if(rewordType.intValue == 3)//优惠卷
        {
            [self creatFinishPopview:DAILY_TASK_YOUHUI];
        }else if (rewordType.intValue == 4)//积分
        {
            [self creatFinishPopview:DAILY_TASK_JIFEN];
        
        }else if (rewordType.intValue == 5 || rewordType.intValue == 20)//现金
        {
            [self creatFinishPopview:DAILY_TASK_XIANJING];
        }
        
    }
    return self;
}

#pragma mark **************完成任务后新的弹框*****************
- (void)creatFinishPopview:(NSString*)type
{
    _SharePopview = [[UIView alloc]initWithFrame:CGRectMake(0, 0,kScreenWidth, kScreenHeight)];
    
    _SharePopview.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
    _SharePopview.userInteractionEnabled = YES;
    
    CGFloat invitcodeYY = (kScreenHeight - ZOOM6(740))/2;
    CGFloat ShareInvitationCodeViewHeigh = ZOOM6(740);
    
    if([type isEqualToString:DAILY_TASK_DUOBAO])
    {
        invitcodeYY = (kScreenHeight - ZOOM6(780))/2;
        ShareInvitationCodeViewHeigh = ZOOM6(780);
    }
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(disapper)];
    [_SharePopview addGestureRecognizer:tap];
    
    //弹框内容
    _ShareInvitationCodeView = [[UIView alloc]initWithFrame:CGRectMake(ZOOM(120), invitcodeYY, kScreenWidth-ZOOM(120)*2, ShareInvitationCodeViewHeigh)];
    [_SharePopview addSubview:_ShareInvitationCodeView];
    
    CGFloat imgHeigh = IMGSIZEH(@"-congratulation");
    
    _SharebackView = [[UIView alloc]initWithFrame:CGRectMake(0,imgHeigh/2, kScreenWidth-ZOOM(120)*2, CGRectGetHeight(_ShareInvitationCodeView.frame)-imgHeigh/2)];
    
    _SharebackView.backgroundColor=[UIColor whiteColor];
    _SharebackView.layer.cornerRadius=5;
    _SharebackView.clipsToBounds = YES;
    [_ShareInvitationCodeView addSubview:_SharebackView];
    
    _SharetitleImg = [[UIImageView alloc]initWithFrame:CGRectMake((CGRectGetWidth(_ShareInvitationCodeView.frame)-imgHeigh*3)/2, 0, imgHeigh*3, imgHeigh)];
    
    _SharetitleImg.image = [UIImage imageNamed:@"-congratulation"];
    [_ShareInvitationCodeView addSubview:_SharetitleImg];
    
    
    //弹框内容
    [self finishContent:type];
    
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

- (void)finishContent:(NSString*)type
{
    
    CGFloat headimageY = ZOOM6(60);
    
    UILabel *titlelab = [[UILabel alloc]initWithFrame:CGRectMake(20, headimageY, CGRectGetWidth(_SharebackView.frame)-40, ZOOM6(40))];
    titlelab.textColor = tarbarrossred;
    titlelab.textAlignment = NSTextAlignmentCenter;
    titlelab.font = [UIFont systemFontOfSize:ZOOM(51)];
    [_SharebackView addSubview:titlelab];
    
    CGFloat spaceheigh = ZOOM6(60);
    CGFloat imageviewYY = CGRectGetMaxY(titlelab.frame);
    
    
    //国片 描述文字 按钮
    
    CGFloat gobtnWidth = (CGRectGetWidth(_SharebackView.frame)-2*30-20)/2;
    CGFloat gobtnHeigh = ZOOM6(80);
    
    CGFloat imageHeigh = ZOOM6(200);
    
    for(int k =0;k<2;k++)
    {
        UIImageView *imageview = [[UIImageView alloc]initWithFrame:CGRectMake(30+(gobtnWidth+20)*k, imageviewYY+spaceheigh, imageHeigh, imageHeigh)];
        imageview.tag = 6666+k;
        [_SharebackView addSubview:imageview];
        
        UILabel *contentlab = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(imageview.frame), CGRectGetMaxY(imageview.frame)+ZOOM6(14), imageHeigh, ZOOM6(28))];
        contentlab.textColor = RGBCOLOR_I(125, 125, 125);
        contentlab.text = @" ";
        contentlab.tag = 5555+k;
        contentlab.font = [UIFont systemFontOfSize:ZOOM6(28)];
        contentlab.textAlignment = NSTextAlignmentCenter;
        [_SharebackView addSubview:contentlab];
        
        
        UILabel *dislable = [[UILabel alloc]initWithFrame:CGRectMake(30+(gobtnWidth+20)*k, CGRectGetMaxY(contentlab.frame)+ZOOM6(28), gobtnWidth, ZOOM6(30))];
        
        dislable.text = @"已参与";
        dislable.tag = 7777+k;
        dislable.textColor = RGBCOLOR_I(255, 63, 139);
        dislable.textAlignment = NSTextAlignmentCenter;
        dislable.font = [UIFont systemFontOfSize:ZOOM6(30)];
        [_SharebackView addSubview:dislable];
        
        
        if(k==0)
        {
            dislable.frame = CGRectMake(40, CGRectGetMaxY(contentlab.frame)+ZOOM6(28), gobtnWidth, ZOOM6(30));
            
            UIImageView *checkimg = [[UIImageView alloc]init];
            checkimg.frame = CGRectMake(ZOOM6(15), -ZOOM6(5), ZOOM6(40), ZOOM6(40));
            checkimg.image = [UIImage imageNamed:@"qiandao_icon_celect"];
            [dislable addSubview:checkimg];
        }
        
        
        UIButton *gobtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        gobtn.frame = CGRectMake(30+(gobtnWidth+20)*k, CGRectGetMaxY(dislable.frame)+ZOOM6(60), gobtnWidth, gobtnHeigh);
        gobtn.backgroundColor = tarbarrossred;
        gobtn.clipsToBounds = YES;
        gobtn.tag = 8888+k;
        gobtn.layer.cornerRadius = 5;
        gobtn.userInteractionEnabled = YES;
        [gobtn setTintColor:[UIColor whiteColor]];
        
        gobtn.titleLabel.font = [UIFont systemFontOfSize:ZOOM(51)];
        [gobtn addTarget:self action:@selector(goClick:) forControlEvents:UIControlEventTouchUpInside];
        [_SharebackView addSubview:gobtn];
        
        [self buttontitle:type Titlelable:titlelab Image:imageview Lable:contentlab StatueLab:dislable Button:gobtn];
    }
    
    
}

- (void)buttontitle:(NSString*)type Titlelable:(UILabel*)titlelable Image:(UIImageView*)typeimage Lable:(UILabel*)typelable StatueLab:(UILabel*)Statuelable Button:(UIButton*)typebtn
{
    
    //当月任务数由当月天数决定
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSRange range = [calendar rangeOfUnit:NSDayCalendarUnit inUnit:NSMonthCalendarUnit forDate:[NSDate date]];
    
    NSUInteger numberOfDaysInMonth = range.length;
    
    
    int finishCount = (int)self.finishList.count;
    if(_selectSigntag + 1 == self.finishList.count )
    {
        finishCount = _selectSigntag;
    }
    
    NSString *name2 ;
    if(finishCount == numberOfDaysInMonth)
    {
        
    }else{
        
        if(_MyDataArray.count && _motaskList.count)
        {
            
            NSString *strid ;
            
            if(finishCount +2 <= _motaskList.count)
            {
                strid = _motaskList[finishCount+1];
            }
            
            for(int i=0;i<_MyDataArray.count;i++)
            {

                NSDictionary *dic = _MyDataArray[i];
                NSString *ID = [NSString stringWithFormat:@"%@",dic[@"t_id"]];
                
                if([ID isEqualToString:strid])
                {
                    name2 = [NSString stringWithFormat:@"%@",dic[@"t_name"]];
                    break;
                }
            }
        }
        
    }
    
    
    //任务类型
    if(typelable.tag == 5555)
    {
        
        NSString *valuestr = [self signtypestatue:finishCount];
        
        if ([type isEqualToString:DAILY_TASK_JIFEN])//积分
        {
            typelable.text = [NSString stringWithFormat:@"%@积分",valuestr];
            
        }else if ([type isEqualToString:DAILY_TASK_YOUHUI])//优惠卷
        {
            typelable.text = [NSString stringWithFormat:@"%@元优惠券",valuestr];
        }else if ([type isEqualToString:DAILY_TASK_XIANJING])//现金
        {
            typelable.text = [NSString stringWithFormat:@"%@元现金",valuestr];
        }
        
    }else{
        typelable.text = name2;
        
        
        if([name2 isEqualToString:@"2元包邮"] || [name2 isEqualToString:@"3元包邮"])
        {
            typelable.text = @"赢取iPhone6";
            
        }else if ([name2 isEqualToString:@"5元包邮"])
        {
            typelable.text = @"赢取vivo+oppo";
            typelable.font = [UIFont systemFontOfSize:ZOOM6(24)];
        }
        
        NSString *valuestr ;
        if(finishCount +1 <= numberOfDaysInMonth){
            
            valuestr = [self signtypestatue:finishCount+1];
        }
        
        if(finishCount +1 >= numberOfDaysInMonth)
        {
            typelable.text = @"?";
        }
    }
    
    //任务图片
    if(typeimage.tag == 6666)
    {
        typeimage.image = [self getTypeImage:type Tag:finishCount];
    }else{
        
        if(numberOfDaysInMonth == finishCount +1 )
        {
            typeimage.image = [UIImage imageNamed:@"jingxi"];
            
        }else{
            
            
            NSString *tomorrrowstatue = [self signImagestatue:finishCount+1];
            NSString* type2 = [self getType:tomorrrowstatue];
            
            typeimage.image = [self getTypeImage:type2 Tag:finishCount+1];
        }
        
    }
    
    
    typebtn.hidden = NO;
    
    if ([type isEqualToString:DAILY_TASK_STORE])//0元购
    {
        titlelable.text = @"开店成功啦~";
        
        if(Statuelable.tag == 7777)
        {
            Statuelable.text = @"已开店";
        }else{
            Statuelable.text = @"明日可领取";
            
            if(finishCount == numberOfDaysInMonth)
            {
                Statuelable.text = @"明日更多惊喜";
            }
            
        }
        
        if(typebtn.tag == 8889)
        {
            [typebtn setTitle:@"去小店" forState:UIControlStateNormal];
        }else{
            [typebtn setTitle:@"查余额" forState:UIControlStateNormal];
            typebtn.backgroundColor = [UIColor clearColor];
            typebtn.tintColor = tarbarrossred;
            typebtn.layer.borderColor = tarbarrossred.CGColor;
            typebtn.layer.borderWidth=1;
        }
        
    }else if ([type isEqualToString:DAILY_TASK_XIANJING])//现金
    {
        titlelable.text = @"签到成功啦~";
        
        if(Statuelable.tag == 7777)
        {
            Statuelable.text = @"已领取";
        }else{
            Statuelable.text = @"明日可领取";
            
            if(finishCount == numberOfDaysInMonth)
            {
                Statuelable.text = @"明日更多惊喜";
            }
            
        }
        
        if(typebtn.tag == 8888)
        {
            [typebtn setTitle:@"知道了" forState:UIControlStateNormal];
            typebtn.tintColor = [UIColor whiteColor];

        }else{
            [typebtn setTitle:@"查看余额" forState:UIControlStateNormal];
            typebtn.backgroundColor = [UIColor clearColor];
            
            [typebtn setTitleColor:tarbarrossred forState:UIControlStateNormal];
            typebtn.layer.borderColor = tarbarrossred.CGColor;
            typebtn.layer.borderWidth=1;
            typebtn.userInteractionEnabled = YES;

        }
        
        
    }else if ([type isEqualToString:DAILY_TASK_YOUHUI])//优惠
    {
        titlelable.text = @"签到成功啦~";
        
        if(Statuelable.tag == 7777)
        {
            Statuelable.text = @"已领取";
        }else{
            Statuelable.text = @"明日可领取";
            if(finishCount == numberOfDaysInMonth)
            {
                Statuelable.text = @"明日更多惊喜";
            }
            
        }
        
        if(typebtn.tag == 8888)
        {
            [typebtn setTitle:@"知道了" forState:UIControlStateNormal];
            
        }else{
            [typebtn setTitle:@"查看卡券" forState:UIControlStateNormal];
            typebtn.backgroundColor = [UIColor clearColor];
            typebtn.tintColor = tarbarrossred;
            typebtn.layer.borderColor = tarbarrossred.CGColor;
            typebtn.layer.borderWidth=1;
            typebtn.userInteractionEnabled = YES;

        }
        
        
    }else if ([type isEqualToString:DAILY_TASK_JIFEN])//积分
    {
        titlelable.text = @"签到成功啦~";
        
        if(Statuelable.tag == 7777)
        {
            Statuelable.text = @"已领取";
        }else{
            Statuelable.text = @"明日可领取";
            if(finishCount == numberOfDaysInMonth)
            {
                Statuelable.text = @"明日更多惊喜";
            }
            
        }
        
        if(typebtn.tag == 8888)
        {
            [typebtn setTitle:@"知道了" forState:UIControlStateNormal];
        
        }else{
            [typebtn setTitle:@"查看积分" forState:UIControlStateNormal];
            typebtn.backgroundColor = [UIColor clearColor];
            typebtn.tintColor = tarbarrossred;
            typebtn.layer.borderColor = tarbarrossred.CGColor;
            typebtn.layer.borderWidth=1;
            typebtn.userInteractionEnabled = YES;
        }
        
    }
    else if ([type isEqualToString:DAILY_TASK_BAOYOU] || [type isEqualToString:DAILY_TASK_DUOBAO_BAOYOU])//包邮
    {
        titlelable.text = @"签到成功啦~";
        
        if(Statuelable.tag == 7777)
        {
            Statuelable.text = @"已参与";
        }else{
            Statuelable.text = @"明日可领取";
            if(finishCount == numberOfDaysInMonth)
            {
                Statuelable.text = @"明日更多惊喜";
            }
            
        }
        
        if(typebtn.tag == 8888)
        {
            [typebtn setTitle:@"知道了一定来~" forState:UIControlStateNormal];
            
            typebtn.frame = CGRectMake(30, CGRectGetMaxY(Statuelable.frame)+ZOOM6(60), CGRectGetWidth(_SharebackView.frame)-2*30, ZOOM(36*3.4));
            
        }else{
            [typebtn setTitle:@"知道了" forState:UIControlStateNormal];
            
            typebtn.hidden = YES;
        }
        
    }
    else if ([type isEqualToString:DAILY_TASK_DUOBAO])//夺宝
    {
        titlelable.text = @"签到成功啦~";
        
        if(Statuelable.tag == 7777)
        {
            Statuelable.text = @"已参与";
        }else{
            Statuelable.text = @"明日可领取";
            if(finishCount == numberOfDaysInMonth)
            {
                Statuelable.text = @"明日更多惊喜";
            }
            
        }
        
        if(typebtn.tag == 8888)
        {
            [typebtn setTitle:@"知道了一定来~" forState:UIControlStateNormal];
            
            typebtn.frame = CGRectMake(30, CGRectGetMaxY(Statuelable.frame)+ZOOM6(60), CGRectGetWidth(_SharebackView.frame)-2*30, ZOOM(36*3.4));
            
        }else{
            [typebtn setTitle:@"知道了" forState:UIControlStateNormal];
            typebtn.backgroundColor = [UIColor yellowColor];
            typebtn.hidden = YES;
        }
        
    }
    else if ([type isEqualToString:DAILY_TASK_DOUBLE])
    {
        
        titlelable.text = @"签到成功啦~";
        
        if(Statuelable.tag == 7777)
        {
            Statuelable.text = @"已开启";
        }else{
            Statuelable.text = @"明日可领取";
            
            if(finishCount == numberOfDaysInMonth)
            {
                Statuelable.text = @"明日更多惊喜";
            }
            
        }
        
        if(typebtn.tag == 8888)
        {
            [typebtn setTitle:@"知道了" forState:UIControlStateNormal];
           
            
        }else{
            [typebtn setTitle:@"查看余额" forState:UIControlStateNormal];
            typebtn.backgroundColor = [UIColor clearColor];
            typebtn.tintColor = tarbarrossred;
            typebtn.layer.borderColor = tarbarrossred.CGColor;
            typebtn.layer.borderWidth=1;
            typebtn.userInteractionEnabled = YES;
        }
        
    }
    
}
#pragma mark //获取任务图片
- (UIImage*)getTypeImage:(NSString*)type Tag:(int)tag
{
    
    NSString *valuestr = [self signtypestatue:tag];
    
    UIImage *image = [[UIImage alloc]init];
    
    if([type isEqualToString:DAILY_TASK_DOUBLE])
    {
        image = [UIImage imageNamed:@"yuefanbei"];
        
    }else if ([type isEqualToString:DAILY_TASK_XIANJING])
    {
        image = [UIImage imageNamed:[NSString stringWithFormat:@"qiandao_%@yuan",valuestr]];
        
    }else if ([type isEqualToString:DAILY_TASK_JIFEN])
    {
        image = [UIImage imageNamed:@"qiandao_jifen"];
        
    }else if ([type isEqualToString:DAILY_TASK_YOUHUI])
    {
        
        image = [UIImage imageNamed:[NSString stringWithFormat:@"qiandao_%@yuan-youhuiquan",valuestr]];
        
    }else if([type isEqualToString:DAILY_TASK_DUOBAO]){
        
        if(valuestr.intValue ==3)
        {
            image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",@"qiandao_3yuan iPhone6"]];
        }else if (valuestr.intValue ==5)
        {
            image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",@"5yuanoppo_pop"]];
        }
        else{
            image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",@"qiandao_3yuan iPhone6"]];
        }
    }else if ([type isEqualToString:DAILY_TASK_BAOYOU])
    {
        
        if(valuestr.intValue == 3)
        {
            image = [UIImage imageNamed:@"qiandao_3yuanbaoyou"];
            
        }else if (valuestr.intValue == 5)
        {
            image = [UIImage imageNamed:@"qiandao_5yuanbaoyou"];
        }
    }else if ([type isEqualToString:DAILY_TASK_DUOBAO_BAOYOU])
    {
        //夺宝包邮的图标
        image = [UIImage imageNamed:@"duobao-baoyou"];
    }else if ([type isEqualToString:DAILY_TASK_STORE])
    {
        image = [UIImage imageNamed:[NSString stringWithFormat:@"qiandao_%@yuan",valuestr]];
    }
    
    return image;
}

#pragma mark 签到类型
- (NSString*)signtypestatue:(int)intcount
{
    NSString *statuestr;
    
    //今天的任务id
    NSString *today_tid;
    if(_motaskList.count)
    {
        today_tid = [NSString stringWithFormat:@"%@",_motaskList[intcount]];
    }
    
    MyLog(@"today_tid=%@",today_tid);
    
    for(int i =0;i<_MyDataArray.count;i++)
    {
        NSDictionary *dic = _MyDataArray[i];
        NSString *ID = [NSString stringWithFormat:@"%@",dic[@"t_id"]];
        if([today_tid isEqualToString:[NSString stringWithFormat:@"%@",ID]])
        {
            //任务类型
            NSString *typeid = [NSString stringWithFormat:@"%@",dic[@"type_id"]];
            NSString *value = [NSString stringWithFormat:@"%@",dic[@"value"]];
            MyLog(@"typeid=%@",value);
            
            if(typeid.intValue ==1)//补签
            {
                statuestr = value;
            }else if (typeid.intValue ==2){//0元购
                statuestr = value;
            }else if (typeid.intValue ==3){//优惠券
                statuestr = value;
            }else if (typeid.intValue ==4){//积分
                statuestr = value;
            }else if (typeid.intValue ==5){//现金
                statuestr = value;
            }else if (typeid.intValue ==6){//开店
                statuestr = value;
            }else if (typeid.intValue ==7){//签到包邮
                statuestr = value;
            }else if (typeid.intValue ==8){//余额翻倍
                statuestr = value;
            }
        }
    }
    
    return  statuestr ;
}

#pragma mark 今天的任务奖励类型
- (NSString*)signImagestatue:(int)intcount
{
    NSString *statuestr;
    
    //今天的任务id
    NSString *today_tid;
    
    if(_motaskList.count)
    {
        today_tid = [NSString stringWithFormat:@"%@",_motaskList[intcount]];
    }
    
    MyLog(@"today_tid=%@",today_tid);
    
    for(int i =0;i<_MyDataArray.count;i++)
    {
        NSDictionary *dic = _MyDataArray[i];
        
        NSString *ID = [NSString stringWithFormat:@"%@",dic[@"t_id"]];
        if([today_tid isEqualToString:[NSString stringWithFormat:@"%@",ID]])
        {
            //任务类型
            NSString *typeid = [NSString stringWithFormat:@"%@",dic[@"type_id"]];
            MyLog(@"typeid=%@",typeid);
            
            if(typeid.intValue ==1)//补签
            {
                statuestr = @"1";
            }else if (typeid.intValue ==2){//0元购
                statuestr = @"2";
            }else if (typeid.intValue ==3){//优惠券
                statuestr = @"3";
            }else if (typeid.intValue ==4){//积分
                statuestr = @"4";
            }else if (typeid.intValue ==5){//现金
                statuestr = @"5";
            }else if (typeid.intValue ==6){//开店
                statuestr = @"6";
            }else if (typeid.intValue ==7){//签到包邮
                statuestr = @"7";
            }else if (typeid.intValue ==8){//余额翻倍
                statuestr = @"8";
            }
        }
    }
    
    return  statuestr ;
}

- (NSString*)getType:(NSString*)type
{
    NSString *typestr;
    
    switch (type.intValue) {
        case 3:
            
            typestr = DAILY_TASK_YOUHUI;
            break;
        case 4:
            
            typestr = DAILY_TASK_JIFEN;
            break;
            
        case 5:
            
            typestr = DAILY_TASK_XIANJING;
            break;
        case 6:
            
            typestr = DAILY_TASK_STORE;
            break;
            
        case 7:
            
            typestr = DAILY_TASK_DUOBAO;
            break;
            
        case 8:
            
            typestr = DAILY_TASK_DOUBLE;
            break;
            
        case 20:
            
            typestr = DAILY_TASK_XIANJING;
            
            break;
            
        default:
            break;
    }
    
    return typestr;
}

#pragma mark ******** 弹框点击事件 **********
- (void)goClick:(UIButton*)sender
{

    if(sender.tag == 8889)
    {
        NSString *title = sender.titleLabel.text;

        
        if(self.rightHideMindBlock)
        {
            self.rightHideMindBlock(title);
        }

        
    }else if (sender.tag == 8888)
    {
        
        NSString *title = sender.titleLabel.text;
        
        if(self.leftHideMindBlock)
        {
            self.leftHideMindBlock(title);
        }

        
    }

}

- (void)disapper
{
    if(self.tapHideMindBlock)
    {
        self.tapHideMindBlock();
    }
}

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
@end
