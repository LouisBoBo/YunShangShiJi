//
//  NewSpecialViewController.m
//  YunShangShiJi
//
//  Created by hebo on 2018/7/16.
//  Copyright © 2018年 ios-1. All rights reserved.
//

#import "NewSpecialViewController.h"
#import "TFShoppingViewController.h"
#import "ShopDetailViewController.h"
#import "XRWaterfallLayout.h"
#import "WaterFlowCell.h"
#import "TFWaterFLayout.h"
#import "TopicPublicModel.h"
#import "TShoplistModel.h"
#import "TFShoppingVM.h"
#import "TFShoppingM.h"
#import "GlobalTool.h"
@interface NewSpecialViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,XRWaterfallLayoutDelegate>
@property (nonatomic , strong) TFShoppingVM *viewModel;
@end

@implementation NewSpecialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self creatHeadView];
    [self creatCollectionView];
    
    self.curpage = 1;
    [self creatData];
}
- (void)creatHeadView
{
    //导航条
    self.tabheadview=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kApplicationWidth, Height_NavBar)];
    [self.view addSubview:self.tabheadview];
    self.tabheadview.userInteractionEnabled=YES;
    
    UIButton *backbtn=[UIButton buttonWithType:UIButtonTypeCustom];
    backbtn.frame=CGRectMake(0, 20, 44, 44);
    backbtn.centerY = View_CenterY(self.tabheadview);
    [backbtn setImage:[UIImage imageNamed:@"返回按钮_正常"] forState:UIControlStateNormal];
    [backbtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [self.tabheadview addSubview:backbtn];
    
    UILabel *titlelable=[[UILabel alloc]init];
    titlelable.frame=CGRectMake(0, 0, 300, 40);
    titlelable.center=CGPointMake(kApplicationWidth/2, self.tabheadview.frame.size.height/2+10);
    titlelable.text=@"特价商品";
    titlelable.font=kNavTitleFontSize;
    titlelable.textColor=kMainTitleColor;
    titlelable.textAlignment=NSTextAlignmentCenter;
    [self.tabheadview addSubview:titlelable];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, Height_NavBar-1, kScreenWidth, 1)];
    lineView.backgroundColor = RGBCOLOR_I(220,220,220);
    [self.view addSubview:lineView];
    
}

- (void)creatData
{
    kSelfWeak;
    [self.viewModel handleDataWithFromType:@"生活" pageNum:self.curpage Success:^(NSArray *modelArray, Response *response) {
        
        [weakSelf.collectionView headerEndRefreshing];
        [weakSelf.collectionView footerEndRefreshing];
        if (response.status == 1) {
            
            if (weakSelf.curpage == 1) {
                [weakSelf.shop_list removeAllObjects];
            }
            
            [weakSelf.shop_list addObjectsFromArray:modelArray];
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf.collectionView reloadData];
            });
        }
        
    } failure:^(NSError *error) {
        [self.collectionView ffRefreshHeaderEndRefreshing];
        [self.collectionView footerEndRefreshing];
    }];
}
- (void)creatCollectionView
{
    //创建瀑布流布局
    XRWaterfallLayout *waterfall = [XRWaterfallLayout waterFallLayoutWithColumnCount:2];
    
    //设置各属性的值
    //    waterfall.rowSpacing = 10;
    //    waterfall.columnSpacing = 10;
    //    waterfall.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    
    //或者一次性设置
    [waterfall setColumnSpacing:5 rowSpacing:0 sectionInset:UIEdgeInsetsMake(0, 5, 0, 5)];
    
    
    //设置代理，实现代理方法
    waterfall.delegate = self;
    /*
     //或者设置block
     [waterfall setItemHeightBlock:^CGFloat(CGFloat itemWidth, NSIndexPath *indexPath) {
     //根据图片的原始尺寸，及显示宽度，等比例缩放来计算显示高度
     XRImage *image = self.images[indexPath.item];
     return image.imageH / image.imageW * itemWidth;
     }];
     */
    //创建collectionView
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, Height_NavBar, kScreenWidth, kScreenHeight-Height_NavBar) collectionViewLayout:waterfall];
    self.collectionView.backgroundColor = RGBCOLOR_I(239, 239, 239);
    [self.collectionView registerNib:[UINib nibWithNibName:@"WaterFlowCell" bundle:nil] forCellWithReuseIdentifier:@"WATERFLOWCELLID"];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    [self.view addSubview:self.collectionView];
    
    //下拉刷新
    __weak NewSpecialViewController *myController = self;
    [self.collectionView addHeaderWithCallback:^{
        
        myController.curpage = 1;
        [myController creatData];
    }];
    
    //上拉加载
    [self.collectionView addFooterWithCallback:^{
        myController.curpage ++;
        [myController creatData];
    }];
    
}

//根据item的宽度与indexPath计算每一个item的高度
- (CGFloat)waterfallLayout:(XRWaterfallLayout *)waterfallLayout itemHeightForWidth:(CGFloat)itemWidth atIndexPath:(NSIndexPath *)indexPath
{
    CGFloat imgH = 900;
    CGFloat imgW = 600;
    
    CGFloat W = (kScreenWidth-5)/2.0;
    CGFloat H = imgH*W/imgW;
    
    return  H+5;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.shop_list.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    WaterFlowCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"WATERFLOWCELLID" forIndexPath:indexPath];
    TFShoppingM *model = self.shop_list[indexPath.item];
    [cell receiveDataModel8:model];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    TFShoppingM *model = self.shop_list[indexPath.item];
    ShopDetailViewController *shopdetail = [[ShopDetailViewController alloc]init];
    shopdetail.shop_code = model.shop_code;
    shopdetail.stringtype = @"订单详情";
    [self.navigationController pushViewController:shopdetail animated:YES];
}

- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (NSMutableArray*)shop_list
{
    if(_shop_list == nil)
    {
        _shop_list = [NSMutableArray array];
    }
    
    return _shop_list;
}

- (TFShoppingVM *)viewModel
{
    if (!_viewModel) {
        _viewModel = [[TFShoppingVM alloc] init];
    }
    return _viewModel;
}
@end
