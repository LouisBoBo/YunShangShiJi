//
//  TFSafetyTipsViewController.m
//  YunShangShiJi
//
//  Created by 云商 on 15/7/3.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//

#import "TFSafetyTipsViewController.h"
#import "TFCellView.h"
#import "SettingCell.h"
#import "TFSafetyTipsDetailViewController.h"
@interface TFSafetyTipsViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)NSMutableArray *dataSourceArray;
@end

@implementation TFSafetyTipsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [super setNavigationItemLeft:@"安全贴士"];
    
    
    [self createNewUI];
}

- (void)createNewUI{
    
    [self.view addSubview:self.tableView];
    
    [self.tableView reloadData];
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
        
    }
    return _tableView;
}

#pragma mark - dataSource
- (NSMutableArray *)dataSourceArray
{
    if (_dataSourceArray == nil) {
        NSArray *titleArr = [NSArray arrayWithObjects:
                                                    @"如何提高账户安全性",
                                                    @"如何进行手机号码绑定与修改",
                                                    @"如何设置安全有效的登录密码",
                                                    @"如何找回密码",
                                                    @"账户安全登录信息提示", nil];
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
    TFSafetyTipsDetailViewController *tdvc = [[TFSafetyTipsDetailViewController alloc] init];
    tdvc.index = (int)indexPath.row;
    tdvc.title = self.dataSourceArray[indexPath.row];
    [self.navigationController pushViewController:tdvc animated:YES];
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
