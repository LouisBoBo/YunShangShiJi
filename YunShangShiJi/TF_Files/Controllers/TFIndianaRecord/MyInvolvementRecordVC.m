//
//  MyInvolvementRecordVC.m
//  YunShangShiJi
//
//  Created by YF on 2017/8/21.
//  Copyright © 2017年 ios-1. All rights reserved.
//

#import "MyInvolvementRecordVC.h"
#import "MXSegmentedPager.h"
#import "InvolvedRecordCell.h"
#import "GlobalTool.h"

#import "IndianaDetailViewController.h"
#import "AXSampleNavBarTabViewController.h"
#import "OneIndianaDetailViewController.h"


@interface MyInvolvementRecordVC ()<MXSegmentedPagerDelegate,MXSegmentedPagerDataSource,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UIView            * cover;
@property (nonatomic, strong) UILabel           * headMoney;
@property (nonatomic, strong) MXSegmentedPager  * segmentedPager;
@property (nonatomic, strong) UITableView       * tableView;
@property (nonatomic, strong) UITableView       * tableView2;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) NSMutableArray *dataArray2;

@property (nonatomic, assign) NSInteger httpPage;
@property (nonatomic, assign) NSInteger httpPage2;

@end

@implementation MyInvolvementRecordVC

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setNavigationItemLeft:@"我的参与"];
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 63, kScreenWidth, 0.5)];
    line.backgroundColor=kNavLineColor;
    [self.navigationView addSubview:line];

    [self.view addSubview:self.segmentedPager];

    // Parallax Header
    self.segmentedPager.parallaxHeader.view = self.cover;
    self.segmentedPager.parallaxHeader.mode = MXParallaxHeaderModeBottom;
    self.segmentedPager.parallaxHeader.height = ZOOM6(262);
    self.segmentedPager.parallaxHeader.minimumHeight = 0;
    self.segmentedPager.segmentedControlEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);

    kSelfWeak;
    [self.tableView addFooterWithCallback:^{
        weakSelf.httpPage ++;
        [weakSelf httpGetMine];
    }];
    [self.tableView2 addFooterWithCallback:^{
        weakSelf.httpPage2 ++;
        [weakSelf httpGetMine2];
    }];

    self.httpPage = 1;
    [self httpGetMine];

    self.httpPage2 = 1;
    [self httpGetMine2];

    [self httpGetMoney];
}
- (void)viewWillLayoutSubviews {
    self.segmentedPager.frame = (CGRect){
        .origin = CGPointMake(0, Height_NavBar),
        .size   = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height-Height_NavBar)
    };
    [super viewWillLayoutSubviews];
}
#pragma mark Properties

- (UIView *)cover {
    if (!_cover) {
        // Set a cover on the top of the view

        _cover = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, ZOOM6(262))];
//        _cover.backgroundColor = [UIColor lightGrayColor];
        UILabel *name = [[UILabel alloc]initWithFrame:CGRectMake(0, ZOOM6(70), kScreenWidth, 20)];
        name.text = @"中奖总金额";
        name.textColor = kSubTitleColor;
        name.textAlignment = NSTextAlignmentCenter;
        name.font = kFont6px(30);
        [_cover addSubview:name];
        _headMoney = [[UILabel alloc]initWithFrame:CGRectMake(0, name.bottom, kScreenWidth, 40)];
        _headMoney.text = @"¥0.0";
        _headMoney.textColor = tarbarrossred;
        _headMoney.textAlignment = NSTextAlignmentCenter;
        _headMoney.font = [UIFont boldSystemFontOfSize:ZOOM6(72)];
        _headMoney.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(httpGetData)];
        [_headMoney addGestureRecognizer:tap];
        [_cover addSubview:_headMoney];

        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, _cover.height-ZOOM6(20), kScreenWidth, ZOOM6(20))];
        line.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [_cover addSubview:line];
    }
    return _cover;
}

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
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerNib:[UINib nibWithNibName:@"InvolvedRecordCell" bundle:nil] forCellReuseIdentifier:@"InvolvedRecordCellID"];
        _tableView.contentInset = UIEdgeInsetsMake(-10, 0, 0, 0);
    }
    return _tableView;
}
- (UITableView *)tableView2 {
    if (!_tableView2) {
        //Add a table page
        _tableView2 = [[UITableView alloc] init];
        _tableView2.delegate = self;
        _tableView2.dataSource = self;
        _tableView2.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView2 registerNib:[UINib nibWithNibName:@"InvolvedRecordCell" bundle:nil] forCellReuseIdentifier:@"InvolvedRecordCellID"];

    }
    return _tableView2;
}
- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
- (NSMutableArray *)dataArray2
{
    if (!_dataArray2) {
        _dataArray2 = [NSMutableArray array];
    }
    return _dataArray2;
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
    return @[@"我的参与", @"中奖记录"][index];
}
- (UIView *)segmentedPager:(MXSegmentedPager *)segmentedPager viewForPageAtIndex:(NSInteger)index {
    return @[self.tableView, self.tableView2][index];
}

#pragma mark <UITableViewDelegate>

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    TreasureRecordsModel *model = tableView==self.tableView ?self.dataArray[indexPath.row] : self.dataArray2[indexPath.row];
    if ([model.status intValue] == 2) {
        return;
    }

    OneIndianaDetailViewController *shopdetail=[[OneIndianaDetailViewController alloc]init];
    shopdetail.stringtype = @"我的参与";
    shopdetail.shop_code= model.shop_code;
    shopdetail.recordsModel = model;
    [self.navigationController pushViewController:shopdetail animated:YES];
}
#pragma mark <UITableViewDataSource>

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    TreasureRecordsModel *model = tableView==self.tableView ?self.dataArray[indexPath.row] : self.dataArray2[indexPath.row];

    if ([model.status intValue] == 3) {
        return 10 + kZoom6pt(35) + 10 + kZoom6pt(70) + 10 + kZoom6pt(35) + 10;
    } else {
        return 10 + kZoom6pt(35) + 10 + kZoom6pt(70) + 10;
    }
}
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return tableView==self.tableView ? self.dataArray.count : self.dataArray2.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    InvolvedRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:@"InvolvedRecordCellID"];
    cell.indexPath = indexPath;
    cell.model = tableView==self.tableView ? self.dataArray[indexPath.row] : self.dataArray2[indexPath.row];

    return cell;

}

#pragma mark - 1️⃣➢➢➢ data
/*
 pt 夺宝分类 String 可选 0普通夺宝 1 额度夺宝 查询  默认0
 my_win 是否查询中奖 string 可选 是否查询是否中奖 0否1是 默认0 当pt==1是有效
 */
- (void)httpGetMine
{
    NSString *token = [TFPublicClass getTokenFromLocal];

    NSString *urlStr = [NSString stringWithFormat:@"%@treasures/getMyParticipationList?token=%@&version=%@&page=%d&sort=btime&order=desc&pt=1", [NSObject baseURLStr], token, VERSION, (int)self.httpPage];
    NSString *URL = [MyMD5 authkey:urlStr];

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:URL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        responseObject = [NSDictionary changeType:responseObject];
        //        [self.tableView headerEndRefreshing];
        [self.tableView footerEndRefreshing];
        if (kUnNilAndNULL(responseObject)) {
            MyLog(@"responseObject: %@", responseObject);

            if (kUnNilAndNULL(responseObject)) {
                if ([responseObject[@"status"] intValue] == 1) {
                    [NSObject saveResponseData:responseObject toPath:urlStr];
                    [self tableViewGetMineData:responseObject];
                } else {
                    NavgationbarView *nv = [[NavgationbarView alloc] init];
                    [nv showLable:responseObject[@"message"] Controller:self];
                }
            }

        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {

        id responseObject = [NSObject loadResponseWithPath:urlStr];
        [self tableViewGetMineData:responseObject];

        NavgationbarView *nv = [[NavgationbarView alloc] init];
        [nv showLable:@"网络连接失败，请检查网络设置~" Controller:self];

        if (!self.dataArray.count) {

            [self createBackgroundView:self.tableView andTag:10 andFrame:self.tableView.bounds withImgge:nil andText:nil];
        }

        [self.tableView ffRefreshHeaderEndRefreshing];
        //        [self.tableView headerEndRefreshing];
        [self.tableView footerEndRefreshing];
    }];

}
- (void)tableViewGetMineData:(NSDictionary *)responseObject
{
    if (kUnNilAndNULL(responseObject[@"data"])) {

        if (self.httpPage == 1) {
            [self.dataArray removeAllObjects];
        }

        NSArray *data = responseObject[@"data"];
        for (NSDictionary *obj in data) {
            TreasureRecordsModel *model = [[TreasureRecordsModel alloc] init];
            [model setValuesForKeysWithDictionary:obj];
            [self.dataArray addObject:model];

        }

        if (!self.dataArray.count) {

            [self createBackgroundView:self.tableView andTag:10 andFrame:self.tableView.bounds withImgge:nil andText:nil];

        } else {
            [self cleanShowBackground];
        }

        [self.tableView reloadData];
    }

}
- (void)httpGetMine2
{
    NSString *token = [TFPublicClass getTokenFromLocal];

    NSString *urlStr = [NSString stringWithFormat:@"%@treasures/getMyParticipationList?token=%@&version=%@&page=%d&sort=btime&order=desc&pt=1&my_win=1", [NSObject baseURLStr], token, VERSION, (int)self.httpPage2];
    NSString *URL = [MyMD5 authkey:urlStr];

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:URL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        responseObject = [NSDictionary changeType:responseObject];
        [self.tableView2 footerEndRefreshing];
        if (kUnNilAndNULL(responseObject)) {
            MyLog(@"responseObject: %@", responseObject);

            if (kUnNilAndNULL(responseObject)) {
                if ([responseObject[@"status"] intValue] == 1) {
                    [NSObject saveResponseData:responseObject toPath:urlStr];
                    [self tableViewGetMineData2:responseObject];
                } else {
                    NavgationbarView *nv = [[NavgationbarView alloc] init];
                    [nv showLable:responseObject[@"message"] Controller:self];
                }
            }

        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {

        id responseObject = [NSObject loadResponseWithPath:urlStr];
        [self tableViewGetMineData2:responseObject];

        NavgationbarView *nv = [[NavgationbarView alloc] init];
        [nv showLable:@"网络连接失败，请检查网络设置~" Controller:self];

        if (!self.dataArray2.count) {

            [self createBackgroundView:self.tableView2 andTag:10 andFrame:self.tableView2.bounds withImgge:nil andText:nil];


        }

        [self.tableView2 footerEndRefreshing];
    }];

}
- (void)tableViewGetMineData2:(NSDictionary *)responseObject
{
    if (kUnNilAndNULL(responseObject[@"data"])) {

        if (self.httpPage2 == 1) {
            [self.dataArray2 removeAllObjects];
        }

        NSArray *data = responseObject[@"data"];
        for (NSDictionary *obj in data) {
            TreasureRecordsModel *model = [[TreasureRecordsModel alloc] init];
            [model setValuesForKeysWithDictionary:obj];
            [self.dataArray2 addObject:model];

        }

        if (!self.dataArray2.count) {

            [self createBackgroundView:self.tableView2 andTag:10 andFrame:self.tableView2.bounds withImgge:nil andText:nil];


        } else {
            [self cleanShowBackground];
        }

        [self.tableView2 reloadData];
    }

}

- (void)httpGetMoney {
    [[APIClient sharedManager] netWorkGeneralRequestWithApi:@"treasures/getTreaExtract?" caches:NO cachesTimeInterval:0*TFMinute token:YES success:^(id data, Response *response) {
        if (response.status == 1) {
            _headMoney.text = [NSString stringWithFormat:@"¥%.1f",[data[@"data"] floatValue]];
        }
    } failure:^(NSError *error) {

    }];
}
- (void)httpGetData
{
    //获取余额
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *token = [ud objectForKey:USER_TOKEN];
    NSString *urlStr1 = [NSString stringWithFormat:@"%@wallet/myWallet?version=%@&token=%@",[NSObject baseURLStr],VERSION,token];
    NSString *URL1 = [MyMD5 authkey:urlStr1];

    kSelfWeak;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:URL1 parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {

        responseObject = [NSDictionary changeType:responseObject];

        if (responseObject!=nil) {

            if ([responseObject[@"status"] intValue] == 1) {

                float balance = [[NSString stringWithFormat:@"%@",responseObject[@"balance"]] floatValue];
                float extract = [[NSString stringWithFormat:@"%@",responseObject[@"extract"]] floatValue];
                float ex_free = [[NSString stringWithFormat:@"%@",responseObject[@"ex_free"]] floatValue];
                float freeze_balance = [[NSString stringWithFormat:@"%@",responseObject[@"freeze_balance"]] floatValue];

                AXSampleNavBarTabViewController *vc = [[AXSampleNavBarTabViewController alloc]initWithType:YDPageVCTypeMoney peas:balance peas_freeze:freeze_balance extract:extract freezeMoney:ex_free];
                [weakSelf.navigationController pushViewController:vc animated:YES];

            } else {
                //                [MBProgressHUD showError:responseObject[@"message"]];
            }
        }

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MBProgressHUD showError:@"网络连接失败,请检查网络设置"];
    }];

}
@end
