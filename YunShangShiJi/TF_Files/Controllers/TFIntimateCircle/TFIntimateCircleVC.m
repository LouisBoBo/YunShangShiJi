//
//  TFIntimateCircleVC.m
//  YunShangShiJi
//
//  Created by jingaiweiyi on 2017/2/14.
//  Copyright © 2017年 ios-1. All rights reserved.
//

#import "TFIntimateCircleVC.h"
#import "TYSlidePageScrollView.h"
#import "CustomTitleView.h"
#import "TFSubIntimateCircleVC.h"
#import "TFPublishThemeVC.h"
#import "TFPublishDress.h"
#import "ScrollView_public.h"
#import "BaseModel.h"
#import "PagerModel.h"
#import "ShopDetailViewController.h"
#import "H5activityViewController.h"
#import "TFCollocationViewController.h"
#import "SpecialDetailViewController.h"
#import "TopicDetailViewController.h"
#import "CollocationDetailViewController.h"
#import "MessageCenterVC.h"
#import "AddPhotoTagsViewController.h"
#import "AddTagsViewController.h"
#import "CFImagePickerVC.h"
#import "DataManager.h"
#import "ShareAnimationView.h"
#import "MakeMoneyViewController.h"
#import "TFPopBackgroundView.h"
#import "VitalityTaskPopview.h"
#import "TFMyWalletViewController.h"
#import "MyOrderViewController.h"
#import "OneYuanModel.h"

@interface bannerListModel : NSObject
@property (nonatomic, copy) NSString *link;
@property (nonatomic, copy) NSString *pic;

@property (nonatomic, strong) NSNumber *type;

@property (nonatomic, copy) NSString *shop_code;
@property (copy, nonatomic) NSString *shop_name;
@property (copy, nonatomic) NSString *def_pic;
@property (copy, nonatomic) NSString *four_pic;
@property (strong, nonatomic) NSNumber *shop_se_price;
@property (strong, nonatomic) NSNumber *shop_status;
@property (strong, nonatomic) NSNumber *kickback;
@property (strong, nonatomic) NSNumber *virtual_sales;
@property (strong, nonatomic) NSNumber *shop_price;
@property (strong, nonatomic) NSNumber *supp_label_id;
@property (copy, nonatomic) NSString *supp_label;

@property (strong, nonatomic) NSNumber *ID;
@property (copy, nonatomic) NSString *url;
@property (copy, nonatomic) NSString *h5_url;
@property (copy, nonatomic) NSString *remark;
@property (strong, nonatomic) NSNumber *option_type;
@property (nonatomic , strong)NSString *name;
@property (nonatomic , strong)NSString *content1;
@property (nonatomic , strong)NSString *content2;
@property (nonatomic , strong)VitalityTaskPopview *vitaliview;
@end
@implementation bannerListModel
@end


@interface TFIntimateCircleVC ()  <TYSlidePageScrollViewDelegate, TYSlidePageScrollViewDataSource, CAAnimationDelegate, TFSubIntimateCircleDelegate> {
    CGFloat HeaderView_H;
    CGFloat FooterView_H;
    CGFloat TabPageMenu_H;
    
    UIView *redCountView;
    UIView *messageCountView;
    UILabel *messageCountLabel;
    
    ShareAnimationView *_aView;

}
@property (nonatomic, strong ) UIButton                  *rightButton;

@property (nonatomic, strong) TYSlidePageScrollView *slidePageScrollView;
@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) UIView *footerView;
@property (nonatomic, strong) CustomTitleView *titleView;
@property (nonatomic, strong) ScrollView_public *bannersView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) UIView *naView;
@property (nonatomic, strong) UIButton *publishButton;
@property (nonatomic, strong) UIView *backgroundView;

@property (nonatomic, strong) NSMutableArray *banners;
@property (nonatomic, strong) UIScrollView *currScrollView;
@end

@implementation TFIntimateCircleVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setData];
    
    [self setUI];
    
}

#pragma mark - Data
- (void)setData {
    HeaderView_H = kScreen_Width * 0.5;
    FooterView_H = 0;
    TabPageMenu_H = ZOOM6(80);
}

- (void)getData {
    NSArray *arrar = @[@"话题广场", @"蜜友"];
    [self.dataSource addObjectsFromArray:arrar];
    
    [self.titleView refreshTitleViewUI:self.dataSource withImgNames:nil];
    
    
    [self addCollectionViewWithPageScrollView];
    
    [self.slidePageScrollView reloadData];
    
    [self httpBannerList];
    
    self.currScrollView = [self slidePageScrollView:self.slidePageScrollView pageVerticalScrollViewForIndex:0];
}

#pragma mark - UI
- (void)setUI {
    
    self.is_pushCome?[self creatHeadView]:[self setNavigationItem];
    
    [self addSlidePageScrollView];
    [self addHeaderView];
    [self addFooterView];
    [self addTabPageMenu];
    
//    [self addPublishTopic];
    [self getData];
}

- (void)shareRecommendRefresh
{
    [NSObject delay:0.5 completion:^{
        [self.currScrollView ffRefreshHeaderBeginRefreshing];
    }];
    
}
- (void)addPublishTopic {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:[UIImage imageNamed:@"miyou_icon_+_fabu"] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:@"miyou_icon_close"] forState:UIControlStateSelected];
    [self.view addSubview:_publishButton = button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(ZOOM6(110), ZOOM6(110)));
        make.right.equalTo(self.view.mas_right).offset(-ZOOM6(46));
        make.bottom.equalTo(self.view.mas_bottom).offset(-(kTabBar_Height + ZOOM6(30)));
    }];
    
    kSelfWeak;
    [button handleClickEvent:UIControlEventTouchUpInside withClickBlock:^(UIButton *sender) {
        [weakSelf loginSuccess:^{
            sender.hidden = YES;
            CFImagePickerVC *doimg = [[CFImagePickerVC alloc] init];
            doimg.nColumnCount = 4;
            doimg.nResultType = DO_PICKER_RESULT_UIIMAGE;
            doimg.nMaxCount = 1;
            doimg.isPublish=YES;
            doimg.refreshBlock = ^{
                [NSObject delay:0.5 completion:^{
                    [weakSelf.currScrollView ffRefreshHeaderBeginRefreshing];
                }];
            };
            UINavigationController *nav=[[UINavigationController alloc]initWithRootViewController:doimg];
            [self presentViewController:nav animated:YES completion:nil];
//            AddPhotoTagsViewController *vc=[[AddPhotoTagsViewController alloc]init];
            /*
            AddTagsViewController *vc=[[AddTagsViewController alloc]init];
            vc.refreshBlock = ^{
                [NSObject delay:0.5 completion:^{
                    [self.currScrollView ffRefreshHeaderBeginRefreshing];
                }];
            };
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:NO];
            */
            sender.hidden = NO;
        }];
        /*
        [self loginSuccess:^{
            [self addMaskingView];
            sender.hidden = YES;
        }];
         */
    }];
}

- (void)addMaskingView {
    UIView *backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height)];
    backgroundView.backgroundColor = [UIColor clearColor];
    UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
    [keyWindow addSubview: _backgroundView = backgroundView];
    
    UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView *effectview = [[UIVisualEffectView alloc] initWithEffect:blur];
    effectview.frame = CGRectMake(0, 0, backgroundView.width, backgroundView.height);
    [backgroundView addSubview:effectview];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    CGFloat W_H_xbutton = ZOOM6(110);
    button.frame = CGRectMake(backgroundView.right - W_H_xbutton - ZOOM6(46), backgroundView.bottom - W_H_xbutton - ZOOM6(128), W_H_xbutton, W_H_xbutton);
    
    [button setBackgroundImage:[UIImage imageNamed:@"miyou_icon_+_fabu"] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:@"miyou_icon_close"] forState:UIControlStateSelected];
    button.selected = YES;
    button.transform = CGAffineTransformMakeRotation(-M_PI_4);
    [backgroundView addSubview:button];
    
    NSArray *images = @[[UIImage imageNamed:@"miyou_icon_chuanda"],
                              [UIImage imageNamed:@"miyou_icon_huati"]];
    NSArray *titles = @[@"穿搭", @"话题"];
    CGFloat W_subView = ZOOM6(140);
    CGFloat H_subView = ZOOM6(205);
    for (int i = 0; i< images.count; i++) {
        UIView *subView = [self createViewWithImage:images[i] tag:100 + i title:titles[i]];
        subView.tag = 200 + i;
        subView.frame = CGRectMake(button.left - (W_subView - W_H_xbutton)* 0.5, button.top - (H_subView - W_H_xbutton) * 0.5, W_subView, H_subView);
        
        [UIView animateWithDuration:0.75 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:1 options:UIViewAnimationOptionCurveEaseIn animations:^{
            subView.centerX = button.centerX;
            subView.y = button.top - (ZOOM6(80) + H_subView) * (i + 1);
            if (i == images.count - 1) {
                button.transform = CGAffineTransformMakeRotation(M_PI_2);
            }
        } completion:^(BOOL finished) {
        }];
        [backgroundView addSubview:subView];
    }
   
    [button handleClickEvent:UIControlEventTouchUpInside withClickBlock:^(UIButton *sender) {
        
        self.publishButton.hidden = NO;
        [backgroundView removeFromSuperview];
        self.backgroundView = nil;
//        for (int i = 0; i< images.count; i++) {
//            UIView *subV = (UIView *)[self.backgroundView viewWithTag:200 + i];
//            [UIView animateWithDuration:0.3 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:1 options:UIViewAnimationOptionCurveEaseIn animations:^{
//                subV.centerY = button.centerY;
//                if (i == images.count - 1) {
//                    button.transform = CGAffineTransformMakeRotation(M_PI_2);
//                }
//            } completion:^(BOOL finished) {
//                
//            }];
//
//        }
    }];
}

- (void)publishButtonClick:(UIButton *)sender {
    self.publishButton.hidden = NO;
    [self.backgroundView removeFromSuperview];
    if (sender.tag == 100) { // 穿搭
        TFPublishDress *vc = [[TFPublishDress alloc] init];
        vc.refreshBlock = ^() {
            [NSObject delay:0.5 completion:^{
                [self.currScrollView ffRefreshHeaderBeginRefreshing];
            }];
        };
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    } else if (sender.tag == 101) { // 话题
        TFPublishThemeVC *vc = [[TFPublishThemeVC alloc] init];
        vc.refreshBlock = ^() {
            [NSObject delay:0.5 completion:^{
                [self.currScrollView ffRefreshHeaderBeginRefreshing];
            }];
        };
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
}


- (void)creatHeadView
{
    //导航条
    UIImageView *headview=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kApplicationWidth, Height_NavBar)];
    //
    [self.view addSubview:headview];
    headview.userInteractionEnabled=YES;
    
    UIButton *backbtn=[UIButton buttonWithType:UIButtonTypeCustom];
    backbtn.frame=CGRectMake(0, Height_NavBar-57, 44, 44);
    [backbtn setImage:[UIImage imageNamed:@"返回按钮_正常"] forState:UIControlStateNormal];
    [backbtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [headview addSubview:backbtn];
    
//    UILabel *titlelable=[[UILabel alloc]init];
//    titlelable.frame=CGRectMake(0, 0, 300, 40);
//    titlelable.center=CGPointMake(kApplicationWidth/2, headview.frame.size.height/2+10);
//    titlelable.text=@"疯狂新衣节";
//    titlelable.font=kNavTitleFontSize;
//    titlelable.textColor=kMainTitleColor;
//    titlelable.textAlignment=NSTextAlignmentCenter;
//    [headview addSubview:titlelable];
    
    UIImageView *titleImage = [[UIImageView alloc]init];
    titleImage.image = [UIImage imageNamed:@"topic_show_nor"];
    [headview addSubview:titleImage];
    [titleImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(headview.mas_centerY).offset(10);
        make.centerX.equalTo(headview);
        make.width.mas_equalTo(ZOOM6(126));
        make.height.mas_equalTo(ZOOM6(34));
    }];

    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, Height_NavBar-1, kScreenWidth, 1)];
    lineView.backgroundColor = RGBCOLOR_I(220,220,220);
    [self.view addSubview:lineView];
}
- (void)back
{
    //何波修改2017-10-23
    if(self.is_pushCome)
    {
        if([[NSUserDefaults standardUserDefaults]boolForKey:@"is_read"] == YES)
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
            [self.navigationController popViewControllerAnimated:YES];
        }
        
    }
}
- (void)setNavigationItem {
    
//    self.navigationController.navigationBarHidden = YES;
    self.navigationController.navigationBar.hidden=YES;
    
    UIView *naView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, Height_NavBar)];
    naView.backgroundColor = [UIColor clearColor];
    
    UIView *line=[[UIView alloc]initWithFrame:CGRectMake(0, naView.height-0.5, kScreenWidth, 0.5)];
    line.backgroundColor=kNavLineColor;
    [naView addSubview:line];
    [self.view addSubview:_naView = naView];
    
    UIImageView *titleImage = [[UIImageView alloc]init];
    titleImage.image = [UIImage imageNamed:@"topic_show_nor"];
    [naView addSubview:titleImage];
    [titleImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(naView.mas_centerY).offset(10);
        make.centerX.equalTo(naView);
        make.width.mas_equalTo(ZOOM6(126));
        make.height.mas_equalTo(ZOOM6(34));
    }];
    
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftBtn setImage:[UIImage imageNamed:@"miyou_icon_news"] forState:UIControlStateNormal];
    [naView addSubview:leftBtn];
    [leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(naView.mas_centerY).offset(10);
        make.left.equalTo(naView.mas_left).offset(ZOOM6(20));
        make.height.mas_equalTo(@(kNavigationBar_Height));
    }];
    
    redCountView = [[UIView alloc]init];
    redCountView.backgroundColor=tarbarrossred;
    redCountView.layer.cornerRadius=ZOOMPT(4);
    redCountView.hidden=YES;
    [leftBtn addSubview:redCountView];
    [redCountView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(leftBtn.mas_right);
        make.top.equalTo(leftBtn.mas_top).offset(5);
        make.width.height.equalTo(@ZOOMPT(8));
    }];
    
    [leftBtn handleClickEvent:UIControlEventTouchUpInside withClickBlock:^(UIButton *sender) {
        MyLog(@"点击消息");
        redCountView.hidden=YES;
        messageCountView.hidden=YES;
        [self loginSuccess:^{
            MessageCenterVC *vc = [[MessageCenterVC alloc]init];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }];
     
    }];
    
    /**< rightButton */
    CGFloat H_btn = kNavigationBar_Height;
    UIImage *rightImage = [UIImage imageNamed:@"shopping_icon_zhuanqian_black"];
    CGFloat right_W = H_btn * rightImage.size.height / rightImage.size.width;
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightButton setImage:rightImage forState:UIControlStateNormal];
    [naView addSubview:_rightButton = rightButton];
    
    //动效
    _aView = [[ShareAnimationView alloc] initWithFrame:CGRectMake(10, 10, 0, 0)];
    [_rightButton addSubview:_aView];
    
    _rightButton.hidden = [DataManager sharedManager].is_MakeMoneyHiden?YES:NO;
    
    [rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(naView.mas_right).offset(0);
        make.size.mas_equalTo(CGSizeMake(right_W, H_btn));
        make.centerY.equalTo(naView.mas_centerY).offset(10);
    }];
    kSelfWeak;
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
}

#pragma mark - Http Tools
- (void)httpBannerList {
    NSString *kApi = @"fc/banner?";
    [[APIClient sharedManager] netWorkGeneralRequestWithApi:kApi caches:NO cachesTimeInterval:0 token:YES success:^(id data, Response *response) {
        
        MyLog(@"data: %@", data);
        
        if (response.status == 1) {
            [self.banners removeAllObjects];
            NSArray *banner_list = data[@"banner_list"];
            for (NSDictionary *dic in banner_list) {
                bannerListModel *model = [bannerListModel yy_modelWithJSON:dic];
                [self.banners addObject:model];
            }
            if (self.banners.count) {
                [self setBanners];
            }
        }
        
    } failure:^(NSError *error) {
        MyLog(@"error: %@", error);
    }];
}

- (void)setBanners {
    NSMutableArray *viewsArray = [NSMutableArray array];
    if (self.banners.count) {
        [self.bannersView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        for (int i = 0; i < self.banners.count; i++) {
            bannerListModel *model=self.banners[i];
            NSString *imgUrlStr = [NSString stringWithFormat:@"%@%@!560",[NSObject baseURLStr_Upy],model.pic];
            [viewsArray addObject:imgUrlStr];
        }
        self.bannersView = [[ScrollView_public alloc]initWithFrame:CGRectMake(0, 0, kApplicationWidth, HeaderView_H) pictures:viewsArray animationDuration:5 contentMode_style:Fill_contentModestyle Haveshiping:NO];
        self.bannersView.pageControl.currentPageIndicatorImage = [UIImage imageNamed:@"Carousel_Selected"];
        self.bannersView.pageControl.pageIndicatorImage = [UIImage imageNamed:@"Carousel_normal"];
        [self.headerView addSubview:self.bannersView];
        
        kWeakSelf(self);
        self.bannersView.getTapClickPage = ^(NSInteger page) {
            bannerListModel *model = weakself.banners[page];
            if ([model.type integerValue] == 1) {
               
                TopicDetailViewController *topic = [[TopicDetailViewController alloc]init];
                topic.hidesBottomBarWhenPushed = YES;
                topic.theme_id = [NSString stringWithFormat:@"%@",model.link];
                [weakself.navigationController pushViewController:topic animated:YES];
            
            } else if ([model.type intValue] == 2) {
                H5activityViewController *h5vc = [[H5activityViewController alloc]init];
                h5vc.H5url = model.link;
                h5vc.hidesBottomBarWhenPushed = YES;
                [weakself.navigationController pushViewController:h5vc animated:YES];
            } else if ([model.type intValue] == 3) {
                ShopDetailViewController *detail=[[ShopDetailViewController alloc]initWithNibName:@"ShopDetailViewController" bundle:nil];
                detail.shop_code = [NSString stringWithFormat:@"%@", model.link];
                detail.stringtype = @"订单详情";
                detail.hidesBottomBarWhenPushed=YES;
                [weakself.navigationController pushViewController:detail animated:YES];
            } else if ([model.type intValue] == 4) {
                CollocationDetailViewController *collcationVC =[[CollocationDetailViewController alloc]init];
                collcationVC.collocationCode = [NSString stringWithFormat:@"%@", model.link];
                collcationVC.hidesBottomBarWhenPushed= YES;
                [weakself.navigationController pushViewController:collcationVC animated:YES];

            } else if ([model.type intValue] == 5) {
                SpecialDetailViewController *special = [[SpecialDetailViewController alloc]init];
                special.collocationCode = [NSString stringWithFormat:@"%@", model.link];
                special.hidesBottomBarWhenPushed = YES;
                [weakself.navigationController pushViewController:special animated:YES];
            }
        };
    } else {
        [self httpBannerList];
    }
}

#pragma mark - set SlidePageScrollView
- (void)addSlidePageScrollView {
    CGFloat tarbarheigh = self.is_pushCome?Height_TabBar:0;
    CGFloat viewHeigh = kScreen_Height - Height_NavBar - Height_TabBar;
    CGRect frame = CGRectMake(0, Height_NavBar, CGRectGetWidth(self.view.frame), viewHeigh+tarbarheigh);
    TYSlidePageScrollView *slidePageScrollView = [[TYSlidePageScrollView alloc] initWithFrame:frame];
    slidePageScrollView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    slidePageScrollView.pageTabBarIsStopOnTop = YES;
    slidePageScrollView.tyDataSource = self;
    slidePageScrollView.tyDelegate = self;
    slidePageScrollView.backgroundColor = RGBCOLOR_I(240, 240, 240);
    slidePageScrollView.pageTabBarStopOnTopHeight = 0;
    [self.view addSubview:slidePageScrollView];
    _slidePageScrollView = slidePageScrollView;
}
- (void)addHeaderView {
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(_slidePageScrollView.frame), HeaderView_H)];
    headerView.backgroundColor = [UIColor whiteColor];
    _slidePageScrollView.headerView = _headerView = headerView;
}
- (void)addFooterView {
    CGRect frame = CGRectMake(0, 0, CGRectGetWidth(_slidePageScrollView.frame), FooterView_H);
    UIView *footerView = [[UIView alloc]initWithFrame:frame];
    footerView.backgroundColor = [UIColor yellowColor];
    _slidePageScrollView.footerView = _footerView = footerView;
}
- (void)addTabPageMenu {
    
    CGRect frame = CGRectMake(0, 0, CGRectGetWidth(_slidePageScrollView.frame), TabPageMenu_H);
    CustomTitleView *titleView = [CustomTitleView scrollWithFrame:frame withTag:0 withIndex:0 withButtonNames:nil withImage:nil];
    titleView.backColor = [UIColor whiteColor];
    titleView.isSecretFriend=YES;
//    titleView.bgScrollView.backgroundColor = COLOR_RANDOM;
    int page = (int)[_slidePageScrollView curPageIndex];
    titleView.index = page;
    
    _slidePageScrollView.pageTabBar = _titleView = titleView;
    
    titleView.loginBlock = ^{
        
    };
}

#pragma mark - SlidePageScrollView delegate

- (NSInteger)numberOfPageViewOnSlidePageScrollView {
    return self.dataSource.count;
}

- (UIScrollView *)slidePageScrollView:(TYSlidePageScrollView *)slidePageScrollView pageVerticalScrollViewForIndex:(NSInteger)index {
    TFSubIntimateCircleVC *subVC = self.childViewControllers[index];
    subVC.headerView_H = HeaderView_H + TabPageMenu_H;
    return subVC.tableView;
}

- (void)slidePageScrollView:(TYSlidePageScrollView *)slidePageScrollView pageTabBarScrollOffset:(CGFloat)offset state:(TYPageTabBarState)state {
//    NSLog(@"\noffset: %f\n", offset);
//    CGFloat oldHeight = kScreen_Height - kStatusBar_And_NavigationBar_Height-kTabBar_Height;
    if (offset >= -kNavigationBar_Height) {
        messageCountView.frame=CGRectMake(0, 64+TabPageMenu_H, kScreenWidth, messageCountView.height);
//        [self.slidePageScrollView.footerView setHeight:0];
//        [UIView beginAnimations:nil context:nil];
//        [UIView setAnimationDuration:0.3];
//        [UIView setAnimationDelegate:self]; 
//        [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
        
//        self.naView.hidden = YES;
//        [self.slidePageScrollView setY:kStatusBar_Height];
//        [self.slidePageScrollView setHeight:kScreen_Height-kStatusBar_Height - kTabBar_Height];
//        [UIView commitAnimations];
//        NSLog(@"\n*********\n frame: %@ \n*********\n", NSStringFromCGRect(self.slidePageScrollView.frame));
    } else {
        messageCountView.frame=CGRectMake(0, 64, kScreenWidth, messageCountView.height);

//        self.naView.hidden = NO;
//        [self.slidePageScrollView setY:kStatusBar_And_NavigationBar_Height];
//        [self.slidePageScrollView setHeight:oldHeight];
//        [self.slidePageScrollView.footerView setHeight:kTabBar_Height];
//        [self.slidePageScrollView layoutContentView];
    }
}
  /* 登录
- (BOOL)selectTitleViewWithBtnIndex:(int)index {
  
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:USER_TOKEN];
    if(token == nil && index==1){
        [self loginSuccess:nil];
        return NO;
    }else
     
        return [_slidePageScrollView scrollToPageIndex:index animated:YES];;
}
     */
- (void)slidePageScrollView:(TYSlidePageScrollView *)slidePageScrollView horizenScrollToPageIndex:(NSInteger)index {
//    NSLog(@"index: %zd", index);
    self.currScrollView = [self slidePageScrollView:self.slidePageScrollView pageVerticalScrollViewForIndex:index];
    /* 登录
    if(index == 1) {
        NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:USER_TOKEN];
        if(token == nil){
            [self scrollToFirstChildVC];
        }
        [self loginSuccess:^{
            
        }];
    }
    */
}

- (void)animationDidStop:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context {
//    NSLog(@"动画结束了");
}


#pragma mark - TFSubIntimateCircleDelegate
- (void)intimateCirclePullDownRefreshWithIndex:(int)index {
    [self httpBannerList];
}

#pragma mark - Other Tools Mothed
- (void)addCollectionViewWithPageScrollView
{
    for (int i = 0; i<self.dataSource.count; i++) {
        [self addCollectionViewWithShopTypeItem:self.dataSource[i]];
    }
}

- (void)addCollectionViewWithShopTypeItem:(NSString *)name
{
    TFSubIntimateCircleVC *subVC = [[TFSubIntimateCircleVC alloc] init];
    subVC.headerView_H = HeaderView_H + TabPageMenu_H;
    subVC.name = name;
    subVC.customDelegate = self;
    [self addChildViewController:subVC];
}

- (UIView *)createViewWithImage:(UIImage *)image tag:(NSInteger)tag title:(NSString *)title {
    UIView *subView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ZOOM6(140), ZOOM6(140) + ZOOM6(20) + ZOOM6(45))];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.tag = tag;
    [btn setBackgroundImage:image forState:UIControlStateNormal];
    btn.frame = CGRectMake(0, 0, ZOOM6(140), ZOOM6(140));
    [btn addTarget:self action:@selector(publishButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [subView addSubview:btn];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, btn.bottom + ZOOM6(20), subView.width, ZOOM6(45))];
    label.textColor = RGBCOLOR_I(62, 62, 62);
    label.font = kFont6px(36);
    label.text = title;
    label.textAlignment = NSTextAlignmentCenter;
    [subView addSubview:label];
    
    return subView;
}


#pragma mark - 懒加载
- (NSMutableArray *)dataSource {
    if (_dataSource != nil) {
        return _dataSource;
    }
    NSMutableArray *dataSource = [NSMutableArray array];
    return _dataSource = dataSource;
}

- (NSMutableArray *)banners {
    if (_banners == nil) {
        _banners = [NSMutableArray array];
    }
    return _banners;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
//    NSInteger readMessageCount = [[EaseMob sharedInstance].chatManager loadTotalUnreadMessagesCountFromDatabase]+[[NSUserDefaults standardUserDefaults]integerForKey:@"TOPICMESSAGE"];
//
//    redCountView.hidden = readMessageCount==0;

    redCountView.hidden = YES;
//    NSInteger messageCountViewNum = [[NSUserDefaults standardUserDefaults]integerForKey:@"messageCountView"];
//    if (readMessageCount==messageCountViewNum && messageCountViewNum) {
//        messageCountView.hidden=YES;
//    }else
//        [self showMessageCountView:readMessageCount];

//    if (readMessageCount)
//        [self showMessageCountView:readMessageCount];
    if([DataManager sharedManager].isSubmitSuccess)
    {
        [DataManager sharedManager].isSubmitSuccess=NO;
        [self shareRecommendRefresh];
    }
    
    NSString *time = [[NSUserDefaults standardUserDefaults] objectForKey:ShareAnimationTime];
    NSString *currTime = [MyMD5 getCurrTimeString:@"year-month-day"];
    if (time == nil || ![time isEqualToString:currTime]) {
        [_aView animationStart:YES];
    } else {
        [_aView animationStart:NO];
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [DataManager sharedManager].beginYiFuMiyou = [NSDate timeIntervalSince1970WithDate];
    [TFStatisticsClickVM StatisticshandleDataWithClickType:@"到达蜜友社区首页" success:nil failure:nil];
    
    _rightButton.userInteractionEnabled = YES;
    
    //拼团失败退款提示框
    kWeakSelf(self);
    [OneYuanModel GetOneYuanCountSuccess:^(id data) {
        OneYuanModel *oneModel = data;
        if(oneModel.status == 1 && oneModel.isFail == 1)
        {
            [DataManager sharedManager].OneYuan_count = oneModel.order_price;
            
            [weakself setVitalityPopMindView:Detail_OneYuanDeductible];
        }
    }];
    
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [TFStatisticsClickVM StatisticshandleDataWithClickType:@"跳出蜜友社区首页" success:nil failure:nil];
    [self httpUseAppTimeInterval];
}

#pragma mark 0元购弹框
- (void)setVitalityPopMindView:(VitalityType)type
{
    NSInteger valityGrade = type ==Detail_OneYuanDeductible?3:0;
    
    VitalityTaskPopview *vitaliview = [[VitalityTaskPopview alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) VitalityType:type valityGrade:valityGrade YidouCount:0];
    vitaliview.oneYuanDiKou = [DataManager sharedManager].OneYuan_count;
    __weak VitalityTaskPopview *view = vitaliview;
    view.tapHideMindBlock = ^{
        
        [view remindViewHiden];
        
    };
    
    view.leftHideMindBlock = ^(NSString*title){
        if(type == Detail_OneYuanDeductible)
        {
            MyOrderViewController *myorder = [[MyOrderViewController alloc]init];
            myorder.hidesBottomBarWhenPushed = YES;
            myorder.tag=999;
            myorder.status1=@"0";
            
            Mtarbar.selectedIndex=4;
            UINavigationController *nv = (UINavigationController *)Mtarbar.viewControllers[4];
            nv.navigationBarHidden = YES;
            [nv pushViewController:myorder animated:YES];
        }
    };
    view.rightHideMindBlock = ^(NSString *title) {
        if (type == Detail_OneYuanDeductible)//余额返回说明
        {
            TFMyWalletViewController *wallet = [[TFMyWalletViewController alloc]init];
            wallet.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:wallet animated:YES];
        }
    };
    
    [self.view addSubview:vitaliview];
}
/**
 App 密友圈停留时长
 */
- (void)httpUseAppTimeInterval
{
    NSTimeInterval currTimeInterval = [NSDate timeIntervalSince1970WithDate];
    NSTimeInterval diffTimeInterval = ABS(currTimeInterval- [[DataManager sharedManager] beginYiFuMiyou])/1000;
    NSDictionary *parameter = @{@"type": @"1008",
                                @"timer": [NSNumber numberWithDouble:(int)diffTimeInterval],
                                @"version":VERSION};
    
    [[APIClient sharedManager] netWorkGeneralRequestWithApi:kApi_apptimeRecord parameter:parameter caches:NO cachesTimeInterval:0*TFSecond token:YES success:^(id data, Response *response) {
        
        MyLog(@"data: %@", data);
        
    } failure:^(NSError *error) {
        MyLog(@"error: %@", error);
        
    }];
}

- (void)showMessageCountView:(NSInteger)count {
    if (messageCountView==nil) {
        messageCountView=[[UIView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, ZOOM6(80))];
        messageCountView.backgroundColor=[UIColor colorWithWhite:1 alpha:0.9f];
        messageCountView.userInteractionEnabled=YES;
        [self.view addSubview:messageCountView];
        
        messageCountLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, ZOOM6(80))];
        messageCountLabel.textColor=tarbarrossred;
        messageCountLabel.textAlignment=NSTextAlignmentCenter;
        messageCountLabel.font=[UIFont systemFontOfSize:ZOOM6(30)];
        messageCountLabel.userInteractionEnabled=YES;
        UIButton *msgBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        msgBtn.frame=CGRectMake(0, 0, messageCountView.width-messageCountView.height, messageCountView.height);
        [msgBtn handleClickEvent:UIControlEventTouchUpInside withClickBlock:^(UIButton *sender) {
            
            redCountView.hidden=YES;
            messageCountView.hidden=YES;
            
            MessageCenterVC *vc = [[MessageCenterVC alloc]init];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
            
        }];
        
        UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame=CGRectMake(messageCountView.width-messageCountView.height, 0, messageCountView.height, messageCountView.height);
        [btn setImage:[UIImage imageNamed:@"icon_close-me"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"icon_close-me"] forState:UIControlStateHighlighted];
        
        [btn handleClickEvent:UIControlEventTouchUpInside withClickBlock:^(UIButton *sender) {
            //        [messageCountView removeFromSuperview];
            [self hideMessageCountView];
//            [[NSUserDefaults standardUserDefaults]setInteger:[[EaseMob sharedInstance].chatManager loadTotalUnreadMessagesCountFromDatabase]+[[NSUserDefaults standardUserDefaults]integerForKey:@"TOPICMESSAGE"] forKey:@"messageCountView"];
        }];
        [messageCountView addSubview:messageCountLabel];
        [messageCountView addSubview:msgBtn];
        [messageCountView addSubview:btn];

    }
    messageCountView.hidden = count==0;
    messageCountLabel.text=[NSString stringWithFormat:@"收到%zd条新消息",count];
}
- (void)hideMessageCountView {
//    [UIView animateWithDuration:0.5 animations:^{
//        messageCountView.alpha = 0;
        messageCountView.hidden=YES;
//    }];
}

- (void)scrollToFirstChildVC {
    [_titleView switchToPageIndex:0];
    [_slidePageScrollView scrollToPageIndex:0 animated:YES];
    self.currScrollView = [self slidePageScrollView:self.slidePageScrollView pageVerticalScrollViewForIndex:0];
}
- (void)reloadChildViewController {
    if (self.childViewControllers.count) {
        TFSubIntimateCircleVC *subVC = self.childViewControllers[0];
        [subVC httpTheme];
        TFSubIntimateCircleVC *subVC2 = self.childViewControllers[1];
        [subVC2 httpCircle];
        if ([[NSUserDefaults standardUserDefaults]objectForKey:USER_TOKEN]) {
//            [subVC2 httpCircle];
        }else {
//            [subVC2.dataSource removeAllObjects];
            [subVC2.dataSource removeObjectsInRange:NSMakeRange(1, subVC2.dataSource.count-1)];
            [subVC2.tableView reloadData];
            [self scrollToFirstChildVC];
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
