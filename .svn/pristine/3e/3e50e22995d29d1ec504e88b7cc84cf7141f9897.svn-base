//
//  TopicReportView.m
//  YunShangShiJi
//
//  Created by ios-1 on 2017/2/20.
//  Copyright © 2017年 ios-1. All rights reserved.
//

#import "TopicReportView.h"
#import "ReportTableViewCell.h"
#import "ReportModel.h"
#import "GlobalTool.h"
@implementation TopicReportView
{
    CGFloat invitcodeYY;                  //弹框初始y坐标
    CGFloat ShareInvitationCodeViewHeigh; //弹框的高度
    CGFloat ShareInvitationCodeViewWidth; //弹框的宽度
    
    NSString *reportStr;
}
- (instancetype)initWithFrame:(CGRect)frame;
{
    if(self = [super initWithFrame:frame])
    {
        [self creatpopView];
        [self creatData:0];
    }
    return self;
}

- (void)creatData:(NSInteger)index
{
    NSArray *data = @[@"广告",@"色情",@"人身攻击",@"其它(段子/水帖等)"];
    for(int i=0;i<data.count;i++)
    {
        ReportModel *model = [[ReportModel alloc]init];
        model.title = data[i];
        model.is_select = i==index?@"选中":@"未选中";
        if([model.is_select isEqualToString:@"选中"])
        {
            reportStr = model.title;
        }
        [self.dataArray addObject:model];
    }
    [self.mytableView reloadData];
}
- (void)creatpopView
{
    self.popBackView = [[UIView alloc]initWithFrame:CGRectMake(0, 0,kScreenWidth, kScreenHeight)];
    self.popBackView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
    self.popBackView.userInteractionEnabled = YES;
    [self addSubview:self.popBackView];
    
    ShareInvitationCodeViewWidth = (kScreenWidth-ZOOM6(100)*2);
    ShareInvitationCodeViewHeigh = ZOOM6(600);
    invitcodeYY = (kScreenHeight - ShareInvitationCodeViewHeigh)/2-ZOOM6(20);
    
    self.mytableView = [[UITableView alloc]initWithFrame:CGRectMake(ZOOM6(100), invitcodeYY, ShareInvitationCodeViewWidth, ShareInvitationCodeViewHeigh) style:UITableViewStylePlain];
    self.mytableView.backgroundColor = [UIColor whiteColor];
    self.mytableView.dataSource = self;
    self.mytableView.delegate = self;
    self.mytableView.scrollEnabled = NO;
    self.mytableView.rowHeight = ZOOM6(80);
    self.mytableView.layer.cornerRadius = 5;
    self.mytableView.tableHeaderView = [self creatTableHeadView];
    self.mytableView.tableFooterView = [self creatTableFootView];
    [self.mytableView registerNib:[UINib nibWithNibName:@"ReportTableViewCell" bundle:nil] forCellReuseIdentifier:@"CELL"];
    [self.popBackView addSubview:self.mytableView];
    
    self.mytableView.transform = CGAffineTransformMakeScale(0.3, 0.3);
    self.mytableView.alpha = 0.5;
    
    self.popBackView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
    [UIView animateWithDuration:0.5 animations:^{
        
        self.popBackView.backgroundColor = [[UIColor colorWithRed:0 green:0 blue:0 alpha:0] colorWithAlphaComponent:0.5];
        
        self.mytableView.transform = CGAffineTransformMakeScale(1, 1);
        self.mytableView.alpha = 1;
        
    } completion:^(BOOL finish) {
        
    }];

}

- (UIView*)creatTableHeadView
{
    UIView *headview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.mytableView.frame), ZOOM6(140))];
    headview.backgroundColor = [UIColor whiteColor];

    UILabel *titlelab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.mytableView.frame), ZOOM6(140))];
    titlelab.textColor = RGBCOLOR_I(62, 62, 62);
    titlelab.font = [UIFont systemFontOfSize:ZOOM6(36)];
    titlelab.textAlignment = NSTextAlignmentCenter;
    titlelab.text = @"举报原因";
    
    UILabel *linelab = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetHeight(titlelab.frame)-1, CGRectGetWidth(self.mytableView.frame), 1)];
    linelab.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    [headview addSubview:titlelab];
    [headview addSubview:linelab];
    return headview;
}
-(UIView*)creatTableFootView
{
    UIView *footview = [[UIView alloc]initWithFrame:CGRectMake(0, 1, CGRectGetWidth(self.mytableView.frame), ZOOM6(140))];
    footview.backgroundColor = [UIColor whiteColor];
    
    CGFloat btnwith = (CGRectGetWidth(self.mytableView.frame)-3*ZOOM6(20))/2;
    CGFloat btnheigh= ZOOM6(80);
    for(int i =0;i<2;i++)
    {
        UIButton *button = [[UIButton alloc]init];
        button.frame = CGRectMake(ZOOM6(20)+(btnwith+ZOOM6(20))*i, (CGRectGetHeight(footview.frame)-btnheigh)/2, btnwith, btnheigh);
        button.titleLabel.font = [UIFont systemFontOfSize:ZOOM6(30)];
        button.layer.cornerRadius = 5;
        if(i == 0)
        {
            button.layer.borderWidth = 1;
            button.layer.borderColor = tarbarrossred.CGColor;
            [button setTitle:@"举报" forState:UIControlStateNormal];
            [button setTitleColor:tarbarrossred forState:UIControlStateNormal];
            [button addTarget:self action:@selector(report:) forControlEvents:UIControlEventTouchUpInside];
        }else{
            button.backgroundColor = tarbarrossred;
            [button setTitle:@"取消" forState:UIControlStateNormal];
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [button addTarget:self action:@selector(cancel:) forControlEvents:UIControlEventTouchUpInside];
        }
    
        [footview addSubview:button];
    }
    
    
    return footview;
}

- (void)report:(UIButton*)sender
{
    if(self.reportBlock)
    {
        self.reportBlock(reportStr);
    }
    [self remindViewHiden];
}

- (void)cancel:(UIButton*)sender
{
    [self remindViewHiden];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.dataArray removeAllObjects];
    
    [self creatData:indexPath.row];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ReportTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CELL"];
    if(cell == nil)
    {
        cell = [[ReportTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"CELL"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    ReportModel *model = _dataArray[indexPath.row];
    [cell refreshView:model];
    return cell;
}

- (void)dismissClick:(UITapGestureRecognizer*)tap
{
    [self remindViewHiden];
}

#pragma mark 弹框消失
- (void)remindViewHiden
{
    [UIView animateWithDuration:0.5 animations:^{
        
        self.popBackView.backgroundColor = [[UIColor colorWithRed:0 green:0 blue:0 alpha:0] colorWithAlphaComponent:0];
        self.mytableView.transform = CGAffineTransformMakeScale(0.25, 0.25);
        self.mytableView.alpha = 0;
        
    } completion:^(BOOL finish) {
        
        [self removeFromSuperview];
    }];
    
}

- (NSMutableArray*)dataArray
{
    if(_dataArray == nil)
    {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
@end
