//
//  CollectionViewController.m
//  YunShangShiJi
//
//  Created by ios-1 on 15/9/6.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//

#import "CollectionViewController.h"
#import "WaterFLayout.h"
#import "WaterFallHeader.h"
#import "WaterFlowCell.h"
#import "GlobalTool.h"
#import "ShopStoreViewController.h"
#import "ShopDetailModel.h"
#import "ShopDetailViewController.h"
#import "AFNetworking.h"
#import "MyMD5.h"
#import "MJRefresh.h"
#import "TFLoginView.h"
#import "LoginViewController.h"
#import "UIScrollView+MyRefresh.h"
#import "AppDelegate.h"
#import "TFCollectionViewService.h"
#import "TFShoppingVM.h"
#import "TFShoppingM.h"
#import "NavgationbarView.h"
#import "SpecialShopDetailViewController.h"

@interface CollectionViewController ()

@property (nonatomic, assign)BOOL isPullRefresh;
@property (nonatomic, assign)BOOL isDownRefresh;
@property (nonatomic, assign)int item;

@property (nonatomic, assign) BOOL update;
@property (nonatomic, strong) TFShoppingVM *viewModel;
@property (nonatomic, strong) TFCollectionViewService *service;

@property (nonatomic, assign) CGFloat reduceMoney;
@property (nonatomic, copy)   NSString * shop_deduction;
@end

@implementation CollectionViewController
{
    ShopDetailModel *_publicmodel;
    
    int currIndex;
}
- (void)viewDidLoad {
    [super viewDidLoad];

    [self setData];
    kSelfWeak;
    [self netStatusBlock:^(NetworkStates networkState) {
        if (networkState != NetworkStatesNone) {
            [weakSelf httpGetData];
        }
    }];
    
    //监听购买会员卡支付成功
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setData) name:@"buyVipCardSuccess" object:nil];
}

- (void)toLogin :(NSInteger)tag
{
    LoginViewController *login=[[LoginViewController alloc]init];
    login.tag = tag;
    login.loginStatue=@"toBack";
    login.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:login animated:YES];
}

- (void)pushLoginAndRegisterView
{
    TFLoginView *tf = [[TFLoginView alloc] initWithHeadImage:nil contentText:nil upButtonTitle:nil downButtonTitle:nil];
    [tf show];
    kSelfWeak;
    tf.upBlock = ^() {
        //上键");
        [weakSelf toLogin:2000];
    };
    
    tf.downBlock = ^() {
        //下键");
        [weakSelf toLogin:1000];
    };
}

- (void)setData
{
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.currPage = 1;
    UIScrollView *supScroll = (UIScrollView *)self.collectionView.superview;
    int index = supScroll.contentOffset.x/kScreenWidth;
    currIndex = index;
    
    [self getData];
}

- (void)getData
{
    if([self.fromType isEqualToString:@"新人钜惠"]){
        [self httpGetData];
    }else{
        NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:USER_TOKEN];
        if(token == nil)
        {
            [self httpGetData];
            return;
        }
        kSelfWeak;
        [self.viewModel netWorkGetBrowsePageListWithReduceMoneySuccess:^(NSDictionary *data, Response *response) {
            if(response.status == 1)
            {
                weakSelf.reduceMoney = [data[@"one_not_use_price"] floatValue];
                weakSelf.shop_deduction = data[@"shop_deduction"];
            }
            [weakSelf httpGetData];
        } failure:^(NSError *error) {
            
        }];
    }
}

#pragma mark DataAccess
- (void)httpGetData
{
    kSelfWeak;
    [self.viewModel handleDataWithFromType:self.fromType pageNum:self.currPage Success:^(NSArray *modelArray, Response *response) {
        
        [weakSelf.collectionView ffRefreshHeaderEndRefreshing];
        [weakSelf.collectionView footerEndRefreshing];
        if (response.status == 1) {

            if (weakSelf.currPage == 1) {
                [weakSelf.collectionDataArr removeAllObjects];
            }
            
            [weakSelf.collectionDataArr addObjectsFromArray:modelArray];
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf.collectionView reloadData];
            });
        }
        
    } failure:^(NSError *error) {
        [weakSelf.collectionView ffRefreshHeaderEndRefreshing];
        [weakSelf.collectionView footerEndRefreshing];
    }];
}

- (void)viewWillAppear:(BOOL)animated
{

}

- (void)viewDidLayoutSubviews
{
    
}


#pragma mark - collectionView delegate
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *typeName = [NSString stringWithFormat:@"%@列表页商品图片", self.typeName];
    [TFStatisticsClickVM handleDataWithPageType:nil withClickType:typeName success:nil failure:nil];
    
    TFShoppingM *model=self.collectionDataArr[indexPath.item];
    
    ShopDetailViewController *detail=[[ShopDetailViewController alloc] initWithNibName:@"ShopDetailViewController" bundle:nil];
    if([self.fromType isEqualToString:@"生活"])
    {
        detail.isTM = YES;
//       detail=[[SpecialShopDetailViewController alloc] initWithNibName:@"SpecialShopDetailViewController" bundle:nil];
    }
    
    
    detail.shop_code = model.shop_code;
    detail.typeID = self.typeID;
    detail.typeName = self.typeName;
    kSelfWeak;
    detail.addLikeBlock = ^() {
//        model.isLike = @"1";
        [UIView performWithoutAnimation:^{
            [weakSelf.collectionView reloadItemsAtIndexPaths:@[indexPath]];
        }];
        
    };
    detail.cancelLikeBlock = ^() {
        
//        model.isLike = @"0";
        [UIView performWithoutAnimation:^{
            [weakSelf.collectionView reloadItemsAtIndexPaths:@[indexPath]];
        }];
    };
    detail.addShopCartBlock = ^() {
//        model.isCart = @"1";
        [UIView performWithoutAnimation:^{
            [weakSelf.collectionView reloadItemsAtIndexPaths:@[indexPath]];
        }];
    };
    
    
    if ([self.fromType isEqualToString:@"店铺美衣"] || [self.fromType isEqualToString:@"新人钜惠"]) {
        detail.stringtype = self.fromType;
    }
    
    detail.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:detail animated:YES];
    //推出");
    
}


//大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat imgH = 900;
    CGFloat imgW = 600;
    
    CGFloat W = (kScreenWidth-18)/2.0;
    CGFloat H = imgH*W/imgW; //
    CGSize size = CGSizeMake(W, H+5);
    if ([self.typeName isEqualToString:@"热卖"])
        size = CGSizeMake(W, H+5);
    return size;
}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.collectionDataArr.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    WaterFlowCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"WATERFLOWCELLID" forIndexPath:indexPath];
    cell.selectBtn.hidden = YES;
    cell.flag = self.typeName;
    if (self.collectionDataArr.count>indexPath.item) {
        
        TFShoppingM *model = self.collectionDataArr[indexPath.item];
        model.reduceMoney = self.reduceMoney;
        model.shop_deduction = self.shop_deduction;
        
        cell.shop_price_new.hidden = NO;
        cell.freelingImageV.hidden = YES;
        if ([self.typeName isEqualToString:@"热卖"]) {
            [cell receiveDataModel6:model];
        } else if ([self.typeName isEqualToString:@"上新"]) {
            [cell receiveDataModel4:model];
        }else if ([self.typeName isEqualToString:@"搭配"]) {
            [cell receiveDataModel8:model];
        }else if ([self.fromType isEqualToString:@"新人钜惠"])
        {
            [cell.freelingImageV sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[NSObject baseURLStr_XCX_Upy],@"small-iconImages/heboImg/mianfei_ling.png"]]];
            cell.shop_price_new.hidden = YES;
            cell.freelingImageV.hidden = NO;
            [cell receiveDataModel2:model];
        }
        else {
            [cell receiveDataModel2:model];
        }
    }
    
    return cell;
    

}

- (UICollectionView *)collectionView
{
    if (_collectionView == nil) {
        
        WaterFLayout *flowLayout=[[WaterFLayout alloc] init];

        flowLayout.sectionInset = UIEdgeInsetsMake(0, 5, 0, 5);
        flowLayout.minimumColumnSpacing = 5;
        flowLayout.minimumInteritemSpacing = 0;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0,0, kScreenWidth, kScreenHeight) collectionViewLayout:flowLayout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.scrollsToTop = YES;
        _collectionView.backgroundColor = RGBCOLOR_I(240, 240, 240);
        
        if (@available(iOS 11.0, *)) {
            _collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        
        [_collectionView registerNib:[UINib nibWithNibName:@"WaterFlowCell" bundle:nil] forCellWithReuseIdentifier:@"WATERFLOWCELLID"];
        [self.view addSubview:_collectionView];
        
//        __weak CollectionViewController *ssc = self;
        kSelfWeak;
        
        if (_isHeadView == YES) {

            self.collectionView.topLoadHeight = [NSNumber numberWithFloat:self.headHeight];

            [self.collectionView addTopTarget:self andAction:@selector(headRefreshData) withView:nil];

        }
        
        [self.collectionView addFooterWithCallback:^{
            weakSelf.isPullRefresh = YES;
            weakSelf.currPage++;
            [weakSelf httpGetData];
        }];
    }
    return _collectionView;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
//    MyLog(@"准备开始拖拽");
    
    if (self.customDelegate!=nil && [self.customDelegate respondsToSelector:@selector(collectionViewWithScrollViewWillBeginDragging:index:)]) {
        [self.customDelegate collectionViewWithScrollViewWillBeginDragging:scrollView index:currIndex];
    }
    
}


- (void)scrollViewDidEndDragging:(nonnull UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
//    NSLog(@"结束拖拽: decelerate = %i", decelerate);
    
    if (self.customDelegate!=nil && [self.customDelegate respondsToSelector:@selector(collectionViewWithScrollViewDidEndDragging:willDecelerate:index:)]) {
        [self.customDelegate collectionViewWithScrollViewDidEndDragging:scrollView willDecelerate:decelerate index:currIndex];
    }
    
    if (decelerate == NO) {
//        NSLog(@"没有惯性, 可以在当前方法监听UIScrollView是否停止滚动");
        [self scrollViewDidEndDecelerating:scrollView];
    } else{
//        NSLog(@"有惯性, 需要在减速结束方法中监听UIScrollView是否停止滚动");
    }
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
//    MyLog(@"将要结束滚动");
    if (self.customDelegate!=nil && [self.customDelegate respondsToSelector:@selector(collectionViewWithScrollViewWillBeginDecelerating:index:)]) {
        [self.customDelegate collectionViewWithScrollViewWillBeginDecelerating:scrollView index:currIndex];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
//    MyLog(@"结束滚动");
    if (self.customDelegate!=nil && [self.customDelegate respondsToSelector:@selector(collectionViewWithscrollViewDidEndDecelerating:index:)]) {
        [self.customDelegate collectionViewWithscrollViewDidEndDecelerating:scrollView index:currIndex];
    }
}

- (void)headRefreshData
{
//    self.isDownRefresh = YES;
//    self.currPage = 1;
//    [self httpGetData];
//
//    if (self.customDelegate!=nil && [self.customDelegate respondsToSelector:@selector(collectionViewPullDownRefreshWithIndex:)]) {
//        [self.customDelegate collectionViewPullDownRefreshWithIndex:currIndex];
//    }
    
    
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *paraments=[NSMutableDictionary dictionary];
    NSString *url=[NSString stringWithFormat:@"%@order/getZeroOrderDeductible?version=%@&token=%@",[NSObject baseURLStr],VERSION,[[NSUserDefaults standardUserDefaults] objectForKey:USER_TOKEN]];
    NSString *URL=[MyMD5 authkey:url];
    [manager POST:URL parameters:paraments success:^(AFHTTPRequestOperation *operation, id responseObject) {
        responseObject = [NSDictionary changeType:responseObject];
        if ([responseObject[@"status"] intValue] == 1) {
            self.reduceMoney = [responseObject[@"one_not_use_price"] floatValue];
            self.shop_deduction = responseObject[@"shop_deduction"];
        }else{
            self.reduceMoney = 0;
            self.shop_deduction = @"0.9";
        }
        
        self.isDownRefresh = YES;
        self.currPage = 1;
        [self httpGetData];
        
        if (self.customDelegate!=nil && [self.customDelegate respondsToSelector:@selector(collectionViewPullDownRefreshWithIndex:)]) {
            [self.customDelegate collectionViewPullDownRefreshWithIndex:currIndex];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self.collectionView ffRefreshHeaderEndRefreshing];
        [self.collectionView footerEndRefreshing];
    }];
}

- (NSMutableArray *)collectionDataArr
{
    if (_collectionDataArr == nil) {
        _collectionDataArr = [[NSMutableArray alloc] init];
    }
    return _collectionDataArr;
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

- (TFCollectionViewService *)service
{
    if (!_service) {
        _service = [[TFCollectionViewService alloc] init];
    }
    return _service;
}

- (void)dealloc
{
    if (self.collectionView.topShowView) {
        [self.collectionView removeObserver:self.collectionView forKeyPath:observerRefreshHeaderViewKeyPath context:nil];
        _collectionView = nil;
    }
    
    if (self.netStatusBlock) {
        [[NSNotificationCenter defaultCenter] removeObserver:self name:netStatusNotificationCenter object:nil];
    }
    
}


@end
