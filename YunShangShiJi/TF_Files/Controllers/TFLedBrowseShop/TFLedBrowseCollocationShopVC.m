//
//  TFLedBrowseCollocationShopVC.m
//  YunShangShiJi
//
//  Created by jingaiweiyi on 2016/10/9.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import "TFLedBrowseCollocationShopVC.h"
#import "LedBrowseCollocationShopCell.h"
#import "TFBrowseShopVM.h"
#import "TFPopBackgroundView.h"
#import "TFLedBrowseShopViewController.h"
#import "LedBrowseCollocationShopCell.h"
#import "ShopDetailViewController.h"
#import "CollocationDetailViewController.h"
#import "CollocationMainModel.h"
#import "YFTagButton.h"
#import "YFTagsView.h"
#import "TFDailyTaskView.h"
#import "TFNoviceTaskView.h"
#import "SpecialDetailViewController.h"
static NSString * const isFirstLedBroweCollocation = @"firstLedBroweCollocationId";
@interface TFLedBrowseCollocationShopVC ()
{
    dispatch_source_t _timer;
}

@property (nonatomic, strong) UIView *headerTimerView;
@property (nonatomic, strong) UILabel *messageLab;
@property (nonatomic, strong) UIButton *explainBtn;

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;

@property (nonatomic, strong) TFBrowseShopVM *shopVM;
@property (nonatomic, assign) NSInteger currPage;

@property (nonatomic, assign) BOOL showGetMoneyWindow;
@property (nonatomic, assign) double currTimeCount;
@property (nonatomic, assign) BOOL isTimeOut;
@property (nonatomic, strong) NSMutableArray *selectShopArray; /**< 选择过的商品计数 */
@property (nonatomic, assign) NSInteger browseCount; /**< 已经浏览了几次 */
@end

@implementation TFLedBrowseCollocationShopVC

- (void)dealloc
{
    if (self.tableView.topShowView) {
        [self.tableView removeObserver:self.tableView forKeyPath:observerRefreshHeaderViewKeyPath];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setNavigationItemLeft:@"浏览有奖"];
    
    [self setupUI];
    
    [self setData];
    
    kWeakSelf(self);
    [self loadFailBtnBlock:^{
        [weakself httpData];
    }];
    
}
#pragma mark - 设置数据
- (void)setData
{
    self.currTimeCount = 0;
    self.currPage = 1;
    if (self.randomNum > 0) {
        self.randomNum --;
    }
    [self httpData];
}

- (void)httpData
{
    [self.shopVM handleCollocationDataWithFromPageNum:10 curPager:self.currPage success:^(id data) {
        
        [self.tableView headerEndRefreshing];
        [self.tableView footerEndRefreshing];
        [self.tableView ffRefreshHeaderEndRefreshing];
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        CollocationMainModel *model = data;
        
        if (model.status == 1) {
            
            if (self.currPage == 1) {
                [self.shopVM.tableViewService.dataSource removeAllObjects];
            }
            //加载成功
            [self.shopVM.tableViewService.dataSource addObjectsFromArray:model.listShop];
            
            if (![[NSUserDefaults standardUserDefaults] objectForKey:isFirstLedBroweCollocation]) {
                
                [NSObject delay:0.1 completion:^{
                    CollocationModel *cModel = [self.shopVM.tableViewService.dataSource firstObject];
                    if ([cModel.type integerValue] !=2 ) {
                        CollocationShopModel *sModel = [cModel.collocation_shop firstObject];
                        [self showWelComeViewFrame:CGRectMake(0, Height_NavBar+ZOOM6(60), kScreen_Width, kScreen_Width) model:sModel];
                    }
                    
                }];
                [[NSUserDefaults standardUserDefaults] setObject:@"NO" forKey:isFirstLedBroweCollocation];
            }

            if (self.shopVM.tableViewService.dataSource.count <= 0) {
                //无数据
                [self loadingDataBackgroundView:self.tableView img:nil text:nil];
            } else {
                //有数据
                [self loadingDataSuccess];
            }
            //是否关闭上拉加载
//            self.tableView.footerHidden = self.shopVM.tableViewService.dataSource.count >= model.pager.rowCount;
//            self.tableView.footerHidden = YES;
            
            if (self.shopVM.tableViewService.dataSource.count >= model.pager.rowCount && self.currPage>1 && model.listShop.count == 0) {
                NavgationbarView *nv = [[NavgationbarView alloc] init];
                [nv showLable:@"没有更多商品了哦~" Controller:self];
            }
            
            [self.tableView reloadData];
        } else {
            //加载失败
            [MBProgressHUD showError:model.message];
            if (self.shopVM.tableViewService.dataSource.count == 0) {
                [self loadingDataBackgroundView:self.tableView img:[UIImage imageNamed:@"哭脸"] text:@"亲,没网了"];
                self.tableView.footerHidden = YES;
            }
        }

    }];
    
}
#pragma mark - 配置UI
- (void)setupUI
{
    // 禁用 iOS7 返回手势
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        //        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
    
    [self.view addSubview:self.headerTimerView];
    kWeakSelf(self);
    [_headerTimerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakself.navigationView.mas_bottom);
        make.left.right.equalTo(weakself.view);
        make.height.mas_equalTo(ZOOM6(60));
    }];
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakself.headerTimerView.mas_bottom);
        make.bottom.left.right.equalTo(weakself.view);
    }];
    
    
}

#pragma mark - 弹提示框
- (void)showWelComeViewFrame:(CGRect)frame model:(CollocationShopModel *)model
{
    if (!model) {
        return;
    }
    
    CollocationShopModel *sModel = model;
    UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
    
    UIView *backgroundV = [[UIView alloc] initWithFrame:keyWindow.bounds];
    backgroundV.backgroundColor = [UIColor clearColor];
    backgroundV.tag = 2008;
    [keyWindow addSubview:backgroundV];
    
    UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGRClick:)];
    [backgroundV addGestureRecognizer:tapGR];
    
    [UIView animateWithDuration:0.5 animations:^{
        backgroundV.backgroundColor = [[UIColor colorWithRed:0 green:0 blue:0 alpha:0] colorWithAlphaComponent:0.5];
    } completion:^(BOOL finish) {
        
    }];
    
    UIView *cellV = [[UIView alloc] init];
    cellV.backgroundColor = [UIColor clearColor];
    cellV.frame = frame;
    [backgroundV addSubview:cellV];
    
    CGFloat scale = kScreen_Width/375;
    YFTagsView *tagView = [[YFTagsView alloc] initWithFrame:CGRectMake(-20*scale, -12*scale, 25*scale, 24*scale) Type:YFTagsViewTypeLeft];
    tagView.userInteractionEnabled = NO;
    tagView.frame = CGRectMake(-20*scale, -12*scale, 25*scale, 24*scale);
    CGPoint point = CGPointMake(168*scale,110*scale);
    CGFloat maxWidth = point.x + 5*scale;
    
    tagView.type = YFTagsViewTypeLeft;
    tagView.maxWidth = maxWidth;
    tagView.isImage = YES;
    tagView.isHighlight = YES;
    tagView.title = sModel.shop_name?:@"";
    
    tagView.right = cellV.width*sModel.shop_x+5*scale;
    tagView.centerY = cellV.height*sModel.shop_y;
    [cellV addSubview:tagView];
    
    UIButton *tagBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    tagBtn.frame = tagView.frame;
    tagBtn.backgroundColor = [UIColor clearColor];
    [tagBtn addTarget:self action:@selector(tagBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [cellV addSubview:tagBtn];
    
    UIImage *image = [UIImage imageNamed:@"ledBrowse_shoushi"];
    CGFloat image_W = tagView.width*1.5;
    CGFloat image_H = [UIImage imageConvertHeightWithImage:image fromWidth:image_W];
    UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(-tagView.left, tagView.bottom, image_W, image_H)];
    imageV.centerX = tagView.centerX;
    imageV.image = image;
    [cellV addSubview:imageV];
    
    UIImage *knowImage = [UIImage imageNamed:@"ledBrowse_but_i-know"];
    CGFloat knowImage_H = [UIImage imageConvertHeightWithImage:knowImage fromWidth:image_W];
    
    UIButton *knowBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [knowBtn setImage:knowImage forState:UIControlStateNormal];
    knowBtn.frame = CGRectMake(0, 0, image_W, knowImage_H);
    knowBtn.bottom = kScreen_Height-ZOOM6(280);
    knowBtn.centerX = kScreen_Width*0.5;
    [knowBtn addTarget:self action:@selector(knowBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [backgroundV addSubview:knowBtn];
}

- (void)tagBtnClick
{
    [self hideTheWelComeVAniamtion:NO];
    
    CollocationModel *cModel = [self.shopVM.tableViewService.dataSource firstObject];
    CollocationShopModel *sModel = [cModel.collocation_shop firstObject];
    [self pushShopDetailShopCode:sModel.shop_code row:0];
}

- (void)knowBtnClick
{
    [self hideTheWelComeVAniamtion:YES];
}

- (void)tapGRClick:(UITapGestureRecognizer *)sender
{
    [self hideTheWelComeVAniamtion:YES];
}

- (void)hideTheWelComeVAniamtion:(BOOL)isAnimation
{
    UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
    UIView *backgroundV = [keyWindow viewWithTag:2008];
    if (!isAnimation) {
        [backgroundV removeFromSuperview];
        return;
    }
    [UIView animateWithDuration:0.5 animations:^{
        backgroundV.alpha = 0;
    } completion:^(BOOL finish) {
        [backgroundV removeFromSuperview];
    }];
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

    if (!self.showGetMoneyWindow) {
        
        TFPopBackgroundView *popView = [[TFPopBackgroundView alloc] init];
        popView.title = @"亲~确定要离开吗？";
        popView.message = @"再逛一下下就可以获得任务奖励噢~";
        popView.leftText = @"不了，谢谢";
        popView.rightText = @"再逛逛";
        popView.textAlignment = NSTextAlignmentCenter;
//        popView.headerTitle = @"温馨提示";
        [popView setCancelBlock:^{
            if (self.browseFail) {
                self.browseFail();
            }
            [MobClick event:BrowseShop_ExitButton];
            [self popViewController];
        } withConfirmBlock:^{
            
        } withNoOperationBlock:^{
            
        }];
//        popView.headerTitle = @"任务提示";
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

- (void)viewWillAppear:(BOOL)animated
{
    [self startTimer:self.currTimeCount action:@selector(refreshHeaderTimerView:) withTimeOut:@selector(timerOut)];
}

/**
 *  超时
 */
- (void)timerOut
{
    MyLog(@"时间溢出");
    self.isTimeOut = YES;
}


- (void)refreshHeaderTimerView:(NSString *)timeText
{
    //    [self.explainBtn setTitle:timeText forState:UIControlStateNormal];
    
    MyLog(@"%.0f", self.currTimeCount);
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


/**
 说明按钮
 */
- (void)explainBtnClick
{
    [self showPopView];
}

- (void)showPopView
{
    //    ExplainPopView *popView = [[ExplainPopView alloc] init];
    //    [popView show];
    
    //    [popView setCancelBlock:^{
    
    //    } withConfirmBlock:^{
    
    //    } withNoOperationBlock:^{
    
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
- (void)setBrowseFinishBlock:(BrowseFinishBlock)browseFinish browseFail:(BrowseFailBlock)browseFail
{
    self.browseFinish = browseFinish;
    self.browseFail = browseFail;
}

- (TFBrowseShopVM *)shopVM
{
    if (!_shopVM) {
        _shopVM = [[TFBrowseShopVM alloc] init];
        
        [_shopVM.tableViewService cellForRowAtIndexPathBlock:^UITableViewCell *(UITableView *tableView, NSIndexPath *indexPath) {
            static NSString *cellName = @"YFDPCell";
            LedBrowseCollocationShopCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
            if (nil == cell) {
                cell = [[LedBrowseCollocationShopCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
            }
            cell.currIndexPath = indexPath;
            __weak typeof(self) weakSelf = self;
            [cell setShopCodeBlock:^(NSString *shopCode, NSIndexPath *currIndexPath) {
                [weakSelf pushShopDetailShopCode:shopCode row:currIndexPath.row];
            }];
            CollocationModel *model = self.shopVM.tableViewService.dataSource[indexPath.row];
            
            [cell receiveDataModel:model];
            return cell;
        }];
        
        [_shopVM.tableViewService heightForRowAtIndexPathBlock:^CGFloat(UITableView *tableView, NSIndexPath *indexPath) {
            
            CollocationModel *model = self.shopVM.tableViewService.dataSource[indexPath.row];
            
            if ([model.type intValue] == 2) {
                if (indexPath.row == self.shopVM.tableViewService.dataSource.count - 1) {
                    return [LedBrowseCollocationShopCell cellForTopicsHeight] - kZoom6pt(10);
                } else {
                    return [LedBrowseCollocationShopCell cellForTopicsHeight];
                }
            } else {
                if (indexPath.row == self.shopVM.tableViewService.dataSource.count - 1) {
                    return [LedBrowseCollocationShopCell cellHeight] - kZoom6pt(10);
                } else {
                    return [LedBrowseCollocationShopCell cellHeight];
                }
            }

        }];
        
        [_shopVM.tableViewService didSelectRowAtIndexPathBlock:^(UITableView *tableView, NSIndexPath *indexPath) {
            [tableView deselectRowAtIndexPath:indexPath animated:NO];
            CollocationModel *model = self.shopVM.tableViewService.dataSource[indexPath.row];
            NSString *shopCodes = nil;
            for (CollocationShopModel *csModel in model.collocation_shop) {
                shopCodes = shopCodes?[NSString stringWithFormat:@"%@,%@",shopCodes,csModel.shop_code]:csModel.shop_code;
            }
            
            if(model.type.intValue == 2)//专题
            {
                SpecialDetailViewController *collcationVC = [[SpecialDetailViewController alloc]init];
                collcationVC.hidesBottomBarWhenPushed = YES;
                collcationVC.collocationCode = model.collocation_code;
                collcationVC.collcationModel = model;
                
                /**< 签到相关 */
                kWeakSelf(self);
//                if(self.randomNum >0)
                if(self.liulanCount >0)
                {
                    collcationVC.stringtype = @"签到领现金";
                }
                collcationVC.rewardType = self.rewardType;
                collcationVC.rewardValue = self.rewardValue;
                collcationVC.Browsedic = self.Browsedic;
                collcationVC.browseCount = self.browseCount;
                collcationVC.currTimeCount = self.currTimeCount;
                collcationVC.index_id = self.index;
                collcationVC.index_day = self.day;
                collcationVC.rewardCount = self.rewardCount;
                
                if ((self.browseCount == self.randomNum) && !self.showGetMoneyWindow) {
                    
                    collcationVC.showGetMoneyWindow = YES;
                    
                }
                
                kWeakSelf(collcationVC);
                collcationVC.browseCountBlock = ^(NSString *shopCode) {
                    
                    if (![weakself.selectShopArray containsObject:shopCode]) {
                        if (self.browseCount == self.randomNum) {
                            weakself.showGetMoneyWindow = YES;
                        }
                        
                        weakself.browseCount++; //计数
                        [weakself.selectShopArray addObject:shopCode];
                        
                        if (self.browseCount == self.randomNum) {
                            weakcollcationVC.showGetMoneyWindow = YES;
                            weakcollcationVC.browseCount  = self.browseCount;
                        }
                        
                    }
                };

                [self.navigationController pushViewController:collcationVC animated:YES];
                
                
            }else{
                
                CollocationDetailViewController *collcationVC =[[CollocationDetailViewController alloc]init];
                collcationVC.pushType = @"TFLedBrowseCollocationShopVC";
                collcationVC.collocationCode = model.collocation_code;
                collcationVC.shopCodes = shopCodes;
                collcationVC.hidesBottomBarWhenPushed= YES;
                collcationVC.collcationModel = model;
                
                /**< 签到相关 */
                kWeakSelf(self);
                if(self.liulanCount >0)
                {
                    collcationVC.stringtype = @"签到领现金";
                }
                collcationVC.rewardType = self.rewardType;
                collcationVC.rewardValue = self.rewardValue;
                collcationVC.Browsedic = self.Browsedic;
                collcationVC.browseCount = self.browseCount;
                collcationVC.currTimeCount = self.currTimeCount;
                collcationVC.index_id = self.index;
                collcationVC.index_day = self.day;
                collcationVC.rewardCount = self.rewardCount;
                
                if ((self.browseCount == self.randomNum) && !self.showGetMoneyWindow) {
                    
                    collcationVC.showGetMoneyWindow = YES;
                    
                }
                
                kWeakSelf(collcationVC);
                collcationVC.browseCountBlock = ^(NSString *shopCode) {
                    
                    if (![weakself.selectShopArray containsObject:shopCode]) {
                        if (self.browseCount == self.randomNum) {
                            weakself.showGetMoneyWindow = YES;
                        }
                        
                        weakself.browseCount++; //计数
                        [weakself.selectShopArray addObject:shopCode];
                        
                        if (self.browseCount == self.randomNum) {
                            weakcollcationVC.showGetMoneyWindow = YES;
                            weakcollcationVC.browseCount  = self.browseCount;
                        }
                        
                    }
                };
                
                [self.navigationController pushViewController:collcationVC animated:YES];
            }
            
          
        }];
    }
    return _shopVM;
}

#pragma mark - 跳转商品详情
- (void)pushShopDetailShopCode:(NSString *)shopCode row:(NSInteger)row
{
    NSLog(@"%@",shopCode);
    ShopDetailViewController *detail = [[ShopDetailViewController alloc] initWithNibName:@"ShopDetailViewController" bundle:nil];
    detail.shop_code = shopCode;
    if(self.liulanCount > 0)
    {
        detail.stringtype = @"签到领现金";
        detail.index_id = self.index;
        detail.index_day = self.day;
        detail.rewardCount = self.rewardCount;
        detail.rewardType = self.rewardType;
        detail.rewardValue = self.rewardValue;
        detail.Browsedic = self.Browsedic;
        detail.browseCount = self.browseCount;
        detail.currTimeCount = self.currTimeCount;
        
        if ((self.browseCount == self.randomNum) && !self.showGetMoneyWindow) {
            detail.showGetMoneyWindow = YES;
        }
        ESWeakSelf;
        detail.browseCountBlock = ^() {
            if (![__weakSelf.selectShopArray containsObject:shopCode]) {
                if (self.browseCount == self.randomNum) {
                    self.showGetMoneyWindow = YES;
                }
                __weakSelf.browseCount++; //计数
                [__weakSelf.selectShopArray addObject:shopCode];
                
            }
            
        };

    }else{
        detail.stringtype = @"浏览商品";
    }
    
    
    detail.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:detail animated:YES];
    //刷新，避免indexPath错位
    [self.tableView reloadData];
}

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self.shopVM.tableViewService;
        _tableView.dataSource = self.shopVM.tableViewService;
        
        _tableView.tableFooterView = [UIView new];
        _tableView.backgroundColor = RGBCOLOR_I(240, 240, 240);
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.backgroundView = [[UIView alloc] init];
        
        kWeakSelf(self);
        [_tableView addTopHeaderWithCallback:^{
            weakself.currPage = 1;
            [weakself httpData];
        }];
        
        [_tableView addFooterWithCallback:^{
            weakself.currPage++;
            [weakself httpData];
        }];
        
    }
    return _tableView;
}

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
//        messageLab.text = @"亲，任务奖励就藏在这些商品详情页里噢，快去领取吧~";
        if(self.isTiXian)
        {
            messageLab.text = [NSString stringWithFormat:@"每浏览%zd件衣服即得%zd元提现额度哦，快去领取吧",[Signmanager SignManarer].everyLinlanCount,[Signmanager SignManarer].everyLiulanRaward];
        }else
            messageLab.text = @"亲，任务奖励就藏在这些商品详情页里噢，快去领取吧~";
        
        
    }
    return _headerTimerView;
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
