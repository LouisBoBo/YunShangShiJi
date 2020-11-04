//
//  AskforChangeViewController.m
//  YunShangShiJi
//
//  Created by ios-1 on 15/7/16.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//

#import "AskforChangeViewController.h"
#import "GlobalTool.h"
#import "AFNetworking.h"
#import "MBProgressHUD+NJ.h"
#import "MBProgressHUD+XJ.h"
#import "NavgationbarView.h"
#import "MyMD5.h"
#import "AddressModel.h"
#import "AccountAddressViewController.h"
#import "TFReceivingAddressViewController.h"
#import "AdressViewController.h"
#import "HZAreaPickerView.h"
#import "PopoverView.h"
#import "KeyboardTool.h"
#import "AftersaleViewController.h"
#import "LoginViewController.h"
//#import "ChatListViewController.h"

#import "WTFPickerView.h"


@interface AskforChangeViewController ()<PopoverViewDelegate,KeyboardToolDelegate,UIActionSheetDelegate>
{
    //计时器 天 时 分 秒
    NSString *_day;
    NSString *_hour;
    NSString *_min;
    NSString *_sec;
    
    NSString *_lasttime;
    
    //物流公司数据源
    NSMutableArray *_logisticArray;
    NSMutableDictionary *_logisticDictinary;
    
    //收货地址数据源
    NSMutableArray *_adressArray;
    
    
    //地址ID
    NSString *_addressID;
    
    //物流信息
    UILabel *_logisticcompany;
    UITextField *_logisticcode;
    UILabel *_logisticaddress;
    
    

    
    
    
    //选择地址的ID
    NSString *_SelectaddressID;
    
    UILabel *_gotolable;

    
    PopoverView *pop;
    
    
}
@property (nonatomic, strong)UITextField *moneyTextField;

@end

@implementation AskforChangeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    _logisticArray=[NSMutableArray array];
    _logisticDictinary=[NSMutableDictionary dictionary];
    _adressArray=[NSMutableArray array];
//    _companyArray=@[@"debangwuliu",@"ems",@"huitongkuaidi",@"quanfengkuaidi",@"shentong",@"shunfeng",@"tiantian",@"yuantong",@"yunda",@"zhaijisong",@"zhongtong"];
//    _companyArray=@[@"yuantong",@"shentong",@"ems",@"shunfeng",@"zhongtong",@"yunda",@"tiantian",@"huitongkuaidi",@"quanfengkuaidi",@"debangwuliu",@"zhaijisong",@"youzhengguonei",@"guotongkuaidi",@"zengyisudi",@"suer",@"ztky",@"ganzhongnengda",@"youshuwuliu",@"quanfengkuaidi"];
   //    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeaddress:) name:@"changeaddress" object:nil];
//    [self creatView];
    [self changeInformation:_orderModel];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    UITapGestureRecognizer *tapGes=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGesture)];
    tapGes.cancelsTouchesInView=NO;
    [_Myscrollview addGestureRecognizer:tapGes];
    //导航条
    UIImageView *headerview=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kApplicationWidth, Height_NavBar)];
    headerview.image=[UIImage imageNamed:@""];
    [self.view addSubview:headerview];
    headerview.userInteractionEnabled=YES;
    headerview.backgroundColor=[UIColor whiteColor];
    
    UIButton *backbtn=[UIButton buttonWithType:UIButtonTypeCustom];
    backbtn.frame=CGRectMake(0, 20, 46, 46);
    backbtn.centerY = View_CenterY(headerview);
    [backbtn setImage:[UIImage imageNamed:@"返回按钮_正常"] forState:UIControlStateNormal];
    [backbtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [headerview addSubview:backbtn];
    
    UILabel *titlelable=[[UILabel alloc]init];
    titlelable.frame=CGRectMake(0, 0, 300, 40);
    titlelable.center=CGPointMake(kApplicationWidth/2, headerview.frame.size.height/2+10);
    titlelable.text=self.titlestring;
    titlelable.font=kNavTitleFontSize;
    titlelable.textColor=kMainTitleColor;
    titlelable.textAlignment=NSTextAlignmentCenter;
    [headerview addSubview:titlelable];
    
//    UIButton *searchbtn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
//    searchbtn.frame=CGRectMake(kApplicationWidth - 40, 30, 25, 25);
//    searchbtn.tintColor=[UIColor blackColor];
//    [searchbtn setImage:[UIImage imageNamed:@"设置"]  forState:UIControlStateNormal];
//    searchbtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
//    [searchbtn addTarget:self action:@selector(tomessage:) forControlEvents:UIControlEventTouchUpInside];
//    [headerview addSubview:searchbtn];
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
    //监听通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeaddress:) name:@"changeaddress" object:nil];
    
    
//    [self requestHttp];

        //获取物流公司
    [self logisticHttp];
    
    //获取收货地址
    [self requestAdressHttp];
}
-(void)tapGesture
{

    [self.moneyTextField resignFirstResponder];

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
    
    self.Myscrollview.frame=CGRectMake(0, 44,kScreenWidth,kScreenHeight-44-60);

    NSArray *titleArr;

    NSString *add_time=[MyMD5 getTimeToShowWithTimestamp:model.add_time];
    
    if([self.titlestring isEqualToString:@"退货详情"])
    {
        
//        self.titlelable.text=@"正在支付宝审核";
//        self.titlelable.font=[UIFont systemFontOfSize:ZOOM(50)];
//        self.addtimelab.hidden = YES;

        if(model.status.intValue == 9 ||model.status.intValue == 11)
        {
            self.titlelable.text=@"正在支付宝审核";
            self.titlelable.font=[UIFont systemFontOfSize:ZOOM(50)];
            self.addtimelab.hidden = YES;

        }else{
        
            self.titlelable.text=@"商家同意退货";
            self.addtimelab.text=[NSString stringWithFormat:@"退货时间:%@",add_time];
            _labelWrite.text=@"请退货并填写物流消息";
            titleArr=@[@"退货物流:",@"物流单号:"];
        }
        
    }else if ([self.titlestring isEqualToString:@"换货详情"])
    {
        self.titlelable.text=@"商家同意换货";
        self.addtimelab.text=[NSString stringWithFormat:@"换货时间:%@",add_time];
        _labelWrite.text=@"请换货并填写物流消息";
        titleArr=@[@"换货物流:",@"物流单号:",@"收货地址:"];
        
    }else if ([self.titlestring isEqualToString:@"退款详情"])
    {
        self.titlelable.text=@"正在支付宝审核";
        self.titlelable.font=[UIFont systemFontOfSize:ZOOM(50)];
        self.addtimelab.hidden = YES;
        
    }
    
//    if([self.titlestring isEqualToString:@"退款详情"] || [self.titlestring isEqualToString:@"退货详情"])
     if(model.status.intValue ==9 || model.status.intValue ==11)
    {
        _line1.hidden=YES;
        _line2.hidden=YES;
        self.ordercodelab.text=[NSString stringWithFormat:@"订单号:%@",model.order_code];
        self.ordercodelab.font = [UIFont systemFontOfSize:ZOOM(44)];
        
        self.orderpricelab.text=[NSString stringWithFormat:@"订单金额(包邮):¥%.2f",[[NSString stringWithFormat:@"%@",model.money]floatValue]];
        self.orderpricelab.font =[UIFont systemFontOfSize:ZOOM(44)];
        
        self.titlelab2.text=@"正在退款中";
        self.titlelab2.font = [UIFont systemFontOfSize:ZOOM(50)];
        self.labelWrite.hidden=YES;
        //        self.timegolab.hidden=YES;
        
        //卖家信息
        self.timegolab.text =@"商家同意换货/退款";
        self.timegolab.font =[UIFont systemFontOfSize:ZOOM(57)];
        
        self.consigneel.text=[NSString stringWithFormat:@"退款状态:  %@",@"支付宝审核中"];
        self.consigneel.font = [UIFont systemFontOfSize:ZOOM(44)];
        
        self.phonelab.text=[NSString stringWithFormat:@"退款类型:  %@",@"退款"];
        self.phonelab.font = [UIFont systemFontOfSize:ZOOM(44)];
        
        self.postcode.text=[NSString stringWithFormat:@"退款金额:  %.2f元",[[NSString stringWithFormat:@"%@",model.money]floatValue]];
        self.postcode.font = [UIFont systemFontOfSize:ZOOM(44)];
        
        self.adress.text=[NSString stringWithFormat:@"退款原因:  %@",[NSString stringWithFormat:@"%@",model.cause]];
        self.adress.font = [UIFont systemFontOfSize:ZOOM(44)];
        
    }else{
        
        //时间计时器
        NSString *timestring=[NSString stringWithFormat:@"%@",model.lasttime];
        _lasttime=timestring;

//        [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(timerFireMethod:) userInfo:nil repeats:YES];
        [NSTimer weakTimerWithTimeInterval:0.1 target:self selector:@selector(timerFireMethod:) userInfo:nil repeats:YES];
        self.titlelab2.text=self.titlelable.text;
        self.ordercodelab.text=[NSString stringWithFormat:@"订单号:%@",model.order_code];
        self.orderpricelab.text=[NSString stringWithFormat:@"订单金额(包邮):¥%.2f",[[NSString stringWithFormat:@"%@",model.money]floatValue]];
        
        if ([model.supp_consignee isEqual:[NSNull null]]&&[model.supp_phone isEqual:[NSNull null]]&&[model.supp_postcode isEqual:[NSNull null]]&&[model.address isEqual:[NSNull null]]) {
            self.consigneel.text=[NSString stringWithFormat:@"退货地址"];
            _phonelab.text=@"空";
            NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"卖家已同意退货申请,请拨打客服电话400-888-4224询问卖家收货地址"]];
            NSRange redRange = NSMakeRange(17, 12);
            [noteStr addAttributes:@{NSForegroundColorAttributeName:tarbarrossred} range:redRange];
            [self.postcode setAttributedText:noteStr];
            _postcode.numberOfLines=2;
            _postcode.frame=CGRectMake(ZOOM(62), CGRectGetMaxY(_phonelab.frame)+ZOOM(10), _phonelab.frame.size.width-ZOOM(62), 40);
            
            UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame=CGRectMake(kApplicationWidth/2-130/2, CGRectGetMaxY(_postcode.frame)+ZOOM(80),130, 30);
            [btn setImage:[UIImage imageNamed:@"拨打电话"] forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(phoneclick) forControlEvents:UIControlEventTouchUpInside];
            btn.layer.borderWidth=1;
            btn.layer.borderColor=lineGreyColor.CGColor;
            [_Infoview addSubview:btn];
            
        }else{
            self.consigneel.text=[NSString stringWithFormat:@"收件人:%@",model.supp_consignee];
            self.phonelab.text=[NSString stringWithFormat:@"电话:%@",model.supp_phone];
            self.postcode.text=[NSString stringWithFormat:@"邮编:%@",model.supp_postcode];
            self.adress.text=[NSString stringWithFormat:@"地址:%@",model.address];
        }
        
    }
    

    
    [self fontAndSize];
    
    self.Myscrollview.contentSize=CGSizeMake(kApplicationWidth, _headview.frame.size.height+_Infoview.frame.size.height+_markview.frame.size.height);
    
    
//    if(![self.titlestring isEqualToString:@"退款详情"] || ![self.titlestring isEqualToString:@"退货详情"])
    if(model.status.intValue !=9 || model.status.intValue !=11)
    {
        //物流信息
        UIView *logisticView=[[UIView alloc]initWithFrame:CGRectMake(0,self.Infoview.frame.origin.y+self.Infoview.frame.size.height, kApplicationWidth, 150)];
        logisticView.tag=9999;
        [self.Myscrollview addSubview:logisticView];
        
        for(int i=0;i<titleArr.count;i++)
        {
            UILabel *lable=[[UILabel alloc]initWithFrame:CGRectMake(ZOOM(62), 10+40*i, 90, 30)];
            lable.text=titleArr[i];
            lable.font=[UIFont systemFontOfSize:ZOOM(50)];
            [logisticView addSubview:lable];
            
            UIImageView *imageview=[[UIImageView alloc]initWithFrame:CGRectMake(110, 10+40*i, kApplicationWidth-130, 30)];
            imageview.backgroundColor=[UIColor whiteColor];
            UIImage *image=[[UIImage alloc]init];
            
            if(i==0)
            {
                image=[UIImage imageNamed:@"更多-1"];
                UILabel *logisticlab=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, kApplicationWidth-130, 30)];
                logisticlab.tag=6666;
                logisticlab.layer.borderColor=lineGreyColor.CGColor;
                logisticlab.font=[UIFont systemFontOfSize:14];
                logisticlab.layer.borderWidth=0.5;
                logisticlab.layer.cornerRadius=5;
                [imageview addSubview:logisticlab];
                
                
                UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(kApplicationWidth-130-40, logisticlab.frame.origin.y, 30, 30)];
                imgView.backgroundColor=[UIColor lightTextColor];
                imgView.image=image;
                imgView.contentMode=UIViewContentModeScaleAspectFit;
                [imageview addSubview:imgView];
                
                _logisticcompany=logisticlab;
                
                UITapGestureRecognizer *logistictap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(logisticclick:)];
                [imageview addGestureRecognizer:logistictap];
                imageview.userInteractionEnabled=YES;
                
            }else if (i==1)
            {
                image=[UIImage imageNamed:@"圆角矩形-20-副本-2"];
                
                UITextField *codefild=[[UITextField alloc]initWithFrame:CGRectMake(0, 0,kApplicationWidth-130, 30)];
                codefild.placeholder=@"请填写物流单号";
                codefild.delegate=self;
                codefild.font=[UIFont systemFontOfSize:14];
                codefild.borderStyle=UITextBorderStyleRoundedRect;
                [imageview addSubview:codefild];
                imageview.userInteractionEnabled=YES;
                
                _logisticcode=codefild;
                

                
                
            }else if (i==2)
            {
                image=[UIImage imageNamed:@"更多-1"];
                UILabel *addresslab=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, kApplicationWidth-130, 30)];
                addresslab.tag=6667;
                addresslab.layer.borderColor=lineGreyColor.CGColor;
                addresslab.layer.borderWidth=0.5;
                addresslab.layer.cornerRadius=5;
                addresslab.font=[UIFont systemFontOfSize:14];
                _logisticaddress=addresslab;
                [imageview addSubview:addresslab];

                UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(kApplicationWidth-130-40, addresslab.frame.origin.y, 30, 30)];
                imgView.backgroundColor=[UIColor whiteColor];
                imgView.image=image;
                imgView.contentMode=UIViewContentModeScaleAspectFit;
                [imageview addSubview:imgView];
                
                UITapGestureRecognizer *addresstap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(addresstapclick:)];
                [imageview addGestureRecognizer:addresstap];
                imageview.userInteractionEnabled=YES;
            }
            
            
            //        imageview.image=image;
            
            [logisticView addSubview:imageview];
        }
        
        //提交按钮
        if ((model.status.intValue==2&&model.orderShopStatus.intValue==1)||(model.status.intValue==2&&model.orderShopStatus.intValue==2)) {
            UIButton *submitbtn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
            submitbtn.frame=CGRectMake(ZOOM(62), kApplicationHeight-50+kUnderStatusBarStartY, kApplicationWidth-ZOOM(62)*2, 40);
            submitbtn.backgroundColor=[UIColor blackColor];
            submitbtn.tintColor=[UIColor whiteColor];
            //    submitbtn.layer.cornerRadius = 5;
            [submitbtn setTitle:@"提交" forState:UIControlStateNormal];
            [submitbtn addTarget:self action:@selector(submit:) forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:submitbtn];
        }
      
       
    
        self.Myscrollview.contentSize=CGSizeMake(kApplicationWidth, _headview.frame.size.height+_Infoview.frame.size.height+_markview.frame.size.height+logisticView.frame.size.height);
    
    }

    
}


-(void)fontAndSize
{
    
    _titlelable.frame=CGRectMake(ZOOM(62), _titlelable.frame.origin.y, _titlelable.frame.size.width, _titlelable.frame.size.height);
    _orderpricelab.frame=CGRectMake(ZOOM(62), _orderpricelab.frame.origin.y, _orderpricelab.frame.size.width, _orderpricelab.frame.size.height);
    _ordercodelab.frame=CGRectMake(ZOOM(62), _ordercodelab.frame.origin.y, _ordercodelab.frame.size.width, _ordercodelab.frame.size.height);
    if([self.titlestring isEqualToString:@"退款详情"])
    {
        _titlelable.frame=CGRectMake(ZOOM(62), _titlelable.frame.origin.y+10, _titlelable.frame.size.width, _titlelable.frame.size.height);
        _orderpricelab.frame=CGRectMake(ZOOM(62), _orderpricelab.frame.origin.y+10, _orderpricelab.frame.size.width, _orderpricelab.frame.size.height);
        _ordercodelab.frame=CGRectMake(ZOOM(62), _ordercodelab.frame.origin.y+10, _ordercodelab.frame.size.width, _ordercodelab.frame.size.height);
    }
    _addtimelab.frame=CGRectMake(ZOOM(62), _addtimelab.frame.origin.y, _addtimelab.frame.size.width, _addtimelab.frame.size.height);
    _headview.frame=CGRectMake(0, _headview.frame.origin.y, kApplicationWidth, _titlelable.frame.size.height+_orderpricelab.frame.size.height+_ordercodelab.frame.size.height+_addtimelab.frame.size.height+ZOOM(32)*3);
    
    
    _titlelab2.frame=CGRectMake(ZOOM(62),ZOOM(32), _titlelab2.frame.size.width, _titlelab2.frame.size.height);
    _labelWrite.frame=CGRectMake(ZOOM(62), CGRectGetMaxY(_titlelab2.frame)+ZOOM(32), _labelWrite.frame.size.width, _labelWrite.frame.size.height);
    NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:14.0]};
    CGSize textSize = [_timegolab.text boundingRectWithSize:CGSizeMake(kApplicationWidth-ZOOM(62)*2, 200) options:NSStringDrawingUsesFontLeading attributes:attributes context:nil].size;
    _timegolab.numberOfLines=1;
    _timegolab.frame=CGRectMake(ZOOM(62), CGRectGetMaxY(_labelWrite.frame)+ZOOM(32),kApplicationWidth-ZOOM(62)*2, textSize.height);
    _line1.frame=CGRectMake(0, CGRectGetMaxY(_timegolab.frame)+ZOOM(32), kApplicationWidth, 1);
    _markview.frame = CGRectMake(0, _markview.frame.origin.y, kApplicationWidth, _titlelab2.frame.size.height+_labelWrite.frame.size.height+textSize.height+ZOOM(32)*4);

    
    _consigneel.frame=CGRectMake(ZOOM(62), ZOOM(32), _consigneel.frame.size.width, _consigneel.frame.size.height);
    _phonelab.frame=CGRectMake(ZOOM(62), CGRectGetMaxY(_consigneel.frame)+ZOOM(32), _phonelab.frame.size.width, _phonelab.frame.size.height);
    _postcode.frame=CGRectMake(ZOOM(62), CGRectGetMaxY(_phonelab.frame)+ZOOM(32), _postcode.frame.size.width, _postcode.frame.size.height);
    CGSize textSize1 = [_adress.text boundingRectWithSize:CGSizeMake(kApplicationWidth-ZOOM(62)*2, 100) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    _adress.frame=CGRectMake(ZOOM(62), CGRectGetMaxY(_postcode.frame)+ZOOM(32),kApplicationWidth-ZOOM(62)*2, textSize1.height);
    _line2.frame=CGRectMake(0, CGRectGetMaxY(_adress.frame)+ZOOM(32), kApplicationWidth, 1);
    _Infoview.frame = CGRectMake(0, CGRectGetMaxY(_markview.frame)+1, kApplicationWidth, _consigneel.frame.size.height+_phonelab.frame.size.height+_postcode.frame.size.height+textSize1.height+ZOOM(32)*5+1);


//    if([self.titlestring isEqualToString:@"退款详情"])
//    {
//    _adress.frame=CGRectMake(ZOOM(62), _adress.frame.origin.y,kApplicationWidth-ZOOM(62)*2, _postcode.frame.size.height);
//    }


}
//.倒计时的实现
- (void)timerFireMethod:(NSTimer *)timer
{
    
    NSString *timestring=[NSString stringWithFormat:@"%@",_lasttime];
    NSString *time=[MyMD5 getTimeToShowWithTimestamp:timestring];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy.MM.dd HH:mm:ss"];
    NSDate *compareDate=[formatter dateFromString:time];//目标时间
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSDate *today = [NSDate date];//当前时间
    unsigned int unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    NSDateComponents *d = [calendar components:unitFlags fromDate:today toDate:compareDate options:0];//计算时间差
    
    _day=[NSString stringWithFormat:@"%d",[d day]];
    _hour=[NSString stringWithFormat:@"%d",[d hour]];
    _min=[NSString stringWithFormat:@"%d",[d minute]];
    _sec=[NSString stringWithFormat:@"%d",[d second]];
    
    
    self.timegolab.text = [NSString stringWithFormat:@"请在%@天%@小时%@分%@秒内填写逾期自动取消",_day,_hour,_min,_sec];
    
}

#pragma mark 选择物流
-(void)logisticclick:(UITapGestureRecognizer*)tap
{

    
    MyLog(@"选择物流");
    

        [self.view endEditing:YES];
        
    WTFPickerView *myPicker = [[WTFPickerView alloc]initWithDataArr:_logisticArray];
    [myPicker.picker selectRow:_logisticArray.count/2 inComponent:0 animated:NO];
    myPicker.theRow=_logisticArray.count/2;
    [myPicker didFinishSelectedString:^(NSString *selectPickerViewString) {
        UILabel *lable=(UILabel*)[_Myscrollview viewWithTag:6666];
        lable.text=selectPickerViewString;
    }];
    

    

    


}

#pragma mark 选择收货地址
-(void)addresstapclick:(UITapGestureRecognizer*)tap
{
    MyLog(@"选择地址");
    
    

    
    NSArray *titleArray=@[@"原地址返回",@"其它地址"];
    _adressArray=[NSMutableArray arrayWithArray:titleArray];
    

    
    CGPoint rootViewPoint = [[tap.view superview] convertPoint:tap.view.frame.origin toView:self.view];
    //%f",rootViewPoint.y);
//    CGPoint point=CGPointMake(kApplicationWidth-30, view.frame.origin.y+175+heigh);
    CGPoint point=CGPointMake(kApplicationWidth-43, rootViewPoint.y+20);

    
    pop = [[PopoverView alloc] initWithPoint:point titles:titleArray images:nil withSceenWith:kScreenWidth popWith:0 cellTextFont:0];
    
    pop.tag=8888;
    pop.delegate = self;
    
    [pop show];

    
    
   


    
    
    
}

#pragma mark --PopoverView 代理
- (void)seletRowAtIndex:(PopoverView *)popoverView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    
    if(popoverView.tag==8888)
    {
        if(_adressArray.count)
        {
            NSString *str=_adressArray[indexPath.row];
            
            //is %@",_adressArray[indexPath.row]);
            
            UILabel *lable=(UILabel*)[self.view viewWithTag:6667];
            
            if(indexPath.row==0)
            {
                lable.text=str;
            }else{
            
                TFReceivingAddressViewController *tfreceiving=[[TFReceivingAddressViewController alloc]init];
                tfreceiving.adresstype = @"选择收货地址";
                [self.navigationController pushViewController:tfreceiving animated:YES];
//                AdressViewController *address=[[AdressViewController alloc]init];
//                [self.navigationController pushViewController:address animated:YES];
            }
            
        }
        
    }
    
    
    
}





#pragma mark 提交信息
-(void)submit:(UIButton*)sender
{
    MyLog(@"提交");
    if(_logisticcompany.text ==nil||_logisticcompany.text.length==0){
        [MBProgressHUD showError:@"请选择快递公司"];
        return;
    }
//    if(![MyMD5 validateNumber:_logisticcode.text ]){
//        [MBProgressHUD showError:@"请填写正确的物流单号"];
//        return;
//    }

    if(_logisticcode.text==nil||_logisticcode.text.length==0){
        [MBProgressHUD showError:@"请填写物流单号"];
        return;
    }
    
    if(_logisticaddress.text==nil&&_logisticaddress!=nil)
    {
        [MBProgressHUD showError:@"请填写收货地址"];
        return;
    }
    
    [self requestHttp];
}

#pragma mark 获取物流公司名称
-(void)logisticHttp
{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *paraments=[NSMutableDictionary dictionary];
    
    NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
    NSString *token=[user objectForKey:USER_TOKEN];
    
    
    NSString *url=[NSString stringWithFormat:@"%@returnShop/getKuaidi?version=%@&token=%@",[NSObject baseURLStr],VERSION,token];
    
    NSString *URL=[MyMD5 authkey:url];
    
    [MBProgressHUD showMessage:@"正在玩命加载" afterDeleay:0 WithView:self.view];
    
    [manager POST:URL parameters:paraments success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [MBProgressHUD hideHUDForView:self.view];
        
        MyLog(@"%@",responseObject);
        //responseObject = [NSDictionary changeType:responseObject];
        if (responseObject!=nil) {
            NSString *message;
            NSString *str=[NSString stringWithFormat:@"%@",responseObject[@"status"]];
            if(str.intValue==1)
            {

                NSDictionary *dic=responseObject[@"data"];
                
                NSArray *array = [responseObject[@"data"]allKeys];
                
//                NSArray *sortedArray = [array sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2){
//                    return [obj1 compare:obj2 options:NSNumericSearch];
//                }];
//                for (NSString *categoryId in sortedArray) {
//                    NSLog(@"[dict objectForKey:categoryId] === %@",[dic objectForKey:categoryId]);
//                }
                
                for(int i=0;i<array.count;i++)  {
                    NSString *str=[dic objectForKey:array[i]];
                    if(str!=nil){
                        [_logisticArray addObject:str];
                        [_logisticDictinary setValue:array[i] forKey:str];
                    }
                }

                
            }else if(str.intValue == 10030){//没登录状态
                
                NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
                [ud removeObjectForKey:USER_TOKEN];
                
                LoginViewController *login=[[LoginViewController alloc]init];
                
                login.tag=1000;
                login.loginStatue = @"10030";
                login.hidesBottomBarWhenPushed=YES;
                [self.navigationController pushViewController:login animated:YES];
                
            }

            
            
            NavgationbarView *mentionview=[[NavgationbarView alloc]init];
            [mentionview showLable:message Controller:self];
        }
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        //网络连接失败");
        [MBProgressHUD hideHUDForView:self.view];
        [self logisticHttp];
    }];


}

#pragma mark 发送网络请求获取地址数据
-(void)requestAdressHttp
{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *paraments=[NSMutableDictionary dictionary];
    
    NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
    NSString *token=[user objectForKey:USER_TOKEN];
    
    
    NSString *url=[NSString stringWithFormat:@"%@address/queryall?version=%@&token=%@",[NSObject baseURLStr],VERSION,token];
    
    
    NSString *URL=[MyMD5 authkey:url];
    
//    [MBProgressHUD showMessage:@"正在玩命加载" afterDeleay:0 WithView:self.view];
    
    [manager POST:URL parameters:paraments success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [MBProgressHUD hideHUDForView:self.view];
        
        //responseObject = [NSDictionary changeType:responseObject];
        if (responseObject!=nil) {
            NSString *str=responseObject[@"status"];
            NSString *message=responseObject[@"message"];
            if(str.intValue==1)
            {
                for(NSDictionary *dic in responseObject[@"listdt"])
                {
                    
                    [_adressArray addObject:dic[@"address"]];
                    
                }
                
            }else if (str.intValue==10030)
            {
                [[NSUserDefaults standardUserDefaults] removeObjectForKey:USER_TOKEN];
                LoginViewController *login=[[LoginViewController alloc]init];
                login.tag=1000;
                login.loginStatue = @"10030";
                login.hidesBottomBarWhenPushed=YES;
                [self.navigationController pushViewController:login animated:YES];
                
            }
            
            NavgationbarView *mentionview=[[NavgationbarView alloc]init];
            [mentionview showLable:message Controller:self];

        }

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        //网络连接失败");
        [MBProgressHUD hideHUDForView:self.view];
        
    }];
    
    
}

#pragma mark 提交退换货信息
-(void)requestHttp
{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *paraments=[NSMutableDictionary dictionary];
    
    NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
    NSString *token=[user objectForKey:USER_TOKEN];
    
    //查找物流公司id
    NSString *logisticID=[_logisticDictinary objectForKey:_logisticcompany.text];
    
    NSMutableString *express_id=[NSMutableString string];
    [express_id appendString:_logisticcode.text];
    [express_id appendString:@":"];
    [express_id appendString:logisticID];
    
    //地址ID
    NSString *addressID;
    if(_addressID)
    {
        addressID=_addressID;
    }else{
        addressID=@"0";
    }
    
    NSString *url=[NSString stringWithFormat:@"%@returnShop/addLogistics?version=%@&token=%@&id=%@&address_id=%@&express_id=%@",[NSObject baseURLStr],VERSION,token,self.orderModel.ID,addressID,express_id];
    
    NSString *URL=[MyMD5 authkey:url];
    
    [MBProgressHUD showMessage:@"正在玩命加载" afterDeleay:0 WithView:self.view];
    
    [manager POST:URL parameters:paraments success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [MBProgressHUD hideHUDForView:self.view];
        
        //responseObject = [NSDictionary changeType:responseObject];
        
        if (responseObject!=nil) {
            NSString *message=[NSString stringWithFormat:@"%@",responseObject[@"message"]];
            NSString *str=[NSString stringWithFormat:@"%@",responseObject[@"status"]];
            if(str.intValue==1)
            {
                NSDictionary *dic=responseObject[@"returnShop"];
                NSString *statue=dic[@"status"];
                if(statue.intValue==1)
                {
                    //                message=@"操作成功";
                }else{
                    //                message=@"操作失败";
                }
                
//                message=@"操作成功";
                
            }else{
                
//                message=@"操作失败";
            }
            
            
            
            NavgationbarView *mentionview=[[NavgationbarView alloc]init];
            [mentionview showLable:message Controller:self];
            
             [self performSelector:@selector(back) withObject:nil afterDelay:1];

        }
        

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        //网络连接失败");
        [MBProgressHUD hideHUDForView:self.view];
        
    }];
    
    

}


#pragma mark 更换收货地址
-(void)changeaddress:(NSNotification*)note
{
    AddressModel *model=note.object;
    
    
    //通过地址ID查询确切地址
    NSMutableString *addressString=[NSMutableString string];
    [addressString appendString:[NSString stringWithFormat:@"%@",model.province]];
    [addressString appendString:@"_"];
    [addressString appendString:[NSString stringWithFormat:@"%@",model.city]];
    [addressString appendString:@"_"];
    [addressString appendString:[NSString stringWithFormat:@"%@",model.area]];
    if(model.street !=nil)
    {
        [addressString appendString:@"_"];
        [addressString appendString:[NSString stringWithFormat:@"%@",model.street]];
    }
    
    HZAreaPickerView *pickview=[[HZAreaPickerView alloc]init];
    NSString *addStr= [pickview fromIDgetAddress:addressString];
    
    UILabel *lable=(UILabel*)[self.view viewWithTag:6667];
    lable.font=[UIFont systemFontOfSize:12];
    lable.text=[NSString stringWithFormat:@"%@%@",addStr,model.address];
    _addressID=[NSString stringWithFormat:@"%@",model.ID];
    
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{

            self.moneyTextField = textField;


}





//-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
//{
//    [_dateView removeFromSuperview];
//    _isclick=NO;
//}




#pragma mark 打电话
-(void)phoneclick
{
    MyLog(@"打电话");
    
    UIActionSheet *phonesheet=[[UIActionSheet alloc]initWithTitle:@"联系客服" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@" 400-888-4224", nil];
    [phonesheet showInView:self.view];

    
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex==0)//打电话
    {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel://4008884224"]];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

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

- (void)keyboardWillShow:(NSNotification *)notification {
    
    NSDictionary *userInfo = [notification userInfo];
    CGRect keyboardFrame = [userInfo[@"UIKeyboardFrameEndUserInfoKey"]CGRectValue];
    
//    NSValue *animationDurationValue = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
//    NSTimeInterval animationDuration;
//    [animationDurationValue getValue:&animationDuration];
    
    CGPoint rootViewPoint = [[self.moneyTextField superview] convertPoint:self.moneyTextField.frame.origin toView:self.view];
//    //%f  %f",self.message.frame.origin.y,rootViewPoint.y);
    

    CGFloat height =rootViewPoint.y -keyboardFrame.origin.y;
    
    if (height>0)
    {
        [UIView animateWithDuration:0.25f
                         animations:^{
                             _Myscrollview.frame=CGRectMake(0,_Myscrollview.frame.origin.y-height-44, kApplicationWidth, kScreenHeight-44-60);

                         }];
    }
}

- (void)keyboardWillHide:(NSNotification *)notification {
    
//    NSDictionary *userInfo = [notification userInfo];
    
//    NSValue *animationDurationValue = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
//    NSTimeInterval animationDuration;
//    [animationDurationValue getValue:&animationDuration];
    [UIView animateWithDuration:0.25f
                     animations:^{
                         _Myscrollview.frame=CGRectMake(0, 44, kApplicationWidth, kScreenHeight-44-60);
                     }];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
