//
//  MembershipViewController.m
//  YunShangShiJi
//
//  Created by yssj on 15/10/27.
//  Copyright © 2015年 ios-1. All rights reserved.
//

#import "MembershipViewController.h"
#import "GlobalTool.h"
#import "membersCell.h"
#import "DistributionModel.h"
#import "MyOrderViewController.h"

#import "AFNetworking.h"
#import "MyMD5.h"
#import "NavgationbarView.h"
#import "MJRefresh.h"
#import "SmileView.h"

@interface MembershipViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *_userArray;
    NSInteger pageCount;
}

@property (nonatomic,strong)UITableView *membersTableView;
@property (nonatomic, strong)NavgationbarView *showMsg;
@property (nonatomic,assign) NSInteger currentPage;

@end

@implementation MembershipViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    _currentPage = 1;  pageCount=1;
    _userArray = [NSMutableArray array];
    [self httpData:_currentPage];
    
    [self creatNavgationView];
    [self creatMembersTableView];
}
-(void)creatNavgationView
{
    UIImageView *headview=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, Height_NavBar)];
    headview.image=[UIImage imageNamed:@"导航背景"];
    headview.backgroundColor = [UIColor whiteColor];
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
    titlelable.text= @"我的会员";
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
-(void)creatMembersTableView
{
    _membersTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, Height_NavBar, kScreenWidth, kScreenHeight-Height_NavBar) style:UITableViewStylePlain];
    _membersTableView.backgroundColor = RGBCOLOR_I(244, 244, 244);
//    _membersTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    _membersTableView.dataSource = self;
    _membersTableView.delegate = self;
    _membersTableView.showsVerticalScrollIndicator=NO;
    _membersTableView.tableFooterView=[[UIView alloc]initWithFrame:CGRectZero];
    [_membersTableView registerNib:[UINib nibWithNibName:@"membersCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:_membersTableView];
    
    __weak MembershipViewController *memberView = self;
    //加下拉刷新
    [_membersTableView addHeaderWithCallback:^{
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                memberView.currentPage = 1;
                [memberView httpData:memberView.currentPage];
            });
    }];
    
    
    //加上拉刷新
    [_membersTableView addFooterWithCallback:^{
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                memberView.currentPage++;
                if (memberView.currentPage<=pageCount) {
                    [memberView httpData:memberView.currentPage];
                }  
            });
        [memberView.membersTableView footerEndRefreshing];
    }];
    
}

#pragma mark - UITableViewDataSource

//-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//    return _userArray.count;
//}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
     return _userArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    membersCell *cell = [_membersTableView dequeueReusableCellWithIdentifier:@"cell"];
    
    DistributionModel *model = _userArray[indexPath.row];
    
    
    [cell refreshModel:model];
    
    
    if(MembersPlain==_membersType) {
        cell.membersLabel.hidden=YES;
        cell.card_noLabel.hidden=YES;
        cell.plaintextLabel.hidden=YES;
        cell.moneyLabel.hidden=NO;
    }
    
    return cell;
    
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DistributionModel *model = _userArray[indexPath.row];
    
    if(_membersType==MembersGroup){
        MembershipViewController *view = [[MembershipViewController alloc]init];
        view.membersType=MembersPlain;
        view.store_code=model.store_code;
        view.user_id=model.user_id;
        [self.navigationController pushViewController:view animated:YES];
    }else if (_membersType==MembersOrder){
        MyOrderViewController *myOrder = [[MyOrderViewController alloc]init];
        myOrder.Distribution=YES;
        myOrder.user_id=model.user_id;
        myOrder.tag=999;
        myOrder.status1=@"0";
        [self.navigationController pushViewController:myOrder animated:YES];
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 85+ZOOM(55)*2;
}
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    return ZOOM(60);
//}
//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
//{
//    return ZOOM(40);
//}


-(void)httpData:(NSInteger )page
{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *paraments=[NSMutableDictionary dictionary];
    NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
    NSString*token=[user objectForKey:USER_TOKEN];
    NSString *url;
    if (_membersType==MembersGroup||_membersType==MembersOrder) {
//        url=[NSString stringWithFormat:@"%@merchantAlliance/myMember?version=%@&token=%@&pager.curPage=%ld",[NSObject baseURLStr],VERSION,token,(long)page];
        url=[NSString stringWithFormat:@"%@superMan/myVipList?version=%@&token=%@&pager.curPage=%ld",[NSObject baseURLStr],VERSION,token,(long)page];

    }else if (_membersType==MembersPlain){
//        url=[NSString stringWithFormat:@"%@merchantAlliance/myMemberH5?version=%@&store_code=%@&token=%@&pager.curPage=%ld",[NSObject baseURLStr],VERSION,_store_code,token,(long)page];
        url=[NSString stringWithFormat:@"%@superMan/myMemberList?version=%@&uid=%@&token=%@&pager.curPage=%ld",[NSObject baseURLStr],VERSION,_user_id,token,(long)page];

        
    }
    NSString *URL=[MyMD5 authkey:url];
    
    [manager GET:URL parameters:paraments success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //%@",responseObject);
        [_membersTableView headerEndRefreshing];
        [_membersTableView footerEndRefreshing];
        
//        responseObject = [NSDictionary changeType:responseObject];
        if (responseObject!=nil) {
            
            pageCount=[responseObject[@"pager"][@"pageCount"]integerValue];
            if (page==1) {
                [_userArray removeAllObjects];
            }
            if ([responseObject[@"status"]integerValue]==1) {
                
//                NSMutableDictionary *myNewDict;
//                for (NSDictionary *dic in responseObject[@"userCounts"]) {
//                    myNewDict = [NSMutableDictionary dictionary];
//                    [myNewDict setObject:dic[@"store_code"] forKey:dic[@"count"]];
//                }
//                if (![responseObject[@"groupSumMoney"]isEqual:[NSNull null]]) {
//                    for (NSDictionary *dic in responseObject[@"groupSumMoney"]) {
//                        myNewDict = [NSMutableDictionary dictionary];
//                        [myNewDict setObject:dic[@"sumMoney"] forKey:dic[@"pay_id"]];
//                    }
//                }
                
                
                NSArray *arr = responseObject[@"list"];
                for (NSDictionary *dic in arr) {
                    DistributionModel *model = [[DistributionModel alloc]init];
                    model.pic=dic[@"pic"];
                    model.plaintext=[NSString stringWithFormat:@"%@",dic[@"plaintext"]];
                    model.nickname= dic[@"nickname"];
                    model.count= [NSString stringWithFormat:@"%@",dic[@"count"]];
                    model.phone= dic[@"phone"];
                    model.store_code=  dic[@"store_code"];
                    model.count=[NSString stringWithFormat:@"%@",dic[@"count"]];
                    model.time=  dic[@"time"];
                    model.user_id=  dic[@"user_id"];
                    model.buyer_id=dic[@"buyer_id"];
                    model.city = dic[@"city"];
                    model.province=dic[@"province"];
                    model.start_time=dic[@"start_time"];
                    model.card_no=[NSString stringWithFormat:@"%@",dic[@"card_no"]];
                    model.is_use=dic[@"is_use"];
                    model.money=[NSString stringWithFormat:@"%@",dic[@"sumMoney"]];
                    
                    [_userArray addObject:model];
                }
            }else{
                
                [self.showMsg showLable:[NSString stringWithFormat:@"%@", responseObject[@"message"]] Controller:self];
                
                //            UIAlertView *alter=[[UIAlertView alloc]initWithTitle:@"温馨提示" message:responseObject[@"message"] delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
                //            [alter show];
            }
            [_membersTableView reloadData];
            
            if(_userArray.count==0){
                
                SmileView *smileView = [[SmileView alloc]initWithFrame:CGRectMake(0,0, kApplicationWidth, kApplicationHeight-Height_NavBar+kUnderStatusBarStartY)];
                smileView.backgroundColor=[UIColor whiteColor];
                smileView.str = @"暂时没有会员";
                if (_membersType != MembersPlain) {
                    smileView.str2 = @"赶快去推广您的邀请码吧～";
                }
                [_membersTableView addSubview:smileView];
            }
        }
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [_membersTableView headerEndRefreshing];
        [_membersTableView footerEndRefreshing];
        
        
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NavgationbarView *)showMsg
{
    if (_showMsg == nil) {
        _showMsg = [[NavgationbarView alloc] init];
    }
    return _showMsg;
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
