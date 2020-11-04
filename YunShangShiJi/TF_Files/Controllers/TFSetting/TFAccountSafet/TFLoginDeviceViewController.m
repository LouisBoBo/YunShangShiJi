//
//  TFLoginDeviceViewController.m
//  YunShangShiJi
//
//  Created by 云商 on 15/7/2.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//

#import "TFLoginDeviceViewController.h"
#import "LoginDeviceModel.h"


@interface TFLoginDeviceViewController ()

@property (nonatomic, assign)int page;

@end

@implementation TFLoginDeviceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [super setNavigationItemLeft:@"登录设备"];
    
    self.page = 1;
    
    [self setupUI];
    
    [self httpGetDataSource];
}

- (void)httpGetDataSource
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *token = [ud objectForKey:USER_TOKEN];
    NSString *urlStr = [NSString stringWithFormat:@"%@loginRecord/loginList?version=%@&token=%@&pager.curPage=%d",[NSObject baseURLStr],VERSION,token,self.page];
    NSString *URL = [MyMD5 authkey:urlStr];
    
    //
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:URL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        responseObject = [NSDictionary changeType:responseObject];
        [self clearBackgroundView:self.view withTag:99999];
        [self.tableView footerEndRefreshing];   //停止刷新
        [self.tableView ffRefreshHeaderEndRefreshing];
//        [self.tableView headerEndRefreshing];   //停止刷新
        
        if (responseObject!=nil) {
            if ([responseObject[@"status"] intValue] == 1) {
                
                [NSObject saveResponseData:responseObject toPath:urlStr];
                [self tableGetLoginDeviceData:responseObject];
                
                if (!self.dataArray.count) {
                    CGRect frame = CGRectMake(0, kNavigationheightForIOS7, self.view.frame.size.width, kScreenHeight-kNavigationheightForIOS7);
                    
                    [self showBackgroundType:ShowBackgroundTypeListEmpty message:nil superView:self.view setSubFrame:frame];
                }
                
            } else {
                [MBProgressHUD showError:responseObject[@"message"]];
            }

        }
        
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self.tableView footerEndRefreshing];   //停止刷新
//        [self.tableView headerEndRefreshing];   //停止刷新
         [self.tableView ffRefreshHeaderEndRefreshing];

         
        id responseObject = [NSObject loadResponseWithPath:urlStr];
         [self tableGetLoginDeviceData:responseObject];
         
         NavgationbarView *nv = [[NavgationbarView alloc] init];
         [nv showLable:@"网络连接失败，请检查网络设置~" Controller:self];
         
         if (!self.dataArray.count) {
             CGRect frame = CGRectMake(0, kNavigationheightForIOS7, self.view.frame.size.width, kScreenHeight-kNavigationheightForIOS7);
             [self createBackgroundView:self.view andTag:99999 andFrame:frame withImgge:[UIImage imageNamed:@"哭脸"] andText:@"亲,没网了"];
         }
    }];
}

- (void)tableGetLoginDeviceData:(NSDictionary *)responseObject
{
    if (self.page == 1) { //上拉
        [self.dataArray removeAllObjects];
        [self.tableView reloadData];
    }
    
    NSArray *loginlistArr = responseObject[@"loginlist"];
    
    if (loginlistArr.count == 0 &&self.dataArray.count == 0) {
        CGRect frame = CGRectMake(0, kNavigationheightForIOS7, self.view.frame.size.width, kScreenHeight-kNavigationheightForIOS7);
        [self createBackgroundView:self.view andTag:10000 andFrame:frame withImgge:nil andText:nil];
        
    } else {
        [self clearBackgroundView:self.view withTag:10000];
        for (NSDictionary *dic in loginlistArr) {
            LoginDeviceModel *ldModel = [[LoginDeviceModel alloc] init];
            [ldModel setValuesForKeysWithDictionary:dic];
            ldModel.ID = dic[@"id"];
            [self.dataArray addObject:ldModel];
        }
        //刷新数据
        [self.tableView reloadData];
    }
}

#pragma mark - 创建UI
- (void)setupUI
{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kNavigationheightForIOS7, kScreenWidth, kScreenHeight-kNavigationheightForIOS7)];
    self.tableView.backgroundColor = RGBCOLOR_I(240, 240, 240);
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [[UIView alloc] init];
//    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    __weak TFLoginDeviceViewController *weakSelf = self;
    //加下拉刷新
//    [self.tableView addHeaderWithCallback:^{
//        //
//        tfld.page = 1;
//        [tfld httpGetDataSource];
//    }];
    
    
    [self.tableView addTopHeaderWithCallback:^{
        weakSelf.page = 1;
        [weakSelf httpGetDataSource];
    }];
    
//    [self.tableView ffRefreshHeaderBeginRefreshing];
    
    //加上拉刷新
    [self.tableView addFooterWithCallback:^{
        weakSelf.page++;
        [weakSelf httpGetDataSource];
    }];
    [self.view addSubview:self.tableView];
}
#pragma mark - 下来刷新
- (void)loadNew
{

}

#pragma mark - 上拉刷新
- (void)loadMore
{
//    [self httpGetDataSource];
}


#pragma mark - tableView代理方法

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 75;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LoginDeviceCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LOGINDEVICECELLID"];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"LoginDeviceCell" owner:self options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }

    
    [cell receiveDataModel:self.dataArray[indexPath.row]];
    return cell;
}

-(void)viewDidLayoutSubviews
{
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsMake(0,0,0,0)];
    }
    
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.tableView setLayoutMargins:UIEdgeInsetsMake(0,0,0,0)];
    }
}


- (void)dealloc
{
    MyLog(@"%@ release", [self class]);
    if (self.tableView.topShowView) {
        [self.tableView removeObserver:self.tableView forKeyPath:observerRefreshHeaderViewKeyPath];
    }

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
