//
//  TFCollocationViewController.m
//  YunShangShiJi
//
//  Created by jingaiweiyi on 16/7/28.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import "TFCollocationViewController.h"
#import "GlobalTool.h"
#import "NSDate+Helper.h"
#import "AppDelegate.h"
#import "UIScrollView+MyRefresh.h"

#import "YFDPCell.h"
#import "TFLoginView.h"
#import "WTFAlertView.h"
#import "YFSearchView.h"
#import "TopRemindView.h"

#import "LoginViewController.h"
#import "TFSearchViewController.h"

#import "ShopDetailViewController.h"
#import "CollocationDetailViewController.h"
#import "YFDoubleSucessVC.h"

#import "CollocationMainModel.h"
#import "ShopCarCountModel.h"
#import "AddVoucherModel.h"
#import "DoubleModel.h"
#import "TFPopBackgroundView.h"
#import "SpecialDetailViewController.h"
#import "SearchTypeViewController.h"
@interface TFCollocationViewController () <UITableViewDataSource, UITableViewDelegate>
{
    NSMutableArray *_mainData;          //列表数据
    
    struct {
        unsigned int collocationViewPullDownRefreshWithIndex: 1; 
        unsigned int collocationViewWithScrollViewWillBeginDragging : 1;
        unsigned int collocationViewWithScrollViewDidEndDragging : 1;
        unsigned int collocationViewWithScrollViewWillBeginDecelerating : 1;
        unsigned int collocationViewWithscrollViewDidEndDecelerating : 1;
    }_delegateFlags;
    
    int currIndex;
}
@end

@implementation TFCollocationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    self.view.backgroundColor = [UIColor yellowColor];
    [super viewDidLoad];
    
    [self setData];
    
    [self setupUI];
}

- (void)viewDidAppear:(BOOL)animated
{
    if([self.typeName isEqualToString:@"专题"])
    {
        [TFStatisticsClickVM StatisticshandleDataWithClickType:@"到达专题列表页" success:nil failure:nil];
    }else{
        [TFStatisticsClickVM StatisticshandleDataWithClickType:@"到达搭配列表页" success:nil failure:nil];
    }

}

- (void)viewDidDisappear:(BOOL)animated
{
    if([self.typeName isEqualToString:@"专题"])
    {
        [TFStatisticsClickVM StatisticshandleDataWithClickType:@"跳出专题列表页" success:nil failure:nil];
    }else{
        [TFStatisticsClickVM StatisticshandleDataWithClickType:@"跳出搭配列表页" success:nil failure:nil];
    }

}
- (void)leftBarButtonClick
{
    if([[NSUserDefaults standardUserDefaults]boolForKey:@"is_read"] == YES && self.isFinish == NO)
    {
        TFPopBackgroundView *popView = [[TFPopBackgroundView alloc] init];
        popView.title = @"亲~确定要离开吗？";
        popView.message = @"你正在进行浏览商品任务，浏览时长还未完成，你可以选择去浏览其它商品，浏览时长达到任务要求即可完成任务喔~";
        popView.leftText = @"不了,谢谢";
        popView.rightText = @"其他商品";
        
        [popView showCancelBlock:^{
            [self.navigationController popViewControllerAnimated:YES];
        } withConfirmBlock:^{
            [Mtarbar selectedToIndexViewController:0];
        } withNoOperationBlock:^{
            
        }];
    }else{
//        [[NSUserDefaults standardUserDefaults]setBool:NO forKey:@"is_read"];
        
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)gotoShop
{
    SearchTypeViewController *searchShopping = [[SearchTypeViewController alloc]init];
    searchShopping.is_pushCome = YES;
    searchShopping.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:searchShopping animated:YES];

}
- (void)setData
{
    _page = 1;
    _mainData = [NSMutableArray array];
 
    UIScrollView *superScrollView = (UIScrollView *)self.mainTableView.superview;
    int index = 0;
    if ([superScrollView isKindOfClass:[UIScrollView class]]) {
        index = superScrollView.contentOffset.x / kScreenWidth;
    }
    currIndex = index;
    //加载缓存数据
    [self getDataFromDBWithClass:[CollocationModel class] dataArray:_mainData];
    [self getData];
}

- (void)setupUI
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    if (self.pushType == PushTypeSign) {
//        self.typeName = @"搭配";
        [self setNavigationItemLeft:self.typeName];
    }
    // 下拉刷新
    kSelfWeak;
    [self.mainTableView addTopTarget:self andAction:@selector(headRefreshData) withView:nil];
    
    // 上拉加载
    [self.mainTableView addFooterWithCallback:^{
        [weakSelf loadCollocation];
    }];

}

#pragma mark - 数据缓存
// 加入数据库
- (void)saveDataToDBWithTypeKeyWord:(Class)class dataArray:(NSMutableArray *)dataArray {
    NSArray *copyedDataArray = [dataArray copy];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0) , ^{
        @synchronized(self) {
            //清除表中相关数据
            [class deleteWithWhere:nil];
            //保存
            for (id model in copyedDataArray) {
                [model saveToDB];
            }
        }
    });
}

// 取出数据
- (BOOL)getDataFromDBWithClass:(Class)class dataArray:(NSMutableArray *)dataArray {
    /* 加载失败，并且之前就没有获取到数据，检测本地数据 */
    if (dataArray.count <= 0) {
        NSArray *sModels = [class searchWithWhere:nil orderBy:0 offset:0 count:0];
        if (sModels.count > 0) {
            [dataArray addObjectsFromArray:sModels];
            return YES;
        }
    }
    return NO;
}

#pragma mark - 加载数据
- (void)getData {
    [MBProgressHUD showHUDAddTo:self.view animated:YES];
    //侧边搜索数据
//    [self loadSearchData];
    //搭配购数据
    [self loadCollocation];
}

- (void)headRefreshData {
    
    _page = 1;
    [self loadCollocation];
    
    if (_delegateFlags.collocationViewPullDownRefreshWithIndex) {
        [self.customDelegate collocationViewPullDownRefreshWithIndex:currIndex];
    }
}

/// 搭配数据
- (void)loadCollocation {
    
    if (self.typeID == nil) {
        self.typeID = @1;
    }
    [CollocationMainModel getCollocationMainModelWithType:self.typeID PageSize:10 curPager:_page success:^(id data) {
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
                //缓存
                if (_page == 1) {
                    [self saveDataToDBWithTypeKeyWord:[CollocationModel class] dataArray:_mainData];
                }
            }
//            //是否关闭上拉加载
//            self.mainTableView.footerHidden = _mainData.count >= model.pager.rowCount;
            
            if (self.pushType == PushTypeSign && _mainData.count >= model.pager.rowCount && _page>1 && model.listShop.count == 0) {
                NavgationbarView *nv = [[NavgationbarView alloc] init];
                [nv showLable:@"没有更多商品了哦~" Controller:self];
            }
            
            _page++;
            [self.mainTableView reloadData];
        } else {
            if (_mainData.count == 0) {
                self.mainTableView.footerHidden = YES;
            }
        }
    }];
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
    [cell receiveDataModel:model ISCollocation:[self.typeName isEqualToString:@"专题"]?NO:YES];
    
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
    
    [TFStatisticsClickVM handleDataWithPageType:nil withClickType:@"首页搭配主图" success:^(id data, Response *response) {
    } failure:^(NSError *error) {
    }];
    
    CollocationModel *model = _mainData[indexPath.row];
    NSString *shopCodes = nil;
    for (CollocationShopModel *csModel in model.collocation_shop) {
        shopCodes = shopCodes?[NSString stringWithFormat:@"%@,%@",shopCodes,csModel.shop_code]:csModel.shop_code;
    }
    
    if([model.type intValue] == 2)
    {
        SpecialDetailViewController *special = [[SpecialDetailViewController alloc]init];
        special.hidesBottomBarWhenPushed = YES;
        special.collocationCode = model.collocation_code;
        special.collcationModel = model;
        [self.navigationController pushViewController:special animated:YES];
        
    }else{
        
        CollocationDetailViewController *collcationVC =[[CollocationDetailViewController alloc]init];
        collcationVC.collocationCode = model.collocation_code;
        collcationVC.shopCodes = shopCodes;
        collcationVC.hidesBottomBarWhenPushed= YES;
        collcationVC.collcationModel = model;
        
        [self.navigationController pushViewController:collcationVC animated:YES];
    }
    
}

#pragma mark - 跳转商品详情
- (void)pushShopDetailShopCode:(NSString *)shopCode {
    NSLog(@"%@",shopCode);
    ShopDetailViewController *detail=[[ShopDetailViewController alloc] initWithNibName:@"ShopDetailViewController" bundle:nil];
    detail.shop_code = shopCode;
    detail.stringtype = @"浏览商品";
    detail.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:detail animated:YES];
    //刷新，避免indexPath错位
//    [self.mainTableView reloadData];
}

- (UITableView *)mainTableView
{
    if (!_mainTableView) {
        
        CGRect rect = CGRectZero;
        CGFloat H_head = 0;
        if (self.pushType == PushTypeHome) {
            rect = CGRectMake(0, 0, kScreen_Width, kScreen_Height);
            H_head = self.headHeight;
        } else if (self.pushType == PushTypeSign) {
            rect = CGRectMake(0, Height_NavBar, kScreen_Width, kScreen_Height - Height_NavBar);
            H_head = 0;
        }
        _mainTableView = [[UITableView alloc] initWithFrame:rect];
        _mainTableView.dataSource = self;
        _mainTableView.delegate = self;
        _mainTableView.tableFooterView = [UIView new];
        _mainTableView.backgroundColor = RGBCOLOR_I(240, 240, 240);
        
        //***   解决iOS11刷新tableview会出现漂移的现象
        _mainTableView.estimatedRowHeight = 0;
        _mainTableView.estimatedSectionHeaderHeight = 0;
        _mainTableView.estimatedSectionFooterHeight = 0;
        
        _mainTableView.topLoadHeight = [NSNumber numberWithFloat:H_head];
        _mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _mainTableView.showsVerticalScrollIndicator = NO;
        _mainTableView.backgroundView = [[UIView alloc] init];
//        _mainTableView.rowHeight = [YFDPCell cellHeight];
        [self.view addSubview:_mainTableView];
        
    }
    return _mainTableView;
}

- (void)dealloc
{
    if (self.netStatusBlock) {
        [[NSNotificationCenter defaultCenter] removeObserver:self name:netStatusNotificationCenter object:nil];
    }
    
    if (self.mainTableView.topShowView) {
        [self.mainTableView removeObserver:self.mainTableView forKeyPath:observerRefreshHeaderViewKeyPath context:nil];
        self.mainTableView = nil;
    }
}

#pragma mark - delegate
- (void)setCustomDelegate:(id<collocationViewCustomDelegate>)customDelegate
{
    _customDelegate = customDelegate;
    _delegateFlags.collocationViewPullDownRefreshWithIndex = [customDelegate respondsToSelector:@selector(collocationViewPullDownRefreshWithIndex:)];
    _delegateFlags.collocationViewWithScrollViewWillBeginDragging = [customDelegate respondsToSelector:@selector(collocationViewWithScrollViewWillBeginDragging:index:)];
    _delegateFlags.collocationViewWithScrollViewDidEndDragging = [customDelegate respondsToSelector:@selector(collocationViewWithScrollViewDidEndDragging:willDecelerate:index:)];
    _delegateFlags.collocationViewWithScrollViewWillBeginDecelerating = [customDelegate respondsToSelector:@selector(collocationViewWithScrollViewWillBeginDecelerating:index:)];
    _delegateFlags.collocationViewWithscrollViewDidEndDecelerating = [customDelegate respondsToSelector:@selector(collocationViewWithscrollViewDidEndDecelerating:index:)];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if (_delegateFlags.collocationViewWithScrollViewWillBeginDragging) {
        [self.customDelegate collocationViewWithScrollViewWillBeginDragging:scrollView index:currIndex];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (_delegateFlags.collocationViewWithScrollViewDidEndDragging) {
        [self.customDelegate collocationViewWithScrollViewDidEndDragging:scrollView willDecelerate:decelerate index:currIndex];
    }
    if (decelerate == NO) {
        [self scrollViewDidEndDecelerating:scrollView];
    } else{

    }

}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
    if (_delegateFlags.collocationViewWithScrollViewWillBeginDecelerating) {
        [self.customDelegate collocationViewWithScrollViewWillBeginDecelerating:scrollView index:currIndex];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (_delegateFlags.collocationViewWithscrollViewDidEndDecelerating) {
        [self.customDelegate collocationViewWithscrollViewDidEndDecelerating:scrollView index:currIndex];
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
