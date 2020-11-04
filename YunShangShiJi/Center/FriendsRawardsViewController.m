//
//  FriendsRawardsViewController.m
//  YunShangShiJi
//
//  Created by ios-1 on 2017/12/13.
//  Copyright © 2017年 ios-1. All rights reserved.
//

#import "FriendsRawardsViewController.h"
#import "FriendsRawardsTableViewCell.h"
#import "FriendsRawardModel.h"
#import "MBProgressHUD+NJ.h"
#import "MBProgressHUD+XJ.h"
#import "AFNetworking.h"
#import "GlobalTool.h"
#import "AppDelegate.h"


#define kYellowColor RGBA(255, 63, 139, 1)
#define kRedColor RGBA(255, 0, 76, 1)
@interface FriendsRawardsViewController ()

@end

@implementation FriendsRawardsViewController
{
    NSInteger currentPage;        //当前页
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    currentPage = 0;
    
    [self httpGetDayReward:NO];
    
    [self creatNavagationbar];
    
}

- (void)httpGetDayReward:(BOOL)isfresh {
    [[APIClient sharedManager]netWorkGeneralRequestWithApi:@"wallet/getTcToDayCount?" caches:NO cachesTimeInterval:0 token:YES success:^(id data, Response *response) {
        [self.mytableview headerEndRefreshing];
        [self.mytableview footerEndRefreshing];
        if (response.status == 1) {
            
            currentPage ++;
            
            NSDictionary *dic = data[@"data"];
            self.dayRewardStr = [NSString stringWithFormat:@"%@-%@-%@-%@-%@-%@",dic[@"xj_num"]?:@"0",dic[@"f_money"]?:@"0",dic[@"ed_num"]?:@"0",dic[@"f_extra"]?:@"0",dic[@"money"]?:@"0",dic[@"extra"]?:@"0"];
            NSArray *userArray = dic[@"listUser"];
            for(NSDictionary *ddic in userArray)
            {
                FriendsRawardModel *model = [[FriendsRawardModel alloc]init];
                model.add_date = [NSString stringWithFormat:@"%@",ddic[@"add_date"]];
                model.user_id = [NSString stringWithFormat:@"%@",ddic[@"user_id"]];
                model.nickname = [NSString stringWithFormat:@"%@",ddic[@"nickname"]];
                model.f_extra = [NSString stringWithFormat:@"%@",ddic[@"f_extra"]];
                model.pic = [NSString stringWithFormat:@"%@",ddic[@"pic"]];
                model.f_money = [NSString stringWithFormat:@"%@",ddic[@"f_money"]];
                
                [self.mydataArray addObject:model];
            }
            
//            FriendsRawardModel *model = [[FriendsRawardModel alloc]init];
//            model.add_date = @"20160317";
//            model.user_id = @"林晓霖";
//            model.nickname = @"林晓霖";
//            model.f_money = @"500";
//            model.f_extra = @"100";
//            model.pic = @"userinfo/head_pic/default.jpg";
//            [self.mydataArray addObject:model];
            
            if(isfresh)
            {
                [self.mytableview reloadData];
            }else{
                [self creatTableView];
            }

        }
        
    } failure:^(NSError *error) {
        
    }];
}

//导航条
- (void)creatNavagationbar
{
    self.navheadview=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kApplicationWidth, Height_NavBar)];
    [self.view addSubview:self.navheadview];
    self.navheadview.userInteractionEnabled=YES;
    
    UIButton *backbtn=[UIButton buttonWithType:UIButtonTypeCustom];
    backbtn.frame=CGRectMake(0, 20, 44, 44);
    backbtn.centerY = View_CenterY(self.navheadview);
    [backbtn setImage:[UIImage imageNamed:@"返回按钮_正常"] forState:UIControlStateNormal];
    [backbtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [self.navheadview addSubview:backbtn];
    
    UILabel *titlelable=[[UILabel alloc]init];
    titlelable.frame=CGRectMake(0, 0, 300, 40);
    titlelable.center=CGPointMake(kApplicationWidth/2, self.navheadview.frame.size.height/2+10);
    titlelable.text=@"好友奖励";
    titlelable.font=kNavTitleFontSize;
    titlelable.textColor=kMainTitleColor;
    titlelable.textAlignment=NSTextAlignmentCenter;
    [self.navheadview addSubview:titlelable];
    
    UIView *hView = [[UIView alloc] initWithFrame:CGRectMake(0, self.navheadview.frame.size.height-1, self.navheadview.frame.size.width, 1)];
    hView.backgroundColor = RGBCOLOR_I(220,220,220);
    [self.navheadview addSubview:hView];

}
- (UIView*)tabheadview{
    if(_tabheadview == nil)
    {
        _tabheadview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, ZOOM6(600))];
        
        
        UILabel *titlelabel = [[UILabel alloc]initWithFrame:CGRectMake(0, ZOOM6(20), CGRectGetWidth(_tabheadview.frame), ZOOM6(80))];
        titlelabel.textColor = RGBCOLOR_I(62, 62, 62);
        titlelabel.backgroundColor = [UIColor clearColor];
        titlelabel.font = [UIFont systemFontOfSize:ZOOM6(36)];
        titlelabel.textAlignment = NSTextAlignmentCenter;
        titlelabel.text = @"今日共有";
        [_tabheadview addSubview:titlelabel];
        
        UILabel *firstLabel=[[UILabel alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(titlelabel.frame), CGRectGetWidth(titlelabel.frame), ZOOM6(50))];
        firstLabel.textAlignment=NSTextAlignmentCenter;
        firstLabel.font=kFont6px(30);
        firstLabel.textColor=RGBCOLOR_I(62, 62, 62);
        
        NSArray *arr = self.dayRewardStr.length>10?[self.dayRewardStr componentsSeparatedByString:@"-"]:@[@"0",@"0",@"0",@"0",@"0",@"0"];
        
        NSString *str1 = [NSString stringWithFormat:@"%@位好友赢得%@元余额",arr[0],arr[1]];
        [firstLabel setAttributedText:[NSString getOneColorInLabel:str1 strs:@[arr[0],[NSString stringWithFormat:@"%@元",arr[1]]] Color:kYellowColor fontSize:ZOOM6(48)]];
        [_tabheadview addSubview:firstLabel];
        
        UILabel *secondLabel=[[UILabel alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(firstLabel.frame), CGRectGetWidth(titlelabel.frame), ZOOM6(50))];
        secondLabel.textAlignment=NSTextAlignmentCenter;
        secondLabel.font=kFont6px(30);
        secondLabel.textColor=RGBCOLOR_I(62, 62, 62);
        
        NSString *str2 = [NSString stringWithFormat:@"%@位好友赢得%@元提现",arr[2],arr[3]];
        [secondLabel setAttributedText:[NSString getOneColorInLabel:str2 strs:@[arr[2],[NSString stringWithFormat:@"%@元",arr[3]]] Color:kYellowColor fontSize:ZOOM6(48)]];
        [_tabheadview addSubview:secondLabel];
        
        UILabel *thirdLabel=[[UILabel alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(secondLabel.frame)+ZOOM6(60), CGRectGetWidth(titlelabel.frame), ZOOM6(50))];
        thirdLabel.textAlignment=NSTextAlignmentCenter;
        thirdLabel.font=kFont6px(36);
        thirdLabel.text=@"我拿到好友奖励";
        thirdLabel.textColor=kYellowColor;
        [_tabheadview addSubview:thirdLabel];
        
        UILabel *fourLabel=[[UILabel alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(thirdLabel.frame)+ZOOM6(10), CGRectGetWidth(titlelabel.frame)/2, ZOOM6(60))];
        fourLabel.textAlignment=NSTextAlignmentCenter;
        fourLabel.font=kFont6px(36);
        
        [fourLabel setAttributedText: [NSString getOneColorInLabel:[NSString stringWithFormat:@"%@元",arr[4]] ColorString:arr[4] Color:kYellowColor fontSize:ZOOM6(60)]];
        fourLabel.textColor=kYellowColor;
        [_tabheadview addSubview:fourLabel];
        
        UILabel *fiveLabel=[[UILabel alloc]initWithFrame:CGRectMake(fourLabel.x,CGRectGetMaxY(fourLabel.frame)+ZOOM6(10), fourLabel.width, ZOOM6(50))];
        fiveLabel.textAlignment=NSTextAlignmentCenter;
        fiveLabel.font=kFont6px(36);
        fiveLabel.text=@"余额";
        fiveLabel.textColor=kYellowColor;
        [_tabheadview addSubview:fiveLabel];
        
        UILabel *middleline = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth/2, CGRectGetMaxY(thirdLabel.frame)+ZOOM6(40), 1, ZOOM6(60))];
        middleline.backgroundColor = kYellowColor;
        [_tabheadview addSubview:middleline];
        
        UILabel *sixLabel=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetWidth(titlelabel.frame)/2,CGRectGetMaxY(thirdLabel.frame)+ZOOM6(10), CGRectGetWidth(titlelabel.frame)/2, ZOOM6(60))];
        sixLabel.textAlignment=NSTextAlignmentCenter;
        sixLabel.font=kFont6px(36);
        [sixLabel setAttributedText: [NSString getOneColorInLabel:[NSString stringWithFormat:@"%@元",arr[5]] ColorString:arr[5] Color:kYellowColor fontSize:ZOOM6(60)]];
        sixLabel.textColor=kYellowColor;
        [_tabheadview addSubview:sixLabel];
        
        UILabel *sevenLabel=[[UILabel alloc]initWithFrame:CGRectMake(sixLabel.x,CGRectGetMaxY(fourLabel.frame)+ZOOM6(10), sixLabel.width, ZOOM6(50))];
        sevenLabel.textAlignment=NSTextAlignmentCenter;
        sevenLabel.font=kFont6px(36);
        sevenLabel.text=@"提现";
        sevenLabel.textColor=kYellowColor;
        [_tabheadview addSubview:sevenLabel];
        
        UILabel *spaceline = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(sevenLabel.frame)+ZOOM6(40), kScreenWidth, ZOOM6(20))];
        spaceline.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [_tabheadview addSubview:spaceline];

        UILabel *bottomlab = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(spaceline.frame)+ZOOM6(30), kScreenWidth, ZOOM6(40))];
        bottomlab.text = @"好友获得今日奖励";
        bottomlab.font = [UIFont systemFontOfSize:ZOOM6(36)];
        bottomlab.textAlignment = NSTextAlignmentCenter;
        bottomlab.textColor = RGBCOLOR_I(62, 62, 62);
        [_tabheadview addSubview:bottomlab];

        UILabel *bottomline = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_tabheadview.frame)-1, kScreenWidth, 1)];
        bottomline.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [_tabheadview addSubview:bottomline];

    }
    return _tabheadview;
}
- (void)creatTableView
{
    self.mytableview=[[UITableView alloc]initWithFrame:CGRectMake(0, Height_NavBar, kScreenWidth, kScreenHeight-Height_NavBar+kUnderStatusBarStartY) style:UITableViewStylePlain];
    self.mytableview.dataSource=self;
    self.mytableview.delegate=self;
    self.mytableview.rowHeight=80;
    self.mytableview.tableHeaderView = self.tabheadview;
    self.mytableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.mytableview];
    
    [self.mytableview registerNib:[UINib nibWithNibName:@"FriendsRawardsTableViewCell" bundle:nil] forCellReuseIdentifier:@"rawardcell" ];
    
    kWeakSelf(self);
    [self.mytableview addHeaderWithCallback:^{
        currentPage = 1;
        
        [weakself.mydataArray removeAllObjects];
        
        [weakself httpGetDayReward:YES];
    }];
    
    [self.mytableview addFooterWithCallback:^{
        
        [weakself httpGetDayReward:YES];
    }];

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return self.mydataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    
    static NSString *identifier=@"rawardcell";
    FriendsRawardsTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
    if(!cell)
    {
        cell=[[FriendsRawardsTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    FriendsRawardModel *model = self.mydataArray[indexPath.row];
    [cell refreshData:model];
    return cell;
}

- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (NSMutableArray*)mydataArray
{
    if(_mydataArray == nil)
    {
        _mydataArray = [NSMutableArray array];
    }
    return _mydataArray;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
