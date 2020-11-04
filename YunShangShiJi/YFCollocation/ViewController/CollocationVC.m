//
//  CollocationVC.m
//  YunShangShiJi
//
//  Created by zgl on 16/6/16.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import "CollocationVC.h"

#import "GlobalTool.h"
#import "NSDate+Helper.h"
#import "AppDelegate.h"
#import "UIScrollView+MyRefresh.h"

#import "YFDPCell.h"
#import "TFLoginView.h"
#import "UpdateView.h"
#import "WTFAlertView.h"
#import "YFSearchView.h"
#import "TopRemindView.h"


#import "LoginViewController.h"
#import "TFSearchViewController.h"

#import "NewShoppingCartViewController.h"
#import "ShopDetailViewController.h"
#import "CollocationDetailViewController.h"
#import "YFDoubleSucessVC.h"

#import "CollocationMainModel.h"
#import "ShopCarCountModel.h"
#import "AddVoucherModel.h"
#import "DoubleModel.h"

@interface CollocationVC ()<UITableViewDataSource, UITableViewDelegate, YFSearchViewDelegate>
{
    CGFloat _firstX;                    //滑动时x初始位置
    NSMutableArray *_searchTitleData;   //侧边栏段标题
    NSMutableArray *_searchCellData;    //侧边栏cell数据
    NSMutableArray *_mainData;          //列表数据
    NSInteger _page;                    //当前页码
    dispatch_source_t _timer;           //计时器
    NSInteger _timeout;                 //倒计时
}

@property (nonatomic, strong) UIImageView *myNavigationView; //导航栏
@property (nonatomic, strong) UILabel *marklable;          //购物车角标
@property (nonatomic, strong) UITableView *mainTableView;  //主界面
@property (nonatomic, strong) YFSearchView *searchView;    //侧边搜索栏
@property (nonatomic, strong) TopRemindView *topRemindView;//头部余额翻倍倒计时

@end

@implementation CollocationVC

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:YFLaunchViewDisappear object:nil];
    [self.mainTableView removeObserver:self.mainTableView forKeyPath:observerRefreshHeaderViewKeyPath];
    if (self.netStatusBlock) {
        [[NSNotificationCenter defaultCenter] removeObserver:self name:netStatusNotificationCenter object:nil];
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    /// 更新购物车
//    [self loadShopCarCount];
    /// 余额翻倍
//    [self doubleTime];
    /// 弹窗
    if ([DataManager sharedManager].isLaunch == NO) {
        [self updateview];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateview) name:YFLaunchViewDisappear object:nil];
    _page = 1;
    _mainData = [NSMutableArray array];
    [self setUI];
    [self loadData];

    ESWeak(self, ws);
    [self netStatusBlock:^(NetworkStates networkState) {
        if (networkState != NetworkStatesNone) {
            MyLog(@"networkState: %lu", (unsigned long)networkState);
            NavgationbarView *nv = [[NavgationbarView alloc] init];
            [nv showLable:@"网络已经恢复，请刷新" Controller:ws];
            
        } else {
            NavgationbarView *nv = [[NavgationbarView alloc] init];
            [nv showLable:@"网络已断开，请重新连接" Controller:ws];
        }
    }];
}


#pragma mark - UI
- (void)setUI {
    [self.view addSubview:self.searchView];
    [self.view addSubview:self.topRemindView];
    [self creatNavigationbar];
    [self.view addSubview:self.mainTableView];
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(swipeGRClick:)];
    [self.view addGestureRecognizer:pan];
    self.view.backgroundColor = RGBCOLOR_I(240, 240, 240);
    // 下拉刷新
    kSelfWeak;
    [self.mainTableView addTopTarget:self andAction:@selector(headRefreshData) withView:nil];
    // 上拉加载
    [self.mainTableView addFooterWithCallback:^{
        [weakSelf loadCollocation];
    }];
    // 加载失败重新加载
    [self loadFailBtnBlock:^{
        kSelfStrong;
        strongSelf -> _page = 1;
        [strongSelf loadData];
    }];

}

/// 创建导航栏
- (void)creatNavigationbar {
    self.navigationController.navigationBar.hidden=YES;
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kStatusBarHeight)];
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
    //导航栏
    self.myNavigationView = [[UIImageView alloc]initWithFrame:CGRectMake(0, kStatusBarHeight, kScreenWidth, kNavigationBarHeight)];
    self.myNavigationView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:self.myNavigationView];
    self.myNavigationView.userInteractionEnabled=YES;
    //标题
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake((kApplicationWidth-100)*0.5, 0, 100, kNavigationBarHeight)];
    titleLabel.text = @"搭配";
    titleLabel.font = [UIFont systemFontOfSize:ZOOM(53)];
    titleLabel.textColor = RGBCOLOR_I(68, 68, 68);
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.myNavigationView addSubview:titleLabel];
    //搜索
    UIButton *searchBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    searchBtn.frame=CGRectMake(5, 0, kNavigationBarHeight*42/38, kNavigationBarHeight);
    [searchBtn setImage:[UIImage imageNamed:@"icon_search"] forState:UIControlStateNormal];
    [searchBtn addTarget:self action:@selector(searchClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.myNavigationView addSubview:searchBtn];
    //购物车
    UIButton *shopcartbtn=[UIButton buttonWithType:UIButtonTypeCustom];
    shopcartbtn.frame=CGRectMake(kScreenWidth - kNavigationBarHeight - 5, 0, kNavigationBarHeight, kNavigationBarHeight);
    [shopcartbtn addTarget:self action:@selector(shopcartClick:) forControlEvents:UIControlEventTouchUpInside];
    [shopcartbtn setImage:[UIImage imageNamed:@"icon_gouwuche_black"] forState:UIControlStateNormal];
    [self.myNavigationView addSubview:shopcartbtn];
    //购物车角标
    self.marklable=[[UILabel alloc]initWithFrame:CGRectMake(kNavigationBarHeight - 21, 5, 16, 16)];
    self.marklable.backgroundColor=tarbarrossred;
    self.marklable.hidden = YES;
    self.marklable.clipsToBounds=YES;
    self.marklable.layer.cornerRadius=8;
    self.marklable.textColor=[UIColor whiteColor];
    self.marklable.textAlignment=NSTextAlignmentCenter;
    self.marklable.font=[UIFont systemFontOfSize:10];
    [shopcartbtn addSubview:self.marklable];
}


#pragma mark - 加载数据
- (void)loadData {
    [MBProgressHUD showHUDAddTo:self.view animated:YES];
    //侧边搜索数据
    [self loadSearchData];
    //搭配购数据
    [self loadCollocation];
}

- (void)headRefreshData {
    _page = 1;
    [self loadCollocation];
}

/// 搭配数据
- (void)loadCollocation {
    [CollocationMainModel getCollocationMainModelWithPageSize:10 curPager:_page success:^(id data) {
        [self.mainTableView headerEndRefreshing];
        [self.mainTableView footerEndRefreshing];
        [self.mainTableView ffRefreshHeaderEndRefreshing];
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        CollocationMainModel *model = data;
        if (model.status == 1) {
            if (_page == 1) {
                [_mainData removeAllObjects];
            }
            //加载成功
            [_mainData addObjectsFromArray:model.listShop];
            if (_mainData.count <= 0) {
                //无数据
                [self loadingDataBackgroundView:self.mainTableView img:nil text:nil];
            } else {
                //有数据
                [self loadingDataSuccess];
            }
            //是否关闭上拉加载
            self.mainTableView.footerHidden = _mainData.count >= model.pager.rowCount;
            _page++;
            [self.mainTableView reloadData];
        } else {
            //加载失败
            [MBProgressHUD showError:model.message];
            if (_mainData.count == 0) {
                [self loadingDataBackgroundView:self.mainTableView img:[UIImage imageNamed:@"哭脸"] text:@"亲,没网了"];
                self.mainTableView.footerHidden = YES;
            }
        }
    }];
}

/// 购物车数量
- (void)loadShopCarCount {
    [ShopCarCountModel getShopCarCountWithSuccess:^(id data) {
        ShopCarCountModel *model = data;
        if (model.status == 1&&model.cart_count>0) {
            self.marklable.text = [NSString stringWithFormat:@"%ld",(long)model.cart_count];
            self.marklable.hidden = NO;
        } else {
            self.marklable.hidden = YES;
        }
    }];
}
#pragma mark - 1️⃣➢➢➢ 弹框

/// 强制更新
- (void)updateview {

    //网络获取当前版本
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;

    if (appDelegate.isUpdata == YES) {

        NSUserDefaults *userDef = [NSUserDefaults standardUserDefaults];
        BOOL isShow = [userDef boolForKey:UPDATE_SHOW];
        NSTimeInterval time = [NSDate date].timeIntervalSince1970 - [userDef doubleForKey:UPDATE_TIME];

        //是否勾选 不再提醒更新按钮
        if (isShow || time < 72*60*60) {
            

        }else{

            /// 强制更新
            NSString *version_no = [NSString stringWithFormat:@"%@更新了以下内容",appDelegate.version_no];
            NSString *msg = [NSString stringWithFormat:@"%@",appDelegate.msg];
            [UpdateView showType:appDelegate.isQiangGeng title:@"衣蝠发新版啦～" subtitle:version_no text:msg toView:self.view.window removeBlock:^{

            }];
        }

    } else{
        

    }

}

/// 红包满天飞
- (void)loadAddVoucher {
    NSString *token = [TFPublicClass getTokenFromLocal];
    if (token == nil) {
        [self redCadsDisplay:1];
        return;
    }
    __weak typeof(self) weakSelf = self;
    [AddVoucherModel getAddVoucherModelWithToken:token success:^(id data) {
        AddVoucherModel *model = data;
        if (model.status == 1) {
            NSInteger isRedCards = 0;
            if (model.num == 0)
                isRedCards = 1;
            else
                isRedCards = 2;
            [weakSelf redCadsDisplay:isRedCards];
        }
    }];
}

/// 侧边栏数据
- (void)loadSearchData {
    _searchTitleData = [NSMutableArray array];
    _searchCellData = [NSMutableArray array];
    SqliteManager *manager = [SqliteManager sharedManager];
    //大类
    NSArray *typeArray = [manager getShopTypeItemForSuperId:@"0"];
    for (ShopTypeItem *item in typeArray) {
        if (![item.type_name isEqualToString:@"特卖"]&&![item.type_name isEqualToString:@"热卖"] ) {
            [_searchTitleData addObject:item];
        }
    }
    //排序
    _searchTitleData = [[manager sortShopTypeArrayWithSequenceFromSourceArray:_searchTitleData] mutableCopy];
    //小类
    if (_searchTitleData.count!=0) {
        for (ShopTypeItem *item in _searchTitleData) {
            NSString *superID = item.ID;
            NSArray *array = [manager getShopTypeItemForSuperId:superID];
            [_searchCellData addObject:array];
        }
    }
    
    //刷新
    [_searchView reloadData];
}


#pragma mark - 红包漫天飞（弹框）
- (void)redCadsDisplay:(NSInteger)isRedCards {
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *oldDate = [ud objectForKey:RedCash];
    NSNumber *userID = [ud objectForKey:USER_ID];
    NSString *currTime = [MyMD5 getCurrTimeString:@"year-month-day"];
    NSString *currDate = [NSString stringWithFormat:@"%@%@", userID?:@"", currTime];
    /// 未登录，且弹过
    if (userID == nil && ([oldDate rangeOfString:currTime].location != NSNotFound) && oldDate != nil) {
        return;
    }
    
    /// 已登录，但弹窗是未登录时弹的
    if ([oldDate isEqualToString:currTime] && userID != nil) {
        [ud setObject:currDate forKey:RedCash];
        return;
    }
    
//    if (oldDate == nil || ![oldDate isEqualToString:currDate]) {
//        [ud setObject:currDate forKey:RedCash];
//        if (isRedCards == 1) {
//            [self popWTFAlertView:@[@"30", @"20", @"20", @"10"]];
//        } else if (isRedCards == 2) {
//            [self popWTFAlertView:@[@"15", @"10", @"5"]];
//        }
//    }
}

/// 弹出红包满天飞
- (void)popWTFAlertView:(NSArray *)titleArray {
     NSString *token = [TFPublicClass getTokenFromLocal];
    WTFAlertView *alert = [WTFAlertView GlodeBottomView];
    alert.titleArray = titleArray;
    kSelfWeak;
    alert.toLoginBlock = token != nil?nil:^{
        [weakSelf loginVerifySuccess:nil];
    };
//    [alert show];
}


#pragma mark - 余额翻倍倒计时
- (void)doubleTime {
    [NSDate systemCurrentTime:^(long long time) {
        _timeout = (NSInteger)([DataManager sharedManager].endDate/1000 - time/1000);
        if ([DataManager sharedManager].isOligible&&(_timeout > 0)) {
            _topRemindView.hidden = NO;
            
            if ([DataManager sharedManager].isOpen) {
                self.topRemindView.RemindBtn.selected = YES;
            } else {
                self.topRemindView.RemindBtn.selected = NO;
            }
            [self countdownTime];
            [UIView animateWithDuration:0.5 animations:^{
                _topRemindView.top = _myNavigationView.bottom;
                _mainTableView.top = _topRemindView.bottom;
                _mainTableView.height = self.view.height - _topRemindView.bottom -kTabBarHeight + kZoom6pt(10);
            }];
        } else {
            _topRemindView.hidden = YES;
            [self.topRemindView setRemindIsHidden:YES];
        }
    }];
 
}

/// 倒计时
- (void)countdownTime {
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(_timer, ^{
        if(_timeout<=0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                [DataManager sharedManager].isOligible = NO;
                [DataManager sharedManager].isOpen = NO;
                [UIView animateWithDuration:0.5 animations:^{
                    _topRemindView.top = _myNavigationView.bottom - 30;
                    _mainTableView.top = _topRemindView.bottom;
                    _mainTableView.height = self.view.height - _topRemindView.bottom -kTabBarHeight + kZoom6pt(10);
                } completion:^(BOOL finished) {
                    _topRemindView.hidden = YES;
                }];
            });
        } else {
            NSInteger hour = _timeout/60/60;
            NSInteger minute = (_timeout%(60*60))/60;
            NSInteger seconds = _timeout%60;
            NSString *strTime = [NSString stringWithFormat:@"距余额翻倍结束还剩: %02ld 时 %02ld 分 %02ld 秒", (long)hour, (long)(long)minute, (long)seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                self.topRemindView.RemindLabel.text = strTime;
            });
            _timeout--;
        }
    });
    dispatch_resume(_timer);
}

/// 开启余额翻倍
- (void)doubleSuccess {
    if(_topRemindView.RemindBtn.selected == NO)
    {
        [DoubleModel getDoubleEntrance:2 Sucess:^(id data) {
            DoubleModel *model = data;
            if(model.status == 1) {
                MyLog(@"开启成功");
                _topRemindView.RemindBtn.selected=YES;
                [DataManager sharedManager].isOpen = YES;
                YFDoubleSucessVC *vc = [[YFDoubleSucessVC alloc]init];
                vc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:vc animated:YES];
            } else {
                MyLog(@"开启失败");
                _topRemindView.RemindBtn.selected=NO;
                [DataManager sharedManager].isOpen = NO;
            }
        }];
    }
}

#pragma mark - 按钮点击
/// 购物车
- (void)shopcartClick:(UIButton *)sender {
    kSelfWeak;
    [self loginVerifySuccess:^{
//        WTFCartViewController *shoppingcart =[[WTFCartViewController alloc]init];
//        shoppingcart.segmentSelect = CartSegment_NormalType;
//        shoppingcart.CartType = Cart_NormalType;

        
        NewShoppingCartViewController *shoppingcart =[[NewShoppingCartViewController alloc]init];
        shoppingcart.ShopCart_Type = ShopCart_NormalType;
                shoppingcart.hidesBottomBarWhenPushed = YES;
        [weakSelf.navigationController pushViewController:shoppingcart animated:YES];
    }];
}

/// 搜索（弹出侧边栏）
- (void)searchClick:(UIButton *)sender {
    CGFloat time = (1 - CGRectGetMinX(_myNavigationView.frame)/(kScreenWidth*0.718))*0.3;
    [UIView animateWithDuration:time delay:0.0f options:UIViewAnimationOptionCurveEaseIn|UIViewAnimationOptionBeginFromCurrentState animations:^{
        _myNavigationView.frame = CGRectMake(floor(kScreenWidth*0.718), CGRectGetMinY(_myNavigationView.frame), CGRectGetWidth(_myNavigationView.frame),CGRectGetHeight(_myNavigationView.frame));
        _mainTableView.frame = CGRectMake(floor(kScreenWidth*0.718), CGRectGetMinY(_mainTableView.frame), CGRectGetWidth(_mainTableView.frame),CGRectGetHeight(_mainTableView.frame));
        Mtarbar.tabBar.frame = CGRectMake(floor(kScreenWidth*0.718), CGRectGetMinY(Mtarbar.tabBar.frame), CGRectGetWidth(Mtarbar.tabBar.frame),CGRectGetHeight(Mtarbar.tabBar.frame));
        _topRemindView.left = _topRemindView.left < kScreenWidth?floor(kScreenWidth*0.718):kScreenWidth;
        _myNavigationView.userInteractionEnabled = NO;
        _mainTableView.userInteractionEnabled = NO;
        Mtarbar.tabBar.userInteractionEnabled = NO;
    }completion:nil];
}


#pragma mark - 跳转商品详情
- (void)pushShopDetailShopCode:(NSString *)shopCode {
    NSLog(@"%@",shopCode);
    ShopDetailViewController *detail=[[ShopDetailViewController alloc] initWithNibName:@"ShopDetailViewController" bundle:nil];
    detail.shop_code = shopCode;
    detail.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:detail animated:YES];
    //刷新，避免indexPath错位
    [self.mainTableView reloadData];
}


#pragma mark - 手势
- (void)swipeGRClick:(UIPanGestureRecognizer *)sender {
    CGFloat x_transition = [sender translationInView:self.view].x;
    if (sender.state == UIGestureRecognizerStateBegan) {
        _firstX = _myNavigationView.frame.origin.x;
    } else if (sender.state == UIGestureRecognizerStateChanged) {
        CGFloat search_x = floor(_firstX + x_transition);
        if ((search_x >= 0)&&(search_x <= floor(kScreenWidth*0.718))) {
            _myNavigationView.frame = CGRectMake(search_x, CGRectGetMinY(_myNavigationView.frame), CGRectGetWidth(_myNavigationView.frame),CGRectGetHeight(_myNavigationView.frame));
            _mainTableView.frame = CGRectMake(search_x, CGRectGetMinY(_mainTableView.frame), CGRectGetWidth(_mainTableView.frame),CGRectGetHeight(_mainTableView.frame));
            Mtarbar.tabBar.frame = CGRectMake(search_x, CGRectGetMinY(Mtarbar.tabBar.frame), CGRectGetWidth(Mtarbar.tabBar.frame),CGRectGetHeight(Mtarbar.tabBar.frame));
            _topRemindView.left = _topRemindView.left < kScreenWidth?search_x:kScreenWidth;
        }
    } else if (sender.state == UIGestureRecognizerStateEnded) {
        if (CGRectGetMinX(_myNavigationView.frame) < floor(kScreenWidth*0.718/2)) {
            [self searchViewDirectionLeft];
        } else {
            [self searchClick:nil];
        }
    }
}


#pragma mark - UITabeViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _mainData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellName = @"YFDPCell";
    YFDPCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    if (nil == cell) {
        cell = [[YFDPCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
    }
    __weak typeof(self) weakSelf = self;
    [cell setShopCodeBlock:^(NSString *shopCode) {
        [weakSelf pushShopDetailShopCode:shopCode];
    }];
    CollocationModel *model = _mainData[indexPath.row];
    [cell receiveDataModel:model ISCollocation:YES];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CollocationModel *model = _mainData[indexPath.row];
    if ([model.type intValue] == 2) {
        return [YFDPCell cellForTopicsHeight];
    } else {
        return [YFDPCell cellHeight];
    }
}

#pragma mark - UITabeViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    CollocationModel *model = _mainData[indexPath.row];
    NSString *shopCodes = nil;
    for (CollocationShopModel *csModel in model.collocation_shop) {
        shopCodes = shopCodes?[NSString stringWithFormat:@"%@,%@",shopCodes,csModel.shop_code]:csModel.shop_code;
    }
        
    CollocationDetailViewController *collcationVC =[[CollocationDetailViewController alloc]init];
    collcationVC.collocationCode = model.collocation_code;
    collcationVC.shopCodes = shopCodes;
    collcationVC.hidesBottomBarWhenPushed= YES;
    collcationVC.collcationModel = model;
    [self.navigationController pushViewController:collcationVC animated:YES];
}


#pragma mark - YFSearchViewDelegate
- (NSInteger)numberOfSectionsInSearchView:(YFSearchView *)searchView {
    return _searchTitleData.count;
}

- (NSInteger)searchView:(YFSearchView *)searchView numberOfRowsInSection:(NSInteger)section {
    return ((NSArray *)_searchCellData[section]).count;
}

- (NSString *)searchView:(YFSearchView *)searchView titleForHeaderInSection:(NSInteger)section {
    ShopTypeItem *item = _searchTitleData[section];
    return item.type_name;
}

- (ShopTypeItem *)searchView:(YFSearchView *)searchView itemForRowAtIndexPath:(NSIndexPath *)indexPath {
    ShopTypeItem *itme = _searchCellData[indexPath.section][indexPath.row];
    return itme;
}

/// 搜索
- (void)searchViewSearchString:(NSString *)string {
    [self searchViewDirectionLeft];
    TFScreenViewController *svc = [[TFScreenViewController alloc] init];
    svc.index = 0;
    svc.muStr = string;
    svc.titleText = string;
    svc.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:svc animated:YES];
}

/// 侧边栏目录点击
- (void)searchView:(YFSearchView *)searchView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
   [self searchViewDirectionLeft];
    ShopTypeItem *itme = _searchCellData[indexPath.section][indexPath.row];
    NSString *ID = itme.ID;
    NSString *title = itme.type_name;
    TFSearchViewController *svc = [[TFSearchViewController alloc] init];
    svc.parentID = ID;
    svc.shopTitle = title;
    svc.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:svc animated:YES];
}

/// 向左滑动收起侧边栏
- (void)searchViewDirectionLeft {
    [_searchView endEditing:YES];
    CGFloat time = CGRectGetMinX(_myNavigationView.frame)/(kScreenWidth*0.718)*0.2;
    [UIView animateWithDuration:time delay:0.0f options:UIViewAnimationOptionCurveEaseIn|UIViewAnimationOptionBeginFromCurrentState animations:^{
        _myNavigationView.frame = CGRectMake(0, CGRectGetMinY(_myNavigationView.frame), CGRectGetWidth(_myNavigationView.frame),CGRectGetHeight(_myNavigationView.frame));
        _mainTableView.frame = CGRectMake(0, CGRectGetMinY(_mainTableView.frame), CGRectGetWidth(_mainTableView.frame),CGRectGetHeight(_mainTableView.frame));
        Mtarbar.tabBar.frame = CGRectMake(0, CGRectGetMinY(Mtarbar.tabBar.frame), CGRectGetWidth(Mtarbar.tabBar.frame),CGRectGetHeight(Mtarbar.tabBar.frame));
        _topRemindView.left = _topRemindView.left < kScreenWidth?0:kScreenWidth;
        _myNavigationView.userInteractionEnabled = YES;
        _mainTableView.userInteractionEnabled = YES;
        Mtarbar.tabBar.userInteractionEnabled = YES;
    }completion:nil];

}


#pragma mark - getter
- (UITableView *)mainTableView {
    if (nil == _mainTableView) {
        CGRect frame = self.view.bounds;
        frame.size = CGSizeMake(frame.size.width, frame.size.height - kNavigationBarHeight - kStatusBarHeight -kTabBarHeight + kZoom6pt(10));
        frame.origin = CGPointMake(0, 64);
        _mainTableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
        _mainTableView.dataSource = self;
        _mainTableView.delegate = self;
        _mainTableView.tableFooterView = [UIView new];
        _mainTableView.backgroundColor = RGBCOLOR_I(240, 240, 240);
        _mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _mainTableView.showsVerticalScrollIndicator = NO;
        _mainTableView.backgroundView = [[UIView alloc] init];
//        _mainTableView.rowHeight = [YFDPCell cellHeight];
    }
    return _mainTableView;
}

- (YFSearchView *)searchView {
    if (nil == _searchView) {
        _searchView = [[YFSearchView alloc] initWithFrame:CGRectMake(0, kStatusBarHeight, floor(kScreenWidth*0.718+2),kScreenHeight - kStatusBarHeight)];
        _searchView.delegate = self;
    }
    return _searchView;
}

- (TopRemindView *)topRemindView {
    if (nil == _topRemindView) {
        _topRemindView = [[TopRemindView alloc]initWithFrame:CGRectMake(0, kNavigationheightForIOS7 - 30, kScreenWidth, 30)];
        _topRemindView.backgroundColor = [UIColor colorWithWhite:0.3 alpha:1];
        _topRemindView.hidden = YES;
        kSelfWeak;
        _topRemindView.RemindBtnBlock = ^{
            [weakSelf doubleSuccess];
        };
    }
    return _topRemindView;
}


#pragma mark - touch
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self searchViewDirectionLeft];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
