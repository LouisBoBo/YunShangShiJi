//
//  NewSigninViewController.m
//  YunShangShiJi
//
//  Created by ios-1 on 15/12/14.
//  Copyright © 2015年 ios-1. All rights reserved.
//

#define TSF(w) [self heightCoefficient:height]

#define HEIGHT(height) [self heightCoefficient:height]

#import "NewSigninViewController.h"
#import "HYJIntelgralDetalViewController.h"
#import "GlobalTool.h"
#import "CircleTableViewCell.h"
#import "MBProgressHUD+NJ.h"
#import "MBProgressHUD+XJ.h"
#import "AFNetworking.h"
#import "NavgationbarView.h"
#import "MyMD5.h"
#import "MIssionModel.h"
#import "MisionTableViewCell.h"
#import "AppDelegate.h"
#import "TFHomeViewController.h"
#import "SubmitViewController.h"
#import "QRCodeGenerator.h"
#import "DShareManager.h"
#import "ProduceImage.h"

@interface NewSigninViewController () <DShareManagerDelegate,SubmitViewControllerDelegate>

@property (nonatomic, strong)UIImage *shareRandShopImage;
@property (nonatomic, assign)BOOL isRegisterKVO;

@end



@implementation NewSigninViewController
{
    UIView *_view;
    
    UITableView *_MytableView;
    NSMutableArray * _DayDataArray;
    NSMutableArray * _NewDataArray;
    
    //每日完成任务id数据源
    NSMutableArray *_everydayIdarry;
    
    //新手流程完成任务id数据源
    NSMutableArray *_fulfillIDarray;
    
    UILabel *_integral;                     //总积分
    UIButton *_signBtn;
    
    //近一个月进账
    NSString *_income;
    //近一个月支出
    NSString *_expense;
    
    int _typeCount;
    
    //任务id
    NSString *_public_mis_id;
    //任务积分
    NSString *_public_jifen;
    
    //连续签到天数
    int _dayCount;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    _DayDataArray = [NSMutableArray array];
    _NewDataArray = [NSMutableArray array];
    _everydayIdarry = [NSMutableArray array];
    _fulfillIDarray = [NSMutableArray array];
    
    
    
    [self httpGetIntegral];
    
    [self requestHttp];
    
    //监听分享成功通知
    
    NSString *st = @"测试";
    
    //
    self.isRegisterKVO = YES;
    
    [gKVO addObserver:self forKeyPath:@"myNewSign" options:NSKeyValueObservingOptionNew context:(void *)st];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hobbysuccess:) name:@"hobbysuccess" object:nil];

    [self creatNavagationView];
    [self creatTableView];

}


- (void)creatNavagationView
{
    //导航条
    UIImageView *headview=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kApplicationWidth, Height_NavBar)];
    //
    headview.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:headview];
    headview.userInteractionEnabled=YES;
    
    UIButton *backbtn=[UIButton buttonWithType:UIButtonTypeCustom];
    backbtn.frame=CGRectMake(0, 20, 44, 44);
    backbtn.centerY = View_CenterY(headview);
    [backbtn setImage:[UIImage imageNamed:@"返回按钮_正常"] forState:UIControlStateNormal];
    [backbtn addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    [headview addSubview:backbtn];
    
    
    UILabel *titlelable=[[UILabel alloc]init];
    titlelable.frame=CGRectMake(0, 0, 300, 40);
    titlelable.center=CGPointMake(kApplicationWidth/2, headview.frame.size.height/2+10);
    titlelable.text=@"我的任务";
    titlelable.font = kNavTitleFontSize;
    titlelable.textColor=kMainTitleColor;
    titlelable.textAlignment=NSTextAlignmentCenter;
    [headview addSubview:titlelable];

}

- (void)creatTableView
{
    _MytableView = [[UITableView alloc]initWithFrame:CGRectMake(0, Height_NavBar, kApplicationWidth, kApplicationHeight-Height_NavBar+kUnderStatusBarStartY) style:UITableViewStyleGrouped];
    _MytableView.delegate = self;
    _MytableView.dataSource = self;
    _MytableView.rowHeight = 90;
    _MytableView.backgroundColor=[UIColor whiteColor];
//    _MytableView.tableHeaderView = [self setHeadView];
    _MytableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_MytableView];
    

    [_MytableView registerNib:[UINib nibWithNibName:@"MisionTableViewCell" bundle:nil] forCellReuseIdentifier:@"miCell"];
    
}

#pragma mark 签到功能
-(UIView *)setHeadView
{
    _view = [[UIView alloc]initWithFrame:CGRectMake(0, 64, kApplicationWidth, ZOOM(800))];
    
    UIImageView *backImg = [[UIImageView alloc]initWithFrame:_view.bounds];

    backImg.image=[UIImage imageNamed:@"bg.jpg"];
    [_view addSubview:backImg];
    
    
    [self creatHead];

    
//    _integral = [[UILabel alloc]initWithFrame:CGRectMake(kApplicationWidth/2-100, 10, 200, 30)];
//    _integral.textAlignment = NSTextAlignmentCenter;
//
//    NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"总积分:%@",_totalintegral]];
//    _integral.textColor = tarbarrossred;
//    NSRange redRange = NSMakeRange(0, [[noteStr string] rangeOfString:@":"].location+1);
//    [noteStr addAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor],NSFontAttributeName:[UIFont systemFontOfSize:17]} range:redRange];
//    [_integral setAttributedText:noteStr];
//    _integral.font = [UIFont systemFontOfSize:17.0f];
//    [_view addSubview:_integral];
    
    
//    UILabel *remind = [[UILabel alloc]initWithFrame:CGRectMake(kApplicationWidth/2-50, _signBtn.frame.origin.y+_signBtn.frame.size.height+5, 100, 20)];
//    remind.text = @"签到赚积分哦~";
//    remind.font=[UIFont systemFontOfSize:12.0f];
//    remind.textAlignment = NSTextAlignmentCenter;
//    remind.textColor = kTextGreyColor;
//    [_view addSubview:remind];
    
    
    
    UIView *roundeDayView = [[UIView alloc]initWithFrame:CGRectMake(kApplicationWidth/2-160, _view.frame.size.height-ZOOM(90*3.4), 320, 50)];
    roundeDayView.tag = 1000;
    [_view addSubview:roundeDayView];
    
    for (int i=0; i<7; i++) {
        
        NSArray *array = @[@"5",@"10",@"15",@"25",@"50",@"100",@"200"];
        UIButton *roundeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        roundeBtn.frame = CGRectMake(25+i*40, 0, 30, 30);
        roundeBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [roundeBtn setTitle:[NSString stringWithFormat:@"%@",array[i]] forState:UIControlStateNormal];
        [roundeBtn setTitleColor:tarbarrossred forState:UIControlStateNormal];
        [roundeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [roundeBtn setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
        [roundeBtn setBackgroundImage:[UIImage imageWithColor:tarbarrossred] forState:UIControlStateSelected];
        roundeBtn.tag = i+100;
        
        MyLog(@"_signDay is %d",_signDay);
        
        if (_signDay>i) {
            roundeBtn.selected=YES;
        }else
            roundeBtn.selected = NO;
        roundeBtn.clipsToBounds = YES;
        roundeBtn.layer.borderColor=tarbarrossred.CGColor;
        roundeBtn.layer.borderWidth=1;
        roundeBtn.layer.cornerRadius = 30/2;
        [roundeDayView addSubview:roundeBtn];
        
        UILabel *dayLabel = [[UILabel alloc]initWithFrame:CGRectMake(roundeBtn.frame.origin.x, roundeBtn.frame.origin.y+roundeBtn.frame.size.height+3, 30, 20)];
        dayLabel.textColor=tarbarrossred;
        dayLabel.text=[NSString stringWithFormat:@"%d天",i+1];
        dayLabel.textAlignment=NSTextAlignmentCenter;
        dayLabel.font=[UIFont systemFontOfSize:14];
        [roundeDayView addSubview:dayLabel];
    }
    
    _signBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    _signBtn.frame = CGRectMake(kApplicationWidth/2-ZOOM(80*3.4)/2, roundeDayView.frame.origin.y+roundeDayView.frame.size.height+ZOOM(5*3.4),ZOOM(80*3.4), ZOOM(30*3.4));
    _signBtn.layer.cornerRadius = 5;
    _signBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [_signBtn setBackgroundImage:[UIImage imageNamed:@"签到按钮"] forState:UIControlStateNormal];
    [_signBtn setTitle:@"签到" forState:UIControlStateNormal];
    _signBtn.titleLabel.font = [UIFont systemFontOfSize:ZOOM(50)];
    [_signBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_signBtn addTarget:self action:@selector(signBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [_view addSubview:_signBtn];

    
    return _view;
}

- (void)creatHead
{
    
    CGFloat H_countLabel = CGRectGetHeight(_view.frame)/4.0;
    CGFloat W_countLabel = CGRectGetWidth(_view.frame)-ZOOM(40)*2;
    
    CGFloat H_2 = CGRectGetHeight(_view.frame)/2.0;
    
    self.integImageView = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth/2-ZOOM(250)/2,ZOOM(58), ZOOM(250), ZOOM(250))];
    self.integImageView.layer.borderColor = [[UIColor whiteColor] CGColor];
    self.integImageView.layer.borderWidth = 2;
    self.integImageView.layer.masksToBounds = YES;
    self.integImageView.layer.cornerRadius = ZOOM(250)/2;
//    self.integImageView.image = [UIImage imageNamed:@"总积分"];
    self.integImageView.backgroundColor = tarbarrossred;

    [_view addSubview:self.integImageView];

    
    UILabel *countTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(ZOOM(40),ZOOM(48), W_countLabel, H_countLabel)];
    countTitleLabel.text = @"总积分";
    countTitleLabel.textAlignment = NSTextAlignmentCenter;
    countTitleLabel.font = [UIFont boldSystemFontOfSize:ZOOM(48)];
    countTitleLabel.adjustsFontSizeToFitWidth = YES;
    countTitleLabel.textColor = [UIColor whiteColor];
    [_view addSubview:countTitleLabel];
    
    
    self.countLabel = [[UILabel alloc] initWithFrame:CGRectMake(ZOOM(40), ZOOM(58)+10, W_countLabel, ZOOM(250))];
    self.countLabel.font = [UIFont boldSystemFontOfSize:ZOOM(80)];
    self.countLabel.adjustsFontSizeToFitWidth = YES;
    self.countLabel.textColor = [UIColor whiteColor];
    self.countLabel.textAlignment = NSTextAlignmentCenter;
    [_view addSubview:self.countLabel];
    
    NSArray *titleArr = [NSArray arrayWithObjects:@"近一个月进账",@"签到",@"近一个月支出", nil];
    
    CGFloat W_l = ZOOM(200);
    CGFloat margin = (kScreenWidth-W_l*3)/4;
//    CGFloat Y_l = CGRectGetMaxY(_view.frame)+ZOOM(20);
    CGFloat Y_l = ZOOM(58)+self.integImageView.frame.size.height/2;
    CGFloat H_l = ZOOM(70);
    
    CGFloat H_bl = ZOOM(70);
    CGFloat W_bl = kScreenWidth/3;
    for (int i= 0 ; i<titleArr.count; i++) {
        UILabel *bottomLabel = [[UILabel alloc] init];
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(W_bl*i, Y_l, W_bl, ZOOM(140));
        if (i == 0) {
            self.inLabel = [[UILabel alloc] initWithFrame:CGRectMake(margin, Y_l, W_l, H_l)];
            self.inLabel.font = [UIFont systemFontOfSize:ZOOM(40)];
            self.inLabel.textColor = [UIColor whiteColor];
            self.inLabel.layer.masksToBounds  = YES;
            self.inLabel.layer.cornerRadius = H_l/2.0;
            self.inLabel.adjustsFontSizeToFitWidth = YES;
            self.inLabel.textAlignment = NSTextAlignmentCenter;
            self.inLabel.backgroundColor = tarbarrossred;;

            [_view addSubview:self.inLabel];
            btn.tag = 1000;
            [btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
            bottomLabel.frame = CGRectMake(0+i*W_bl, CGRectGetMaxY(self.inLabel.frame), W_bl, H_bl);
            bottomLabel.center = CGPointMake(self.inLabel.center.x, bottomLabel.center.y);
            bottomLabel.textColor = RGBCOLOR_I(152,152,152);
            [_view addSubview:btn];
            
        } else if (i == 1) {
            
        } else if (i == 2) {
            self.outLabel = [[UILabel alloc] initWithFrame:CGRectMake(margin*3+W_l*2, Y_l, W_l, H_l)];
            self.outLabel.font = [UIFont systemFontOfSize:ZOOM(40)];
            self.outLabel.textColor = [UIColor whiteColor];
            self.outLabel.backgroundColor = tarbarrossred;
            self.outLabel.layer.masksToBounds  = YES;
            self.outLabel.layer.cornerRadius = H_l/2.0;
            self.outLabel.adjustsFontSizeToFitWidth = YES;
            self.outLabel.textAlignment = NSTextAlignmentCenter;

            [_view addSubview:self.outLabel];
            
            bottomLabel.frame = CGRectMake(0+i*W_bl, CGRectGetMaxY(self.outLabel.frame), W_bl, H_bl);
            bottomLabel.center = CGPointMake(self.outLabel.center.x, bottomLabel.center.y);
            bottomLabel.textColor = RGBCOLOR_I(152,152,152);
            btn.tag = 1001;
            [btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
            [_view addSubview:btn];
        }
        bottomLabel.text = titleArr[i];
        bottomLabel.textAlignment = NSTextAlignmentCenter;
        bottomLabel.font = kFont6px(28);
        bottomLabel.textColor = [UIColor whiteColor];
        [_view addSubview:bottomLabel];
        
        
    }
    
    CGFloat titlableYY = CGRectGetMaxY(self.integImageView.frame);
    
    NSArray *titlearr = @[@"积分价值:5积分等于一分钱",@"可以直接抵扣商品价,1元起抵哦"];
    
    for(int j =0;j<titlearr.count;j++)
    {
        UILabel *titlelable = [[UILabel alloc]initWithFrame:CGRectMake(ZOOM(20), titlableYY+ZOOM(10*3.4)+25*j, kApplicationWidth-ZOOM(20)*2, 20)];
        titlelable.text = titlearr[j];
        titlelable.textAlignment = NSTextAlignmentCenter;
        titlelable.font = [UIFont systemFontOfSize:ZOOM(45)];
        titlelable.textColor = [UIColor whiteColor];
        [_view addSubview:titlelable];
        
    }
    

}

#pragma mark - 按钮点击事件
-(void)signBtnClick
{
    //self.isSign = %d",self.isSign);
    if (!self.isSign) { //如果今天没有签到过
        [self httpSign];    //签到
    } else { //已经签到过，不能点击
        [MBProgressHUD showError:@"每天只能签到一次哦"];
        _signBtn.userInteractionEnabled  = NO;
    }
    
}
#pragma mark - 获取积分
- (void)httpGetIntegral
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *token = [ud objectForKey:USER_TOKEN];
    NSString *urlStr = [NSString stringWithFormat:@"%@wallet/getIntegral?token=%@&version=%@",[NSObject baseURLStr],token,VERSION];
    NSString *URL = [MyMD5 authkey:urlStr];

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:URL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {

//        responseObject = [NSDictionary changeType:responseObject];
        if (responseObject!=nil) {
            if ([responseObject[@"status"] intValue] == 1) {
                [self refreshUI:responseObject]; //刷新UI
            } else {
                [MBProgressHUD showError:responseObject[@"message"]];
            }
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if ([error code] == kCFURLErrorTimedOut) {
//            [[SVProgressHUD  sharedManager]showMessage:timeOutMsg];
            [MBProgressHUD showError:timeOutMsg];
        }else{
            [MBProgressHUD showError:@"网络开小差啦,请检查网络"];
        }
//        NavgationbarView *mentionview=[[NavgationbarView alloc]init];
//        [mentionview showLable:@"网络开小差啦,请检查网络" Controller:self];
    }];
    
}

#pragma mark - 刷新UI
- (void)refreshUI:(NSDictionary *)responseObject
{
    NSString *income;
    NSString *integral;
    NSString *expense;
    /*****积分****/
    if (responseObject[@"income"]!=[NSNull null]) {
        income = [NSString stringWithFormat:@"%@",responseObject[@"income"]];//积分进账
    } else {
        income = @"0";
    }
    if (responseObject[@"integral"]!=[NSNull null]) {
        integral = [NSString stringWithFormat:@"%@",responseObject[@"integral"]];//积分总额
    } else {
        integral = @"0";
    }
    if (responseObject[@"expense"]!=[NSNull null]) {
        expense = [NSString stringWithFormat:@"%@",responseObject[@"expense"]];//积分支出
    } else {
        expense = @"0";
    }
    if ([integral intValue]>0) {
//        self.integImageView.image = [UIImage imageNamed:@"总积分"];
        self.integImageView.backgroundColor = tarbarrossred;
    } else {
//        self.integImageView.image = [UIImage imageNamed:@"总积分"];
        self.integImageView.backgroundColor = tarbarrossred;
    }
    
    MyLog(@"integral =%@",integral);

    self.countLabel.text = integral;
    self.inLabel.text = income;
    self.outLabel.text = expense;
    
    /******签到*******/
    self.signDay = [responseObject[@"signDay"] intValue];
    
    MyLog(@"_signDay is %d is_sign = %d",_signDay,_isSign);
    
    [self changeRoundeBtn];
    
    //是否签到 0签到,其他未签
    if (responseObject[@"is_sign"] == [NSNull null]) {

        self.isSign = NO;
        self.signBtn.userInteractionEnabled = YES; //可以点击签到
        self.signLabel.textColor = RGBACOLOR_F(0.5,0.5,0.5,0.8);
        
    } else if ([responseObject[@"is_sign"] intValue] !=0) {

        self.isSign = NO;
        self.signBtn.userInteractionEnabled = YES; //可以点击签到
        self.signLabel.textColor = RGBACOLOR_F(0.5,0.5,0.5,0.8);
        
    } else {

        self.isSign = YES; //已经签过了
        self.signBtn.userInteractionEnabled = YES; //可以点击签到
        self.signLabel.textColor = COLOR_ROSERED;
    }
    //完成任务
//    NSArray *fulfill = responseObject[@"fulfill"];
//    NSMutableArray *ivArr = [[NSMutableArray alloc] init];
//    for (int i = 0; i<5; i++) {
//        UIImageView *iv = (UIImageView *)[self.view viewWithTag:300+i];
//        [ivArr addObject:iv];
//    }
//    NSArray *idArr = @[@1,@2,@3,@4,@5];
//    for (NSNumber *num in fulfill) {
//        
//        for (int i = 0; i<idArr.count; i++) {
//            if ([num isEqualToNumber:idArr[i]]) { //找到完成的任务
//                UIImageView *iv = ivArr[i];
//                iv.image = [UIImage imageNamed:@"积分商城选中"];
//            }
//        }
//    }
}



#pragma mark - 签到
- (void)httpSign
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *token = [ud objectForKey:USER_TOKEN];
    
    NSString *urlStr = [NSString stringWithFormat:@"%@wallet/everydaySign?token=%@&version=%@",[NSObject baseURLStr],token,VERSION];
    NSString *URL = [MyMD5 authkey:urlStr];
    //URL = %@",URL);
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:URL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {

//        responseObject = [NSDictionary changeType:responseObject];
        if (responseObject!=nil) {
            if ([responseObject[@"status"] intValue] == 1) {
                [MBProgressHUD showSuccess:@"签到成功"];
//                NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"总积分:%@",responseObject[@"integral"]]];
//                _integral.textColor = tarbarrossred;
//                NSRange redRange = NSMakeRange(0, [[noteStr string] rangeOfString:@":"].location+1);
//                [noteStr addAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor],NSFontAttributeName:[UIFont systemFontOfSize:17]} range:redRange];
//                [_integral setAttributedText:noteStr];
//                _signBtn.userInteractionEnabled = NO; //不能在点击了
//                self.countLabel.text=[NSString stringWithFormat:@"%@",responseObject[@"integral"]];
//                self.signDay = _signDay + 1;
//                [self changeRoundeBtn];
//                NSNotification *notification=[NSNotification notificationWithName:@"integral" object:responseObject[@"integral"]];
//                [[NSNotificationCenter defaultCenter] postNotification:notification];
                [self httpGetIntegral];
            } else {
                [MBProgressHUD showError:responseObject[@"message"]];
            }
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                [MBProgressHUD showError:@"网络开小差啦,请检查网络"];
        
//        NavgationbarView *nv = [[NavgationbarView alloc] init];
//        [nv showLable:@"网络开小差啦,请检查网络" Controller:self];
    }];
}

-(NSMutableArray*)myBubble_Sort:(NSMutableArray*)oldArray

{
    
//    NSMutableArray * newArray = [NSMutableArray arrayWithArray: oldArray];
    
    NSInteger num = [oldArray count];
    
    for(int i = 0 ; i < num-1 ; i++)
    {
        for(int j = i +1; j < num ; j++)
        {
            
//            int model1 = [[newArray objectAtIndex: i]intValue];
//            int model2 = [[newArray objectAtIndex: j]intValue];
            MIssionModel *model1 = [oldArray objectAtIndex:i];
            MIssionModel *model2 = [oldArray objectAtIndex:j];
            if(model1.mission_id.intValue > model2.mission_id.intValue)
            {
                MIssionModel *temp = model1;
                [oldArray replaceObjectAtIndex: i  withObject:model2];
                [oldArray replaceObjectAtIndex: j  withObject:temp];

//                [newArray replaceObjectAtIndex: i  withObject:[NSString stringWithFormat:@"%d",model2]];
//                [newArray replaceObjectAtIndex: j  withObject:[NSString stringWithFormat:@"%d",temp]];
            }
        }
    }
    //newarray %@",oldArray);
    return oldArray;
}
#pragma mark 获取任务列表请求
- (void)requestHttp
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *token = [ud objectForKey:USER_TOKEN];
    
    NSString *urlStr = [NSString stringWithFormat:@"%@wallet/getIntegral?token=%@&version=%@",[NSObject baseURLStr],token,VERSION];
    NSString *URL = [MyMD5 authkey:urlStr];
    //URL = %@",URL);
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:URL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {

//        responseObject = [NSDictionary changeType:responseObject];
        if (responseObject!=nil) {
            if ([responseObject[@"status"] intValue] == 1) {
                
                if([responseObject[@"everyDayFulfill"] count])
                {
                    _everydayIdarry = responseObject[@"everyDayFulfill"];
                }
                
                if([responseObject[@"fulfill"] count])
                {
                    _fulfillIDarray = responseObject[@"fulfill"];
                }
                
                if([responseObject[@"everyDayMission"] count])
                {
                    NSMutableArray *arr=[NSMutableArray array];
                    for(NSDictionary *dic in responseObject[@"everyDayMission"])
                    {
                        MIssionModel *model = [[MIssionModel alloc]init];
                        model.add_date = [NSString stringWithFormat:@"%@",dic[@"add_date"]];
                        model.mission_id = [NSString stringWithFormat:@"%@",dic[@"id"]];
                        model.integral_num = [NSString stringWithFormat:@"%@",dic[@"integral_num"]];
                        model.is_del = [NSString stringWithFormat:@"%@",dic[@"is_del"]];
                        model.m_mis_day = [NSString stringWithFormat:@"%@",dic[@"m_mis_day"]];
                        model.m_name = [NSString stringWithFormat:@"%@",dic[@"m_name"]];
                        model.m_type = [NSString stringWithFormat:@"%@",dic[@"m_type"]];
                        
                        [arr addObject:model];
                    }
                    _DayDataArray = [NSMutableArray arrayWithArray:[self myBubble_Sort:arr]];
//                    //%@",[self myBubble_Sort:@[@"10",@"8",@"8",@"6",@"7",@"3",@"5",@"2"]]);
                }
                
                
                
                if([responseObject[@"mission"] count]){
                    NSMutableArray *arr=[NSMutableArray array];
                    for(NSDictionary *dic in responseObject[@"mission"])
                    {
                        
                        
                        MIssionModel *model = [[MIssionModel alloc]init];
                        model.add_date = [NSString stringWithFormat:@"%@",dic[@"add_date"]];
                        model.mission_id = [NSString stringWithFormat:@"%@",dic[@"id"]];
                        model.integral_num = [NSString stringWithFormat:@"%@",dic[@"integral_num"]];
                        model.is_del = [NSString stringWithFormat:@"%@",dic[@"is_del"]];
                        model.m_mis_day = [NSString stringWithFormat:@"%@",dic[@"m_mis_day"]];
                        model.m_name = [NSString stringWithFormat:@"%@",dic[@"m_name"]];
                        model.m_type = [NSString stringWithFormat:@"%@",dic[@"m_type"]];
                        
                        
                        if (![_fulfillIDarray containsObject:model.mission_id]) {
                            [arr addObject:model];
                        }
                    }
                    _NewDataArray = [NSMutableArray arrayWithArray:[self myBubble_Sort:arr]];
                }
                
                _typeCount = (int)_NewDataArray.count/2 +_NewDataArray.count%2;
                
                MyLog(@"_typeCount is %d",_typeCount);
                
                MyLog(@"_DayDataArray is %@ *****%@ everyDayFulfill=%@",_DayDataArray,_NewDataArray,_everydayIdarry);
                
                _MytableView.tableFooterView = [self creatBestSeller];

                [_MytableView reloadData];
                
            } else {
                
                [MBProgressHUD showError:responseObject[@"message"]];
            }
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MBProgressHUD showError:@"网络开小差啦,请检查网络"];
//        NavgationbarView *nv = [[NavgationbarView alloc] init];
//        [nv showLable:@"网络开小差啦,请检查网络" Controller:self];
    }];

}

/*********  改变签到天数   *********/
-(void)changeRoundeBtn
{
//    UIView *view = [_MytableView.tableHeaderView viewWithTag:1000];
    
    for (int i=0; i<_signDay; i++) {
        UIButton *btn =(UIButton *)[_view viewWithTag:i+100];
        btn.selected = YES;
        btn.backgroundColor = tarbarrossred;
    }
}

- (NSInteger)numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 70;
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headview = [[UIView alloc]initWithFrame:CGRectMake(0, 5, 120, 70)];
    headview.backgroundColor = [UIColor whiteColor];
    
    UIImageView * headimage = [[UIImageView alloc]initWithFrame:CGRectMake(ZOOM(50), 8, 60*2.54, 60)];
    headimage.image = [UIImage imageNamed:@"每日任务"];
    
    [headview addSubview:headimage];
    
    return headview;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _DayDataArray.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MIssionModel *model = _DayDataArray[indexPath.row];
    int idstr = model.mission_id.intValue;
    
    MyLog(@"model.mission_id is %@",model.mission_id);
    
    _public_mis_id = model.mission_id;
    _public_jifen = model.integral_num;
    
    for(NSString *finishid in _everydayIdarry)
    {
        MyLog(@"finishid is %@",finishid);

        if([finishid isEqualToString:model.mission_id])
        {
            NavgationbarView *nv = [[NavgationbarView alloc] init];
            [nv showLable:@"此任务已经完成" Controller:self];
            
            return;
        }
       
    }
    
    [self gomission:idstr];
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier=@"miCell";
    MisionTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
    if(!cell)
    {
        cell=[[MisionTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    MIssionModel *model = _DayDataArray[indexPath.row];
    
    cell.cornerimage.clipsToBounds = YES;
    cell.cornerimage.hidden = NO;
    cell.cornerimage.layer.cornerRadius = cell.cornerimage.frame.size.width/2;
    cell.cornerimage.image = [UIImage imageNamed:@"红点"];
    cell.minimage.image = [UIImage imageNamed:@"箭头1"];
    
    if(_everydayIdarry.count)
    {
        for(NSString *finishid in _everydayIdarry)
        {
            if([finishid isEqualToString:model.mission_id])
            {
                cell.cornerimage.hidden=YES;
                cell.minimage.image = [UIImage imageNamed:@"已完成_笑脸"];
            }
        }
    }
    
    BOOL result = [self isBetweenFromHour:7 toHour:14];
    if([model.m_name hasPrefix:@"上午分享美衣到朋友圈"]&&result==NO){
        cell.cornerimage.hidden=YES;
    }
    if([model.m_name hasPrefix:@"下午分享美衣到朋友圈"]&&result==YES){
        cell.cornerimage.hidden=YES;
    }
    

    cell.titlelable.frame=CGRectMake(cell.titlelable.frame.origin.x, cell.titlelable.frame.origin.y,kScreenWidth-150, cell.titlelable.frame.size.height);
    
    cell.headimage.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",model.m_name]];
    
    if([model.m_name hasPrefix:@"挑选5款商品"])
    {
        cell.headimage.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",@"挑选5款商品加心加店铺"]];
    }
    
    
    cell.titlelable.text = [NSString stringWithFormat:@"%@",model.m_name];
    cell.titlelable.font = [UIFont systemFontOfSize:ZOOM(40)];
    
    cell.contentlable.frame = CGRectMake(cell.contentlable.frame.origin.x, cell.contentlable.frame.origin.y, ZOOM(60*3.4), cell.contentlable.frame.size.height);
    cell.contentlable.clipsToBounds = YES;
    cell.contentlable.text = [NSString stringWithFormat:@"+%@积分",model.integral_num];
    cell.contentlable.layer.cornerRadius = cell.contentlable.frame.size.height/2;
    cell.contentlable.textAlignment = NSTextAlignmentCenter;
    cell.contentlable.textColor = [UIColor whiteColor];
    cell.contentlable.font = [UIFont systemFontOfSize:ZOOM(35)];
    
    cell.contentlable.backgroundColor = [self ColorID7:model.mission_id.intValue];
    
    return cell;
}

#pragma mark 收入、支出积分
- (void)click:(UIButton *)sender
{
    HYJIntelgralDetalViewController *vc = [[HYJIntelgralDetalViewController alloc] init];
    vc.index = sender.tag-1000;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark 新手任务
- (UIView*)creatBestSeller
{
    
    CGFloat width = (kApplicationWidth - 60)/2;
//    CGFloat heigh = ZOOM(350);
    CGFloat heigh = width;

    
    MyLog(@"%d",_typeCount);
    
    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 10, kApplicationWidth, heigh*_typeCount+60)];
    backView.tag = 55555;
    
    UIImageView *headimage = [[UIImageView alloc]initWithFrame:CGRectMake(ZOOM(60), 5, 45*3.3, 45)];
    headimage.image = [UIImage imageNamed:@"新手任务"];
    [backView addSubview:headimage];
    
    int xxxx=0;
    int yyyy=0;
    
    for(int i=0;i<_NewDataArray.count;i++)
    {
        
        xxxx = i%2;
        yyyy = i/2;
        
        MIssionModel *model = _NewDataArray[i];
        
        //底视图
        UIView *baseview = [[UIView alloc]initWithFrame:CGRectMake(20+(width+20)*xxxx, 60+(heigh)*yyyy, width, heigh)];
        baseview.tag = 50000+i;
        baseview.userInteractionEnabled = YES;
        [backView addSubview:baseview];
    
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(sellerImageClick:)];
        [baseview addGestureRecognizer:tap];
        
        MyLog(@"model.m_name is %@",model.m_name);
        //小图片
        UIImageView *titltimage = [[UIImageView alloc]initWithFrame:CGRectMake((width-ZOOM(30*3.4))/2, ZOOM(76), ZOOM(30*3.4), ZOOM(30*3.4))];
        titltimage.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",model.m_name]];
        titltimage.contentMode=UIViewContentModeScaleAspectFit;
        [baseview addSubview:titltimage];
        
        MIssionModel *newmodel = [[MIssionModel alloc]init];
        newmodel = _NewDataArray[i];
        
        if([newmodel.m_name isEqualToString:@"首次更新我的店点名"])
        {
            newmodel.m_name = @"首次更新我的店名";
        }
        
        //内容
        CGFloat titlelabeY = CGRectGetMaxY(titltimage.frame);
        
        UILabel *titlelable = [[UILabel alloc]initWithFrame:CGRectMake(0, titlelabeY+10, width, ZOOM(35*3.4))];
        titlelable.numberOfLines = 0;
        titlelable.text = [NSString stringWithFormat:@"%@",newmodel.m_name];
        titlelable.textAlignment = NSTextAlignmentCenter;
        titlelable.font = [UIFont systemFontOfSize:ZOOM(40)];
        [baseview addSubview:titlelable];
        
        //副内容
        CGFloat detaillableY = CGRectGetMaxY(titlelable.frame);
        
        UILabel *detaillable = [[UILabel alloc]initWithFrame:CGRectMake(20, detaillableY+5, width-40, 20)];
        detaillable.text = [NSString stringWithFormat:@"奖励:%@积分",newmodel.integral_num];
        detaillable.textAlignment = NSTextAlignmentCenter;
        detaillable.textColor = tarbarrossred;
        detaillable.font = [UIFont systemFontOfSize:ZOOM(30)];
        [baseview addSubview:detaillable];
        
        
        //角标
        UIImageView *cornetimage =[[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(titltimage.frame)-ZOOM(20), ZOOM(50), 15, 15)];
        cornetimage.image = [UIImage imageNamed:@"红点"];
        cornetimage.layer.cornerRadius = cornetimage.frame.size.width/2;
        cornetimage.tag =9000+i;
        for(NSString *strid in _fulfillIDarray)
        {
            if([strid isEqualToString:model.mission_id])
            {
                cornetimage.hidden = YES;
            }
        }
        
        [baseview addSubview:cornetimage];

    }
    
    for(int j =0;j<_typeCount+1;j++)
    {
        UILabel *linelable = [[UILabel alloc]initWithFrame:CGRectMake(20, 60+heigh*j, kApplicationWidth-40, 0.5)];
        linelable.backgroundColor = kBackgroundColor;
        [backView addSubview:linelable];
 
    }
    
    UILabel *lableline = [[UILabel alloc]initWithFrame:CGRectMake(kApplicationWidth/2, 60, 0.5, backView.frame.size.height-60)];
    lableline.backgroundColor = kBackgroundColor;
    [backView addSubview:lableline];
    
    return backView;
}

#pragma mark 完成喜好通知
- (void)hobbysuccess:(NSNotification*)note
{
    UIImageView *cornerimage = (UIImageView*)[self.view viewWithTag:9009];
    cornerimage.hidden = YES;
    
    [self requestHttp];
}


- (void)back:(UIButton*)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark 加心任务
-(void)shoppinggo
{
    // 跳转到衣服
    Mtarbar.selectedIndex=0;
  
    [self.navigationController popToRootViewControllerAnimated:NO];
    
}

#pragma mark 购买0元购商品
-(void)zeroShoppinggo
{
    MyLog(@"0元购");
    Mtarbar.selectedIndex=3;
    
    [self.navigationController popToRootViewControllerAnimated:NO];

}
#pragma mark 上午，下午分享美衣任务
- (void)httpGetRandShop
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *token = [ud objectForKey:USER_TOKEN];
    NSString *realm = [ud objectForKey:USER_ID];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    NSString *urlStr = [NSString stringWithFormat:@"%@shop/shareShop?token=%@&version=%@&realm=%@",[NSObject baseURLStr], token,VERSION, realm];
    NSString *URL = [MyMD5 authkey:urlStr];
    
    [manager GET:URL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //
        //分享商品 = %@", responseObject);
        NSDictionary *dic = responseObject[@"shop"];
        
        if(dic != NULL)
        {
            NSUserDefaults *userdefaul=[NSUserDefaults standardUserDefaults];
            
            NSArray *imageArray = [dic[@"four_pic"] componentsSeparatedByString:@","];
            
        
            NSString *imgstr;
            if(imageArray.count > 2)
            {
                imgstr = imageArray[2];
                
            }else if (imageArray.count > 0)
            {
                imgstr = imageArray[0];
            }
            
            [userdefaul setObject:[NSString stringWithFormat:@"%@",imgstr] forKey:SHOP_PIC];
            
            [userdefaul setObject:[NSString stringWithFormat:@"%@",dic[@"content"]] forKey:SHOP_TITLE];
            
            [userdefaul setObject:[NSString stringWithFormat:@"%@",responseObject[@"link"]] forKey:SHOP_LINK];
            
            [userdefaul setObject:[NSString stringWithFormat:@"%@",responseObject[@"QrLink"]] forKey:QR_LINK];
            
            [userdefaul setObject:dic[@"shop_se_price"] forKey:SHOP_PRICE];
            
            //配置分享平台信息
            AppDelegate *app=(AppDelegate *)[[UIApplication sharedApplication] delegate];
            [app shardk];
            
            [[DShareManager share] shareAppWithType:ShareTypeWeixiTimeline View:nil Image:nil WithShareType:@"myNewSign"];
            
        } else{
            NavgationbarView *nv = [[NavgationbarView alloc] init];
            [nv showLable:@"获取数据失败，稍后重试" Controller:self];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NavgationbarView *nv = [[NavgationbarView alloc] init];
        [nv showLable:@"网络开小差啦,请检查网络" Controller:self];
    }];
    
}

-(void)jifenHttp
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *token = [ud objectForKey:USER_TOKEN];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    NSString *urlStr = [NSString stringWithFormat:@"%@mission/doMission?token=%@&version=%@&m_id=%@",[NSObject baseURLStr], token,VERSION, _public_mis_id];
    NSString *URL = [MyMD5 authkey:urlStr];
    
    [manager GET:URL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
      //分享商品 = %@", responseObject);
        
        NSString *str = responseObject[@"status"];
        if(str.intValue == 1)
        {
            NavgationbarView *nv = [[NavgationbarView alloc] init];
            [nv showLable:[NSString stringWithFormat:@"任务完成,恭喜获得%@积分",_public_jifen] Controller:self];
        }else{
            NavgationbarView *nv = [[NavgationbarView alloc] init];
            [nv showLable:@"任务完成失败" Controller:self];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NavgationbarView *nv = [[NavgationbarView alloc] init];
        [nv showLable:@"网络开小差啦,请检查网络" Controller:self];
    }];

}

#pragma mark 监听是否分享成功
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    
    if ([keyPath isEqualToString:@"myNewSign"]) {
        //value = %@", change[@"new"]);
        
        NSNumber *st = change[@"new"];
        
        if ([st intValue ]== 1) {//分享成功
            
            [self jifenHttp];
            
        }
                
    }
}

#pragma mark 判断某个时间是否在7~14点
- (BOOL)isBetweenFromHour:(NSInteger)fromHour toHour:(NSInteger)toHour
{
    NSDate *date7 = [self getCustomDateWithHour:7];
    NSDate *date14 = [self getCustomDateWithHour:14];
    
    NSDate *currentDate = [NSDate date];
    
    if ([currentDate compare:date7]==NSOrderedDescending && [currentDate compare:date14]==NSOrderedAscending)
    {
        //该时间在 %d:00-%d:00 之间！", fromHour, toHour);
        return YES;
    }
    return NO;
}

/**
 * @brief 生成当天的某个点（返回的是伦敦时间，可直接与当前时间[NSDate date]比较）
 * @param hour 如hour为“8”，就是上午8:00（本地时间）
 */
- (NSDate *)getCustomDateWithHour:(NSInteger)hour
{
    //获取当前时间
    NSDate *currentDate = [NSDate date];
    NSCalendar *currentCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *currentComps = [[NSDateComponents alloc] init];
    
    NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    
    currentComps = [currentCalendar components:unitFlags fromDate:currentDate];
    
    //设置当天的某个点
    NSDateComponents *resultComps = [[NSDateComponents alloc] init];
    [resultComps setYear:[currentComps year]];
    [resultComps setMonth:[currentComps month]];
    [resultComps setDay:[currentComps day]];
    [resultComps setHour:hour];
    
    NSCalendar *resultCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    return [resultCalendar dateFromComponents:resultComps];
}

- (void)dealloc
{
    if (self.isRegisterKVO) {
        [gKVO removeObserver:self forKeyPath:@"myNewSign"];
        self.isRegisterKVO = NO;
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}
#pragma mark //任务副标题颜色
- (UIColor*)ColorID7:(int)idstr
{
    UIColor *color;
    
    switch (idstr) {
        case 7://上午分享美衣到朋友圈
            
            color= [UIColor colorWithRed:255/255.0 green:220/255.0 blue:101/255.0 alpha:1.0];

            break;
        case 8://下午分享美衣到朋友圈
            color= [UIColor colorWithRed:255/255.0 green:203/255.0 blue:166/255.0 alpha:1.0];
            
            break;
        case 9://挑选5款商品加心加店铺
            color= [UIColor colorWithRed:120/255.0 green:194/255.0 blue:247/255.0 alpha:1.0];            break;
        case 10://购买0元购商品并分享
            color= [UIColor colorWithRed:157/255.0 green:135/255.0 blue:212/255.0 alpha:1.0];
            break;
        case 11://购买一件自己心仪的美衣
            color= [UIColor colorWithRed:243/255.0 green:133/255.0 blue:203/255.0 alpha:1.0];
            break;
        case 12://更换店铺模板并分享
            color= [UIColor colorWithRed:255/255.0 green:196/255.0 blue:202/255.0 alpha:1.0];
            break;
        case 13://发布新的店铺公告并分享
            color= [UIColor colorWithRed:117/255.0 green:211/255.0 blue:231/255.0 alpha:1.0];
            break;
        case 14://更新店铺轮播图商品并分享
            color= [UIColor colorWithRed:255/255.0 green:186/255.0 blue:97/255.0 alpha:1.0];
            break;
        case 15://更新店铺店主最爱并分享
            color= [UIColor colorWithRed:207/255.0 green:171/255.0 blue:255/255.0 alpha:1.0];
            break;
        case 16://分享我的小店到朋友圈
            color= [UIColor colorWithRed:255/255.0 green:113/255.0 blue:70/255.0 alpha:1.0];
            break;
            
        default:
            break;
            
    }
    
    return color;
}


#pragma mark - ******************新手流程点击******************
- (void)sellerImageClick:(UITapGestureRecognizer*)tap
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    
    NSString *token = [ud objectForKey:USER_TOKEN];
    NSString *hobby = [ud objectForKey:USER_HOBBY];
    
    if (token!=nil) {
        int tag = tap.view.tag%50000;
        MyLog(@"tag is %d",tag);
        
        MIssionModel *model = _NewDataArray[tag];
        int missionID = [model.mission_id intValue];
        
        for(NSString *strid in _fulfillIDarray)
        {
            if([strid isEqualToString:model.mission_id])
            {
                NavgationbarView *nv = [[NavgationbarView alloc] init];
                [nv showLable:@"此任务已经完成" Controller:self];
                
                return;
            }
        }
        
        //完成喜好通知而来
        UIImageView *cornerimage = (UIImageView*)[self.view viewWithTag:9009];
        
        if(cornerimage.hidden == YES && tap.view.tag == 50009){
            MyLog(@"cornerimage = %@",cornerimage);
            
            NavgationbarView *nv = [[NavgationbarView alloc] init];
            [nv showLable:@"此任务已经完成" Controller:self];
            
            return;
 
        }

        //id = %d", missionID);
        
        
        switch (missionID) {
            case 17://开通我的小店
            {
                if (hobby.length==0) {
                    
                    NSMutableArray *viewControllerArr = [NSMutableArray arrayWithArray:Mtarbar.viewControllers];

                    UINavigationController *tfnc = (UINavigationController *)[viewControllerArr firstObject];
                    TFHomeViewController *tfhmVC = (TFHomeViewController *)[tfnc.viewControllers firstObject];
                    tfhmVC.isFormMyIntegral = YES;
                    tfhmVC.fromType = IntegralTaskGoShop;
                    
                    [self.navigationController popToRootViewControllerAnimated:NO];
                    Mtarbar.selectedIndex = 0;
                }
            }
                break;
            case 18:    //首次分享美衣到朋友圈
            {
                [self httpGetRandShopWithType:NoviciateTask_Seven_Eight];
            }
                
                break;
            case 19:    //首次更换店铺模板 (++++++)
            {
                
                NSMutableArray *viewControllerArr = [NSMutableArray arrayWithArray:Mtarbar.viewControllers];
                
                UINavigationController *tfnc = (UINavigationController *)[viewControllerArr firstObject];
                TFHomeViewController *tfhmVC = (TFHomeViewController *)[tfnc.viewControllers firstObject];
                tfhmVC.type = NoviciateTaskMonday;
                tfhmVC.isFormMyIntegral = YES;
                tfhmVC.fromType = IntegralTaskGoShop;
                
                [self.navigationController popToRootViewControllerAnimated:NO];
                Mtarbar.selectedIndex = 0;

            }
                break;
            case 20:    //首次更新我的店点名
            {
                
                NSMutableArray *viewControllerArr = [NSMutableArray arrayWithArray:Mtarbar.viewControllers];
                UINavigationController *tfnc = (UINavigationController *)[viewControllerArr firstObject];
                TFHomeViewController *tfhmVC = (TFHomeViewController *)[tfnc.viewControllers firstObject];
                tfhmVC.type = @"changeShopName";
                tfhmVC.isFormMyIntegral = YES;
                tfhmVC.fromType = IntegralTaskGoShop;

                [self.navigationController popToRootViewControllerAnimated:NO];
                Mtarbar.selectedIndex = 0;
            }
                
                break;
            case 21:    //首次更换店铺头像
                
            {
                
                NSMutableArray *viewControllerArr = [NSMutableArray arrayWithArray:Mtarbar.viewControllers];
                UINavigationController *tfnc = (UINavigationController *)[viewControllerArr firstObject];
                TFHomeViewController *tfhmVC = (TFHomeViewController *)[tfnc.viewControllers firstObject];
                tfhmVC.type = @"changeShopHeadImage";
                tfhmVC.isFormMyIntegral = YES;
                tfhmVC.fromType = IntegralTaskGoShop;

                [self.navigationController popToRootViewControllerAnimated:NO];
                Mtarbar.selectedIndex = 0;
            }
                
                break;
            case 22://首次发布公告并分享到朋友圈 (++++++)
                
            {
                
                NSMutableArray *viewControllerArr = [NSMutableArray arrayWithArray:Mtarbar.viewControllers];
                UINavigationController *tfnc = (UINavigationController *)[viewControllerArr firstObject];
                TFHomeViewController *tfhmVC = (TFHomeViewController *)[tfnc.viewControllers firstObject];
                tfhmVC.type = NoviciateTaskTuesday;
                tfhmVC.isFormMyIntegral = YES;
                tfhmVC.fromType = IntegralTaskGoShop;

                [self.navigationController popToRootViewControllerAnimated:NO];
                Mtarbar.selectedIndex = 0;

            }
                
                break;
            case 23://店铺首次更换轮播图商品并分享到朋友圈 (++++++)
                
            {
                
                NSMutableArray *viewControllerArr = [NSMutableArray arrayWithArray:Mtarbar.viewControllers];
                UINavigationController *tfnc = (UINavigationController *)[viewControllerArr firstObject];
                TFHomeViewController *tfhmVC = (TFHomeViewController *)[tfnc.viewControllers firstObject];
                tfhmVC.type = NoviciateTaskWednesday;
                tfhmVC.isFormMyIntegral = YES;
                tfhmVC.fromType = IntegralTaskGoShop;

                [self.navigationController popToRootViewControllerAnimated:NO];
                Mtarbar.selectedIndex = 0;

            }
                
                break;
            case 24://店铺首次更换店主最爱商品并分享到朋友圈 (++++++)
                
            {
                
                NSMutableArray *viewControllerArr = [NSMutableArray arrayWithArray:Mtarbar.viewControllers];
                UINavigationController *tfnc = (UINavigationController *)[viewControllerArr firstObject];
                TFHomeViewController *tfhmVC = (TFHomeViewController *)[tfnc.viewControllers firstObject];
                tfhmVC.type = NoviciateTaskThursday;
                tfhmVC.isFormMyIntegral = YES;
                tfhmVC.fromType = IntegralTaskGoShop;
                
                [self.navigationController popToRootViewControllerAnimated:NO];
                Mtarbar.selectedIndex = 0;

            }
                
                break;
            case 25://首次购买正价商品
                
            {
                [self.navigationController popToRootViewControllerAnimated:NO];
                Mtarbar.selectedIndex = 0;
            }
                
                break;
            case 26://完成喜好
            {
                
                if (hobby.length==0) {
                    
                    NSMutableArray *viewControllerArr = [NSMutableArray arrayWithArray:Mtarbar.viewControllers];
                    
                    UINavigationController *tfnc = (UINavigationController *)[viewControllerArr firstObject];
                    TFHomeViewController *tfhmVC = (TFHomeViewController *)[tfnc.viewControllers firstObject];
                    tfhmVC.isFormMyIntegral = YES;
                    tfhmVC.fromType = IntegralTaskGoShop;
                    
                    [self.navigationController popToRootViewControllerAnimated:NO];
                    Mtarbar.selectedIndex = 0;
                    
                }else{
                
                    SubmitViewController *sbVC = [[SubmitViewController alloc] init];
                    sbVC.typestring = @"完善喜好";
                    sbVC.hidesBottomBarWhenPushed = YES;
                    sbVC.delegate = self;
                    [self.navigationController pushViewController:sbVC animated:YES];
                
                }

               
            }
                
            default:
                break;
        }
        
    }
    
}

#pragma mark - ******************每日任务点击******************
- (void)gomission:(int)idstr
{
    BOOL result = [self isBetweenFromHour:7 toHour:14];
    
    NSUserDefaults *userdefaul = [NSUserDefaults standardUserDefaults];
    NSString *hobby = [userdefaul objectForKey:USER_HOBBY];
    
    //id = %d", idstr);
    
    
    switch (idstr) {
        case 7://上午分享美衣到朋友圈
            if(result == YES)
            {
                [self httpGetRandShopWithType:DailyTaskMorningShare];
            } else{
                NavgationbarView *nv = [[NavgationbarView alloc] init];
                [nv showLable:@"任务已过期，明天再来吧" Controller:self];
            }
            
            break;
        case 8://下午分享美衣到朋友圈
            
            if(result == NO)
            {
                [self httpGetRandShopWithType:DailyTaskAfternoonShare];
            }else{
                NavgationbarView *nv = [[NavgationbarView alloc] init];
                [nv showLable:@"任务时间没到，下午再来吧" Controller:self];
            }
            
            break;
        case 9://挑选5款商品加心加店铺
            [self shoppinggo];
            break;
        case 10://购买0元购商品并分享
            [self zeroShoppinggo];
            break;
        case 11://购买一件自己心仪的美衣
            [self shoppinggo];
            break;
        case 12://更换店铺模板并分享
            {
                
                NSMutableArray *viewControllerArr = [NSMutableArray arrayWithArray:Mtarbar.viewControllers];
                UINavigationController *tfnc = (UINavigationController *)[viewControllerArr firstObject];
                TFHomeViewController *tfhmVC = (TFHomeViewController *)[tfnc.viewControllers firstObject];
                tfhmVC.type = DailyTaskMonday;
                tfhmVC.isFormMyIntegral = YES;
                tfhmVC.fromType = IntegralTaskGoShop;
                
                [self.navigationController popToRootViewControllerAnimated:NO];
                Mtarbar.selectedIndex = 0;

            }
            
            
            
            break;
        case 13://发布新的店铺公告并分享
            
            {
                
                NSMutableArray *viewControllerArr = [NSMutableArray arrayWithArray:Mtarbar.viewControllers];
                UINavigationController *tfnc = (UINavigationController *)[viewControllerArr firstObject];
                TFHomeViewController *tfhmVC = (TFHomeViewController *)[tfnc.viewControllers firstObject];
                tfhmVC.type = DailyTaskTuesday;
                tfhmVC.isFormMyIntegral = YES;
                tfhmVC.fromType = IntegralTaskGoShop;
                
                [self.navigationController popToRootViewControllerAnimated:NO];
                
                Mtarbar.selectedIndex = 0;
            }
            
            break;
        case 14://更新店铺轮播图商品并分享
            
            {
                
                NSMutableArray *viewControllerArr = [NSMutableArray arrayWithArray:Mtarbar.viewControllers];
                UINavigationController *tfnc = (UINavigationController *)[viewControllerArr firstObject];
                TFHomeViewController *tfhmVC = (TFHomeViewController *)[tfnc.viewControllers firstObject];
                tfhmVC.type = DailyTaskWednesday;
                tfhmVC.isFormMyIntegral = YES;
                tfhmVC.fromType = IntegralTaskGoShop;
                
                [self.navigationController popToRootViewControllerAnimated:NO];
                Mtarbar.selectedIndex = 0;
            }
            
            break;
        case 15://更新店铺店主最爱并分享
            {
                
                NSMutableArray *viewControllerArr = [NSMutableArray arrayWithArray:Mtarbar.viewControllers];
                UINavigationController *tfnc = (UINavigationController *)[viewControllerArr firstObject];
                TFHomeViewController *tfhmVC = (TFHomeViewController *)[tfnc.viewControllers firstObject];
                tfhmVC.type = DailyTaskThursday;
                tfhmVC.isFormMyIntegral = YES;
                tfhmVC.fromType = IntegralTaskGoShop;

                [self.navigationController popToRootViewControllerAnimated:NO];
                Mtarbar.selectedIndex = 0;
            }
            
            break;
        case 16://分享我的小店到朋友圈
            {
                if(hobby.length > 10)//已经开店
                {
                    [self shareStoreToWeiXin];
                }else{
                     Mtarbar.selectedIndex = 0;
                }
            }
            break;
            
        default:
            break;
            
    }
    
}

- (void)shareStoreToWeiXin
{
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"weixin://"]]) {
        AppDelegate *appDelegate=(AppDelegate *)[[UIApplication sharedApplication] delegate];
        [appDelegate shardk];
        
        NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
        NSString *realm = [NSString stringWithFormat:@"%@",[ud objectForKey:USER_REALM]];
        //	NSString *token = [NSString stringWithFormat:@"%@",[ud objectForKey:USER_TOKEN]];
        
        
        NSString *link = [NSString stringWithFormat:@"%@view/store/index.html?realm=%@", [NSObject baseH5ShareURLStr], realm];
        
        //link = %@", link);
        
        DShareManager *ds = [DShareManager share];
        ds.delegate = self;
        
        NSString *name = [ud objectForKey:STORE_NAME];
        NSString *title = [NSString stringWithFormat:@"%@-姐妹们的美丽小屋~",name];
        NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"is_match" ofType:@"png"];
        
        //何波加的 2016-9-18
        int i = arc4random()%ds.ShareTitleArray.count;
        NSString *sharetitle = ds.ShareTitleArray[i];
        title = sharetitle;
        
        [ds shareAppWithType:ShareTypeWeixiTimeline withLinkShareType:DailyTaskFriday withLink:link andImagePath:imagePath andTitle:title andContent:nil];

    } else {
        NavgationbarView *nv = [[NavgationbarView alloc] init];
        [nv showLable:@"请安装微信,再分享" Controller:self];
    }
    
    
    }

#pragma mark ren成功后
-(void)httpShareSuccessWithType:(NSString *)type
{
    NavgationbarView *nv = [[NavgationbarView alloc] init];
    
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *paraments=[NSMutableDictionary dictionary];
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    //	NSString *realm = [NSString stringWithFormat:@"%@",[ud objectForKey:USER_REALM]];
    NSString *token = [NSString stringWithFormat:@"%@",[ud objectForKey:USER_TOKEN]];
    
    NSString *urlStr;
    if ([type isEqualToString:DailyTaskMorningShare]) {
        urlStr = [NSString stringWithFormat:@"%@mission/doMission?version=%@&token=%@&m_id=7",[NSObject baseURLStr], VERSION,token];
    } else if ([type isEqualToString:DailyTaskAfternoonShare]) {
        urlStr = [NSString stringWithFormat:@"%@mission/doMission?version=%@&token=%@&m_id=8",[NSObject baseURLStr], VERSION,token];
    }
    else if ([type isEqualToString:DailyTaskMonday]) {
        urlStr = [NSString stringWithFormat:@"%@mission/doMission?version=%@&token=%@&m_id=12",[NSObject baseURLStr], VERSION,token];
    } else if ([type isEqualToString:DailyTaskTuesday]) {
        urlStr = [NSString stringWithFormat:@"%@mission/doMission?version=%@&token=%@&m_id=13",[NSObject baseURLStr], VERSION,token];
    } else if ([type isEqualToString:DailyTaskWednesday]) {
        urlStr = [NSString stringWithFormat:@"%@mission/doMission?version=%@&token=%@&m_id=14",[NSObject baseURLStr], VERSION,token];
    } else if ([type isEqualToString:DailyTaskThursday]) {
        urlStr = [NSString stringWithFormat:@"%@mission/doMission?version=%@&token=%@&m_id=15",[NSObject baseURLStr], VERSION,token];
    } else if ([type isEqualToString:DailyTaskFriday]) {
        urlStr = [NSString stringWithFormat:@"%@mission/doMission?version=%@&token=%@&m_id=16",[NSObject baseURLStr], VERSION,token];
    } else if ([type isEqualToString:NoviciateTask_Seven_Eight]) {
        urlStr = [NSString stringWithFormat:@"%@mission/doMission?version=%@&token=%@&m_id=18",[NSObject baseURLStr], VERSION,token];
    }
    
    NSString *URL=[MyMD5 authkey:urlStr];
    
    
    [manager POST:URL parameters:paraments success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        //分享调用接口 res = %@",responseObject);
//        responseObject = [NSDictionary changeType:responseObject];
        if (responseObject!=nil) {
            
            if ([responseObject[@"status"] intValue] == 1) {
                if ([type isEqualToString:DailyTaskMorningShare]) {
                    
                    int flag = [responseObject[@"flag"] intValue];
                    int num = [responseObject[@"num"] intValue];
                    
                    int newFlag = [responseObject[@"newFlag"] intValue];
                    int newNum = [responseObject[@"newNum"] intValue];
                    
                    if (flag == 0) {
                        [nv showLable:[NSString stringWithFormat:@"任务完成,恭喜获得%d积分", num] Controller:self];
                    }
                    
                    NSDictionary *currDic = [NSDictionary dictionaryWithObjectsAndKeys:[MyMD5 getCurrTimeString:@"year-month-day"], @"year-month-day", nil];
                    
                    [ud setObject:currDic forKey:[NSString stringWithFormat:@"%@%@",[ud objectForKey:USER_ID],DailyTaskMorningShare]];
                    [ud setObject:currDic forKey:[NSString stringWithFormat:@"%@%@",[ud objectForKey:USER_ID],DailyTaskAfternoonShare]];
                    
                    [ud synchronize];
                    
                } else if ([type isEqualToString:DailyTaskAfternoonShare]) {
                    
                    int flag = [responseObject[@"flag"] intValue];
                    int num = [responseObject[@"num"] intValue];
                    
                    int newFlag = [responseObject[@"newFlag"] intValue];
                    int newNum = [responseObject[@"newNum"] intValue];
                    
                    if (flag == 0) {
                        [nv showLable:[NSString stringWithFormat:@"任务完成,恭喜获得%d积分", num] Controller:self];
                    }
                    
                    NSDictionary *currDic = [NSDictionary dictionaryWithObjectsAndKeys:[MyMD5 getCurrTimeString:@"year-month-day"], @"year-month-day", nil];
                    
                    [ud setObject:currDic forKey:[NSString stringWithFormat:@"%@%@",[ud objectForKey:USER_ID],DailyTaskMorningShare]];
                    [ud setObject:currDic forKey:[NSString stringWithFormat:@"%@%@",[ud objectForKey:USER_ID],DailyTaskAfternoonShare]];
                    
                    [ud synchronize];
                    
                    
                }
                
                if ([type isEqualToString:DailyTaskMonday]) {
                    int flag = [responseObject[@"flag"] intValue];
                    int num = [responseObject[@"num"] intValue];
                    
                    int newFlag = [responseObject[@"newFlag"] intValue];
                    int newNum = [responseObject[@"newNum"] intValue];
                    
                    if (flag == 0) {
                        [nv showLable:[NSString stringWithFormat:@"任务完成,恭喜获得%d积分", num] Controller:self];
                    }
                } else if ([type isEqualToString:DailyTaskTuesday]) {
                    int flag = [responseObject[@"flag"] intValue];
                    int num = [responseObject[@"num"] intValue];
                    
                    int newFlag = [responseObject[@"newFlag"] intValue];
                    int newNum = [responseObject[@"newNum"] intValue];
                    
                    if (flag == 0) {
                        [nv showLable:[NSString stringWithFormat:@"任务完成,恭喜获得%d积分", num] Controller:self];
                    }
                } else if ([type isEqualToString:DailyTaskWednesday]) {
                    int flag = [responseObject[@"flag"] intValue];
                    int num = [responseObject[@"num"] intValue];
                    
                    int newFlag = [responseObject[@"newFlag"] intValue];
                    int newNum = [responseObject[@"newNum"] intValue];
                    
                    if (flag == 0) {
                        [nv showLable:[NSString stringWithFormat:@"任务完成,恭喜获得%d积分", num] Controller:self];
                    }
                } else if ([type isEqualToString:DailyTaskThursday]) {
                    int flag = [responseObject[@"flag"] intValue];
                    int num = [responseObject[@"num"] intValue];
                    
                    int newFlag = [responseObject[@"newFlag"] intValue];
                    int newNum = [responseObject[@"newNum"] intValue];
                    
                    if (flag == 0) {
                        [nv showLable:[NSString stringWithFormat:@"任务完成,恭喜获得%d积分", num] Controller:self];
                    }
                } else if ([type isEqualToString:DailyTaskFriday]) {
                    
                    int flag = [responseObject[@"flag"] intValue];
                    int num = [responseObject[@"num"] intValue];
                    
                    int newFlag = [responseObject[@"newFlag"] intValue];
                    int newNum = [responseObject[@"newNum"] intValue];
                    
                    if (flag == 0) {
                        [nv showLable:[NSString stringWithFormat:@"任务完成,恭喜获得%d积分", num] Controller:self];
                    }
                }
                else if ([type isEqualToString:NoviciateTask_Seven_Eight]) {
                    int flag = [responseObject[@"flag"] intValue];
                    int num = [responseObject[@"num"] intValue];
                    
                    int newFlag = [responseObject[@"newFlag"] intValue];
                    int newNum = [responseObject[@"newNum"] intValue];
                    
                    if (newFlag == 0) {
                        [nv showLable:[NSString stringWithFormat:@"任务完成,恭喜获得%d积分", newNum] Controller:self];
                    }
                }
            } else {
                [nv showLable:responseObject[@"message"] Controller:self];
            }

        }
            
            
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //网络连接失败");
    }];
    
}

- (void)httpGetRandShopWithType:(NSString *)myType
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *token = [ud objectForKey:USER_TOKEN];
    NSString *realm = [ud objectForKey:USER_REALM];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    
    NSString *urlStr;
    
    if ([myType isEqualToString:DailyTaskMorningShare]||[myType isEqualToString:DailyTaskAfternoonShare]||[myType isEqualToString:NoviciateTask_Seven_Eight]) {
        urlStr = [NSString stringWithFormat:@"%@shop/shareShop?token=%@&version=%@&realm=%@",[NSObject baseURLStr], token,VERSION, realm];
    }
    NSString *URL = [MyMD5 authkey:urlStr];
    [MBProgressHUD showMessage:nil afterDeleay:0 WithView:self.view];
    [manager GET:URL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //type = %@ 分享商品 = %@", myType,responseObject);
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
//        responseObject = [NSDictionary changeType:responseObject];
        if (responseObject!=nil) {
            if ([responseObject[@"status"] intValue] == 1) {
                NSString *QrLink = responseObject[@"QrLink"];
                NSNumber *shop_se_price = responseObject[@"shop"][@"shop_se_price"];
                NSString *four_pic = responseObject[@"shop"][@"four_pic"];
                NSArray *picArr = [four_pic componentsSeparatedByString:@","];
                
                NSString *pic = [picArr lastObject];
                NSString *shop_code = responseObject[@"shop"][@"shop_code"];
                NSString *sup_code  = [shop_code substringWithRange:NSMakeRange(1, 3)];
                NSString *share_pic = [NSString stringWithFormat:@"%@/%@/%@", sup_code, shop_code, pic];
                [DataManager sharedManager].key = shop_code;
                [self httpGetShareImageWithPrice:shop_se_price QRLink:QrLink sharePicUrl:share_pic type:myType];
                
            }else
                [MBProgressHUD showError:responseObject[@"message"]];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
    
}

- (void)httpGetShareImageWithPrice:(NSNumber *)shop_price QRLink:(NSString *)qrLink sharePicUrl:(NSString *)picUrl type:(NSString *)myType
{
    [MBProgressHUD showMessage:@"启动分享中,请稍后" afterDeleay:0 WithView:self.view];
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    
    NSString *url = [NSString stringWithFormat:@"%@%@",[NSObject baseURLStr_Upy], picUrl];
    //url = %@", url);
    
    manager.responseSerializer = [AFImageResponseSerializer serializer];
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
//        responseObject = [NSDictionary changeType:responseObject];
        if (responseObject!=nil) {
            NSData *imgData = UIImagePNGRepresentation(responseObject);
            self.shareRandShopImage = [UIImage imageWithData:imgData];
            
            [self shareRandShopWithPrice:shop_price QRLink:qrLink sharePicUrl:picUrl type:myType];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
    
}
- (void)shareRandShopWithPrice:(NSNumber *)shop_price QRLink:(NSString *)qrLink sharePicUrl:(NSString *)picUrl type:(NSString *)myType
{
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"weixin://"]]) {
        
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        [appDelegate shardk];
        
        UIImage *QRImage =[[UIImage alloc] init];
        QRImage = [QRCodeGenerator qrImageForString:qrLink imageSize:160];
        
        ProduceImage *pi = [[ProduceImage alloc] init];
        UIImage *newimg = [pi getImage:self.shareRandShopImage withQRCodeImage:QRImage withText:nil withPrice:[NSString stringWithFormat:@"%@",shop_price] WithTitle:nil];
        
        DShareManager *ds = [DShareManager share];
        ds.delegate = self;
        
        [ds shareAppWithType:ShareTypeWeixiTimeline withImageShareType:myType withImage:newimg];
    } else {
        
        NavgationbarView *nv = [[NavgationbarView alloc] init];
        [nv showLable:@"没有安装微信" Controller:self];
    }
}


- (void)DShareManagerStatus:(SHARESTATE)shareStatus withType:(NSString *)type
{
    NavgationbarView *nv = [[NavgationbarView alloc] init];
    
    //type = %@", type);
    
    if ([type isEqualToString:DailyTaskMorningShare]||[type isEqualToString:DailyTaskAfternoonShare]||[type isEqualToString:DailyTaskFriday]||[type isEqualToString:NoviciateTask_Seven_Eight]) {
        if (shareStatus == 1) {
            
            [self httpShareSuccessWithType:type];
            [self httpGetIntegral];
            [self requestHttp];
            
        } else if (shareStatus == 2) {
            
            [nv showLable:@"分享失败" Controller:self];
            [self requestHttp];
            
        } else if (shareStatus == 3) {
            
            
//            [nv showLable:@"分享取消" Controller:self];
            [self requestHttp];
        }
    }
}



@end
