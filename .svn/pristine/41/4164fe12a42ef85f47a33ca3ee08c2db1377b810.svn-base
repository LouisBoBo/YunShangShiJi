//
//  TFInvolvedUncoverViewController.m
//  YunShangShiJi
//
//  Created by jingaiweiyi on 16/5/28.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import "TFInvolvedUncoverViewController.h"
#import "InvolvedRecordCell.h"
#import "AgoAnnounceCell.h"
#import "TFPublicClass.h"
#import "GlobalTool.h"
#import "TreasureRecordsModel.h"
#import "IndianaDetailViewController.h"
#import "TFTreasureRecordsVM.h"
#import "FightIndianaDetailViewController.h"

@interface TFInvolvedUncoverViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, assign) NSInteger httpPage;
@end

@implementation TFInvolvedUncoverViewController

- (void)dealloc
{
    if (self.tableView.topShowView) {
        [self.tableView removeObserver:self.tableView forKeyPath:observerRefreshHeaderViewKeyPath];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupUI];
}

- (void)setupUI
{
    ESWeakSelf;
    self.httpPage = 1;
    if (!_tableView) {
        _tableView = ({
            UITableView *tableView = [UITableView new];
//            tableView.backgroundColor = COLOR_RANDOM;
            tableView.delegate = self;
            tableView.dataSource = self;
            tableView.backgroundColor = [UIColor whiteColor];
            [tableView registerNib:[UINib nibWithNibName:@"InvolvedRecordCell" bundle:nil] forCellReuseIdentifier:@"InvolvedRecordCellID"];
            
            [tableView registerNib:[UINib nibWithNibName:@"AgoAnnounceCell" bundle:nil] forCellReuseIdentifier:@"AgoAnnounceCellID"];
            
            __weak __typeof(&*self)weakSelf = self;
//            [tableView addHeaderWithCallback:^{
//                weakSelf.httpPage = 1;
//                [weakSelf httpRequestAlls];
//            }];
            
            [tableView addTopHeaderWithCallback:^{
                weakSelf.httpPage = 1;
                [weakSelf httpRequestAlls];

            }];
            
            [tableView addFooterWithCallback:^{
                weakSelf.httpPage ++;
                [weakSelf httpRequestAlls];
            }];
            
            [self.view addSubview:tableView];
            [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(__weakSelf.view);
            }];
            tableView;
        });
    }
    

    [self httpRequestAlls];
    
    __weak typeof (self) weakS = self;
    [self reloadDataBlock:^{
        [weakS httpRequestAlls];
    }];
}
- (void)httpRequestAlls
{
    
    if (self.myTypeIndex & (MyTypeTheMine|MyTypeTheMine_TreasureGroup)) {
        [self httpGetMine];
    }else {
        [self httpGetOthers];
    }

}

- (void)httpGetMine
{
    NSString *token = [TFPublicClass getTokenFromLocal];
    
    NSString *urlStr = self.myTypeIndex==MyTypeTheMine
    ? [NSString stringWithFormat:@"%@treasures/getMyParticipationList?token=%@&version=%@&page=%d&sort=btime&order=desc", [NSObject baseURLStr], token, VERSION, (int)self.httpPage]
    : [NSString stringWithFormat:@"%@rollTrea/getMyPation?token=%@&version=%@&page=%d&sort=add_time&order=desc", [NSObject baseURLStr], token, VERSION, (int)self.httpPage];
;
    NSString *URL = [MyMD5 authkey:urlStr];

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:URL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        responseObject = [NSDictionary changeType:responseObject];
        [self.tableView ffRefreshHeaderEndRefreshing];
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
        
//        [self showBackgroundType:ShowBackgroundTypeNetError message:nil superView:nil setSubFrame:self.view.bounds];
        id responseObject = [NSObject loadResponseWithPath:urlStr];
        [self tableViewGetMineData:responseObject];
        
        NavgationbarView *nv = [[NavgationbarView alloc] init];
        [nv showLable:@"网络连接失败，请检查网络设置~" Controller:self];
        
        if (!self.dataArray.count) {
                [self showBackgroundType:ShowBackgroundTypeNetError message:nil superView:nil setSubFrame:self.view.bounds];
        }
        
        [self.tableView ffRefreshHeaderEndRefreshing];
//        [self.tableView headerEndRefreshing];
        [self.tableView footerEndRefreshing];
    }];
    
    
//    [TFTreasureRecordsVM handleDataWithTreasureRecordsPageNum:self.httpPage success:^(NSArray *modelArray, Response *response) {
//        
//        if (response.status == 1) {
//            if (self.httpPage == 1) {
//                [self.dataArray removeAllObjects];
//            }
//            
//            [self.dataArray addObjectsFromArray:modelArray];
//            if (!self.dataArray.count) {
//                [self showBackgroundType:ShowBackgroundTypeListEmpty message:@"亲，您还未参与夺宝哦~" superView:nil setSubFrame:self.view.bounds];
//            } else {
//                [self cleanShowBackground];
//            }
//            
//            dispatch_async(dispatch_get_main_queue(), ^{
//                [self.tableView reloadData];
//            });
//        }
//        
//        
//    } failure:^(NSError *error) {
//        [self showBackgroundType:ShowBackgroundTypeNetError message:nil superView:nil setSubFrame:self.view.bounds];
//        
//        [self showBackgroundType:ShowBackgroundTypeNetError message:nil superView:nil setSubFrame:self.view.bounds];
//        
//        [self.tableView headerEndRefreshing];
//        [self.tableView footerEndRefreshing];
//    }];
    
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
            [self showBackgroundType:ShowBackgroundTypeListEmpty message:@"亲，您还未参与抽奖哦~" superView:nil setSubFrame:self.view.bounds];
        } else {
            [self cleanShowBackground];
        }
        
        [self.tableView reloadData];
    }
    
}

- (void)httpGetOthers
{
    NSString *token = [TFPublicClass getTokenFromLocal];
    
    NSString *urlStr = self.myTypeIndex == MyTypeTheOthers
    ? [NSString stringWithFormat:@"%@treasures/getWinParticipationList?token=%@&version=%@&page=%d&sort=otime&order=desc", [NSObject baseURLStr], token, VERSION, (int)self.httpPage]
    : [NSString stringWithFormat:@"%@rollTrea/getPast?token=%@&version=%@&page=%d&sort=btime&order=desc", [NSObject baseURLStr], token, VERSION, (int)self.httpPage];


    NSString *URL = [MyMD5 authkey:urlStr];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:URL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        responseObject = [NSDictionary changeType:responseObject];
        [self.tableView ffRefreshHeaderEndRefreshing];
//        [self.tableView headerEndRefreshing];
        [self.tableView footerEndRefreshing];
        
        MyLog(@"responseObject: %@", responseObject);
        
        if (kUnNilAndNULL(responseObject)) {
            
            if ([responseObject[@"status"] intValue] == 1) {
                [NSObject saveResponseData:responseObject toPath:urlStr];
                [self tableViewGetOthersData:responseObject];
            } else {
                NavgationbarView *nv = [[NavgationbarView alloc] init];
                [nv showLable:responseObject[@"message"] Controller:self];
            }
        } else {
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        
        id responseObject = [NSObject loadResponseWithPath:urlStr];
        [self tableViewGetOthersData:responseObject];
        
        NavgationbarView *nv = [[NavgationbarView alloc] init];
        [nv showLable:@"网络连接失败，请检查网络设置~" Controller:self];
        
        if (!self.dataArray.count) {
            [self showBackgroundType:ShowBackgroundTypeNetError message:nil superView:nil setSubFrame:self.view.bounds];
        }
        
        [self.tableView ffRefreshHeaderEndRefreshing];
//        [self.tableView headerEndRefreshing];
        [self.tableView footerEndRefreshing];
    }];
}

- (void)tableViewGetOthersData:(NSDictionary *)responseObject
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
            [self showBackgroundType:ShowBackgroundTypeListEmpty message:@"亲，暂时还没有往期揭晓纪录~" superView:nil setSubFrame:self.view.bounds];
        } else {
            [self cleanShowBackground];
        }
        
        [self.tableView reloadData];
        
    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.myTypeIndex & (MyTypeTheMine|MyTypeTheMine_TreasureGroup)) {
        
        TreasureRecordsModel *model = self.dataArray[indexPath.row];
        
        if ([model.status intValue] == 3) {
            return 10 + kZoom6pt(35) + 10 + kZoom6pt(70) + 10 + kZoom6pt(35) + 10;
        } else {
            return 10 + kZoom6pt(35) + 10 + kZoom6pt(70) + 10;
        }
        
    } else {

        return kZoom6pt(130);
        
    }
    return 0;
}

-(void)viewDidLayoutSubviews
{
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsMake(0,kScreenWidth,0,0)];
    }
    
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.tableView setLayoutMargins:UIEdgeInsetsMake(0,kScreenWidth,0,0)];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.myTypeIndex & (MyTypeTheMine|MyTypeTheMine_TreasureGroup)) {
        InvolvedRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:@"InvolvedRecordCellID"];
        cell.indexPath = indexPath;
        if (self.myTypeIndex==MyTypeTheMine) {
            cell.model = self.dataArray[indexPath.row];
        }else
            cell.model2 = self.dataArray[indexPath.row];

        return cell;
    } else {
        AgoAnnounceCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AgoAnnounceCellID"];
        cell.indexPath = indexPath;

        if (self.myTypeIndex == MyTypeTheOthers) {
            cell.model = self.dataArray[indexPath.row];
        }else
            cell.model2 = self.dataArray[indexPath.row];
   
        return cell;
    }
    return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    TreasureRecordsModel *model = self.dataArray[indexPath.row];
    if ([model.status intValue]==2 && self.myTypeIndex==MyTypeTheMine) {
        return;
    }
    if (self.myTypeIndex & (MyTypeTheOthers_TreasureGroup|MyTypeTheMine_TreasureGroup)) {
        FightIndianaDetailViewController *vc = [[FightIndianaDetailViewController alloc]init];
        vc.shop_code = model.shop_code;
        vc.recordsModel = model;
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    
    IndianaDetailViewController *shopdetail=[[IndianaDetailViewController alloc]init];
    shopdetail.shop_code= model.shop_code;
    shopdetail.recordsModel = model;
    [self.navigationController pushViewController:shopdetail animated:YES];
}

- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (void)loadView
{
    UIView *view = [UIView new];
    view.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight-kNavigationheightForIOS7-ZOOM6(80));
    self.view = view;
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
