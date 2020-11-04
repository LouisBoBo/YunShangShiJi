//
//  TaskCollectionVC.m
//  YunShangShiJi
//
//  Created by yssj on 2016/11/2.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import "TaskCollectionVC.h"
#import "WaterFLayout.h"
#import "WaterFlowCell.h"
//#import "ComboShopDetailViewController.h"
#import "ShopDetailViewController.h"
#import "TFShoppingVM.h"
#import "TFPopBackgroundView.h"

#import "CollectionImageHeaderView.h"
#import "CollectionImageMenuReusableView.h"
#import "DefaultImgManager.h"
#import "TFCollocationViewController.h"
@interface TaskCollectionVC ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic,strong) UICollectionView *Mycollection;
@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic, strong) TFShoppingVM *viewModel;
@property (nonatomic , assign)int currPage;

@end

@implementation TaskCollectionVC
{
    NSString *appendingStr; //排序条件
    
    dispatch_source_t _timer;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor groupTableViewBackgroundColor];
    
    appendingStr = @"audit_time&pager.order=desc";
    
    [self setNavigationItemLeft:self.title];
    [self.view addSubview:self.Mycollection];
    
    [self httpGetData];
    kSelfWeak;
    [self loadFailBtnBlock:^{
        kSelfStrong;
        strongSelf.currPage = 1;
        [strongSelf httpGetData];
    }];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarHidden:false];
    [self startTimer:self.currTimeCount action:@selector(refreshHeaderTimerView:) withTimeOut:@selector(timerOut)];
}
- (NSMutableArray *)dataArray {
    if (nil == _dataArray) {
        _dataArray=[NSMutableArray array];
    }
    return _dataArray;
}
- (TFShoppingVM *)viewModel
{
    if (!_viewModel) {
        _viewModel = [[TFShoppingVM alloc] init];
        _viewModel.typeID = self.typeID;
        _viewModel.typeName = self.typeName;
    }
    return _viewModel;
}
- (UICollectionView *)Mycollection {
    if (nil == _Mycollection) {
        WaterFLayout *flowLayout=[[WaterFLayout alloc]init];
        flowLayout.sectionInset = UIEdgeInsetsMake(0, 5, 0, 5);
        flowLayout.minimumColumnSpacing=5;
        flowLayout.minimumInteritemSpacing=0;
        
        
        _Mycollection=[[UICollectionView alloc]initWithFrame:CGRectMake(0, Height_NavBar,kApplicationWidth,kApplicationHeight-Height_NavBar+kUnderStatusBarStartY) collectionViewLayout:flowLayout];
        _Mycollection.backgroundColor=[UIColor groupTableViewBackgroundColor];
        _Mycollection.delegate=self;
        _Mycollection.dataSource=self;
        [self.view addSubview:_Mycollection];
        [_Mycollection registerNib:[UINib nibWithNibName:@"WaterFlowCell" bundle:nil] forCellWithReuseIdentifier:@"WATERFLOWCELLID"];
//        [_Mycollection registerClass:[CollectionImageHeaderView class] forSupplementaryViewOfKind:WaterFallSectionHeader withReuseIdentifier:@"HeaderView"];

        [_Mycollection registerClass:[CollectionImageMenuReusableView class] forSupplementaryViewOfKind:WaterFallSectionHeader withReuseIdentifier:@"HeaderView"];
        kSelfWeak;
        [_Mycollection addHeaderWithCallback:^{
            weakSelf.currPage=1;
            [weakSelf httpGetData];
        }];
        [_Mycollection addFooterWithCallback:^{
            weakSelf.currPage++;
            [weakSelf httpGetData];
        }];
    }
    return _Mycollection;
}

- (void)httpSelectIndex:(NSInteger)index
{
    switch (index) {
        case 0: {

            appendingStr=@"audit_time&pager.order=desc";
        }
            break;
        case 1: {
            appendingStr=@"virtual_sales&pager.order=desc";
        }
            break;
        case 2: {
            
            appendingStr=@"shop_se_price&pager.order=asc";
        }
            break;
        case 3: {
            
            appendingStr=@"shop_se_price&pager.order=desc";
        }
            break;

        default:
            break;
    }
    
    self.currPage = 1;
    [self httpGetData];
}

#pragma mark DataAccess
- (void)httpGetData
{
    [self.viewModel handleDataWithFromType:@"购物" pageNum:self.currPage Sort:appendingStr Success:^(NSArray *modelArray, Response *response) {
        [self.Mycollection headerEndRefreshing];
        [self.Mycollection footerEndRefreshing];
        if (response.status == 1) {
            
            if (self.currPage == 1) {
                [self.dataArray removeAllObjects];
            }
            
            [self.dataArray addObjectsFromArray:modelArray];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.Mycollection reloadData];
            });
            [self loadingDataSuccess];
            
        }

    } failure:^(NSError *error) {
        
        [self.Mycollection headerEndRefreshing];
        [self.Mycollection footerEndRefreshing];
        [self loadingDataBackgroundView:self.Mycollection img:[UIImage imageNamed:@"哭脸"] text:@"亲,没网了"];
    }];
    
//    [self.viewModel handleDataWithFromType:@"购物" pageNum:self.currPage Success:^(NSArray *modelArray, Response *response) {
//        
//        [self.Mycollection headerEndRefreshing];
//        [self.Mycollection footerEndRefreshing];
//        if (response.status == 1) {
//            
//            if (self.currPage == 1) {
//                [self.dataArray removeAllObjects];
//            }
//            
//            [self.dataArray addObjectsFromArray:modelArray];
//            dispatch_async(dispatch_get_main_queue(), ^{
//                [self.Mycollection reloadData];
//            });
//            [self loadingDataSuccess];
//
//        }
//        
//    } failure:^(NSError *error) {
//        [self.Mycollection headerEndRefreshing];
//        [self.Mycollection footerEndRefreshing];
//        [self loadingDataBackgroundView:self.Mycollection img:[UIImage imageNamed:@"哭脸"] text:@"亲,没网了"];
//
//    }];
    
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if ([kind isEqualToString:WaterFallSectionHeader]) {
        CollectionImageMenuReusableView * headerView =(CollectionImageMenuReusableView *)[collectionView dequeueReusableSupplementaryViewOfKind:WaterFallSectionHeader withReuseIdentifier:@"HeaderView" forIndexPath:indexPath];
        [headerView.headImgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@!450", [NSObject baseURLStr_Upy], self.bannerImage]]placeholderImage:[[DefaultImgManager sharedManager] defaultImgWithSize:headerView.frame.size]];
        
        kWeakSelf(self);
        [headerView.menubackview setMenuBtnClickBlock:^(NSInteger btnClickIndex) {
            
            [weakself httpSelectIndex:btnClickIndex];
        }];
        return headerView;
    }

    return [UICollectionReusableView new];
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout heightForHeaderInSection:(NSInteger)section{
    return self.bannerImage.length ? kScreenWidth/1.7+ZOOM6(70) : ZOOM6(70);
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    WaterFlowCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"WATERFLOWCELLID" forIndexPath:indexPath];
    cell.selectBtn.hidden = YES;
    
    if(self.dataArray.count){
        TFShoppingM *model=self.dataArray[indexPath.item];
        [cell receiveDataModel2:model];
    }
    return cell;
}
#pragma mark item 大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
#if 0
    CGFloat imgwidh;
    CGFloat imgheigh;
    ShopDetailModel *model=_dataArray[indexPath.item];
    NSString *str=model.shop_pic;
    str=[str substringToIndex:[str length]-4];
    NSArray *arr=[str componentsSeparatedByString:@"_"];
    if(arr.count){
        imgheigh=[arr[1] floatValue];
        imgwidh=[arr[2] floatValue];
    }
    CGFloat f=imgwidh/imgheigh;
#endif
    
    CGFloat imgH = 900;
    CGFloat imgW = 600;

    CGFloat W = (kScreenWidth-18)/2.0;
    CGFloat H = imgH*W/imgW;
    
    CGSize size = CGSizeMake(W, H+5);
    return size;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
//    TFShoppingM *model=self.dataArray[indexPath.item];
//    ShopDetailViewController *detail=[[ShopDetailViewController alloc] initWithNibName:@"ShopDetailViewController" bundle:nil];
//    detail.stringtype = @"浏览商品";
//    detail.shop_code = model.shop_code;
//    [self.navigationController pushViewController:detail animated:YES];
    
    
    
//        [self stopTimer];
        TFShoppingM *model=self.dataArray[indexPath.item];
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
    

}

- (void)leftBarButtonClick
{
    MyLog(@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"is_read"]);
    
    if(self.isbrowse)
    {
        if(!self.showGetMoneyWindow && self.Browsedic !=nil)//浏览件数
        {
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

        }else{//浏览分钟数
            
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
    }else{
        if([self.comefrom isEqualToString:@"推荐"])
        {
            [self.navigationController popToRootViewControllerAnimated:YES];
        }else{
            [self.navigationController popViewControllerAnimated:YES];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
