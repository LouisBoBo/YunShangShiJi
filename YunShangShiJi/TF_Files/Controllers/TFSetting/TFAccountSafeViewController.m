//
//  TFAccountSafeViewController.m
//  YunShangShiJi
//
//  Created by 云商 on 15/6/30.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//

#import "TFAccountSafeViewController.h"

#import "TFTitleView.h"
#import "TFCellView.h"
#import "LoginViewController.h"

#import "TFChangePasswordViewController.h"
#import "TFChangePaymentPasswordViewController.h"
#import "TFLoginDeviceViewController.h"
#import "TFSafetyTipsViewController.h"
#import "TFBindingPhoneViewController.h"
#import "TFBindingEmailViewController.h"
#import "TFOldPaymentViewController.h"

#import "TFSetPaymentPasswordViewController.h"
#import "BoundPhoneVC.h"

#import "WTFChangePhoneNumController.h"
#import "SettingCell.h"
@interface TFAccountSafeViewController () <UITableViewDataSource, UITableViewDelegate>
{
    int phone_status;
    
    int email_status;  //1为未绑定（未设置）   2为已绑定（已设置）
 
    int paypwd_status;
}
@property (nonatomic, strong)UIView *tableViewHeadView;
@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)NSMutableArray *dataSectionArray;
@property (nonatomic, strong)NSMutableArray *dataSourceArray;


@property (nonatomic, copy)NSString *userName; //用户是否登录

@property (nonatomic, strong)UILabel *nameLabel;
@property (nonatomic, strong)UILabel *loginTimeLabel;
@property (nonatomic, strong)UIScrollView *backgroundScrollView;

@end

@implementation TFAccountSafeViewController

- (void)viewDidLoad {
    [super viewDidLoad];


    [super setNavigationItemLeft:@"账号与安全"];//设置导航

    [self setupUI];
}

- (void)setupUI{
    
    [self.view addSubview:self.tableView];
    
    [self.tableView reloadData];
}

#pragma mark - tableHeadView
- (UIView *)tableViewHeadView
{
    if (_tableViewHeadView == nil) {
        
        UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 0)];
        
        //bgvi_size
        CGFloat name_H = ZOOM(50);
        CGFloat login_H = ZOOM(50);
        CGFloat bgvi_H = ZOOM(112)+name_H+login_H;
        UIView *bgvi = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenHeight, bgvi_H)];
        
        [self.backgroundScrollView addSubview:bgvi];
        self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(ZOOM(62), ZOOM(10), kScreenWidth-ZOOM(62), name_H)];
        self.nameLabel.textColor = RGBCOLOR_I(34,34,34);
        self.nameLabel.font = kFont6px(32);
        //先从本地读取用户名
        NSUserDefaults *userdefaul=[NSUserDefaults standardUserDefaults];
        //获取用户是否登录
        self.userName = [userdefaul objectForKey:USER_NAME];
        if (self.userName.length == 0) {
            self.nameLabel.text = @"请登录";
        } else {
            //已经登录读取用户名
            NSString *name=[userdefaul objectForKey:USER_NAME];
            self.nameLabel.text = name;
        }
        [bgvi addSubview:self.nameLabel];
        
        self.loginTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.nameLabel.frame.origin.x,  self.nameLabel.bottom+ZOOM(32), self.nameLabel.bounds.size.width, login_H)];
        self.loginTimeLabel.font = kFont6px(29);
        self.loginTimeLabel.textColor = RGBCOLOR_I(152,152,152);
        self.loginTimeLabel.text = @"";
        [bgvi addSubview:self.loginTimeLabel];
        
        headView.frame = CGRectMake(0, 0, kScreenWidth, CGRectGetHeight(bgvi.frame)+ZOOM(10));
        
        [headView addSubview:bgvi];
        
        _tableViewHeadView = headView;
    }
    
    
    return _tableViewHeadView;
}

#pragma mark - tableView
- (UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kNavigationheightForIOS7, kScreenWidth, kScreenHeight-kNavigationheightForIOS7)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
        [_tableView registerNib:[UINib nibWithNibName:@"SettingCell" bundle:nil] forCellReuseIdentifier:@"SETTINGCELLID"];
        //        _tableView.backgroundColor = COLOR_ROSERED;
        _tableView.tableFooterView = [[UIView alloc] init];
        _tableView.tableHeaderView = self.tableViewHeadView;
    }
    return _tableView;
}

#pragma mark - dataSource
- (NSMutableArray *)dataSectionArray
{
    if (_dataSectionArray == nil) {
        
        NSArray *arr = [NSArray arrayWithObjects:
                                                @"账号及信息完善",
                                                @"登录及访问历史",
                                                @"安全贴士", nil];
        _dataSectionArray = [NSMutableArray arrayWithArray:arr];
    }
    return _dataSectionArray;
}


- (NSMutableArray *)dataSourceArray
{
    if (_dataSourceArray == nil) {
        
        NSArray *arr = @[@"登录密码",
                         @"绑定手机",
                         @"绑定邮箱",
                         @"支付密码"];
        
        NSArray *arr1 = @[@"登录设备"];
        NSArray *arr2 = @[@"安全贴士"];
        
        _dataSourceArray = [NSMutableArray array];
        [_dataSourceArray addObject:arr];
        [_dataSourceArray addObject:arr1];
        [_dataSourceArray addObject:arr2];
    }
    return _dataSourceArray;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, ZOOM(132))];
    view.backgroundColor = kBackgroundColor;
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(ZOOM(60), 0, kScreenWidth-ZOOM(60)*2, ZOOM(132))];
    NSString *st = self.dataSectionArray[section];
    label.text = st;
    label.font = [UIFont systemFontOfSize:ZOOM(48)];
    label.textColor = RGBCOLOR_I(152,152,152);
    [view addSubview:label];
    
    return view;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.dataSectionArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataSourceArray[section] count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return ZOOM(132);
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return ZOOM(172);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SettingCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SETTINGCELLID"];
    
    NSArray *arr = self.dataSourceArray[indexPath.section];
    NSString *st = arr[indexPath.row];
    
    
    cell.titleLabel.text = st;
    
    if (indexPath.section == 0) {
        
        if (indexPath.row == 0) {
            cell.headImageView.image = [UIImage imageNamed:st];
        } else if (indexPath.row == 1) {
            if (phone_status == 1) {
                cell.headImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@1",st]];
            } else {
                cell.headImageView.image = [UIImage imageNamed:st];
            }
        } else if (indexPath.row == 2) {
            if (email_status == 1) {
                cell.headImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@1",st]];
            } else {
                cell.headImageView.image = [UIImage imageNamed:st];
            }
        } else if (indexPath.row == 3) {
            if (paypwd_status == 1) {
                cell.headImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@1",st]];
            } else {
                cell.headImageView.image = [UIImage imageNamed:st];
            }
        }
    } else {
        cell.headImageView.image = [UIImage imageNamed:st];
    }
    
    cell.M_l_headImageView.constant = ZOOM(62);
    cell.W_H_headImageView.constant = ZOOM(54);
    cell.M_l_titleLabel.constant = cell.W_H_headImageView.constant+cell.M_l_headImageView.constant*2;
    cell.titleLabel.font = [UIFont systemFontOfSize:ZOOM(48)];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (indexPath.section!=2) {
        if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
            [cell setSeparatorInset:UIEdgeInsetsZero];
        }
        
        if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
            [cell setLayoutMargins:UIEdgeInsetsZero];
        }

    } else if (indexPath.section == 2) {
        if (indexPath.row == arr.count-1) {
            if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
                [cell setSeparatorInset:UIEdgeInsetsMake(0, kScreenWidth, 0, 0)];
            }
            
            if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
                [cell setSeparatorInset:UIEdgeInsetsMake(0, kScreenWidth, 0, 0)];
            }
        }
    }
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0: {
                //登录密码
                TFChangePasswordViewController *tcpv = [[TFChangePasswordViewController alloc] init];
                [self.navigationController pushViewController:tcpv animated:YES];
            }
                break;
            case 1: {
                //绑定手机
                [self httpFindPhone];
            }
                break;
            case 2: {
                [self httpWhetherBinDingEmail];
            }
                break;
            case 3: {
                [self httpIsSetPwd];
            }
                break;
                
            default:
                break;
        }
        
    } else if (indexPath.section == 1) {
        switch (indexPath.row) {
            case 0: {
                //登录设备
                TFLoginDeviceViewController *tlvc = [[TFLoginDeviceViewController alloc] init];
                [self.navigationController pushViewController:tlvc animated:YES];
            }
                break;
            default:
                break;
        }

        
    } else if (indexPath.section == 2) {
        switch (indexPath.row) {
            case 0: {
                //安全贴士
                TFSafetyTipsViewController *tsvc = [[TFSafetyTipsViewController alloc] init];
                [self.navigationController pushViewController:tsvc animated:YES];
            }
                break;
            default:
                break;
        }
        
    }
   
    
}

-(void)viewDidLayoutSubviews
{
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsMake(0,0,0,0)];
    }
    
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.tableView setLayoutMargins:UIEdgeInsetsMake(0,0,0,0)];
    }
}

- (void)httpGetStates
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *token = [ud objectForKey:USER_TOKEN];
    
    NSString *urlStr = [NSString stringWithFormat:@"%@loginRecord/lastLogin?version=%@&token=%@",[NSObject baseURLStr],VERSION,token];
    NSString *URL = [MyMD5 authkey:urlStr];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    [manager GET:URL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        //responseObject = %@",responseObject);
        
        MyLog(@"responseObject: %@", responseObject);
        
//        responseObject = [NSDictionary changeType:responseObject];
        if (responseObject!=nil) {
            
            if ([responseObject[@"status"] intValue] == 1) {
                NSString *loginTime = [NSString stringWithFormat:@"%lld",[responseObject[@"loginTime"] longLongValue]/1000];
                NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
                [user setObject:loginTime forKey:LOGIN_TIME];
                [user synchronize];
                
                
                //设置时间
                [self timeInfoWithDateString:loginTime];
                
                phone_status = [responseObject[@"phone_status"] intValue];
                email_status = [responseObject[@"email_status"]  intValue];
                paypwd_status = [responseObject[@"paypwd_status"] intValue];
                
                [self.tableView reloadData];
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}

- (void)viewWillAppear:(BOOL)animated
{
    [self httpGetStates];
}

#pragma mark - 是否设置过支付密码
- (void)httpIsSetPwd
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *token = [ud objectForKey:USER_TOKEN];
    NSString *urlStr = [NSString stringWithFormat:@"%@wallet/ckSetPwd?token=%@&version=%@",[NSObject baseURLStr],token,VERSION];
    NSString *URL = [MyMD5 authkey:urlStr];
    
    //
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:URL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {

//        responseObject = [NSDictionary changeType:responseObject];
        
        if (responseObject!=nil) {
            if ([responseObject[@"status"] intValue] == 1) { //设置过密码了
                
                if ([responseObject[@"flag"] intValue] == 1) { //没设置
                    //进入设置支付密码页面
                    TFSetPaymentPasswordViewController *tsvc= [[TFSetPaymentPasswordViewController alloc] init];
                    [self.navigationController pushViewController:tsvc animated:YES];
                } else if ([responseObject[@"flag"] intValue] == 2) { //设置过了
                    //                [MBProgressHUD showError:@"您可在[设置]中修改支付密码"];
                    TFChangePaymentPasswordViewController *tppvc = [[TFChangePaymentPasswordViewController alloc] init];
                    tppvc.index = 0;
                    [self.navigationController pushViewController:tppvc animated:YES];
                }
            } else {
                [MBProgressHUD showError:responseObject[@"message"]];
            }
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        //        [MBProgressHUD showError:@"网络连接失败,请检查网络设置"];
        NavgationbarView *mentionview=[[NavgationbarView alloc]init];
        [mentionview showLable:@"网络开小差啦,请检查网络" Controller:self];
    }];
}


#pragma mark - 是否绑定邮箱
/**************  是否绑定邮箱    **********/
-(void)httpWhetherBinDingEmail
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *token = [ud objectForKey:USER_TOKEN];
    
    NSString *urlStr = [NSString stringWithFormat:@"%@user/queryEmail?version=%@&token=%@",[NSObject baseURLStr],VERSION,token];

    NSString *URL = [MyMD5 authkey:urlStr];
    //
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:URL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //
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
//        [MBProgressHUD showError:@"网络连接失败,请检查网络设置"];
        
        NavgationbarView *mentionview=[[NavgationbarView alloc]init];
        [mentionview showLable:@"网络开小差啦,请检查网络" Controller:self];
    }];
}
#pragma mark - 判断用户是否绑定过手机
- (void)httpFindPhone
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *token = [ud objectForKey:USER_TOKEN];
    
    NSString *urlStr = [NSString stringWithFormat:@"%@user/queryPhone?version=%@&token=%@",[NSObject baseURLStr],VERSION,token];
    NSString *URL = [MyMD5 authkey:urlStr];
    //
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:URL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //
//        responseObject = [NSDictionary changeType:responseObject];
        if (responseObject!=nil) {
            if ([responseObject[@"status"] intValue] == 1) {
                if ([responseObject[@"bool"] boolValue]== YES) { // 绑定过手机
//                    TFBindingPhoneViewController *tbvc= [[TFBindingPhoneViewController alloc] init];
//                    tbvc.navTitle=@"绑定手机";
//                    tbvc.leftTitle=@"手机号";
//                    tbvc.subTitle=@"更换绑定手机";
                    WTFChangePhoneNumController *tbvc=[[WTFChangePhoneNumController alloc]init];
                    tbvc.phone = responseObject[@"phone"];
                    [self.navigationController pushViewController:tbvc animated:YES];
                    
                } else { //没有绑定过手机
                    BoundPhoneVC *tovc = [[BoundPhoneVC alloc] init];
                    
//                    TFOldPaymentViewController *tovc = [[TFOldPaymentViewController alloc] init];
//                    tovc.headTitle = @"绑定手机";
//                    tovc.leftStr = @"手机号码";
//                    tovc.plaStr = @"输入您要绑定的手机号";
//                    tovc.index = 1;
                    [self.navigationController pushViewController:tovc animated:YES];
                }
            } else {
                [MBProgressHUD showError:responseObject[@"message"]];
            }

        }
        
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        [MBProgressHUD showError:@"网络连接失败,请检查网络设置"];
         
         NavgationbarView *mentionview=[[NavgationbarView alloc]init];
         [mentionview showLable:@"网络开小差啦,请检查网络" Controller:self];
    }];
}

#pragma mark - 登录方法
- (void)goLogin
{
    NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
    [user removeObjectForKey:USER_TOKEN];
    [user removeObjectForKey:USER_PHONE];
    [user removeObjectForKey:USER_PASSWORD];
    [user removeObjectForKey:USER_NAME];
    [user removeObjectForKey:USER_EMAIL];
    [user removeObjectForKey:USER_INFO];
    [user removeObjectForKey:USER_BIRTHDAY];
    [user removeObjectForKey:USER_ARRER];
    [[NSUserDefaults standardUserDefaults] synchronize];
    //回到登陆页面
    LoginViewController *login=[[LoginViewController alloc] init];
    login.tag=1000;
    [self.navigationController pushViewController:login animated:YES];
}

#pragma mark 网络请求获取登陆时间
-(void)creatHttp
{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *paraments=[NSMutableDictionary dictionary];
    
    NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
    NSString *token=[user objectForKey:USER_TOKEN];
    
    NSString *url=[NSString stringWithFormat:@"%@loginRecord/lastLogin?version=%@&token=%@",[NSObject baseURLStr],VERSION,token];
    
    NSString *URL=[MyMD5 authkey:url];
    [manager POST:URL parameters:paraments success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //
//        responseObject = [NSDictionary changeType:responseObject];
        if (responseObject!=nil) {
            NSString *str=responseObject[@"status"];
            if(str.intValue==1)//检测成功
            {
                NSString *loginTime = [NSString stringWithFormat:@"%lld",[responseObject[@"loginTime"] longLongValue]/1000];
                NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
                [user setObject:loginTime forKey:LOGIN_TIME];
                [user synchronize];
                
                //设置时间
                [self timeInfoWithDateString:loginTime];
                
            }
            else if(str.intValue == 10030){//没登录状态
                
                NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
                [ud removeObjectForKey:USER_TOKEN];
                
                LoginViewController *login=[[LoginViewController alloc]init];
                
                login.tag=1000;
                login.loginStatue = @"10030";
                login.hidesBottomBarWhenPushed=YES;
                [self.navigationController pushViewController:login animated:YES];
                
            }

            else {
                [MBProgressHUD showError:responseObject[@"message"]];
            }

        }
        
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        [MBProgressHUD showError:@"网络连接失败,请检查网络设置"];
         
         NavgationbarView *mentionview=[[NavgationbarView alloc]init];
         [mentionview showLable:@"网络开小差啦,请检查网络" Controller:self];
    }];
    
    
}
//显示时间
- (void)timeInfoWithDateString:(NSString *)timeString
{
    MyLog(@"timeString: %@", timeString);
    NSDate *oldDate = [NSDate dateWithTimeIntervalSince1970:[timeString longLongValue]];
    NSDate *curDate = [NSDate date];
    
    MyLog(@"%@, %@", oldDate, curDate);
    
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *showOldDate = [formatter stringFromDate:oldDate];
    NSString *showCurDate = [formatter stringFromDate:curDate];
    
    MyLog(@"%@, %@", showOldDate, showCurDate);
    

    int year = [[showCurDate substringToIndex:4] intValue]-[[showOldDate substringToIndex:4] intValue];
    int month = [[showCurDate substringWithRange:NSMakeRange(5, 2)] intValue]-[[showOldDate substringWithRange:NSMakeRange(5, 2)] intValue];
    int day = [[showCurDate substringWithRange:NSMakeRange(8, 2)] intValue]-[[showOldDate substringWithRange:NSMakeRange(8, 2)] intValue];
    if (year == 0&&month == 0&&day == 0) {
        self.loginTimeLabel.text = [NSString stringWithFormat:@"最后一次访问时间: 今天%@",[showOldDate substringWithRange:NSMakeRange(11, 5)]];
    } else if (year == 0&&month == 0&&day == 1) {
        self.loginTimeLabel.text = [NSString stringWithFormat:@"最后一次访问时间: 昨天%@",[showOldDate substringWithRange:NSMakeRange(11, 5)]];
    } else if (year == 0&&month == 0&&day == 2) {
        self.loginTimeLabel.text = [NSString stringWithFormat:@"最后一次访问时间: 前天%@",[showOldDate substringWithRange:NSMakeRange(11, 5)]];
    } else {
        self.loginTimeLabel.text = [NSString stringWithFormat:@"最后一次访问时间: %@",[showOldDate substringToIndex:16]];
    }
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    MyLog(@"Offset.y: %f\nsectionHeaderHeight: %f\n", scrollView.contentOffset.y, ceil(ZOOM(132)));
//
//    CGFloat sectionHeaderHeight = ceil(ZOOM(132));
//    if (scrollView.contentOffset.y<=sectionHeaderHeight&&scrollView.contentOffset.y>=0) {
//        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
//    } else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
//        scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
//    }
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
