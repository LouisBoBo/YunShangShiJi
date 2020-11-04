//
//  TFAccountDetailsViewController.m
//  YunShangShiJi
//
//  Created by 云商 on 15/7/7.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//

#import "TFAccountDetailsViewController.h"
#import "TradAndDrawalCell.h"
#import "AccountDetailModel.h"
#import "TFCashDetailsViewController.h"
#import "KickBackCell.h"
#import "KickBackModel.h"
#import "TFRefundDatailViewController.h"
#import "DrawCashModel.h"
#import "TFMyWalletViewController.h"
#import "HBkickbackTableViewCell.h"
#import "NavgationbarView.h"

@interface TFAccountDetailsViewController () <UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>

@property (nonatomic, strong)UIView *headView;

@property (nonatomic, strong)UIScrollView *bgScrollView;

@property (nonatomic, strong)UIView *bgView1;
@property (nonatomic, strong)UIView *bgView2;
@property (nonatomic, strong)UIView *bgView3;
@property (nonatomic, strong)UIView *bgView4;

@property (nonatomic, strong)NSMutableArray *dataArr1;
@property (nonatomic, strong)NSMutableArray *dataArr2;
@property (nonatomic, strong)NSMutableArray *dataArr3;
@property (nonatomic, strong)NSMutableArray *dataArr4;

@property (nonatomic, strong)UITableView *tableView1;
@property (nonatomic, strong)UITableView *tableView2;
@property (nonatomic, strong)UITableView *tableView3;
@property (nonatomic, strong)UITableView *tableView4;


@property (nonatomic, assign)int page1;
@property (nonatomic, assign)int page2;
@property (nonatomic, assign)int page3;
@property (nonatomic, assign)int page4;

@end

@implementation TFAccountDetailsViewController

- (void)dealloc
{
    MyLog(@"%@ release", [self class]);
    if (self.tableView1.topShowView) {
        [self.tableView1 removeObserver:self.tableView1 forKeyPath:observerRefreshHeaderViewKeyPath];
    }
    if (self.tableView2.topShowView) {
        [self.tableView2 removeObserver:self.tableView2 forKeyPath:observerRefreshHeaderViewKeyPath];
    }
    if (self.tableView3.topShowView) {
        [self.tableView3 removeObserver:self.tableView3 forKeyPath:observerRefreshHeaderViewKeyPath];
    }
    if (self.tableView4.topShowView) {
        [self.tableView4 removeObserver:self.tableView4 forKeyPath:observerRefreshHeaderViewKeyPath];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [super setNavigationItemLeft:@"账户明细"];
    [self setupUI];
    
    if([self.comefrom isEqualToString:@"消息推送"])
    {
        [self pushMessage];
    }else if ([self.comefrom isEqualToString:@"退款推送"])
    {
        [self refundMessage];
    }
    
}

#pragma mark - 创建UI
- (void)setupUI
{
    self.page1 = 1;
    self.page2 = 1;
    self.page3 = 1;
    self.page4 = 1;
    self.headView = [[UIView alloc] initWithFrame:CGRectMake(0, kNavigationheightForIOS7, kScreenWidth, (40))];
//    self.headView.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:self.headView ];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.headView.frame)-1, CGRectGetWidth(self.headView.frame), 1)];
    lineView.backgroundColor = RGBCOLOR_I(220,220,220);
    [self.headView addSubview:lineView];
    
    
    self.bgScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.headView.frame.origin.y+self.headView.frame.size.height, kScreenWidth, kScreenHeight-self.headView.frame.origin.y-self.headView.frame.size.height)];
    self.bgScrollView.bounces = YES;
    self.bgScrollView.pagingEnabled = YES;
    self.bgScrollView.delegate = self;
    self.bgScrollView.showsHorizontalScrollIndicator = NO;
    self.bgScrollView.tag = 1000;
    self.bgScrollView.contentSize = CGSizeMake(kScreenWidth*4, kScreenHeight-self.headView.frame.origin.y-self.headView.frame.size.height);
    [self.view addSubview:self.bgScrollView];
    
    NSArray *titleArr = [NSArray arrayWithObjects:@"交易",@"退款/提现",@"售后",@"余额", nil];
    
    CGFloat W = 90;
    CGFloat H = 40;
    CGFloat Margin = (kScreenWidth-W*titleArr.count)/5.0;

    for (int i = 0; i<titleArr.count; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(Margin+i*W+i*Margin, (self.headView .frame.size.height-H)/2, W, H);
        [btn setTitle:titleArr[i] forState:UIControlStateNormal];
        btn.titleLabel.font = kFont6px(34);
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setTitleColor:COLOR_ROSERED forState:UIControlStateSelected];
        btn.tag = 100+i;
        
        [btn addTarget:self action:@selector(headBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        if (i == 0) {
            btn.selected = YES;
        }
        [self.headView  addSubview:btn];
    }
    
    [self createTrading];
    [self createWithDrawals];
    [self createRefund];
    [self createRebate];

    if (self.headIndex == 0) {
        [self httpTradingData];

    } else if (self.headIndex == 1) {
        [self httpDrawalsData];
    } else if (self.headIndex == 2) {
        [self httpRefundData];
    } else if (self.headIndex == 3) {
        [self httpRebateData];
    }
    self.bgScrollView.contentOffset = CGPointMake(kScreenWidth*self.headIndex, 0);
    for (int i = 0; i<4; i++) {
        UIButton *btn = (UIButton *)[self.headView viewWithTag:100+i];
        btn.selected = NO;
        if (btn.tag == self.headIndex+100) {
            btn.selected = YES;
        }
    }
    
}
#pragma mark 由推送消息而来
- (void)pushMessage
{
    NavgationbarView *mentionview =[[NavgationbarView alloc]init];
    NSString *message ;
    if(self.isfrozen.intValue == 2)
    {
        message = @"";
    }else if (self.Toaccount.intValue == 1)
    {
        message = @"佣金将在确认收货后到账";
        [mentionview showLable:message Controller:self];
    }
    
    self.headIndex = 3;
    self.page4 = 1;
    self.bgScrollView.contentOffset = CGPointMake(kScreenWidth*3, 0);
    [self httpRebateData];

}
- (void)refundMessage
{
    self.headIndex = 2;
    self.page3 = 1;
    self.bgScrollView.contentOffset = CGPointMake(kScreenWidth*2, 0);
    [self httpRefundData];
}
#pragma mark - 网络请求数据
- (void)httpTradingData //交易
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *token = [ud objectForKey:USER_TOKEN];
    NSString *urlStr = [NSString stringWithFormat:@"%@wallet/findFundDetail?page=%d&token=%@&version=%@&order=desc",[NSObject baseURLStr],self.page1,token,VERSION];
    NSString *URL = [MyMD5 authkey:urlStr];
//    //URL = %@",URL);
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:URL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        responseObject = [NSDictionary changeType:responseObject];
        [self clearBackgroundView:self.bgView1 withTag:99999];
        [self.tableView1 ffRefreshHeaderEndRefreshing];
//        [self.tableView1 headerEndRefreshing];
        [self.tableView1 footerEndRefreshing];
        
        if (responseObject!=nil) {
            if ([responseObject[@"status"] intValue] == 1) {

                //把数据存到模型中
                if (self.page1 == 1) {
                    [self.dataArr1 removeAllObjects];
                }
                NSArray *fundDetails = responseObject[@"fundDetails"];
                
                if (fundDetails.count == 0 && self.dataArr1.count == 0) {
                    CGRect frame = CGRectMake(0, 0, self.bgView1.frame.size.width, self.bgView1.frame.size.height);
                    
                    [self createBackgroundView:self.bgView1 andTag:10000 andFrame:frame withImgge:nil andText:nil];
                } else {
                    [self clearBackgroundView:self.bgView1 withTag:10000];
                    for (NSDictionary *dic in fundDetails) {
                        AccountDetailModel *adModel = [[AccountDetailModel alloc] init];
                        [adModel setValuesForKeysWithDictionary:dic];
                        adModel.ID = dic[@"id"];
                        [self.dataArr1 addObject:adModel];
                    }
                    [self.tableView1 reloadData];
                }
                
            } else {

                [MBProgressHUD showError:responseObject[@"message"]];
            }

        }
        
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        [self.tableView1 headerEndRefreshing];
         [self.tableView1 ffRefreshHeaderEndRefreshing];
        [self.tableView1 footerEndRefreshing];
        
        CGRect frame = CGRectMake(0, 0, self.bgView1.frame.size.width, self.bgView1.frame.size.height);
        [self createBackgroundView:self.bgView1 andTag:99999 andFrame:frame withImgge:[UIImage imageNamed:@"哭脸"] andText:@"亲,没网了"];
//        [MBProgressHUD showError:@"网络连接失败,请检查网络设置"];
    }];
}

- (void)httpDrawalsData
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *token = [ud objectForKey:USER_TOKEN];
    NSString *urlStr = [NSString stringWithFormat:@"%@wallet/selDeposit?page=%d&token=%@&version=%@&order=desc",[NSObject baseURLStr],self.page2,token,VERSION];
    NSString *URL = [MyMD5 authkey:urlStr];
//    //
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:URL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        responseObject = [NSDictionary changeType:responseObject];
        [self clearBackgroundView:self.bgView2 withTag:99999];
        
        MyLog(@"res :%@", responseObject);
        [self.tableView2 ffRefreshHeaderEndRefreshing];
//        [self.tableView2 headerEndRefreshing];
        [self.tableView2 footerEndRefreshing];
        
        if (responseObject!=nil) {
            if ([responseObject[@"status"] intValue] == 1) {

                if (self.page2 == 1) {
                    [self.dataArr2 removeAllObjects];
                }
                NSArray *data = responseObject[@"data"];
                if (data.count == 0 && self.dataArr2.count == 0) {
                    CGRect frame = CGRectMake(0, 0, self.bgView2.frame.size.width, self.bgView2.frame.size.height);
                    
                    [self createBackgroundView:self.bgView2 andTag:10001 andFrame:frame withImgge:nil andText:nil];
                    //bgView2 = %@",self.bgView2.subviews);
                    
                } else {
                    [self clearBackgroundView:self.bgView2 withTag:10001];
                    for (NSDictionary *dic in data) {
                        DrawCashModel *dcModel = [[DrawCashModel alloc] init];
                        [dcModel setValuesForKeysWithDictionary:dic];
                        [self.dataArr2 addObject:dcModel];
                    }
                    [self.tableView2 reloadData];
                }
                
            } else {
                
                [MBProgressHUD showError:responseObject[@"message"]];
            }

        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        [self.tableView2 headerEndRefreshing];
        [self.tableView2 ffRefreshHeaderEndRefreshing];
        [self.tableView2 footerEndRefreshing];
        
         CGRect frame = CGRectMake(0, 0, self.bgView2.frame.size.width, self.bgView2.frame.size.height);
//        [MBProgressHUD showError:@"网络连接失败,请检查网络设置"];
        [self createBackgroundView:self.bgView2 andTag:99999 andFrame:frame withImgge:[UIImage imageNamed:@"哭脸"] andText:@"亲,没网了"];
    }];
}

- (void)httpRefundData
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *token = [ud objectForKey:USER_TOKEN];
    NSString *urlStr = [NSString stringWithFormat:@"%@wallet/findFundDetail?page=%d&token=%@&version=%@&type=8&order=desc",[NSObject baseURLStr],self.page3,token,VERSION];
    NSString *URL = [MyMD5 authkey:urlStr];
//    //URL = %@",URL);
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:URL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        responseObject = [NSDictionary changeType:responseObject];
        [self clearBackgroundView:self.bgView3 withTag:99999];

        [self.tableView3 ffRefreshHeaderEndRefreshing];
//        [self.tableView3 headerEndRefreshing];
        [self.tableView3 footerEndRefreshing];
        if (responseObject!=nil) {
            if ([responseObject[@"status"] intValue] == 1) {

                //把数据存到模型中
                if (self.page3 == 1) {
                    [self.dataArr3 removeAllObjects];
                }
                NSArray *fundDetails = responseObject[@"fundDetails"];
                
                if (fundDetails.count == 0 && self.dataArr3.count == 0) {
                    CGRect frame = CGRectMake(0, 0, self.bgView3.frame.size.width, self.bgView3.frame.size.height);
                    [self createBackgroundView:self.bgView3 andTag:10002 andFrame:frame withImgge:nil andText:nil];
                } else {
                    [self clearBackgroundView:self.bgView3 withTag:10002];
                    for (NSDictionary *dic in fundDetails) {
                        AccountDetailModel *adModel = [[AccountDetailModel alloc] init];
                        [adModel setValuesForKeysWithDictionary:dic];
                        adModel.ID = dic[@"id"];
                        [self.dataArr3 addObject:adModel];
                    }
                    [self.tableView3 reloadData];
                }
            } else {
                
                
                [MBProgressHUD showError:responseObject[@"message"]];
            }

        }
        
      } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        [self.tableView3 headerEndRefreshing];
        [self.tableView3 ffRefreshHeaderEndRefreshing];
        [self.tableView3 footerEndRefreshing];
//        [MBProgressHUD showError:@"网络连接失败,请检查网络设置"];
        CGRect frame = CGRectMake(0, 0, self.bgView3.frame.size.width, self.bgView3.frame.size.height);
        [self createBackgroundView:self.bgView3 andTag:99999 andFrame:frame withImgge:[UIImage imageNamed:@"哭脸"] andText:@"亲,没网了"];
    }];

}

- (void)httpRebateData
{
//    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
//    NSString *token = [ud objectForKey:USER_TOKEN];
//    NSString *urlStr = [NSString stringWithFormat:@"%@wallet/selKickBack?page=%d&token=%@&version=%@&order=desc",[NSObject baseURLStr],self.page4,token,VERSION];
//    NSString *URL = [MyMD5 authkey:urlStr];
////    //
//    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    [manager GET:URL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
////        responseObject = [NSDictionary changeType:responseObject];
//        [self clearBackgroundView:self.bgView4 withTag:99999];
//
//        MyLog(@"responseObject = %@",responseObject);
////        [self.tableView4 headerEndRefreshing];
//        [self.tableView4 ffRefreshHeaderEndRefreshing];
//        [self.tableView4 footerEndRefreshing];
//        if (responseObject!=nil) {
//
//            if ([responseObject[@"status"] intValue] == 1) {
//
//
//                if (self.page4 == 1) {
//                    [self.dataArr4 removeAllObjects];
//                }
//                NSArray *dataArr = responseObject[@"data"];
//
//                if (dataArr.count == 0 && self.dataArr4.count == 0) {
//                    CGRect frame = CGRectMake(0, 0, self.bgView4.frame.size.width, self.bgView4.frame.size.height);
//                    [self createBackgroundView:self.bgView4 andTag:10003 andFrame:frame withImgge:nil andText:nil];
//                } else {
//                    [self clearBackgroundView:self.bgView4 withTag:10003];
//                    for (NSDictionary *dic in dataArr) {
//                        KickBackModel *kbModel = [[KickBackModel alloc] init];
//                        [kbModel setValuesForKeysWithDictionary:dic];
//                        NSMutableArray *array = [[NSMutableArray alloc] init];
//                        [array addObject:kbModel];
//                        [self.dataArr4 addObject:array];
//                    }
//
//
//                    [self.tableView4 reloadData];
//                }
//            } else {
//
//                [MBProgressHUD showError:responseObject[@"message"]];
//            }
//
//        }
//
//     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
////        [self.tableView4 headerEndRefreshing];
//         [self.tableView4 ffRefreshHeaderEndRefreshing];
//        [self.tableView4 footerEndRefreshing];
////        [MBProgressHUD showError:@"网络连接失败,请检查网络设置"];
//        CGRect frame = CGRectMake(0, 0, self.bgView4.frame.size.width, self.bgView4.frame.size.height);
//        [self createBackgroundView:self.bgView4 andTag:99999 andFrame:frame withImgge:[UIImage imageNamed:@"哭脸"] andText:@"亲,没网了"];
//
//    }];

    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *token = [ud objectForKey:USER_TOKEN];
    NSString *urlStr = [NSString stringWithFormat:@"%@wallet/findFundDetail?page=%d&token=%@&version=%@&type=2&order=desc",[NSObject baseURLStr],self.page4,token,VERSION];
    NSString *URL = [MyMD5 authkey:urlStr];
    //    //URL = %@",URL);
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:URL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //        responseObject = [NSDictionary changeType:responseObject];
        [self clearBackgroundView:self.bgView4 withTag:99999];
        
        [self.tableView4 ffRefreshHeaderEndRefreshing];
        //        [self.tableView3 headerEndRefreshing];
        [self.tableView4 footerEndRefreshing];
        if (responseObject!=nil) {
            if ([responseObject[@"status"] intValue] == 1) {
                
                //把数据存到模型中
                if (self.page4 == 1) {
                    [self.dataArr4 removeAllObjects];
                }
                NSArray *fundDetails = responseObject[@"fundDetails"];
                
                if (fundDetails.count == 0 && self.dataArr4.count == 0) {
                    CGRect frame = CGRectMake(0, 0, self.bgView4.frame.size.width, self.bgView4.frame.size.height);
                    [self createBackgroundView:self.bgView4 andTag:10004 andFrame:frame withImgge:nil andText:nil];
                } else {
                    [self clearBackgroundView:self.bgView4 withTag:10004];
                    for (NSDictionary *dic in fundDetails) {
                        AccountDetailModel *adModel = [[AccountDetailModel alloc] init];
                        [adModel setValuesForKeysWithDictionary:dic];
                        adModel.ID = dic[@"id"];
                        [self.dataArr4 addObject:adModel];
                    }
                    [self.tableView4 reloadData];
                }
            } else {
                
                
                [MBProgressHUD showError:responseObject[@"message"]];
            }
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //        [self.tableView3 headerEndRefreshing];
        [self.tableView4 ffRefreshHeaderEndRefreshing];
        [self.tableView4 footerEndRefreshing];
        //        [MBProgressHUD showError:@"网络连接失败,请检查网络设置"];
        CGRect frame = CGRectMake(0, 0, self.bgView4.frame.size.width, self.bgView4.frame.size.height);
        [self createBackgroundView:self.bgView4 andTag:99999 andFrame:frame withImgge:[UIImage imageNamed:@"哭脸"] andText:@"亲,没网了"];
    }];

}

- (void)createTrading
{
    self.bgView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-kNavigationheightForIOS7-self.headView.frame.size.height)];
//    self.bgView1.backgroundColor = [UIColor yellowColor];
    [self.bgScrollView addSubview:self.bgView1];
    
    self.tableView1 = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.bgView1.frame.size.width, self.bgView1.frame.size.height)];
    self.tableView1.delegate = self;
    self.tableView1.dataSource = self;
    self.tableView1.tag = 200;
//    self.tableView1.backgroundColor = [UIColor orangeColor];
    self.tableView1.tableFooterView = [[UIView alloc] init];
    [self.bgView1 addSubview:self.tableView1];
    
    __weak TFAccountDetailsViewController *myController = self;
//    [self.tableView1 addHeaderWithCallback:^{
//        myController.page1 = 1;
//        [myController httpTradingData];
//    }];
    
    [self.tableView1 addTopHeaderWithCallback:^{
        myController.page1 = 1;
        [myController httpTradingData];
    }];
    
    [self.tableView1 addFooterWithCallback:^{
        myController.page1++;
        [myController httpTradingData];
    }];
    
    
}
- (void)createWithDrawals
{
    self.bgView2 = [[UIView alloc] initWithFrame:CGRectMake(kScreenWidth*1, 0, kScreenWidth, kScreenHeight-kNavigationheightForIOS7-self.headView.frame.size.height)];
//    self.bgView2.backgroundColor = [UIColor orangeColor];
    [self.bgScrollView addSubview:self.bgView2];
    
    self.tableView2 = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.bgView2.frame.size.width, self.bgView2.frame.size.height)];
    self.tableView2.delegate = self;
    self.tableView2.dataSource = self;
    self.tableView2.tag = 201;
//    self.tableView2.backgroundColor = [UIColor orangeColor];
    self.tableView2.tableFooterView = [[UIView alloc] init];
    [self.bgView2 addSubview:self.tableView2];
    

    __weak TFAccountDetailsViewController *myController = self;
//    [self.tableView2 addHeaderWithCallback:^{
//        myController.page2 = 1;
//        [myController httpDrawalsData];
//    }];
    
    [self.tableView2 addTopHeaderWithCallback:^{
        myController.page2 = 1;
        [myController httpDrawalsData];
    }];
    
    [self.tableView2 addFooterWithCallback:^{
        myController.page2++;
        [myController httpDrawalsData];
    }];

}
- (void)createRefund
{
    self.bgView3 = [[UIView alloc] initWithFrame:CGRectMake(kScreenWidth*2, 0, kScreenWidth, kScreenHeight-kNavigationheightForIOS7-self.headView.frame.size.height)];
//    self.bgView3.backgroundColor = [UIColor redColor];
    [self.bgScrollView addSubview:self.bgView3];
    
    self.tableView3 = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.bgView3.frame.size.width, self.bgView3.frame.size.height)];
    self.tableView3.delegate = self;
    self.tableView3.dataSource = self;
    self.tableView3.tag = 202;
//    self.tableView3.backgroundColor = [UIColor orangeColor];
    self.tableView3.tableFooterView = [[UIView alloc] init];
    [self.bgView3 addSubview:self.tableView3];
    
    __weak TFAccountDetailsViewController *myController = self;
//    [self.tableView3 addHeaderWithCallback:^{
//        myController.page3 = 1;
//        [myController httpRefundData];
//    }];
    
    [self.tableView3 addTopHeaderWithCallback:^{
        myController.page3 = 1;
        [myController httpRefundData];
    }];
    
    [self.tableView3 addFooterWithCallback:^{
        myController.page3++;
        [myController httpRefundData];
    }];

}
- (void)createRebate
{
    self.bgView4 = [[UIView alloc] initWithFrame:CGRectMake(kScreenWidth*3, 0, kScreenWidth, kScreenHeight-kNavigationheightForIOS7-self.headView.frame.size.height)];
//    self.bgView4.backgroundColor = [UIColor greenColor];
    [self.bgScrollView addSubview:self.bgView4];
    
    self.tableView4 = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.bgView4.frame.size.width, self.bgView4.frame.size.height)];
    self.tableView4.delegate = self;
    self.tableView4.dataSource = self;
    self.tableView4.tag = 203;
    self.tableView4.tableFooterView = [[UIView alloc] init];
    [self.bgView4 addSubview:self.tableView4];
    

    __weak TFAccountDetailsViewController *myController = self;
//    [self.tableView4 addHeaderWithCallback:^{
//        myController.page4 = 1;
//        [myController httpRebateData];
//    }];
    
    [self.tableView4 addTopHeaderWithCallback:^{
        myController.page4 = 1;
        [myController httpRebateData];
    }];
    
    [self.tableView4 addFooterWithCallback:^{
        myController.page4++;
        [myController httpRebateData];
    }];

}

- (void)headBtnClick:(UIButton *)sender
{
    for (int i = 0; i<4; i++) {
        UIButton *btn = (UIButton *)[self.headView viewWithTag:100+i];
        btn.selected = NO;
    }
    sender.selected = YES;
    if (sender.tag == 100) {
        self.headIndex = 0;
        self.page1 = 1;
        self.bgScrollView.contentOffset = CGPointMake(0, 0);
        [self httpTradingData];
    } else if (sender.tag == 101) {
        self.headIndex = 1;
        self.page2 = 1;
        self.bgScrollView.contentOffset = CGPointMake(kScreenWidth*1, 0);
        [self httpDrawalsData];
    } else if (sender.tag == 102) {
        self.headIndex = 2;
        self.page3 = 1;
        self.bgScrollView.contentOffset = CGPointMake(kScreenWidth*2, 0);
        [self httpRefundData];
    } else if (sender.tag == 103) {
        self.headIndex = 3;
        self.page4 = 1;
        self.bgScrollView.contentOffset = CGPointMake(kScreenWidth*3, 0);
        [self httpRebateData];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView.tag == 1000) {
        int oldIndex = self.headIndex;
        self.headIndex = scrollView.contentOffset.x/kScreenWidth;
        
        if (oldIndex!=self.headIndex) {
            if (self.headIndex == 0) {
                self.page1 = 1;
                [self httpTradingData];
            } else if (self.headIndex == 1) {
                self.page2 = 1;
                [self httpDrawalsData];
            } else if (self.headIndex == 2) {
                self.page3 = 1;
                [self httpRefundData];
            } else if (self.headIndex == 3) {
                self.page4 = 1;
                [self httpRebateData];
            }
        }
        
        for (int i = 0; i<4; i++) {
            UIButton *btn = (UIButton *)[self.headView viewWithTag:100+i];
            btn.selected = NO;
            if (btn.tag == self.headIndex+100) {
                btn.selected = YES;
            }
        }
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView.tag == 200) {
        return 1;
    } else if (tableView.tag == 201) {
        return 1;
    } else if (tableView.tag == 202) {
        return 1;
    } else if (tableView.tag == 203) {
        return 1;
    } else {
        return 0;
    }

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView.tag == 200) {
        return [self.dataArr1 count];
    } else if (tableView.tag == 201) {
        return [self.dataArr2 count];
    } else if (tableView.tag == 202) {
        return [self.dataArr3 count];
    } else if (tableView.tag == 203) {
        return [self.dataArr4 count];
    } else {
        return 0;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (tableView.tag == 203) {
        if (section == 0) {
            return 0;
        } else {
            return (8);
        }
    } else
        return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag == 200) {
        return ZOOM(180);
    } else if (tableView.tag == 201) {
        return ZOOM(180);
    } else if (tableView.tag == 202){
        return ZOOM(180);
    } else if (tableView.tag == 203){
        return ZOOM(180);
    }
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag == 200) {
        TradAndDrawalCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TRADDRAWACELLID"];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"TradAndDrawalCell" owner:self options:nil] lastObject];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        cell.index = self.headIndex;
        [cell receiveDataModel:self.dataArr1[indexPath.row]];
        return cell;
    } else if (tableView.tag == 201) {
        TradAndDrawalCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TRADDRAWACELLID"];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"TradAndDrawalCell" owner:self options:nil] lastObject];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        cell.index = self.headIndex;
        [cell receiveDataCashModel:self.dataArr2[indexPath.row]];
        return cell;
    } else if (tableView.tag == 202) {
        TradAndDrawalCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TRADDRAWACELLID"];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"TradAndDrawalCell" owner:self options:nil] lastObject];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        cell.index = self.headIndex;
        [cell receiveDataModel:self.dataArr3[indexPath.row]];
        return cell;
    } else if (tableView.tag == 203) {
//        KickBackCell *cell = [tableView dequeueReusableCellWithIdentifier:@"KICKBACKCELLID"];
//        if (cell == nil) {
//            cell = [[[NSBundle mainBundle] loadNibNamed:@"KickBackCell" owner:self options:nil] lastObject];
//            cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        }
//        [cell receiveDataModel:[self.dataArr4[indexPath.section] objectAtIndex:indexPath.row]];
        
//        HBkickbackTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BackCell"];
//        if (cell == nil) {
//            cell = [[[NSBundle mainBundle] loadNibNamed:@"HBkickbackTableViewCell" owner:self options:nil] lastObject];
//            cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        }
//        [cell receiveDataModel:[self.dataArr4[indexPath.section] objectAtIndex:indexPath.row]];
//
//        KickBackModel *model =[self.dataArr4[indexPath.section] objectAtIndex:indexPath.row];
//        if([model.type intValue] == 8||[model.type intValue] == 9||[model.type intValue] == 10||[model.type intValue] == 11)
//            cell.namelab.hidden=YES;
//        else
//            cell.namelab.hidden=NO;
//
//        return cell;
        
        TradAndDrawalCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TRADDRAWACELLID"];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"TradAndDrawalCell" owner:self options:nil] lastObject];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        cell.index = self.headIndex;
        [cell receiveDataModel:self.dataArr4[indexPath.row]];
        return cell;
    }
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CELLID"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CELLID"];
    }
    return cell;
}

#pragma mark - cell点击
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag == 200) {
        //
    } else if (tableView.tag == 201) {
        TFCashDetailsViewController *tdvc = [[TFCashDetailsViewController alloc] init];
        tdvc.model = [self.dataArr2 objectAtIndex:indexPath.row];
        [self.navigationController pushViewController:tdvc animated:YES];
    } else if (tableView.tag == 202) {
        TFRefundDatailViewController *trvc = [[TFRefundDatailViewController alloc] init];
        trvc.model = [self.dataArr3 objectAtIndex:indexPath.row];
        [self.navigationController pushViewController:trvc animated:YES];
    } else if (tableView.tag == 203) {

    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat sectionHeaderHeight = 8;
    if (scrollView.tag == 203) {
        if (scrollView.contentOffset.y<=sectionHeaderHeight&&scrollView.contentOffset.y>=0) {
            scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
        } else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
            scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
        }
    }
    
    if (scrollView.tag == 1000) {
        int oldIndex = self.headIndex;
        self.headIndex = scrollView.contentOffset.x/kScreenWidth;
        
        if (oldIndex!=self.headIndex) {
            if (self.headIndex == 0) {
                self.page1 = 1;
                [self httpTradingData];
            } else if (self.headIndex == 1) {
                self.page2 = 1;
                [self httpDrawalsData];
            } else if (self.headIndex == 2) {
                self.page3 = 1;
                [self httpRefundData];
            } else if (self.headIndex == 3) {
                self.page4 = 1;
                [self httpRebateData];
            }
        }
        for (int i = 0; i<4; i++) {
            UIButton *btn = (UIButton *)[self.headView viewWithTag:100+i];
            btn.selected = NO;
            if (btn.tag == self.headIndex+100) {
                btn.selected = YES;
            }
        }
        
    }
}


- (NSMutableArray *)dataArr1
{
    if (_dataArr1 == nil) {
        _dataArr1 = [[NSMutableArray alloc] init];
    }
    return _dataArr1;
}
- (NSMutableArray *)dataArr2
{
    if (_dataArr2 == nil) {
        _dataArr2 = [[NSMutableArray alloc] init];
    }
    return _dataArr2;
}
- (NSMutableArray *)dataArr3
{
    if (_dataArr3 == nil) {
        _dataArr3 = [[NSMutableArray alloc] init];
    }
    return _dataArr3;
}
- (NSMutableArray *)dataArr4
{
    if (_dataArr4 == nil) {
        _dataArr4 = [[NSMutableArray alloc] init];
    }
    return _dataArr4;
}

- (void)leftBarButtonClick
{
    for(UIViewController *vc in self.navigationController.viewControllers)
    {
        if([vc isKindOfClass:[TFMyWalletViewController class]]){
            [self.navigationController popToViewController:vc animated:YES];
            return;
        }
    }
    [self.navigationController popViewControllerAnimated:YES];
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
