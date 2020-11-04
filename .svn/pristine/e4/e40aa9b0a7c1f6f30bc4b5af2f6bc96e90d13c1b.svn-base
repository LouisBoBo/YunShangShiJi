//
//  TFShareOrderViewController.m
//  YunShangShiJi
//
//  Created by jingaiweiyi on 16/5/28.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import "TFShareOrderViewController.h"
#import "IndianaModel.h"
#import "IndianaCell.h"
#import "SharOrderVC.h"
#import "TFPublicClass.h"
#import "GlobalTool.h"

@interface TFShareOrderViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, assign) NSInteger httpPage;
@property (nonatomic, strong) NSIndexPath *selectIndexPath; // 选中行

@end

@implementation TFShareOrderViewController

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:AddLikeNotification object:nil];
    
    if (self.tableView.topShowView) {
        [self.tableView removeObserver:self.tableView forKeyPath:observerRefreshHeaderViewKeyPath];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    [self setupUI];
    


    
}

- (void)setupUI
{
    ESWeakSelf;
    self.httpPage = 1;
    
    if (self.myShareTypeIndex == MyShareTypeMine) {
        if (!_tableView) {
            _tableView = ({
                UITableView *tableView = [UITableView new];
                //            tableView.backgroundColor = COLOR_RANDOM;
                [self.view addSubview:tableView];
                //            tableView.rowHeight = UITableViewAutomaticDimension;
                
                [tableView registerClass:[IndianaCell class] forCellReuseIdentifier:kCellIdentifier_Indiana];
                tableView.backgroundColor = [UIColor whiteColor];
                tableView.delegate = self;
                tableView.dataSource = self;
                [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.edges.equalTo(__weakSelf.view);
                }];
                
                
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
                
                
                tableView;
            });
        }
    } else {
        
        UIImage *defaultImage = [UIImage imageNamed:@""];
        CGFloat defaultW = kScreen_Width;
//        CGFloat defaultH = defaultW*defaultImage.size.height/defaultImage.size.width;

        __block CGFloat W = defaultW;
//        __block CGFloat H = defaultH;
        __block CGFloat H = 0;

        
        [self.view addSubview:self.scrollView];
        [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
        }];
        
        UIImageView *imageV = [[UIImageView alloc] init];
        [self.scrollView addSubview:imageV];
        [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.scrollView.mas_left);
            make.top.equalTo(self.scrollView.mas_top);
            make.size.mas_equalTo(CGSizeMake(W, H));
        }];
        
        PhotoOperate *photoOperate = [PhotoOperate sharedPhotoOperate];
        
        NSString *photoUrl = self.myShareTypeIndex == MyShareTypeOthers
        ?
        [NSString stringWithFormat:@"%@%@", [NSObject baseURLStr_Upy], @"shop_comment/share_order/default.png"]
        :
        [NSString stringWithFormat:@"%@%@", [NSObject baseURLStr_Upy], @"shop_comment/share_order/pintuan/default.png"];
        [MBProgressHUD showMessage:@"正在加载..." afterDeleay:0 WithView:self.view];
        [photoOperate downloadPhotoWithURL:photoUrl cachesFilePath:nil  progress:^(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead) {
            //NSLog(@"progress: %f％", (float)totalBytesRead / totalBytesExpectedToRead);
        } success:^(UIImage *image, NSString *photoPath) {
            [MBProgressHUD hideHUDForView:self.view animated:NO];
            imageV.image = image;
            CGSize currSize = image.size;
            H = defaultW*currSize.height/currSize.width;
            [imageV mas_updateConstraints:^(MASConstraintMaker *make) {
                make.size.mas_equalTo(CGSizeMake(W, H));
            }];
            self.scrollView.contentSize = CGSizeMake(W, H);
            
        } failure:^(NSError *error) {
            [MBProgressHUD hideHUDForView:self.view animated:NO];            MyLog(@"error: %@", error);
            imageV.image = defaultImage;
            self.scrollView.contentSize = CGSizeMake(W, H);
        }];
        self.scrollView.contentSize = CGSizeMake(W, H);
        
    }
    
    [self httpRequestAlls];
    __weak typeof (self) weakS = self;
    [self reloadDataBlock:^{
        [weakS httpRequestAlls];
    }];
    
}

- (void)httpRequestAlls
{
    if (self.myShareTypeIndex == MyShareTypeMine) {
        [self httpGetMine];
    } else {
//        [self httpGetOthers];
    }
}

- (void)httpGetMine
{
    NSString *token = [TFPublicClass getTokenFromLocal];
    NSString *uid = [TFPublicClass getUIDFromLocal];
    
    NSString *urlStr = [NSString stringWithFormat:@"%@shareOrder/selCommList?token=%@&version=%@&user_id=%@&pager.curPage=%d", [NSObject baseURLStr], token, VERSION, uid,(int)self.httpPage];
    NSString *URL = [MyMD5 authkey:urlStr];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:URL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        responseObject = [NSDictionary changeType:responseObject];
        [self.tableView ffRefreshHeaderEndRefreshing];
//        [self.tableView headerEndRefreshing];
        [self.tableView footerEndRefreshing];
        if (kUnNilAndNULL(responseObject)) {
//            MyLog(@"responseObject: %@", responseObject);
            if ([responseObject[@"status"] intValue] == 1) {
                
                [NSObject saveResponseData:responseObject toPath:urlStr];
                [self tableViewGetMineData:responseObject];
                
            } else {
                NavgationbarView *nv = [[NavgationbarView alloc] init];
                [nv showLable:responseObject[@"message"] Controller:self];
            }
            
        } else {
            
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
}

- (void)tableViewGetMineData:(NSDictionary *)responseObject
{
    if (kUnNilAndNULL(responseObject[@"comments"])) {
        
        if (self.httpPage == 1) {
            [self.dataArray removeAllObjects];
        }
        
        NSArray *comments = responseObject[@"comments"];
        NSArray *shop_codes = responseObject[@"shop_codes"];
        
        for (NSDictionary *obj in comments) {
            IndianaModel *model = [[IndianaModel alloc] init];
            
            [model setValuesForKeysWithDictionary:obj];
            
            if ([shop_codes containsObject:obj[@"shop_code"]]) {
                model.isClick = YES;
            } else {
                model.isClick = NO;
            }
            [self.dataArray addObject:model];
        }
        
        if (!self.dataArray.count) {
            [self showBackgroundType:ShowBackgroundTypeListEmpty message:@"亲，赶快抽奖晒单吧~" superView:nil setSubFrame:self.view.bounds];
        } else {
            [self cleanShowBackground];
        }
        
        [self.tableView reloadData];
    }
}

- (void)httpGetOthers
{
    NSString *token = [TFPublicClass getTokenFromLocal];
//    NSString *uid = [TFPublicClass getUIDFromLocal];
    
    NSString *urlStr = [NSString stringWithFormat:@"%@shareOrder/selCommList?token=%@&version=%@&pager.curPage=%d", [NSObject baseURLStr], token, VERSION,(int)self.httpPage];
    NSString *URL = [MyMD5 authkey:urlStr];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:URL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        responseObject = [NSDictionary changeType:responseObject];
        [self.tableView ffRefreshHeaderEndRefreshing];
//        [self.tableView headerEndRefreshing];
        [self.tableView footerEndRefreshing];
        if (kUnNilAndNULL(responseObject)) {
//            MyLog(@"responseObject: %@", responseObject);
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
        
//        [self showBackgroundType:ShowBackgroundTypeNetError message:nil superView:nil setSubFrame:self.view.bounds];
        
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
    if (kUnNilAndNULL(responseObject[@"comments"])) {
        
        if (self.httpPage == 1) {
            [self.dataArray removeAllObjects];
        }
        
        NSArray *comments = responseObject[@"comments"];
        NSArray *shop_codes = responseObject[@"shop_codes"];
        
        for (NSDictionary *obj in comments) {
            IndianaModel *model = [[IndianaModel alloc] init];
            
            [model setValuesForKeysWithDictionary:obj];
            
            if ([shop_codes containsObject:obj[@"shop_code"]]) {
                model.isClick = YES;
            } else {
                model.isClick = NO;
            }
            
            
            [self.dataArray addObject:model];
            
        }
        
        if (!self.dataArray.count) {
            [self showBackgroundType:ShowBackgroundTypeListEmpty message:@"亲，还没有人晒单呢，赶快抽奖晒单吧~" superView:nil setSubFrame:self.view.bounds];
        } else {
            [self cleanShowBackground];
        }
        
        [self.tableView reloadData];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = [IndianaCell cellHeightWithObj:self.dataArray[indexPath.row]];
    return height;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    IndianaCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier_Indiana];
    cell.indexPath = indexPath;
    cell.model = self.dataArray[indexPath.row];
    if (!cell.moreButtonClickedBlock) {
        [cell setMoreButtonClickedBlock:^(NSIndexPath *indexPath) {
            IndianaModel *model = self.dataArray[indexPath.row];
            model.isOpening = !model.isOpening;
            [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        }];
    }
    
    if (!cell.commentClickedBlock) {
        [cell setCommentClickedBlock:^(IndianaModel *curModel, NSIndexPath *indexPath) {
            SharOrderVC *shareOrderVC = [[SharOrderVC alloc] initWithShopCode:curModel.shop_code];
            [self.navigationController pushViewController:shareOrderVC animated:YES];
        }];
    }
    
    if (!cell.likeBtnClickedBlock) {
        [cell setLikeBtnClickedBlock: ^(IndianaModel *curModel, NSIndexPath *indexPath) {
            [self httpLike:curModel withIndexPath:indexPath];
        }];
    }
    
    if (!cell.userBtnClickedBlock) {
        [cell setUserBtnClickedBlock:^{
            
        }];
    }
    
    cell.refreshSingleCellBlock = ^(){
        [self.tableView reloadData];
        
    };
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"晒单详情");
    [[NSNotificationCenter defaultCenter] removeObserver:self name:AddLikeNotification object:nil];
    _selectIndexPath = [indexPath copy];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addLickNC) name:AddLikeNotification object:nil];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    IndianaModel *model = self.dataArray[indexPath.row];
    SharOrderVC *shareOrderVC = [[SharOrderVC alloc] initWithShopCode:model.shop_code];
    [self.navigationController pushViewController:shareOrderVC animated:YES];
}

- (void)viewDidLayoutSubviews
{
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsMake(0,kScreenWidth,0,0)];
    }
    
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.tableView setLayoutMargins:UIEdgeInsetsMake(0,kScreenWidth,0,0)];
    }
}

- (void)httpLike:(IndianaModel *)model withIndexPath:(NSIndexPath *)indexPath
{
    NSString *token = [TFPublicClass getTokenFromLocal];
    NSString *urlStr = [NSString stringWithFormat:@"%@shareOrder/addClick?token=%@&version=%@&shop_code=%@", [NSObject baseURLStr], token, VERSION, model.shop_code];
    NSString *URL = [MyMD5 authkey:urlStr];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    [manager GET:URL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        responseObject = [NSDictionary changeType:responseObject];
        MyLog(@"responseObject: %@",responseObject);
        if (kUnNilAndNULL(responseObject)) {
            if ([responseObject[@"status"] intValue] == 1) {
                NavgationbarView *nv = [[NavgationbarView alloc] init];
                [nv showLable:@"点赞成功" Controller:self];
                model.isClick = YES;
                model.click_size = [NSNumber numberWithInteger:[model.click_size integerValue]+1];
                [self.dataArray replaceObjectAtIndex:indexPath.row withObject:model];
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
                    
                });
                
            } else {
                NavgationbarView *nv = [[NavgationbarView alloc] init];
                [nv showLable:responseObject[@"message"] Controller:self];
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
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
    view.frame = CGRectMake(kScreenWidth, 0, kScreenWidth, kScreenHeight-kNavigationheightForIOS7-ZOOM6(80));
    self.view = view;
}

- (void)addLickNC {
    IndianaModel *model = self.dataArray[_selectIndexPath.row];
    model.isClick = YES;
    model.click_size = [NSNumber numberWithInt:model.click_size.intValue + 1];
    [self.dataArray replaceObjectAtIndex:_selectIndexPath.row withObject:model];
    [self.tableView reloadRowsAtIndexPaths:@[_selectIndexPath] withRowAnimation:UITableViewRowAnimationNone];
}

- (UIScrollView *)scrollView
{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
//        _scrollView.backgroundColor = COLOR_RANDOM;
        _scrollView.bounces = NO;
    }
    return _scrollView;
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
