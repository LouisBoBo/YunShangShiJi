//
//  TFShopStoreViewController.m
//  YunShangShiJi
//
//  Created by jingaiweiyi on 16/6/16.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import "TFShopStoreViewController.h"
#import "SqliteManager.h"
#import "TFNoviceTaskView.h"
#import "TFDailyTaskView.h"
#import "TFScreeningBackgroundView.h"
#import "DShareManager.h"
#import "CollectionViewController.h"
#import "ScrollView_public.h"
#import "TYSlidePageScrollView.h"
#import "AppDelegate.h"
#import "TFLoginView.h"
#import "H5activityViewController.h"
#import "InvitCodeViewController.h"
#import "LoginViewController.h"
#import "TFFeedBackViewController.h"
#import "TFTopShopsVM.h"
#import "TFCollocationViewController.h"
#import "AddVoucherModel.h"
#import "IndianaPublicModel.h"
#import "OneYuanModel.h"
#import "WTFAlertView.h"
#import "TFNoviceTaskView.h"
#import "UpdateView.h"
#import "VitalityTaskPopview.h"
#import "YFAlertView.h"
#import "FreeOrderPopview.h"
#import "TopicPublicModel.h"
#import "VitalityTaskPopview.h"
#import "TypeShareModel.h"
#import "NewProductViewController.h"
#import "BrandMakerDetailVC.h"
#import "MakeMoneyViewController.h"
#import "CrazyStyleViewController.h"
#import "CrazyMondayActivityVC.h"
#import "MyOrderViewController.h"
#import "TFMyWalletViewController.h"
#import "ShouYeShopStoreViewController.h"
#import "MemberRawardsViewController.h"
#import "TFAccountDetailsViewController.h"
#import "HBmemberViewController.h"
#import "AddMemberCardViewController.h"
#import "RedXuanfuHongBao.h"
#import "TixianRedHongbao.h"
#import "ProduceImage.h"
#import "hongBaoModel.h"
@interface TFShopStoreViewController () <TYSlidePageScrollViewDataSource, TYSlidePageScrollViewDelegate,UIAlertViewDelegate,UIScrollViewDelegate, collectionViewCustomDelegate, collocationViewCustomDelegate, DShareManagerDelegate,MiniShareManagerDelegate>
{
    CGFloat _oldPointY;
    
    struct {
        unsigned int titlePageToIndex: 1; //位域: 1”的意思是这个成员的大小占所定义类型的1 bit
        unsigned int storePageViewScrollSetTabBarStatus : 1;
        unsigned int storePageViewScrollViewDidScroll : 1;
        unsigned int storeTitleTopStatus : 1;
    }_delegateFlags;
    
    // 新手任务5
    NSInteger _noviceTimerCount_5;
    NSTimer *_noviceTimer_5;
    
    // 去吐槽
    NSInteger _noviceTimerCount_11;
    NSTimer *_noviceTimer_11;
}

/**
 *  视图
 */
@property (nonatomic, weak  ) TYSlidePageScrollView *slidePageScrollView;
@property (nonatomic ,strong) UIView                *nheadView;
@property (nonatomic, strong ) UIScrollView              *hotScrollView;

@property (nonatomic, strong) UICollectionView *hotCollectionView;

@property (nonatomic, strong ) ScrollView_public         *myBigScrollView;
@property (nonatomic, strong) CustomTitleView       *nTitleView;;
@property (nonatomic, strong ) UIImage                   *shareRandShopImage;
@property (nonatomic, strong ) UIImage                   *shareAppImg;
@property (nonatomic, strong ) TFNoviceTaskView          *noviceTaskView;
@property (nonatomic, strong ) TFDailyTaskView           *dailyTsakView;
@property (nonatomic, strong) TFTopShopsVM *topShopsVM;
/**
 *  变量
 */
@property (nonatomic, assign ) CGFloat                   headHeight;
@property (nonatomic, assign ) CGFloat                   topImageHeight;
@property (nonatomic, assign ) CGFloat                   hotImageHeight;
@property (nonatomic, assign ) CGFloat                   lineHeight;

@property (nonatomic, strong) NSMutableArray *titleArry;
@property (nonatomic, strong) NSMutableArray *typeIndexArray;

@property (nonatomic, strong) NSMutableArray *shopTypeIDArray;
@property (nonatomic, strong) NSMutableArray *shopTypeNameArray;
@property (nonatomic, strong) NSMutableArray *shopTypeIconArray;

@property (nonatomic, strong) NSMutableArray *topShopsArray;

@property (nonatomic, assign)TYPageTabBarState pageTabBarState;
@property (nonatomic, assign) BOOL isViewDidLoad;
@property (nonatomic, strong) RedXuanfuHongBao *hongbaoview;
@property (nonatomic, assign) BOOL isOnLoad;
@property (nonatomic, assign) BOOL isFightPop;
@property (nonatomic, assign) double ElastTime;
@property (nonatomic, strong ) NSTimer *mytimer;
@property (nonatomic, assign) BOOL isFirstComming;
@property (nonatomic, strong) TixianRedHongbao * redhongbaoview;
@end

@implementation TFShopStoreViewController

- (void)dealloc
{
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:YFLaunchViewDisappear object:nil];
    if (self.netStatusBlock) {
        [[NSNotificationCenter defaultCenter] removeObserver:self name:netStatusNotificationCenter object:nil];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [MobClick beginLogPageView:@"GouwuPage"];
    
    [self pageTabBarState:self.pageTabBarState];
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    /// 弹窗 去赚钱页面
    if ([DataManager sharedManager].isLaunch == NO) {
        [self updateview];
    }

    if (self.isViewDidLoad) {
        [self getData];
        self.isViewDidLoad = NO;
    }
    
    if([self.shopTypeName isEqualToString:@"专题"])
    {
        [TFStatisticsClickVM StatisticshandleDataWithClickType:@"到达专题列表页" success:nil failure:nil];
    }else{
        [TFStatisticsClickVM StatisticshandleDataWithClickType:@"到达搭配列表页" success:nil failure:nil];
    }
    
    [self xuanfuHongBaoView];
    
    NSUserDefaults *userdefaul = [NSUserDefaults standardUserDefaults];
    NSString *token = [userdefaul objectForKey:USER_TOKEN];
    if(self.isFirstComming && (token == nil || [token isEqual:[NSNull null]]))
    {
        [self RedhongBao];
    }
    self.isFirstComming = true;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [_noviceTimer_5 invalidate];
    [_noviceTimer_11 invalidate];
    
}
- (void)viewDidDisappear:(BOOL)animated
{
    if([self.shopTypeName isEqualToString:@"专题"])
    {
        [TFStatisticsClickVM StatisticshandleDataWithClickType:@"跳出专题列表页" success:nil failure:nil];
    }else{
        [TFStatisticsClickVM StatisticshandleDataWithClickType:@"跳出搭配列表页" success:nil failure:nil];
    }
    
    [self.mytimer invalidate];
    [self.redhongbaoview remindViewDisapper];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.isViewDidLoad = YES;
    self.isOnLoad = YES;
    self.shopTypeName = @"专题";
    
    [self setData];
    [self setupUI];
    
    [MBProgressHUD showHUDAddTo:self.view animated:YES];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateview) name:YFLaunchViewDisappear object:nil];
    
}

- (void)getData
{
    [self buildShopTypeData];
    
    [MBProgressHUD hideHUDForView:self.view];
}

- (void)setData
{
    self.topImageHeight = kScreenWidth * 0.5546;
    self.hotImageHeight = kZoom6pt(90)+20;
    self.titleHeight = ZOOM6(80);
    self.lineHeight = 0;
    self.currPageViewController = 0;
    if (kDevice_Is_iPhone6Plus) {
        self.hotImageHeight = kZoom6pt(102)+20;
    }
    self.hotImageHeight = 0;
    _noviceTimerCount_5 = 5;
    _noviceTimerCount_11 = 60;
}

- (void)buildShopTypeData
{
    SqliteManager *manager = [SqliteManager sharedManager];
    NSArray *shopTypeArray = [manager getShopTypeItemForSuperId:@"0"];
//    NSMutableArray *shopTypeMuArray = [NSMutableArray arrayWithArray:shopTypeArray];
    
    NSMutableArray *shopTypeMuArray = [NSMutableArray array];
    
    
    ShopTypeItem* shopTypeItem = [[ShopTypeItem alloc] init];
    shopTypeItem.ID = @"1";
    shopTypeItem.type_name  = @"猜你喜欢";
    shopTypeItem.ico = @"shop/type/qunzi.png,shop/type/qunzi1.png";
    shopTypeItem.is_show = @"1";
    shopTypeItem.group_flag = @"";
    shopTypeItem.sequence = @"0";
    [shopTypeMuArray addObject:shopTypeItem];
    
//    ShopTypeItem* shopTypeItem2 = [[ShopTypeItem alloc] init];
//    shopTypeItem2.ID = @"2";
//    shopTypeItem2.type_name  = @"搭配";
//    shopTypeItem2.ico = @"shop/type/qunzi.png,shop/type/qunzi1.png";
//    shopTypeItem2.is_show = @"1";
//    shopTypeItem2.group_flag = @"";
//    shopTypeItem2.sequence = @"1";
//    [shopTypeMuArray addObject:shopTypeItem2];
    

    if (shopTypeMuArray.count) {
        NSArray *sortArray = [manager sortShopTypeArrayWithSequenceFromSourceArray:shopTypeMuArray];
        
        [self buildTypeIndexArray:sortArray firstArray:@[@"专题", @"精选", @"上新", @"热卖"]];
        
        [self addCollectionViewWithPageScrollView];
        
        [self.nTitleView refreshTitleViewUI:self.shopTypeNameArray withImgNames:self.shopTypeIconArray];
    }
    [_slidePageScrollView reloadData];
    
    [self httpGetTopShopsAndCentShops:YES];
}

- (void)addCollectionViewWithPageScrollView
{
    for (int i = 0; i<self.shopTypeIDArray.count; i++) {
        [self addCollectionViewWithPage:i withTypeName:self.shopTypeNameArray[i] withtTypeID:self.shopTypeIDArray[i]];
    }
}
/**
 *  构建商品类型数组
 *
 *  @param array 排序后数组
 */
- (void)buildTypeIndexArray:(NSArray *)array firstArray:(NSArray *)firstArray
{
     __block int i = 0;
    [firstArray enumerateObjectsUsingBlock:^(NSString *obj, NSUInteger firstIdx, BOOL * _Nonnull stop) {
        [array enumerateObjectsUsingBlock:^(ShopTypeItem *item, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([item.type_name isEqualToString:obj] && [item.is_show intValue] == 1) {
                [self addshopInfoItem:item withIndex:i];
                i++;
            }
        }];
    }];
    
    [array enumerateObjectsUsingBlock:^(ShopTypeItem *item, NSUInteger idx, BOOL * _Nonnull stop) {
        if (![firstArray containsObject:item.type_name] && [item.is_show intValue] == 1) {
            [self addshopInfoItem:item withIndex:i];
            i++;
        }
    }];
    
    if (_delegateFlags.titlePageToIndex) {
        [self.shopStoreDelegate titlePageToIndex:0 withTitleShopType:self.typeIndexArray.firstObject];
    }
}

- (void)addshopInfoItem:(ShopTypeItem *)item withIndex:(int)index {
    NSMutableDictionary *shopTypeDic = [NSMutableDictionary dictionary];
    [shopTypeDic setValue:item.ID forKey:@"id"];
    [shopTypeDic setValue:item.type_name forKey:@"name"];
    [shopTypeDic setValue:[NSNumber numberWithInt:index] forKey:@"index"];
    [self.shopTypeIDArray addObject:item.ID];
    [self.shopTypeNameArray addObject:item.type_name];
    [self.shopTypeIconArray addObject:item.ico];
    [self.typeIndexArray addObject:shopTypeDic];
}

- (void)setupUI
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = RGBCOLOR_I(240, 240, 240);
    
    [self addSlidePageScrollView];
    [self addHeaderView];
    [self addFooterView];
    [self addTabPageMenu];
    
    [self netStatusBlock:^(NetworkStates networkState) {
        
        if (networkState != NetworkStatesNone) {
            [self httpGetTopShopsAndCentShops:YES];
        }
        
    }];

}

- (void)addSlidePageScrollView
{
    CGFloat viewHeigh = kScreen_Height- Height_TabBar;
    CGRect frame = CGRectMake(0, 0, CGRectGetWidth(self.view.frame), viewHeigh);
    TYSlidePageScrollView *slidePageScrollView = [[TYSlidePageScrollView alloc] initWithFrame:frame];
    slidePageScrollView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    slidePageScrollView.pageTabBarIsStopOnTop = YES;
    slidePageScrollView.tyDataSource = self;
    slidePageScrollView.tyDelegate = self;
    slidePageScrollView.backgroundColor = RGBCOLOR_I(240, 240, 240);
    slidePageScrollView.pageTabBarStopOnTopHeight = Height_NavBar;
    [self.view addSubview:slidePageScrollView];
    
    _slidePageScrollView = slidePageScrollView;
}

- (void)addHeaderView
{
    self.nheadView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(_slidePageScrollView.frame), self.topImageHeight+self.hotImageHeight+self.lineHeight)];

//    [self.nheadView addSubview:self.hotCollectionView];
    _slidePageScrollView.headerView = _isHeadView?self.nheadView:nil;
    
}

- (void)addTabPageMenu
{
    CGRect frame = CGRectMake(0, 0, CGRectGetWidth(_slidePageScrollView.frame), self.titleHeight);
    
    self.nTitleView = [CustomTitleView scrollWithFrame:frame withTag:0 withIndex:0 withButtonNames:self.shopTypeNameArray withImage:self.shopTypeIconArray];
    self.nTitleView.backColor = [UIColor whiteColor];
    self.nTitleView.isShopping = YES;
    int page = (int)[_slidePageScrollView curPageIndex];
    self.nTitleView.index = page;
    _slidePageScrollView.pageTabBar = self.nTitleView;
}

- (void)addFooterView
{
    CGRect frame = CGRectMake(0, 0, CGRectGetWidth(_slidePageScrollView.frame), 0);
    
    UIView *footerView = [[UIView alloc]initWithFrame:frame];
    footerView.backgroundColor = [UIColor yellowColor];
    _slidePageScrollView.footerView = _isFootView?footerView:nil;;
}

- (void)addCollectionViewWithPage:(NSInteger)page withTypeName:(NSString *)typeName withtTypeID:(NSNumber *)typeID
{
    
//    if ([typeName isEqualToString:@"专题"] || [typeName isEqualToString:@"精选"])
    if ([typeName isEqualToString:@"专题"])
    {
        TFCollocationViewController *subVC = [[TFCollocationViewController alloc] init];
        subVC.page = page;
        subVC.typeName = typeName;
        subVC.typeID = typeID;
        
        subVC.headHeight = self.topImageHeight+self.hotImageHeight+self.lineHeight+self.titleHeight;
        [self addChildViewController:subVC];

    }else if ([typeName isEqualToString:@"猜你喜欢"])
    {
        CollectionViewController *subVC = [[CollectionViewController alloc] init];
        subVC.page = page;
        subVC.typeName = @"热卖";
        subVC.typeID = [NSNumber numberWithInteger:6];
        subVC.fromType = @"购物";
        subVC.headHeight = self.topImageHeight+self.hotImageHeight+self.lineHeight+self.titleHeight;
        
        [self addChildViewController:subVC];
    }else if ([typeName isEqualToString:@"搭配"])
    {
        CollectionViewController *subVC = [[CollectionViewController alloc] init];
        subVC.page = page;
        subVC.typeName = typeName;
        subVC.typeID = typeID;
        subVC.fromType = @"生活";
        subVC.headHeight = self.topImageHeight+self.hotImageHeight+self.lineHeight+self.titleHeight;
        [self addChildViewController:subVC];
    }
    else {
        CollectionViewController *subVC = [[CollectionViewController alloc] init];
        subVC.page = page;
        subVC.typeName = typeName;
        subVC.typeID = typeID;
        subVC.fromType = @"购物";
        subVC.headHeight = self.topImageHeight+self.hotImageHeight+self.lineHeight+self.titleHeight;
        [self addChildViewController:subVC];

    }
    
}


- (NSInteger)numberOfPageViewOnSlidePageScrollView
{
    return self.childViewControllers.count;
}

- (UIScrollView *)slidePageScrollView:(TYSlidePageScrollView *)slidePageScrollView pageVerticalScrollViewForIndex:(NSInteger)index
{
    NSString *shopTypeName = self.shopTypeNameArray[index];
    
    if([self.shopTypeName isEqualToString:@"专题"])
    {
        [TFStatisticsClickVM StatisticshandleDataWithClickType:@"到达专题列表页" success:nil failure:nil];
    }else{
        [TFStatisticsClickVM StatisticshandleDataWithClickType:@"到达搭配列表页" success:nil failure:nil];
    }

//    if ([shopTypeName isEqualToString:@"专题"] || [shopTypeName isEqualToString:@"精选"])
    if ([shopTypeName isEqualToString:@"专题"])
    {
        TFCollocationViewController *subVC = self.childViewControllers[index];
        subVC.isHeadView = self.isHeadView;
        if (self.isHeadView) {
            subVC.customDelegate = self;
        }
        return subVC.mainTableView;
        
    }else if ([shopTypeName isEqualToString:@"生活"])
    {
        CollectionViewController *subVC = self.childViewControllers[index];
        subVC.isHeadView = self.isHeadView;
        if (self.isHeadView) {
            subVC.customDelegate = self;
        }
        return subVC.collectionView;
    }
    else {
        CollectionViewController *subVC = self.childViewControllers[index];
        subVC.isHeadView = self.isHeadView;
        if (self.isHeadView) {
            subVC.customDelegate = self;
        }
        return subVC.collectionView;
    }
    return 0;
}

- (void)slidePageScrollView:(TYSlidePageScrollView *)slidePageScrollView horizenScrollToPageIndex:(NSInteger)index
{
    if (_delegateFlags.titlePageToIndex) {
        if (index >= self.typeIndexArray.count) {
            return;
        }
        [self.shopStoreDelegate titlePageToIndex:index withTitleShopType:self.typeIndexArray[index]];
    }
    
}

- (void)slidePageScrollView:(TYSlidePageScrollView *)slidePageScrollView pageTabBarScrollOffset:(CGFloat)offset state:(TYPageTabBarState)state
{
    [self pageTabBarState:state];
    self.pageTabBarState = state;
}

- (void)slidePageScrollView:(TYSlidePageScrollView *)slidePageScrollView verticalScrollViewDidScroll:(UIScrollView *)pageScrollView
{
    if (_delegateFlags.storePageViewScrollViewDidScroll) {
        [self.shopStoreDelegate storePageViewScrollViewDidScroll:pageScrollView];
    }
    if (pageScrollView.contentSize.height <= CGRectGetHeight(pageScrollView.bounds)-Height_TabBar-(self.topImageHeight+self.hotImageHeight+self.lineHeight+self.titleHeight)) {
        
        if (_delegateFlags.storePageViewScrollSetTabBarStatus) {
            [self.shopStoreDelegate storePageViewScrollView:pageScrollView setTabBarStatus:TabBarStutesNormal animation:NO];
        }
        return;
    } else if (pageScrollView.panGestureRecognizer.state == UIGestureRecognizerStateChanged){
        CGFloat nowPanOffsetY = [pageScrollView.panGestureRecognizer translationInView:pageScrollView.superview].y;
        CGFloat diffPanOffsetY = nowPanOffsetY - _oldPointY;
        
        if (ABS(diffPanOffsetY) > 5) {
            
            if (diffPanOffsetY <0) {
                
                if (_delegateFlags.storePageViewScrollSetTabBarStatus) {
                    [self.shopStoreDelegate storePageViewScrollView:pageScrollView setTabBarStatus:TabBarStutesBottom animation:YES];
                }
                
                
            } else {
                if (_delegateFlags.storePageViewScrollSetTabBarStatus) {
                    [self.shopStoreDelegate storePageViewScrollView:pageScrollView setTabBarStatus:TabBarStutesNormal animation:YES];
                }
            }
        }
        _oldPointY = nowPanOffsetY;
        
    }
}

#pragma mark collectionViewCustomDelegate
- (void)collectionViewWithScrollViewWillBeginDragging:(UIScrollView *)scrollView index:(int)index
{
    
    _oldPointY = [scrollView.panGestureRecognizer translationInView:scrollView.superview].y;
}

- (void)collectionViewWithScrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate index:(int)index
{
    
    _oldPointY = 0;
    if (decelerate == NO) {
        
    } else{
        
    }
    
}

- (void)collectionViewWithScrollViewWillBeginDecelerating:(UIScrollView *)scrollView index:(int)index
{
    
}

- (void)collectionViewWithscrollViewDidEndDecelerating:(UIScrollView *)scrollView index:(int)index
{
    if (_delegateFlags.storePageViewScrollSetTabBarStatus) {
//        [self.shopStoreDelegate storePageViewScrollSetTabBarStatus:TabBarStutesNormal animation:YES];
    }
    
}

- (void)collocationViewPullDownRefreshWithIndex:(int)index
{
    [self httpGetTopShopsAndCentShops:NO];
}

#pragma mark - collocationViewCustomDelegate
- (void)collocationViewWithScrollViewWillBeginDragging:(UIScrollView *)scrollView index:(int)index
{
    _oldPointY = [scrollView.panGestureRecognizer translationInView:scrollView.superview].y;
}

#pragma mark - http Request
-(void)httpGetTopShopsAndCentShops:(BOOL)bl
{
    [self.topShopsVM handleDataWithSuccess:^(NSArray *centShopsArray, NSArray *topShopsArray, Response *response) {
        if (response.status == 1) {
            
            [self.topShopsArray removeAllObjects];
            [self.topShopsArray addObjectsFromArray:topShopsArray];
            if (self.topShopsArray.count) {
                [self refreshTopShops];
            }
            if (self.topShopsVM.hotService.dataSource.count) {
//                [self.hotCollectionView reloadData];
            }
        }
    } failure:^(NSError *error) {
        
    }];
}

-(void)refreshTopShops
{
    NSMutableArray *viewsArray = [NSMutableArray array];
    if(self.topShopsArray.count)
    {
        for (UIView *view in self.myBigScrollView.subviews) {
            [view removeFromSuperview];
        }
        
        for (int i = 0; i < self.topShopsArray.count; i++) {
            TFShoppingM *model=self.topShopsArray[i];
            NSString *imgUrlStr = [NSString stringWithFormat:@"%@%@!560",[NSObject baseURLStr_Upy],model.url];
            [viewsArray addObject:imgUrlStr];
        }
        
        //添加轮播图
        self.myBigScrollView = [[ScrollView_public alloc]initWithFrame:CGRectMake(0, 0, kApplicationWidth, self.topImageHeight) pictures:viewsArray animationDuration:5 contentMode_style:Fill_contentModestyle Haveshiping:NO];
        
        self.myBigScrollView.pageControl.currentPageIndicatorImage = [UIImage imageNamed:@"Carousel_Selected"];
        self.myBigScrollView.pageControl.pageIndicatorImage = [UIImage imageNamed:@"Carousel_normal"];
        
        [self.nheadView addSubview:self.myBigScrollView];
        
        self.myBigScrollView.scrollview.scrollsToTop = NO;
        NSArray *tmpArr = self.topShopsArray;
        __weak TFShopStoreViewController *shopStore = self;
        self.myBigScrollView.getTapClickPage = ^(NSInteger page){
            
            NSString *typeName = [NSString stringWithFormat:@"banner%ld", (long)page+1];
            [TFStatisticsClickVM handleDataWithPageType:nil withClickType:typeName success:nil failure:nil];
            
            TFShoppingM *model = shopStore.topShopsArray[page];
            if(model.option_type.intValue == 1)//商品详情
            {
                ShopDetailViewController *detail=[[ShopDetailViewController alloc]initWithNibName:@"ShopDetailViewController" bundle:nil];
                detail.shop_code=model.shop_code;
                detail.hidesBottomBarWhenPushed=YES;
                [shopStore.navigationController pushViewController:detail animated:YES];
                
            }else if (model.option_type.intValue == 2)//邀请码
            {
                NSUserDefaults *userdefaul = [NSUserDefaults standardUserDefaults];
                NSString *token = [userdefaul objectForKey:USER_TOKEN];
                
                if(token == nil) {
                    [shopStore toLoginView];
                } else{
                    
                    InvitCodeViewController *invit =[[InvitCodeViewController alloc]init];
                    invit.hidesBottomBarWhenPushed = YES;
                    [shopStore.navigationController pushViewController:invit animated:YES];
                }
                
            }else if (model.option_type.intValue == 3)//消息盒子
            {
                
                NSUserDefaults *userdefaul = [NSUserDefaults standardUserDefaults];
                NSString *token = [userdefaul objectForKey:USER_TOKEN];
                
                if(token == nil) {
                    [shopStore toLoginView];
                } else{
                    // begin 赵官林 2016.5.26 跳转到消息列表
                    [shopStore presentChatList];
                    // end
                }
            }else if (model.option_type.intValue == 4)//签到页
            {
                Mtarbar.selectedIndex = 2;
            }else if (model.option_type.intValue == 5)//H5活动页
            {
                TFShoppingM *model=tmpArr[page];
                
                if(model.shop_code !=nil || ![model.shop_code isEqual:[NSNull null]]){
                    
                    H5activityViewController *h5vc = [[H5activityViewController alloc]init];
                    h5vc.H5url = model.shop_code;
                    h5vc.hidesBottomBarWhenPushed = YES;
                    [shopStore.navigationController pushViewController:h5vc animated:YES];
                }
            }else if (model.option_type.intValue == 6)//新品专区
            {
                
                NewProductViewController *new = [[NewProductViewController alloc]init];
                new.hidesBottomBarWhenPushed = YES;
                [shopStore.navigationController pushViewController:new animated:YES];
            }else if (model.option_type.intValue == 7)//制造商
            {
                
                BrandMakerDetailVC *view=[BrandMakerDetailVC new];
                
                SqliteManager *manager = [SqliteManager sharedManager];
                TypeTagItem *item = [manager getSuppLabelItemForId:[NSString stringWithFormat:@"%@",model.shop_code]];
                view.shopItem=item;
                view.hidesBottomBarWhenPushed=YES;
                [shopStore.navigationController pushViewController:view animated:YES];
            }
        };
    } else {
        [self httpGetTopShopsAndCentShops:YES];
    }
}

- (void)toLoginView
{
    TFLoginView *tf = [[TFLoginView alloc] initWithHeadImage:nil contentText:nil upButtonTitle:nil downButtonTitle:nil];
    [tf show];
    
    tf.upBlock = ^() { //注册
        //上键");
        
        [self toLogin:2000];
    };
    
    tf.downBlock = ^() {// 登录
        //下键");
        
        [self toLogin:1000];
    };
}
- (void)toLogin :(NSInteger)tag
{
    LoginViewController *login=[[LoginViewController alloc]init];
    login.tag = tag;
    login.loginStatue=@"toBack";
    login.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:login animated:YES];
}

- (void)collectionViewPullDownRefreshWithIndex:(int)index
{
    [self httpGetTopShopsAndCentShops:NO];
}

- (NSMutableArray *)titleArry
{
    if (!_titleArry) {
        _titleArry = [NSMutableArray array];
    }
    return _titleArry;
}

- (NSMutableArray *)typeIndexArray
{
    if (!_typeIndexArray) {
        _typeIndexArray = [NSMutableArray array];
    }
    return _typeIndexArray;
}

- (NSMutableArray *)shopTypeIDArray
{
    if (!_shopTypeIDArray) {
        _shopTypeIDArray = [NSMutableArray array];
    }
    return _shopTypeIDArray;
}

- (NSMutableArray *)shopTypeNameArray
{
    if (!_shopTypeNameArray) {
        _shopTypeNameArray = [NSMutableArray array];
    }
    return _shopTypeNameArray;
}

- (NSMutableArray *)shopTypeIcoArray
{
    if (!_shopTypeIconArray) {
        _shopTypeIconArray = [NSMutableArray array];
    }
    return _shopTypeIconArray;
}

- (NSMutableArray *)topShopsArray
{
    if (!_topShopsArray) {
        _topShopsArray = [NSMutableArray array];
    }
    return _topShopsArray;
}

//- (void)loadView
//{
//    UIView *view = [UIView new];
//    view.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
//    self.view = view;
//}

- (void)setShopStoreDelegate:(id<TFShopStoreDelegate>)shopStoreDelegate
{
    _shopStoreDelegate = shopStoreDelegate;
    
    _delegateFlags.titlePageToIndex = [shopStoreDelegate respondsToSelector:@selector(titlePageToIndex:withTitleShopType:)];
    _delegateFlags.storePageViewScrollSetTabBarStatus = [shopStoreDelegate respondsToSelector:@selector(storePageViewScrollView:setTabBarStatus:animation:)];
    _delegateFlags.storeTitleTopStatus = [shopStoreDelegate respondsToSelector:@selector(storeTitleTopStatus:)];
    _delegateFlags.storePageViewScrollViewDidScroll = [shopStoreDelegate respondsToSelector:@selector(storePageViewScrollViewDidScroll:)];
    
}

//是否在同一周
- (BOOL)isSameWeek:(NSDate *)date
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *comps = [calendar components:NSCalendarUnitWeekOfYear fromDate:date];
    NSDateComponents *selfComps = [calendar components:NSCalendarUnitWeekOfYear fromDate:[NSDate date]];
    NSInteger week = [comps weekOfYear];//今年的第几周
    NSInteger week2 = [selfComps weekOfYear];

    return week==week2;
    
}

#pragma mark - 1️⃣➢➢➢ 弹框
//首页引导到赚钱任务页的引导弹窗，仅出现前2天（新用户打开app，前两天打开的时候出现。比如周一打开了，弹窗，周二没打开，周三打开了，弹窗，周四周五周六日都不弹）。以后每周一次（每周打开，只在第一次打开的时候出现，按自然周计算，周一0点到周日24点）。
- (void)alertMakeMoneyView {

    NSInteger appNumCount = [[NSUserDefaults standardUserDefaults] integerForKey:@"appNumCount"];
    NSString *eightday = [[NSUserDefaults standardUserDefaults]objectForKey:@"eight"];
    BOOL isShow = NO;
    BOOL isShowFightSuccess = NO;
    
    NSDate *date = [[NSUserDefaults standardUserDefaults] objectForKey:@"getMoneyDate"];
    BOOL sameWeek = [self isSameWeek:date];

    NSString *daystr = [MyMD5 compareDate:date];

    if ((![daystr isEqualToString:@"今天"] && appNumCount<2) || !sameWeek) {
        isShow = YES;
        appNumCount += 1;
        [[NSUserDefaults standardUserDefaults] setInteger:appNumCount forKey:@"appNumCount"];
        [[NSUserDefaults standardUserDefaults] setObject:[NSDate date] forKey:@"getMoneyDate"];
        [[NSUserDefaults standardUserDefaults] setObject:[NSDate date] forKey:TASKCOUNTMENTION];
        
        //        [self httpYFAlertViewData];
        [self hongbaoview];
    }else if(eightday == nil)//如果是第8天落地页在首页弹出此框
    {
        [self getShouyeHttp];
    }else{
        //千元红包雨弹框
        if([DataManager sharedManager].is_guidePopviewShow)
        {
            [[DataManager sharedManager] guidePopview];
        }else{
            isShowFightSuccess = YES;
//            [self getFightSuccess];//拼团成功提示弹框
            [self getFightRawarSuccess];
        }
    }
}
#pragma mark 疯狂新衣节弹框
- (void)firstGoToMakeMoney {
    //是否有疯狂星期一的任务
    [TopicPublicModel GetisMandayDataSuccess:^(id data) {
        
        TopicPublicModel *model = data;
        if(model.status == 1)
        {
            [DataManager sharedManager].IS_Monday = model.isMonday==1?YES:NO;
            model.isMonday == 1?([self performSelector:@selector(popCrazyMonday) withObject:self afterDelay:1.5]):nil;
            if([DataManager sharedManager].IS_Monday)
            {
                [DataManager sharedManager].mondayValue = [NSString stringWithFormat:@"%@",model.monday_info[@"value"]];
            }else{
                //千元红包雨弹框
                if([DataManager sharedManager].is_guidePopviewShow)
                {
                    [[DataManager sharedManager] guidePopview];
                }
            }
        }
    }];
}

#pragma mark 疯狂星期一
- (void)popCrazyMonday
{
    //记录疯狂星期一弹出时间（每天只弹一次）
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSDate *record = [user objectForKey:CRAZYMonday];
    if(![[MyMD5 compareDate:record] isEqualToString:@"今天"] || record==nil )
    {
        [self setFreeOrderPopMindView:CrazyMonday_activity];
        NSDate *date = [NSDate date];
        [user setObject:date forKey:CRAZYMonday];
    }
}
#pragma mark 疯狂星期一弹框
- (void)setFreeOrderPopMindView:(FreeOrderType)Ordertype
{
    FreeOrderPopview* freeorderview = [[FreeOrderPopview alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) FreeOrderType:Ordertype];
    __weak FreeOrderPopview *view = freeorderview;
    ESWeakSelf;
    view.tapHideMindBlock = ^{
        
        if(Ordertype == CrazyMonday_activity)
        {
            [__weakSelf loginSuccess:^{
                
                [__weakSelf CrazyMonday];
            }];
        }
    };
    
    view.getLuckBlock = ^{
        
        [__weakSelf loginSuccess:^{
            
            CrazyStyleViewController *vc = [[CrazyStyleViewController alloc]init];
            vc.hidesBottomBarWhenPushed = YES;
            [__weakSelf.navigationController pushViewController:vc animated:YES];
        }];
        
    };
    
    [self.view addSubview:freeorderview];
    [self.view bringSubviewToFront:freeorderview];
}

//疯狂星期一活动详情页
- (void)CrazyMonday
{

    CrazyMondayActivityVC *activity = [[CrazyMondayActivityVC alloc]init];
    activity.hidesBottomBarWhenPushed = YES;
    activity.comefrom = @"推荐";
    [self.navigationController pushViewController:activity animated:YES];
}

#pragma mark 请求落地页
- (void)getShouyeHttp
{
    NSUserDefaults *userdefaul = [NSUserDefaults standardUserDefaults];
    NSString *token = [userdefaul objectForKey:USER_TOKEN];
    
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *paraments=[NSMutableDictionary dictionary];
    
    //修改后的接口
    NSString *url=[NSString stringWithFormat:@"%@/cfg/landingPage?version=%@&token=%@",[NSObject baseURLStr],VERSION,token];
    NSString *URL=[MyMD5 authkey:url];
    [manager POST:URL parameters:paraments success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if ([responseObject[@"status"] intValue] == 1) {
            
            NSInteger shouyeCount = [NSString stringWithFormat:@"%@",responseObject[@"data"]].integerValue;
            [DataManager sharedManager].shouYeGround = shouyeCount;
            
            if (shouyeCount == 1)
            {
//                [self httpYFAlertViewData];
                [self hongbaoview];
                [[NSUserDefaults standardUserDefaults]setObject:@"eight" forKey:@"eight"];
            }else{
                [self firstGoToMakeMoney];
            }
        }else{
            [self firstGoToMakeMoney];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}
#pragma mark 是否有拼团成功的订单
- (void)getFightSuccess
{
    NSUserDefaults *userdefaul = [NSUserDefaults standardUserDefaults];
    NSString *token = [userdefaul objectForKey:USER_TOKEN];
    
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *paraments=[NSMutableDictionary dictionary];
    
    NSString *url=[NSString stringWithFormat:@"%@/order/getOrderStatus?version=%@&token=%@",[NSObject baseURLStr],VERSION,token];
    NSString *URL=[MyMD5 authkey:url];
    [manager POST:URL parameters:paraments success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"&&&&&&&&&&&&&&&&&&&&&&&&URL=%@",URL);
        if ([responseObject[@"status"] intValue] == 1) {
            
            NSInteger roll = [responseObject[@"roll"] integerValue];
            NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
            BOOL isFightSuccessShow = [user boolForKey:@"isFightSuccessShow"];
            if(roll == 1 && !isFightSuccessShow)
            {
                NSString *username = [NSString stringWithFormat:@"%@",responseObject[@"user_name"]];
                [user setBool:YES forKey:@"isFightSuccessShow"];
                [user setValue:username forKey:@"fightSuccessUser"];
                self.isFightPop = YES;
                [self setVitalityPopMindView:Fight_luckSuccess];
                
            }else{
                //拼团失败退款提示框
                kWeakSelf(self);
                [OneYuanModel GetOneYuanCountSuccess:^(id data) {
                    OneYuanModel *oneModel = data;
                    if(oneModel.status == 1 && oneModel.isFail == 1)
                    {
                        self.isFightPop = YES;
                        [DataManager sharedManager].OneYuan_count = oneModel.order_price;

                        [weakself setVitalityPopMindView:Detail_OneYuanDeductible];
                    }
                }];
            }
        }
        
        //当有拼团成功拼团失败退款的弹框时不弹此框
        if(self.isOnLoad && !self.isFightPop){
            self.isOnLoad = NO;
            [self RedhongBao];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}
- (void)getFightRawarSuccess
{
    NSUserDefaults *userdefaul = [NSUserDefaults standardUserDefaults];
    NSString *token = [userdefaul objectForKey:USER_TOKEN];
    
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *paraments=[NSMutableDictionary dictionary];
    
    NSString *url=[NSString stringWithFormat:@"%@/userVipCard/rewardDrawPop?version=%@&token=%@",[NSObject baseURLStr],VERSION,token];
    NSString *URL=[MyMD5 authkey:url];
    [manager POST:URL parameters:paraments success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"&&&&&&&&&&&&&&&&&&&&&&&&URL=%@",URL);
        if ([responseObject[@"status"] intValue] == 1) {
            
            NSInteger ispop = [responseObject[@"pop"] integerValue];
            NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
            BOOL isFightSuccessShow = [user boolForKey:@"isFightSuccessShow"];
            if(ispop > 0 && !isFightSuccessShow)
            {
                NSString *rawardMoney = [NSString stringWithFormat:@"%@",responseObject[@"draw"]];
                [user setBool:YES forKey:@"isFightSuccessShow"];
                [user setValue:rawardMoney forKey:@"rawardMoney"];
                self.isFightPop = YES;
                [self setVitalityPopMindView:ispop==2?Fight_rawardClear:Fight_rawardSuccess];
            }else{
                //拼团失败退款提示框
                kWeakSelf(self);
                [OneYuanModel GetOneYuanCountSuccess:^(id data) {
                    OneYuanModel *oneModel = data;
                    if(oneModel.status == 1 && oneModel.isFail == 1)
                    {
                        self.isFightPop = YES;
                        [DataManager sharedManager].OneYuan_count = oneModel.order_price;
                        
                        [weakself setVitalityPopMindView:Detail_OneYuanDeductible];
                    }
                }];
            }
        }
        
        //当有拼团成功拼团失败退款的弹框时不弹此框
        if(self.isOnLoad && !self.isFightPop){
            self.isOnLoad = NO;
            [self RedhongBao];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}
- (void)httpYFAlertViewData
{
    //不登录不弹
    NSString *token = [[NSUserDefaults standardUserDefaults]objectForKey:USER_TOKEN];
    if(token.length < 10)
    {
        return;
    }
    NSString *url= [NSString stringWithFormat:@"%@paperwork/paperwork.json",[NSObject baseURLStr_Upy]];

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer.cachePolicy = NSURLRequestReloadIgnoringLocalCacheData;

    kSelfWeak;
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        MyLog(@"responseObject = %@", responseObject);

        responseObject = [NSDictionary changeType:responseObject];
        if (responseObject!=nil) {

            if(responseObject[@"qdrwyd"] != nil)
            {
                NSDictionary *dic = responseObject[@"qdrwyd"];
                NSString *text = dic[@"text"];
              
                //每日任务弹窗文案修改3.5.9
                NSArray *arr = [text componentsSeparatedByString:@","];
                if (arr.count>2) {
                    __block NSString *title = [NSString stringWithString:dic[@"title"]] ;
                    NSString *title1 = [NSString stringWithString:dic[@"title1"]] ;
                    
                    title = [title stringByReplacingOccurrencesOfString:@"${replace}元" withString:[NSString stringWithFormat:@"%@元",arr[0]]];
//                    title = [title stringByReplacingOccurrencesOfString:@"${replace}个" withString:[NSString stringWithFormat:@"%@个",arr[1]]];
                    title1 = [title1 stringByReplacingOccurrencesOfString:@"${replace}个" withString:[NSString stringWithFormat:@"%@个",arr[1]]];
                    title1 = [title1 stringByReplacingOccurrencesOfString:@"${replace}元" withString:[NSString stringWithFormat:@"%@元",arr[2]]];


                    [IndianaPublicModel H5getMoney:^(id data) {
                        IndianaPublicModel *model = data;
                        if(model.status == 1 && model.data.floatValue>0)
                        {
                            title = [title stringByReplacingOccurrencesOfString:@"${replace}元" withString:[NSString stringWithFormat:@"%.2f元",model.data.floatValue]];
                        }else{
                            title = @"";
                        }
                        
                        YFAlertView *view = [[YFAlertView alloc]initWithFrame:self.view.frame];
                        view.titleStr = [NSString stringWithFormat:@"%@\n%@",title,title1];
                        view.btnBlok = ^(NSInteger index) {
                            MakeMoneyViewController *vc = [[MakeMoneyViewController alloc]init];
                            vc.hidesBottomBarWhenPushed = YES;
                            [weakSelf.navigationController pushViewController:vc animated:YES];
                        };
                        view.home_zeroshoppingBlock = ^ {
                            [self setVitalityPopMindView:Super_zeroShopping];
                        };
                        //当赚钱任务页隐藏的时候不弹此框
                        if(![DataManager sharedManager].is_MakeMoneyHiden)
                        {
                            [view show];
                        }
                    }];
                    
                }
            }
        }

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];

}
/// 强制更新
- (void)updateview {

    UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
    UIViewController *topVC = [keyWindow topViewControllerWithRootViewController:keyWindow.rootViewController];
    if (![topVC isKindOfClass:NSClassFromString(@"TFShoppingViewController")]) {
        return;
    }
    //网络获取当前版本
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    if (appDelegate.isUpdata == YES && [DataManager sharedManager].shouYeGround < 2) {

        NSUserDefaults *userDef = [NSUserDefaults standardUserDefaults];
        BOOL isShow = [userDef boolForKey:UPDATE_SHOW];
        NSTimeInterval time = [NSDate date].timeIntervalSince1970 - [userDef doubleForKey:UPDATE_TIME];

        //是否勾选 不再提醒更新按钮
        if (isShow || time < 72*60*60) {
           
            [self alertMakeMoneyView];
            
        }else{
            /// 强制更新
            NSString *version_no = [NSString stringWithFormat:@"%@更新了以下内容",appDelegate.version_no];
            NSString *msg = [NSString stringWithFormat:@"%@",appDelegate.msg];
            [UpdateView showType:appDelegate.isQiangGeng title:@"衣蝠发新版啦～" subtitle:version_no text:msg toView:self.view.window removeBlock:^{

            }];
        }
    }
    else if([DataManager sharedManager].shouYeGround < 2){
        [self alertMakeMoneyView];
    }else{
//        [self getFightSuccess];
        [self getFightRawarSuccess];
    }
}

#pragma mark 0元购弹框
- (void)setVitalityPopMindView:(VitalityType)type
{
    NSInteger valityGrade = type ==Detail_OneYuanDeductible?3:0;
    
    VitalityTaskPopview *vitaliview = [[VitalityTaskPopview alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) VitalityType:type valityGrade:valityGrade YidouCount:0];
    vitaliview.oneYuanDiKou = [DataManager sharedManager].OneYuan_count;

    __weak VitalityTaskPopview *view = vitaliview;
    view.tapHideMindBlock = ^{
        
        if(type == Stop_business)
        {
            [self httpGetRandShopWithType:nil Daytag:0 fanxian:NO];
        }
        else{
            [view remindViewHiden];
        }
    };
    view.closeMindBlock = ^{
        
    };
    view.leftHideMindBlock = ^(NSString*title){
        if(type == Stop_business)
        {
            [self httpGetRandShopWithType:nil Daytag:0 fanxian:NO];
        }else if (type == Fight_luckSuccess || type == Detail_OneYuanDeductible)
        {
        
            MyOrderViewController *myorder = [[MyOrderViewController alloc]init];
            myorder.tag= (type == Detail_OneYuanDeductible)?999:1001;
            myorder.status1= (type == Detail_OneYuanDeductible)?@"0":@"2";
            myorder.hidesBottomBarWhenPushed = YES;
            
            Mtarbar.selectedIndex=4;
            UINavigationController *nv = (UINavigationController *)Mtarbar.viewControllers[4];
            nv.navigationBarHidden = YES;
            [nv pushViewController:myorder animated:YES];
        }else if (type == Fight_rawardSuccess){
            MemberRawardsViewController *rawards = [[MemberRawardsViewController alloc]init];
            rawards.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:rawards animated:YES];
        }else if (type == Fight_rawardClear)
        {
            //账户明细
            TFAccountDetailsViewController *tdvc = [[TFAccountDetailsViewController alloc] init];
            tdvc.headIndex = 3;
            tdvc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:tdvc animated:YES];
        }
    };
    view.rightHideMindBlock = ^(NSString *title) {
        if (type == Detail_OneYuanDeductible)//余额返回说明
        {
            TFMyWalletViewController *wallet = [[TFMyWalletViewController alloc]init];
            wallet.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:wallet animated:YES];
        }else if (type == Fight_rawardClear)//成为会员
        {
            AddMemberCardViewController *member = [[AddMemberCardViewController alloc]init];
            member.hidesBottomBarWhenPushed = YES;
            member.from_vipType = @"detail";
            [self.navigationController pushViewController:member animated:YES];
        }
    };
    
    if(type == Stop_business)
    {
        [kUIWindow addSubview:vitaliview];
    }else
        [self.view addSubview:vitaliview];
}

#pragma mark 获取随机分享商品
- (void)httpGetRandShopWithType:(NSString *)myType Daytag:(int)daytag fanxian:(BOOL)isfanxian
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *token = [ud objectForKey:USER_TOKEN];
    NSString *realm = [ud objectForKey:USER_ID];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    NSString *urlStr;
    
    NSString *shoptypestr;
    
    //实惠类商品
    urlStr = [NSString stringWithFormat:@"%@shop/shareShop?token=%@&version=%@&realm=%@&getShop=true&hobby=20",[NSObject baseURLStr], token,VERSION, realm];
    shoptypestr = @"正价商品";
    
    
    NSString *URL = [MyMD5 authkey:urlStr];
    
    [MBProgressHUD showMessage:@"分享加载中，稍等哟~" afterDeleay:0 WithView:self.view];
    
    [manager GET:URL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if (responseObject!=nil) {
            
            MyLog(@"responseObject = %@",responseObject);
            
            if ([responseObject[@"status"] intValue] == 1) {
                
                    NSString *QrLink = responseObject[@"QrLink"];
                    if(isfanxian)
                    {
                        QrLink = [NSString stringWithFormat:@"%@%@",QrLink,@"share=true"];
                    }
                    
                    NSString *prce = [NSString stringWithFormat:@"%.1f", [responseObject[@"shop"][@"shop_se_price"] floatValue]];
                    NSNumber *shop_se_price = (NSNumber*)prce;
                    NSString *four_pic = [NSString stringWithFormat:@"%@",responseObject[@"shop"][@"four_pic"]];
                    NSString *shop_name = [NSString stringWithFormat:@"%@",responseObject[@"shop"][@"shop_name"]];
                    NSString *brand = [NSString stringWithFormat:@"%@",responseObject[@"shop"][@"supp_label"]];
                    NSString *app_shop_group_price = [NSString stringWithFormat:@"%@",responseObject[@"shop"][@"app_shop_group_price"]];
                    NSArray *picArr ;
                    if(![four_pic isEqual:[NSNull null]] && ![four_pic isEqualToString:@"null"])
                    {
                        picArr = [four_pic componentsSeparatedByString:@","];
                    }else{
                        NavgationbarView *mentionview = [[NavgationbarView alloc]init];
                        [mentionview showLable:@"数据异常" Controller:self];
                        
                        return ;
                    }
                    NSString *pic = [picArr lastObject];
                    NSString *shop_code = responseObject[@"shop"][@"shop_code"];
                    NSString *sup_code  = [shop_code substringWithRange:NSMakeRange(1, 3)];
                    NSString *share_pic = [NSString stringWithFormat:@"%@/%@/%@", sup_code, shop_code, pic];
                    [DataManager sharedManager].key = shop_code;
                    
                    NSUserDefaults *userdefaul = [NSUserDefaults standardUserDefaults];
                    if(shop_code.length > 10)
                    {
                        [userdefaul setObject:shop_code forKey:SHOP_CODE];
                    }
                    if(QrLink.length > 10)
                    {
                        [userdefaul setObject:QrLink forKey:QR_LINK];
                    }
                    if(![shop_name isEqual:[NSNull null]] && ![shop_name isEqualToString:@"null"] && shop_name != nil)
                    {
                        [userdefaul setObject:shop_name forKey:SHOP_NAME];
                    }
                    if(![brand isEqual:[NSNull null]] && ![brand isEqualToString:@"null"] && brand != nil)
                    {
                        [userdefaul setObject:brand forKey:SHOP_BRAND];
                    }
                    if(shop_se_price > 0)
                    {
                        [userdefaul setObject:shop_se_price forKey:SHOP_PRICE];
                    }
                    if(![app_shop_group_price isEqual:[NSNull null]] && ![app_shop_group_price isEqualToString:@"null"] && app_shop_group_price != nil)
                    {
                        [userdefaul setObject:app_shop_group_price forKey:@"app_shop_group_price"];
                    }
                    [TypeShareModel getTypeCodeWithShop_code:shop_code success:^(TypeShareModel *data) {
                        
                        if(data.status == 1 && data.type2 != nil)
                        {
                            [userdefaul setObject:[NSString stringWithFormat:@"%@",data.type2] forKey:SHOP_TYPE2];
                            [self miniSharewithTypeisShop:YES Tixian:NO Sharelink:nil ShareImage:share_pic];
                        }
                        
                    }];
                
                
            }else{
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                
                [MBProgressHUD show:@"数据异常，请稍后" icon:nil view:self.view];
            }
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
    
}

#pragma mark &&&&&&&&&&&&&&&&&&&&&&&&&&小程序分享
- (void)miniSharewithTypeisShop:(BOOL)isshop Tixian:(BOOL)istixian Sharelink:(NSString*)link ShareImage:(NSString*)shareimage
{
    MiniShareManager *minishare = [MiniShareManager share];
    minishare.delegate = self;
    NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
    NSString *realm = [user objectForKey:USER_ID];
    NSString *image = @""; NSString *title = @"";
    NSString *path  = [NSString stringWithFormat:@"/pages/shouye/redHongBao?shouYePage=ThreePage&isShareFlag=true&user_id=%@",realm];
    if(isshop)//随机商品
    {
        NSString *shopprice =[user objectForKey:SHOP_PRICE];
        NSString *shop_brand = [user objectForKey:SHOP_BRAND];
        NSString *shop_code = [user objectForKey:SHOP_CODE];
        NSString *shop_name = [user objectForKey:SHOP_NAME];
        NSString *app_shop_group_price = [user objectForKey:@"app_shop_group_price"];
        if(shop_brand == nil || [shop_brand isEqualToString:@"(null)"] || [shop_brand isEqual:[NSNull null]])
        {
            shop_brand = @"衣蝠";
        }
        NSString *type2 = [user objectForKey:SHOP_TYPE2];
        
        image = [NSString stringWithFormat:@"%@%@!450",[NSObject baseURLStr_Upy],shareimage];
        title = [minishare newtaskrawardHttp:type2 Price:shopprice Brand:shop_brand];
        path = [NSString stringWithFormat:@"/pages/shouye/detail/detail?shop_code=%@&user_id=%@",shop_code,realm];
        
        //合成图片
        ProduceImage *pi = [[ProduceImage alloc] init];
        UIImage *baseImg = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:image]]];
        UIImage *zhezhaoImg = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[NSObject baseURLStr_XCX_Upy],@"small-iconImages/heboImg/shareCanvas_price.png"]]]];
        UIImage *afterImage = [pi getShareImage:zhezhaoImg WithBaseImg:baseImg WithPrice:app_shop_group_price];
        NSData *imageData = UIImageJPEGRepresentation(afterImage,0.8f);
        
        title= [NSString stringWithFormat:@"点击购买👆【%@】今日特价%.1f元！",shop_name,[app_shop_group_price floatValue]];
        [minishare shareAppImageWithType:MINIShareTypeWeixiSession Image:imageData Title:title Discription:nil WithSharePath:path];
    }
    
    
//    [minishare shareAppWithType:MINIShareTypeWeixiSession Image:image Title:title Discription:nil WithSharePath:path];
}
#pragma mark - 红包漫天飞（弹框）
- (void)loadAddVoucher:(BOOL)isPop {
    NSString *token = [TFPublicClass getTokenFromLocal];
    if (token == nil) {
        return;
    }
    __weak typeof(self) weakSelf = self;
    [AddVoucherModel getAddVoucherModelWithToken:token success:^(id data) {
        AddVoucherModel *model = data;
        if (model.status == 1 && isPop) {
            if (model.num == 0)
                [weakSelf popWTFAlertView:@[@"30", @"20", @"20", @"10"]];
            else if (model.num == 1)
                [weakSelf popWTFAlertView:@[@"15", @"10", @"5"]];
        }
    }];
}

/// 红包满天飞是否弹过
- (BOOL)redCadsDisplay {
    //是否是当前页面
    UIViewController *view = ((UINavigationController *)Mtarbar.selectedViewController).topViewController;
    if (![view isKindOfClass:[TFShoppingViewController class]] || ((TFShoppingViewController *)view).selcetedControllerType == CurrSelectedControllerType_B) {
        return NO;
    }
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *oldDate = [ud objectForKey:RedCash];
    NSNumber *userID = [ud objectForKey:USER_ID];
    NSString *currTime = [MyMD5 getCurrTimeString:@"year-month-day"];
    NSString *currDate = [NSString stringWithFormat:@"%@%@", userID?:@"", currTime];
    

    if (userID == nil) {
        //未登录，且今天未弹
        if ([oldDate rangeOfString:currTime].location == NSNotFound || oldDate == nil) {
//            [ud setObject:currDate forKey:RedCash];
//            [self popWTFAlertView:@[@"30", @"20", @"20", @"10"]];
            return NO;
        }
    } else {
        //已登录，且今天未登录时弹过
        if ([oldDate isEqualToString:currTime]) {
//            [ud setObject:currDate forKey:RedCash];
//            [self loadAddVoucher:NO];
        //已登录，且未弹过或当前帐号今天未弹
        }else if (oldDate == nil || ![oldDate isEqualToString:currDate]) {
//            [ud setObject:currDate forKey:RedCash];
//            [self loadAddVoucher:YES];
            return NO;
        }
    }
    return YES;
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

/// 30元现金
- (BOOL)showSignView
{
    BOOL isThirty = [[[NSUserDefaults standardUserDefaults] objectForKey:@"ThirtyCash"] boolValue];
    if (isThirty) {
        return YES;
    } else {
        [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithBool:YES] forKey:@"ThirtyCash"];
        TFNoviceTaskView *popView = [[TFNoviceTaskView alloc] init];
        [popView returnClick:^(NSInteger type) {
            Mtarbar.selectedIndex = 2;
        } withCloseBlock:^(NSInteger type) {
            
        }];
        [popView showWithType:@"30yuanxianjin"];
        return NO;
    }
}

#pragma mark - 新手任务5 (注册用户未开店)
- (void)noviceTaskView5
{
    //5：0元购首页，5秒，弹1未完成，已登录未开店
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    
    NSString *noviceTaskView5 = [ud objectForKey:NoviciateTaskFive];
    
    NSString *token = [ud objectForKey:USER_TOKEN];
    NSString *hobby = [ud objectForKey:USER_HOBBY];
    
    NSString *flag = [ud objectForKey:UserUUIDFlag];
    
    //    //hobby =  %@", hobby);
    
    if (noviceTaskView5.length == 0&&token!=nil) {
        if (hobby.length==0 &&_noviceTimerCount_5!=0&& [flag intValue] == 1) {
            
            if ([_noviceTimer_5 isValid]) {
                [_noviceTimer_5 invalidate];
            }
            _noviceTimer_5 = [NSTimer weakTimerWithTimeInterval:MY_SEC target:self selector:@selector(timeGoMyStore) userInfo:nil repeats:YES];
        }
    }
    
}

- (void)timeGoMyStore
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    _noviceTimerCount_5--;
    //%@ = %d",NoviciateTaskFive, (int)_noviceTimerCount_5);
    if (_noviceTimerCount_5 == 0) {
        [ud setObject:@"noviceTaskView5" forKey:NoviciateTaskFive];
        [ud synchronize];
        [_noviceTimer_5 invalidate];
        
        self.noviceTaskView = [[TFNoviceTaskView alloc] init];
        [self.noviceTaskView returnClick:^(NSInteger type) {
            
            //去吐槽
            _noviceTimerCount_11 = 55;
            [self noviceTaskView11];
            
            Mtarbar.selectedIndex = 0;
            
        } withCloseBlock:^(NSInteger type) {
            //去吐槽
            _noviceTimerCount_11 = 55;
            [self noviceTaskView11];
            
        }];
        [self.noviceTaskView showWithType:@"4"];
    }
}
#pragma mark ------------------5-------------------

#pragma mark - 新手任务11 (去吐槽/不去了)
- (void)noviceTaskView11
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *token = [ud objectForKey:USER_TOKEN];
    NSString *goFeedbackFlag = [ud objectForKey:UserShowFlag];
    if (token!=nil && [goFeedbackFlag intValue] == 1 && _noviceTimerCount_11!=0) { //用户登录并且第二次打开APP
        
        if ([_noviceTimer_11 isValid]) {
            [_noviceTimer_11 invalidate];
        }
        _noviceTimer_11 = [NSTimer weakTimerWithTimeInterval:MY_SEC target:self selector:@selector(timeGoFeedback) userInfo:nil repeats:YES];
        
    }
}

- (void)timeGoFeedback
{
    _noviceTimerCount_11--;
    //去吐槽/不去了 = %d",(int)_noviceTimerCount_11);
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    
    if (_noviceTimerCount_11 == 0) {
        
        [ud setBool:NO forKey:UserShowFlag]; //不用弹出了
        [_noviceTimer_11 invalidate];
        
        self.noviceTaskView = [[TFNoviceTaskView alloc] init];
        [self.noviceTaskView returnClick:^(NSInteger type) {
            
            //type = %d", (int)type);
            if (type == 11) {
                //去吐槽
                TFFeedBackViewController *tffVC = [[TFFeedBackViewController alloc] init];
                tffVC.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:tffVC animated:YES];
            } else if (type == 511) {
                //不去了
            }
            
        } withCloseBlock:^(NSInteger type) {
            
        }];
        [self.noviceTaskView showWithType:@"11"];
    }
}

- (void)pageTabBarState:(TYPageTabBarState)state
{
//    MyLog(@"store state: %lu", (unsigned long)state);
    
    if (state == TYPageTabBarStateStopOnTop ||state == TYPageTabBarStateScrolling) {
        if (_delegateFlags.storeTitleTopStatus) {
            [self.shopStoreDelegate storeTitleTopStatus:YES];
        }
    } else {
        if (_delegateFlags.storeTitleTopStatus) {
            [self.shopStoreDelegate storeTitleTopStatus:NO];
        }
    }
}

- (TFTopShopsVM *)topShopsVM
{
    if (!_topShopsVM) {
        _topShopsVM = [[TFTopShopsVM alloc] init];
    }
    return _topShopsVM;
}

#pragma mark - 热图
- (UICollectionView *)hotCollectionView
{
    if (!_hotCollectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.minimumInteritemSpacing = 10;
        flowLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;

        _hotCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, self.topImageHeight, CGRectGetWidth(_slidePageScrollView.frame), self.hotImageHeight) collectionViewLayout:flowLayout];
        _hotCollectionView.delegate = self.topShopsVM.hotService;
        _hotCollectionView.dataSource = self.topShopsVM.hotService;
        _hotCollectionView.scrollsToTop = NO;
        _hotCollectionView.backgroundColor = [UIColor whiteColor];
        _hotCollectionView.showsHorizontalScrollIndicator = NO;
        
        
        /**< 必须要先注册 */
        [_hotCollectionView registerClass:[TFHotServiceCell class] forCellWithReuseIdentifier:@"TFHotServiceCellId"];
        
        [self.topShopsVM.hotService sizeForItemAtIndexPathBlock:^CGSize(UICollectionView *collectionView, UICollectionViewLayout *collectionViewLayout, NSIndexPath *indexPath) {
            CGSize size = CGSizeMake(self.hotImageHeight-20, self.hotImageHeight-20);
            return size;
        }];
        
        [self.topShopsVM.hotService cellForItemAtIndexPathBlock:^UICollectionViewCell *(UICollectionView *collectionView, NSIndexPath *indexPath) {
            TFShoppingM *model = self.topShopsVM.hotService.dataSource[indexPath.item];
            TFHotServiceCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TFHotServiceCellId" forIndexPath:indexPath];
            NSURL *imgUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@!280",[NSObject baseURLStr_Upy],model.url]];
            
            [cell.imageV setImageWithURL:imgUrl placeholderImage:[UIImage imageDefaultWithSize:CGSizeMake(self.hotImageHeight-20, self.hotImageHeight-20)] progress:^(float downloaderProgress) {
            } completed:^{
            }];
            
            return cell;
        }];
        
        [self.topShopsVM.hotService didSelectItemAtIndexPathBlock:^(UICollectionView *collectionView, NSIndexPath *indexPath) {
            TFShoppingM *model = self.topShopsVM.hotService.dataSource[indexPath.item];
            
            NSInteger index = indexPath.item;
            NSString *typeName = [NSString stringWithFormat:@"风格%ld", (long)index+1];
            [TFStatisticsClickVM handleDataWithPageType:nil withClickType:typeName success:nil failure:nil];
            
            [DataManager sharedManager].outAppStatistics = [NSString stringWithFormat:@"%@列表页",typeName];
            
            NSString *shopcode = model.shop_code;
            if ([shopcode hasPrefix:@"type2"]) {
                NSArray *typeArr = [shopcode componentsSeparatedByString:@"="];
                NSString *idStr = [typeArr lastObject];
                
                SqliteManager *manager = [SqliteManager sharedManager];
                ShopTypeItem *item = [manager getShopTypeItemForId:idStr];
                NSString *ID = item.ID;
                NSString *title = item.type_name;
                
                if (ID != nil) {
                    NSNumber *type1=[self.typeIndexArray[_slidePageScrollView.pageTabBar.index]objectForKey:@"id"];
                    NSString *type_name=[self.typeIndexArray[_slidePageScrollView.pageTabBar.index]objectForKey:@"name"];
                    
                    TFSearchViewController *svc = [[TFSearchViewController alloc] init];
                    svc.parentID = ID;
                    svc.shopTitle = title;
                    svc.dataStatistics = typeName;
                    svc.typeID = type1;
                    svc.typeName = type_name;
                    
                    svc.hidesBottomBarWhenPushed=YES;
                    [self.navigationController pushViewController:svc animated:YES];
                }
            } else {
                TFScreenViewController *screen = [[TFScreenViewController alloc]init];
                screen.dataStatistics = typeName;
                screen.muStr = shopcode;
                screen.index = 1;
                screen.titleText = model.shop_name;
                if (!model.shop_name.length) {
                    screen.titleText = @"筛选结果";
                }
                screen.hidesBottomBarWhenPushed=YES;
                [self.navigationController pushViewController:screen animated:YES];
            }

        }];
        
    }
    return _hotCollectionView;
}

- (void)setCurrPageViewController:(NSInteger)currPageViewController
{
    _currPageViewController = currPageViewController;
    [self setCurrPageIndex:currPageViewController];
}

- (void)setCurrPageIndex:(NSInteger)currPage
{
    if (self.slidePageScrollView && self.nTitleView &&( currPage <= self.shopTypeNameArray.count-1)) {
        [self.nTitleView switchToPageIndex:(int)currPage];
        [self.nTitleView.customTitleViewDelegate selectEndWithView:self.nTitleView withBtnIndex:(int)currPage];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 悬浮红包
 */
- (void)xuanfuHongBaoView
{
    if(self.hongbaoview == nil)
    {
        self.hongbaoview = [[RedXuanfuHongBao alloc]initWithFrame:CGRectMake(kScreen_Width-78, kScreen_Height-(kTabBarHeight+ZOOM6(320)), 70,70) isShouYeThree:NO];
        [self.view addSubview:self.hongbaoview];
    }else{
        [self.hongbaoview refreshXuanfuImage];
    }
    
    kWeakSelf(self);
    self.hongbaoview.lingHongBaoBlock = ^(BOOL isNewUser) {
        
//        if(isNewUser)//没有交易记录用户
//        {
//            ShouYeShopStoreViewController *vc = [[ShouYeShopStoreViewController alloc] init];
//            vc.hidesBottomBarWhenPushed = YES;
//            vc.isHeadView = YES;
//            vc.isFootView = NO;
//            vc.isVseron = YES;
//            [weakself.navigationController pushViewController:vc animated:YES];
//        }else{
//            MakeMoneyViewController *vc = [[MakeMoneyViewController alloc] init];
//            vc.hidesBottomBarWhenPushed = YES;
//            [weakself.navigationController pushViewController:vc animated:YES];
//        }
        MakeMoneyViewController *vc = [[MakeMoneyViewController alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [weakself.navigationController pushViewController:vc animated:YES];
    };
    
}
/**
 新人红包
 */
- (void)RedhongBao
{
    kWeakSelf(self);
    [hongBaoModel GetDataSuccess:^(id  _Nonnull data) {
        hongBaoModel *model = data;
        if(model.status == 1)
        {
            NSNumber* homePage3FirstTime = model.data[@"homePage3FirstTime"];
            NSNumber* homePage3ElastTime = model.data[@"homePage3ElasticFrame"];
            self.ElastTime = [homePage3ElastTime doubleValue];
            
            //第一次弹出时间
            [weakself performSelector:@selector(creatRedHongBaoview) withObject:nil afterDelay:homePage3FirstTime.doubleValue];
        }
    }];
    
    
}
- (void)creatRedHongBaoview
{
    self.redhongbaoview = [[TixianRedHongbao alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width,kScreen_Height) Nextpop:self.ElastTime];
    kWeakSelf(self);
    self.redhongbaoview.lingHongBaoBlock = ^(BOOL isNewUser) {
        
        MakeMoneyViewController *vc = [[MakeMoneyViewController alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [weakself.navigationController pushViewController:vc animated:YES];
    };
    
    self.redhongbaoview.closeHongBaoBlack = ^(double lastTime) {
        NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:USER_TOKEN];
        if(token.length >10)
        {
            return ;
        }
    };
    [self.view addSubview:self.redhongbaoview];
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