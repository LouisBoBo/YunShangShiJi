//
//  CancleViewController.m
//  YunShangShiJi
//
//  Created by ios-1 on 15/7/30.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//

#import "CancleViewController.h"
#import "GlobalTool.h"
#import "MyMD5.h"
#import "ServiceViewController.h"
//#import "ChatViewController.h"
#import "RobotManager.h"
#import "MoneyGoViewController.h"
#import "AftersaleViewController.h"
#import "TFAccountDetailsViewController.h"
//#import "ChatListViewController.h"
#import "ContactKefuViewController.h"
@interface CancleViewController ()

@end

@implementation CancleViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    //导航条
    UIImageView *headview=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kApplicationWidth, Height_NavBar)];
    //
    [self.view addSubview:headview];
    headview.userInteractionEnabled=YES;
    
    UIButton *backbtn=[UIButton buttonWithType:UIButtonTypeCustom];
    backbtn.frame=CGRectMake(0, 20, 46, 46);
    backbtn.centerY = View_CenterY(headview);
    [backbtn setImage:[UIImage imageNamed:@"返回按钮_正常"] forState:UIControlStateNormal];
    [backbtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [headview addSubview:backbtn];
    
    UILabel *titlelable=[[UILabel alloc]init];
    titlelable.frame=CGRectMake(0, 0, 300, 40);
    titlelable.center=CGPointMake(kApplicationWidth/2, headview.frame.size.height/2+10);
    
    
    titlelable.text=self.titlestring;
    titlelable.font=kNavTitleFontSize;
    titlelable.textColor=kMainTitleColor;
    titlelable.textAlignment=NSTextAlignmentCenter;
    [headview addSubview:titlelable];
    
//    UIButton *searchbtn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
//    searchbtn.frame=CGRectMake(kApplicationWidth - 40, 30, 25, 25);
//    searchbtn.tintColor=[UIColor blackColor];
//    [searchbtn setImage:[UIImage imageNamed:@"设置"]  forState:UIControlStateNormal];
//    searchbtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
//    [searchbtn addTarget:self action:@selector(tomessage:) forControlEvents:UIControlEventTouchUpInside];
//    [headview addSubview:searchbtn];
//    
//    NSInteger unReadMessageCount=[[EaseMob sharedInstance].chatManager loadTotalUnreadMessagesCountFromDatabase];
//    UILabel *messagecount=[[UILabel alloc]initWithFrame:CGRectMake(20, -10, 20, 20)];
//    messagecount.text=[NSString stringWithFormat:@"%ld",(long)unReadMessageCount];
//    messagecount.font=[UIFont systemFontOfSize:15];
//    messagecount.textColor=[UIColor whiteColor];
//    messagecount.backgroundColor=tarbarYellowcolor;
//    messagecount.clipsToBounds=YES;
//    messagecount.layer.cornerRadius=10;
//    messagecount.textAlignment=NSTextAlignmentCenter;
//    if(unReadMessageCount !=0)
//    {
//        [searchbtn addSubview:messagecount];
//    }
//    [self creatview];
    [self changeInformation:_orderModel];
}
-(void)tomessage:(UIButton*)sender
{
    // begin 赵官林 2016.5.26 跳转到消息列表
    [self presentChatList];
    // end
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    Myview.hidden=YES;
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    Myview.hidden=NO;
}
-(void)changeInformation:(OrderModel *)model
{
    NSString *statue=model.status;
    
    if(statue.intValue==5)//买家撤消
    {
        NSString *str;
        NSString *titletext;
        
        if([self.titlestring isEqualToString:@"退款详情"])
        {
            str=@"退款";
            titletext=@"撤消退款";
            
        }else if ([self.titlestring isEqualToString:@"退货详情"])
        {
            str=@"退货";
            titletext=@"撤消退货";
        }else if ([self.titlestring isEqualToString:@"换货详情"])
        {
            str=@"换货";
            titletext=@"撤消换货";
        }
        
        //订单头
        self.ordertitle.text=titletext;
        
        //退款金额
        self.orderprice.text=[NSString stringWithFormat:@"%@金额:¥%.2f元",str,[[NSString stringWithFormat:@"%@",model.money]floatValue]];
        
        
        //订单编号
        self.ordercode.text=[NSString stringWithFormat:@"订单编号:%@",model.order_code];
        
        
        //订单状态
        self.orderstatue.text=[NSString stringWithFormat:@"买家已%@",titletext];
        
        
        //申请时间
        NSString *timestr=[MyMD5 getTimeToShowWithTimestamp:model.add_time];
        self.applytime.text=[NSString stringWithFormat:@"申请%@时间:%@",str,timestr];
        
        //撤消时间
        NSString *cancletime=[MyMD5 getTimeToShowWithTimestamp:model.end_time];
        self.cancletime.text=[NSString stringWithFormat:@"撤消%@时间:%@",str,cancletime];
        self.cancletime.textColor=kTextGreyColor;
        
    }
    else if(statue.intValue==3){//审核未通过
        
        NSString *str;
        NSString *titletext;
        
        if([self.titlestring isEqualToString:@"退款详情"])
        {
            str=@"退款";
            titletext=@"商家未同意退款";
            
        }else if ([self.titlestring isEqualToString:@"退货详情"])
        {
            str=@"退货";
            titletext=@"商家未同意退货";
        }else if ([self.titlestring isEqualToString:@"换货详情"])
        {
            str=@"换货";
            titletext=@"商家未同意换货";
        }
        
        //订单头
        self.ordertitle.text=titletext;
        
        //退款金额
        self.orderprice.text=[NSString stringWithFormat:@"订单金额(包邮):¥%.2f元",[[NSString stringWithFormat:@"%@",model.money]floatValue]];
        
        
        //订单编号
        self.ordercode.text=[NSString stringWithFormat:@"订单号:%@",model.order_code];
        
        //申请时间
        NSString *timestr=[MyMD5 getTimeToShowWithTimestamp:model.add_time];
        self.applytime.text=[NSString stringWithFormat:@"申请%@时间:%@",str,timestr];
        
        //订单状态
        self.orderstatue.text=[NSString stringWithFormat:@"你申请了%@",str];
        self.orderstatue.textColor=kTextGreyColor;
        self.orderstatue.font=[UIFont systemFontOfSize:ZOOM(40)];
        
        //未同意的原因
        
        self.cancletime.text=[NSString stringWithFormat:@"%@原因:%@",str,model.cause];
        self.cancletime.textColor=kTextGreyColor;
        self.cancletime.font=[UIFont systemFontOfSize:ZOOM(40)];
        
        
        //未同意的时间
        if (model.ck_time!=nil && ![[NSString stringWithFormat:@"%@",model.ck_time]isEqualToString:@"<null>"]) {
            self.timelable.text=[MyMD5 getTimeToShowWithTimestamp:model.ck_time];
        }
        self.timelable.textColor=kTextGreyColor;
        self.timelable.font=[UIFont systemFontOfSize:ZOOM(40)];
        
        NSArray *titleArry=@[@"卖家未同意",@"你可以选择以下方式处理"];
        for(int i=0;i<2;i++)
        {
            UILabel *lable=[[UILabel alloc]initWithFrame:CGRectMake(ZOOM(62), 250+40*i, kApplicationWidth-20, 30)];
            lable.text=titleArry[i];
            [self.view addSubview:lable];
            
            if(i==1)
            {
                lable.textColor=kTextGreyColor;
                lable.font=[UIFont systemFontOfSize:14];
            }
        }
        
        CGFloat btnwidth=kApplicationWidth/2-20;
        NSArray *btnarr=@[@"联系卖家",@"售后帮助"];
        
        for(int i=0;i<2;i++)
        {
            UIButton *helpbtn=[[UIButton alloc]initWithFrame:CGRectMake(10+(btnwidth+20)*i,350, btnwidth, 30)];
            [helpbtn setTitle:btnarr[i] forState:UIControlStateNormal];
            [helpbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            helpbtn.tag=6000+i;
            helpbtn.layer.cornerRadius = 5;
            helpbtn.backgroundColor=[UIColor blackColor];
            [self.view addSubview:helpbtn];
            
            [helpbtn addTarget:self action:@selector(help:) forControlEvents:UIControlEventTouchUpInside];
        }
    }
    else if (statue.intValue==4||statue.intValue==8) //后期状态要改成8  //换货成功
    {
        
        NSString *str;
        NSString *titletext;
        
        if([self.titlestring isEqualToString:@"退款详情"])
        {
            str=@"退款";
            titletext=@"商家未同意退款";
            
        }else if ([self.titlestring isEqualToString:@"退货详情"])
        {
            str=@"退货";
            titletext=@"商家未同意退货";
        }else if ([self.titlestring isEqualToString:@"换货详情"])
        {
            str=@"换货";
            titletext=@"换货成功";
        }
        
        //订单头
        self.ordertitle.text=titletext;
        
        //退款金额
        self.orderprice.text=[NSString stringWithFormat:@"订单金额(包邮):¥%.2f元",[model.money floatValue]];
        
        
        //订单编号
        self.ordercode.text=[NSString stringWithFormat:@"订单号:%@",model.order_code];
        
        //申请时间
        NSString *timestr=[MyMD5 getTimeToShowWithTimestamp:model.add_time];
        self.applytime.text=[NSString stringWithFormat:@"申请时间:%@",timestr];
        
        //订单状态
        self.orderstatue.text=[NSString stringWithFormat:@"买家已确认收货"];
        
        //未同意的原因
        
        self.cancletime.text=[NSString stringWithFormat:@"买家已收到换货物品,换货成功"];
        self.cancletime.font=[UIFont systemFontOfSize:ZOOM(50)];
        //        self.cancletime.textColor=kTextGreyColor;
        self.cancletime.font=[UIFont systemFontOfSize:ZOOM(40)];
        
        
        //买家收货时间
        self.timelable.text=[MyMD5 getTimeToShowWithTimestamp:model.end_time];
        self.timelable.textColor=kTextGreyColor;
        self.timelable.font=[UIFont systemFontOfSize:ZOOM(40)];
        
        
        NSString *cause=[NSString stringWithFormat:@"%@",model.cause];
        NSArray *titleArry=@[[NSString stringWithFormat:@"%@状态",str],[NSString stringWithFormat:@"%@原因",str]];
        for(int i=0;i<2;i++)
        {
            UILabel *lable=[[UILabel alloc]initWithFrame:CGRectMake(ZOOM(62), 250+40*i, kApplicationWidth-20, 30)];
            lable.textColor=kTextGreyColor;
            lable.font=[UIFont systemFontOfSize:ZOOM(40)];
            [self.view addSubview:lable];
            
            NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@",titleArry[i]]];
            
            if (i==0) {
                noteStr=[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@  %@",titleArry[i],[NSString stringWithFormat:@"%@成功",str]]];
            }else{
            noteStr=[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@  %@",titleArry[i],cause]];
            }
            NSRange redRange = NSMakeRange(0, [[noteStr string] rangeOfString:@" "].location);
            [noteStr addAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor]} range:redRange];

            
            
            
            [lable setAttributedText:noteStr];
            
            
        }
        
        
    }
    else if (statue.intValue==6)//退款成功
    {
        
        NSString *str;
        NSString *titletext;
        
        if([self.titlestring isEqualToString:@"退款详情"])
        {
            str=@"退款";
            titletext=@"退款成功";
            
        }else if ([self.titlestring isEqualToString:@"退货详情"])
        {
            str=@"退货";
            titletext=@"退货成功";
        }else if ([self.titlestring isEqualToString:@"换货详情"])
        {
            str=@"换货";
            titletext=@"换货成功";
        }
        
        //订单头
        self.ordertitle.text=titletext;
        
        //退款金额
        self.orderprice.text=[NSString stringWithFormat:@"订单金额(包邮):¥%.2f元",[model.money floatValue]];
        
        
        //订单编号
        self.ordercode.text=[NSString stringWithFormat:@"订单号:%@",model.order_code];
        
        //申请时间
        NSString *timestr=[MyMD5 getTimeToShowWithTimestamp:model.add_time];
        self.applytime.text=[NSString stringWithFormat:@"申请时间:%@",timestr];
        
        //订单状态
        self.orderstatue.text=[NSString stringWithFormat:@"%@成功",str];
        
        //未同意的原因
        
        self.cancletime.text=[NSString stringWithFormat:@"商家同意%@,交易款项%.2f已退款至你帐户",str,[model.money floatValue]];
        
        self.cancletime.font=[UIFont systemFontOfSize:ZOOM(50)];
        //        self.cancletime.textColor=kTextGreyColor;
        self.cancletime.font=[UIFont systemFontOfSize:ZOOM(40)];
        
        
        //买家收货时间
        self.timelable.text=[MyMD5 getTimeToShowWithTimestamp:model.end_time];
        self.timelable.textColor=kTextGreyColor;
        self.timelable.font=[UIFont systemFontOfSize:ZOOM(40)];
        
        //退款记录
        UIButton *moneygobtn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
        moneygobtn.frame=CGRectMake(ZOOM(62), 260, kApplicationWidth-ZOOM(62)*2, 40);
        moneygobtn.layer.borderWidth=1;
//        moneygobtn.layer.cornerRadius=5;
        moneygobtn.layer.borderColor=kBackgroundColor.CGColor;
        [moneygobtn setTitle:@"查看退款记录" forState:UIControlStateNormal];
        [moneygobtn setTitleColor:kTextGreyColor forState:UIControlStateNormal];
        [moneygobtn addTarget:self action:@selector(moneygo:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:moneygobtn];
        
        
        
        //协商详情
        NSArray *titlearr=@[[NSString stringWithFormat:@"%@状态",str],[NSString stringWithFormat:@"%@金额",str],[NSString stringWithFormat:@"%@原因",str]];
        
        NSString *applytime=[MyMD5 getTimeToShowWithTimestamp:model.add_time];
        
        CGFloat space;
        if (ThreeAndFiveInch) {
            space=35;
        }else{
            space=40;
        }
        
        for(int i=0;i<titlearr.count;i++)
        {
            UILabel *titlelable=[[UILabel alloc]initWithFrame:CGRectMake(ZOOM(62), moneygobtn.frame.origin.y+moneygobtn.frame.size.height+15+space*i, 80, 30)];
            titlelable.text=titlearr[i];
            titlelable.font=[UIFont systemFontOfSize:ZOOM(40)];
            titlelable.textColor=kTextGreyColor;
            [self.view addSubview:titlelable];
            
            UILabel *contentlable=[[UILabel alloc]initWithFrame:CGRectMake(90+ZOOM(62), moneygobtn.frame.origin.y+moneygobtn.frame.size.height+15+space*i, kApplicationWidth-110, 30)];
            contentlable.font=[UIFont systemFontOfSize:ZOOM(40)];
            contentlable.textColor=kTextGreyColor;
            [self.view addSubview:contentlable];
            
            switch (i+1) {
                case 1:
                    contentlable.text=[NSString stringWithFormat:@"%@成功",str];
                    break;
                case 2:
                    contentlable.text=[NSString stringWithFormat:@"%.2f元",[model.money floatValue]];
                    break;
                case 3:
                    contentlable.text=[NSString stringWithFormat:@"%@",model.cause];
                    break;
                    
                default:
                    break;
            }
            
        }
        
        
    }
    else if (statue.intValue==7)//退款关闭
    {
        
        NSString *str;
        NSString *titletext;
        
        if([self.titlestring isEqualToString:@"退款详情"])
        {
            str=@"退款";
            titletext=@"退款关闭";
            
        }else if ([self.titlestring isEqualToString:@"退货详情"])
        {
            str=@"退货";
            titletext=@"退货成功";
        }else if ([self.titlestring isEqualToString:@"换货详情"])
        {
            str=@"换货";
            titletext=@"换货成功";
        }
        
        //订单头
        self.ordertitle.text=titletext;
        
        //退款金额
        self.orderprice.text=[NSString stringWithFormat:@"订单金额(包邮):¥%.2f元",[model.money floatValue]];
        
        
        //订单编号
        self.ordercode.text=[NSString stringWithFormat:@"订单号:%@",model.order_code];
        
        //申请时间
        NSString *timestr=[MyMD5 getTimeToShowWithTimestamp:model.add_time];
        self.applytime.text=[NSString stringWithFormat:@"申请时间:%@",timestr];
        
        //订单状态
        self.orderstatue.text=[NSString stringWithFormat:@"%@关闭",str];
        
        //未同意的原因
        
        self.cancletime.text=[NSString stringWithFormat:@"由于你确认%@此%@申请已关闭",str,str];
        
        self.cancletime.font=[UIFont systemFontOfSize:ZOOM(50)];
        //        self.cancletime.textColor=kTextGreyColor;
        self.cancletime.font=[UIFont systemFontOfSize:ZOOM(40)];
        
        
        //买家收货时间
        self.timelable.text=[MyMD5 getTimeToShowWithTimestamp:model.end_time];
        self.timelable.textColor=kTextGreyColor;
        self.timelable.font=[UIFont systemFontOfSize:ZOOM(40)];
        
        
        
        //协商详情
        NSArray *titlearr=@[[NSString stringWithFormat:@"%@状态",str],[NSString stringWithFormat:@"%@金额",str],[NSString stringWithFormat:@"%@原因",str]];
        
        NSString *applytime=[MyMD5 getTimeToShowWithTimestamp:model.add_time];
        
        CGFloat space;
        if (ThreeAndFiveInch) {
            space=35;
        }else{
            space=40;
        }
        
        for(int i=0;i<titlearr.count;i++)
        {
            UILabel *titlelable=[[UILabel alloc]initWithFrame:CGRectMake(ZOOM(62), 280+space*i, 80, 30)];
            titlelable.text=titlearr[i];
            titlelable.font=[UIFont systemFontOfSize:ZOOM(40)];
            titlelable.textColor=kTextGreyColor;
            [self.view addSubview:titlelable];
            
            UILabel *contentlable=[[UILabel alloc]initWithFrame:CGRectMake(90+ZOOM(62),280+space*i, kApplicationWidth-110, 30)];
            contentlable.font=[UIFont systemFontOfSize:ZOOM(40)];
            contentlable.textColor=kTextGreyColor;
            [self.view addSubview:contentlable];
            
            switch (i+1) {
                case 1:
                    contentlable.text=[NSString stringWithFormat:@"%@成功",str];
                    break;
                case 2:
                    contentlable.text=[NSString stringWithFormat:@"%.2f元",[model.money floatValue]];
                    break;
                case 3:
                    contentlable.text=[NSString stringWithFormat:@"%@",model.cause];
                    break;
                    
                default:
                    break;
            }
            
        }
        
        
    }
    
    
    [self fontAndSize];
}
/*
-(void)creatview
{
    NSString *statue=self.dic[@"status"];
    
    if(statue.intValue==5)//买家撤消
    {
        NSString *str;
        NSString *titletext;
        
        if([self.titlestring isEqualToString:@"退款详情"])
        {
            str=@"退款";
            titletext=@"撤消退款";
            
        }else if ([self.titlestring isEqualToString:@"退货详情"])
        {
            str=@"退货";
            titletext=@"撤消退货";
        }else if ([self.titlestring isEqualToString:@"换货详情"])
        {
            str=@"换货";
            titletext=@"撤消换货";
        }
        
        //订单头
        self.ordertitle.text=titletext;
        
        //退款金额
        self.orderprice.text=[NSString stringWithFormat:@"退款金额:¥%.2f元",[[NSString stringWithFormat:@"%@",self.dic[@"money"]]floatValue]];
        
        
        //订单编号
        self.ordercode.text=[NSString stringWithFormat:@"订单编号:%@",self.dic[@"order_code"]];

        
        //订单状态
        self.orderstatue.text=[NSString stringWithFormat:@"买家已%@",titletext];
        
        
        //申请时间
        NSString *timestr=[MyMD5 getTimeToShowWithTimestamp:self.dic[@"add_time"]];
        self.applytime.text=[NSString stringWithFormat:@"申请%@时间:%@",str,timestr];
        
        //撤消时间
        NSString *cancletime=[MyMD5 getTimeToShowWithTimestamp:self.dic[@"end_time"]];
            self.cancletime.text=[NSString stringWithFormat:@"撤消%@时间:%@",str,cancletime];
        self.cancletime.textColor=kTextGreyColor;

    }else if(statue.intValue==3){//审核未通过
    
        NSString *str;
        NSString *titletext;
        
        if([self.titlestring isEqualToString:@"退款详情"])
        {
            str=@"退款";
            titletext=@"商家未同意退款";
            
        }else if ([self.titlestring isEqualToString:@"退货详情"])
        {
            str=@"退货";
            titletext=@"商家未同意退货";
        }else if ([self.titlestring isEqualToString:@"换货详情"])
        {
            str=@"换货";
            titletext=@"商家未同意换货";
        }
        
        //订单头
        self.ordertitle.text=titletext;
        
        //退款金额
        self.orderprice.text=[NSString stringWithFormat:@"订单金额(包邮):¥%.2f元",[[NSString stringWithFormat:@"%@",self.dic[@"money"]]floatValue]];
        
        
        //订单编号
        self.ordercode.text=[NSString stringWithFormat:@"订单号:%@",self.dic[@"order_code"]];
        
        //申请时间
        NSString *timestr=[MyMD5 getTimeToShowWithTimestamp:self.dic[@"add_time"]];
        self.applytime.text=[NSString stringWithFormat:@"申请%@时间:%@",str,timestr];
        
        //订单状态
        self.orderstatue.text=[NSString stringWithFormat:@"你申请了%@",str];
        self.orderstatue.textColor=kTextGreyColor;
        self.orderstatue.font=[UIFont systemFontOfSize:ZOOM(40)];
        
        //未同意的原因
       
        self.cancletime.text=[NSString stringWithFormat:@"%@原因:%@",str,self.dic[@"cause"]];
        self.cancletime.textColor=kTextGreyColor;
        self.cancletime.font=[UIFont systemFontOfSize:ZOOM(40)];
        
        
        //未同意的时间
        if (_dic[@"ck_time"]!=nil && ![[NSString stringWithFormat:@"%@",_dic[@"ck_time"]]isEqualToString:@"<null>"]) {
            self.timelable.text=[MyMD5 getTimeToShowWithTimestamp:_dic[@"ck_time"]];
        }
        self.timelable.textColor=kTextGreyColor;
        self.timelable.font=[UIFont systemFontOfSize:ZOOM(40)];
        
        NSArray *titleArry=@[@"卖家未同意",@"你可以选择以下方式处理"];
        for(int i=0;i<2;i++)
        {
            UILabel *lable=[[UILabel alloc]initWithFrame:CGRectMake(ZOOM(62), 250+40*i, kApplicationWidth-20, 30)];
            lable.text=titleArry[i];
            [self.view addSubview:lable];
            
            if(i==1)
            {
                lable.textColor=kTextGreyColor;
                lable.font=[UIFont systemFontOfSize:14];
            }
        }
        
        CGFloat btnwidth=kApplicationWidth/2-20;
        NSArray *btnarr=@[@"联系卖家",@"售后帮助"];
        
        for(int i=0;i<2;i++)
        {
            UIButton *helpbtn=[[UIButton alloc]initWithFrame:CGRectMake(10+(btnwidth+20)*i,350, btnwidth, 30)];
            [helpbtn setTitle:btnarr[i] forState:UIControlStateNormal];
            [helpbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            helpbtn.tag=6000+i;
            helpbtn.layer.cornerRadius = 5;
            helpbtn.backgroundColor=[UIColor blackColor];
            [self.view addSubview:helpbtn];
        
            [helpbtn addTarget:self action:@selector(help:) forControlEvents:UIControlEventTouchUpInside];
        }
    }
    else if (statue.intValue==4||statue.intValue==8) //后期状态要改成8  //换货成功
    {
        
        NSString *str;
        NSString *titletext;
        
        if([self.titlestring isEqualToString:@"退款详情"])
        {
            str=@"退款";
            titletext=@"商家未同意退款";
            
        }else if ([self.titlestring isEqualToString:@"退货详情"])
        {
            str=@"退货";
            titletext=@"商家未同意退货";
        }else if ([self.titlestring isEqualToString:@"换货详情"])
        {
            str=@"换货";
            titletext=@"换货成功";
        }
        
        //订单头
        self.ordertitle.text=titletext;
        
        //退款金额
        self.orderprice.text=[NSString stringWithFormat:@"订单金额(包邮):¥%@元",self.dic[@"money"]];
        
        
        //订单编号
        self.ordercode.text=[NSString stringWithFormat:@"订单号:%@",self.dic[@"order_code"]];
        
        //申请时间
        NSString *timestr=[MyMD5 getTimeToShowWithTimestamp:self.dic[@"add_time"]];
        self.applytime.text=[NSString stringWithFormat:@"申请时间:%@",timestr];
        
        //订单状态
        self.orderstatue.text=[NSString stringWithFormat:@"买家已确认收货"];

        //未同意的原因
        
        self.cancletime.text=[NSString stringWithFormat:@"买家已收到换货物品,换货成功"];
        self.cancletime.font=[UIFont systemFontOfSize:ZOOM(50)];
//        self.cancletime.textColor=kTextGreyColor;
        self.cancletime.font=[UIFont systemFontOfSize:ZOOM(40)];
        
        
        //买家收货时间
        self.timelable.text=[MyMD5 getTimeToShowWithTimestamp:_dic[@"end_time"]];
        self.timelable.textColor=kTextGreyColor;
        self.timelable.font=[UIFont systemFontOfSize:ZOOM(40)];
        
        
        NSString *cause=[NSString stringWithFormat:@"%@",self.dic[@"cause"]];
        NSArray *titleArry=@[@"换货状态  换货成功",@"换货原因  "];
        for(int i=0;i<2;i++)
        {
            UILabel *lable=[[UILabel alloc]initWithFrame:CGRectMake(ZOOM(62), 250+40*i, kApplicationWidth-20, 30)];
            lable.textColor=[UIColor blackColor];
            lable.font=[UIFont systemFontOfSize:ZOOM(40)];
            [self.view addSubview:lable];
            
            NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@",titleArry[i]]];
            if(i==1)
            {
                noteStr=[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@%@",titleArry[i],cause]];;
            }
            
            NSRange redRange = NSMakeRange(0, [[noteStr string] rangeOfString:@" "].location);
            [noteStr addAttributes:@{NSForegroundColorAttributeName:kTextGreyColor} range:redRange];
            
            [lable setAttributedText:noteStr];
            

        }

    
    }
    else if (statue.intValue==6)//退款成功
    {
        
        NSString *str;
        NSString *titletext;
        
        if([self.titlestring isEqualToString:@"退款详情"])
        {
            str=@"退款";
            titletext=@"退款成功";
            
        }else if ([self.titlestring isEqualToString:@"退货详情"])
        {
            str=@"退货";
            titletext=@"退货成功";
        }else if ([self.titlestring isEqualToString:@"换货详情"])
        {
            str=@"换货";
            titletext=@"换货成功";
        }
        
        //订单头
        self.ordertitle.text=titletext;
        
        //退款金额
        self.orderprice.text=[NSString stringWithFormat:@"订单金额(包邮):¥%@元",self.dic[@"money"]];
        
        
        //订单编号
        self.ordercode.text=[NSString stringWithFormat:@"订单号:%@",self.dic[@"order_code"]];
        
        //申请时间
        NSString *timestr=[MyMD5 getTimeToShowWithTimestamp:self.dic[@"add_time"]];
        self.applytime.text=[NSString stringWithFormat:@"申请时间:%@",timestr];
        
        //订单状态
        self.orderstatue.text=[NSString stringWithFormat:@"退款成功"];
        
        //未同意的原因
        
        self.cancletime.text=[NSString stringWithFormat:@"商家同意退款,交易款项%@已退款至你帐户",self.dic[@"money"]];
        
        self.cancletime.font=[UIFont systemFontOfSize:ZOOM(50)];
        //        self.cancletime.textColor=kTextGreyColor;
        self.cancletime.font=[UIFont systemFontOfSize:ZOOM(40)];
        
        
        //买家收货时间
        self.timelable.text=[MyMD5 getTimeToShowWithTimestamp:_dic[@"end_time"]];
        self.timelable.textColor=kTextGreyColor;
        self.timelable.font=[UIFont systemFontOfSize:ZOOM(40)];
        
        //退款记录
        UIButton *moneygobtn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
        moneygobtn.frame=CGRectMake(ZOOM(62), 260, kApplicationWidth-ZOOM(62)*2, 30);
        moneygobtn.layer.borderWidth=1;
        moneygobtn.layer.cornerRadius=5;
        moneygobtn.layer.borderColor=kBackgroundColor.CGColor;
        [moneygobtn setTitle:@"查看退款记录" forState:UIControlStateNormal];
        [moneygobtn setTitleColor:kTextGreyColor forState:UIControlStateNormal];
        [moneygobtn addTarget:self action:@selector(moneygo:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:moneygobtn];
        

        
        //协商详情
        NSArray *titlearr=@[@"退货状态",@"退款金额",@"退货原因"];
        
        NSString *applytime=[MyMD5 getTimeToShowWithTimestamp:self.dic[@"add_time"]];
        
        CGFloat space;
        if (ThreeAndFiveInch) {
            space=35;
        }else{
            space=40;
        }
        
        for(int i=0;i<titlearr.count;i++)
        {
            UILabel *titlelable=[[UILabel alloc]initWithFrame:CGRectMake(ZOOM(62), moneygobtn.frame.origin.y+moneygobtn.frame.size.height+15+space*i, 80, 30)];
            titlelable.text=titlearr[i];
            titlelable.font=[UIFont systemFontOfSize:ZOOM(40)];
            titlelable.textColor=kTextGreyColor;
            [self.view addSubview:titlelable];
            
            UILabel *contentlable=[[UILabel alloc]initWithFrame:CGRectMake(90+ZOOM(62), moneygobtn.frame.origin.y+moneygobtn.frame.size.height+15+space*i, kApplicationWidth-110, 30)];
            contentlable.font=[UIFont systemFontOfSize:ZOOM(40)];
            contentlable.textColor=kTextGreyColor;
            [self.view addSubview:contentlable];
            
            switch (i+1) {
                case 1:
                    contentlable.text=@"退款成功";
                    break;
                case 2:
                    contentlable.text=[NSString stringWithFormat:@"%@元",self.dic[@"money"]];
                    break;
                case 3:
                    contentlable.text=[NSString stringWithFormat:@"%@",self.dic[@"cause"]];
                    break;
                                  
                default:
                    break;
            }
            
        }


    }
    else if (statue.intValue==7)//退款关闭
    {
        
        NSString *str;
        NSString *titletext;
        
        if([self.titlestring isEqualToString:@"退款详情"])
        {
            str=@"退款";
            titletext=@"退款关闭";
            
        }else if ([self.titlestring isEqualToString:@"退货详情"])
        {
            str=@"退货";
            titletext=@"退货成功";
        }else if ([self.titlestring isEqualToString:@"换货详情"])
        {
            str=@"换货";
            titletext=@"换货成功";
        }
        
        //订单头
        self.ordertitle.text=titletext;
        
        //退款金额
        self.orderprice.text=[NSString stringWithFormat:@"订单金额(包邮):¥%@元",self.dic[@"money"]];
        
        
        //订单编号
        self.ordercode.text=[NSString stringWithFormat:@"订单号:%@",self.dic[@"order_code"]];
        
        //申请时间
        NSString *timestr=[MyMD5 getTimeToShowWithTimestamp:self.dic[@"add_time"]];
        self.applytime.text=[NSString stringWithFormat:@"申请时间:%@",timestr];
        
        //订单状态
        self.orderstatue.text=[NSString stringWithFormat:@"退款关闭"];
        
        //未同意的原因
        
        self.cancletime.text=[NSString stringWithFormat:@"由于你确认收货此退款申请已关闭"];
        
        self.cancletime.font=[UIFont systemFontOfSize:ZOOM(50)];
        //        self.cancletime.textColor=kTextGreyColor;
        self.cancletime.font=[UIFont systemFontOfSize:ZOOM(40)];
        
        
        //买家收货时间
        self.timelable.text=[MyMD5 getTimeToShowWithTimestamp:_dic[@"end_time"]];
        self.timelable.textColor=kTextGreyColor;
        self.timelable.font=[UIFont systemFontOfSize:ZOOM(40)];
        
        

        //协商详情
        NSArray *titlearr=@[@"退货状态",@"退款金额",@"退货原因"];
        
        NSString *applytime=[MyMD5 getTimeToShowWithTimestamp:self.dic[@"add_time"]];
        
        CGFloat space;
        if (ThreeAndFiveInch) {
            space=35;
        }else{
            space=40;
        }
        
        for(int i=0;i<titlearr.count;i++)
        {
            UILabel *titlelable=[[UILabel alloc]initWithFrame:CGRectMake(ZOOM(62), 280+space*i, 80, 30)];
            titlelable.text=titlearr[i];
            titlelable.font=[UIFont systemFontOfSize:ZOOM(40)];
            titlelable.textColor=kTextGreyColor;
            [self.view addSubview:titlelable];
            
            UILabel *contentlable=[[UILabel alloc]initWithFrame:CGRectMake(90+ZOOM(62),280+space*i, kApplicationWidth-110, 30)];
            contentlable.font=[UIFont systemFontOfSize:ZOOM(40)];
            contentlable.textColor=kTextGreyColor;
            [self.view addSubview:contentlable];
            
            switch (i+1) {
                case 1:
                    contentlable.text=@"退款成功";
                    break;
                case 2:
                    contentlable.text=[NSString stringWithFormat:@"%@元",self.dic[@"money"]];
                    break;
                case 3:
                    contentlable.text=[NSString stringWithFormat:@"%@",self.dic[@"cause"]];
                    break;
                    
                default:
                    break;
            }
            
        }
        
        
    }
    

    [self fontAndSize];
}
*/
-(void)fontAndSize
{
    _orderprice.frame=CGRectMake(ZOOM(62), _orderprice.frame.origin.y, _orderprice.frame.size.width, _orderprice.frame.size.height);
    _ordercode.frame=CGRectMake(ZOOM(62), _ordercode.frame.origin.y, _ordercode.frame.size.width, _ordercode.frame.size.height);
    _applytime.frame=CGRectMake(ZOOM(62), _applytime.frame.origin.y, _applytime.frame.size.width, _applytime.frame.size.height);
    _ordertitle.frame=CGRectMake(ZOOM(62), _ordertitle.frame.origin.y, _ordertitle.frame.size.width, _ordertitle.frame.size.height);
    _orderstatue.frame=CGRectMake(ZOOM(62), _orderstatue.frame.origin.y, _orderstatue.frame.size.width, _orderstatue.frame.size.height);
    _cancletime.frame=CGRectMake(ZOOM(62), _cancletime.frame.origin.y, kApplicationWidth-ZOOM(62)*2, _cancletime.frame.size.height);
    _timelable.frame=CGRectMake(kApplicationWidth-ZOOM(62)-_timelable.frame.size.width, _timelable.frame.origin.y, _timelable.frame.size.width, _timelable.frame.size.height);
}
-(void)moneygo:(UIButton*)sender
{
//    MoneyGoViewController *moneygo=[[MoneyGoViewController alloc]init];
    TFAccountDetailsViewController *moneygo = [[TFAccountDetailsViewController alloc]init];
    moneygo.headIndex=2;
    
    [self.navigationController pushViewController:moneygo animated:YES];
}


-(void)help:(UIButton*)sender
{
    MyLog(@"help");
    
    if(sender.tag==6000)//联系卖家
    {
        // begin 赵官林 2016.5.26（功能：联系客服）
//        [self messageWithSuppid:@"915" title:nil model:nil detailType:nil imageurl:nil];
        // end
        
        
//        NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
//        NSString* suppid = [user objectForKey:PTEID];
//        EMConversation *conversation;
//
//        ChatViewController *chatController;
////        NSString *title = @"915";
//
//        NSString *title = suppid;
//
//        NSString *chatter = conversation.chatter;
//
//        //////////////////////////////////////////以后要删除
//        chatter=suppid;
//
//        chatController = [[ChatViewController alloc] initWithChatter:chatter conversationType:conversation.conversationType];
////        chatController.delelgate = self;
//        chatController.title = title;
//        if ([[RobotManager sharedInstance] getRobotNickWithUsername:chatter]) {
//            chatController.title = [[RobotManager sharedInstance] getRobotNickWithUsername:chatter];
//        }
//
//        [self presentViewController:chatController animated:YES completion:^{
//
//
//        }];
        
        ContactKefuViewController *contact = [[ContactKefuViewController alloc]init];
        contact.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:contact animated:YES];
    }else{//售后帮助
        
        ServiceViewController *service=[[ServiceViewController alloc]init];
        [self.navigationController pushViewController:service animated:YES];
    
    }
    
    
    
}

-(void)back
{
//    [self.navigationController popViewControllerAnimated:YES];
    for (UIViewController *controller in self.navigationController.viewControllers) {
        if ([controller isKindOfClass:[AftersaleViewController class]]) {
            [self.navigationController popToViewController:controller animated:YES];
        }
    }

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}


@end
