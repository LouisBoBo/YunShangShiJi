//
//  WithdrawalsViewController.m
//  YunShangShiJi
//
//  Created by ios-1 on 15/10/28.
//  Copyright © 2015年 ios-1. All rights reserved.
//

#import "WithdrawalsViewController.h"
#import "GlobalTool.h"
#import "UIImageView+WebCache.h"
#import "BrokerageCell.h"
#import "AFNetworking.h"    
#import "MyMD5.h"
#import "TFWithdrawCashViewController.h"
#import "NavgationbarView.h"

#define kLabelColor RGBCOLOR_I(102, 102, 102)



@interface WithdrawalsViewController ()
{
    UITableView *_MytableView;
    UIImageView *_headImgView;
    UILabel *_nameLabel;
    UILabel *_timeLabel;
    UILabel *_allMoneyLabel;
    UILabel *_successLabel;          //成功提现
    UILabel *_brokerageLabel1;       //累计佣金
    UILabel *_brokerageLabel2;       //未结算佣金
    
    UIButton *_leftBtn;             //提现纪录
    UIButton *_rightBtn;            //佣金纪录
    
    NSMutableArray *_withdrawalsArray;  //提现数组
    NSMutableArray *_brokerageArray;    //佣金数组
    
    UISegmentedControl *subSegment;
    NSInteger selectIndex;             //segment选择
 
    BOOL isFirstIn;
}
@property (nonatomic, assign)int currentpageWithdrawals;
@property (nonatomic, assign)int currentpageBrokerage;

@end

@implementation WithdrawalsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets=NO;
    
    isFirstIn=YES;
    selectIndex=0;
    _currentpageBrokerage=1;
    _currentpageWithdrawals=1;
    
    _withdrawalsArray = [NSMutableArray array];
    _brokerageArray = [NSMutableArray array];
    
    
    [self creatNavgationView];
    [self creatView];
    [self creatFootBtn];
    [self reloadHeadView];
    
}
-(void)viewDidAppear:(BOOL)animated
{
    _currentpageWithdrawals=1;
    [self httpWithdrawals];
//    [self httpData];

}
-(void)creatNavgationView
{
    UIImageView *headview=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, Height_NavBar)];
    headview.image=[UIImage imageNamed:@"导航背景"];
    [self.view addSubview:headview];
    headview.userInteractionEnabled=YES;
    
    UIButton *backbtn=[UIButton buttonWithType:UIButtonTypeCustom];
    backbtn.frame=CGRectMake(0, 20, 44, 44);
    backbtn.centerY = View_CenterY(headview);
    [backbtn addTarget:self action:@selector(leftBarButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    [backbtn setImage:[UIImage imageNamed:@"返回按钮_正常"] forState:UIControlStateNormal];
//    [backbtn setImage:[UIImage imageNamed:@"返回按钮_高亮"] forState:UIControlStateHighlighted];
    [headview addSubview:backbtn];
    
    UILabel *titlelable=[[UILabel alloc]init];
    titlelable.frame=CGRectMake(0, 0, headview.frame.size.width, 40);
    titlelable.center=CGPointMake(kScreenWidth/2, headview.frame.size.height/2+10);
    titlelable.text= @"佣金记录";
    titlelable.font = kNavTitleFontSize;
    titlelable.textColor=kMainTitleColor;
    titlelable.textAlignment=NSTextAlignmentCenter;
    [headview addSubview:titlelable];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, headview.frame.size.height-1, kScreenWidth, 1)];
    line.backgroundColor=lineGreyColor;
    [headview addSubview:line];
}
- (void)leftBarButtonClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark 创建主界面
-(void)creatView
{
    _MytableView = [[UITableView alloc]initWithFrame:CGRectMake(0, Height_NavBar, kApplicationWidth, kScreenHeight-Height_NavBar-ZOOM(150)) style:UITableViewStyleGrouped];
    _MytableView.backgroundColor = [UIColor whiteColor];
    _MytableView.delegate = self;
    _MytableView.dataSource = self;
    _MytableView.tableHeaderView = [self headview];
    _MytableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    [_MytableView registerNib:[UINib nibWithNibName:@"BrokerageCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:_MytableView];
    
    __weak WithdrawalsViewController *tfld = self;
    //加上拉刷新
    [_MytableView addFooterWithCallback:^{

        
        switch (subSegment.selectedSegmentIndex) {
            case 0:
            {
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    tfld.currentpageWithdrawals++;
                    [tfld httpWithdrawals];
                    
                });
            }
                break;
            case 1:
            {
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    tfld.currentpageBrokerage++;
                    [tfld httpBrokerage];
                });
            }
                break;
                
        }
    }];
}
#pragma mark - 提现按钮
-(void)creatFootBtn
{
    UIButton *footBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    footBtn.frame = CGRectMake(0, kScreenHeight-ZOOM(150), kScreenWidth, ZOOM(150));
    [footBtn setTintColor:tarbarrossred];
    footBtn.backgroundColor = tarbarrossred;
    [footBtn setTitle:@"我要提现" forState:UIControlStateNormal];
    [footBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    footBtn.titleLabel.font=[UIFont systemFontOfSize:ZOOM(50)];
    [footBtn addTarget:self action:@selector(footBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:footBtn];
    
}
-(void)footBtnClick
{
    //我要提现");
    TFWithdrawCashViewController *tvc = [[TFWithdrawCashViewController alloc] init];
    tvc.type = Withdrawals;
    [self.navigationController pushViewController:tvc animated:YES];
}
#pragma mark - tableHeaderView
-(UIView *)headview
{
//    CGFloat imgWidth = 70;
//    CGFloat imgHeight = 80;
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 500)];
    //    headView.backgroundColor=DRandomColor;
    
    _headImgView = [[UIImageView alloc]initWithFrame:CGRectMake(ZOOM(40), ZOOM(55), ZOOM(180), ZOOM(180))];
    _headImgView.backgroundColor = DRandomColor;
    [headView addSubview:_headImgView];
    
    _nameLabel = [[UILabel alloc]init];
    _nameLabel.frame = CGRectMake(CGRectGetMaxX(_headImgView.frame)+ZOOM(44), ZOOM(80), kScreenWidth-CGRectGetMaxX(_headImgView.frame)-ZOOM(44), ZOOM(80));
    _nameLabel.font = [UIFont systemFontOfSize:ZOOM(50)];
    [headView addSubview:_nameLabel];
    
    _timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(_nameLabel.frame.origin.x, CGRectGetMaxY(_nameLabel.frame)+ZOOM(25), _nameLabel.frame.size.width,  ZOOM(80))];
    _timeLabel.font = [UIFont systemFontOfSize:ZOOM(40)];
    _timeLabel.textColor=kLabelColor;
    [headView addSubview:_timeLabel];
    
    _allMoneyLabel =  [[UILabel alloc]initWithFrame:CGRectMake(_headImgView.frame.origin.x, CGRectGetMaxY(_headImgView.frame)+ZOOM(90), 200,  ZOOM(80))];
    _allMoneyLabel.font = [UIFont systemFontOfSize:ZOOM(80)];
    _allMoneyLabel.textColor=tarbarrossred;
    _allMoneyLabel.text = [NSString stringWithFormat:@"%.2f", [self.model.two_balance doubleValue]];
    [headView addSubview:_allMoneyLabel];
    
    
    NSString *st0 = [NSString stringWithFormat:@"已提现：%.2f元", [self.model.depositMoneySuccessSum doubleValue]];
    NSMutableAttributedString *maStr = [[NSMutableAttributedString alloc] initWithString:st0];
    [maStr addAttributes:@{NSForegroundColorAttributeName:COLOR_ROSERED} range:NSMakeRange(4, st0.length-5)];
    [maStr addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:ZOOM(40)]} range:NSMakeRange(0, 4)];
    [maStr addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:ZOOM(40)]} range:NSMakeRange(4, st0.length-5)];
    [maStr addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:ZOOM(40)]} range:NSMakeRange(st0.length-1, 1)];
    
    _successLabel = [[UILabel alloc]initWithFrame:CGRectMake(_headImgView.frame.origin.x, CGRectGetMaxY(_allMoneyLabel.frame)+ZOOM(25), kScreenWidth-ZOOM(40)*2,  ZOOM(80))];
    _successLabel.font=[UIFont systemFontOfSize:ZOOM(40)];
    _successLabel.textColor=kLabelColor;
    _successLabel.attributedText = maStr;
    [headView addSubview:_successLabel];
    
    UIView *spaceView = [[UIView alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(_successLabel.frame)+ZOOM(60) , kScreenWidth, 1)];
    spaceView.backgroundColor= RGBCOLOR_I(220,220,220);
    [headView addSubview:spaceView];
    
    UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(spaceView.frame)+ZOOM(63), kScreenWidth/2, ZOOM(80))];
    label1.font = [UIFont systemFontOfSize:ZOOM(50)];
    label1.textColor = kLabelColor;
    label1.textAlignment=NSTextAlignmentCenter;
    label1.text=@"累计佣金";
    [headView addSubview:label1];
    _brokerageLabel1=[[UILabel alloc]initWithFrame:CGRectMake(label1.frame.origin.x, CGRectGetMaxY(label1.frame)+ZOOM(25), label1.frame.size.width, ZOOM(80))];
    _brokerageLabel1.font=[UIFont systemFontOfSize:ZOOM(50)];
    _brokerageLabel1.textColor=tarbarrossred;
    _brokerageLabel1.textAlignment=NSTextAlignmentCenter;
    [headView addSubview:_brokerageLabel1];
    
    UIView *line2 = [[UIView alloc]initWithFrame:CGRectMake(kScreenWidth/2, label1.frame.origin.y, 1, label1.frame.size.height+_brokerageLabel1.frame.size.height+ZOOM(25))];
    line2.backgroundColor=lineGreyColor;
    [headView addSubview:line2];
    
    UILabel *label2 = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth/2, CGRectGetMaxY(spaceView.frame)+ZOOM(63), kScreenWidth/2, 25)];
    label2.font = [UIFont systemFontOfSize:ZOOM(50)];
    label2.textColor = kLabelColor;
    label2.text=@"未结算佣金";
    label2.textAlignment=NSTextAlignmentCenter;
    [headView addSubview:label2];
    _brokerageLabel2=[[UILabel alloc]initWithFrame:CGRectMake(label2.frame.origin.x, CGRectGetMaxY(label2.frame)+ZOOM(25), label2.frame.size.width, 25)];
    _brokerageLabel2.font=[UIFont systemFontOfSize:ZOOM(50)];
    _brokerageLabel2.textColor=tarbarrossred;
    _brokerageLabel2.textAlignment=NSTextAlignmentCenter;
    [headView addSubview:_brokerageLabel2];
    
    UIView *line3 = [[UIView alloc]initWithFrame:CGRectMake(_headImgView.frame.origin.x, CGRectGetMaxY(_brokerageLabel1.frame)+ZOOM(55), kScreenWidth-ZOOM(40)*2, 1)];
    line3.backgroundColor=lineGreyColor;
    [headView addSubview:line3];
    
    
    NSString *st = [NSString stringWithFormat:@"买家交易成功后，立即获得合伙人分红。每月可提现一次。"];
    
    CGSize size = [st boundingRectWithSize:CGSizeMake(kScreenWidth-CGRectGetMinX(_headImgView.frame)*2, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:ZOOM(40)]} context:nil].size;
    
    
    UILabel *explainLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(_headImgView.frame),CGRectGetMaxY(line3.frame)+ZOOM(40) , size.width, size.height)];
    explainLabel.textColor=RGBCOLOR_I(178, 178, 178);
    explainLabel.font=[UIFont systemFontOfSize:ZOOM(40)];
    explainLabel.numberOfLines=0;
    explainLabel.text = st;
    [headView addSubview:explainLabel];

    
    UIView *spaceView2 = [[UIView alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(explainLabel.frame)+ZOOM(40), kScreenWidth, ZOOM(40))];
    spaceView2.backgroundColor = RGBCOLOR_I(244,244,244);
    [headView addSubview:spaceView2];
    
    headView.frame=CGRectMake(0, 0, kScreenWidth, CGRectGetMaxY(spaceView2.frame));
    
    return headView;
}

/*******************  刷新头部信息  *****************/
-(void)reloadHeadView
{
//    [_headImgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", [NSObject baseURLStr_Upy], self.model.user_pic]]];
    
    if ([_model.user_pic hasPrefix:@"http://"]) {
        [_headImgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",_model.user_pic]]];
    }else{
        [_headImgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", [NSObject baseURLStr_Upy], _model.user_pic]]];
        
    }
    _nameLabel.text = self.model.user_name;
    _timeLabel.text = [NSString stringWithFormat:@"加入时间:%@",[MyMD5 getTimeToShowWithTimestamp:self.model.user_add_date]];
    _allMoneyLabel.text = [NSString stringWithFormat:@"%.2f",[self.model.two_balance doubleValue]];
//    _successLabel.text = [NSString stringWithFormat:@"成功提现:1632.00元"];
    _brokerageLabel1.text = [NSString stringWithFormat:@"%.2f" ,self.model.twbAll.doubleValue];
    _brokerageLabel2.text = [NSString stringWithFormat:@"%.2f",self.model.two_freeze_balance.doubleValue];
    
    
}
-(CGFloat )height:(NSMutableAttributedString *)attrString
{

    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    [paragraphStyle setLineSpacing:10];
    [attrString addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:ZOOM(40)],NSParagraphStyleAttributeName:paragraphStyle} range:NSMakeRange(0, attrString.length)];
    CGRect rect = [attrString boundingRectWithSize:CGSizeMake(kScreenWidth-2*ZOOM(103), MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin  context:nil];
    
    return rect.size.height;
}
#pragma mark - UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (subSegment.selectedSegmentIndex==1) {
        return _brokerageArray.count;
    }
    return _withdrawalsArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    BrokerageCell *cell = [_MytableView dequeueReusableCellWithIdentifier:@"cell"];
    
    DistributionModel *model;
    if (selectIndex==0 && _withdrawalsArray.count!=0) {
        model = _withdrawalsArray[indexPath.row];
        [cell refreshModelWithdrawals:model];
    }else if(selectIndex==1 && _brokerageArray.count!=0){
        model = _brokerageArray[indexPath.row];
        [cell refreshModel:model];
    }
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 50+ZOOM(74)*2-1, kScreenWidth, 1)];
    line.backgroundColor=lineGreyColor;
    [cell addSubview:line];
    
    return cell;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, ZOOM(130))];
    
    subSegment = [[UISegmentedControl alloc]initWithItems:@[@"提现纪录",@"佣金记录"]];
//    subSegment.backgroundColor = DRandomColor;
    subSegment.frame=CGRectMake(0, 0, kApplicationWidth, ZOOM(130)-2);
    subSegment.tintColor = [UIColor clearColor];
    NSDictionary* selectedTextAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:ZOOM(50)],
                                             NSForegroundColorAttributeName:tarbarrossred };
    [subSegment setTitleTextAttributes:selectedTextAttributes forState:UIControlStateSelected];//设置文字属性
    NSDictionary* unselectedTextAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:ZOOM(50)],
                                               NSForegroundColorAttributeName: RGBCOLOR_I(178, 178, 178) };
    [subSegment setTitleTextAttributes:unselectedTextAttributes forState:UIControlStateNormal];
    subSegment.selectedSegmentIndex=selectIndex;
    [subSegment addTarget:self action:@selector(BtnClick:) forControlEvents:UIControlEventValueChanged];
    [view addSubview:subSegment];


    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, view.frame.size.height-1, kScreenWidth, 1)];
    line.backgroundColor=lineGreyColor;
    [view addSubview:line];
    return view;
}
#pragma mark -  提现纪录  佣金记录 按钮点击
-(void)BtnClick:(UISegmentedControl *)sender
{
    //%ld",(long)subSegment.selectedSegmentIndex);
    switch (subSegment.selectedSegmentIndex) {
        case 0:
        {
            selectIndex=0;
            [_MytableView reloadData];
        }
            break;
        case 1:
        {
            selectIndex=1;
            if (isFirstIn) {
                [self httpBrokerage];
                isFirstIn=NO;
            }else
                [_MytableView reloadData];
        }
            break;
        default:
            break;
    }
}

#pragma mark - UITableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50+ZOOM(74)*2;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return ZOOM(130);
}
#pragma mark - 数据请求
-(void)httpData
{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *paraments=[NSMutableDictionary dictionary];
    NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
    NSString*token=[user objectForKey:USER_TOKEN];
    NSString *url=[NSString stringWithFormat:@"%@merchantAlliance/earningsDetail?version=%@&token=%@",[NSObject baseURLStr],VERSION,token];
    NSString *URL=[MyMD5 authkey:url];
    
    [manager GET:URL parameters:paraments success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //%@",responseObject);
        
//        responseObject = [NSDictionary changeType:responseObject];
        if (responseObject!=nil) {
            _successLabel.text = [NSString stringWithFormat:@"已经提现:%.2f元",[responseObject[@"depositMoneySuccessSum"]doubleValue]]; ;

        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        

        
    }];
}
/*********************   提现纪录  ******************/
-(void)httpWithdrawals
{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *paraments=[NSMutableDictionary dictionary];
    NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
    NSString*token=[user objectForKey:USER_TOKEN];
    NSString *url=[NSString stringWithFormat:@"%@merchantAlliance/selBankDeposit?version=%@&token=%@&page=%ld&sort=add_date&order=desc",[NSObject baseURLStr],VERSION,token,(long)_currentpageWithdrawals];
    NSString *URL=[MyMD5 authkey:url];
    
    [manager GET:URL parameters:paraments success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //%@",responseObject);
        [_MytableView footerEndRefreshing];   //停止刷新
        
//        responseObject = [NSDictionary changeType:responseObject];
        
        if (responseObject!=nil) {
            if ([responseObject[@"status"]integerValue]==1) {
              
                if (_currentpageWithdrawals == 1) {
                    [_withdrawalsArray removeAllObjects];
                }

                NSArray *arr = responseObject[@"data"];
                for(NSDictionary *dic in arr)
                {
                    DistributionModel *model = [[DistributionModel alloc]init];
                    model.collect_bank_code =  [NSString stringWithFormat:@"%@", dic[@"collect_bank_code"]];
                    model.collect_bank_name = [NSString stringWithFormat:@"%@", dic[@"collect_bank_name"]];
                    model.money = dic[@"money"];
                    model.add_date =[NSString stringWithFormat:@"%@", dic[@"add_date"]];
                    model.check =[NSString stringWithFormat:@"%@",dic[@"check"]];
                    
                    
                    [_withdrawalsArray addObject:model];
                }
            }else{
                NavgationbarView *mentionview=[[NavgationbarView alloc]init];
                [mentionview showLable:responseObject[@"message"] Controller:self];
            }
            
            [_MytableView reloadData];
        }

       
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [_MytableView footerEndRefreshing];   //停止刷新

        
        
    }];
}
/*********************   佣金纪录  ******************/
-(void)httpBrokerage
{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *paraments=[NSMutableDictionary dictionary];
    NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
    NSString*token=[user objectForKey:USER_TOKEN];
    NSString *url=[NSString stringWithFormat:@"%@merchantAlliance/selKickBack?version=%@&token=%@&page=%ld&sort=add_date&order=desc",[NSObject baseURLStr],VERSION,token,(long)_currentpageBrokerage];
    NSString *URL=[MyMD5 authkey:url];
    
    [manager GET:URL parameters:paraments success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //%@",responseObject);

        [_MytableView footerEndRefreshing];   //停止刷新
        
//        responseObject = [NSDictionary changeType:responseObject];
        
        if (responseObject!=nil) {
            if ([responseObject[@"status"]integerValue]==1) {
                
                if (_currentpageBrokerage == 1) {
                    [_brokerageArray removeAllObjects];
                }
                NSArray *arr = responseObject[@"data"];
                for(NSDictionary *dic in arr)
                {
                    DistributionModel *model = [[DistributionModel alloc]init];
                    model.NICKNAME =  [NSString stringWithFormat:@"%@",dic[@"user_name"]];
                    //%@",model.NICKNAME);
                    model.is_free = [NSString stringWithFormat:@"%@", dic[@"is_free"]];
                    model.money = dic[@"money"];
                    model.add_date =dic[@"add_date"];
                    model.status = dic[@"status"];
                    
                    [_brokerageArray addObject:model];
                }
                
            }else{
                NavgationbarView *mentionview=[[NavgationbarView alloc]init];
                [mentionview showLable:responseObject[@"message"] Controller:self];
            }
            
            [_MytableView reloadData];

        }

        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [_MytableView footerEndRefreshing];   //停止刷新

        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
