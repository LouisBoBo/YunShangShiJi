//
//  TFActivityShopVC.m
//  YunShangShiJi
//
//  Created by jingaiweiyi on 2016/10/22.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import "TFActivityShopVC.h"
#import "TFBrowseShopVM.h"
#import "WaterFLayout.h"
#import "WaterFlowCell.h"
#import "ShopDetailViewController.h"
#import "TFPopBackgroundView.h"
#import "TFGroupBuysVC.h"
#import "CollectionImageHeaderView.h"
#import "CollectionImageMenuReusableView.h"
#import "DefaultImgManager.h"
#import "TFCollocationViewController.h"
@interface TFActivityShopVC ()
{
    dispatch_source_t _timer;
}

@property (nonatomic, strong) UIButton *expBtn;
@property (nonatomic, strong) TFBrowseShopVM *shopVM;
@property (nonatomic, assign) NSInteger currPage;

@property (nonatomic, strong) UICollectionView *collectionView;


@property (nonatomic, assign) BOOL isTimeOut;
@property (nonatomic, assign) double currTimeCount;
@property (nonatomic, strong) NSMutableArray *selectShopArray; /**< 选择过的商品计数 */
@property (nonatomic, assign) BOOL showGetMoneyWindow;
//@property (nonatomic, strong) TFBrowseShopVM *viewModel;
@property (nonatomic, assign) NSInteger browseCount;
@property (nonatomic, strong) ActiveMenuButtonView *menuButtonView;
@end

@implementation TFActivityShopVC
{
    NSString *appendingStr;   //刷新条件
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavigationItemLeft:@"活动商品专区"];
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"threemenu"];
    
    [self setupUI];
    
    [self setData];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self startTimer:self.currTimeCount action:@selector(refreshHeaderTimerView:) withTimeOut:@selector(timerOut)];
}

- (void)setData
{
    self.currPage = 1;
    
    self.currTimeCount = 0;
    self.currPage = 1;
    appendingStr=@"add_time&order=desc";//默认最新
    
    //    self.randomNum = 2; //+arc4random_uniform(2);
    if (self.randomNum > 0) {
        self.randomNum --;
    }
    
    [self httpData];
    
    [self reloadDataBlock:^{
        [self httpData];
    }];
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
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *count = [user objectForKey:TASK_LIULAN_SHOPCOUNT];
    if(count.intValue >= self.liulanCount)
    {
        self.showGetMoneyWindow = YES;
        [user removeObjectForKey:TASK_LIULAN_SHOPCOUNT];
    }
    
    if(self.isLiulan == YES )//浏览分钟数
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
        
    }else{
        if (!self.showGetMoneyWindow) {
            
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
            
        }
        else{
            
            if (self.browseFinish) {
                self.browseFinish();
            }
            [self popViewController];

        }
        
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

- (void)httpData
{
    [self.shopVM handleActivityShopDataWithFromPageNum:10 curPager:self.currPage Sort:appendingStr success:^(NSArray *modelArray, Response *response) {
        
        [self.collectionView headerEndRefreshing];
        [self.collectionView footerEndRefreshing];
        if (response.status == 1) {
            if (self.currPage == 1) {
                [self.shopVM.service.dataSource removeAllObjects];
            }
            //加载成功
            [self.shopVM.service.dataSource addObjectsFromArray:modelArray];
            
            //是否关闭上拉加载
            //            self.tableView.footerHidden = self.shopVM.tableViewService.dataSource.count >= model.pager.rowCount;
            dispatch_async(dispatch_get_main_queue(), ^{
                
                if (self.shopVM.service.dataSource.count >= response.pager.rowCount && self.currPage>1 && modelArray.count == 0) {
                    NavgationbarView *nv = [[NavgationbarView alloc] init];
                    [nv showLable:@"没有更多商品了哦~" Controller:self];
                }
                
                [self.collectionView reloadData];
            });
            
        } else {
            NavgationbarView *nv = [[NavgationbarView alloc] init];
            [nv showLable:response.message Controller:self];
        }
        
        if (self.shopVM.service.dataSource.count <= 0) {
            //无数据
            [self showBackgroundTabBar:NO type:ShowBackgroundTypeListEmpty message:@"没有你想要的结果"];
        } else {
            //有数据
            [self cleanShowBackground];
        }

    } failure:^(NSError *error) {
        [self showBackgroundTabBar:NO type:ShowBackgroundTypeNetError message:nil];
        [self.collectionView headerEndRefreshing];
        [self.collectionView footerEndRefreshing];
    }];
//    [self.shopVM handleActivityShopDataWithFromPageNum:10 curPager:self.currPage  success:^(NSArray *modelArray, Response *response) {
//        [self.collectionView headerEndRefreshing];
//        [self.collectionView footerEndRefreshing];
//        if (response.status == 1) {
//            if (self.currPage == 1) {
//                [self.shopVM.service.dataSource removeAllObjects];
//            }
//            //加载成功
//            [self.shopVM.service.dataSource addObjectsFromArray:modelArray];
//            
//            //是否关闭上拉加载
//            //            self.tableView.footerHidden = self.shopVM.tableViewService.dataSource.count >= model.pager.rowCount;
//            dispatch_async(dispatch_get_main_queue(), ^{
//                
//                if (self.shopVM.service.dataSource.count >= response.pager.rowCount && self.currPage>1 && modelArray.count == 0) {
//                    NavgationbarView *nv = [[NavgationbarView alloc] init];
//                    [nv showLable:@"没有更多商品了哦~" Controller:self];
//                }
//                
//                [self.collectionView reloadData];
//            });
//            
//        } else {
//            NavgationbarView *nv = [[NavgationbarView alloc] init];
//            [nv showLable:response.message Controller:self];
//        }
//        
//        if (self.shopVM.service.dataSource.count <= 0) {
//            //无数据
//            [self showBackgroundTabBar:NO type:ShowBackgroundTypeListEmpty message:@"没有你想要的结果"];
//        } else {
//            //有数据
//            [self cleanShowBackground];
//        }
//        
//    } failure:^(NSError *error) {
//        [self showBackgroundTabBar:NO type:ShowBackgroundTypeNetError message:nil];
//        [self.collectionView headerEndRefreshing];
//        [self.collectionView footerEndRefreshing];
//    }];
}

- (void)setupUI
{
    kWeakSelf(self);
    [self.navigationView addSubview:self.expBtn];
//    self.expBtn.hidden = self.isLiulan?YES:NO;
    [self.expBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakself.navigationView.mas_top).offset(20);
        make.right.equalTo(weakself.navigationView.mas_right).offset(-ZOOM6(30));
        make.height.mas_equalTo(kNavigationBarHeight);
    }];
    
//    CGFloat space =0;
//    if(self.liulanCount)
//    {
//        space = ZOOM6(60);
//        [self addHeaderTimerView];
//    }
    
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.navigationView.mas_bottom);
        make.left.right.bottom.equalTo(self.view);
    }];

    /*
    UIButton *goBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [goBtn setBackgroundImage:[UIImage imageNamed:@"pintuan_go"] forState:UIControlStateNormal];
    goBtn.tag = 100;
    [goBtn handleClickEvent:UIControlEventTouchUpInside withClickBlock:^(UIButton *sender) {
//        MyLog(@"%ld", (long)sender.tag);
         [self stopTimer];
        TFGroupBuysVC *vc = [[TFGroupBuysVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }];
    [self.view addSubview:goBtn];
    [goBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(ZOOM6(140), ZOOM6(140)));
        make.right.equalTo(self.view.mas_right).offset(-ZOOM6(40));
        make.bottom.equalTo(self.view.mas_bottom).offset(-ZOOM6(120));
    }];
    */
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

- (void)explainBtnClick
{
    [MobClick event:BrowseShop_ExplainButton];
    [self showPopView];
}

- (void)showPopView
{
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

- (void)expBtnClick
{

    TFPopBackgroundView *popView = [[TFPopBackgroundView alloc] init];
    popView.showCancelBtn = YES;
    popView.headerTitle = @"任务说明";
    
    UIView *contentV = [[UIView alloc] init];
//    contentV.backgroundColor = COLOR_RANDOM;
    popView.contentView = contentV;
    
    
    UILabel *titleLabel = [UILabel new];
    titleLabel.font = kFont6px(32);
    titleLabel.textColor = COLOR_ROSERED;
    titleLabel.text = self.isLiulan?@"浏览美衣达到指定时间即可完成任务":@"浏览完指定数量商品即可完成任务~";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.adjustsFontSizeToFitWidth = YES;
    [contentV addSubview:titleLabel];
    
    UILabel *desTitle = [UILabel new];
    desTitle.font = kFont6px(32);
    desTitle.textColor = RGBCOLOR_I(62, 62, 62);
    desTitle.text = @"购买温馨提示";
    desTitle.textAlignment = NSTextAlignmentCenter;
    [contentV addSubview:desTitle];

    UILabel *contentLabel = [UILabel new];
    contentLabel.font = kFont6px(28);
    contentLabel.textColor = RGBCOLOR_I(125, 125, 125);
    contentLabel.numberOfLines = 0;
    contentLabel.text = @"活动商品价格为最优惠价格，购买时不能使用余额、积分、优惠券。由于抢购人数较多，商品库存有限，请及时下单，以免心爱的美衣被抢光喔～";
    [contentV addSubview:contentLabel];
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(contentV.mas_top).offset(ZOOM6(0));
        make.left.right.equalTo(contentV);
        
    }];
    
    [desTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleLabel.mas_bottom).offset(ZOOM6(40));
        make.left.right.equalTo(contentV);
        
    }];
    
    contentLabel.preferredMaxLayoutWidth = popView.contentViewWidth;
    [contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(desTitle.mas_bottom).offset(ZOOM6(20));
        make.left.right.equalTo(contentV);
        make.bottom.equalTo(contentV.mas_bottom);
    }];

    
    popView.rightText = @"立即浏览美衣";
    [contentV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(popView.contentViewWidth);
    }];
    [contentV setNeedsLayout];
    [contentV layoutIfNeeded];
    
    [popView showCancelBlock:^{
        
    } withConfirmBlock:^{
        
    } withNoOperationBlock:^{
        
    }];
}

#pragma mark - 去商品详情
- (void)pushShopDetailVCWithModel:(TFShoppingM *)model indexPath:(NSIndexPath *)indexPath
{
    ShopDetailViewController *detail = [[ShopDetailViewController alloc]init];
    detail.shop_code = model.shop_code;
    if(self.liulanCount > 0)
    {
        detail.isNOFightgroups = YES;
        detail.stringtype = @"活动商品";
        detail.rewardType = self.rewardType;
        detail.rewardValue = self.rewardValue;
        detail.Browsedic = self.Browsedic;
        detail.browseCount = self.browseCount;
        detail.currTimeCount = self.currTimeCount;
        detail.index_day = self.day;
        detail.index_id = self.index;
        detail.rewardCount = self.rewardCount;
        
        if ((self.browseCount == self.randomNum) && !self.showGetMoneyWindow) {
            detail.showGetMoneyWindow = YES;
        }
        ESWeakSelf;
        
        detail.browseCountBlock = ^() {
            if (![__weakSelf.selectShopArray containsObject:[NSNumber numberWithInteger:indexPath.item]]) {
                if (self.browseCount == self.randomNum) {
                    self.showGetMoneyWindow = YES;
                }
                __weakSelf.browseCount++; //计数
                [__weakSelf.selectShopArray addObject:[NSNumber numberWithInteger:indexPath.item]];
                MyLog(@"\nrandomNum: %ld, \nbrowseCount: %ld, \nselectShopArray: %@", (long)self.randomNum ,(long)self.browseCount, self.selectShopArray);
            }
        };

    }else{
        detail.browseCount = -1;
        detail.stringtype = @"活动商品";
        detail.isNOFightgroups = YES;
    }
  
    [self.navigationController pushViewController:detail animated:YES];
}

- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        WaterFLayout *flowLayout=[[WaterFLayout alloc] init];
        
        flowLayout.sectionInset = UIEdgeInsetsMake(0, 5, 0, 5);
        flowLayout.minimumColumnSpacing = 5;
        flowLayout.minimumInteritemSpacing = 0;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _collectionView.delegate = self.shopVM.service;
        _collectionView.dataSource = self.shopVM.service;
        _collectionView.scrollsToTop = YES;
        _collectionView.backgroundColor = RGBCOLOR_I(240, 240, 240);
        
        [_collectionView registerNib:[UINib nibWithNibName:@"WaterFlowCell" bundle:nil] forCellWithReuseIdentifier:@"WATERFLOWCELLID"];
        [_collectionView registerClass:[CollectionImageMenuReusableView class] forSupplementaryViewOfKind:WaterFallSectionHeader withReuseIdentifier:@"HeaderView"];
        
        __weak typeof (self) weakSelf = self;
        [_collectionView addHeaderWithCallback:^{
            weakSelf.currPage = 1;
            [weakSelf httpData];
        }];
        
        [_collectionView addFooterWithCallback:^{
            weakSelf.currPage ++;
            [weakSelf httpData];
        }];
        
    }
    return _collectionView;
}

- (TFBrowseShopVM *)shopVM
{
    if (!_shopVM) {
        _shopVM = [[TFBrowseShopVM alloc] init];
        kSelfWeak;

        [_shopVM.service setHeightForHeaderInSectionBlock:^CGFloat(UICollectionView *collectionView, UICollectionViewLayout *collectionViewLayout, NSInteger section) {
            return weakSelf.bannerImage.length ? kScreenWidth/1.7+ZOOM6(70) : ZOOM6(70);
        }];
        [_shopVM.service setViewForSupplementaryElementOfKindAtIndexPathBlock:^UICollectionReusableView *(UICollectionView *collectionView, NSString *kind, NSIndexPath *indexPath) {
            CollectionImageMenuReusableView * headerView =(CollectionImageMenuReusableView *)[collectionView dequeueReusableSupplementaryViewOfKind:WaterFallSectionHeader withReuseIdentifier:@"HeaderView" forIndexPath:indexPath];
            [headerView.headImgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@!450", [NSObject baseURLStr_Upy], weakSelf.bannerImage]]placeholderImage:[[DefaultImgManager sharedManager] defaultImgWithSize:headerView.frame.size]];
            
//            [headerView addSubview:weakSelf.menuButtonView];
//            [weakSelf.menuButtonView setMenuBtnClickBlock:^(NSInteger btnClickIndex) {
//                
//                [weakSelf httpSelectIndex:btnClickIndex];
//            }];
//            [weakSelf.menuButtonView show];

            [headerView.menubackview setMenuBtnClickBlock:^(NSInteger btnClickIndex) {
                
                [weakSelf httpSelectIndex:btnClickIndex];
            }];

            return headerView;
        }];

        [_shopVM.service didSelectItemAtIndexPathBlock:^(UICollectionView *collectionView, NSIndexPath *indexPath) {
            
            [self stopTimer];
            
            TFShoppingM *model = self.shopVM.service.dataSource[indexPath.item];
            
            /**< 商品详情 */
            [self pushShopDetailVCWithModel:model indexPath:indexPath];
            
        }];
        
        [_shopVM.service cellForItemAtIndexPathBlock:^UICollectionViewCell *(UICollectionView *collectionView, NSIndexPath *indexPath) {
            WaterFlowCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"WATERFLOWCELLID" forIndexPath:indexPath];
            cell.selectBtn.hidden = YES;
            if (self.shopVM.service.dataSource.count>indexPath.item) {
                [cell receiveDataModel7:(TFShoppingM *)self.shopVM.service.dataSource[indexPath.item]];
            }
            return cell;
        }];
    }
    return _shopVM;
}

- (void)httpSelectIndex:(NSInteger)index
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
    
    self.currPage = 1;
    [self httpData];
}

- (ActiveMenuButtonView *)menuButtonView
{
    if (!_menuButtonView) {
        _menuButtonView = [[ActiveMenuButtonView alloc] init];
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

- (UIButton *)expBtn
{
    if (!_expBtn && !_isMonday) {
        _expBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        _expBtn.backgroundColor = COLOR_RANDOM;
        [_expBtn setTitle:@"任务说明" forState:UIControlStateNormal];
        [_expBtn setTitleColor:RGBA(128, 128, 128, 1) forState:UIControlStateNormal];
        _expBtn.titleLabel.font = kFont6px(32);
        _expBtn.titleLabel.textAlignment = NSTextAlignmentRight;
        [_expBtn addTarget:self action:@selector(expBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _expBtn;
}

- (NSMutableArray *)selectShopArray
{
    if (!_selectShopArray) {
        _selectShopArray = [NSMutableArray array];
    }
    return _selectShopArray;
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

@implementation ActiveMenuButtonView

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

