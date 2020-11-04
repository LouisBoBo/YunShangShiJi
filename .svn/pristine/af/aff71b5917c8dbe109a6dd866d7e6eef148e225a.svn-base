//
//  VoiceredViewController.m
//  YunShangShiJi
//
//  Created by ios-1 on 16/3/28.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import "VoiceredViewController.h"
#import "GlobalTool.h"
#import "AFNetworking.h"
#import "NavgationbarView.h"
#import "MJRefresh.h"
#import "PersonCenterCell.h"
#import "WantSendredViewController.h"
#import "SendenvelopeViewController.h"

@interface VoiceredViewController ()

@end

@implementation VoiceredViewController
{
    UITableView *_MytableView;
    NSArray *_MydataArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self creatNavgationView];
    [self creatMainView];
    [self creatData];

    
}

-(void)creatNavgationView
{
    UIImageView *headview=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 64)];
    headview.image=[UIImage imageNamed:@"导航背景"];
    [self.view addSubview:headview];
    headview.userInteractionEnabled=YES;
    
    UIButton *backbtn=[UIButton buttonWithType:UIButtonTypeCustom];
    backbtn.frame=CGRectMake(0, 20, 80, 44);
    [backbtn addTarget:self action:@selector(leftBarButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    [backbtn setImage:[UIImage imageNamed:@"返回按钮_正常"] forState:UIControlStateNormal];
    [backbtn setImage:[UIImage imageNamed:@"返回按钮_高亮"] forState:UIControlStateHighlighted];
    [headview addSubview:backbtn];
    
    UILabel *titlelable=[[UILabel alloc]init];
    titlelable.frame=CGRectMake(0, 0, headview.frame.size.width, 40);
    titlelable.center=CGPointMake(kScreenWidth/2, headview.frame.size.height/2+10);
    titlelable.text= @"语音红包";
    titlelable.font = [UIFont systemFontOfSize:ZOOM(57)];
    titlelable.textColor=[UIColor blackColor];
    titlelable.textAlignment=NSTextAlignmentCenter;
    [headview addSubview:titlelable];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, headview.frame.size.height-1, kScreenWidth, 1)];
    line.backgroundColor=lineGreyColor;
    [headview addSubview:line];
}


- (void)creatMainView
{
    
    _MytableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight-64+kUnderStatusBarStartY) style:UITableViewStylePlain];
    _MytableView.delegate = self;
    _MytableView.dataSource = self;
    _MytableView.scrollEnabled = NO;
    [self.view addSubview:_MytableView];

    _MytableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_MytableView registerNib:[UINib nibWithNibName:@"PersonCenterCell" bundle:nil] forCellReuseIdentifier:@"Cell"];
    
    
}

- (void)creatData
{
    _MydataArray = @[@"我要发红包",@"已发的红包"];
    [_MytableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _MydataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 55;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    PersonCenterCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (_MydataArray.count) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
       
        if(indexPath.row == 0)
        {
             cell.headImg.image=[UIImage imageNamed:[NSString stringWithFormat:@"%@",@"我要发红包"]];
        }else{
            cell.headImg.image=[UIImage imageNamed:[NSString stringWithFormat:@"%@",@"已发的红包"]];
        }
        
        cell.nameLabel.text=_MydataArray[indexPath.row];
        cell.nameLabel.font = [UIFont systemFontOfSize:ZOOM(51)];
        
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 0)//我要发红包
    {
        WantSendredViewController *wantsend = [[WantSendredViewController alloc]init];
        wantsend.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:wantsend animated:YES];
        
    }else if (indexPath.row == 1)//已发的红包
    {
        SendenvelopeViewController *sendred = [[SendenvelopeViewController alloc]init];
        sendred.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:sendred animated:YES];
    }
}
- (void)leftBarButtonClick
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
