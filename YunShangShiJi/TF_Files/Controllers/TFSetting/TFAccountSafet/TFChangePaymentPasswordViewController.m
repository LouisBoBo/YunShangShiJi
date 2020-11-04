//
//  TFPaymentPasswordViewController.m
//  YunShangShiJi
//
//  Created by 云商 on 15/7/1.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//

#import "TFChangePaymentPasswordViewController.h"
#import "TFCellView.h"
#import "TFCodePhoneViewController.h"
#import "TFOldPaymentViewController.h"
#import "SettingCell.h"

@interface TFChangePaymentPasswordViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong)UIView *tableViewHeadView;
@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)NSMutableArray *dataSourceArray;
@end

@implementation TFChangePaymentPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [super setNavigationItemLeft:@"重置支付密码"];
    
    [self createNewUI];
}

- (void)createNewUI{
    
    [self.view addSubview:self.tableView];
    
    [self.tableView reloadData];
}
#pragma mark - tableViewHeadView
- (UIView *)tableViewHeadView
{
    if (_tableViewHeadView == nil) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, ZOOM(80))];
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, ZOOM(80)-1, kScreenWidth, 1)];
        lineView.backgroundColor = RGBCOLOR_I(220,220,220);
        [view addSubview:lineView];
        
        _tableViewHeadView = view;
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
        
        _tableView.tableHeaderView = [self tableViewHeadView];
        
        _tableView.tableFooterView = [[UIView alloc] init];
        
    }
    return _tableView;
}

#pragma mark - dataSource
- (NSMutableArray *)dataSourceArray
{
    if (_dataSourceArray == nil) {
        NSArray *titleArr = [NSArray arrayWithObjects:
                             @"原支付密码",
                             @"手机验证", nil];
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
    return ZOOM(172);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SettingCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SETTINGCELLID"];
    
    NSString *st = self.dataSourceArray[indexPath.row];
    
    cell.titleLabel.text = st;
    
    cell.M_l_headImageView.constant = ZOOM(62);
    cell.W_H_headImageView.constant = ZOOM(0);
    cell.M_l_titleLabel.constant = cell.W_H_headImageView.constant+cell.M_l_headImageView.constant*1;
    
    cell.titleLabel.font = [UIFont systemFontOfSize:ZOOM(48)];
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
            TFOldPaymentViewController *tovc = [[TFOldPaymentViewController alloc] init];
            tovc.headTitle = @"支付密码";
            tovc.leftStr = @"原支付密码";
            tovc.plaStr = @"只能是6位数字哦";
            tovc.index = 0; //更换支付密码
            [self.navigationController pushViewController:tovc animated:YES];
        }
            break;
        case 1: {
            TFCodePhoneViewController *tcvc = [[TFCodePhoneViewController alloc] init];
            tcvc.index =  0;
            tcvc.headTitle = @"手机验证"; //更换支付密码
            [self.navigationController pushViewController:tcvc animated:YES];
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

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
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
