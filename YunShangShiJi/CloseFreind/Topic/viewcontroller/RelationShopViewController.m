//
//  RelationShopViewController.m
//  YunShangShiJi
//
//  Created by ios-1 on 2017/5/19.
//  Copyright © 2017年 ios-1. All rights reserved.
//

#import "RelationShopViewController.h"
#import "XRWaterfallLayout.h"
#import "MBProgressHUD.h"
#import "MBProgressHUD+NJ.h"
#import "HotTopicCollectionViewCell.h"
#import "TopicDetailViewController.h"
#import "TFShoppingViewController.h"
#import "WaterFlowCell.h"
#import "GlobalTool.h"
#import "ShareModel.h"
#import "TFWaterFLayout.h"

#import "TFShoppingVM.h"
#import "NavgationbarView.h"
#import "TopicPublicModel.h"
#import "ShopDetailViewController.h"
#import "TaskSignModel.h"
#import "AppDelegate.h"
#import "QRCodeGenerator.h"
#import "ProduceImage.h"
#import "NoMentionView.h"

#define SHAREVIEWHEIGH ZOOM6(250)

@interface RelationShopViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,XRWaterfallLayoutDelegate>
@property (nonatomic , assign)int currPage;
@property (nonatomic , assign)int currPage2;

@property (nonatomic, strong) TFShoppingVM *viewModel;
@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic,strong) NSMutableArray *dataArray2;
@property (nonatomic , strong) DShareManager *shareManager;

@end

@implementation RelationShopViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = RGBCOLOR_I(239, 239, 239);
    [self creatHeadView];
    [self creatsegment];
    [self creatCollectionView];
    [self.view addSubview:self.shareView];
    
    self.currPage=1;self.currPage2=1;
    [self httpGetData];
    [self httpTheme];
    
    kSelfWeak;
    [self loadFailBtnBlock:^{

        if (weakSelf.selectShareType) {
            weakSelf.currPage2=1;
            [weakSelf httpTheme];
           
        }else{
            
            weakSelf.currPage=1;
            [weakSelf httpGetData];
        }
    }];
}
- (TFShoppingVM *)viewModel
{
    if (!_viewModel) {
        _viewModel = [[TFShoppingVM alloc] init];
        _viewModel.typeID = [NSNumber numberWithInteger:6];
        _viewModel.typeName = @"热卖";
    }
    return _viewModel;
}
- (NSMutableArray *)dataArray {
    if (nil == _dataArray) {
        _dataArray=[NSMutableArray array];
    }
    return _dataArray;
}
- (NSMutableArray *)dataArray2 {
    if (nil == _dataArray2) {
        _dataArray2=[NSMutableArray array];
    }
    return _dataArray2;
}
#pragma mark - *********************网络数据********************
//我的最爱
- (void)httpTheme {
    
    kSelfWeak;
    [self.viewModel handleDataWithFromType:@"我的最爱" pageNum:self.currPage2 Success:^(NSArray *modelArray, Response *response) {
        
        if (response.status == 1) {
            if (weakSelf.currPage2 == 1) {
                [weakSelf.dataArray2 removeAllObjects];
            }
            
            if(modelArray.count)
            {
                [weakSelf.dataArray2 addObjectsFromArray:modelArray];
                [weakSelf.collectionView reloadData];
                if(weakSelf.selectShareType == 1){
                    [weakSelf loadingDataSuccess];
                }
            }else{
                if(weakSelf.dataArray2.count)
                {
                    [weakSelf.collectionView reloadData];
                }else{
                    if(weakSelf.selectShareType == 1){
                        [weakSelf LoadnomentionView:@"topic_icon_no-like" Content:@"你还木有喜欢的商品哦~"];
                    }
                }
            }

        }else{
            if(weakSelf.selectShareType == 1){
                [weakSelf LoadnomentionView:@"topic_icon_no-like" Content:@"你还木有喜欢的商品哦~"];
            }
        }
        
    } failure:^(NSError *error) {
        
        if(weakSelf.selectShareType == 1){
            [weakSelf LoadnomentionView:@"topic_icon_no-like" Content:@"你还木有喜欢的商品哦~"];
        }
    }];

}

//已购买的
- (void)httpGetData
{
    kSelfWeak;
    [self.viewModel handleDataWithFromType:@"我的购买" pageNum:self.currPage Success:^(NSArray *modelArray, Response *response) {
        
        if (response.status == 1) {
            
            if (weakSelf.currPage == 1) {
                [weakSelf.dataArray removeAllObjects];
            }
            
            if(modelArray.count)
            {
                [weakSelf.dataArray addObjectsFromArray:modelArray];
                [weakSelf.collectionView reloadData];
                if(weakSelf.selectShareType == 0){
                    [weakSelf loadingDataSuccess];
                }
            }else{
                if(weakSelf.dataArray.count)
                {
                    [weakSelf.collectionView reloadData];
                }else{
                    
                    if(weakSelf.selectShareType == 0){
                        [weakSelf LoadnomentionView:@"topic_icon_no-buy" Content:@"你还木有购买过商品哦~"];
                    }
                }
            }

        }else{
           
            if(weakSelf.selectShareType == 0){
                [weakSelf LoadnomentionView:@"topic_icon_no-buy" Content:@"你还木有购买过商品哦~"];
            }
        }
        
    } failure:^(NSError *error) {
       
        if(weakSelf.selectShareType == 0){
            [weakSelf LoadnomentionView:@"topic_icon_no-buy" Content:@"你还木有购买过商品哦~"];
        }

    }];
}

//获取商品链接请求
- (void)shopRequestShopcode:(NSString*)shopcode Success:(void(^)(NSString *shopcode))success
{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *paraments=[NSMutableDictionary dictionary];
    NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
    NSString *realm = [user objectForKey:USER_ID];
    NSString *token = [user objectForKey:USER_TOKEN];
    
    NSString *url=[NSString stringWithFormat:@"%@shop/getShopLink?version=%@&shop_code=%@&realm=%@&token=%@&share=%@&getShopMessage=true",[NSObject baseURLStr],VERSION,shopcode,realm,token,@"2"];
    
    NSString *URL=[MyMD5 authkey:url];
    
    [manager POST:URL parameters:paraments success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if (responseObject!=nil || ![responseObject isEqual:[NSNull null]]) {
            NSString *str=responseObject[@"status"];
            if(str.intValue==1) {
                
                NSString *Shopurl=responseObject[@"link"];
                if(Shopurl)
                {
                    if(success)
                    {
                        success(Shopurl);
                    }
                }
            }else{
                [MBProgressHUD hideHUDForView:self.view];
                NavgationbarView *mentionview=[[NavgationbarView alloc]init];
                [mentionview showLable:@"网络异常，请稍后重试" Controller:self];
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MBProgressHUD hideHUDForView:self.view];
        [[Animation shareAnimation] stopAnimationAt:self.view];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
}

- (void)creatsegment
{
    self.segment=[[UISegmentedControl alloc]initWithItems:@[@"已购买的",@"我的最爱"]];
    self.segment.frame=CGRectMake((kApplicationWidth-ZOOM6(320))/2,(44-ZOOM6(60))/2+20, ZOOM6(320), ZOOM6(60));
    self.segment.selectedSegmentIndex = self.selectShareType;
    [self.segment setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                          [UIFont systemFontOfSize:ZOOM6(28)],NSFontAttributeName,nil] forState:UIControlStateNormal];
    [self.segment setTintColor:tarbarrossred];
    [self.segment addTarget:self action:@selector(segmentChange:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:self.segment];
    
}
//导航条
- (void)creatHeadView
{
    self.tabheadview=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kApplicationWidth, Height_NavBar)];
    [self.view addSubview:self.tabheadview];
    self.tabheadview.userInteractionEnabled=YES;
    
    UIButton *backbtn=[UIButton buttonWithType:UIButtonTypeCustom];
    backbtn.frame=CGRectMake(0, 20, 44, 44);
    backbtn.centerY = View_CenterY(self.tabheadview);
    [backbtn setImage:[UIImage imageNamed:@"返回按钮_正常"] forState:UIControlStateNormal];
    [backbtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [self.tabheadview addSubview:backbtn];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, Height_NavBar-1, kScreenWidth, 1)];
    lineView.backgroundColor = RGBCOLOR_I(220,220,220);
    [self.view addSubview:lineView];
}

- (void)creatCollectionView
{
    //创建瀑布流布局
    XRWaterfallLayout *waterfall = [[XRWaterfallLayout alloc]init];
    //设置各属性的值
    //    waterfall.rowSpacing = 10;
    //    waterfall.columnSpacing = 10;
    //    waterfall.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    
    //或者一次性设置
    [waterfall setColumnSpacing:5 rowSpacing:0 sectionInset:UIEdgeInsetsMake(0, 5, 0, 5)];
    //设置代理，实现代理方法
    waterfall.delegate = self;
    
    //创建collectionView
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, Height_NavBar, kScreenWidth, kScreenHeight-Height_NavBar) collectionViewLayout:waterfall];
    self.collectionView.backgroundColor = RGBCOLOR_I(239, 239, 239);
    [self.collectionView registerNib:[UINib nibWithNibName:@"HotTopicCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"HotCell"];
    [self.collectionView registerNib:[UINib nibWithNibName:@"WaterFlowCell" bundle:nil] forCellWithReuseIdentifier:@"WATERFLOWCELLID"];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    [self.view addSubview:self.collectionView];
    
    kSelfWeak;
    [_collectionView addHeaderWithCallback:^{

        [weakSelf.collectionView headerEndRefreshing];
        if (weakSelf.selectShareType) {
            weakSelf.currPage2=1;
            [weakSelf httpTheme];
        }else{
            weakSelf.currPage=1;
            [weakSelf httpGetData];
        }
    }];
    
    [_collectionView addFooterWithCallback:^{
        [weakSelf.collectionView footerEndRefreshing];
        if (weakSelf.selectShareType) {
            weakSelf.currPage2++;
            [weakSelf httpTheme];
        }else{
//            weakSelf.currPage++;
//            [weakSelf httpGetData];
        }
    }];
}

#pragma mark *****************XRWaterfallLayoutDelegate**********
//根据item的宽度与indexPath计算每一个item的高度
- (CGFloat)waterfallLayout:(XRWaterfallLayout *)waterfallLayout itemHeightForWidth:(CGFloat)itemWidth atIndexPath:(NSIndexPath *)indexPath
{
    CGFloat imgH = 900;
    CGFloat imgW = 600;
    
    CGFloat W = (kScreenWidth-18)/2.0;
    CGFloat H = imgH*W/imgW;
    
    return  H+5;
}

#pragma mark *****************UIcollectionViewDelegate**********
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.selectShareType == 0 ? self.dataArray.count : self.dataArray2.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    WaterFlowCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"WATERFLOWCELLID" forIndexPath:indexPath];
    cell.selectBtn.hidden = YES;
    NSMutableArray *dataArray = [NSMutableArray array];
    if(self.selectShareType == 0)
    {
        dataArray = self.dataArray;
    }else{
        dataArray = self.dataArray2;
    }
    if(dataArray.count>indexPath.item){
        TFShoppingM *model=dataArray[indexPath.item];
        self.selectShareType == 1?model.def_pic=model.show_pic:nil;
        [cell receiveDataModel2:model];
    }
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSMutableArray *dataArray = [NSMutableArray array];
    if(self.selectShareType == 0)
    {
        dataArray = self.dataArray;
    }else{
        dataArray = self.dataArray2;
    }

    TFShoppingM *model=dataArray[indexPath.item];

    ESWeakSelf;
    [self shopRequestShopcode:model.shop_code Success:^(NSString *shopurl) {
        
        if(__weakSelf.selectShopBlock)
        {
            __weakSelf.selectShopBlock(model.supp_label,model.supp_label_id,model.shop_code);
        }
        UIViewController *vc=(UIViewController *)self.navigationController.viewControllers[self.navigationController.viewControllers.count-2];
        if ([vc isKindOfClass:NSClassFromString(@"BrandAndStyleChoseVC")]) {
            [__weakSelf.navigationController popToViewController:self.navigationController.viewControllers[self.navigationController.viewControllers.count-3] animated:YES];
        }
    }];
}

#pragma mark - 事件点击 segmentChange
-(void)segmentChange:(UISegmentedControl *)sender
{
    switch (self.segment.selectedSegmentIndex) {
        case 0:
            self.selectShareType = 0;
            break;
        case 1:
            self.selectShareType = 1;
            break;
        default:
            break;
    }
    
    //滑动到最底部
    [self.collectionView setContentOffset:CGPointMake(0, 0)];
    self.selectShareType = sender.selectedSegmentIndex;
    
    if(self.selectShareType == 0)
    {
        if(self.dataArray.count == 0)
        {
            [self loadingDataSuccess];
            [self LoadnomentionView:@"topic_icon_no-buy" Content:@"你还木有购买过商品哦~"];
        }else{
            [self loadingDataSuccess];
        }
    }
    else if(self.selectShareType == 1)
    {
        if(self.dataArray2.count == 0)
        {
            [self loadingDataSuccess];
            [self LoadnomentionView:@"topic_icon_no-like" Content:@"你还木有喜欢的商品哦~"];
        }else{
            [self loadingDataSuccess];
        }
    }

    [self.collectionView reloadData];
}

- (void)LoadnomentionView:(NSString*)image Content:(NSString*)content
{
    if(_nomentionView == nil)
    {
        self.nomentionView = [[NoMentionView alloc]initWithFrame:self.collectionView.bounds Image:image Content:content];
        [self.collectionView addSubview:self.nomentionView];
    }
}
- (void)loadingDataSuccess
{
    [self.nomentionView removeFromSuperview];
    self.nomentionView = nil;
}
- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)dealloc {
    
    MyLog(@"%@ release",[self class]);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
