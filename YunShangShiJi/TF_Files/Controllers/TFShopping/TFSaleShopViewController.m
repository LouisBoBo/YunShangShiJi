//
//  TFSaleShopViewController.m
//  YunShangShiJi
//
//  Created by jingaiweiyi on 16/6/16.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import "TFSaleShopViewController.h"
#import "TFSalePurchaseFirstViewController.h"
#import "GlobalTool.h"
 
#import "TFSlidePageScrollView.h"
#import "TFCustomTitleView.h"
#import "LoginViewController.h"

#import "TFLoginView.h"
#import "TFNoviceTaskView.h"
#import "TFDailyTaskView.h"
#import "SaleShopListModel.h"
#import "CycleScrollView.h"
#import "TFShopModel.h"
#import "DShareManager.h"
#import "AppDelegate.h"
#import "ProduceImage.h"
//#import "ComboShopDetailViewController.h"
#import "TFHomeViewController.h"
#import "ScrollView_public.h"
#import "QRCodeGenerator.h"
#import "AppDelegate.h"
#import "TFFeedBackViewController.h"
#import "InvitCodeViewController.h"
#import "H5activityViewController.h"
#import "WTFAlertView.h"
#import "TFTopShopsVM.h"
#import "NewShoppingCartViewController.h"
#define NavigationHeight 44.0f
#define StatusTableHeight 20.0f
#define TableBarHeight 49.0f

@interface TFSaleShopViewController () <TFSlidePageScrollViewDataSource, TFSlidePageScrollViewDelegate, DShareManagerDelegate, UIAlertViewDelegate, SalePurchasecustomDelegate>

{
    
    CGFloat _oldPointY;
    
    struct {
        unsigned int salePageViewScrollSetTabBarStatus: 1;
        unsigned int saleTitleTopStatus : 1;
    }_delegateFlags;
    
    UIAlertView *_saleShopAlertView;
    
    CGFloat H_headView;
    
    NSInteger _noviceTimerCount_1;
    NSTimer *_noviceTimer_1;
    
    NSInteger _noviceTimerCount_4;
    NSTimer *_noviceTimer_4;
    
    NSInteger _noviceTimerCount_5;
    NSTimer *_noviceTimer_5;
    
    NSInteger _noviceTimerCount_11;
    NSTimer *_noviceTimer_11;
    
    NSTimer *_dailyTimer_2;
    NSInteger _dailyTimerCount_2;
    
    NSTimer *_dailyTimer_1;
    NSInteger _dailyTimerCount_1;
    
    ScrollView_public *_ScrollView_public;
    
    CGRect _rect;
    
    
    UIView *_Popview;
    UIView *_InvitationCodeView;
    
    
}

@property (nonatomic, weak) TFSlidePageScrollView *slidePageScrollView;
@property (nonatomic, strong)UIView *nheadView;
@property (nonatomic, strong)TFCustomTitleView *nTitleView;
@property (nonatomic , retain)CycleScrollView *mainScorllView;

@property (nonatomic, strong)UIButton *leftBtn;
@property (nonatomic, strong)UIButton *rightBtn;


@property (nonatomic, assign)NSInteger currPageIndex;
@property (nonatomic, assign)NSInteger countIndex;

@property (nonatomic, strong)TFNoviceTaskView *noviceTaskView;
@property (nonatomic, strong)TFDailyTaskView *dailyTsakView;

@property (nonatomic, strong)NSMutableArray *LideImageArr;
@property (nonatomic, strong)UIImage *shareAppImg;
@property (nonatomic, strong)UIImage *shareRandShopImage;

@property (nonatomic, assign)CGFloat titleHeight;
@property (nonatomic, assign)CGFloat bannerHeight;

@property (nonatomic, assign)TFPageTabBarState pageTabBarState;
@property (nonatomic, assign) BOOL isViewDidLoad;


@end

@implementation TFSaleShopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.isViewDidLoad = YES;
    // 数据初始化
    [self setData];
    // 创建UI
    [self setupUI];
    
    [MBProgressHUD showHUDAddTo:self.view animated:YES];
    
}

- (void)getData
{
    [self httpZeroShopsRequest];
    
    [self httpGetShareImage];
    
    [MBProgressHUD hideHUDForView:self.view];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if (self.isViewDidLoad) {
        [self getData];
        self.isViewDidLoad = NO;
    }
}

#pragma mark - view将要出现
- (void)viewWillAppear:(BOOL)animated
{
    [MobClick beginLogPageView:@"TemaiPage"];
    
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;

    [self pageTabBarState:self.pageTabBarState];
    
    if (appDelegate.isUpdata == NO){
        
//        [self httpGetVoucherCards];
//        [self taskView];
    }
}
/*
- (void)httpGetVoucherCards
{
    NSString *token = [TFPublicClass getTokenFromLocal];
    if (token == nil) {
        return;
    }
    
    [[APIClient sharedManager] netWorkGeneralRequestWithApi:kApi_coupon_addVoucher caches:NO cachesTimeInterval:0*TFSecond token:YES success:^(id data, Response *response) {
        if (response.status == 1) {
            if (kUnNilAndNULL(data[@"num"])) {
                int num = [data[@"num"] intValue];
                NSInteger isRedCards = 0;
                if (num == 0) {
                    isRedCards = 1;
                } else if(num == 1) {
                    isRedCards = 2;
                }
                [self redCadsDisplay:isRedCards];
            }
        }

    } failure:^(NSError *error) {
        
    }];
}

-(void)popWTFAlertView:(NSArray *)titleArray
{
    WTFAlertView *alert = [WTFAlertView GlodeBottomView];
    alert.titleArray = titleArray;
    
    [alert show];
}
*/
- (void)viewWillDisappear:(BOOL)animated
{
    [MobClick endLogPageView:@"TemaiPage"];
    
    [_saleShopAlertView dismissWithClickedButtonIndex:0 animated:NO];
    _saleShopAlertView = nil;
    
    [_noviceTimer_1 invalidate];
    [_noviceTimer_4 invalidate];
    [_noviceTimer_5 invalidate];
    [_noviceTimer_11 invalidate];
    [_dailyTimer_1 invalidate];
    [_dailyTimer_2 invalidate];
}



/***   任务  流程  ****/
-(void)taskView
{
    //        [self noviceTaskView1]; //新手任务1(0元购首页；5秒；无论登录状态；完成后消失)
    //        [self noviceTaskView4]; //新手任务4(0元购首页，5秒，弹1完成，未登录，登录后不出现)
    [self noviceTaskView5]; //新手任务5(0元购首页，5秒，弹1完成，已登录未开店)
    
    [self dailyTaskView1];  //0元购首页，5秒，上午；新手任务弹1完成 已登录已开店
    [self dailyTaskView2];  //0元购首页，5秒，上午；新手任务弹1完成 已登录已开店
    
    [self noviceTaskView11];  //这个弹窗会与所有的弹窗冲突
    
}
/*
- (void)redCadsDisplay:(NSInteger )isRedCards
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *token = [ud objectForKey:USER_TOKEN];
    NSString *oldDate = [ud objectForKey:RedCash];
    NSString *userID = [ud objectForKey:USER_ID];
    NSString *currDate = [NSString stringWithFormat:@"%@%@", userID, [MyMD5 getCurrTimeString:@"year-month-day"]];
    
    if (token == nil) {
        return;
    }
    
    if (oldDate == nil || ![oldDate isEqualToString:currDate]) {
        
//        [ud setObject:currDate forKey:RedCash];
        
        if (isRedCards == 1) {
            [self popWTFAlertView:@[@"30", @"20", @"10", @"20"]];
        } else if (isRedCards == 2) {
            [self popWTFAlertView:@[@"15", @"10", @"5"]];
        }
    }
    
}
*/

/// 分享图片
- (void)httpGetShareImage
{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSString *url=[NSString stringWithFormat:@"%@%@",[NSObject baseURLStr_Upy], USER_SHARE_APP];
    manager.responseSerializer = [AFImageResponseSerializer serializer];
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        responseObject = [NSDictionary changeType:responseObject];
        if (responseObject!=nil) {
            NSData *imgData = UIImagePNGRepresentation(responseObject);
            self.shareAppImg = [UIImage imageWithData:imgData];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //
    }];
}

- (void)shareAppToWeiXin
{
    //	//App");
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"weixin://"]]) {
        AppDelegate *appDelegate=(AppDelegate *)[[UIApplication sharedApplication] delegate];
        [appDelegate shardk];
        
        UIImage *img;
        if (self.shareAppImg == nil) {
            [self httpGetShareImage];
        } else {
            img = self.shareAppImg;
        }
        
        DShareManager *ds = [DShareManager share];
        ds.delegate = self;
        [ds shareAppWithType:ShareTypeWeixiTimeline withImageShareType:NoviciateTaskOne withImage:img];
    } else {
        dispatch_async(dispatch_get_main_queue(), ^{
            NavgationbarView *nv = [[NavgationbarView alloc] init];
            [nv showLable:@"请安装微信,再分享" Controller:self];
        });
        
    }
}


#pragma mark ------------------1-------------------

- (void)toLogin :(NSInteger)tag
{
    LoginViewController *login=[[LoginViewController alloc]init];
    login.tag = tag;
    login.loginStatue = @"toBack";
    login.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:login animated:YES];
}

/// 跳转登录注册页面
- (void)pushLoginAndRegisterView
{
    TFLoginView *tf = [[TFLoginView alloc] initWithHeadImage:nil contentText:nil upButtonTitle:nil downButtonTitle:nil];
    [tf show];
    
    tf.upBlock = ^() {
        //上键");
        [self toLogin:2000];
    };
    
    tf.downBlock = ^() {
        //下键");
        [self toLogin:1000];
    };
}

/// 刷新Banner
- (void)refreshLideImage
{
    __weak TFSaleShopViewController *tp = self;
    NSMutableArray *topimageArry = [NSMutableArray array];
    for (int i = 0; i < _LideImageArr.count; i++) {
        TFShoppingM *model=_LideImageArr[i];
        NSString *imgUrlStr = [NSString stringWithFormat:@"%@%@!560",[NSObject baseURLStr_Upy],model.url];
        [topimageArry addObject:imgUrlStr];
    }
    
    for (UIView *view in _ScrollView_public.subviews) {
        [view removeFromSuperview];
    }
    
    //添加轮播图
    _ScrollView_public = [[ScrollView_public alloc]initWithFrame:_rect pictures:topimageArry animationDuration:5 contentMode_style:Fill_contentModestyle Haveshiping:NO];
    _ScrollView_public.pageControl.currentPageIndicatorImage = [UIImage imageNamed:@"Carousel_Selected"];
    _ScrollView_public.pageControl.pageIndicatorImage = [UIImage imageNamed:@"Carousel_normal"];
    
    [self.nheadView addSubview:_ScrollView_public];
    
    _ScrollView_public.scrollview.scrollsToTop = NO;
    _ScrollView_public.getTapClickPage = ^(NSInteger page){
        TFShoppingM *model = (TFShoppingM *)tp.LideImageArr[page];
        if(model.option_type.intValue == 1)//商品详情
        {
//            ComboShopDetailViewController *detail=[[ComboShopDetailViewController alloc] initWithNibName:@"ComboShopDetailViewController" bundle:nil];
//            detail.shop_code = model.shop_code;
//            
//            detail.hidesBottomBarWhenPushed=YES;
//            [tp.navigationController pushViewController:detail animated:YES];
        }else if (model.option_type.intValue == 2)//邀请码
        {
            NSUserDefaults *userdefaul = [NSUserDefaults standardUserDefaults];
            NSString *token = [userdefaul objectForKey:USER_TOKEN];
            
            if(token == nil) {
                [tp pushLoginAndRegisterView];
            } else{
                
                InvitCodeViewController *invit =[[InvitCodeViewController alloc]init];
                invit.hidesBottomBarWhenPushed = YES;
                [tp.navigationController pushViewController:invit animated:YES];
            }
            
        }else if (model.option_type.intValue == 3)//消息盒子
        {
            
            NSUserDefaults *userdefaul = [NSUserDefaults standardUserDefaults];
            NSString *token = [userdefaul objectForKey:USER_TOKEN];
            
            if(token == nil) {
                [tp pushLoginAndRegisterView];
            } else {
                //begin 赵官林 2016.5.26 跳转到消息列表
                [tp presentChatList];
                //end
            }
        }else if (model.option_type.intValue == 4)//签到页
        {
            Mtarbar.selectedIndex = 2;
        }else if (model.option_type.intValue == 5)//H5活动页
        {
            if(model.shop_code !=nil || ![model.shop_code isEqual:[NSNull null]])
            {
                
                H5activityViewController *h5vc = [[H5activityViewController alloc]init];
                h5vc.H5url = model.shop_code;
                h5vc.hidesBottomBarWhenPushed = YES;
                [tp.navigationController pushViewController:h5vc animated:YES];
            }
        }
    };
}

/// 加载轮播图
-(void)httpZeroShopsRequest
{
    
    [TFTopShopsVM handleZeroShopsDataWithSuccess:^(NSArray *zeroShopsArray, Response *response) {        
        if (response.status == 1) {
            [self.LideImageArr removeAllObjects];
            [self.LideImageArr addObjectsFromArray:zeroShopsArray];
            
            if (self.LideImageArr.count) {
                [self refreshLideImage];
            }

        }
    } failure:^(NSError *error) {
        
    }];
    
    
}

- (void)setData
{
    self.navigationController.navigationBar.hidden = YES;
    self.view.backgroundColor = RGBCOLOR_I(220,220,220);
    
    
//    NSArray *normalImgArr = [NSArray arrayWithObjects:[UIImage imageNamed:@"normal_0yuan"],
//                             [UIImage imageNamed:@"normal_9yuan"],
//                             [UIImage imageNamed:@"normal_19yuan"],
//                             [UIImage imageNamed:@"normal_29yuan"], nil];
    
//    UIImage *img = normalImgArr[0];
//    CGFloat W_btn = ceil(kScreenWidth/normalImgArr.count);
//    CGFloat H_btn = ceil(img.size.height/img.size.width*W_btn);
    
    self.bannerHeight = kScreenWidth/3;
    self.titleHeight = ZOOM6(100);
    
    self.currPageIndex = 0;
    self.countIndex = 2;
    
    _noviceTimerCount_1 = 5;
    _noviceTimerCount_4 = 5;
    _noviceTimerCount_5 = 5;
    _noviceTimerCount_11 = 60;
    
    _dailyTimerCount_1 = 5;
    _dailyTimerCount_2 = 5;
}

- (void)setupUI
{
    // 整体大框架
    [self addSlidePageScrollView];
    // 头部Banner
    [self createHeadView];
    // 底部
    [self addFooterView];
    // 页面菜单栏
    [self addTabPageMenu];
    // 正文视图控制器
    [self addViewController];
    
}

- (void)addTabPageMenu
{
    CGRect frame = CGRectMake(0, 0, CGRectGetWidth(_slidePageScrollView.frame), self.titleHeight);
    
    NSArray *titleArray = @[@"超值套餐", @"超值单品"];
    self.nTitleView = [[TFCustomTitleView alloc] initWithFrame:frame withTag:0 withIndex:0 withButtonNames:titleArray];
    self.nTitleView.backgroundColor = [UIColor whiteColor];
    
    UIView *backgroundViwe = [[UIView alloc] initWithFrame:CGRectMake(0, self.titleHeight-(int)ZOOM(100), CGRectGetWidth(self.nTitleView.frame), (int)ZOOM(100))];
    backgroundViwe.backgroundColor = [UIColor whiteColor];
    
    UIView *bottomLine = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(backgroundViwe.frame)-0.5, CGRectGetWidth(backgroundViwe.frame), 0.5)];
    bottomLine.backgroundColor = RGBCOLOR_I(229, 229, 229);
    [backgroundViwe addSubview:bottomLine];
    
    
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(0, 0, kScreenWidth*0.5-2, (int)ZOOM(100)-ZOOM6(14)-0.5);
    leftBtn.titleLabel.font = kFont6px(18);
    [leftBtn setTitleColor:RGBCOLOR_I(62, 62, 62) forState:UIControlStateNormal];
    [leftBtn setTitleColor:COLOR_ROSERED forState:UIControlStateSelected];
    
    NSString *leftBtnTitle = @"超值套餐";
    CGSize titleSize = [leftBtnTitle boundingRectWithSize:CGSizeMake(100, (int)ZOOM(100)) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: kFont6px(18)} context:nil].size;
    UIImage *leftBtnImage = [UIImage imageNamed:@"0_icon_hot.png"];
    [leftBtn setImage:leftBtnImage forState:UIControlStateNormal];
    [leftBtn setImage:leftBtnImage forState:UIControlStateSelected];
    [leftBtn setImage:leftBtnImage forState:UIControlStateHighlighted];
    leftBtn.backgroundColor = [UIColor whiteColor];
    CGSize imgSize = leftBtn.imageView.bounds.size;
    [leftBtn setImageEdgeInsets:UIEdgeInsetsMake(-4, titleSize.width+4, 0, -titleSize.width)];
    [leftBtn setTitle:leftBtnTitle forState:UIControlStateNormal];
    [leftBtn setTitle:leftBtnTitle forState:UIControlStateSelected];
    [leftBtn setTitle:leftBtnTitle forState:UIControlStateHighlighted];
    [leftBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, -imgSize.width, 0, imgSize.width)];
    [leftBtn addTarget:self action:@selector(leftBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    leftBtn.selected = YES;
    [backgroundViwe addSubview:_leftBtn = leftBtn];
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(kScreenWidth*0.5+2, 0, kScreenWidth*0.5, (int)ZOOM(100)-ZOOM6(14)-0.5);
    [rightBtn setTitle:@"超值单品" forState:UIControlStateNormal];
    rightBtn.titleLabel.font = kFont6px(18);
    [rightBtn setTitleColor:RGBCOLOR_I(62, 62, 62) forState:UIControlStateNormal];
    [rightBtn setTitleColor:COLOR_ROSERED forState:UIControlStateSelected];
    rightBtn.backgroundColor = [UIColor whiteColor];
    [backgroundViwe addSubview:_rightBtn = rightBtn];
    
    [rightBtn addTarget:self action:@selector(rightBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(kScreenWidth*0.5+1.5, ((int)ZOOM(100)-(int)ZOOM(60))*0.5, 0.5, (int)ZOOM(60))];
    lineView.backgroundColor = RGBCOLOR_I(229, 229, 229);
    [backgroundViwe addSubview:lineView];
    
    
    int page = (int)[_slidePageScrollView curPageIndex];
    self.nTitleView.index = page;
    _slidePageScrollView.pageTabBar = self.nTitleView;
}

- (void)leftBtnClick:(UIButton *)sender
{
    NSArray *viewControllers = self.childViewControllers;
    TFSalePurchaseFirstViewController *tfVc = (TFSalePurchaseFirstViewController *)viewControllers[self.currPageIndex];
    
    tfVc.myChoose = ChooseBuyPackage;
    self.leftBtn.selected = YES;
    self.rightBtn.selected = NO;
}

- (void)rightBtnClick:(UIButton *)sender
{
    NSArray *viewControllers = self.childViewControllers;
    TFSalePurchaseFirstViewController *tfVc = (TFSalePurchaseFirstViewController *)viewControllers[self.currPageIndex];
    
    tfVc.myChoose = ChooseBuySingle;
    self.leftBtn.selected = NO;
    self.rightBtn.selected = YES;
    
}

#pragma mark - TFSlidePageScrollViewDelegate
- (void)slidePageScrollView:(TFSlidePageScrollView *)slidePageScrollView horizenScrollToPageIndex:(NSInteger)index
{
    self.currPageIndex = index;
    NSArray *viewControllers = self.childViewControllers;
    TFSalePurchaseFirstViewController *tfVC = (TFSalePurchaseFirstViewController *)viewControllers[index];
    if (tfVC.myChoose == ChooseBuyPackage) {
        self.leftBtn.selected = YES;
        self.rightBtn.selected = NO;
    } else {
        self.leftBtn.selected = NO;
        self.rightBtn.selected = YES;
    }
    
//    UIScrollView *subScrollV = nil;
//    for (int i = 0; i<self.childViewControllers.count; i++) {
//        TFSalePurchaseFirstViewController *subVC = (TFSalePurchaseFirstViewController *)viewControllers[i];
//        subScrollV = subVC.tableView;
//        if (subScrollV.topShowView.topRefreshStatus != REFRESH_STATUS_NORMAL) {
//            subScrollV.topShowView.topRefreshStatus = REFRESH_STATUS_NORMAL;
//            MyLog(@"index: %ld, i: %d normal", (long)index, i);
//        }
//    }
}


- (void)addSlidePageScrollView
{
    CGRect frame = CGRectMake(0, 0, kScreenWidth, CGRectGetHeight(self.view.frame));
    TFSlidePageScrollView *slidePageScrollView = [[TFSlidePageScrollView alloc]initWithFrame:frame];
    slidePageScrollView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    slidePageScrollView.backgroundColor = RGBCOLOR_I(244,244,244);
    slidePageScrollView.pageTabBarIsStopOnTop = YES;
    slidePageScrollView.tyDataSource = self;
    slidePageScrollView.tyDelegate = self;
    _slidePageScrollView = slidePageScrollView;
    [self.view addSubview:_slidePageScrollView];
    
}

- (void)addHeaderView
{
    CGFloat H_main = self.bannerHeight;
    
    self.nheadView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(_slidePageScrollView.frame), H_main)];
    self.nheadView.backgroundColor = RGBCOLOR_I(244,244,244);
    
    self.mainScorllView = [[CycleScrollView alloc] initWithFrame:CGRectMake(0, 0, kApplicationWidth, self.bannerHeight) animationDuration:4];
    self.mainScorllView.scrollView.scrollsToTop = NO;
    self.mainScorllView.backgroundColor = [[UIColor purpleColor] colorWithAlphaComponent:0.1];
    [self.nheadView addSubview:self.mainScorllView];
    
    //    _slidePageScrollView.headerView = self.nheadView;
    
}

- (void)createHeadView
{
    CGFloat H_main = self.bannerHeight;
    
    self.nheadView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(_slidePageScrollView.frame), H_main)];
    self.nheadView.backgroundColor = RGBCOLOR_I(240, 240, 240);
    
    _slidePageScrollView.headerView = self.nheadView;
    _rect = CGRectMake(0, 0, kApplicationWidth, self.bannerHeight);
    
    //    NSArray *imageArr =@[@"分类图1.jpg",@"分类图1.jpg",@"分类图1.jpg",@"分类图1.jpg"];
    
    //    _ScrollView_public = [[ScrollView_public alloc]initWithFrame:rect pictures:imageArr animationDuration:5 contentMode_style:Fill_contentModestyle Haveshiping:NO];
    //
    //
    //    [self.nheadView addSubview:_ScrollView_public];
    
}

- (void)addFooterView
{
    CGRect frame = CGRectMake(0, 0, CGRectGetWidth(_slidePageScrollView.frame), 1);
    UIView *footerView = [[UIView alloc]initWithFrame:frame];
    footerView.backgroundColor = [UIColor clearColor];
    _slidePageScrollView.footerView = footerView;
}


- (void)addViewController
{
    for (int i = 0; i<self.countIndex; i++) {
        
        TFSalePurchaseFirstViewController *tfVC  = [[TFSalePurchaseFirstViewController alloc] init];
        tfVC.type = [NSString stringWithFormat:@"%d",i+1];
        if (i == 0) {
            tfVC.myChoose = ChooseBuyPackage;
        } else {
            tfVC.myChoose = ChooseBuySingle;
        }
        tfVC.headHeight = self.bannerHeight+self.titleHeight;
        tfVC.customDelegate = self;
        
        [self addChildViewController:tfVC];
        
    }
    [_slidePageScrollView reloadData];

}

#pragma mark - TFSlidePageScrollViewDataSource
- (NSInteger)numberOfPageViewOnSlidePageScrollView
{
    return self.childViewControllers.count;
}

- (UIScrollView *)slidePageScrollView:(TFSlidePageScrollView *)slidePageScrollView pageVerticalScrollViewForIndex:(NSInteger)index
{
    
    if(index==0)
    {
        [MobClick event:TEMIA_0];
    }else if (index==1)
    {
        [MobClick event:TEMIA_9];
    }else if (index==2)
    {
        [MobClick event:TEMIA_19];
    }else if (index==3)
    {
        [MobClick event:TEMIA_29];
    }
    
    TFSalePurchaseFirstViewController *tfVC = self.childViewControllers[index];
    return tfVC.tableView;

}

#pragma mark - SalePurchaseDownRefreshDelegate
- (void)salePurchaseDownRefresh:(int)index
{
    //    //下拉刷新");
    [self httpZeroShopsRequest];
}

/// 购物车按钮点击
- (void)shoppingCartClick:(UIButton *)sender
{
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *token = [ud objectForKey:USER_TOKEN];
    if (token.length) {
//        WTFCartViewController *spVC = [[WTFCartViewController alloc] init];
//        spVC.segmentSelect = CartSegment_ZeroType;
//        spVC.hidesBottomBarWhenPushed = YES;
//        [self.navigationController pushViewController:spVC animated:YES];
        
        NewShoppingCartViewController *shoppingcart =[[NewShoppingCartViewController alloc]init];
        shoppingcart.ShopCart_Type = ShopCart_NormalType;
        shoppingcart.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:shoppingcart animated:YES];

    } else {
        [self pushLoginAndRegisterView];
    }
}


- (NSMutableArray *)LideImageArr
{
    if (_LideImageArr == nil) {
        _LideImageArr = [[NSMutableArray alloc] init];
    }
    return _LideImageArr;
}

#pragma mark - 新手任务1 (提示分享APP)
- (void)noviceTaskView1
{
    //0元购首页；5秒；无论登录状态；完成后消失
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *flag = [ud objectForKey:UserUUIDFlag];
    //新手任务1
    if ([flag intValue] == 1 && _noviceTimerCount_1!=0) {
        
        if ([_noviceTimer_1 isValid]) {
            [_noviceTimer_1 invalidate];
        }
        _noviceTimer_1 = [NSTimer weakTimerWithTimeInterval:MY_SEC target:self selector:@selector(timeShareAppView) userInfo:nil repeats:YES];
    }
}

- (void)timeShareAppView
{
    _noviceTimerCount_1--;
    //%@ = %d",NoviciateTaskOne, (int)_noviceTimerCount_1);
    if (_noviceTimerCount_1 == 0) {
        
        [_noviceTimer_1 invalidate];
        
        NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
        [ud setObject:[MyMD5 getCurrTimeString:@"year-month-day"] forKey:NoviciateTaskOne];
        
        [ud setBool:NO forKey:UserUUIDFlag];
        
        self.noviceTaskView = [[TFNoviceTaskView alloc] init];
        [self.noviceTaskView returnClick:^(NSInteger type) {
            [self shareAppToWeiXin];
        } withCloseBlock:^(NSInteger type) {
            
            //去吐槽/不去了
            _noviceTimerCount_11 = 55;
            [self noviceTaskView11];
            
        }];
        [self.noviceTaskView showWithType:@"1"];
    }
}

#pragma mark - 新手任务4 (提示注册或者登录)
- (void)noviceTaskView4
{
    //0元购首页，5秒，弹1完成，未登录，登录后不出现
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *token = [ud objectForKey:USER_TOKEN];
    NSString *flag = [ud objectForKey:UserUUIDFlag];
    
    if (token == nil && _noviceTimerCount_4!=0 && [flag intValue] == 0) {
        
        if ([_noviceTimer_4 isValid]) {
            [_noviceTimer_4 invalidate];
        }
        _noviceTimer_4 = [NSTimer weakTimerWithTimeInterval:MY_SEC target:self selector:@selector(timeRegisterView) userInfo:nil repeats:YES];
    }
}

- (void)timeRegisterView
{
    _noviceTimerCount_4--;
    //提示注册或者登录 = %d",(int)_noviceTimerCount_4);
    if (_noviceTimerCount_4 == 0) {
        [_noviceTimer_4 invalidate];
        self.noviceTaskView = [[TFNoviceTaskView alloc] init];
        [self.noviceTaskView returnClick:^(NSInteger type) {
            if (type == 3) {
                LoginViewController *login=[[LoginViewController alloc]init];
                login.tag = 1000;
                login.loginStatue=@"toBack";
                login.hidesBottomBarWhenPushed=YES;
                [self.navigationController pushViewController:login animated:YES];
            } else if (type == 503) {
                LoginViewController *login=[[LoginViewController alloc]init];
                login.tag = 2000;
                login.loginStatue=@"toBack";
                login.hidesBottomBarWhenPushed=YES;
                [self.navigationController pushViewController:login animated:YES];
            }
            
        } withCloseBlock:^(NSInteger type) {
            
        }];
        [self.noviceTaskView showWithType:@"3"];
    }
    
}
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

#pragma mark - 新手任务5 (注册用户未开店)
- (void)noviceTaskView5
{
    //5.6：0元购首页，5秒，弹1完成，已登录未开店
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    
    NSString *noviceTaskView5 = [ud objectForKey:NoviciateTaskFive];
    
    NSString *token = [ud objectForKey:USER_TOKEN];
    NSString *hobby = [ud objectForKey:USER_HOBBY];
    
    NSString *flag = [ud objectForKey:UserUUIDFlag];
    
    //    //hobby =  %@", hobby);
    
    if (noviceTaskView5.length == 0&&token!=nil) {
        if (hobby.length==0 &&_noviceTimerCount_5!=0&& [flag intValue] == 0) {
            
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
    //注册用户未开店 = %d",(int)_noviceTimerCount_5);
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
#pragma mark - 每日任务上下午分享
- (void)dailyTaskView2
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *token = [ud objectForKey:USER_TOKEN];
    NSString *hobby = [ud objectForKey:USER_HOBBY];
    NSString *flag = [ud objectForKey:UserUUIDFlag];
    if (token!=nil && [flag intValue] == 0 && hobby.length!=0 && _dailyTimerCount_2!=0) {
        NSDictionary *oldDic = [ud objectForKey:[NSString stringWithFormat:@"%@%@",[ud objectForKey:USER_ID],DailyTaskAfternoonShare]];
        NSDictionary *currDic = [NSDictionary dictionaryWithObjectsAndKeys:[MyMD5 getCurrTimeString:@"year-month-day"], @"year-month-day", nil];
        if (oldDic == nil||![oldDic[@"year-month-day"] isEqualToString:currDic[@"year-month-day"]]) { //不是同一天
            //判断时间是不是12-19
            /*******一天就弹出一次****/
            
            NSString *hour = [MyMD5 getCurrTimeString:@"hour"];
            if ((hour.intValue <= 23&&hour.intValue>12)||(hour.intValue < 7&&hour.intValue>=0)) {
                
                if ([_dailyTimer_2 isValid]) {
                    [_dailyTimer_2 invalidate];
                }
                
                _dailyTimer_2 = [NSTimer weakTimerWithTimeInterval:SEC_5 target:self selector:@selector(goShareShop:) userInfo:DailyTaskAfternoonShare repeats:YES];
            }
        }
    }
}
- (void)dailyTaskView1
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *token = [ud objectForKey:USER_TOKEN];
    NSString *hobby = [ud objectForKey:USER_HOBBY];
    NSString *flag = [ud objectForKey:UserUUIDFlag];
    
    if (token!=nil && [flag intValue] == 0 && hobby.length!=0 && _dailyTimerCount_1!=0) {
        NSDictionary *oldDic = [ud objectForKey:[NSString stringWithFormat:@"%@%@",[ud objectForKey:USER_ID],DailyTaskMorningShare]];
        NSDictionary *currDic = [NSDictionary dictionaryWithObjectsAndKeys:[MyMD5 getCurrTimeString:@"year-month-day"], @"year-month-day", nil];
        if (oldDic == nil||![oldDic[@"year-month-day"] isEqualToString:currDic[@"year-month-day"]]) { //不是同一天
            //判断时间是不是7-12
            /*******一天就弹出一次****/
            NSString *hour = [MyMD5 getCurrTimeString:@"hour"];
            if (hour.intValue <= 12&& hour.intValue>=7) {
                
                if ([_dailyTimer_1 isValid]) {
                    [_dailyTimer_1 invalidate];
                }
                _dailyTimer_1 = [NSTimer weakTimerWithTimeInterval:MY_SEC target:self selector:@selector(goShareShop:) userInfo:DailyTaskMorningShare repeats:YES];
            }
        }
    }
}
- (void)goShareShop:(NSTimer *)timer
{
    //userInfo = %@", timer.userInfo);
    
    NSString *myType;
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    
    if ([timer.userInfo isEqualToString:DailyTaskMorningShare]) {
        myType = @"2";
        _dailyTimerCount_1--;
        
        //%@ = %d", DailyTaskMorningShare,(int)_dailyTimerCount_1);
        
        if (_dailyTimerCount_1 == 0) {
            [_dailyTimer_1 invalidate];
        }
        
    } else if ([timer.userInfo isEqualToString:DailyTaskAfternoonShare]) {
        myType = @"3";
        _dailyTimerCount_2--;
        
        //%@ = %d", DailyTaskAfternoonShare,(int)_dailyTimerCount_2);
        
        if (_dailyTimerCount_2 == 0) {
            [_dailyTimer_2 invalidate];
        }
    }
    
    if (_dailyTimerCount_1 == 0||_dailyTimerCount_2 == 0) {
        self.dailyTsakView = [[TFDailyTaskView alloc] init];
        [self.dailyTsakView returnClick:^(NSInteger type) {
            
            NSString *theType;
            if (type == 2) {
                theType = DailyTaskMorningShare;
            } else if (type == 3) {
                theType = DailyTaskAfternoonShare;
            }
            
            //获取时间
            NSDictionary *currDic = [NSDictionary dictionaryWithObjectsAndKeys:[MyMD5 getCurrTimeString:@"year-month-day"], @"year-month-day", nil];
            //存储状态
            //        [ud setObject:currDic forKey:[NSString stringWithFormat:@"%@%@",[ud objectForKey:USER_ID],theType]];
            
            //存储状态
            [ud setObject:currDic forKey:[NSString stringWithFormat:@"%@%@",[ud objectForKey:USER_ID],DailyTaskMorningShare]];
            [ud setObject:currDic forKey:[NSString stringWithFormat:@"%@%@",[ud objectForKey:USER_ID],DailyTaskAfternoonShare]];
            
            [ud synchronize];
            
            [self httpGetRandShopWithType:theType];
        } withCloseBlock:^(NSInteger type) {
            
            //去吐槽
            _noviceTimerCount_11 = 55;
            [self noviceTaskView11];
            
            
//            NSString *theType;
//            if (type == 2) {
//                theType = DailyTaskMorningShare;
//            } else if (type == 3) {
//                theType = DailyTaskAfternoonShare;
//            }
            //获取时间
            NSDictionary *currDic = [NSDictionary dictionaryWithObjectsAndKeys:[MyMD5 getCurrTimeString:@"year-month-day"], @"year-month-day", nil];
            //存储状态
            //        [ud setObject:currDic forKey:[NSString stringWithFormat:@"%@%@",[ud objectForKey:USER_ID],theType]];
            
            //存储状态
            [ud setObject:currDic forKey:[NSString stringWithFormat:@"%@%@",[ud objectForKey:USER_ID],DailyTaskMorningShare]];
            [ud setObject:currDic forKey:[NSString stringWithFormat:@"%@%@",[ud objectForKey:USER_ID],DailyTaskAfternoonShare]];
            
            [ud synchronize];
            
        }];
        [self.dailyTsakView showWithType:myType];
    }
}

- (void)httpGetRandShopWithType:(NSString *)myType
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *token = [ud objectForKey:USER_TOKEN];
    NSString *realm = [ud objectForKey:USER_REALM];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    
    NSString *urlStr;
    
    if ([myType isEqualToString:DailyTaskMorningShare]||[myType isEqualToString:DailyTaskAfternoonShare]) {
        urlStr = [NSString stringWithFormat:@"%@shop/shareShop?token=%@&version=%@&realm=%@",[NSObject baseURLStr], token,VERSION, realm];
    }
    NSString *URL = [MyMD5 authkey:urlStr];
    [MBProgressHUD showMessage:@"启动分享中,请稍后" afterDeleay:0 WithView:self.view];
    [manager GET:URL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        responseObject = [NSDictionary changeType:responseObject];
        //分享商品 = %@", responseObject);
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if (responseObject!=nil) {
            if ([responseObject[@"status"] intValue] == 1) {
                NSString *QrLink = responseObject[@"QrLink"];
                NSNumber *shop_se_price = responseObject[@"shop"][@"shop_se_price"];
                NSString *four_pic = responseObject[@"shop"][@"four_pic"];
                NSArray *picArr = [four_pic componentsSeparatedByString:@","];
                
                NSString *pic = [picArr lastObject];
                NSString *shop_code = responseObject[@"shop"][@"shop_code"];
                NSString *sup_code  = [shop_code substringWithRange:NSMakeRange(1, 3)];
                NSString *share_pic = [NSString stringWithFormat:@"%@/%@/%@", sup_code, shop_code, pic];
                
                [self httpGetShareImageWithPrice:shop_se_price QRLink:QrLink sharePicUrl:share_pic type:myType];
                
            }else
                [MBProgressHUD showError:responseObject[@"message"]];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
    
}


- (void)httpGetShareImageWithPrice:(NSNumber *)shop_price QRLink:(NSString *)qrLink sharePicUrl:(NSString *)picUrl type:(NSString *)myType
{
    [MBProgressHUD showMessage:@"启动分享中,请稍后" afterDeleay:0 WithView:self.view];
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    
    NSString *url = [NSString stringWithFormat:@"%@%@",[NSObject baseURLStr_Upy], picUrl];
    //url = %@", url);
    
    manager.responseSerializer = [AFImageResponseSerializer serializer];
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        responseObject = [NSDictionary changeType:responseObject];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if (responseObject!=nil) {
            NSData *imgData = UIImagePNGRepresentation(responseObject);
            self.shareRandShopImage = [UIImage imageWithData:imgData];
            
            [self shareRandShopWithPrice:shop_price QRLink:qrLink sharePicUrl:picUrl type:myType];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
    
}

- (void)shareRandShopWithPrice:(NSNumber *)shop_price QRLink:(NSString *)qrLink sharePicUrl:(NSString *)picUrl type:(NSString *)myType
{
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"weixin://"]]) {
        
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        [appDelegate shardk];
        
//        UIImage *QRImage =[[UIImage alloc] init];
        UIImage *QRImage = [QRCodeGenerator qrImageForString:qrLink imageSize:160];
        
        ProduceImage *pi = [[ProduceImage alloc] init];
        UIImage *newimg = [pi getImage:self.shareRandShopImage withQRCodeImage:QRImage withText:nil withPrice:[NSString stringWithFormat:@"%@",shop_price] WithTitle:nil];
        
        DShareManager *ds = [DShareManager share];
        ds.delegate = self;
        
        [ds shareAppWithType:ShareTypeWeixiTimeline withImageShareType:myType withImage:newimg];
    } else {
        
        NavgationbarView *nv = [[NavgationbarView alloc] init];
        [nv showLable:@"没有安装微信" Controller:self];
    }
}



#pragma mark - 分享代理
- (void)DShareManagerStatus:(SHARESTATE)shareStatus withType:(NSString *)type
{
    NavgationbarView *nv = [[NavgationbarView alloc] init];
    
    //type = %@", type);
    
    if ([type isEqualToString:NoviciateTaskOne]) {
        if (shareStatus == 1) {
            
            //去吐槽
            _noviceTimerCount_11 = 55;
            [self noviceTaskView11];
            
            [self httpShareSuccessWithType:type];
            
        } else if (shareStatus == 2) {
            
            //去吐槽
            _noviceTimerCount_11 = 55;
            [self noviceTaskView11];
            
            [nv showLable:@"分享失败" Controller:self];
            
        } else if (shareStatus == 3) {
            
            //去吐槽
            _noviceTimerCount_11 = 55;
            [self noviceTaskView11];
            
            //            [nv showLable:@"分享取消" Controller:self];
            
        }
    } else if ([type isEqualToString:DailyTaskMorningShare]||[type isEqualToString:DailyTaskAfternoonShare]) {
        if (shareStatus == 1) {
            
            //去吐槽
            _noviceTimerCount_11 = 55;
            [self noviceTaskView11];
            
            [self httpShareSuccessWithType:type];
            
        } else if (shareStatus == 2) {
            
            
            //去吐槽
            _noviceTimerCount_11 = 55;
            [self noviceTaskView11];
            [nv showLable:@"分享失败" Controller:self];
            
            
        } else if (shareStatus == 3) {
            
            //去吐槽
            _noviceTimerCount_11 = 55;
            [self noviceTaskView11];
            //            [nv showLable:@"分享取消" Controller:self];
            
        }
    }
}


#pragma mark 分享成功后
-(void)httpShareSuccessWithType:(NSString *)type
{
    NavgationbarView *nv = [[NavgationbarView alloc] init];
    
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *paraments=[NSMutableDictionary dictionary];
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    //	NSString *realm = [NSString stringWithFormat:@"%@",[ud objectForKey:USER_REALM]];
    NSString *token = [NSString stringWithFormat:@"%@",[ud objectForKey:USER_TOKEN]];
    
    NSString *urlStr;
    if ([type isEqualToString:NoviciateTaskOne]) {
        
        if(token!=nil)
        {
            urlStr = [NSString stringWithFormat:@"%@activaShare/activaShare?version=%@&imei=%@&token=%@",[NSObject baseURLStr], VERSION,[ud objectForKey:USER_UUID],token];
        } else{
            
            urlStr = [NSString stringWithFormat:@"%@activaShare/activaShare?version=%@&imei=%@",[NSObject baseURLStr], VERSION,[ud objectForKey:USER_UUID]];
        }
        
        
        
    } else if ([type isEqualToString:DailyTaskMorningShare]) {
        urlStr = [NSString stringWithFormat:@"%@mission/doMission?version=%@&token=%@&m_id=7",[NSObject baseURLStr], VERSION,token];
    } else if ([type isEqualToString:DailyTaskAfternoonShare]) {
        urlStr = [NSString stringWithFormat:@"%@mission/doMission?version=%@&token=%@&m_id=8",[NSObject baseURLStr], VERSION,token];
    }
    NSString *URL=[MyMD5 authkey:urlStr];
    
    [manager POST:URL parameters:paraments success:^(AFHTTPRequestOperation *operation, id responseObject) {
        responseObject = [NSDictionary changeType:responseObject];
        //分享调用接口 res = %@",responseObject);
        
        if (responseObject!=nil) {
            if ([responseObject[@"status"] intValue] == 1) {
                
                if ([type isEqualToString:NoviciateTaskOne]) {
                    [nv showLable:@"分享成功" Controller:self];
                    
                    _noviceTimerCount_4 = 5;
                    
                    //0元购首页，5秒，弹1完成，未登录，登录后不出现
                    //                    [self noviceTaskView4];
                    
                } else if ([type isEqualToString:DailyTaskMorningShare]) {
                    
//                    NSArray *messageArr = @[@"任务完成,恭喜获得50积分",
//                                            @"不存在此任务",
//                                            @"此任务属于新手任务",
//                                            @"此任务今天不能完成",
//                                            @"今日已经完成此任务",
//                                            @"不能执行上午分享任务",
//                                            @"不能执行下午分享任务",
//                                            @"分享次数已经到达限制"];
//
//                    if (flag<=messageArr.count-1) {
//                        [nv showLable:messageArr[flag] Controller:self];
//                    }
                    
                    int flag = [responseObject[@"flag"] intValue];
                    int num = [responseObject[@"num"] intValue];
                    
//                    int newFlag = [responseObject[@"newFlag"] intValue];
//                    int newNum = [responseObject[@"newNum"] intValue];
                    
                    if (flag == 0) {
                        [nv showLable:[NSString stringWithFormat:@"任务完成,恭喜获得%d积分", num] Controller:self];
                    }
                } else if ([type isEqualToString:DailyTaskAfternoonShare]) {
                    int flag = [responseObject[@"flag"] intValue];
                    int num = [responseObject[@"num"] intValue];
                    
//                    int newFlag = [responseObject[@"newFlag"] intValue];
//                    int newNum = [responseObject[@"newNum"] intValue];
                    
                    if (flag == 0) {
                        [nv showLable:[NSString stringWithFormat:@"任务完成,恭喜获得%d积分", num] Controller:self];
                    }
                }
                
            } else {
                [nv showLable:responseObject[@"message"] Controller:self];
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    }];
    
}

- (void)loadView
{
    UIView *view = [UIView new];
    view.frame = CGRectMake(0, 44, kScreenWidth, kScreenHeight-kNavigationheightForIOS7);
    self.view = view;
}

- (void)setSaleDelegate:(id<TFSaleDelegate>)saleDelegate
{
    _saleDelegate = saleDelegate;
    _delegateFlags.salePageViewScrollSetTabBarStatus = [saleDelegate respondsToSelector:@selector(salePageViewScrollSetTabBarStatus:animation:)];
    _delegateFlags.saleTitleTopStatus = [saleDelegate respondsToSelector:@selector(saleTitleTopStatus:)];
}
- (void)slidePageScrollView:(TYSlidePageScrollView *)slidePageScrollView verticalScrollViewDidScroll:(UIScrollView *)pageScrollView
{
    if (pageScrollView.contentSize.height <= CGRectGetHeight(pageScrollView.bounds)-49-(self.bannerHeight+self.titleHeight)) {
        
        if (_delegateFlags.salePageViewScrollSetTabBarStatus) {
            [self.saleDelegate salePageViewScrollSetTabBarStatus:TabBarStutesNormal animation:NO];
        }
        
        return;
    } else if (pageScrollView.panGestureRecognizer.state == UIGestureRecognizerStateChanged){
        CGFloat nowPanOffsetY = [pageScrollView.panGestureRecognizer translationInView:pageScrollView.superview].y;
        CGFloat diffPanOffsetY = nowPanOffsetY - _oldPointY;
        
        if (ABS(diffPanOffsetY) > 5) {
            
            if (diffPanOffsetY <0) {
                
                if (_delegateFlags.salePageViewScrollSetTabBarStatus) {
                    [self.saleDelegate salePageViewScrollSetTabBarStatus:TabBarStutesBottom animation:YES];
                }
                
                
            } else {
                if (_delegateFlags.salePageViewScrollSetTabBarStatus) {
                    [self.saleDelegate salePageViewScrollSetTabBarStatus:TabBarStutesNormal animation:YES];
                }
            }
        }
        _oldPointY = nowPanOffsetY;
        
    }
}

- (void)slidePageScrollView:(TYSlidePageScrollView *)slidePageScrollView pageTabBarScrollOffset:(CGFloat)offset state:(TFPageTabBarState)state
{
    [self pageTabBarState:state];
    self.pageTabBarState = state;
}

- (void)tableViewWithScrollViewWillBeginDragging:(UIScrollView *)scrollView index:(int)index
{
    
    _oldPointY = [scrollView.panGestureRecognizer translationInView:scrollView.superview].y;
}

- (void)tableViewWithScrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate index:(int)index
{
    
    _oldPointY = 0;
    if (decelerate == NO) {
        
    } else{
        
    }
    
}

- (void)tableViewWithScrollViewWillBeginDecelerating:(UIScrollView *)scrollView index:(int)index
{
    
}

- (void)tableViewWithscrollViewDidEndDecelerating:(UIScrollView *)scrollView index:(int)index
{
    if (_delegateFlags.salePageViewScrollSetTabBarStatus) {
//        [self.saleDelegate salePageViewScrollSetTabBarStatus:TabBarStutesNormal animation:YES];
    }
}

- (void)pageTabBarState:(TFPageTabBarState)state
{
//    MyLog(@"sale state: %lu", (unsigned long)state);
    if (state == TFPageTabBarStateStopOnTop || state == TFPageTabBarStateScrolling) {
        if (_delegateFlags.saleTitleTopStatus) {
            [self.saleDelegate saleTitleTopStatus:YES];
        }
    } else {
        if (_delegateFlags.saleTitleTopStatus) {
            [self.saleDelegate saleTitleTopStatus:NO];
        }
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
