//
//  SalemanageViewController.m
//  YunShangShiJi
//
//  Created by ios-1 on 15/6/24.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//

#import "SalemanageViewController.h"
#import "GlobalTool.h"

@interface SalemanageViewController ()
{
    //数据源
    NSMutableArray *_dataArray;
    
    //列表
    UITableView *_Mytableview;
}
@end

@implementation SalemanageViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    _dataArray=[NSMutableArray array];

    
    //导航条
    UIImageView *headview=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kApplicationWidth, Height_NavBar)];
    //
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
    titlelable.text=@"销售管理";
    titlelable.textColor=[UIColor blackColor];
    titlelable.textAlignment=NSTextAlignmentCenter;
    [headview addSubview:titlelable];
    
    [self creatData];
    [self creatView];
}

-(void)creatData
{
    NSArray *arr=@[@"成交订单",@"每日金额",@"一周回佣",@"每日访客"];
    _dataArray =[NSMutableArray arrayWithArray:arr];
}
-(void)creatView
{
    _Mytableview=[[UITableView alloc]initWithFrame:CGRectMake(0, Height_NavBar, kApplicationWidth, kApplicationHeight-Height_NavBar+kUnderStatusBarStartY) style:UITableViewStylePlain];
    _Mytableview.dataSource=self;
    _Mytableview.delegate=self;
    _Mytableview.sectionHeaderHeight=10;
    [self.view addSubview:_Mytableview];

}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell)
    {
        
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }

    cell.textLabel.text=_dataArray[indexPath.row];

    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)back:(UIButton*)sender
{
    [self.navigationController popViewControllerAnimated:YES];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

@end
