//
//  TFAboutViewController.m
//  YunShangShiJi
//
//  Created by 云商 on 15/6/30.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//

#import "TFAboutViewController.h"

#import "SettingCell.h"
#import "TFCellView.h"
#import "TFQRCodeView.h"

#import "TFAboutWeViewController.h"
#import "TFFeedBackViewController.h"
#import "TFUserProtocolViewController.h"
//#import "ChatViewController.h"
#import "RobotManager.h"
//#import "ChatListViewController.h"

@interface TFAboutViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong)UIView *tableViewFootView;
@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)NSMutableArray *dataSourceArray;

@property (nonatomic, strong)UIScrollView *backgroundScrollView;

@end

@implementation TFAboutViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setNavigationItemLeft:@"关于"];
//    [self createUI];
    
    [self setupUI];
}

- (void)setupUI{
    
    [self.view addSubview:self.tableView];
    
    [self.tableView reloadData];
}

#pragma mark - tableViewFootView
- (UIView *)tableViewFootView
{
    if (_tableViewFootView == nil) {
        
        UIView *view = [[UIView alloc] init];
        
        CGFloat QR_W_H = ZOOM(427);
        CGFloat c = QR_W_H/4.0;
        //CGRectMake((kScreenWidth-qr_W_H)/2,0,  tcv]+ZOOM(152), qr_W_H, qr_W_H+c)
        CGRect frame = CGRectMake((kScreenWidth-QR_W_H)/2.0, ZOOM(120), QR_W_H, QR_W_H+c);
        TFQRCodeView *trv = [[TFQRCodeView alloc] initWithFrame:frame];
        trv.titleLabel.text = @"分享二维码给好友";
        trv.titleLabel.font = kFont6px(34);
        
        //+++++++++此时应该将APP下载的APPStore地址生成二维码设置++++++++++
        trv.imageView.image = [UIImage imageNamed:@"300+300.jpg"];
        
        view.frame = CGRectMake(0, 0, kScreenWidth, CGRectGetMaxX(trv.frame));
        
        [view addSubview:trv];
        _tableViewFootView = view;
        
    }
    return _tableViewFootView;
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
        _tableView.tableFooterView = [self tableViewFootView];
        
    }
    return _tableView;
}

#pragma mark - dataSource
- (NSMutableArray *)dataSourceArray
{
    if (_dataSourceArray == nil) {
        NSArray *titleArr = [NSArray arrayWithObjects:
                             @"关于我们",
                             @"意见反馈",
                             @"用户协议",
                             @"", nil];
        _dataSourceArray = [NSMutableArray arrayWithArray:titleArr];
    }
    return _dataSourceArray;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataSourceArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row!=self.dataSourceArray.count) {
        return ZOOM(172);
    } else
        return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SettingCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SETTINGCELLID"];
    
    if (indexPath.row!=self.dataSourceArray.count-1) {
        NSString *st = self.dataSourceArray[indexPath.row];
        
        cell.titleLabel.text = st;
        
        cell.M_l_headImageView.constant = ZOOM(62);
        cell.W_H_headImageView.constant = ZOOM(0);
        cell.M_l_titleLabel.constant = cell.W_H_headImageView.constant+cell.M_l_headImageView.constant*1;
        
        cell.titleLabel.font = [UIFont systemFontOfSize:ZOOM(48)];
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    //    cell.contentView.backgroundColor = COLOR_RANDOM;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0: {

            TFAboutWeViewController *twvc = [[TFAboutWeViewController alloc] init];
            [self.navigationController pushViewController:twvc animated:YES];

        }
            break;
        case 1: {
            TFFeedBackViewController *tfvc = [[TFFeedBackViewController alloc] init];
            [self.navigationController pushViewController:tfvc animated:YES];
        }
            break;
        case 2: {
            TFUserProtocolViewController *tuvc = [[TFUserProtocolViewController alloc] init];
            [self.navigationController pushViewController:tuvc animated:YES];
        }
            break;
        
        default:
            break;
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

#pragma mark - 检测新版
-(void)versionsHttp
{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *paraments=[NSMutableDictionary dictionary];
    NSString *url=[NSString stringWithFormat:@"%@getVersion?version=%@&type=2",[NSObject baseURLStr],VERSION];
    NSString *URL=[MyMD5 authkey:url];
    
    //
    [manager POST:URL parameters:paraments success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [MBProgressHUD hideHUDForView:self.view];
//        responseObject = [NSDictionary changeType:responseObject];
        if (responseObject!=nil) {
            if ([responseObject[@"status"] intValue] == 1) {
                NSString *version_no = [NSString stringWithFormat:@"%@",responseObject[@"version_no"]];

                if([version_no isEqualToString:@"<null>"]) //无新版
                {
                    [MBProgressHUD showSuccess:@"当前是最新版"];
                } else{ // 有新版
                    //有新版，请前往APPStore下载
                    [MBProgressHUD showSuccess:@"App Store有最新版啦"];
                }
            }

        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        [MBProgressHUD showError:@"网络连接失败,请检查网络设置"];
        
        NavgationbarView *nv = [[NavgationbarView alloc] init];
        [nv showLable:@"网络连接失败,请检查网络设置" Controller:self];
    }];
}

- (void)rightBarButtonClick
{
    [self Message];
}

#pragma mark 聊天
-(void)Message
{
    //begin 赵官林 2016.5.26 跳转到消息列表
    [self presentChatList];
    //end
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
