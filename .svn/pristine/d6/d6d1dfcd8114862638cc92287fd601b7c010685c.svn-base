//
//  SignViewController.m
//  YunShangShiJi
//
//  Created by yssj on 15/9/10.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//

#import "SignViewController.h"
#import "GlobalTool.h"
#import "SignCell.h"
#import "AFNetworking.h"
#import "MyMD5.h"
#import "MBProgressHUD+NJ.h"

#import "TFMyInformationViewController.h"
#import "TFSettingViewController.h"
#import "TFBindingPhoneViewController.h"
#import "TFOldPaymentViewController.h"
#import "TFBindingEmailViewController.h"
#import "TFAccountSafeViewController.h"
#import "TFReceivingAddressViewController.h"
#import "BoundPhoneVC.h"

CGFloat fontSize = 18;

@interface SignViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_myTableView;
    UILabel *_integral;                     //总积分
    UIButton *_signBtn;
    

    NSArray *_nameArray;
    NSArray *_detailArray;
}
@end

@implementation SignViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    

    _nameArray = @[@"完善注册信息",@"认证邮箱",@"打分鼓励我们",@"设置个人头像为自拍",@"认证手机号"];
    _detailArray = @[@"50",@"100",@"200",@"100",@"100",@"100"];

    
    [self setNavgationView];
    [self setMyTableView];
    

}

-(void)setNavgationView
{
    //导航条
    UIImageView *headview=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kApplicationWidth, Height_NavBar)];
    headview.image=[UIImage imageNamed:@"导航背景"];
    [self.view addSubview:headview];
    headview.userInteractionEnabled=YES;
    //左边返回按钮
    UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(10+(40-15)/2, 20+(44-25)/2, 15, 25)];
    img.centerY = View_CenterY(headview);
    img.image = [UIImage imageNamed:@"返回"];
    img.userInteractionEnabled = YES;
    [headview addSubview:img];
    
    UIButton *backbtn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    backbtn.frame=CGRectMake(0, 20, 80, 44);
    backbtn.centerY = View_CenterY(headview);
    [backbtn addTarget:self action:@selector(backButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [headview addSubview:backbtn];
    
    UILabel *titlelable=[[UILabel alloc]init];
    titlelable.frame=CGRectMake(0, 0, 300, 40);
    titlelable.center=CGPointMake(kApplicationWidth/2, headview.frame.size.height/2+10);
    titlelable.text= @"签到";
    titlelable.font = kNavTitleFontSize;
    titlelable.textColor=kMainTitleColor;
    titlelable.textAlignment=NSTextAlignmentCenter;
    [headview addSubview:titlelable];
    
}

-(void)setMyTableView
{
    _myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, Height_NavBar, kApplicationWidth, kApplicationHeight-Height_NavBar+kUnderStatusBarStartY) style:UITableViewStyleGrouped];
    _myTableView.dataSource = self;
    _myTableView.delegate = self;
//    _myTableView.bounces = NO;
    _myTableView.showsVerticalScrollIndicator=NO;
    _myTableView.backgroundColor = [UIColor whiteColor];
    [_myTableView registerClass:[SignCell class] forCellReuseIdentifier:@"cell"];
    _myTableView.tableHeaderView = [self setHeadView];
    
    [self.view addSubview:_myTableView];
    
}
-(UIView *)setHeadView
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 64, kApplicationWidth, 200)];
    
    UIImageView *backImg = [[UIImageView alloc]initWithFrame:view.bounds];
//    backImg.backgroundColor = [UIColor lightGrayColor];
    backImg.image=[UIImage imageNamed:@"签到背景"];
    [view addSubview:backImg];
    
    _integral = [[UILabel alloc]initWithFrame:CGRectMake(kApplicationWidth/2-100, 10, 200, 30)];
    _integral.textAlignment = NSTextAlignmentCenter;
//    _integral.text = [NSString stringWithFormat:@"总积分:%@",_totalintegral];
    NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"总积分:%@",_totalintegral]];
    _integral.textColor = tarbarrossred;
    NSRange redRange = NSMakeRange(0, [[noteStr string] rangeOfString:@":"].location+1);
    [noteStr addAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor],NSFontAttributeName:[UIFont systemFontOfSize:17]} range:redRange];
    [_integral setAttributedText:noteStr];
    _integral.font = [UIFont systemFontOfSize:17.0f];
    [view addSubview:_integral];
    
    _signBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    _signBtn.frame = CGRectMake(kApplicationWidth/2-40, _integral.frame.origin.y+_integral.frame.size.height+5,80, 25);
    _signBtn.backgroundColor = tarbarrossred;
    _signBtn.layer.cornerRadius = 5;
    _signBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [_signBtn setTitle:@"签到" forState:UIControlStateNormal];
    [_signBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_signBtn addTarget:self action:@selector(signBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:_signBtn];
    
    UILabel *remind = [[UILabel alloc]initWithFrame:CGRectMake(kApplicationWidth/2-50, _signBtn.frame.origin.y+_signBtn.frame.size.height+5, 100, 20)];
    remind.text = @"签到赚积分哦~";
    remind.font=[UIFont systemFontOfSize:12.0f];
    remind.textAlignment = NSTextAlignmentCenter;
    remind.textColor = kTextGreyColor;
    [view addSubview:remind];
    
    UIView *roundeDayView = [[UIView alloc]initWithFrame:CGRectMake(kApplicationWidth/2-160, view.frame.size.height-80, 320, 50)];
    roundeDayView.tag = 1000;
    [view addSubview:roundeDayView];
    
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
    
    return view;
}
/*********  改变签到天数   *********/
-(void)changeRoundeBtn
{
    UIView *view = [_myTableView.tableHeaderView viewWithTag:1000];
    for (int i=0; i<_signDay; i++) {
        UIButton *btn =(UIButton *)[view viewWithTag:i+100];
        btn.selected = YES;
    }
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return ZOOM(160);
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _nameArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SignCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];

    [cell setImg:[NSString stringWithFormat:@"积分_%@",_nameArray[indexPath.row]] name:_nameArray[indexPath.row] detail:@"50"];
    
    return cell;
}

-(void)httpWhetherBinDingEmail
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *token = [ud objectForKey:USER_TOKEN];
    
    NSString *urlStr = [NSString stringWithFormat:@"%@user/queryEmail?version=%@&token=%@",[NSObject baseURLStr],VERSION,token];
    
    NSString *URL = [MyMD5 authkey:urlStr];

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:URL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {

//        responseObject = [NSDictionary changeType:responseObject];
        if (responseObject!=nil) {
            if ([responseObject[@"status"] intValue] == 1) {
                if ([responseObject[@"bool"] boolValue]== YES) {
                    TFBindingPhoneViewController *tbvc= [[TFBindingPhoneViewController alloc] init];
                    tbvc.navTitle = @"绑定邮箱";
                    tbvc.leftTitle=@"邮箱";
                    tbvc.subTitle=@"更换绑定邮箱";
                    tbvc.phone = responseObject[@"email"];
                    [self.navigationController pushViewController:tbvc animated:YES];
                } else{
                    TFBindingEmailViewController *tevc = [[TFBindingEmailViewController alloc] init];
                    [self.navigationController pushViewController:tevc animated:YES];
                }
                
            }

        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MBProgressHUD showError:@"网络连接失败,请检查网络设置"];
    }];
}

#pragma mark - 判断用户是否绑定过手机
- (void)httpFindPhone
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *token = [ud objectForKey:USER_TOKEN];
    
    NSString *urlStr = [NSString stringWithFormat:@"%@user/queryPhone?version=%@&token=%@",[NSObject baseURLStr],VERSION,token];
    NSString *URL = [MyMD5 authkey:urlStr];

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:URL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        responseObject = [NSDictionary changeType:responseObject];
        if (responseObject!=nil) {
            if ([responseObject[@"status"] intValue] == 1) {
                if ([responseObject[@"bool"] boolValue]== YES) { // 绑定过手机
                    TFBindingPhoneViewController *tbvc= [[TFBindingPhoneViewController alloc] init];
                    tbvc.phone = responseObject[@"phone"];
                    tbvc.navTitle = @"绑定手机";
                    tbvc.leftTitle = @"手机号";
                    tbvc.subTitle = @"更换绑定手机";
                    [self.navigationController pushViewController:tbvc animated:YES];
                    
                } else { //没有绑定过手机
//                    TFOldPaymentViewController *tovc = [[TFOldPaymentViewController alloc] init];
//                    tovc.headTitle = @"绑定手机";
//                    tovc.leftStr = @"手机号码";
//                    tovc.plaStr = @"输入您要绑定的手机号";
//                    tovc.index = 1;
                    BoundPhoneVC *tovc = [[BoundPhoneVC alloc] init];
                    [self.navigationController pushViewController:tovc animated:YES];
                }
            } else {
                [MBProgressHUD showError:responseObject[@"message"]];
            }

        }
        
        
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MBProgressHUD showError:@"网络连接失败,请检查网络设置"];
    }];
}

#pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    switch (indexPath.row) {
        case 0:
        {
            //完善注册信息
            TFReceivingAddressViewController *view=[[TFReceivingAddressViewController alloc]init];
            [self.navigationController pushViewController:view animated:YES];
        }
            break;

        case 1:
        {
//            //绑定邮箱
            [self httpWhetherBinDingEmail];
//            TFBindingEmailViewController *tevc = [[TFBindingEmailViewController alloc] init];
//            [self.navigationController pushViewController:tevc animated:YES];
        }
            break;
        case 2:
        {
            //打分鼓励
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"itms-apps://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=1029741842"]];
            
        }
            break;
        case 3:
        {
            //设置个人头像为自拍
            TFMyInformationViewController *view=[[TFMyInformationViewController alloc]init];
            [self.navigationController pushViewController:view animated:YES];

        }
            break;
        case 4:
        {
            //认证手机号
            [self httpFindPhone];
        }
            break;
        default:
            break;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kApplicationWidth, 50)];
    
    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(20, 20, kApplicationWidth, 30)];
    title.text = @"做任务，赚积分";
    [view addSubview:title];
    
    return view;
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
                NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"总积分:%@",responseObject[@"integral"]]];
                _integral.textColor = tarbarrossred;
                NSRange redRange = NSMakeRange(0, [[noteStr string] rangeOfString:@":"].location+1);
                [noteStr addAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor],NSFontAttributeName:[UIFont systemFontOfSize:17]} range:redRange];
                [_integral setAttributedText:noteStr];
                _signBtn.userInteractionEnabled = NO; //不能在点击了
                
                self.signDay = _signDay + 1;
                [self changeRoundeBtn];
                
                NSNotification *notification=[NSNotification notificationWithName:@"integral" object:responseObject[@"integral"]];
                [[NSNotificationCenter defaultCenter] postNotification:notification];
                
            } else {
                [MBProgressHUD showError:responseObject[@"message"]];
            }

        }
        
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        [MBProgressHUD showError:@"网络连接失败,请检查网络设置"];
         
         NavgationbarView *nv = [[NavgationbarView alloc] init];
         [nv showLable:@"网络连接失败,请检查网络设置" Controller:self];
    }];
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
- (void)backButtonClick
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    Myview.hidden =YES;
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    Myview.hidden = NO;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
