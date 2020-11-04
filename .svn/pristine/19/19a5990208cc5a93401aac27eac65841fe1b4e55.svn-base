//
//  TFShoppingViewController.m
//  YunShangShiJi
//
//  Created by jingaiweiyi on 16/6/16.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import "TFShoppingViewController.h"
#import "TFShopStoreViewController.h"
#import "TFSaleShopViewController.h"
#import "TFMyWalletViewController.h"
#import "TFPublicClass.h"
#import "SqliteManager.h"
#import "TFSearchViewController.h"
#import "FMDBSearchManager.h"
#import "TFScreeningBackgroundView.h"
#import "LoginViewController.h"

#import "TFLoginView.h"
#import "YFDoubleSucessVC.h"
#import "TFShopCartVM.h"
#import "NSDate+Helper.h"
#import "DoubleModel.h"
#import "TopRemindView.h"
#import "AppDelegate.h"
#import "DataManager.h"
#import "GoldCouponsManager.h"
#import "VitalityTaskPopview.h"
#import "NewProductViewController.h"
#import "TFLedBrowseCollocationShopVC.h"
#import "TFWXWithdrawalsDescriptionVC.h"
#import "TFActivityShopVC.h"
#import "TFWXWithdrawalsCheckVC.h"
#import "CollocationVC.h"
#import "TFLedBrowseShopViewController.h"
#import "TFCollocationViewController.h"
#import "TFExpViewController.h"
#import "TFCashSuccessViewController.h"
#import "TFGroupBuysVC.h"
#import "TFMoreTopicsVC.h"
#import "TFClassifyVC.h"
#import "MakeMoneyViewController.h"
#import "SearchTypeViewController.h"
#import "PYSearchViewController.h"
#import "RecommendRemindView.h"
#import "SelectPhotoViewController.h"
#import "SelectHobbyViewController.h"
#import "ShouYeShopStoreViewController.h"
#import "RecommendModel.h"
#import "BoundPhoneVC.h"
#import "OneYuanModel.h"

#import "FreeOrderPopview.h"
#import "TaskCollectionVC.h"
#import "CrazyMondayActivityVC.h"
#import "ShareAnimationView.h"
#import "TopicPublicModel.h"
#import "CrazyStyleViewController.h"
#import "FinishTaskPopview.h"
#import "RedXuanfuHongBao.h"
#import "TixianRedHongbao.h"
#import <ShareSDKCoreService/ShareSDKCoreService.h>
#import <ShareSDK/ShareSDKPlugin.h>
#import <ShareSDK/ShareSDK.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import <TencentOpenAPI/TencentOAuth.h>
#import <QZoneConnection/ISSQZoneApp.h>

@interface TFShoppingViewController () <UISearchBarDelegate,UISearchDisplayDelegate, UITableViewDelegate, UITableViewDataSource, TFShopStoreDelegate, TFSaleDelegate, TFScreeningBackgroundDelegate,PYSearchViewControllerDelegate>
/**
 *  变量
 */
{
    CGPoint openPointCenter;
    int _timeCount;
    BOOL firstGo;
    
    RecommendRemindView *Recommendview; //精选推荐
    ShareAnimationView *_aView;
}

/**
 *  控制器
 */
@property (nonatomic, strong) TFShopStoreViewController *subVC_A;
@property (nonatomic, strong) TFSaleShopViewController *subVC_B;
@property (nonatomic ,strong) UIViewController *currentVC;
@property (nonatomic, strong) RedXuanfuHongBao * hongbaoview;

/**
 *  视图
 */
@property (nonatomic, strong) UIView                *contentBackgroundView;
@property (nonatomic, strong) UIView                *leftHandView;
@property (nonatomic, strong) UIView                *searchRightView;
@property (nonatomic, strong ) UIImageView               *navigationView;
@property (nonatomic, strong ) UISearchBar               *searchBar;
@property (nonatomic, strong ) UIButton                  *searchBtn;
@property (nonatomic, strong ) UIButton                  *screenBtn;


@property (nonatomic, strong ) UIButton                  *leftButton;
@property (nonatomic, strong ) UIButton                  *rightButton;

@property (nonatomic, strong ) UIButton                  *shoppingCartBtn;
@property (nonatomic, strong ) UITableView               *searchTableView;
@property (nonatomic, strong ) TFScreeningBackgroundView *screeningScrollView;
@property (nonatomic, strong ) UILabel *shoppingCartLabel;
@property (nonatomic, strong ) UISegmentedControl *segControl;
/**
 *  数据
 */
@property (nonatomic, assign ) BOOL                      isOpen;
@property (nonatomic, assign ) BOOL                      isScrAnimationFinished;
@property (nonatomic, strong) NSMutableArray *searchDataArray;
@property (nonatomic, strong) NSMutableArray *searchCateArray;

@property (nonatomic, strong) NSMutableArray *screenCateArray;
@property (nonatomic, strong) NSMutableArray *screenDataArray;
@property (nonatomic, strong) NSMutableArray *searchHisArray;
@property (nonatomic, assign ) NSInteger                 searchStatus;
@property (nonatomic, copy   ) NSString                  *searchText;
@property (nonatomic, assign) NSInteger currTitlePage;
@property (nonatomic, strong) NSDictionary *currTitlePageTypeParms;
@property (nonatomic, assign) BOOL isViewDidLoad;
@property (nonatomic, strong) VitalityTaskPopview *vitalityview;
@end



@implementation TFShoppingViewController

- (void)dealloc
{
    if (self.netStatusBlock) {
        [[NSNotificationCenter defaultCenter] removeObserver:self name:netStatusNotificationCenter object:nil];
    }
}
- (instancetype)initWithFiristGo {
    if (self = [super init]) {
        firstGo = YES;
    }
    return self;
}
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
            }
        }
    }];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.isViewDidLoad = YES;

   //    [self firstGoToMakeMoney];
    
    //赚钱任务按钮隐藏
    [self httpMakeMoneyShow:^{
        [DataManager sharedManager].is_MakeMoneyHiden = YES;
        _rightButton.hidden = YES;
    } Fail:^{
        
    }];
    
    //落地页
    if([DataManager sharedManager].Startpage == YES)
    {
        [self getShouyeHttp];//暂停运营后面打开
        [DataManager sharedManager].Startpage = NO;
    }else{
        [DataManager sharedManager].shouYeGround = 0;
    }
    
}

- (void)setupUIAndSetData
{
    [self setData];
    
    [self setupUI];
}

- (void)setData
{
    if (self.selcetedControllerType != CurrSelectedControllerType_A && self.selcetedControllerType != CurrSelectedControllerType_B) {
        self.selcetedControllerType = CurrSelectedControllerType_A;
    }
}

- (void)setupUI
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationController.navigationBar.hidden = YES;
    
    [self createContentBackgroundView];
    
    [self addViewController];
    
//    [self xuanfuHongBaoView];
//
//    [self RedhongBao];
    
    self.pushCome?[self creatHeadView]:[self setNavigationItem];
    
    //查看精选推荐浏览守时间（今天浏览完就不能在浏览）
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSDate *record = [user objectForKey:FINISHRECOMMENDPOPDATE];
    if(![[MyMD5 compareDate:record] isEqualToString:@"今天"] || record==nil )
    {
         [self addOtherView];
    }
   
    ESWeak(self, ws);
    [self netStatusBlock:^(NetworkStates networkState) {
        if (networkState != NetworkStatesNone) {
            
            NSString *token = [TFPublicClass getTokenFromLocal];
            if (token.length) {
                [self httpGetShopCartCount];
            }
            
//            NavgationbarView *nv = [[NavgationbarView alloc] init];
//            [nv showLable:@"网络已经恢复，请刷新" Controller:ws];
        } else {
            NavgationbarView *nv = [[NavgationbarView alloc] init];
            [nv showLable:@"网络已断开，请重新连接" Controller:ws];
        }
    }];
    
    [TFStatisticsClickVM handleDataWithPageType:nil withClickType:@"app初始启动" success:nil failure:nil];
}


#pragma mark 获取赚钱页是否隐藏
- (void)httpMakeMoneyShow:(void(^)())success Fail:(void(^)())fail
{

    NSString *apistr = [NSString stringWithFormat:@"cfg/getlandingPage8778?appVersion=%@&",[DataManager sharedManager].appversion];
    [[APIClient sharedManager]netWorkGeneralRequestWithApi:apistr caches:NO cachesTimeInterval:0 token:YES success:^(id data, Response *response) {
        if (response.status == 1) {
            if([data[@"data"] integerValue] == 1)//data 0不隐藏 1隐藏
            {
                if(success)
                {
                    success();
                }
            }else{
                if(fail)
                {
                    fail();
                }
            }
        }else{
            if(fail)
            {
                fail();
            }
        }
    } failure:^(NSError *error) {
        if(fail)
        {
            fail();
        }
    }];
}

- (void)addViewController
{
    TFShopStoreViewController *subVC_A = [[TFShopStoreViewController alloc] init];
    subVC_A.isHeadView = YES;
    subVC_A.isFootView = YES;
    subVC_A.shopStoreDelegate = self;
    subVC_A.isHeadView = YES;
    subVC_A.isFootView = YES;
    subVC_A.currPageViewController = self.currPageViewController;
    _subVC_A = subVC_A;
    
    TFSaleShopViewController *subVC_B = [[TFSaleShopViewController alloc] init];
    subVC_B.saleDelegate = self;
    _subVC_B = subVC_B;

    if (self.selcetedControllerType == CurrSelectedControllerType_A) {
        [self addChildViewController:self.subVC_A];
        [self.contentBackgroundView addSubview:self.subVC_A.view];
        self.currentVC  = self.subVC_A;

    } else {
        [self addChildViewController:self.subVC_B];
        [self.contentBackgroundView addSubview:self.subVC_B.view];
        self.currentVC  = self.subVC_B;
    }
}

- (void)createContentBackgroundView
{
    self.contentBackgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    self.contentBackgroundView.backgroundColor = RGBCOLOR_I(240, 240, 240);
    [self.view addSubview:self.contentBackgroundView];
    
    UIImage *image = [UIImage imageNamed:@"shopping_mengcen"];
    image = [image stretchableImageWithLeftCapWidth:image.size.width * 0.5 topCapHeight:image.size.height * 0.5];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, Height_NavBar)];
    imageView.image = image;
    [self.contentBackgroundView addSubview:imageView];
}

- (void)creatHeadView
{
    //导航条
    UIImageView *headview=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kApplicationWidth, Height_NavBar)];
    [self.view addSubview:headview];
    headview.userInteractionEnabled=YES;
    
    UIButton *backbtn=[UIButton buttonWithType:UIButtonTypeCustom];
    backbtn.frame=CGRectMake(0, Height_StatusBar-58, 44, 44);
    backbtn.centerY = View_CenterY(headview);
    [backbtn setImage:[UIImage imageNamed:@"返回按钮_正常"] forState:UIControlStateNormal];
    [backbtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [headview addSubview:backbtn];
    
    UILabel *titlelable=[[UILabel alloc]init];
    titlelable.frame=CGRectMake(0, 0, 300, 40);
    titlelable.center=CGPointMake(kApplicationWidth/2, headview.frame.size.height/2+10);
    titlelable.text=@"首页";
    titlelable.font=kNavTitleFontSize;
    titlelable.textColor=kMainTitleColor;
    titlelable.textAlignment=NSTextAlignmentCenter;
    [headview addSubview:titlelable];
    
    
//    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 63, kScreenWidth, 1)];
//    lineView.backgroundColor = RGBCOLOR_I(220,220,220);
//    [self.view addSubview:lineView];
}
- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)setNavigationItem
{
    self.navigationView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, Height_NavBar)];
//    self.navigationView.backgroundColor = [UIColor clearColor];
    self.navigationView.image=[UIImage imageNamed:@"zhezhao"];
    self.navigationView.userInteractionEnabled=YES;
    [self.contentBackgroundView addSubview:self.navigationView];

    
    UISearchBar *searchBar = [[UISearchBar alloc] init];
    searchBar.backgroundColor = [UIColor clearColor];
    searchBar.delegate = self;
    searchBar.alpha=0.9f;
    [searchBar setBackgroundImage:[UIImage imageWithColor:[UIColor clearColor]]];
//    searchBar.searchBarStyle = UISearchBarStyleMinimal;
    UITextField *searchField = [searchBar valueForKeyPath:@"searchField"];
//    searchField.backgroundColor = RGBCOLOR_I(240, 240, 240);
//    UILabel *sbPlaceholderLabel = [searchField valueForKey:@"placeholderLabel"]; //然后取出textField的placeHolder
//    sbPlaceholderLabel.backgroundColor = RGBCOLOR_I(240, 240, 240);
//    sbPlaceholderLabel.textColor = [UIColor redColor]; //改变颜色
//    searchBar.placeholder = @"元气少女连衣裙";
    [self setSearchBarPlaceholder];
    [self.navigationView addSubview:_searchBar = searchBar];

    /**< leftButton */
    UIImage *leftImage = [UIImage imageNamed:@"shopping_icon_fenlei_white"];
    CGFloat H_btn = kNavigationBar_Height;
    CGFloat left_W = H_btn * leftImage.size.height / leftImage.size.width;
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftButton setImage:leftImage forState:UIControlStateNormal];
    [self.navigationView addSubview:_leftButton = leftButton];
    
    [leftButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.navigationView.mas_left).offset(0);
        make.size.mas_equalTo(CGSizeMake(left_W, H_btn));
        make.centerY.equalTo(self.navigationView.mas_centerY).offset(10);
    }];
    
    kSelfWeak;
    [leftButton handleClickEvent:UIControlEventTouchUpInside withClickBlock:^(UIButton *sender) {
        
        TFClassifyVC *vc = [[TFClassifyVC alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [weakSelf.navigationController pushViewController:vc animated:YES];
    }];
    
    /**< rightButton */
    UIImage *rightImage = [UIImage imageNamed:@"shopping_icon_zhuanqian_white"];
    CGFloat right_W = H_btn * rightImage.size.height / rightImage.size.width;
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightButton setImage:rightImage forState:UIControlStateNormal];
    [self.navigationView addSubview:_rightButton = rightButton];
    
    //动效
//    _aView = [[ShareAnimationView alloc] initWithFrame:CGRectMake(10, 10, 0, 0)];
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *token = [ud objectForKey:USER_TOKEN];
    
    if(token.length > 10)
    {
        [_rightButton addSubview:self.aView];
    }
    
    [self httpMakeMoneyShow:^{
        [DataManager sharedManager].is_MakeMoneyHiden = YES;
        _rightButton.hidden = YES;
    } Fail:^{
    
    }];
    
    [rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.navigationView.mas_right).offset(0);
        make.size.mas_equalTo(CGSizeMake(right_W, H_btn));
        make.centerY.equalTo(self.navigationView.mas_centerY).offset(10);
    }];
    [rightButton handleClickEvent:UIControlEventTouchUpInside withClickBlock:^(UIButton *sender) {
        sender.userInteractionEnabled = NO;
        kSelfStrong;
        NSString *currTime = [MyMD5 getCurrTimeString:@"year-month-day"];
        [[NSUserDefaults standardUserDefaults] setObject:currTime forKey:ShareAnimationTime];
        [strongSelf -> _aView animationStart:NO];

        MakeMoneyViewController *vc = [[MakeMoneyViewController alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [weakSelf.navigationController pushViewController:vc animated:YES];
    }];
    [searchBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(leftButton.mas_right);
        make.right.equalTo(rightButton.mas_left);
        make.centerY.equalTo(self.navigationView.mas_centerY).offset(10);
        make.height.mas_equalTo(44);
    }];
}

- (ShareAnimationView*)aView{
    if(_aView == nil)
    {
        _aView = [[ShareAnimationView alloc] initWithFrame:CGRectMake(10, 10, 0, 0)];
    }
    return _aView;
}
/**
 悬浮红包
 */
- (void)xuanfuHongBaoView
{
    self.hongbaoview = [[RedXuanfuHongBao alloc]initWithFrame:CGRectMake(kScreen_Width-78, kScreen_Height-(kTabBarHeight+ZOOM6(300)), 70,70) isShouYeThree:NO];
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
    [self.contentBackgroundView addSubview:self.hongbaoview];
}
/**
 新人红包
 */
- (void)RedhongBao
{
    TixianRedHongbao * hongbaoview = [[TixianRedHongbao alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width,kScreen_Height)];
    kWeakSelf(self);
    hongbaoview.lingHongBaoBlock = ^(BOOL isNewUser) {
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
    [self.contentBackgroundView addSubview:hongbaoview];
}
/**
 精选 和 200款
 */
- (void)addOtherView {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.contentBackgroundView addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentBackgroundView.mas_right).offset(-ZOOM6(25));
        make.bottom.equalTo(self.contentBackgroundView.mas_bottom).offset(-kTabBarHeight-ZOOM6(60));
        make.size.mas_equalTo(CGSizeMake(ZOOM6(110), ZOOM6(110)));
    }];
    button.tag = 89898989;
    [button setBackgroundImage:[UIImage imageNamed:@"shopping_200kuan"] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:@"shopping_jingxuan"] forState:UIControlStateSelected];
    __block BOOL is200 = YES;
    [NSTimer weakTimerWithTimeInterval:1 target:self userInfo:nil repeats:YES block:^(id target, NSTimer *timer) {
        is200 = ! is200;
        if (is200) {
            button.selected = NO;
        } else {
            button.selected = YES;
        }
    }];
    
    [button handleClickEvent:UIControlEventTouchUpInside withClickBlock:^(UIButton *sender) {
        if (!sender.selected) {
            MyLog(@"200");
            [self loginSuccess:^{
                 [self bindingPhone:YES];
            }];
           
        } else {
            MyLog(@"精选");
            
            [self loginSuccess:^{
                [self bindingPhone:YES];
            }];

        }
    }];
    
}


- (void)selectBtnEnd:(TFScreeningBackgroundView *)screeningBackgroundView withChooseArray:(NSArray *)chooseArray
{
    [MobClick event:SHOP_TIJIAO];
    
    //
    
    [TFStatisticsClickVM handleDataWithPageType:nil withClickType:@"喜好筛选“提交”" success:nil failure:nil];
    
    [DataManager sharedManager].outAppStatistics = [NSString stringWithFormat:@"%@",@"自定义喜好筛选结果列表页"];
    
//   MyLog(@"chooseArray = %@",chooseArray);
    
    if (chooseArray.count!=0) {
        [self httpScreeningRequest:chooseArray];
        [MBProgressHUD showMessage:@"正在筛选" toView:self.screeningScrollView];
    } else {
        [MBProgressHUD showError:@"亲,请至少选择一项吧"];
    }

}

- (void)createTableData
{
    SqliteManager *manager = [SqliteManager sharedManager];
    NSArray *typeArray = [manager getShopTypeItemForSuperId:@"0"];

    
    NSMutableArray *tmpArr = [NSMutableArray array];
    NSMutableArray *muTypeArr = [NSMutableArray arrayWithArray:typeArray];
    NSArray *sortArr = nil;
    for (ShopTypeItem *item in muTypeArr) {
        if ([item.type_name isEqualToString:@"特卖"] || [item.type_name isEqualToString:@"热卖"] || [item.type_name isEqualToString:@"上新"] ) {
            [tmpArr addObject:item];
        }
    }
    [muTypeArr removeObjectsInArray:tmpArr];
    sortArr = [manager sortShopTypeArrayWithSequenceFromSourceArray:muTypeArr];
    self.searchCateArray = [NSMutableArray arrayWithArray:sortArr];
    
    if (self.searchCateArray.count!=0) {

        for (ShopTypeItem *item in self.searchCateArray) {
            NSString *superID = item.ID;
            NSArray *array = [manager getShopTypeItemForSuperId:superID];
            [self.searchDataArray addObject:array];
        }
    }
}

- (void)setCurrPageViewController:(NSInteger)currPageViewController
{
//    _currPageViewController = currPageViewController;
    
//    [self setShopStoreCurrPageViewController:currPageViewController];
}

- (void)setShopStoreCurrPageViewController:(NSInteger)currPageViewController
{
    self.segControl.selectedSegmentIndex = 0;

    for (UIViewController *vc in self.childViewControllers) {
        if ([vc isKindOfClass:[TFShopStoreViewController class]]) {
            TFShopStoreViewController *shopVC = (TFShopStoreViewController *)vc;
            shopVC.currPageViewController = currPageViewController;
        }
    }
}


#pragma mark - delegate
- (void)titlePageToIndex:(NSInteger)index withTitleShopType:(NSDictionary *)typeParms
{
    MyLog(@"typeParms: %@", typeParms);
    NSString *typeName = [typeParms objectForKey:@"name"];
    [TFStatisticsClickVM handleDataWithPageType:nil withClickType:typeName success:nil failure:nil];
    
    if ([typeName isEqualToString:@"搭配"]) {
        [DataManager sharedManager].outAppStatistics = @"主界面（顶部购物+搭配）";
    } else {
         [DataManager sharedManager].outAppStatistics = [NSString stringWithFormat:@"%@列表页", typeName];
    }
    
    self.currTitlePage = index;
    self.currTitlePageTypeParms = typeParms;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (self.searchStatus == 0) {
        return self.searchDataArray.count;
    } else if (self.searchStatus == 1) {
        return 1;
    }
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (self.searchStatus == 0) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 25)];
        label.font = [UIFont systemFontOfSize:16];
        label.textColor = RGBCOLOR_I(167,167,167);
        label.backgroundColor = RGBCOLOR_I(22,22,22);
        label.font = kFont6px(32);
        if (self.searchCateArray.count>section) {
            ShopTypeItem *item = self.searchCateArray[section];
            label.text = [NSString stringWithFormat:@"    %@",item.type_name];
        }
        return label;
    } else if (self.searchStatus == 1) {
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 25)];
        label.font = [UIFont systemFontOfSize:16];
        label.textColor = RGBCOLOR_I(167,167,167);
        label.backgroundColor = RGBCOLOR_I(22,22,22);
        label.font = kFont6px(32);
        label.text = [NSString stringWithFormat:@"    %@",@"历史搜索"];
        return label;
        
    }
    return 0;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.searchStatus == 0) {
        return [self.searchDataArray[section] count];
    } else if (self.searchStatus == 1) {
        return self.searchHisArray.count;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return ZOOM(80);
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.searchStatus == 0) {
        return ZOOM(150);
    } else if (self.searchStatus == 1) {
        return ZOOM(100);
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.searchStatus == 0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CELLID"];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CELLID"];
            cell.backgroundColor = RGBCOLOR_I(22,22,22);
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectMake(ZOOM(62), (CGRectGetHeight(cell.frame)-ZOOM(100))/2, ZOOM(67), ZOOM(100))];
            iv.tag = 500;
//        iv.contentMode = UIViewContentModeScaleAspectFit;
            [cell.contentView addSubview:iv];
            
            UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(iv.frame.origin.x+iv.frame.size.width+ZOOM(62), 0, ZOOM(300), CGRectGetHeight(cell.frame))];
            titleLabel.tag = 501;
            titleLabel.textColor = [UIColor whiteColor];
            titleLabel.font = kFont6px(34);
            [cell.contentView addSubview:titleLabel];
            
            UIImageView *iiv = [[UIImageView alloc] initWithFrame:CGRectMake(tableView.frame.size.width-ZOOM(62)-ZOOM(27), (CGRectGetHeight(cell.frame)-ZOOM(55))/2, ZOOM(27), ZOOM(55))];
            iiv.image = [UIImage imageNamed:@"搜索更多"];
            iiv.contentMode = UIViewContentModeScaleAspectFit;
            [cell.contentView addSubview:iiv];
        }
        UIImageView *iv = (UIImageView *)[cell.contentView viewWithTag:500];
        UILabel *titleLabel = (UILabel *)[cell.contentView viewWithTag:501];
        
        ShopTypeItem *item = [self.searchDataArray[indexPath.section] objectAtIndex:indexPath.row];
        [iv sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", [NSObject baseURLStr_Upy], item.ico]]];
        
//        MyLog(@"img: %@", [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", [NSObject baseURLStr_Upy], item.icon]]);
        
        titleLabel.text = item.type_name;
        return cell;
    } else if (self.searchStatus == 1) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CELLHISID"];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CELLHISID"];
            cell.backgroundColor = RGBCOLOR_I(22,22,22);
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.searchTableView.frame), CGRectGetHeight(cell.frame))];
            label.textAlignment = NSTextAlignmentCenter;
            label.font = [UIFont systemFontOfSize:ZOOM(50)];
            label.textColor = [UIColor whiteColor];
            label.tag = 200;
            [cell.contentView addSubview:label];
        }
        UILabel *label = (UILabel *)[cell.contentView viewWithTag:200];
        SearchItem *item = self.searchHisArray[indexPath.row];
        label.text = item.searchText;
        
        if (indexPath.row == self.searchHisArray.count-1) {
            label.textColor = COLOR_ROSERED;
        } else {
            label.textColor = [UIColor whiteColor];
        }
        
        return cell;
    }
    return 0;
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    [self.searchBar resignFirstResponder];
    
    if (self.searchStatus == 0) {
        ShopTypeItem *item = [self.searchDataArray[indexPath.section] objectAtIndex:indexPath.row];
        
        NSString *ID = item.ID;
        NSString *title = item.type_name;
        
        NSNumber *type1=[self.currTitlePageTypeParms objectForKey:@"id"];
        NSString *type_name=[self.currTitlePageTypeParms objectForKey:@"name"];
        
        //统计分发
        [self handleDataWithPageType:title];
        
        TFSearchViewController *svc = [[TFSearchViewController alloc] init];
        svc.parentID = ID;
        svc.dataStatistics = @"搜索结果商品点击";
        svc.shopTitle = title;
        svc.typeID = type1;
        
        ESWeakSelf;
        svc.MainViewStatusNormal = ^(){
            __weakSelf.searchBtn.selected = NO;
            [__weakSelf mainViewStatusNormal];
            if (__weakSelf.screenBtn.selected) {
                __weakSelf.tabBarController.tabBar.hidden = YES;
            }
        };
        
        svc.typeName = type_name;
        svc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:svc animated:YES];
    } else if (self.searchStatus == 1) {
        if (indexPath.row!=self.searchHisArray.count-1) {
            SearchItem *item = self.searchHisArray[indexPath.row];
            self.searchBar.text = item.searchText;
            [self searchBarSearchButtonClicked:self.searchBar];
        } else {
            FMDBSearchManager *manager = [FMDBSearchManager sharedManager];
            [manager deleteSearchDB];
            
            [self.searchHisArray removeAllObjects];
            [self.searchTableView reloadData];
        }
    }
}

- (void)handleDataWithPageType:(NSString*)type
{
    
    [TFStatisticsClickVM handleDataWithPageType:nil withClickType:type success:nil failure:nil];
    
    [DataManager sharedManager].outAppStatistics = [NSString stringWithFormat:@"%@列表页",type];

}
#pragma mark - 搜索按钮
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    
    return;
    
    
    [TFStatisticsClickVM handleDataWithPageType:nil withClickType:@"搜索下—输入后确定" success:nil failure:nil];
     [DataManager sharedManager].outAppStatistics = [NSString stringWithFormat:@"%@",@"搜索结果列表页"];
    
    //添加搜索的文本到历史
    SearchItem *item = [[SearchItem alloc] init];
    item.searchText = searchBar.text;
    BOOL bl = NO;
    FMDBSearchManager *manager = [FMDBSearchManager sharedManager];
    NSArray *itemArray = [manager getAllSearchItem];
    for (SearchItem *itemTemp in itemArray) {
        if ([itemTemp.searchText isEqualToString:searchBar.text]) {
            bl = YES;
        }
    } if (bl == NO) {
        [manager addSearchItem:item];
    }
    
    //开始搜索 = %@",searchBar.text);
    
    SqliteManager *sManager = [SqliteManager sharedManager];
    ShopTypeItem *sItem = [sManager getShopTypeItemFromShopTypeWithName:searchBar.text];
    
    MyLog(@"sItem: %@", sItem);
    
    NSString *typeID = sItem.ID;
    self.searchBtn.selected = YES;
//    self.screenBtn.selected = NO;
    [self.searchBar resignFirstResponder];
    
    
    TFScreenViewController *svc = [[TFScreenViewController alloc] init];
    svc.dataStatistics = @"搜索下—输入后确定";
    svc.index = 0;
    if ([typeID isEqualToString:searchBar.text]) {
        svc.muStr = searchBar.text;
    } else { //类型
//        svc.type2 = typeID;
        svc.muStr = searchBar.text;
        
    }
    ESWeakSelf;
    svc.MainViewStatusNormal = ^(){
        __weakSelf.searchBtn.selected = NO;
        [__weakSelf mainViewStatusNormal];
        if (__weakSelf.screenBtn.selected) {
            __weakSelf.tabBarController.tabBar.hidden = YES;
        }
    };
    svc.titleText = self.searchBar.text;
    svc.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:svc animated:YES];
    
}


- (BOOL)searchBar:(UISearchBar *)searchBar shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    //self.searchText = %@", self.searchText);
    //搜索当前输入文字: %@", text);
    
    return YES;
}
#pragma mark - PYSearchViewController
- (void)didClickCancel:(PYSearchViewController *)searchViewController {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)searchViewController:(PYSearchViewController *)searchViewController searchTextDidChange:(UISearchBar *)seachBar searchText:(NSString *)searchText
{
    if (searchText.length) { // 与搜索条件再搜索
        // 根据条件发送查询（这里模拟搜索）
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{ // 搜索完毕
            // 显示建议搜索结果
            NSMutableArray *searchSuggestionsM = [NSMutableArray array];
            [searchViewController.hotSearches enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if ([obj containsString:searchText]) {
                    [searchSuggestionsM addObject:obj];
                }
            }];
//            for (int i = 0; i < arc4random_uniform(5) + 10; i++) {
//                NSString *searchSuggestion = [NSString stringWithFormat:@"搜索建议 %d", i];
//                [searchSuggestionsM addObject:searchSuggestion];
//            }
            // 返回
            searchViewController.searchSuggestions = searchSuggestionsM;
        });
    }
}
- (void)searchToShopListView:(NSString *)text {
    TFScreenViewController *svc = [[TFScreenViewController alloc] init];
    svc.dataStatistics = @"搜索下—输入后确定";
    svc.index = 0;
    svc.muStr = text;
    svc.titleText = text;
    svc.currTitlePage = self.currTitlePage;
    [self.navigationController pushViewController:svc animated:YES];
}
- (void)setSearchBarPlaceholder {
    kSelfWeak;
    [SearchTypeModel httpGetSearchTypeModelSuccess:^(id data) {
        SearchTypeModel *model=data;
        if (model.status==1) {
            SqliteManager *manager = [SqliteManager sharedManager];
            HotModel *model2;
            if(model.hotTagList.count)
            {
                model2=model.hotTagList[0];
            }
            ShopTagItem *item = [manager getShopTagItemForId:model2.tag_id];
            weakSelf.searchBar.placeholder = item.tag_name;
        }else
            weakSelf.searchBar.placeholder = @"元气少女连衣裙";
    }];
}
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    PYSearchViewController *vc = [PYSearchViewController searchViewControllerWithHotSearches:nil searchBarPlaceholder:searchBar.placeholder didSearchBlock:^(PYSearchViewController *searchViewController, UISearchBar *searchBar, NSString *searchText) {
        // 开始搜索执行以下代码
        // 如：跳转到指定控制器
        //            [searchViewController.navigationController pushViewController:[[PYTempViewController alloc] init] animated:YES];
        [self searchToShopListView:searchText];
    }];
    NSString * path=[[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"PYSearchhistories.plist"];
    [vc setSearchHistories:[NSMutableArray arrayWithArray:[NSKeyedUnarchiver unarchiveObjectWithFile:path]]];
    vc.delegate=self;
    
    kSelfWeak;
    [SearchTypeModel httpGetSearchTypeModelSuccess:^(id data) {
        SearchTypeModel *model=data;
        if (model.status==1) {
            NSMutableArray *hotTitleArr=[NSMutableArray array];
            SqliteManager *manager = [SqliteManager sharedManager];
            for (HotModel *model1 in model.hotTagList) {
                ShopTagItem *item = [manager getShopTagItemForId:model1.tag_id];
                [hotTitleArr addObject: item.tag_name];
            }
            vc.hotSearches=[hotTitleArr copy];
            if(hotTitleArr.count)
            {
            vc.searchBar.placeholder=hotTitleArr[0];
            weakSelf.searchBar.placeholder=hotTitleArr[0];
            }
        }
    }];
    

    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
    
    return NO;
}

- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar
{
    //self.searchText = %@", self.searchText);
    //结束搜索");
    self.searchStatus = 0; //默认状态
    [self.searchTableView reloadData];
    
    return YES;
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    //self.searchText = %@", self.searchText);
    //搜索框文字: %@", searchText);
    self.searchText = searchText;
    if (self.searchText.length == 0) {
#pragma mark - 是否保留搜索纪录
        //        self.searchStatus = 1;
        //        [self.searchTableView reloadData];
    }
    
}

- (NSMutableArray *)searchCateArray
{
    if (!_searchCateArray) {
        _searchCateArray = [NSMutableArray array];
    }
    return _searchCateArray;
}

- (NSMutableArray *)searchDataArray
{
    if (!_searchDataArray) {
        _searchDataArray = [NSMutableArray array];
    }
    return _searchDataArray;
}

- (NSMutableArray *)searchHisArray
{
    if (_searchHisArray == nil) {
        _searchHisArray = [[NSMutableArray alloc] init];
    }
    return _searchHisArray;
}

- (NSMutableArray *)screenCateArray
{
    if (!_screenCateArray) {
        _screenCateArray = [NSMutableArray array];
    }
    return _screenCateArray;
}

- (NSMutableArray *)screenDataArray
{
    if (!_screenDataArray) {
        _screenDataArray = [NSMutableArray array];
    }
    return _screenDataArray;
}

#pragma mark - tabBar 设置
- (void)mainViewStatusNormal
{
    [self contentBackgroundViewStatusWithNormal];
    [self tabBarStatusWithNormal];
}

- (void)mainViewStatusToRight
{
    [self contentBackgroundViewStatusToRight];
    [self tabBarStatusToRight];
}

- (void)contentBackgroundViewStatusWithNormal
{
    self.contentBackgroundView.center = CGPointMake(openPointCenter.x-OPENCENTERX,openPointCenter.y);
}

- (void)contentBackgroundViewStatusToRight
{
    self.contentBackgroundView.center = openPointCenter;
    //    self.contentBackgroundView.frame = CGRectMake(OPENCENTERX, StatusTableHeight, kScreenWidth, self.contentBackgroundView.frame.size.height);
}
- (void)tabBarStatusWithNormal
{
//何波修改 2018-3-2
//    if(!self.pushCome)
//    {
//        Mtarbar.tabBar.frame = CGRectMake(0, kScreenHeight-Height_TabBar, self.tabBarController.tabBar.frame.size.width, Height_TabBar);
//    }
}

- (void)tabBarStatusToRight
{
    //    Mtarbar.tabBar.center = CGPointMake(kScreenWidth/2.0+OPENCENTERX, kScreenHeight-49);
    
//何波修改 2018-3-2
//    if(!self.pushCome)
//    {
//        Mtarbar.tabBar.frame=CGRectMake(OPENCENTERX, kScreenHeight-Height_TabBar, self.tabBarController.tabBar.frame.size.width, Height_TabBar);
//    }
}

- (void)tabBarStatusToBottom
{
////何波修改 2018-3-2
//    CGRect rect = Mtarbar.tabBar.frame;
//    rect.origin.x = 0;
//    rect.origin.y = kScreenHeight;
//    if(!self.pushCome)
//    {
//        Mtarbar.tabBar.frame = rect;
//    }
}

// 加载购物车商品数
- (void)httpGetShopCartCount
{
    [TFShopCartVM handleDataWithShopCartCountSuccess:^(TFShopCartM *model, Response *response) {
        if (response.status == 1) {
            
            if (response.isCaches) {
                NavgationbarView *nv = [[NavgationbarView alloc] init];
                [nv showLable:@"网络连接失败，请检查网络设置~" Controller:self];
            }
            
            self.shoppingCartLabel.hidden = NO;
            self.shoppingCartLabel.text = [NSString stringWithFormat:@"%@",model.cart_count];
            if([model.cart_count intValue] <1) {
                self.shoppingCartLabel.hidden = YES;
            }
        }
    } failure:^(NSError *error) {
        NavgationbarView *nv = [[NavgationbarView alloc] init];
        [nv showLable:@"网络连接失败，请检查网络设置~" Controller:self];
    }];
    
}

- (void)httpScreeningRequest:(NSArray *)arr
{
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *token = [ud objectForKey:USER_TOKEN];
    
    NSMutableString *muStr = [NSMutableString string];
    for (NSDictionary *dic in arr) {
        [muStr appendString:@"&"];
        [muStr appendString:dic[@"cate"]];
        [muStr appendString:@"="];
        [muStr appendString:dic[@"chac"]];
    }
    
    NSString *type1= [self.currTitlePageTypeParms objectForKey:@"id"];
    NSString *type_name = [self.currTitlePageTypeParms objectForKey:@"name"];
    
//    MyLog(@"type1: %@, type_name: %@", type1, type_name);
    
    if (type_name == nil || [type_name isEqualToString:@"搭配"]) {
        type1 = @"6";
        type_name = @"热卖";
    }
    
    NSString *urlStr;
    if(token != nil){
        urlStr = [NSString stringWithFormat:@"%@shop/fCondition?&pager.curPage=1&pager.pageSize=10&token=%@&version=%@%@&type1=%@&type_name=%@",[NSObject baseURLStr],token,VERSION,muStr,type1,type_name];
    }else
        urlStr = [NSString stringWithFormat:@"%@shop/queryConUnLogin?&pager.curPage=1&pager.pageSize=10&version=%@%@&type1=%@&type_name=%@",[NSObject baseURLStr],VERSION,muStr,type1,type_name];
    
    NSString *URL = [MyMD5 authkey:urlStr];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:URL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [MBProgressHUD hideHUDForView:self.screeningScrollView];
//        MyLog(@"responseObject: %@",responseObject);
        responseObject = [NSDictionary changeType:responseObject];
        if ([responseObject[@"status"] intValue] == 1) {
            [MBProgressHUD showSuccess:@"筛选成功"];
            NSArray *dataArr = responseObject[@"listShop"];
            NSMutableArray *muArr = [NSMutableArray array];
            for (NSDictionary *dic in dataArr) {
                ShopDetailModel *sModel = [[ShopDetailModel alloc] init];
                [sModel setValuesForKeysWithDictionary:dic];
                [muArr addObject:sModel];
            }
            
            TFScreenViewController *svc = [[TFScreenViewController alloc] init];
            svc.receiveArray = muArr;
            svc.muStr = muStr;
            svc.index = 2;
            svc.type1=type1;
            svc.type_name=type_name;
            svc.titleText = @"筛选结果";
            svc.dataStatistics = @"自定义喜好筛选结果";
            svc.hidesBottomBarWhenPushed=YES;
            [self.navigationController pushViewController:svc animated:YES];
            
        } else {
            [MBProgressHUD showError:responseObject[@"message"]];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MBProgressHUD hideHUDForView:self.screeningScrollView];
//        MyLog(@"error: %@", error);
        
//        [MBProgressHUD showError:@"网络连接失败,请检查网络设置"];
    }];
}

- (void)storeTitleTopStatus:(BOOL)isTop
{
//    MyLog(@"store isTop: %d", isTop);
}

- (void)saleTitleTopStatus:(BOOL)isTop
{
//    MyLog(@"sale isTop: %d", isTop);
    
}

- (void)storePageViewScrollViewDidScroll:(UIScrollView *)pageViewScrollView {
   
    CGFloat headerV_H = pageViewScrollView.contentInset.top;
    CGFloat pageV_Y = pageViewScrollView.contentOffset.y;
    CGFloat pageStop_Y = self.subVC_A.titleHeight + Height_NavBar;
    if (pageV_Y <= -pageStop_Y) {
        CGFloat diff = 1-(-1 * (pageV_Y + pageStop_Y)/(headerV_H-pageStop_Y));
//        MyLog(@"diff: %f", diff);
        
        
        self.navigationView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:diff];
        
        if (diff <= 0.618) {
            
            self.navigationView.image=[UIImage imageNamed:@"zhezhao"];
            
            self.searchBar.searchBarStyle = UISearchBarStyleDefault;
            UIImage *leftImage = [UIImage imageNamed:@"shopping_icon_fenlei_white"];
            UIImage *rightImage = [UIImage imageNamed:@"shopping_icon_zhuanqian_white"];
            [self.leftButton setImage:leftImage forState:UIControlStateNormal];
            [self.rightButton setImage:rightImage forState:UIControlStateNormal];
            [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
            
        } else {
            
            UIImage *leftImage = [UIImage imageNamed:@"shopping_icon_fenlei_black"];
            UIImage *rightImage = [UIImage imageNamed:@"shopping_icon_zhuanqian_black"];
            [self.leftButton setImage:leftImage forState:UIControlStateNormal];
            [self.rightButton setImage:rightImage forState:UIControlStateNormal];
            self.searchBar.searchBarStyle = UISearchBarStyleMinimal;
            [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
            self.navigationView.image=[UIImage imageNamed:@""];
            
        }
    } else {
        
        self.searchBar.searchBarStyle = UISearchBarStyleMinimal;
        self.navigationView.backgroundColor = [UIColor whiteColor];
        self.navigationView.alpha = 1;
        self.navigationView.image=[UIImage imageNamed:@""];
        
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
        
        UIImage *leftImage = [UIImage imageNamed:@"shopping_icon_fenlei_black"];
        UIImage *rightImage = [UIImage imageNamed:@"shopping_icon_zhuanqian_black"];
        [self.leftButton setImage:leftImage forState:UIControlStateNormal];
        [self.rightButton setImage:rightImage forState:UIControlStateNormal];
        
    }
}

- (void)storePageViewScrollView:(UIScrollView *)pageViewScrollView setTabBarStatus:(TabBarStutes)status animation:(BOOL)isAnimation
{
    [self tabBarFrameChangeStatus:status animation:isAnimation];
}

- (void)salePageViewScrollSetTabBarStatus:(TabBarStutes)status animation:(BOOL)isAnimation
{
    [self tabBarFrameChangeStatus:status animation:isAnimation];
}

- (void)tabBarFrameChangeStatus:(TabBarStutes)status animation:(BOOL)isAnimation
{
    if (!self.searchBtn.selected) {
        if([DataManager sharedManager].is_OneYuan)
        {
            Mtarbar.tabBar.hidden = self.pushCome;
        }else{
            Mtarbar.tabBar.hidden = YES;
        }
        
        if (isAnimation) {
            [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
                if (status == TabBarStutesNormal) {
                    [self tabBarStatusWithNormal];
                } else {
                    [self tabBarStatusToBottom];
                }
                
            } completion:^(BOOL finished) {
                
            }];
            
        } else {
            if (status == TabBarStutesNormal) {
                [self tabBarStatusWithNormal];
            } else {
                [self tabBarStatusToBottom];
            }
            
        }
    }
}

/**
 App 首页停留时长
 */
- (void)httpUseAppTimeInterval
{
    NSTimeInterval currTimeInterval = [NSDate timeIntervalSince1970WithDate];
    NSTimeInterval diffTimeInterval = ABS(currTimeInterval- [[DataManager sharedManager] beginYiFuShouye])/1000;
    NSDictionary *parameter = @{@"type": @"1001",
                                @"timer": [NSNumber numberWithDouble:(int)diffTimeInterval],
                                @"version":VERSION};
    
    [[APIClient sharedManager] netWorkGeneralRequestWithApi:kApi_apptimeRecord parameter:parameter caches:NO cachesTimeInterval:0*TFSecond token:YES success:^(id data, Response *response) {
        
        MyLog(@"data: %@", data);
        
    } failure:^(NSError *error) {
        MyLog(@"error: %@", error);
        
    }];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
////何波修改 2018-3-2
//    if (self.pushCome)
//    {
//        Mtarbar.tabBar.frame = CGRectZero;
//    }
    
    if (self.isViewDidLoad)
    {
        [self setupUIAndSetData];
        self.isViewDidLoad = NO;
    }
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    NSString *token = [TFPublicClass getTokenFromLocal];
    if (token.length) {
        [self httpGetShopCartCount];
    } else {
        self.shoppingCartLabel.hidden = YES;
    }
    
    if (self.screenBtn.selected) {
        self.tabBarController.tabBar.hidden = YES;
    }
    
    //何波加的2017-1-21
    Myview.hidden = NO;
    
    if(token.length > 10)
    {
        [_rightButton addSubview:self.aView];
    }else{
        [self.aView removeFromSuperview];
    }
    
    NSString *time = [[NSUserDefaults standardUserDefaults] objectForKey:ShareAnimationTime];
    NSString *currTime = [MyMD5 getCurrTimeString:@"year-month-day"];
    if (time == nil || ![time isEqualToString:currTime]) {
        [self.aView animationStart:YES];
    } else {
        [self.aView animationStart:NO];
    }
    
    //获取是否一元购
    [OneYuanModel GetOneYuanDataSuccess:^(id data) {
        
        OneYuanModel *model = data;
        OneYuanDataModel *dataModel = model.data;
        if(model.status == 1)
        {
            [DataManager sharedManager].is_OneYuan = dataModel.app_status ==0?YES:NO;
//            [DataManager sharedManager].app_value = dataModel.app_value;
            [DataManager sharedManager].app_every = dataModel.app_every;
            [DataManager sharedManager].app_zero = dataModel.app_zero;
            
            Mtarbar.tabBar.hidden = ![DataManager sharedManager].is_OneYuan;
        }
    }];
    
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
            
            if(shouyeCount == 2)
            {
                if(![DataManager sharedManager].is_MakeMoneyHiden){
                    MakeMoneyViewController *vc = [[MakeMoneyViewController alloc] init];
                    vc.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:vc animated:YES];
                }
            }
        }else if ([responseObject[@"status"] intValue] == 10030)
        {
            if(![DataManager sharedManager].is_MakeMoneyHiden){
                MakeMoneyViewController *vc = [[MakeMoneyViewController alloc] init];
                vc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:vc animated:YES];
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    //跳出首页
    [TFStatisticsClickVM StatisticshandleDataWithClickType:@"跳出首页" success:^(id data, Response *response) {
    } failure:^(NSError *error) {
    }];
    [self httpUseAppTimeInterval];
}
- (void)viewDidAppear:(BOOL)animated
{

    _rightButton.userInteractionEnabled = YES;
    [DataManager sharedManager].beginYiFuShouye = [NSDate timeIntervalSince1970WithDate];
    //到达首页
    [TFStatisticsClickVM StatisticshandleDataWithClickType:@"到达首页" success:^(id data, Response *response) {
    } failure:^(NSError *error) {
    }];

    if([Signmanager SignManarer].task_Fightgroups == YES)
    {
        [self FightgroupsPopview];
    }
    
    if ([DataManager sharedManager].isRecommendTask)
    {
        [self bindingPhone:YES];
       
        [DataManager sharedManager].isRecommendTask = NO;
    }

    
    
//    //记录精选推荐勾选时间（每天只自动弹一次）
//    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
//    NSDate *record = [user objectForKey:RECOMMENDSELECT];
//    if(![[MyMD5 compareDate:record] isEqualToString:@"今天"] || record==nil)
//    {
//        //精选推荐弹框
//        [RecommendModel getPhoneData:^(id data) {
//            RecommendModel *model = data;
//            if(model.status == 1)//手机绑定成功
//            {
//                if(model.isphone)
//                {
//                    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
//                    NSString *hobby = [user objectForKey:USER_HOBBY];
//                    
//                    if(hobby.length > 8)
//                    {
//                        [self setRecommendPopMindView:NO];
//                    }
//                }
//            }
//        }];
//        
//    }else if ([DataManager sharedManager].isRecommendTask)
//    {
//        [self bindingPhone:YES];
//    }
}
- (void)shareSdkWithAutohorWithTypeGetOpenIDSuccess:(void(^)())success{

    //判断设备是否安装微信
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"weixin://"]]){

    }else{

        NavgationbarView *mentionview = [[NavgationbarView alloc]init];
        [mentionview showLable:@"还未安装微信哦~" Controller:self];
        return;
    }

    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate shardk];

    // 取消授权
    [ShareSDK cancelAuthWithType:ShareTypeWeixiFav];

    // 开始授权
    id<ISSAuthOptions> authOptions = [ShareSDK authOptionsWithAutoAuth:YES
                                                         allowCallback:YES
                                                         authViewStyle:SSAuthViewStyleFullScreenPopup
                                                          viewDelegate:nil
                                               authManagerViewDelegate:nil];
    id<ISSQZoneApp> app =(id<ISSQZoneApp>)[ShareSDK getClientWithType:ShareTypeQQSpace];
    [app setIsAllowWebAuthorize:YES];

    [ShareSDK getUserInfoWithType:ShareTypeWeixiFav
                      authOptions:authOptions
                           result:^(BOOL result, id<ISSPlatformUser> userInfo, id<ICMErrorInfo> error) {

                               if (result) {
                                   NSDictionary *uniondic = (NSDictionary *)[userInfo sourceData];

                                   if(uniondic[@"unionid"] !=nil) {
                                       NSString *unionid = [NSString stringWithFormat:@"%@",uniondic[@"unionid"]];
                                       NSString *wx_openid = [userInfo uid];
                                       
                                       [self saveunionid:unionid Openid:wx_openid Success:^(id data) {
                                           if(success) {
                                               success();
                                           }
                                       }];
                                   }
                                   
                               }else{
                                   [MBProgressHUD show:@"微信授权失败" icon:nil view:self.view];
                               }
                           }];
}

#pragma mark 修改用户信息 将微信授权unionid传给后台
-(void)saveunionid:(NSString*)unionid Openid:(NSString*)wx_openid Success:(void(^)())success
{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *paraments=[NSMutableDictionary dictionary];
    NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
    NSString *token=[user objectForKey:USER_TOKEN];

    NSString *url=[NSString stringWithFormat:@"%@user/update_userinfo?version=%@&token=%@&unionid=%@&wx_openid=%@",[NSObject baseURLStr],VERSION,token,unionid,wx_openid];
    NSString *URL=[MyMD5 authkey:url];
    [manager POST:URL parameters:paraments success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (responseObject!=nil) {
            NSString *str=responseObject[@"status"];

            if(str.intValue==1){
                MyLog(@"上传成功");
                NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
                [user setObject:unionid forKey:UNION_ID];
                if(success){
                    success();
                }
                [MBProgressHUD show:@"授权成功" icon:nil view:self.view];
            }else{

                [MBProgressHUD show:responseObject[@"message"] icon:nil view:self.view];
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //网络连接失败");
        NavgationbarView *mentionview=[[NavgationbarView alloc]init];
        [mentionview showLable:@"保存失败,请重试!" Controller:self];
        [[Animation shareAnimation] stopAnimationAt:self.view];
    }];

}
#pragma mark 是否绑定手机
- (void)bindingPhone:(BOOL)clickComming
{
    kSelfWeak;
    [RecommendModel getPhoneData:^(id data) {
        RecommendModel *model = data;
        if(model.status == 1)//手机绑定成功
        {
            if(model.isphone)
            {
//                [self getHobby:clickComming];
                if([[NSUserDefaults standardUserDefaults] objectForKey:UNION_ID] == nil)
                {
                    [weakSelf shareSdkWithAutohorWithTypeGetOpenIDSuccess:^{
                        [weakSelf getHobby:clickComming];
                    }];

                }else{
                    [weakSelf getHobby:clickComming];
                }
                
            }else{
                BoundPhoneVC *tovc = [[BoundPhoneVC alloc] init];
                tovc.hidesBottomBarWhenPushed = YES;
                tovc.comefrom = @"推荐";
                [weakSelf.navigationController pushViewController:tovc animated:YES];
            }
        }else if (model.status == 2)
        {
            BoundPhoneVC *tovc = [[BoundPhoneVC alloc] init];
            tovc.hidesBottomBarWhenPushed = YES;
            tovc.comefrom = @"推荐";
            [weakSelf.navigationController pushViewController:tovc animated:YES];
        }
    }];
}
//是否设置喜好
- (void)getHobby:(BOOL)clickComming
{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *hobby = [user objectForKey:USER_HOBBY];
    
    if(hobby.length > 8 && [hobby rangeOfString:@"_"].length>0)
    {
        [self setRecommendPopMindView:clickComming];
    }else{
        [self settingHobby:clickComming];
    }
}
#pragma mark 设置喜好
- (void)settingHobby:(BOOL)clickComming
{
    SelectHobbyViewController *hobby = [[SelectHobbyViewController alloc]init];
    hobby.comefrom = @"推荐";
    hobby.submitHobbySuccess = ^{
        [self setRecommendPopMindView:clickComming];
    };
    hobby.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:hobby animated:YES];
}

#pragma mark 精选推荐
- (void)setRecommendPopMindView:(BOOL)clickComming
{
    //记录精选推荐弹出时间（每天只弹一次）
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSDate *record = [user objectForKey:RECOMMENDPOPDATE];
    
    [RecommendModel getLikeData:1 Success:^(id data) {
        RecommendModel *model = data;
        if(model.status == 1 && model.likes.count)
        {
            if(clickComming)
            {
                Recommendview = [[RecommendRemindView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-kTabBarHeight) DataModel:model];
                ESWeakSelf;
                Recommendview.likeDataBlock = ^(NSString *message){
                    NavgationbarView *view = [[NavgationbarView alloc]init];
                    [view showLable:message Controller:__weakSelf];
                };
                Recommendview.addImageBlock = ^(NSArray *photos){
                    [__weakSelf pushaddimage:photos];
                };
                Recommendview.didselectShopBlock = ^(NSString *shopcode){
                    [__weakSelf pushShopDetail:shopcode];
                };
                Recommendview.FinishbrowseBlock = ^{
                    
                    UIButton *button = [__weakSelf.contentBackgroundView viewWithTag:89898989];
                    //查看精选推荐浏览时间（今天浏览完就不能在浏览）
                    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
                    NSDate *record = [user objectForKey:FINISHRECOMMENDPOPDATE];
                    if(![[MyMD5 compareDate:record] isEqualToString:@"今天"] || record==nil )
                    {
                        button.hidden = NO;
                    }else{
                        button.hidden = YES;
                    }
                };
                
                Recommendview.RemindFinishBlock = ^{
                    [__weakSelf setTaskPopMindView:Task_Recommend_finish];
                };
                [self.view addSubview:Recommendview];
                
            }else{
                
                if(![[MyMD5 compareDate:record] isEqualToString:@"今天"] || record==nil  )
                {
                    Recommendview = [[RecommendRemindView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-kTabBarHeight) DataModel:model];
                    ESWeakSelf;
                    Recommendview.addImageBlock = ^(NSArray *photos){
                        [__weakSelf pushaddimage:photos];
                    };
                    [self.view addSubview:Recommendview];
                    
                    NSDate *date = [NSDate date];
                    [user setObject:date forKey:RECOMMENDPOPDATE];
                }
            }
            
        }else{
            [TFStatisticsClickVM StatisticshandleDataWithClickType:@"到达点左划右划点不再弹出次数" success:nil failure:nil];
            if(clickComming)
            {
                NavgationbarView *nv = [[NavgationbarView alloc] init];
                [nv showLable:@"亲，没有相关推荐数据!" Controller:self];

            }
        }
    }];
}

#pragma mark 疯狂星期一
- (void)popCrazyMonday
{
    //是否是疯狂星期一
    if([DataManager sharedManager].IS_Monday)
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

}

#pragma mark 签到任务弹框
- (void)setTaskPopMindView:(TaskPopType)type
{
    FinishTaskPopview * bonusview = [[FinishTaskPopview alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) TaskType:type TaskValue:nil Title:nil RewardValue:nil RewardNumber:1  Rewardtype:nil];
    
    __weak FinishTaskPopview *view = bonusview;
    view.tapHideMindBlock = ^{
        [view remindViewHiden];
    };
    
    view.leftHideMindBlock = ^(NSString*title){
        MyLog(@"左");
    };
    
    view.rightHideMindBlock = ^(NSString*title){
        MyLog(@"右");
        [self gotovc];
    };
    
    [self.view addSubview:bonusview];
    
}
//一键做下个任务
- (void)gotovc
{
    [Recommendview removeFromSuperview];
    [[NextTaskManager taskManager] bakeToMakemoneyVC];
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
            [self CrazyMonday];
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

//购买几件商品
- (void)shoppinggo:(NSString*)dataStr
{
    NSString *value1 = dataStr;
    
    if([value1 isEqualToString:@"type_name=热卖&notType=true"])//热卖
    {
        TaskCollectionVC *vc = [[TaskCollectionVC alloc]init];
        vc.typeID = [NSNumber numberWithInt:6];
        vc.typeName = @"热卖";
        vc.title = @"热卖";
        vc.is_jingxi = YES;
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }else if ([value1 isEqualToString:@"collection=shop_activity"])//活动商品
    {
        TFActivityShopVC *vc = [[TFActivityShopVC alloc]init];
        vc.isMonday = YES;
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        
    }else if ([value1 isEqualToString:@"collection=collocation_shop"])//搭配
    {
        TFCollocationViewController *testVC = [[TFCollocationViewController alloc] init];
        testVC.typeName = @"搭配";
        testVC.pushType = PushTypeSign;
        testVC.isFinish = YES;
        testVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:testVC animated:YES];
    }else if ([value1 isEqualToString:@"collection=csss_shop"])//专题
    {
        TFCollocationViewController *subVC = [[TFCollocationViewController alloc] init];
        subVC.page = 0;
        subVC.typeName = @"专题";
        subVC.typeID = [NSNumber numberWithInt:2];
        subVC.isFinish = YES;
        subVC.pushType = PushTypeSign;
        subVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:subVC animated:YES];
        
    }else if ([value1 isEqualToString:@"collection=shop_home"])//首页
    {
        Mtarbar.selectedIndex = 0;
        [self.navigationController popToRootViewControllerAnimated:NO];
    }
    else if ([value1 isEqualToString:@"collection=shopping_page"])//购物界面
    {
        Mtarbar.selectedIndex = 1;
        [self.navigationController popToRootViewControllerAnimated:NO];
    }
    else{//其它合集(热卖)
        
        TaskCollectionVC *vc = [[TaskCollectionVC alloc]init];
        vc.typeID = [NSNumber numberWithInt:6];
        vc.typeName = @"热卖";
        vc.title = @"热卖";
        vc.is_jingxi = YES;
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

//热卖
- (void)goremai
{
    TaskCollectionVC *vc = [[TaskCollectionVC alloc]init];
    vc.typeID = [NSNumber numberWithInt:6];
    vc.typeName = @"热卖";
    vc.title = @"热卖";
    vc.is_jingxi = YES;
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}
//疯狂星期一活动详情页
- (void)CrazyMonday
{
    CrazyMondayActivityVC *activity = [[CrazyMondayActivityVC alloc]init];
    activity.hidesBottomBarWhenPushed = YES;
    activity.comefrom = @"推荐";
    [self.navigationController pushViewController:activity animated:YES];
}

//选择照片
- (void)pushaddimage:(NSArray*)photos
{
    SelectPhotoViewController *photo = [[SelectPhotoViewController alloc]init];
    photo.selectPhotoBlock =^(NSArray *images){
        [Recommendview refreshView:images];
    };
    photo.photoData = photos;
    photo.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:photo animated:YES];
}
//商品详情
- (void)pushShopDetail:(NSString*)shopcode
{
    ShopDetailViewController *shopdetail = [[ShopDetailViewController alloc]init];
    shopdetail.shop_code = shopcode;
    shopdetail.stringtype = @"订单详情";
    shopdetail.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:shopdetail animated:YES];

}
//活动商品发起拼团成功 何波加的2016-11-25
- (void)FightgroupsPopview
{
    [Signmanager SignManarer].task_Fightgroups = NO;
    
    VitalityTaskPopview *vitaliview = [[VitalityTaskPopview alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) VitalityType:Fightgroups_from valityGrade:0 YidouCount:0];
    __weak VitalityTaskPopview *view = vitaliview;
    view.tapHideMindBlock = ^{
        
    };
    
    view.rightHideMindBlock = ^(NSString*title){
        [self gotoFightgroupVC];
    };
    
    [self.view addSubview:vitaliview];
}
//拼团广场
- (void)gotoFightgroupVC
{
    MyLog(@"拼团广场");
    TFGroupBuysVC *vc = [[TFGroupBuysVC alloc]init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (void)addVCTestGesture
{
    UIView *changeBaseURLView = [UIView new];
    
    if (My_DEBUG) {
        [self.view addSubview:changeBaseURLView];
    }
    
    UILabel *titleL = (UILabel *)[self.navigationView viewWithTag:250];
    
    changeBaseURLView.backgroundColor = [UIColor clearColor];
//    ESWeakSelf;
    [changeBaseURLView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(titleL.mas_centerY);
        make.left.equalTo(titleL.mas_right).offset(0);
        make.size.mas_equalTo(CGSizeMake(44, 44));
    }];
    
    UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGRClick:)];
    tapGR.numberOfTapsRequired = 3; //3下
    [changeBaseURLView addGestureRecognizer:tapGR];
}

- (void)tapGRClick:(UITapGestureRecognizer *)sender
{
    if (sender.state == UIGestureRecognizerStateRecognized) {
        
        
//        TFWXWithdrawalsDescriptionVC
        
//        TFActivityShopVC *testVC = [[TFActivityShopVC alloc] init];
        TFExpViewController *testVC = [[TFExpViewController alloc] init];
//        TFCashSuccessViewController *testVC = [[TFCashSuccessViewController alloc] init];
//        testVC.index = VCType_Cash;
//        testVC.type = TFMyWallet;
//        testVC.cashType = CashType_Adopt;
//        testVC.money = 192.3f;
//        testVC.unAdoptMoney = 100.2f;
//        testVC.hidesBottomBarWhenPushed = YES;
        
//        TFWXWithdrawalsDescriptionVC *testVC = [[TFWXWithdrawalsDescriptionVC alloc] init];
//        testVC.isIdenf = NO;
        
//        TFLedBrowseCollocationShopVC *testVC = [[TFLedBrowseCollocationShopVC alloc] init];
        testVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:testVC animated:YES];
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
