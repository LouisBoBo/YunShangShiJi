//
//  SuccessRerundViewController.m
//  YunShangShiJi
//
//  Created by ios-1 on 15/7/29.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//

#import "SuccessRerundViewController.h"
#import "GlobalTool.h"
#import "MyMD5.h"
#import "MoneyGoViewController.h"
#import "AftersaleViewController.h"

@interface SuccessRerundViewController ()

@end

@implementation SuccessRerundViewController

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
    titlelable.text=self.titlestr;
    titlelable.font=kNavTitleFontSize;
    titlelable.textColor=kMainTitleColor;
    titlelable.textAlignment=NSTextAlignmentCenter;
    [headview addSubview:titlelable];


    if([self.titlestr isEqualToString:@"退款详情"])
    {
        [self creatview];
    }else{
        [self creatRerundView];
    }
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

#pragma mark 退款的界面
-(void)creatview
{
    if(self.staute.intValue == 6)//退款成功
    {
        //退款金额
        self.rerundmoney.text=[NSString stringWithFormat:@"退款金额:%@元",self.dic[@"money"]];
        self.rerundmoney.textColor=kTextGreyColor;
    
        //退款时间
        NSString *timestr=[MyMD5 getTimeToShowWithTimestamp:self.dic[@"end_time"]];
        self.rerundtime.text=[NSString stringWithFormat:@"退款时间:%@",timestr];
        self.rerundtime.textColor=kTextGreyColor;
    
        //退款记录
        self.moneygobtn.layer.borderWidth=1;
        self.moneygobtn.layer.borderColor=kBackgroundColor.CGColor;
        [self.moneygobtn setTitleColor:kTextGreyColor forState:UIControlStateNormal];
        [self.moneygobtn addTarget:self action:@selector(moneygo:) forControlEvents:UIControlEventTouchUpInside];
    
        UILabel *statuelable=[[UILabel alloc]initWithFrame:CGRectMake(ZOOM(62), self.headview.frame.origin.y+120, kApplicationWidth, 40)];
        
        statuelable.text=@"退款详情";
        statuelable.font=[UIFont systemFontOfSize:ZOOM(48)];
        
        [self.view addSubview:statuelable];
    
        //协商详情
        NSArray *titlearr=@[@"退款类型",@"退款状态",@"退款金额",@"退款原因",@"退款说明",@"退款编号",@"申请时间"];
   
        NSString *applytime=[MyMD5 getTimeToShowWithTimestamp:self.dic[@"add_time"]];
    
        CGFloat space;
        if (ThreeAndFiveInch) {
            space=35;
        }else{
            space=40;
        }
    
        for(int i=0;i<titlearr.count;i++)
        {
            UILabel *titlelable=[[UILabel alloc]initWithFrame:CGRectMake(ZOOM(62), self.headview.frame.origin.y+self.headview.frame.size.height+35+space*i, 80, 30)];
            titlelable.text=titlearr[i];
            titlelable.font=[UIFont systemFontOfSize:ZOOM(40)];
            titlelable.textColor=kTextGreyColor;
            [self.view addSubview:titlelable];
        
            UILabel *contentlable=[[UILabel alloc]initWithFrame:CGRectMake(100, self.headview.frame.origin.y+self.headview.frame.size.height+35+space*i, kApplicationWidth-110, 30)];
            contentlable.font=[UIFont systemFontOfSize:ZOOM(40)];
            contentlable.textColor=kTextGreyColor;
            [self.view addSubview:contentlable];
        
            switch (i) {
            case 0:
                contentlable.text=[NSString stringWithFormat:@"退款金额:%@",self.dic[@"money"]];
                break;
            case 1:
                contentlable.text=@"退款成功";
                break;
            case 2:
                contentlable.text=[NSString stringWithFormat:@"%@元",self.dic[@"money"]];
                break;
            case 3:
                contentlable.text=[NSString stringWithFormat:@"%@",self.dic[@"cause"]];
                break;
            case 4:
                contentlable.text=[NSString stringWithFormat:@"%@",self.dic[@"explain"]];
                break;
            case 5:
                contentlable.text=[NSString stringWithFormat:@"%@",self.dic[@"return_code"]];
                break;
            case 6:
                
                contentlable.text=[NSString stringWithFormat:@"%@",applytime];
                break;
             
            default:
                break;
            }

        }
    
    }else //退款关闭
    {
        self.headview.userInteractionEnabled=YES;
        self.headview.frame=CGRectMake(0, self.headview.frame.origin.y, kApplicationWidth, 80);
        self.moneygobtn.hidden=YES;
        
        self.headtitle.text=@"退款关闭";
        //关闭原因
        self.rerundmoney.text=[NSString stringWithFormat:@"关闭原因:%@元",self.dic[@"money"]];
        self.rerundmoney.textColor=kTextGreyColor;
        
        //关闭时间
        NSString *timestr=[MyMD5 getTimeToShowWithTimestamp:self.dic[@"add_time"]];
        self.rerundtime.text=[NSString stringWithFormat:@"关闭时间:%@",timestr];
        self.rerundtime.textColor=kTextGreyColor;
        
        UILabel *statuelable=[[UILabel alloc]initWithFrame:CGRectMake(ZOOM(62), self.headview.frame.origin.y+90, kApplicationWidth, 40)];
        
        statuelable.text=@"售后详情";
        statuelable.font=[UIFont systemFontOfSize:ZOOM(48)];

        
        [self.view addSubview:statuelable];
        
        UILabel *linelable=[[UILabel alloc]initWithFrame:CGRectMake(0, self.headview.frame.origin.y+90+40, kApplicationWidth, 1)];
        linelable.backgroundColor=kBackgroundColor;
        [self.view addSubview:linelable];
        
        
        //协商详情
        NSArray *titlearr=@[@"售后类型",@"退款金额",@"退款原因",@"退款编号",@"申请时间"];

        NSString *applytime=[MyMD5 getTimeToShowWithTimestamp:self.dic[@"add_time"]];

        for(int i=0;i<titlearr.count;i++)
        {
            UILabel *titlelable=[[UILabel alloc]initWithFrame:CGRectMake(ZOOM(62), self.headview.frame.origin.y+self.headview.frame.size.height+55+40*i, 80, 30)];
            titlelable.text=titlearr[i];
            titlelable.font=[UIFont systemFontOfSize:ZOOM(40)];
            titlelable.textColor=kTextGreyColor;
            [self.view addSubview:titlelable];
            
            UILabel *contentlable=[[UILabel alloc]initWithFrame:CGRectMake(100, self.headview.frame.origin.y+self.headview.frame.size.height+55+40*i, kApplicationWidth-110, 30)];
            contentlable.font=[UIFont systemFontOfSize:ZOOM(40)];
            contentlable.textColor=kTextGreyColor;
            [self.view addSubview:contentlable];
            
            switch (i) {
                case 0:
                    contentlable.text=[NSString stringWithFormat:@"退款金额:%@",self.dic[@"money"]];
                    break;
                case 1:
                    contentlable.text=[NSString stringWithFormat:@"%@元",self.dic[@"money"]];
                    break;
                case 2:
                    contentlable.text=[NSString stringWithFormat:@"%@",self.dic[@"cause"]];
                    break;
                case 3:
                    contentlable.text=[NSString stringWithFormat:@"%@",self.dic[@"return_code"]];
                    break;
                case 4:
                    
                    contentlable.text=[NSString stringWithFormat:@"%@",applytime];
                    break;
                    
                default:
                    break;
            }
            
        }

    }
    
    
    
}

#pragma mark 退货成功的界面
-(void)creatRerundView
{
    if(self.staute.intValue == 6)//退货成功
    {
        //退款金额
        self.rerundmoney.text=[NSString stringWithFormat:@"退款金额:%@元",self.dic[@"money"]];
        self.rerundmoney.textColor=kTextGreyColor;
        
        //退款时间
        NSString *timestr=[MyMD5 getTimeToShowWithTimestamp:self.dic[@"end_time"]];
        self.rerundtime.text=[NSString stringWithFormat:@"退款时间:%@",timestr];
        self.rerundtime.textColor=kTextGreyColor;
        
        //退款记录
        self.moneygobtn.layer.borderWidth=1;
        self.moneygobtn.layer.borderColor=kBackgroundColor.CGColor;
        [self.moneygobtn setTitleColor:kTextGreyColor forState:UIControlStateNormal];
        [self.moneygobtn addTarget:self action:@selector(moneygo:) forControlEvents:UIControlEventTouchUpInside];
        
        UILabel *statuelable=[[UILabel alloc]initWithFrame:CGRectMake(ZOOM(62), self.headview.frame.origin.y+120, kApplicationWidth, 40)];
        
        statuelable.text=@"退款详情";
        statuelable.font=[UIFont systemFontOfSize:ZOOM(48)];

        [self.view addSubview:statuelable];
        
        //协商详情
        NSArray *titlearr=@[@"退货状态",@"退款金额",@"退货原因",@"退货说明",@"退货编号",@"申请时间"];
        
        NSString *applytime=[MyMD5 getTimeToShowWithTimestamp:self.dic[@"add_time"]];
        
        CGFloat space;
        if (ThreeAndFiveInch) {
            space=35;
        }else{
            space=40;
        }
        
        for(int i=0;i<titlearr.count;i++)
        {
            UILabel *titlelable=[[UILabel alloc]initWithFrame:CGRectMake(ZOOM(62), self.headview.frame.origin.y+self.headview.frame.size.height+35+space*i, 80, 30)];
            titlelable.text=titlearr[i];
            titlelable.font=[UIFont systemFontOfSize:ZOOM(40)];
            titlelable.textColor=kTextGreyColor;
            [self.view addSubview:titlelable];
            
            UILabel *contentlable=[[UILabel alloc]initWithFrame:CGRectMake(100, self.headview.frame.origin.y+self.headview.frame.size.height+35+space*i, kApplicationWidth-110, 30)];
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
                case 4:
                    contentlable.text=[NSString stringWithFormat:@"%@",self.dic[@"explain"]];
                    break;
                case 5:
                    contentlable.text=[NSString stringWithFormat:@"%@",self.dic[@"return_code"]];
                    break;
                case 6:
                    
                    contentlable.text=[NSString stringWithFormat:@"%@",applytime];
                    break;
                    
                default:
                    break;
            }
            
        }
    }
    
    
}
-(void)fontAndSize
{
    self.headimage.frame=CGRectMake(ZOOM(62), self.headimage.frame.origin.y, self.headimage.frame.size.width, self.headimage.frame.size.height);
    self.headtitle.frame=CGRectMake(self.headimage.frame.origin.x+self.headimage.frame.size.width+5, self.headtitle.frame.origin.y, self.headtitle.frame.size.width, self.headtitle.frame.size.height);
    self.rerundmoney.frame=CGRectMake(ZOOM(62), self.rerundmoney.frame.origin.y, self.rerundmoney.frame.size.width, self.rerundmoney.frame.size.height);
    self.rerundtime.frame=CGRectMake(ZOOM(62), self.rerundtime.frame.origin.y, self.rerundtime.frame.size.width, self.rerundtime.frame.size.height);
}
-(void)moneygo:(UIButton*)sender
{
    MoneyGoViewController *moneygo=[[MoneyGoViewController alloc]init];
    
    [self.navigationController pushViewController:moneygo animated:YES];
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
