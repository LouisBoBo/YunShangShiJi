//
//  TFMemberShopStoreViewController.m
//  YunShangShiJi
//
//  Created by 云商 on 16/2/26.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import "TFMemberShopStoreViewController.h"

//#import "ComboShopDetailViewController.h"

#import "WaterFLayout.h"
#import "WaterFallHeader.h"
#import "MemberWaterFlowCell.h"

#import "TFShopModel.h"
#import "ScrollView_public.h"

@interface TFMemberShopStoreViewController () <UICollectionViewDataSource, UICollectionViewDelegate>

{
    CGFloat H_headView;
    CGFloat H_bigImageView;
    
    ScrollView_public *_ScrollView_public;
}

@property (nonatomic, strong)NSIndexPath *headViewIndexPath;

@property (nonatomic, assign)NSInteger page;

@property (nonatomic, strong)UICollectionView *collectionView;
@property (nonatomic, strong)NSMutableArray *collectionDataArr;
@property (nonatomic, strong)UICollectionReusableView *headView;

@property (nonatomic, strong)NSMutableArray *lideImageMuArr;
@property (nonatomic, strong)NSMutableArray *lideImageUrlMuArr;

@end

@implementation TFMemberShopStoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavigationItemLeft:@"会员商品"];
    
    [self dataInit];
    
    [self createUI];
    
    [self httpsLideImageRequest];
    
    [self httpGetMemberShops];

}

- (void)dataInit
{
    
    CGFloat H_headImg = kScreenWidth*0.5;
    
    H_bigImageView = H_headImg;
    
    H_headView = H_bigImageView+ZOOM(20);
    
    self.page = 1;
    
}

- (void)createUI
{
    WaterFLayout *flowLayout=[[WaterFLayout alloc] init];
    
//    flowLayout.sectionInset = UIEdgeInsetsMake(0, 6, 0, 6);
    flowLayout.minimumColumnSpacing = 2;
    flowLayout.minimumInteritemSpacing = 2;
    
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, Height_NavBar, kScreenWidth, kScreenHeight-Height_NavBar) collectionViewLayout:flowLayout];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    //    self.collectionView.bounces = YES;
    self.collectionView.pagingEnabled = NO;
    self.collectionView.showsVerticalScrollIndicator = NO;
    
    [self.collectionView registerClass:[WaterFallHeader class]  forSupplementaryViewOfKind:WaterFallSectionHeader withReuseIdentifier:@"WaterFallSectionHeader"];
    
    [self.collectionView registerClass:[MemberWaterFlowCell class] forCellWithReuseIdentifier:@"MEMBERCELLID"];
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"MemberWaterFlowCell" bundle:nil] forCellWithReuseIdentifier:@"MEMBERCELLID"];
    
    [self.view addSubview:self.collectionView];
    
    __weak TFMemberShopStoreViewController *tssVC = self;
    [self.collectionView addHeaderWithCallback:^{
        tssVC.page = 1;
        [tssVC httpGetMemberShops];     //商品列表
        [tssVC httpsLideImageRequest];  //轮播图
    }];
    
    [self.collectionView addFooterWithCallback:^{
        tssVC.page++;
        [tssVC httpGetMemberShops];
    }];

}
#pragma mark - ++++++++++++++++++网络请求++++++++++++++++++

#pragma mark - 轮播图
- (void)httpsLideImageRequest
{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *paraments=[NSMutableDictionary dictionary];
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *token = [ud objectForKey:USER_TOKEN];
    
    NSString *urlStr = [NSString stringWithFormat:@"%@vip/queryOption?version=%@&token=%@",[NSObject baseURLStr], VERSION, token];
    
    NSString *URL=[MyMD5 authkey:urlStr];
    
    [manager POST:URL parameters:paraments success:^(AFHTTPRequestOperation *operation, id responseObject) {
        responseObject = [NSDictionary changeType:responseObject];
        NSString *status=responseObject[@"status"];
        
        //轮播图: %@",responseObject);
        
        if(status.intValue==1) {
            
            
            if (responseObject[@"topShops"]!=nil) {
                
                NSArray *topShopsArr = responseObject[@"topShops"];
                
                [self.lideImageMuArr removeAllObjects];
                [self.lideImageUrlMuArr removeAllObjects];
                
                for (NSDictionary *dic in topShopsArr) {
                    TFShopModel *sModel = [[TFShopModel alloc] init];
                    sModel.ID = dic[@"id"];
                    [sModel setValuesForKeysWithDictionary:dic];
                    
                     NSString *imgUrlStr = [NSString stringWithFormat:@"%@%@!560",[NSObject baseURLStr_Upy],sModel.url];
                    
                    [self.lideImageMuArr addObject:sModel];
                    [self.lideImageUrlMuArr addObject:imgUrlStr];
                }
                
                if (self.lideImageMuArr.count) {
                    [self refreshLideImage];
                }
            }
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        
    }];
    
}
- (void)refreshLideImage
{
    __weak TFMemberShopStoreViewController *tp = self;
    for (UIView *view in _ScrollView_public.subviews) {
        [view removeFromSuperview];
    }

    CGRect rect = CGRectMake(0, 0, kScreenWidth, H_bigImageView);
        
    //添加轮播图
    _ScrollView_public = [[ScrollView_public alloc]initWithFrame:rect pictures:self.lideImageUrlMuArr animationDuration:5 contentMode_style:Fill_contentModestyle Haveshiping:NO];
    [self.headView addSubview:_ScrollView_public];
    _ScrollView_public.scrollview.scrollsToTop = NO;
    __weak TFMemberShopStoreViewController *tmVC = self;
    _ScrollView_public.getTapClickPage = ^(NSInteger page){
        
        //点击 %d",(int) page);
        TFShopModel *sModel = (TFShopModel *)tp.lideImageMuArr[page];
        
//        ComboShopDetailViewController *detail=[[ComboShopDetailViewController alloc] initWithNibName:@"ComboShopDetailViewController" bundle:nil];
//            detail.shop_code = sModel.shop_code;
//            detail.detailType = @"会员商品";
//            detail.hidesBottomBarWhenPushed=YES;
//            [tmVC.navigationController pushViewController:detail animated:YES];
    
    };
    
    [self.collectionView reloadData];
}

#pragma mark - 会员商品列表
- (void)httpGetMemberShops
{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *paraments=[NSMutableDictionary dictionary];
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *token = [ud objectForKey:USER_TOKEN];
    
    NSString *urlStr = [NSString stringWithFormat:@"%@vip/queryShopList?version=%@&token=%@&pager.curPage=%d&pager.pageSize=%@",[NSObject baseURLStr], VERSION, token, (int)self.page, @"10"];
    
    NSString *URL=[MyMD5 authkey:urlStr];
    
    [manager POST:URL parameters:paraments success:^(AFHTTPRequestOperation *operation, id responseObject) {
        responseObject = [NSDictionary changeType:responseObject];
        [self.collectionView headerEndRefreshing];
        [self.collectionView footerEndRefreshing];
        
        NSString *status=responseObject[@"status"];
        
//        //会员商品列表: %@",responseObject);
        
        if(status.intValue==1) {
            
            if (responseObject[@"data"]!=nil) {
                
                NSArray *dataArr = responseObject[@"data"];
                
                if (self.page == 1) {
                    [self.collectionDataArr removeAllObjects];
                }
                
                for (NSDictionary *dic in dataArr) {
                    TFShopModel *sModel = [[TFShopModel alloc] init];
                    [sModel setValuesForKeysWithDictionary:dic];
                    
                    [self.collectionDataArr addObject:sModel];
                }
                
                [self.collectionView reloadData];
            }
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [self.collectionView headerEndRefreshing];
        [self.collectionView footerEndRefreshing];
    }];

}

#pragma mark - collectionView代理方法

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    CGSize size = {kScreenWidth,H_headView};
    return size;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout heightForHeaderInSection:(NSInteger)section
{
    if (self.lideImageMuArr.count!=0) {
        return H_headView;
    }
    return 1;
}


- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    
    UICollectionReusableView *header;
    if ([kind isEqualToString:WaterFallSectionHeader]) {
        header = [collectionView dequeueReusableSupplementaryViewOfKind:kind
                                                    withReuseIdentifier:@"WaterFallSectionHeader"
                                                           forIndexPath:indexPath];
        self.headViewIndexPath = indexPath;
        /**
         * 轮播图的scrollView
         */
        NSArray *subViews = self.headView.subviews;
        self.headView = nil;
        
        int j = 0;
        
        for (int i =0; i<subViews.count; i++) {
            UIView *view = subViews[i];
            if (view == _ScrollView_public) {
                j++;
            }
        }
        
        //j = %d", j);
        
        if (j == 0) {
            

        }
        
        header.backgroundColor = RGBCOLOR_I(244,244,244);
        
        return self.headView = header;
    }
    
    return 0;
}

//大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    CGFloat H = 3*(kScreenWidth)*0.5*0.5;
    CGSize size = CGSizeMake(kScreenWidth/2.0, H);
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
    
    MemberWaterFlowCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MEMBERCELLID" forIndexPath:indexPath];
    
    if (self.collectionDataArr.count>indexPath.item) {
        
//        cell.contentView.backgroundColor = COLOR_RANDOM;
        
        TFShopModel *sModel = self.collectionDataArr[indexPath.item];
        [cell receiveDataModel:sModel];
    }
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    //点击");
    
    TFShopModel *sModel=self.collectionDataArr[indexPath.item];
//    ComboShopDetailViewController *detail=[[ComboShopDetailViewController alloc] initWithNibName:@"ComboShopDetailViewController" bundle:nil];
//    detail.shop_code = sModel.shop_code;
//    detail.detailType = @"会员商品";
//    detail.hidesBottomBarWhenPushed=YES;
//    [self.navigationController pushViewController:detail animated:YES];
}


#pragma mark - 懒加载
- (NSMutableArray *)collectionDataArr
{
    if (_collectionDataArr == nil) {
        _collectionDataArr = [[NSMutableArray alloc] init];
    }
    
    return _collectionDataArr;
}

#pragma mark - 懒加载
- (NSMutableArray *)lideImageMuArr
{
    if (_lideImageMuArr == nil) {
        _lideImageMuArr = [[NSMutableArray alloc] init];
    }
    return _lideImageMuArr;
}

- (NSMutableArray *)lideImageUrlMuArr
{
    if (_lideImageUrlMuArr == nil) {
        _lideImageUrlMuArr = [[NSMutableArray alloc] init];
    }
    return _lideImageUrlMuArr;
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
