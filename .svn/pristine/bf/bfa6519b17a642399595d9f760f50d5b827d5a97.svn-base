//
//  TFLedBrowseShopViewController.m
//  YunShangShiJi
//
//  Created by jingaiweiyi on 16/6/27.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import "TFLedBrowseShopViewController.h"
#import "LoginViewController.h"
#import "WaterFLayout.h"

#import "TFPopBackgroundView.h"
#import "ShopDetailModel.h"
#import "ShopDetailViewController.h"
#import "TFBrowseShopVM.h"
#import "TFShoppingM.h"
#import "TFCollectionViewService.h"
#import "MobClick.h"
#import "TFShopCartVM.h"
#import "ShopCarManager.h"
#import "NewShoppingCartViewController.h"
#import "StickyHeaderFlowLayout.h"
#import "CollectionImageHeaderView.h"
#import "CollectionImageMenuReusableView.h"
#import "CollectionMenuReusableView.h"
#import "DefaultImgManager.h"

@interface TFLedBrowseShopViewController ()<StickyHeaderFlowLayoutDelegate>
{
    dispatch_source_t _timer;
}
/**
 *  视图
 */

@property (nonatomic, assign) BOOL is_shopcart;
@property (nonatomic, strong) UIButton *shoppingCartBtn; /**< 购物车 */
@property (nonatomic, strong) UILabel *shoppingCartLabel;
@property (nonatomic, strong) UIView *headerTimerView;
@property (nonatomic, strong) UILabel *messageLab;
@property (nonatomic, strong) UIButton *explainBtn;
@property (nonatomic, strong) UICollectionView *collectionView;

/**
 *  数据
 */

@property (nonatomic, assign) NSInteger currPage;
@property (nonatomic, assign) BOOL isTimeOut;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, assign) double currTimeCount;
@property (nonatomic, strong) NSMutableArray *selectShopArray; /**< 选择过的商品计数 */
@property (nonatomic, assign) BOOL showGetMoneyWindow;
@property (nonatomic, strong) TFBrowseShopVM *viewModel;
@property (nonatomic, assign) NSInteger browseCount;
@property (nonatomic, strong) TaskMenuButtonView *menuButtonView;
@end

@implementation TFLedBrowseShopViewController
{
    NSString *appendingStr; //排序条件
}
- (void)dealloc
{
    MyLog(@"%@ release", [self class]);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupUI];
    
    [self getData];
}

- (void)getData
{
    self.currTimeCount = 0;
    self.currPage = 1;
    appendingStr=@"add_time&order=desc";//默认排序条件为热销
//    self.randomNum = 2; //+arc4random_uniform(2);
    if (self.randomNum > 0) {
        self.randomNum --;
    }
    
    MyLog(@"randomNum = %ld", (long)self.randomNum);
    
    [self httpGetDataSource]; /**< 商品列表 */
    [self httpGetShopCartCount]; /**< 购物车数量 */
    
    __weak typeof (self) weakS = self;
    [self reloadDataBlock:^{
        [weakS httpGetDataSource]; /**< 商品列表 */
        [weakS httpGetShopCartCount]; /**< 购物车数量 */
    }];

}

- (void)setupUI
{
    // 禁用 iOS7 返回手势
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
//        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
    
    self.title!=nil?[self setNavigationItemLeft:self.title]:[self setNavigationItemLeft:@"浏览有奖"];
    
    if([self.title containsString:@"最热销单品"])
    {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"threemenu"];
    }
    
    [self supplementNavigationItem];
    
    self.isbrowse?[self addHeaderTimerView]:nil;
    
    [self addCollectionView];
    
    [self didSelectItemAtIndexPath];
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *oldDate = [ud objectForKey:@"newShowPopView"];
    NSString *currDate = [NSString stringWithFormat:@"%@%@", [ud objectForKey:USER_ID], [MyMD5 getCurrTimeString:@"year-month-day"]];
    if ((oldDate == nil || ![oldDate isEqualToString:currDate]) && self.isbrowse) {
        [self showPopView];
        [[NSUserDefaults standardUserDefaults] setObject:currDate forKey:@"newShowPopView"];
    }
}

/**
 *  刷新计时器
 *
 *  @param timeText 时间
 */
- (void)refreshHeaderTimerView:(NSString *)timeText
{
//    [self.explainBtn setTitle:timeText forState:UIControlStateNormal];

    MyLog(@"%.0f", self.currTimeCount);
}

/**
 *  超时
 */
- (void)timerOut
{
    MyLog(@"时间溢出");
    self.isTimeOut = YES;
}

- (void)supplementNavigationItem
{
    ESWeakSelf;
    CGFloat H_btn = 44;
    CGFloat W_shopBtn= 44;
    
    UIButton *btn3 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn3.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [btn3 setImage:[UIImage imageNamed:@"0_购物车"] forState:UIControlStateNormal];
    [btn3 addTarget:self action:@selector(shoppingCartBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationView addSubview:_shoppingCartBtn = btn3];
    
    [self.shoppingCartBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(__weakSelf.navigationView.mas_right).offset(0);
        make.size.mas_equalTo(CGSizeMake(W_shopBtn, H_btn));
        make.centerY.equalTo(__weakSelf.navigationView.mas_centerY).offset(10);
    }];
    
    UILabel *cartLabel = [[UILabel alloc] init];
    cartLabel.layer.cornerRadius = 15*0.5;
    cartLabel.layer.masksToBounds = YES;
    cartLabel.textColor = [UIColor whiteColor];
    cartLabel.textAlignment = NSTextAlignmentCenter;
    cartLabel.adjustsFontSizeToFitWidth = YES;
    cartLabel.backgroundColor = COLOR_ROSERED;
    cartLabel.font = [UIFont systemFontOfSize:10];
    cartLabel.hidden = YES;
    [btn3 addSubview:_shoppingCartLabel = cartLabel];
    [cartLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(15, 15));
        make.top.equalTo(btn3.mas_top).with.offset(5);
        make.right.equalTo(btn3.mas_right).with.offset(-5);
    }];
    
}

- (void)didSelectItemAtIndexPath
{
    kSelfWeak;
    [self.viewModel.service setHeightForHeaderInSectionBlock:^CGFloat(UICollectionView *collectionView, UICollectionViewLayout *collectionViewLayout, NSInteger section) {

        if(self.bannerImage !=nil)
        {
            return kScreenWidth/1.7+ZOOM6(70);
        }else{
            return ZOOM6(70);
        }
    }];
    [self.viewModel.service setViewForSupplementaryElementOfKindAtIndexPathBlock:^UICollectionReusableView *(UICollectionView *collectionView, NSString *kind, NSIndexPath *indexPath) {
        CollectionImageMenuReusableView * headerView =(CollectionImageMenuReusableView *)[collectionView dequeueReusableSupplementaryViewOfKind:WaterFallSectionHeader withReuseIdentifier:@"HeaderView" forIndexPath:indexPath];
        
        [headerView.headImgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@!450", [NSObject baseURLStr_Upy], weakSelf.bannerImage]]placeholderImage:[[DefaultImgManager sharedManager] defaultImgWithSize:headerView.frame.size]];

        [headerView.menubackview setMenuBtnClickBlock:^(NSInteger btnClickIndex) {
            
            [weakSelf httpSelectIndex:btnClickIndex];
            
        }];

        return headerView;
    }];
    [self.viewModel.service didSelectItemAtIndexPathBlock:^(UICollectionView *collectionView, NSIndexPath *indexPath) {

        [self stopTimer];
        
        TFShoppingM *model=self.dataSource[indexPath.item];
        ShopDetailViewController *detail=[[ShopDetailViewController alloc] initWithNibName:@"ShopDetailViewController" bundle:nil];
        if(self.randomNum > 0)
        {
            detail.stringtype = @"签到领现金";
        }else{
            detail.stringtype = @"浏览商品";
        }
        detail.shop_code = model.shop_code;
        detail.rewardType = self.rewardType;
        detail.rewardValue = self.rewardValue;
        detail.Browsedic = self.Browsedic;
        detail.browseCount = self.browseCount;
        detail.currTimeCount = self.currTimeCount;
        detail.index_id = self.index;
        detail.index_day = self.day;
        detail.rewardCount = self.rewardCount;
        
        if([self.rewardType isEqualToString:@"提现额度"])
        {
            detail.showGetMoneyWindow = NO;
        }else{
            if ((self.browseCount == self.randomNum) && !self.showGetMoneyWindow) {
                detail.showGetMoneyWindow = YES;
            }
        }
        
        ESWeakSelf;
        detail.browseCountBlock = ^() {
            if (![__weakSelf.selectShopArray containsObject:[NSNumber numberWithInteger:indexPath.item]]) {
                if (self.browseCount == self.randomNum) {
                    self.showGetMoneyWindow = YES;
                }
                __weakSelf.browseCount++; //计数
                [__weakSelf.selectShopArray addObject:[NSNumber numberWithInteger:indexPath.item]];
            }
            
        };
        detail.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:detail animated:YES];
    }];
}

- (void)httpSelectIndex:(NSInteger)index
{
    if([self.title containsString:@"最热销单品"])
    {
        switch (index) {
            case 0: {
                appendingStr=@"add_time&order=desc";
            }
                break;
            case 1: {
                appendingStr=@"shop_se_price&order=asc";
            }
                break;
            case 2: {
                
                appendingStr=@"shop_se_price&order=desc";
            }
                break;
            default:
                break;
        }

    }else{
        switch (index) {
            case 0: {
                
                appendingStr=@"add_time&order=desc";
            }
                break;
            case 1: {
                appendingStr=@"virtual_sales&order=desc";
            }
                break;
            case 2: {
                
                appendingStr=@"shop_se_price&order=asc";
            }
                break;
            case 3: {
                
                appendingStr=@"shop_se_price&order=desc";
            }
                break;
                
            default:
                break;
        }
    }
    
    self.currPage = 1;
    [self httpGetDataSource];
}

- (TaskMenuButtonView *)menuButtonView
{
    if (!_menuButtonView) {
        _menuButtonView = [[TaskMenuButtonView alloc] init];
        if(self.bannerImage !=nil)
        {
            _menuButtonView.frame = CGRectMake(0, kScreenWidth/1.7, kScreenWidth, ZOOM6(70));
        }else{
            _menuButtonView.frame = CGRectMake(0, 0, kScreenWidth, ZOOM6(70));
        }
        _menuButtonView.titleArray = @[@"最新",@"价格↑",@"价格↓"];
    }
    return _menuButtonView;
    
}

- (void)explainBtnClick
{
    [MobClick event:BrowseShop_ExplainButton];
    [self showPopView];
}

- (void)shoppingCartBtnClick:(UIButton *)sender
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *token = [ud objectForKey:USER_TOKEN];
    if (token.length) {
//        WTFCartViewController *spVC = [[WTFCartViewController alloc] init];
//        spVC.segmentSelect = CartSegment_NormalType;
        
        [self stopTimer];
//        [self.navigationController pushViewController:spVC animated:YES];
        self.is_shopcart = YES;
        NewShoppingCartViewController *shoppingcart =[[NewShoppingCartViewController alloc]init];
        shoppingcart.ShopCart_Type = ShopCart_NormalType;
        shoppingcart.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:shoppingcart animated:YES];

    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [self startTimer:self.currTimeCount action:@selector(refreshHeaderTimerView:) withTimeOut:@selector(timerOut)];
}

#pragma mark - http
// 加载购物车商品数
- (void)httpGetShopCartCount
{
//    int cart1= (int)[ShopCarManager sharedManager].s_count ;
    int cart2= (int)[ShopCarManager sharedManager].p_count ;
    int cart = cart2;
    
    ESWeakSelf;
    [TFShopCartVM handleDataWithShopCartCountSuccess:^(TFShopCartM *model, Response *response) {
        if (response.status == 1) {
            __weakSelf.shoppingCartLabel.hidden = NO;
//            __weakSelf.shoppingCartLabel.text = [NSString stringWithFormat:@"%@",model.cart_count];
            
            //何波修改2016.8.17
            __weakSelf.shoppingCartLabel.text = [NSString stringWithFormat:@"%d",cart];
            
            if([model.cart_count intValue] <1) {
                __weakSelf.shoppingCartLabel.hidden = YES;
            }
        }
    } failure:^(NSError *error) {

    }];
}

- (void)httpGetDataSource
{
    ESWeakSelf;
   [self.viewModel handleDataWithFromPageNum:self.currPage Sort:appendingStr Success:^(NSArray *modelArray, Response *response) {
       [__weakSelf.collectionView headerEndRefreshing];
       [__weakSelf.collectionView footerEndRefreshing];
       if (response.status == 1) {
           if (__weakSelf.currPage == 1) {
               [__weakSelf.dataSource removeAllObjects];
           }
           
           [__weakSelf.dataSource addObjectsFromArray:modelArray];
           __weakSelf.viewModel.service.dataSource = [NSMutableArray arrayWithArray:__weakSelf.dataSource];
           
           if (__weakSelf.dataSource.count == 0) {
               
               [__weakSelf showBackgroundTabBar:NO setY:ZOOM6(60) type:ShowBackgroundTypeListEmpty message:nil];
           } else {
               [__weakSelf cleanShowBackground];
           }
           kWeakSelf(self);
           dispatch_async(dispatch_get_main_queue(), ^{
               
               if (weakself.dataSource.count >= response.pager.rowCount && self.currPage>1 && modelArray.count == 0) {
                   NavgationbarView *nv = [[NavgationbarView alloc] init];
                   
                   weakself.is_shopcart?(weakself.is_shopcart=NO):([nv showLable:@"没有更多商品了哦~" Controller:self]);
               }
               
               [__weakSelf.collectionView reloadData];
           });
       }

       
   } failure:^(NSError *error) {
       
       [__weakSelf showBackgroundTabBar:NO setY:ZOOM6(60) type:ShowBackgroundTypeNetError message:nil];
       
       [__weakSelf.collectionView headerEndRefreshing];
       [__weakSelf.collectionView footerEndRefreshing];

   }];

//    [self.viewModel handleDataWithFromPageNum:self.currPage Success:^(NSArray *modelArray, Response *response) {
//        
//        [__weakSelf.collectionView headerEndRefreshing];
//        [__weakSelf.collectionView footerEndRefreshing];
//        if (response.status == 1) {
//            if (__weakSelf.currPage == 1) {
//                [__weakSelf.dataSource removeAllObjects];
//            }
//            
//            [__weakSelf.dataSource addObjectsFromArray:modelArray];
//            __weakSelf.viewModel.service.dataSource = [NSMutableArray arrayWithArray:__weakSelf.dataSource];
//            
//            if (__weakSelf.dataSource.count == 0) {
//
//                [__weakSelf showBackgroundTabBar:NO setY:ZOOM6(60) type:ShowBackgroundTypeListEmpty message:nil];
//            } else {
//                [__weakSelf cleanShowBackground];
//            }
//            
//            dispatch_async(dispatch_get_main_queue(), ^{
//                
//                if (self.dataSource.count >= response.pager.rowCount && self.currPage>1 && modelArray.count == 0) {
//                    NavgationbarView *nv = [[NavgationbarView alloc] init];
//                    [nv showLable:@"没有更多商品了哦~" Controller:self];
//                }
//                
//                [__weakSelf.collectionView reloadData];
//            });
//        }
//    } failure:^(NSError *error) {
//        
//        [__weakSelf showBackgroundTabBar:NO setY:ZOOM6(60) type:ShowBackgroundTypeNetError message:nil];
//        
//        [__weakSelf.collectionView headerEndRefreshing];
//        [__weakSelf.collectionView footerEndRefreshing];
//    }];
}

#pragma mark - getter
- (NSMutableArray *)selectShopArray
{
    if (!_selectShopArray) {
        _selectShopArray = [NSMutableArray array];
    }
    return _selectShopArray;
}

- (NSMutableArray *)dataSource
{
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        WaterFLayout *flowLayout=[[WaterFLayout alloc] init];
        
        flowLayout.sectionInset = UIEdgeInsetsMake(0, 5, 0, 5);
        flowLayout.minimumColumnSpacing = 5;
        flowLayout.minimumInteritemSpacing = 0;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _collectionView.delegate = self.viewModel.service;
        _collectionView.dataSource = self.viewModel.service;
        _collectionView.scrollsToTop = YES;
        _collectionView.backgroundColor = RGBCOLOR_I(240, 240, 240);
        
        
        
        [_collectionView registerNib:[UINib nibWithNibName:@"WaterFlowCell" bundle:nil] forCellWithReuseIdentifier:@"WATERFLOWCELLID"];
        [_collectionView registerClass:[CollectionImageMenuReusableView class] forSupplementaryViewOfKind:WaterFallSectionHeader withReuseIdentifier:@"HeaderView"];

        __weak typeof (self) weakSelf = self;
        [_collectionView addHeaderWithCallback:^{
            weakSelf.currPage = 1;
            [weakSelf httpGetDataSource];
        }];
        
        [_collectionView addFooterWithCallback:^{
            weakSelf.currPage ++;
            [weakSelf httpGetDataSource];
        }];
        
    }
    return _collectionView;
}

- (UIView *)headerTimerView
{
    if (!_headerTimerView) {
        _headerTimerView = [UIView new];
        _headerTimerView.backgroundColor = RGBCOLOR_I(62, 62, 62);
        CGFloat W_img = ZOOM6(140);
        
        UIButton *explainBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [explainBtn setTitleColor:RGBCOLOR_I(255, 231, 24) forState:UIControlStateNormal];
        [explainBtn setTitle:@"任务说明" forState:UIControlStateNormal];
        explainBtn.titleLabel.font = [UIFont boldSystemFontOfSize:ZOOM6(24)];
        explainBtn.backgroundColor = RGBCOLOR_I(255, 89, 79);
        [explainBtn addTarget:self action:@selector(explainBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [_headerTimerView addSubview:_explainBtn = explainBtn];
        [explainBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.and.right.equalTo(_headerTimerView);
            make.width.mas_equalTo(W_img);
        }];
        
        UIImageView *imgV = [UIImageView new];
        imgV.image = [UIImage imageNamed:@"browse_icon_tongzhi"];
        [_headerTimerView addSubview:imgV];
        
        [imgV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(_headerTimerView.mas_centerY);
            make.left.mas_equalTo(ZOOM6(10));
            make.size.mas_equalTo(CGSizeMake(ZOOM6(30), ZOOM6(30)));
        }];
        
        
        UILabel *messageLab = [UILabel new];
        messageLab.font = [UIFont boldSystemFontOfSize:ZOOM6(24)];
        messageLab.textColor = RGBCOLOR_I(168, 168, 168);
        messageLab.textAlignment = NSTextAlignmentCenter;
        [_headerTimerView addSubview:_messageLab = messageLab];
        [messageLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.and.bottom.equalTo(_headerTimerView);
            make.right.equalTo(explainBtn.mas_left);
            make.left.equalTo(imgV.mas_right).offset(ZOOM6(10));
        }];
        
        if(self.isTiXian)
        {
            messageLab.text = [NSString stringWithFormat:@"每浏览%zd件衣服即得%zd元提现额度哦，快去领取吧",[Signmanager SignManarer].everyLinlanCount,[Signmanager SignManarer].everyLiulanRaward];
        }else
            messageLab.text = @"亲，任务奖励就藏在这些商品详情页里噢，快去领取吧~";

    }
    return _headerTimerView;
}

- (void)addCollectionView
{
    ESWeakSelf;
    [self.view addSubview:self.collectionView];
    
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        if(__weakSelf.isbrowse)
        {
            make.top.equalTo(__weakSelf.headerTimerView.mas_bottom);
        }else{
            make.top.equalTo(__weakSelf.navigationView.mas_bottom);
        }
        make.left.right.and.bottom.equalTo(__weakSelf.view);
    }];
}

- (void)addHeaderTimerView
{
    [self.view addSubview:self.headerTimerView];
    
    ESWeakSelf;
    [_headerTimerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(__weakSelf.navigationView.mas_bottom);
        make.left.right.equalTo(__weakSelf.view);
        make.height.mas_equalTo(ZOOM6(60));
    }];
}

- (void)startTimer:(double)timeCount action:(SEL)sel withTimeOut:(SEL)selOut
{
    if (_timer) {
        dispatch_source_cancel(_timer);
    }
    __block double timeOut = timeCount-1;
    double delayInSeconds = 1.0;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    _timer = timer;
    dispatch_source_set_timer(timer,dispatch_walltime(NULL, 0), delayInSeconds*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(timer, ^{
        if(timeOut < 0){ //倒计时结束，关闭
            dispatch_source_cancel(timer);
            _timer = nil;
            dispatch_async(dispatch_get_main_queue(), ^{
                [self performSelector:selOut withObject:nil afterDelay:0.0];
            });
        } else{
            
            self.currTimeCount = timeOut;
//            int hours = timeOut / 3600;
            int minutes = (int)timeOut % 3600/ 60;
            int seconds = (int)timeOut % 60;
            NSString *stringTime = [NSString stringWithFormat:@"%02d:%02d",minutes, seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self performSelector:sel withObject:stringTime afterDelay:0.0];
            });
            timeOut--;
        }
    });
    dispatch_resume(timer);
}

- (void)stopTimer
{
    if (_timer) {
        dispatch_source_cancel(_timer);
        dispatch_async(dispatch_get_main_queue(), ^{
            _timer = nil;
        });
    }
}

- (void)leftBarButtonClick
{
    if (!self.showGetMoneyWindow && self.Browsedic !=nil) {
        
        TFPopBackgroundView *popView = [[TFPopBackgroundView alloc] init];
        popView.title = @"亲~确定要离开吗？";
        popView.message = @"再逛一下下就可以获得任务奖励噢~";
        popView.leftText = @"不了，谢谢";
        popView.rightText = @"再逛逛";
        popView.textAlignment = NSTextAlignmentCenter;
        [popView setCancelBlock:^{
            if (self.browseFail) {
                self.browseFail();
            }
            [MobClick event:BrowseShop_ExitButton];
            [self popViewController];
        } withConfirmBlock:^{
            
        } withNoOperationBlock:^{
            
        }];
        [popView show];
        
    } else {
        
        if (self.browseFinish) {
            self.browseFinish();
        }
        [self popViewController];
    }
}


- (void)popViewController
{
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    }
    [self stopTimer];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)setBrowseFinishBlock:(BrowseFinishBlock)browseFinish browseFail:(BrowseFailBlock)browseFail
{
    self.browseFinish = browseFinish;
    self.browseFail = browseFail;
}


- (TFBrowseShopVM *)viewModel
{
    if (!_viewModel) {
        _viewModel = [[TFBrowseShopVM alloc] init];
    }
    return _viewModel;
}
- (void)showPopView
{
//    ExplainPopView *popView = [[ExplainPopView alloc] init];
//    [popView show];
//
//    [popView setCancelBlock:^{
//        
//    } withConfirmBlock:^{
//        
//    } withNoOperationBlock:^{
//        
//    }];
    
    NSString *rewardstr = [NSString stringWithFormat:@"每浏览%zd件美衣，即可得到%zd元提现额度，任务奖励就藏在商品里，快去领取吧~",[Signmanager SignManarer].everyLinlanCount,[Signmanager SignManarer].everyLiulanRaward];
    NSString *title = self.isTiXian?rewardstr:@"任务奖励就藏在商品里面噢~";
    TFPopBackgroundView *popBackgV = [[TFPopBackgroundView alloc] initWithTitle:nil message:title showCancelBtn:NO leftBtnText:nil rightBtnText:@"知道啦~"];
    popBackgV.textAlignment = NSTextAlignmentCenter;
    [popBackgV setCancelBlock:^{
        
    } withConfirmBlock:^{
        
    } withNoOperationBlock:^{
        
    }];
    
    [popBackgV show];
    
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

@interface ExplainPopView () <UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *dataSource;

@end

@implementation ExplainPopView

- (instancetype)init
{
    if (self = [super init]) {
        [self setupUI];
        [self getData];
    }
    return self;
}

- (void)getData
{
    NSArray *array = [NSArray arrayWithObjects:@"任务奖励随机藏在每日精选商品列表的商品详情页中，进入商品详情页浏览至底部，就有机会找到噢~",
                                                @"在这些推荐商品中购买下单，即可直接完成任务获得奖励。",nil];
    [self.dataSource addObjectsFromArray:array];
    
    [self.tableView reloadData];
}

- (void)setupUI
{
    ESWeakSelf;
    self.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    
    CGFloat W_backgrd = kScreenWidth- ZOOM6(85)*2;
    CGFloat H_backgrd = ZOOM6(530);
    
    UIView *backgroundView = [UIView new];
    backgroundView.tag = 200;
    backgroundView.layer.masksToBounds = YES;
    backgroundView.layer.cornerRadius = ZOOM6(15);
    backgroundView.backgroundColor = [UIColor whiteColor];
    backgroundView.clipsToBounds = YES;
    [self addSubview:backgroundView];
    [backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(__weakSelf);
        make.centerY.equalTo(__weakSelf);
        make.size.mas_equalTo(CGSizeMake(W_backgrd, H_backgrd));
    }];
    
    UILabel *titleLabel = [UILabel new];
    titleLabel.text = @"任务说明";
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont systemFontOfSize:ZOOM6(36)];
    titleLabel.backgroundColor = COLOR_ROSERED;
    [backgroundView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(backgroundView);
        make.height.mas_equalTo(ZOOM6(80));
    }];
    
    UIButton *conBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    conBtn.layer.masksToBounds = YES;
    conBtn.layer.cornerRadius = ZOOM6(8);
    [conBtn setTitle:@"知道了" forState:UIControlStateNormal];
    [conBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    conBtn.backgroundColor = COLOR_ROSERED;
    [conBtn setBackgroundImage:[UIImage imageWithColor:COLOR_ROSERED] forState:UIControlStateNormal];
    [conBtn setBackgroundImage:[UIImage imageWithColor:RGBCOLOR_I(204, 20, 93)] forState:UIControlStateHighlighted];
    [backgroundView addSubview:conBtn];
    
    [conBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(backgroundView).offset(-ZOOM6(50));
        make.left.equalTo(backgroundView).offset(ZOOM6(30));
        make.right.equalTo(backgroundView).offset(-ZOOM6(30));
        make.height.mas_equalTo(ZOOM6(80));
    }];
    
    [backgroundView addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleLabel.mas_bottom).offset(ZOOM6(40));
        make.bottom.equalTo(conBtn.mas_top).offset(-ZOOM6(40));
        make.left.right.equalTo(conBtn);
    }];
    
    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
    backgroundView.transform = CGAffineTransformMakeScale(0, 0);
    
    [conBtn addTarget:self action:@selector(conBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGRClick:)];
    [self addGestureRecognizer:tapGR];
    
}

- (void)setCancelBlock:(CancelBlock)canBlock withConfirmBlock:(ConfirmBlock)conBlock withNoOperationBlock:(NoOperationBlock)noOperatBlock
{
    self.cancelClickBlock = canBlock;
    self.confirmClickBlock = conBlock;
    self.noOperationBlock = noOperatBlock;
}

- (void)tapGRClick:(UITapGestureRecognizer *)sender
{
    if (self.noOperationBlock) {
        self.noOperationBlock();
    }
    [self dismissAlert:YES];
    
}
- (void)conBtnClick:(UIButton *)sender
{
    if (self.confirmClickBlock) {
        self.confirmClickBlock();
    }
    [self dismissAlert:YES];
}

- (void)dismissAlert:(BOOL)animation
{
    UIView *backgroundView = (UIView *)[self viewWithTag:200];
    if (animation) {
        [UIView animateWithDuration:0.5 animations:^{
            self.alpha = 0;
            backgroundView.transform = CGAffineTransformMakeScale(0.25, 0.25);
            backgroundView.alpha = 0;
        } completion:^(BOOL finish) {
            [backgroundView removeFromSuperview];
            [self removeFromSuperview];
        }];
    } else {
        [backgroundView removeFromSuperview];
        [self removeFromSuperview];
    }
}
- (void)show
{
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    [window addSubview:self];
    
    UIView *backgroundView = (UIView *)[self viewWithTag:200];
    
    [UIView animateWithDuration:0.5 animations:^{
        self.backgroundColor = [[UIColor colorWithRed:0 green:0 blue:0 alpha:0] colorWithAlphaComponent:0.5];
        backgroundView.transform = CGAffineTransformMakeScale(1, 1);
        backgroundView.alpha = 1;
    } completion:^(BOOL finish) {
        
    }];

}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataSource count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *idenf = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:idenf];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idenf];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UILabel *numLab = [UILabel new];
        numLab.tag = 200;
        numLab.font = [UIFont systemFontOfSize:ZOOM6(30)];
        numLab.textAlignment = NSTextAlignmentCenter;
        numLab.backgroundColor = COLOR_ROSERED;
        numLab.layer.masksToBounds = YES;
        numLab.layer.cornerRadius = ZOOM6(40)*0.5;
        numLab.textColor = [UIColor whiteColor];
        [cell.contentView addSubview:numLab];
        [numLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.equalTo(cell.contentView);
            make.size.mas_equalTo(CGSizeMake(ZOOM6(40), ZOOM6(40)));
        }];
        
        UILabel *contentLab = [UILabel new];
        contentLab.tag = 201;
        contentLab.numberOfLines = 0;
        contentLab.font = [UIFont systemFontOfSize:ZOOM6(24)];
        contentLab.textColor = RGBCOLOR_I(125, 125, 125);
        [cell.contentView addSubview:contentLab];
        
        [contentLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(numLab.mas_right).offset(ZOOM6(8));
            make.top.equalTo(cell.contentView).offset(ZOOM6(10));
            make.right.equalTo(cell.contentView);
            make.bottom.equalTo(cell.contentView).offset(-ZOOM6(40));
        }];
        
    }
    
    UILabel *numLab = (UILabel *)[cell.contentView viewWithTag:200];
    UILabel *contentLab = (UILabel *)[cell.contentView viewWithTag:201];
    
    numLab.text = [NSString stringWithFormat:@"%ld", (long)indexPath.row+1];
    contentLab.text = self.dataSource[indexPath.row];
    
    return cell;
}


- (void)viewDidLayoutSubviews
{
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsMake(0, 2*kScreenWidth,0,0)];
    }
    
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.tableView setLayoutMargins:UIEdgeInsetsMake(0, 2*kScreenWidth,0,0)];
    }
}

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.estimatedRowHeight = 44;
        _tableView.rowHeight = UITableViewAutomaticDimension;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

- (NSMutableArray *)dataSource
{
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

@end
@implementation TaskMenuButtonView

- (instancetype)init
{
    if (self = [super init]) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame titleArray:(NSArray *)titleArray normalImgArray:(NSArray *)normalImgArray selectImgArray:(NSArray *)selectImgArray
{
    if (self = [super init]) {
        _titleArray = titleArray;
        _normalImgArray = normalImgArray;
        _selectImgArray = selectImgArray;
    }
    return self;
}

- (void)show
{
    ESWeakSelf;
    if (_titleArray.count) {
        //        CGFloat W_btn = CGRectGetWidth(self.frame)/self.titleArray.count;
        //        CGFloat H_btn = CGRectGetHeight(self.frame);
        
        //        MyLog(@"w: %f, h: %f", W_btn, H_btn);
        
        CGFloat scal = (CGFloat)1/self.titleArray.count;
        
        UIButton *lastBtn =  nil;
        for (int i = 0; i<self.titleArray.count; i++) {
            UIButton *btn = [UIButton new];
            //            btn.backgroundColor = COLOR_RANDOM;
            [btn setTitle:self.titleArray[i] forState:UIControlStateNormal];
            [btn setTitle:self.titleArray[i] forState:UIControlStateSelected];
            btn.titleLabel.font = [UIFont systemFontOfSize:ZOOM6(28)];
            [btn setTitleColor:COLOR_ROSERED forState:UIControlStateSelected];
            [btn setTitleColor:RGBCOLOR_I(68, 68, 68) forState:UIControlStateNormal];
            //            [btn setImage:self.selectImgArray[i] forState:UIControlStateSelected];
            //            [btn setImage:self.normalImgArray[i] forState:UIControlStateNormal];
            btn.tag = 100 + i;
            [btn addTarget:self action:@selector(menuBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            
            [self addSubview:btn];
            
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                if (!lastBtn) {
                    make.left.equalTo(__weakSelf.mas_left);
                } else {
                    make.left.equalTo(lastBtn.mas_right);
                }
                make.centerY.equalTo(__weakSelf.mas_centerY);
                make.width.equalTo(__weakSelf.mas_width).multipliedBy(scal);
                make.height.equalTo(__weakSelf.mas_height);
                //                make.size.mas_equalTo(CGSizeMake(100, ZOOM6(80)));
            }];
            lastBtn = btn;
        }
        
    }
}

- (void)menuBtnClick:(UIButton *)sender
{
    for (int i = 0; i<self.titleArray.count; i ++) {
        UIButton *btn = (UIButton *)[self viewWithTag:100+i];
        btn.selected = NO;
    }
    sender.selected = YES;
    
    NSInteger index = sender.tag - 100;
    if (self.menuBtnClickBlock) {
        self.menuBtnClickBlock(index);
    }
}

@end

