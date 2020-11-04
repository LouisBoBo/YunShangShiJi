//
//  TFSalePurchaseViewController.m
//  YunShangShiJi
//
//  Created by 云商 on 15/11/27.
//  Copyright © 2015年 ios-1. All rights reserved.
//  特卖

#import "TFSalePurchaseViewController.h"
#import "TFSalePurchaseFirstViewController.h"
#import "GlobalTool.h"
 
#import "TFSlidePageScrollView.h"
#import "TFCustomTitleView.h"
#import "LoginViewController.h"

#import "NewShoppingCartViewController.h"
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
//#import "ChatListViewController.h"
#import "H5activityViewController.h"

#import "WTFAlertView.h"
#define NavigationHeight 44.0f
#define StatusTableHeight 20.0f
#define TableBarHeight 49.0f

@interface TFSalePurchaseViewController () <TFSlidePageScrollViewDataSource, TFSlidePageScrollViewDelegate, DShareManagerDelegate, UIAlertViewDelegate, SalePurchasecustomDelegate>

{
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
@property (nonatomic, strong)UILabel *shoppingCartLabel;
@property (nonatomic, assign)NSInteger currPageIndex;
@property (nonatomic, assign)NSInteger countIndex;

@property (nonatomic, strong)TFNoviceTaskView *noviceTaskView;
@property (nonatomic, strong)TFDailyTaskView *dailyTsakView;

@property (nonatomic, strong)NSMutableArray *LideImageArr;
@property (nonatomic, strong)UIImage *shareAppImg;
@property (nonatomic, strong)UIImage *shareRandShopImage;

@property (nonatomic, assign)CGFloat titleHeight;
@property (nonatomic, assign)CGFloat bannerHeight;
@property (nonatomic, assign) BOOL isCardDisplay;

@end

@implementation TFSalePurchaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 数据初始化
    [self getData];
    // 创建UI
    [self setupUI];
    // 加载轮播图
    [self httpsLideImageRequest];
    // 创建导航栏
    [self createNavigationItem];
    
    [_slidePageScrollView reloadData];
    
    [self httpGetShareImage];
    
}

#pragma mark - view将要出现
- (void)viewWillAppear:(BOOL)animated
{
//    [self showSignViewTwoOrFive:@"签到_5元现金"];
    [MobClick beginLogPageView:@"TemaiPage"];

    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    //isUpdata = %d",appDelegate.isUpdata);
    //    Myview.hidden=NO;
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *token = [ud objectForKey:USER_TOKEN];
    
    if (token.length) {
        [self httpGetShopCartCount];
    } else {
        self.shoppingCartLabel.hidden = YES;
    }


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
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSString *urlStr = [NSString stringWithFormat:@"%@coupon/addVoucher?token=%@&version=%@", [NSObject baseURLStr], token, VERSION];
    NSString *URL = [MyMD5 authkey:urlStr];
    
    [manager GET:URL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        MyLog("res: %@", responseObject);
        responseObject = [NSDictionary changeType:responseObject];
        NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
        NSString *oldDate = [ud objectForKey:RedCash];
        
//        MyLog(@"oldDate: %@", oldDate);
        
        if (responseObject!=nil) {
            if ([responseObject[@"status"] intValue] == 1) {
                
                NSInteger isRedCards = 0;
                
                if (responseObject[@"num"]!=nil) {
                    int num = [responseObject[@"num"] intValue];
                    
                    if (num == 0) {
                        
                        isRedCards = 1;
                        
                    } else {
                        isRedCards = 2;
                    }
                    
                    [self redCadsDisplay:isRedCards];

                }
                
            } else {
                
            }
            
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
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
    NSString *currDate = [NSString stringWithFormat:@"%@%@", USER_ID, [MyMD5 getCurrTimeString:@"year-month-day"]];
    
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
    //url = %@", url);
    
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
    
#if 0
    for (UIView *view in self.mainScorllView.scrollView.subviews) {
        [view removeFromSuperview];
    }
    
    NSMutableArray *viewArr = [[NSMutableArray alloc] init];
    
    for (int i = 0; i<self.LideImageArr.count; i++) {
        
        TFShopModel *sModel = self.LideImageArr[i];
        UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, self.bannerHeight)];
        
        NSURL *imgUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@!560",[NSObject baseURLStr_Upy],sModel.url]];
        
//        //imgUrl = %@", imgUrl);
        
        __block float d = 0;
        __block BOOL isDownlaod = NO;
        [iv sd_setImageWithURL:imgUrl placeholderImage:nil options:SDWebImageRetryFailed progress:^(NSInteger receivedSize, NSInteger expectedSize) {
            d = (float)receivedSize/expectedSize;
            isDownlaod = YES;
        } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            if (image != nil && isDownlaod == YES) {
                iv.alpha = 0;
                [UIView animateWithDuration:0.5 animations:^{
                    iv.alpha = 1;
                } completion:^(BOOL finished) {
                }];
            } else if (image != nil && isDownlaod == NO) {
                iv.image = image;
            }
        }];
        
        [viewArr addObject:iv];
    }
    
    self.mainScorllView.fetchContentViewAtIndex = ^UIView *(NSInteger pageIndex){
        return viewArr[pageIndex];
    };
    self.mainScorllView.totalPagesCount = ^NSInteger(void){
        return viewArr.count;
    };
    
    self.mainScorllView.backgroundColor = [[UIColor purpleColor] colorWithAlphaComponent:0.1];
    
    __weak TFSalePurchaseViewController *tp = self;
    
    self.mainScorllView.TapActionBlock = ^(NSInteger pageIndex){
        //点击 %d",(int) pageIndex);
        if(pageIndex == 0)
        {
            
        }else{
            
//            TFShopModel *sModel = (TFShopModel *)tp.LideImageArr[pageIndex];
//            ComboShopDetailViewController *detail=[[ComboShopDetailViewController alloc] initWithNibName:@"ComboShopDetailViewController" bundle:nil];
//            detail.shop_code = sModel.shop_code;
//            //        //pcode = %@", sModel.shop_code);
//            detail.hidesBottomBarWhenPushed=YES;
//            [tp.navigationController pushViewController:detail animated:YES];
        }
        
        
    };
    
#endif
    
    __weak TFSalePurchaseViewController *tp = self;
    NSMutableArray *topimageArry = [NSMutableArray array];
//    for (int i = 0; i<self.LideImageArr.count; i++) {
//        
//        TFShopModel *sModel = self.LideImageArr[i];
//        
//        NSURL *imgUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@!560",[NSObject baseURLStr_Upy],sModel.url]];
//        
//        UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:imgUrl]];
//        
//        if(image)
//        {
//            [topimageArry addObject:image];
//        }
//    }
    
//    UIImage *image = [UIImage imageNamed:@"宋仲基-红包轮播-min"];
//    [topimageArry addObject:image];
    
    for (int i = 0; i < _LideImageArr.count; i++) {
        TFShopModel *model=_LideImageArr[i];
        NSString *imgUrlStr = [NSString stringWithFormat:@"%@%@!560",[NSObject baseURLStr_Upy],model.url];
        
//        MyLog(@"imgUrlStr: %@", imgUrlStr);

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
        //点击 %d",(int) page);
        
        
        
        MyLog(@"page = %d",(int)page);
        
        TFShopModel *model = (TFShopModel *)tp.LideImageArr[page];
        
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
-(void)httpsLideImageRequest
{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *paraments=[NSMutableDictionary dictionary];
    
    NSString *urlStr = [NSString stringWithFormat:@"%@shop/queryOption?version=%@&type=3",[NSObject baseURLStr],VERSION];
    
    NSString *URL=[MyMD5 authkey:urlStr];
    
    [manager POST:URL parameters:paraments success:^(AFHTTPRequestOperation *operation, id responseObject) {
        responseObject = [NSDictionary changeType:responseObject];
        NSString *status=responseObject[@"status"];
        
        //轮播图res = %@",responseObject);
        
        if(status.intValue==1) {
            
            
            if (responseObject[@"zeroShops"]!=nil) {
                NSArray *topShopsArr = responseObject[@"zeroShops"];
                
                [self.LideImageArr removeAllObjects];
                
                for (NSDictionary *dic in topShopsArr) {
                    TFShopModel *sModel = [[TFShopModel alloc] init];
                    sModel.ID = dic[@"id"];
                    [sModel setValuesForKeysWithDictionary:dic];
                    
                    [self.LideImageArr addObject:sModel];
                }
                
//                //LideImageArr = %@", self.LideImageArr);
                
                if (self.LideImageArr.count) {
                    [self refreshLideImage];
                }
            }
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        
    }];
    
}

/// 加载购物车商品数
- (void)httpGetShopCartCount
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *token = [ud objectForKey:USER_TOKEN];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSString *urlStr = [NSString stringWithFormat:@"%@shopCart/shopCartCount?version=%@&token=%@",[NSObject baseURLStr],VERSION,token];
    NSString *URL = [MyMD5 authkey:urlStr];
    [manager GET:URL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        responseObject = [NSDictionary changeType:responseObject];
        //购物车 = %@", responseObject);
        if (responseObject!=nil) {
            int status = [responseObject[@"status"] intValue];
            if (status == 1) {
                self.shoppingCartLabel.hidden = NO;
                self.shoppingCartLabel.text = [NSString stringWithFormat:@"%@",responseObject[@"cart_count"]];
                if([responseObject[@"cart_count"] intValue] <1)
                {
                   self.shoppingCartLabel.hidden = YES;
                }
                
            } else if (status == 10030) {
                
                LoginViewController *login=[[LoginViewController alloc]init];
                login.tag=1000;
                login.loginStatue = @"10030";
                login.hidesBottomBarWhenPushed=YES;
                [self.navigationController pushViewController:login animated:YES];
                
            } else {
                
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //
    }];
    
}

- (void)getData
{
    self.navigationController.navigationBar.hidden = YES;
    self.view.backgroundColor = RGBCOLOR_I(220,220,220);
    
    
    NSArray *normalImgArr = [NSArray arrayWithObjects:[UIImage imageNamed:@"qiandao_2yuan"],
                             [UIImage imageNamed:@"qiandao_2yuan"],
                             [UIImage imageNamed:@"qiandao_2yuan"],
                             [UIImage imageNamed:@"qiandao_2yuan"], nil];
    
    UIImage *img = normalImgArr[0];
    CGFloat W_btn = ceil(kScreenWidth/normalImgArr.count);
    CGFloat H_btn = ceil(img.size.height/img.size.width*W_btn);
    
    self.bannerHeight = kScreenWidth/3;
    self.titleHeight = H_btn+(int)ZOOM(100);
    
    self.currPageIndex = 0;
    self.countIndex = 4;
    
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
    NSArray *selectImgArr = [NSArray arrayWithObjects:[UIImage imageNamed:@"selected_-0yuan"],
                             [UIImage imageNamed:@"selected_-9yuan"],
                             [UIImage imageNamed:@"selected_-19yuan"],
                             [UIImage imageNamed:@"selected_-29yuan"], nil];
    
    NSArray *normalImgArr = [NSArray arrayWithObjects:[UIImage imageNamed:@"normal_0yuan"],
                             [UIImage imageNamed:@"normal_9yuan"],
                             [UIImage imageNamed:@"normal_19yuan"],
                             [UIImage imageNamed:@"normal_29yuan"], nil];
    
//    UIImage *img = normalImgArr[0];
//    
//    CGFloat W_btn = ceil(kScreenWidth/normalImgArr.count);
//    CGFloat H_btn = ceil(img.size.height/img.size.width*W_btn);
//    
    CGRect frame = CGRectMake(0, 0, CGRectGetWidth(_slidePageScrollView.frame), self.titleHeight);
    
    self.nTitleView = [TFCustomTitleView scrollWithFrame:frame withTag:0 wintIndex:0 withNormalImage:normalImgArr withSelectImage:selectImgArr];
    self.nTitleView.backgroundColor = [UIColor blackColor];
    
    UIView *backgroundViwe = [[UIView alloc] initWithFrame:CGRectMake(0, self.titleHeight-(int)ZOOM(100), CGRectGetWidth(self.nTitleView.frame), (int)ZOOM(100))];
    backgroundViwe.backgroundColor = [UIColor whiteColor];
    [self.nTitleView addSubview:backgroundViwe];
    
    UIView *bottomLine = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(backgroundViwe.frame)-0.5, CGRectGetWidth(backgroundViwe.frame), 0.5)];
//    bottomLine.backgroundColor = RGBCOLOR_I(168, 168, 168);
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
    
}


- (void)addSlidePageScrollView
{
    CGRect frame = CGRectMake(0, NavigationHeight+StatusTableHeight, kScreenWidth, CGRectGetHeight(self.view.frame)-(NavigationHeight+StatusTableHeight));
    TFSlidePageScrollView *slidePageScrollView = [[TFSlidePageScrollView alloc]initWithFrame:frame];
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
    
    self.nheadView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(_slidePageScrollView.frame), H_main+10)];
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
    
    self.nheadView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(_slidePageScrollView.frame), H_main+10)];
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
    CGRect frame = CGRectMake(0, 0, CGRectGetWidth(_slidePageScrollView.frame), TableBarHeight);
    
    UIView *footerView = [[UIView alloc]initWithFrame:frame];
    footerView.backgroundColor = [UIColor clearColor];
    _slidePageScrollView.footerView = footerView;
}


- (void)addViewController
{
    for (int i = 0; i<self.countIndex; i++) {
        
        TFSalePurchaseFirstViewController *tfVC  = [[TFSalePurchaseFirstViewController alloc] init];
        tfVC.type = [NSString stringWithFormat:@"%d",i+1];
        tfVC.myChoose = ChooseBuyPackage;
        tfVC.headHeight = self.bannerHeight+10+self.titleHeight;
        tfVC.customDelegate = self;
        
        [self addChildViewController:tfVC];
        
    }
}

#pragma mark - TFSlidePageScrollViewDataSource
- (NSInteger)numberOfPageViewOnSlidePageScrollView
{
    return self.childViewControllers.count;
}

- (UIScrollView *)slidePageScrollView:(TFSlidePageScrollView *)slidePageScrollView pageVerticalScrollViewForIndex:(NSInteger)index
{
    
    //    if (index<=self.countIndex-1) {
    //        TFSalePurchaseFirstViewController *tfVC = self.childViewControllers[index];
    //        return tfVC.tableView;
    //    } else {
    //        TFSalePurchaseTwoViewController *tfVC = self.childViewControllers[index];
    //        return tfVC.tableView;
    //    }
    
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

//    tfVC.myChoose = ChooseBuyPackage;
    
    return tfVC.tableView;
    //    return 0;
}

#pragma mark - SalePurchaseDownRefreshDelegate
- (void)salePurchaseDownRefresh:(int)index
{
    //    //下拉刷新");
    [self httpsLideImageRequest];
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

/// 创建导航栏
- (void)createNavigationItem
{
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, NavigationHeight+StatusTableHeight)];
    headView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:headView];
    
    CGFloat H_iv = 25;
    CGFloat W_iv = 131/52.0*H_iv;
    
    UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectMake((kScreenWidth-W_iv)*0.5, 20+(44-H_iv)*0.5, W_iv, H_iv)];
    iv.image = [UIImage imageNamed:@"tf_0元购"];
    //    iv.backgroundColor = COLOR_RANDOM;
//    [headView addSubview:iv];
    
    UILabel *titlelable = [[UILabel alloc]initWithFrame:CGRectMake(40, 20, kScreenWidth - 40*2, 44)];
    titlelable.text = @"超值特卖";
    titlelable.font = kNavTitleFontSize;
    titlelable.textAlignment = NSTextAlignmentCenter;
    [headView addSubview:titlelable];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(kScreenWidth-60, 20, 60, 44);
    btn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [btn setImage:[UIImage imageNamed:@"0_购物车"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(shoppingCartClick:) forControlEvents:UIControlEventTouchUpInside];
    [headView addSubview:btn];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetWidth(btn.frame)-20-5, 5, 15, 15)];
    label.layer.cornerRadius = 15*0.5;
    label.layer.masksToBounds = YES;
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.adjustsFontSizeToFitWidth = YES;
    label.backgroundColor = COLOR_ROSERED;
    label.font = [UIFont systemFontOfSize:10];
    [btn addSubview:_shoppingCartLabel = label];
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
        [ud setObject:[self getCurrTimeString:@"year-month-day"] forKey:NoviciateTaskOne];
        
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
            NSDictionary *currDic = [NSDictionary dictionaryWithObjectsAndKeys:[self getCurrTimeString:@"year-month-day"], @"year-month-day", nil];
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
            
            
            NSString *theType;
            if (type == 2) {
                theType = DailyTaskMorningShare;
            } else if (type == 3) {
                theType = DailyTaskAfternoonShare;
            }
            //获取时间
            NSDictionary *currDic = [NSDictionary dictionaryWithObjectsAndKeys:[self getCurrTimeString:@"year-month-day"], @"year-month-day", nil];
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
        
        UIImage *QRImage =[[UIImage alloc] init];
        QRImage = [QRCodeGenerator qrImageForString:qrLink imageSize:160];
        
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
                    
                    int newFlag = [responseObject[@"newFlag"] intValue];
                    int newNum = [responseObject[@"newNum"] intValue];
                    
                    if (flag == 0) {
                        [nv showLable:[NSString stringWithFormat:@"任务完成,恭喜获得%d积分", num] Controller:self];
                    }
                } else if ([type isEqualToString:DailyTaskAfternoonShare]) {
                    int flag = [responseObject[@"flag"] intValue];
                    int num = [responseObject[@"num"] intValue];
                    
                    int newFlag = [responseObject[@"newFlag"] intValue];
                    int newNum = [responseObject[@"newNum"] intValue];
                    
                    if (flag == 0) {
                        [nv showLable:[NSString stringWithFormat:@"任务完成,恭喜获得%d积分", num] Controller:self];
                    }
                }
                
            } else {
                [nv showLable:responseObject[@"message"] Controller:self];
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //网络连接失败");
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

