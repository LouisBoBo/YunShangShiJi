//
//  OneIndianaPopView.m
//  YunShangShiJi
//
//  Created by ios-1 on 2017/6/28.
//  Copyright © 2017年 ios-1. All rights reserved.
//

#import "OneIndianaPopView.h"
#import "GlobalTool.h"
#import "IndianaPopModel.h"
#import "IndianPopTableViewCell.h"
#import "NavgationbarView.h"
#import "MBProgressHUD.h"
#import "MBProgressHUD+NJ.m"
#import "IndianaPublicModel.h"
#import "YFShareModel.h"
#define codeYY (kScreenHeight - ZOOM6(650))/2
#define CodeViewHeigh ZOOM6(650)


@implementation OneIndianaPopView
{
    CGFloat shareimageYY ;
    NSString *str3;
    NSString *str4;
    
    BOOL is_rdecent;      //是否是一分钱夺宝
    int changeCount;      //参与次数
    int dayShareCount;    //当天分享的次数
    int recordshareCount;
    int recordduobaoCount;
    
}

- (instancetype)initWithFrame:(CGRect)frame Surplus:(NSInteger)Surplus ToalCount:(NSInteger)totalCount;
{
    if(self = [super initWithFrame:frame])
    {
        self.totalCount = totalCount;
        self.Surplus = Surplus;
        self.se_price = @"1";
        [self creatData];
    }
    
    return self;
}

- (void)creatData
{
    NSString *price = [NSString stringWithFormat:@"￥%.1f",self.se_price.floatValue];
    NSString *se_price = [NSString stringWithFormat:@"-￥%.2f",self.se_price.floatValue-0.01];
    NSArray *titltArr = @[@"结算",@"参与次数",@"应付总额"];
    NSArray *contentArr = @[@"取消",@"1",price,se_price];
    
    for(int i=0;i<3;i++)
    {
        IndianaPopModel *model = [[IndianaPopModel alloc]init];
        model.title = titltArr[i];
        model.content = contentArr[i];
        [self.duobaoData addObject:model];
    }
    
    [self creaPopview];
}
//主弹框
- (void)creaPopview
{
    //弹框最底层
    _SharePopview = [[UIView alloc]initWithFrame:CGRectMake(0, 0,kScreenWidth, kScreenHeight)];
    _SharePopview.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
    _SharePopview.userInteractionEnabled = YES;
    [self addSubview:_SharePopview];
    
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismisspop:)];
//    [_SharePopview addGestureRecognizer:tap];
    
    [_SharePopview addSubview:[self shareOrderView]];
    
    _SharePopview.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
    
    [UIView animateWithDuration:0.5 animations:^{
        
        _SharePopview.backgroundColor = [[UIColor colorWithRed:0 green:0 blue:0 alpha:0] colorWithAlphaComponent:0.5];
        
         CGFloat OrderViewheigh = ZOOM6(400);
        _ShareInvitationOrderView.frame = CGRectMake(0, CGRectGetHeight(_SharePopview.frame)-OrderViewheigh, CGRectGetWidth(_SharePopview.frame), OrderViewheigh);
        _confirmView.frame = CGRectMake(0, OrderViewheigh-ZOOM6(100), kScreenWidth, ZOOM6(100));

    } completion:^(BOOL finish) {
        
    }];
    
}

//下弹框内容
- (UIView*)shareOrderView
{
    if(!_ShareInvitationOrderView)
    {
        _ShareInvitationOrderView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetHeight(_SharePopview.frame)+ZOOM6(50), CGRectGetWidth(_SharePopview.frame), ZOOM6(400))];
        _ShareInvitationOrderView.backgroundColor = [UIColor whiteColor];
        
        [_ShareInvitationOrderView addSubview:self.orderTableView];
        
        _confirmView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetHeight(_ShareInvitationOrderView.frame)-ZOOM6(100), kScreenWidth, ZOOM6(100))];
        _confirmView.backgroundColor = [UIColor whiteColor];
        
        _confirmBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        _confirmBtn.frame = CGRectMake(ZOOM6(20), (CGRectGetHeight(_confirmView.frame)-ZOOM6(80))/2, CGRectGetWidth(_ShareInvitationOrderView.frame)-ZOOM6(20)*2, ZOOM6(80));
        _confirmBtn.backgroundColor = tarbarrossred;
        _confirmBtn.layer.cornerRadius=3;

        _confirmBtn.titleLabel.font = [UIFont systemFontOfSize:ZOOM6(36)];
        [_confirmBtn setTitle:@"确定" forState:UIControlStateNormal];
        [_confirmBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        [_confirmBtn addTarget:self action:@selector(confirmClick:) forControlEvents:UIControlEventTouchUpInside];
        [_confirmView addSubview:_confirmBtn];
        [_ShareInvitationOrderView addSubview:_confirmView];
    }
    return _ShareInvitationOrderView;
}

- (UITableView*)orderTableView
{
    if(_orderTableView == nil)
    {
        CGFloat imagewidth = CGRectGetWidth(_ShareInvitationOrderView.frame);
        CGFloat imageHeigh = ZOOM6(500);
        
        _orderTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, imagewidth, imageHeigh) style:UITableViewStylePlain];
        _orderTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _orderTableView.scrollEnabled = NO;
        _orderTableView.delegate= self;
        _orderTableView.dataSource = self;
        [_ShareInvitationOrderView addSubview:_orderTableView];
        
        [_orderTableView registerNib:[UINib nibWithNibName:@"IndianPopTableViewCell" bundle:nil] forCellReuseIdentifier:@"Popcell"];
    }
    return _orderTableView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return ZOOM6(100);
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _duobaoData.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    IndianPopTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Popcell"];
    if(!cell)
    {
        cell = [[IndianPopTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"Popcell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    IndianaPopModel *model = self.duobaoData[indexPath.row];
    [cell refreshData:model Max:self.Surplus];
    kWeakSelf(self);
    cell.cancleBlock = ^{
        [weakself disapper];
    };
    
    cell.numberBlock = ^(NSInteger num){
        if(num >= self.Surplus)
        {
            recordduobaoCount++;
            NSString *message = [NSString stringWithFormat:@"一次最多只能参与%zd次哦~",self.Surplus];
            recordduobaoCount>1?[MBProgressHUD show:message icon:nil view:self]:nil;
        }else if (num >=2 && ((self.Surplus<self.totalCount*0.2) || (self.Surplus-num) < self.totalCount*0.2)){
            recordduobaoCount++;
            [MBProgressHUD show:@"期满即开奖，参与记录可能被分散在两期内" icon:nil view:self];
        }else{
            recordduobaoCount=0;
        }
        
        IndianaPopModel *duobaomodel = self.duobaoData[2];
        CGFloat price = self.se_price.floatValue*num;
        duobaomodel.content = [NSString stringWithFormat:@"￥%.1f",price];
        
        model.content = [NSString stringWithFormat:@"%zd",num];
        [self.orderTableView reloadData];
    };
    return cell;
}

#pragma mark 确定
- (void)confirmClick:(UIButton*)sender
{
    NSString *se_price = @"";
    NSString *num = @"";
    NSString *ReductionPrice = @"";
    
    IndianaPopModel *sharemodel = self.duobaoData[1];
    num = sharemodel.content;
    se_price = self.se_price;
    ReductionPrice = nil;

    if(self.confirmOrderBlock)
    {
        self.confirmOrderBlock(se_price,num,ReductionPrice);
    }
    [self disapper];
}
#pragma mark 关闭弹框
- (void)dismisspop:(UITapGestureRecognizer*)tap
{
    [self disapper];
}
#pragma mark 关闭弹框
- (void)cancleClick
{
    [self disapper];
}

- (void)disapper
{
//    if(self.tapHideMindBlock)
//    {
//        self.tapHideMindBlock();
//    }
    
    [self remindViewHiden];
}

#pragma mark 弹框消失
- (void)remindViewHiden
{
    [UIView animateWithDuration:0.5 animations:^{
        
        _SharePopview.backgroundColor = [[UIColor colorWithRed:0 green:0 blue:0 alpha:0] colorWithAlphaComponent:0];
        _ShareInvitationOrderView.frame = CGRectMake(0, CGRectGetHeight(_SharePopview.frame)+ZOOM6(50), CGRectGetWidth(_SharePopview.frame), ZOOM6(600));
        
    } completion:^(BOOL finish) {
        
        [self removeFromSuperview];
        
    }];
}

- (NSMutableArray*)duobaoData
{
    if(_duobaoData == nil)
    {
        _duobaoData = [NSMutableArray array];
    }
    return _duobaoData;
}

@end
