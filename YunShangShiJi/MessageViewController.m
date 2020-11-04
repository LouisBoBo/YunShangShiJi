//
//  MessageViewController.m
//  YunShangShiJi
//
//  Created by ios-1 on 15/4/20.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//

#import "MessageViewController.h"
#import "GlobalTool.h"
@interface MessageViewController ()

@end

@implementation MessageViewController
{
    //数据源
    NSMutableArray *_dataArray;
    
    //列表
    UITableView *_Mytableview;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    _dataArray=[NSMutableArray array];
    
    
    //导航条
    UIImageView *headview=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kApplicationWidth, Height_NavBar)];
    //
    [self.view addSubview:headview];
    headview.userInteractionEnabled=YES;
    
    UIButton *backbtn=[UIButton buttonWithType:UIButtonTypeCustom];
    backbtn.frame=CGRectMake(0, 20, 46, 46);
    backbtn.centerY = View_CenterY(headview);
    [backbtn setImage:[UIImage imageNamed:@"返回按钮_正常"] forState:UIControlStateNormal];
    [backbtn addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    [headview addSubview:backbtn];
    
    UILabel *titlelable=[[UILabel alloc]init];
    titlelable.frame=CGRectMake(0, 0, 300, 40);
    titlelable.center=CGPointMake(kApplicationWidth/2, headview.frame.size.height/2+10);
    titlelable.text=@"消息盒子";
    titlelable.textColor=[UIColor blackColor];
    titlelable.textAlignment=NSTextAlignmentCenter;
    [headview addSubview:titlelable];
    
    [self creatData];
    [self creaTableView];
    
}
- (void)viewWillAppear:(BOOL)animated
{
    Myview.hidden=YES;
}
-(void)viewWillDisappear:(BOOL)animated
{
    Myview.hidden=NO;
}

#pragma mark 数据源
-(void)creatData
{
    for(int i=0;i<20;i++)
    {
        NSString *str=[NSString stringWithFormat:@"我的消息%d",i];
        [_dataArray addObject:str];
    }
    
    
}
-(void)creaTableView
{
    _Mytableview=[[UITableView alloc]initWithFrame:CGRectMake(0, Height_NavBar, kApplicationWidth, kApplicationHeight-Height_NavBar) style:UITableViewStylePlain];
    _Mytableview.dataSource=self;
    _Mytableview.delegate=self;
    [self.view addSubview:_Mytableview];
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //row is %ld",indexPath.row);
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
       
        cell.textLabel.text=_dataArray[indexPath.row];
        cell.detailTextLabel.text=_dataArray[indexPath.row];

        UIImage *image=[UIImage imageNamed:@"u1002"];
        cell.imageView.image=image;
        
        UILabel *lable=[[UILabel alloc]initWithFrame:CGRectMake(kApplicationWidth-140, 0, 120, 40)];
        lable.text=@"2015-05-01";
        lable.textAlignment=NSTextAlignmentRight;
        lable.font=kStatementFontSize;
        [cell addSubview:lable];
        
        
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)back:(UIButton*)sender
{
    [self.navigationController popViewControllerAnimated:NO];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
