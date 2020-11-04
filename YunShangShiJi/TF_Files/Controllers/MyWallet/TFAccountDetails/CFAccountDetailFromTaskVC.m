//
//  CFAccountDetailFromTaskVC.m
//  YunShangShiJi
//
//  Created by YF on 2017/9/21.
//  Copyright © 2017年 ios-1. All rights reserved.
//

#import "CFAccountDetailFromTaskVC.h"
#import "MXSegmentedPager.h"
#import "TradAndDrawalCell.h"

@interface CFAccountDetailFromTaskVC ()<MXSegmentedPagerDelegate,MXSegmentedPagerDataSource,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) MXSegmentedPager  * segmentedPager;
@property (nonatomic, strong) UITableView       * tableView;
@property (nonatomic, strong) UITableView       * tableView2;

@property (nonatomic, strong)NSMutableArray *dataArr1;
@property (nonatomic, strong)NSMutableArray *dataArr2;
@property (nonatomic, assign)int page1;
@property (nonatomic, assign)int page2;

@end

@implementation CFAccountDetailFromTaskVC

- (void)viewWillLayoutSubviews {
    self.segmentedPager.frame = (CGRect){
        .origin = CGPointMake(0, Height_NavBar),
        .size   = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height-Height_NavBar)
    };
    [super viewWillLayoutSubviews];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setNavigationItemLeft:@"我的参与"];
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 63, kScreenWidth, 0.5)];
    line.backgroundColor=kNavLineColor;
    [self.navigationView addSubview:line];

    [self.view addSubview:self.segmentedPager];

    // Parallax Header
//    self.segmentedPager.parallaxHeader.view = self.cover;
//    self.segmentedPager.parallaxHeader.mode = MXParallaxHeaderModeBottom;
//    self.segmentedPager.parallaxHeader.height = ZOOM6(262);
//    self.segmentedPager.parallaxHeader.minimumHeight = 0;
//    self.segmentedPager.segmentedControlEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);

    kSelfWeak;
    [self.tableView addHeaderWithCallback:^{
        weakSelf.page1 = 1;
        [weakSelf httpRefundData];
    }];
    [self.tableView2 addHeaderWithCallback:^{
        weakSelf.page2 = 1;
        [weakSelf httpDrawalsData];
    }];

    [self.tableView addFooterWithCallback:^{
        weakSelf.page1 ++;
        [weakSelf httpRefundData];
    }];
    [self.tableView2 addFooterWithCallback:^{
        weakSelf.page2 ++;
        [weakSelf httpDrawalsData];
    }];

    self.page1 = 1;
    [self httpRefundData];

    self.page2 = 1;
    [self httpDrawalsData];
}

#pragma mark Properties

- (MXSegmentedPager *)segmentedPager {
    if (!_segmentedPager) {

        // Set a segmented pager below the cover
        _segmentedPager = [[MXSegmentedPager alloc] init];
        _segmentedPager.delegate    = self;
        _segmentedPager.dataSource  = self;
    }
    return _segmentedPager;
}

- (UITableView *)tableView {
    if (!_tableView) {
        //Add a table page
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
//        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//        [_tableView registerNib:[UINib nibWithNibName:@"InvolvedRecordCell" bundle:nil] forCellReuseIdentifier:@"InvolvedRecordCellID"];
//        _tableView.contentInset = UIEdgeInsetsMake(-10, 0, 0, 0);
    }
    return _tableView;
}
- (UITableView *)tableView2 {
    if (!_tableView2) {
        //Add a table page
        _tableView2 = [[UITableView alloc] init];
        _tableView2.delegate = self;
        _tableView2.dataSource = self;
        _tableView2.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
//        _tableView2.separatorStyle = UITableViewCellSeparatorStyleNone;
//        [_tableView2 registerNib:[UINib nibWithNibName:@"InvolvedRecordCell" bundle:nil] forCellReuseIdentifier:@"InvolvedRecordCellID"];

    }
    return _tableView2;
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
#pragma mark <MXSegmentedPagerDelegate>

- (CGFloat)heightForSegmentedControlInSegmentedPager:(MXSegmentedPager *)segmentedPager {
    return 40.f;
}

#pragma mark <MXSegmentedPagerDataSource>
- (NSInteger)numberOfPagesInSegmentedPager:(MXSegmentedPager *)segmentedPager {
    return 2;
}

- (NSString *)segmentedPager:(MXSegmentedPager *)segmentedPager titleForSectionAtIndex:(NSInteger)index {
    return @[@"提现中", @"审核中"][index];
}
- (UIView *)segmentedPager:(MXSegmentedPager *)segmentedPager viewForPageAtIndex:(NSInteger)index {
    return @[self.tableView, self.tableView2][index];
}

#pragma mark tableview
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return ZOOM(250);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView==self.tableView) {
        return self.dataArr1.count;
    }else
        return self.dataArr2.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TradAndDrawalCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TRADDRAWACELLID"];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"TradAndDrawalCell" owner:self options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
//    cell.index = self.headIndex;
//    if (tableView==self.tableView)
//        [cell receiveDataCashModel:self.dataArr1[indexPath.row]];
    [cell loadTaskAccountDetailModel:
                                     tableView==self.tableView
                                                 ? self.dataArr1[indexPath.row]
                                                 : self.dataArr2[indexPath.row]
                              isLeft:tableView==self.tableView];
//    else
//        [cell receiveDataCashModel:self.dataArr2[indexPath.row]];

    return cell;
}

#pragma mark - 数据请求
- (void)httpRefundData
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *token = [ud objectForKey:USER_TOKEN];
    NSString *urlStr = [NSString stringWithFormat:@"%@wallet/queryWaitDeposit?page=%d&token=%@&version=%@&order=desc",[NSObject baseURLStr],self.page1,token,VERSION];
    NSString *URL = [MyMD5 authkey:urlStr];
    //    //URL = %@",URL);
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:URL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //        responseObject = [NSDictionary changeType:responseObject];
        [self clearBackgroundView:self.tableView withTag:10002];

//        [self.tableView ffRefreshHeaderEndRefreshing];
                [self.tableView headerEndRefreshing];
        [self.tableView footerEndRefreshing];
        if (responseObject!=nil) {
            if ([responseObject[@"status"] intValue] == 1) {

                //把数据存到模型中
                if (self.page1 == 1) {
                    [self.dataArr1 removeAllObjects];
                }
                NSArray *fundDetails = responseObject[@"data"];

                if (fundDetails.count == 0 && self.dataArr1.count == 0) {
                    CGRect frame = CGRectMake(0, 0, self.tableView.frame.size.width, self.tableView.frame.size.height);
                    [self createBackgroundView:self.tableView andTag:10002 andFrame:frame withImgge:nil andText:nil];
                } else {
                    [self clearBackgroundView:self.tableView withTag:10002];
                    for (NSDictionary *dic in fundDetails) {
                        DrawCashModel *adModel = [[DrawCashModel alloc] init];
                        [adModel setValuesForKeysWithDictionary:dic];
                        adModel.ID = dic[@"id"];
                        [self.dataArr1 addObject:adModel];
                    }
                    [self.tableView reloadData];
                }
            } else {


                [MBProgressHUD showError:responseObject[@"message"]];
            }

        }

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                [self.tableView headerEndRefreshing];
//        [self.tableView ffRefreshHeaderEndRefreshing];
        [self.tableView footerEndRefreshing];
        //        [MBProgressHUD showError:@"网络连接失败,请检查网络设置"];
        CGRect frame = CGRectMake(0, 0, self.tableView.frame.size.width, self.tableView.frame.size.height);
        [self createBackgroundView:self.tableView andTag:10002 andFrame:frame withImgge:[UIImage imageNamed:@"哭脸"] andText:@"亲,没网了"];
    }];

}
- (void)httpDrawalsData
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *token = [ud objectForKey:USER_TOKEN];
    NSString *urlStr = [NSString stringWithFormat:@"%@wallet/selDeposit?page=%d&token=%@&version=%@&order=desc&check=-1&t_type=2",[NSObject baseURLStr],self.page2,token,VERSION];
    NSString *URL = [MyMD5 authkey:urlStr];
    //    //
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:URL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //        responseObject = [NSDictionary changeType:responseObject];
        [self clearBackgroundView:self.tableView2 withTag:10001];

        MyLog(@"res :%@", responseObject);
        [self.tableView2 headerEndRefreshing];
        [self.tableView2 footerEndRefreshing];

        if (responseObject!=nil) {
            if ([responseObject[@"status"] intValue] == 1) {

                if (self.page2 == 1) {
                    [self.dataArr2 removeAllObjects];
                }
                NSArray *data = responseObject[@"data"];
                if (data.count == 0 && self.dataArr2.count == 0) {
                    CGRect frame = CGRectMake(0, 0, self.tableView2.frame.size.width, self.tableView2.frame.size.height);

                    [self createBackgroundView:self.tableView2 andTag:10001 andFrame:frame withImgge:nil andText:nil];
                    //bgView2 = %@",self.bgView2.subviews);

                } else {
                    [self clearBackgroundView:self.tableView2 withTag:10001];
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
        [self.tableView2 headerEndRefreshing];

        [self.tableView2 footerEndRefreshing];

        CGRect frame = CGRectMake(0, 0, self.tableView2.frame.size.width, self.tableView2.frame.size.height);
        //        [MBProgressHUD showError:@"网络连接失败,请检查网络设置"];
        [self createBackgroundView:self.tableView2 andTag:10001 andFrame:frame withImgge:[UIImage imageNamed:@"哭脸"] andText:@"亲,没网了"];
    }];
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
