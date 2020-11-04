//
//  NewShoppingCartViewController.m
//  FJWaterfallFlow
//
//  Created by ios-1 on 2017/1/16.
//  Copyright © 2017年 fujin. All rights reserved.
//

#import "NewShoppingCartViewController.h"
#import "CollectionHeaderView.h"
#import "CartNoEditCollectionViewCell.h"
#import "InvalidCollectionViewCell.h"
#import "TFShoppingViewController.h"
#import "OrderTableViewController.h"
#import "ShopDetailViewController.h"
#import "SubmitTopicViewController.h"
#import "WaterFlowCell.h"
#import "GoShopView.h"
#import "GlobalTool.h"
#import "ChangeShopPopview.h"
#import "VitalityTaskPopview.h"
#import "RecommendRemindView.h"
#import "LuckdrawViewController.h"

#import "ShopCarManager.h"
#import "ShopDetailModel.h"
#import "YFShareModel.h"
#import "CartViewModel.h"
#import "LikeModel.h"
#import "CartLikeModel.h"

#import "MBProgressHUD.h"
#import "MBProgressHUD+NJ.h"
#import "MBProgressHUD+XJ.h"
#import "NavgationbarView.h"
#import "BindingManager.h"
#import "TFShoppingVM.h"
@interface NewShoppingCartViewController ()
@property (nonatomic, strong) TFShoppingVM *viewModel;
@property (nonatomic, assign) CGFloat reduceMoney;
@property (nonatomic, copy)   NSString * shop_deduction;
@property (nonatomic, strong) NSNumber *isVip;
@property (nonatomic, strong) NSNumber *maxType;
@end

@implementation NewShoppingCartViewController
{
    UILabel *_titlelable;          //导航条title
    UIView *_FootView;             //底部全选视图
    UIButton *allselectbtn;        //全选按钮
    UIButton *_allpaybtn;          //结算
    UIView *_delateBackview;       //底视图
    UIButton *_delateAllbtn;       //删除所有按钮
    UIButton *_addLikebtn;         //加入喜欢按钮
    UILabel *_allmoneylable;
    UILabel *_lable;
    UIButton *_collectbtn;
    UIButton *_delectbtn;
    UILabel *payTimeLabel;

    ChangeShopPopview *shopPopview;//更改商品信息视图
    NSInteger _shopnumber;         //结算商品数量
    CGFloat _totalMoney;           //结算商品总价

    BOOL _select;                  //全选按钮是否选中
    BOOL _editall;                 //编辑全部按钮是否选中
    
    int _shop_num;                 //商品数量
    
    ShopCarModel *_shopCarModel;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    self.navigationController.navigationBar.hidden=YES;

    [self creatNavagationView];
    [self creatCollectionView];
    [self creatFootview];


}
/**
 获取当天还有多少次抽奖机会
 */
- (void)httpGetRedMoneyLeastNum {
    kSelfWeak;
    [[APIClient sharedManager]netWorkGeneralRequestWithApi:@"order/getOrderRaffleNum?" caches:NO cachesTimeInterval:0 token:YES success:^(id data, Response *response) {
        if (response.status == 1) {
            [[NSUserDefaults standardUserDefaults]setObject:data[@"data"] forKey:@"RedMoneyLeastNum"];
            [[NSUserDefaults standardUserDefaults]setObject:data[@"n"] forKey:@"RedMoneyAllNum"];
            [[NSUserDefaults standardUserDefaults]setObject:[NSString stringWithFormat:@"%@",data[@"money"]] forKey:@"RedMoneyRaward"];
            
            if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"RedMoneyLeastNum"] integerValue]!=-1)
            {
//                [weakSelf creatRedMoneyAlertView];
            }else{
                
                [self.redMoneybtn removeFromSuperview];
            }

        }
    } failure:^(NSError *error) {

    }];
}
- (void)creatRedMoneyAlertView {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:@"余额抽奖红包"] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"余额抽奖红包"] forState:UIControlStateNormal|UIControlStateHighlighted];
    [btn addTarget:self action:@selector(redViewClick) forControlEvents:UIControlEventTouchUpInside];
    btn.frame = CGRectMake(kScreenWidth-ZOOM6(168)-ZOOM6(20), 200, ZOOM6(168), ZOOM6(178));
//    [self.view addSubview:self.redMoneybtn = btn];
//    [self.view bringSubviewToFront:btn];
    
    kWeakSelf(self);
    [[DataManager sharedManager] taskListHttp:26 Success:^{
        
        [weakself.view addSubview:self.redMoneybtn = btn];
        [weakself.view bringSubviewToFront:btn];
    }];

}
- (void)redViewClick {
    
    kWeakSelf(self);
    
    [[BindingManager BindingManarer] checkPhoneAndUnionID:YES Success:^{
        
        [weakself gotoLuck];
    }];
    [BindingManager BindingManarer].BindingSuccessBlock = ^{
        [weakself gotoLuck];
    };
}
- (void)gotoLuck
{
    LuckdrawViewController *vc = [[LuckdrawViewController alloc]init];
    vc.is_OrderRedLuck = [[[NSUserDefaults standardUserDefaults]objectForKey:@"RedMoneyLeastNum"] integerValue] ? YES : NO;
    vc.is_comefromeRed = YES;
    if (self.ShopCart_Type == ShopCart_TarbarType) {
        vc.hidesBottomBarWhenPushed = YES;
    }
    
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)viewWillAppear:(BOOL)animated
{
    allselectbtn.selected = NO;
    payTimeLabel.backgroundColor = RGBCOLOR_I(197, 197, 197);
    _delateAllbtn.backgroundColor = RGBCOLOR_I(197, 197, 197);
    
//    [self creatData];
    [self checkShopList];
    
    [self creatLikeData];
//    if(!self.likeArray.count)
//    {
//        self.currPage = 1;
//        [self creatLikeData:self.currPage];
//    }
    
    if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"RedMoneyLeastNum"] integerValue]!=-1) {
        [self httpGetRedMoneyLeastNum];
    }
    
}
- (void)creatLikeData
{
    kSelfWeak;
    [self.viewModel netWorkGetBrowsePageListWithReduceMoneySuccess:^(NSDictionary *data, Response *response) {
        if(response.status == 1)
        {
            weakSelf.reduceMoney = [data[@"one_not_use_price"] floatValue];
            weakSelf.shop_deduction = data[@"shop_deduction"];
        }
        
        weakSelf.currPage = 1;
        [weakSelf creatLikeData:weakSelf.currPage];
    } failure:^(NSError *error) {
        
    }];
}
- (void)viewDidAppear:(BOOL)animated
{
    [TFStatisticsClickVM StatisticshandleDataWithClickType:@"到达购物车" success:nil failure:nil];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [TFStatisticsClickVM StatisticshandleDataWithClickType:@"跳出购物车" success:nil failure:nil];
}
- (void)creatData
{
    self.viewmodel = [[ShoppingCartViewModel alloc] init];
    [self.viewmodel getData:^{
        [self getShopCount];
        _FootView.hidden = NO;
        self.editButtonn.userInteractionEnabled=self.viewmodel.dataArray.count>0?YES:NO;
        CGFloat Heigh = self.ShopCart_Type==ShopCart_TarbarType?49:0;
        self.MycollectionView.frame =CGRectMake(0, Height_NavBar, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)-Height_NavBar-50-Heigh);
        [self.MycollectionView reloadData];
    } Fail:^{
        
        self.editButtonn.userInteractionEnabled = NO;
        _titlelable.text = @"购物车";
    }];
}
//获取购物车商品数量
- (void)getShopCount
{
    int shopcount = 0;
    for (int i=0; i<self.viewmodel.dataArray.count; i++) {
        ShopDetailModel *model = self.viewmodel.dataArray[i];
        shopcount += model.shop_num.intValue;
    }
    _titlelable.text = [NSString stringWithFormat:@"购物车(%d)",shopcount];
}
- (void)creatLikeData:(NSInteger)page
{
    [CartLikeModel getLikeDataSuccess:page Success:^(id data) {
        CartLikeModel *model = data;
        if(model.status == 1)
        {
            if(self.currPage == 1)
            {
                [self.likeArray removeAllObjects];
            }
            self.currPage ++;
            
            self.isVip = model.isVip;
            self.maxType = model.maxType;
            [self.likeArray addObjectsFromArray:model.likeArray];
            [self.MycollectionView reloadData];
        }
    }];

    [self.MycollectionView footerEndRefreshing];
    [self.MycollectionView headerEndRefreshing];
    [self.MycollectionView ffRefreshHeaderEndRefreshing];
}
//导航条
- (void)creatNavagationView
{
    UIImageView *headview=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kApplicationWidth, Height_NavBar)];
    [self.view addSubview:headview];
    headview.userInteractionEnabled=YES;
    
    UIButton *backbtn=[UIButton buttonWithType:UIButtonTypeCustom];
    backbtn.frame=CGRectMake(0, 20, 44, 44);
    backbtn.centerY = View_CenterY(headview);
    [backbtn setImage:[UIImage imageNamed:@"返回按钮_正常"] forState:UIControlStateNormal];
    [backbtn addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    backbtn.hidden=self.ShopCart_Type==ShopCart_TarbarType?YES:NO;
    [headview addSubview:backbtn];

    _titlelable=[[UILabel alloc]init];
    _titlelable.frame=CGRectMake(0, 0, 300, 40);
    _titlelable.center=CGPointMake(kApplicationWidth/2, headview.frame.size.height/2+10);
    _titlelable.text=@"购物车";
    _titlelable.font = kNavTitleFontSize;
    _titlelable.textColor=kMainTitleColor;
    _titlelable.textAlignment=NSTextAlignmentCenter;
    [headview addSubview:_titlelable];
    
    self.editButtonn=[[UIButton alloc]init];
    self.editButtonn.frame=CGRectMake(kApplicationWidth-ZOOM6(120), 23, ZOOM6(100), 40);
    self.editButtonn.centerY = View_CenterY(headview);
    [self.editButtonn setTitle:@"编辑" forState:UIControlStateNormal];
    self.editButtonn.titleLabel.font=[UIFont systemFontOfSize:16];
    [self.editButtonn setTitleColor:RGBCOLOR_I(125, 125, 125) forState:UIControlStateNormal];
    self.editButtonn.selected = NO;
    [self.editButtonn addTarget:self action:@selector(Edit:) forControlEvents:UIControlEventTouchUpInside];
    [headview addSubview:self.editButtonn];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, Height_NavBar-1, kScreenWidth, 1)];
    lineView.backgroundColor = RGBCOLOR_I(220,220,220);
    [self.view addSubview:lineView];
}
//列表
- (void)creatCollectionView
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumInteritemSpacing = 5;
    layout.minimumLineSpacing = 0;
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    
    CGFloat Heigh = self.ShopCart_Type==ShopCart_TarbarType?49:0;
    self.MycollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, Height_NavBar, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)-Height_NavBar-Heigh-50) collectionViewLayout:layout];
    self.MycollectionView.backgroundColor = RGBCOLOR_I(239, 239, 239);
    self.MycollectionView.delegate = self;
    self.MycollectionView.dataSource = self;
    [self.view addSubview:self.MycollectionView];
    
    [self.MycollectionView registerNib:[UINib nibWithNibName:@"WaterFlowCell" bundle:nil] forCellWithReuseIdentifier:@"WATERFLOWCELLID"];
    
    [self.MycollectionView registerNib:[UINib nibWithNibName:@"CartNoEditCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"CELL"];
    
    [self.MycollectionView registerNib:[UINib nibWithNibName:@"InvalidCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"invalidCell"];
    
    [self.MycollectionView registerClass:[CollectionHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView"];
    
    [self.MycollectionView registerClass:[CollectionHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"FooterView"];

    //下拉刷新
    __weak NewShoppingCartViewController *myController = self;
    [self.MycollectionView addHeaderWithCallback:^{
        myController.currPage = 1;
        [myController creatLikeData:myController.currPage];
    }];
    
    //上拉加载
    [self.MycollectionView addFooterWithCallback:^{
        
        [myController creatLikeData:myController.currPage];
    }];

}

#pragma mark 批量视图
-(void)creatFootview
{
    CGFloat Heigh = self.ShopCart_Type==ShopCart_TarbarType?49:0;
    _FootView=[[UIView alloc]initWithFrame:CGRectMake(0, self.view.height-50-Heigh, kApplicationWidth, 50)];
    _FootView.backgroundColor=[UIColor whiteColor];
    _FootView.tag=7272;
    _FootView.hidden=YES;
    [self.view addSubview:_FootView];
    
    UILabel *linelable=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, kApplicationWidth, 0.5)];
    linelable.backgroundColor=RGBCOLOR_I(197, 197, 197);
    [_FootView addSubview:linelable];

    //全选按钮
    allselectbtn=[[UIButton alloc]init];
    allselectbtn.frame=CGRectMake(0,_FootView.frame.size.height/2-ZOOM(60)/2,ZOOM(230), ZOOM(60));
    allselectbtn.imageEdgeInsets = UIEdgeInsetsMake(0,-ZOOM(20),0.0f,ZOOM(20));
    allselectbtn.titleEdgeInsets = UIEdgeInsetsMake(0, -ZOOM(10), 0.0f, ZOOM(10));
    [allselectbtn setImage:[UIImage imageNamed:@"icon_nor"] forState:UIControlStateNormal];
    [allselectbtn setImage:[UIImage imageNamed:@"选中"] forState:UIControlStateSelected];
    allselectbtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [allselectbtn setTitle:@"全选" forState:UIControlStateNormal];
    allselectbtn.titleLabel.font = [UIFont systemFontOfSize:ZOOM(46)];
    [allselectbtn setTitleColor:kMainTitleColor forState:UIControlStateNormal];
    allselectbtn.clipsToBounds=YES;
    allselectbtn.selected=NO;
    allselectbtn.tag=9999;
    allselectbtn.layer.borderColor=kbackgrayColor.CGColor;
    [allselectbtn addTarget:self action:@selector(selectclick:) forControlEvents:UIControlEventTouchUpInside];
    [_FootView addSubview:allselectbtn];
    
   
    //结算
    _allpaybtn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    _allpaybtn.frame=CGRectMake(kScreenWidth-ZOOM6(300), 0.5, ZOOM6(300), _FootView.frame.size.height);;
    _allpaybtn.backgroundColor = RGBCOLOR_I(197, 197, 197);
    _allpaybtn.titleLabel.font = [UIFont systemFontOfSize:ZOOM(46)];
    [_allpaybtn addTarget:self action:@selector(pay:) forControlEvents:UIControlEventTouchUpInside];
    [_FootView addSubview:_allpaybtn];
    
    payTimeLabel=[[UILabel alloc]initWithFrame:_allpaybtn.frame];
    payTimeLabel.attributedText=[[NSAttributedString alloc]initWithString:@"结算"];
    payTimeLabel.textAlignment=NSTextAlignmentCenter;
    payTimeLabel.numberOfLines=0;
    payTimeLabel.textColor=[UIColor whiteColor];
    payTimeLabel.backgroundColor=RGBCOLOR_I(197, 197, 197);
    [_FootView addSubview:payTimeLabel];
    
    _allmoneylable=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(allselectbtn.frame)+ZOOM6(30), CGRectGetMidY(_allpaybtn.frame)-20+ZOOM6(5), kScreenWidth/2, 20)];
    _allmoneylable.text=[NSString stringWithFormat:@"合计：￥0.0"];
    _allmoneylable.font=[UIFont systemFontOfSize:ZOOM6(28)];
    _allmoneylable.textColor=tarbarrossred;
    _allmoneylable.textAlignment=NSTextAlignmentLeft;
    [_FootView addSubview:_allmoneylable];
    
    _lable=[[UILabel alloc]initWithFrame:CGRectMake(_allmoneylable.frame.origin.x, CGRectGetMidY(_allpaybtn.frame)-ZOOM6(5), _allmoneylable.frame.size.width, 20)];
    _lable.text=@"比专柜节省¥0.0";
    _lable.textColor=RGBCOLOR_I(168, 168, 168);
    _lable.font=[UIFont systemFontOfSize:ZOOM6(24)];
    _lable.textAlignment=NSTextAlignmentLeft;
    [_FootView addSubview:_lable];
    
    _delateBackview = [[UIView alloc]initWithFrame:CGRectMake(ZOOM6(150), 0.5, kScreenWidth-ZOOM6(150), _FootView.frame.size.height)];
    _delateBackview.hidden = YES;
    _delateBackview.backgroundColor = [UIColor whiteColor];
    [_FootView addSubview:_delateBackview];
    
    _delateAllbtn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    _delateAllbtn.frame=CGRectMake(CGRectGetWidth(_delateBackview.frame)-kScreenWidth/3, 0, kScreenWidth/3, _FootView.frame.size.height);
    _delateAllbtn.backgroundColor = RGBCOLOR_I(197, 197, 197);
    [_delateAllbtn setTintColor:[UIColor whiteColor]];
    [_delateAllbtn setTitle:@"删除" forState:UIControlStateNormal];
    _delateAllbtn.titleLabel.font = [UIFont systemFontOfSize:ZOOM(46)];
    [_delateAllbtn addTarget:self action:@selector(delateAll:) forControlEvents:UIControlEventTouchUpInside];
    [_delateBackview addSubview:_delateAllbtn];
    
    _addLikebtn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    _addLikebtn.frame=CGRectMake(CGRectGetWidth(_delateBackview.frame)-(kScreenWidth/3)*2, 0, kScreenWidth/3, _FootView.frame.size.height);
    [_addLikebtn setTintColor:tarbarrossred];
    [_addLikebtn setTitle:@"加入喜欢" forState:UIControlStateNormal];
    _addLikebtn.titleLabel.font = [UIFont systemFontOfSize:ZOOM(46)];
    [_addLikebtn addTarget:self action:@selector(addLike:) forControlEvents:UIControlEventTouchUpInside];
    [_delateBackview addSubview:_addLikebtn];
    
    UILabel *spaceline=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(_addLikebtn.frame)-1, 0, 0.5, _FootView.frame.size.height)];
    spaceline.backgroundColor=kNavLineColor;
    [_delateBackview addSubview:spaceline];
    
}

//section==0时headview
-(UIView *)getfirstHeadview
{
    kSelfWeak;
    GoShopView *goShopView=[[GoShopView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, ZOOM6(490))];
    goShopView.BtnBlock = ^{
        [weakSelf shoppinggo];
    };

    return goShopView;
}

//section==2时headview
- (UIView*)getSecondHeadview
{
    UIView *headview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
    headview.backgroundColor = RGBCOLOR_I(239, 239, 239);
    
    UILabel *lableline = [[UILabel alloc]initWithFrame:CGRectMake((kScreenWidth-ZOOM6(280))/2, 40/2, ZOOM6(280), 1)];
    lableline.backgroundColor = tarbarrossred;
    [headview addSubview:lableline];
    
    UILabel *shoplab = [[UILabel alloc]initWithFrame:CGRectMake((kScreenWidth-ZOOM6(160))/2, 0, ZOOM6(160), CGRectGetHeight(headview.frame))];
    shoplab.backgroundColor = RGBCOLOR_I(239, 239, 239);
    shoplab.text = @"我的喜欢";
    shoplab.textColor = RGBCOLOR_I(255, 63, 139);
    shoplab.font = [UIFont systemFontOfSize:ZOOM6(28)];
    shoplab.textAlignment = NSTextAlignmentCenter;
    [headview addSubview:shoplab];
    
    return headview;
}
//section==1时的footview
- (UIView*)getfirstFootview
{
    UIView *headview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 50)];
    headview.backgroundColor = [UIColor whiteColor];
    
    UIButton *clearBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    clearBtn.frame = CGRectMake((kScreenWidth-ZOOM6(300))/2, 5, ZOOM6(300), 30);
    [clearBtn setTitle:@"清空失效商品" forState:UIControlStateNormal];
    [clearBtn setTintColor:tarbarrossred];
    clearBtn.layer.borderWidth = 1;
    clearBtn.layer.cornerRadius = 3;
    clearBtn.layer.borderColor = tarbarrossred.CGColor;
    [clearBtn addTarget:self action:@selector(clearData:) forControlEvents:UIControlEventTouchUpInside];
    [headview addSubview:clearBtn];
    return headview;
}

#pragma mark collectionViewDatasouce
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionVie
{
    return 3;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if(section == 0)
    {
        return [self.viewmodel.dataArray count];
    }else if (section == 1)
    {
        return [self.viewmodel.invalidArray count];
    }else if (section == 2)
    {
        return [self.likeArray count];
    }
    return 0;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0 || indexPath.section == 1)
    {
        ShopDetailModel *model;
        ShopDetailModel *model1;
    
        CartNoEditCollectionViewCell *editcell ;
        InvalidCollectionViewCell *validcell ;
        
        ShopDetailViewController *detail=[[ShopDetailViewController alloc]initWithNibName:@"ShopDetailViewController" bundle:nil];
        if(indexPath.section == 0)
        {
            model1 = self.viewmodel.dataArray[indexPath.item];
            editcell = (CartNoEditCollectionViewCell*)[self.MycollectionView cellForItemAtIndexPath:indexPath];
            detail.bigimage=editcell.headImage.image;
        }else{
            model1 = self.viewmodel.invalidArray[indexPath.item];
            validcell = (InvalidCollectionViewCell*)[self.MycollectionView cellForItemAtIndexPath:indexPath];
            detail.bigimage=validcell.headImage.image;
        }
        
        if (model.shop_list.count) {
            model=model1.shop_list[indexPath.item];
        }else
            model=model1;
        if (model.isGray.intValue||model.is_del.intValue) {
            return;
        }
        
        detail.shop_code=model.shop_code;
        detail.hidesBottomBarWhenPushed=self.ShopCart_Type==ShopCart_TarbarType?YES:NO;
        detail.stringtype = @"订单详情";
        [self.navigationController pushViewController:detail animated:YES];

    }else{
        ShopDetailViewController *detail=[[ShopDetailViewController alloc]initWithNibName:@"ShopDetailViewController" bundle:nil];
        LikeModel *model = self.likeArray[indexPath.item];
        detail.shop_code=model.shop_code;
        detail.hidesBottomBarWhenPushed=self.ShopCart_Type==ShopCart_TarbarType?YES:NO;
        detail.stringtype = @"订单详情";
        [self.navigationController pushViewController:detail animated:YES];

    }
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 2)
    {
        WaterFlowCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"WATERFLOWCELLID" forIndexPath:indexPath];
        LikeModel *model = self.likeArray[indexPath.item];
        model.reduceMoney = self.reduceMoney;
        model.shop_deduction = self.shop_deduction;
        model.isVip = self.isVip;
        model.maxType = self.maxType;
        [cell refreshDataModel:model];
        return cell;
    }else if(indexPath.section == 1)
    {
        InvalidCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"invalidCell" forIndexPath:indexPath];
        cell.backgroundColor = [UIColor whiteColor];
        ShopDetailModel *model = self.viewmodel.invalidArray[indexPath.item];
        
        cell.delateClick = ^{
            
            ShopDetailModel *model1;
            if(self.viewmodel.invalidArray.count){
                model1=self.viewmodel.invalidArray[indexPath.item];
            }
            [self deleteHttp:model1 type:NO DelArr:self.viewmodel.invalidArray ISalldelate:NO];
        };
        
        [cell refreshData:model];
        
        return cell;
        
    }else if(indexPath.section == 0)
    {
        CartNoEditCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CELL" forIndexPath:indexPath];
        cell.backgroundColor = [UIColor whiteColor];
        cell.shopNumber.text = @"";
        cell.makelab.text = @"";
        cell.editView.hidden = YES;
        if(self.editButtonn.selected)
        {
            cell.editView.hidden=NO;
        }else{
            cell.editView.hidden=YES;
        }
        
        ShopDetailModel *model = self.viewmodel.dataArray[indexPath.item];
        model.allselectShop = allselectbtn.selected?YES:NO;
        
        cell.selectClick= ^{
            model.selectShop = !model.selectShop;
            [self changeResavePrice];
            [self.MycollectionView reloadData];
        };
        cell.reduiceClick= ^{
            
            [self changeshopHttp:indexPath.item typeid:model.stock_type_id withIndex:indexPath model:model ShopNum:[model.shop_num integerValue] Change:NO];
        };
        cell.addClick= ^{
            if(model.shop_num.intValue < 3)
            {
                [self changeshopHttp:indexPath.item typeid:model.stock_type_id withIndex:indexPath model:model ShopNum:[model.shop_num integerValue] Change:NO];
            }else{
                [MBProgressHUD show:@"抱歉,数量有限,最多只能购买2件噢!" icon:nil view:self.view];
            }
        };
        cell.delateClick= ^{
            
            [self setdelateShopPopMindView:Deleate_shoppingcart shopModel:model];
        };
        cell.changeClick= ^{
            
            shopPopview = [[ChangeShopPopview alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) ShopModel:model];
            __weak ChangeShopPopview *view = shopPopview;
            view.okChangeBlock = ^(ShopDetailModel* changepmodel)
            {
                 [self changeshopHttp:indexPath.item typeid:changepmodel.stock_type_id withIndex:indexPath model:changepmodel ShopNum:[changepmodel.shop_num integerValue] Change:YES];
                
                [self reloadTableviewData];
            };
            
            UIWindow *window = [[UIApplication sharedApplication] keyWindow];
            [window addSubview:shopPopview];
        };
        [cell refreshData:model];
        
        return cell;

    }
    return nil;
}

//item大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 2)
    {
        CGFloat imgH = 900;
        CGFloat imgW = 600;
        
        CGFloat W = (kScreenWidth-5)/2.0;
        CGFloat H = imgH*W/imgW;
        
        return CGSizeMake(W, H+5);
        
    }else if (indexPath.section == 1)
    {
        //        if(indexPath.section == 0 && self.viewmodel.dataArray.count)
        //        {
        //            if(indexPath.item != self.viewmodel.dataArray.count-1)
        //            {
        //                return CGSizeMake(CGRectGetWidth(self.view.frame),110);
        //            }
        //        }

        return CGSizeMake(CGRectGetWidth(self.view.frame),100);
    }
    else{
        return CGSizeMake(CGRectGetWidth(self.view.frame),110);
    }
}
//header大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    if(section == 2)
    {
        return CGSizeMake(CGRectGetWidth(self.view.frame) - 20, 40);
    }else if (section == 0)
    {
        if(self.viewmodel.dataArray.count != 0)
        {
            return CGSizeMake(CGRectGetWidth(self.view.frame) - 20, 0);
        }
        return CGSizeMake(CGRectGetWidth(self.view.frame) - 20, ZOOM6(490));
    }
    
    return CGSizeMake(CGRectGetWidth(self.view.frame) - 20, 0);
}
//footer大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    if(section == 1 && self.viewmodel.invalidArray.count !=0)
    {
        return CGSizeMake(CGRectGetWidth(self.view.frame) - 20, 50);
    }
    return CGSizeMake(CGRectGetWidth(self.view.frame) - 20, 0);
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        CollectionHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView" forIndexPath:indexPath];
        if(indexPath.section==0)
        {
            for (UIView *view in headerView.subviews) {
                [view removeFromSuperview];
            }
            [headerView addSubview:[self getfirstHeadview]];
        }else if (indexPath.section == 2)
        {
            for (UIView *view in headerView.subviews) {
                [view removeFromSuperview];
            }
            
            self.likeArray.count?[headerView addSubview:[self getSecondHeadview]]:nil;
        }
        
        return headerView;
    }
    else{
        CollectionHeaderView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"FooterView" forIndexPath:indexPath];
        if(indexPath.section == 1)
        {
            [footerView addSubview:[self getfirstFootview]];
        }
        return footerView;
    }
    
    return nil;
}

#pragma mark 删除商品弹框
- (void)setdelateShopPopMindView:(VitalityType)type shopModel:(ShopDetailModel*)model
{
    VitalityTaskPopview*vitaliview = [[VitalityTaskPopview alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) VitalityType:type valityGrade:0 YidouCount:0];
    __weak VitalityTaskPopview *view = vitaliview;
    view.tapHideMindBlock = ^{
        [view remindViewHiden];
    };
    
    view.rightHideMindBlock = ^(NSString*title){
        
        if(model != nil)//单个删除
        {
            [self deleteHttp:model type:NO DelArr:self.viewmodel.dataArray ISalldelate:NO];

        }else{//全部删除
            
            for(int i =0;i<self.viewmodel.dataArray.count;i++)
            {
                ShopDetailModel *model = self.viewmodel.dataArray[i];
                if(model.selectShop)
                {
                    [self deleteHttp:model type:NO DelArr:self.viewmodel.dataArray ISalldelate:YES];
                }
            }
        }
        
        [self reloadTableviewData];
        [self changeTabbarCartNum];
    };
    
    view.leftHideMindBlock = ^(NSString*title)
    {
       
    };
    
    [self.view addSubview:vitaliview];
}

#pragma mark 购物车商品加入喜欢
- (void)addLike:(UIButton*)sender
{
    int shopCount = 0;
    NSMutableString *shopcodes = [NSMutableString string];
    for(int i =0 ;i<self.viewmodel.dataArray.count;i++)
    {
        ShopDetailModel *model = self.viewmodel.dataArray[i];
        if(model.selectShop)
        {
            shopCount ++;
            [shopcodes appendString:model.shop_code];
            [shopcodes appendString:@","];
        }
    }
    NSString *codes = shopcodes.length>0?[shopcodes substringToIndex:[shopcodes length] - 1]:nil;
    shopCount >0?[self likerequestHttp:codes]:[MBProgressHUD show:@"亲，请选择喜欢的商品" icon:nil view:self.view];
    
}
#pragma mark 删除购物车所有商品
- (void)delateAll:(UIButton*)sender
{
    int delateCount = 0;
    for(int i =0;i<self.viewmodel.dataArray.count;i++)
    {
        ShopDetailModel *model = self.viewmodel.dataArray[i];
        if(model.selectShop)
        {
            delateCount ++;
        }
    }
    if(delateCount == 0)
    {
        [MBProgressHUD show:@"亲，还没有选择删除的商品" icon:nil view:self.view];
        return;
    }
    
    [self setdelateShopPopMindView:Deleate_shoppingcart shopModel:nil];
}

#pragma mark 改变购物车商品数量 YES-改变颜色数量尺码 NO-只改数量
-(void)changeshopHttp:(NSInteger)tag typeid:(NSString*)typeid withIndex:(NSIndexPath*)index model:(ShopDetailModel *)model ShopNum:(NSInteger)shopnum  Change:(BOOL)change;
{
    ShopCarModel *cmodel = [ShopCarManager sharedManager].pData[tag];
    cmodel.shop_num = shopnum ;
    if(change)
    {
        cmodel.color = model.shop_color;
        cmodel.size = model.shop_size;
        cmodel.def_pic = model.pic;
//        cmodel.stock_type_id = [model.stock_type_id longLongValue];
    }
    
    [ShopCarManager updateToDB:cmodel];
    [self getShopCount];
    [self changeTabbarCartNum];
    [self changeResavePrice];
    
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *paraments=[NSMutableDictionary dictionary];
    NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
    NSString*token=[user objectForKey:USER_TOKEN];
    
    NSString *url;
    if(model.p_code!=nil){
        url=[NSString stringWithFormat:@"%@shopCart/update?version=%@&token=%@&id=%@&size=%@&color=%@&shop_num=%d&stock_type_id=%@&p_code=%@",[NSObject baseURLStr],VERSION,token,model.ID,model.shop_size,model.shop_color,(int)shopnum,typeid,model.p_code];
    }else{
        if(change)
        {
            url=[NSString stringWithFormat:@"%@shopCart/updatePrefer?version=%@&token=%@&id=%@&size=%@&color=%@&shop_num=%d&stock_type_id=%@&def_pic=%@",[NSObject baseURLStr],VERSION,token,model.ID,model.shop_size,model.shop_color,(int)shopnum,typeid,model.def_pic];

        }else{
            url=[NSString stringWithFormat:@"%@shopCart/update?version=%@&token=%@&id=%@&size=%@&color=%@&shop_num=%d&stock_type_id=%@",[NSObject baseURLStr],VERSION,token,model.ID,model.shop_size,model.shop_color,(int)shopnum,typeid];
        }
        
    }
    NSString *URL=[MyMD5 authkey:url];
    
    [manager POST:URL parameters:paraments success:^(AFHTTPRequestOperation *operation, id responseObject) {
        MyLog(@"responseObject = %@",responseObject);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    }];
    
}

#pragma mark 删除购物车所有失效的商品
/**
 *  删除购物车商品
 *
 *  @param model <#model description#>
 *  @param type  未过期列表yes代表过期商品  no代表未过期   过期列表no代表过期的不是搭配的
 *  @param DelArr  被删除对象的数组
 */
-(void)deleteHttp:(ShopDetailModel*)model type:(BOOL)type DelArr:(NSMutableArray*)DelArr ISalldelate:(BOOL)isall
{
    ShopCarModel *cmodel = [ShopCarModel new];
    cmodel.shop_code = model.shop_code;
    cmodel.stock_type_id = model.stock_type_id.floatValue;
    [ShopCarManager deleteToDB:cmodel];
    
    isall==NO?[self reloadTableviewData]:nil;

    [self changeTabbarCartNum];
    
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *paraments=[NSMutableDictionary dictionary];
    NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
    NSString*token=[user objectForKey:USER_TOKEN];
    NSString *str=[NSString stringWithFormat:@"%@",model.ID];
    
    NSArray *arr=[str componentsSeparatedByString:@","];
    NSString *url;
    
    if (type&&model.paired_code!=nil) {
        url=[NSString stringWithFormat:@"%@shopCart/del?version=%@&token=%@&paired_code=%@",[NSObject baseURLStr],VERSION,token,model.paired_code];
    }
    else if (model.p_code!=nil) {
        url=[NSString stringWithFormat:@"%@shopCart/del?version=%@&token=%@&id=%@&p_code=%@",[NSObject baseURLStr],VERSION,token,str,model.p_code];
    }else{
        if(arr.count>1){
            url=[NSString stringWithFormat:@"%@shopCart/del?version=%@&token=%@&ids=%@",[NSObject baseURLStr],VERSION,token,str];
        }else if(model.paired_code!=nil){
            url=[NSString stringWithFormat:@"%@shopCart/del?version=%@&token=%@&shop_code=%@&id=%@&paired_code=%@",[NSObject baseURLStr],VERSION,token,model.shop_code,str,model.paired_code];
        }
        else {
            url=[NSString stringWithFormat:@"%@shopCart/del?version=%@&token=%@&id=%@",[NSObject baseURLStr],VERSION,token,str];
        }
    }
    NSString *URL=[MyMD5 authkey:url];
    
    [manager POST:URL parameters:paraments success:^(AFHTTPRequestOperation *operation, id responseObject) {
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    }];
    
}

#pragma mark 加喜欢
-(void)likerequestHttp:(NSString*)shopcodes
{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *paraments=[NSMutableDictionary dictionary];
    
    NSString *url;
    
    NSUserDefaults *userdefaul=[NSUserDefaults standardUserDefaults];
    NSString *token=[userdefaul objectForKey:USER_TOKEN];
    
    //
    int weekday = [self getweekday];
    MyLog(@"weekday is %d",weekday);
    
    url=[NSString stringWithFormat:@"%@like/addLike?version=%@&shop_code=%@&token=%@&show=%d",[NSObject baseURLStr],VERSION,shopcodes,token,weekday];
    
    NSString *URL=[MyMD5 authkey:url];

    [manager POST:URL parameters:paraments success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if (responseObject!=nil) {
            NSString *statu=responseObject[@"status"];
             NavgationbarView *mentionview=[[NavgationbarView alloc]init];
            if(statu.intValue==1)//请求成功
            {
                //新加的最爱存储到本地
                NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
                NSArray *likearr = [user objectForKey:@"user_like"];
                
                NSMutableArray *newlikearr = [NSMutableArray arrayWithArray:likearr];
                if(shopcodes)
                {
                    NSArray *codes = [shopcodes componentsSeparatedByString:@","];
                    if(codes.count)
                    {
                        [newlikearr addObjectsFromArray:codes];
                    }
                }
                [user setObject:newlikearr forKey:@"user_like"];

                [mentionview showLable:@"加喜欢成功" Controller:self];
            }else{
                [mentionview showLable:@"加喜欢失败" Controller:self];
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        
        [[Animation shareAnimation] stopAnimationAt:self.view];
        if ([error code] == kCFURLErrorTimedOut) {
            [[SVProgressHUD  sharedManager]showMessage:timeOutMsg];
        }else{
            NavgationbarView *mentionview=[[NavgationbarView alloc]init];
            [mentionview showLable:@"网络开小差啦,请检查网络" Controller:self];
        }
    }];
    
}

#pragma mark 检测商品是否有库存
-(void)checkShopList
{
    NSMutableArray *arr=[NSMutableArray arrayWithArray:[ShopCarManager sharedManager].pData];
    [arr addObjectsFromArray:[ShopCarManager sharedManager].peData];
    NSMutableString *IDstrings=[NSMutableString string];
    
    [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        ShopCarModel *model=obj;
        if(model.shop_code){
            [IDstrings appendString:[NSString stringWithFormat:@"%@",model.shop_code]];
            [IDstrings appendString:@","];
        }
    }];
   
    NSString *ccc=IDstrings.length!=0?[IDstrings substringToIndex:[IDstrings length]-1]:@"";
    
    [CartViewModel CheckShopListWithShopCodes:ccc Success:^(id data) {
        CartViewModel *model1 = data;
        if (model1.status == 1) {
            
            NSArray *numArr=[NSArray arrayWithArray:model1.list];
            [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                ShopCarModel *model = (ShopCarModel *)obj;
                if ([numArr containsObject:model.shop_code]) {
                    model.valid=YES;
                    model.expired=YES;
                }
            }];
            [ShopCarManager updateToDBWidthArray:arr];
            [self reloadTableviewData];
        } else {
            if(model1.status == 10030){//没登录状态
                [[NSUserDefaults standardUserDefaults] removeObjectForKey:USER_TOKEN];
                [self loginWithPro:@"10030" Success:nil];
            }
            [MBProgressHUD show:model1.message icon:nil view:nil];
        }
    }];
}
#pragma mark 获取是星期几
-(int)getweekday
{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDate *now;
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags =NSYearCalendarUnit | NSMonthCalendarUnit |NSDayCalendarUnit | NSWeekdayCalendarUnit |
    NSHourCalendarUnit |NSMinuteCalendarUnit | NSSecondCalendarUnit;
    now=[NSDate date];
    comps = [calendar components:unitFlags fromDate:now];
    
    //-----------weekday is %d",(int)[comps weekday]);//在这里需要注意的是：星期日是数字1，星期一时数字2，以此类推。。。
    
    int weekday ;
    if([comps weekday])
    {
        weekday = (int)[comps weekday]-1;
    }
    
    return weekday;
}

#pragma mark 去逛逛
-(void)shoppinggo
{
    Mtarbar.selectedIndex=0;
    [self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma makr 编辑
- (void)Edit:(UIButton*)sender
{
    sender.selected =!sender.selected;
    _delateBackview.hidden = !sender.selected;
    
    if(sender.selected)
    {
        [sender setTitleColor:tarbarrossred forState:UIControlStateNormal];
        [sender setTitle:@"完成" forState:UIControlStateNormal];
    }else{
        [sender setTitleColor:RGBCOLOR_I(125, 125, 125) forState:UIControlStateNormal];
        [sender setTitle:@"编辑" forState:UIControlStateNormal];
    }
    
    [self.MycollectionView reloadData];
    
}

#pragma mark 清空失效数据
- (void)clearData:(UIButton*)sender
{
    for(int i=0;i<self.viewmodel.invalidArray.count;i++)
    {
        ShopDetailModel *model1=self.viewmodel.invalidArray[i];
        
        [self deleteHttp:model1 type:NO DelArr:self.viewmodel.invalidArray ISalldelate:YES];
    }
    
    [self reloadTableviewData];
}

#pragma mark 全选
-(void)selectclick:(UIButton*)sender
{
    sender.selected=!sender.selected;
    
    NSInteger shopCount=0;
    if(sender.selected){
        for(int i=0;i<self.viewmodel.dataArray.count;i++){
            ShopDetailModel *model=self.viewmodel.dataArray[i];
            if (!model.isGray.intValue||!model.is_del.intValue) {
                model.selectShop=YES;
                shopCount++;
            }
        }
        [self changeResavePrice];
    }else{
        for(int i=0;i<self.viewmodel.dataArray.count;i++){
            ShopDetailModel *model=self.viewmodel.dataArray[i];
            model.selectShop=NO;
        }
        [self changeResavePrice];
        
    }
    
    [self.MycollectionView reloadData];
}
#pragma mark  改变节省的资金
/******************    改变节省的资金   **************/
-(void)changeResavePrice
{
    CGFloat shopprice=0; CGFloat allMoney=0;int shopCount = 0; int CartCount =0;
    for (int i=0; i<self.viewmodel.dataArray.count; i++) {
        ShopDetailModel *model=self.viewmodel.dataArray[i];
        
        if (model.shop_list.count) {
            for (int j=0; j<model.shop_list.count; j++) {
                ShopDetailModel *model2=model.shop_list[j];
                allMoney+=[model2.shop_se_price floatValue]*model2.shop_num.intValue*0.9;
                shopprice+=([model2.shop_price floatValue]-[model2.shop_se_price floatValue])*model2.shop_num.intValue;
            }
        }else if (model.selectShop) {
            allMoney+=[model.shop_se_price floatValue]*model.shop_num.intValue;
            shopprice+=([model.shop_price floatValue]-[model.shop_se_price floatValue])*model.shop_num.intValue;
            shopCount ++;
            CartCount +=model.shop_num.intValue;
        }
    }
    
    if(shopCount < self.viewmodel.dataArray.count)
    {
        allselectbtn.selected = NO;
        if(shopCount == 0)
        {
            payTimeLabel.text = @"结算";
            payTimeLabel.backgroundColor = RGBCOLOR_I(197, 197, 197);
            _delateAllbtn.backgroundColor = RGBCOLOR_I(197, 197, 197);
        }else{
            payTimeLabel.text = [NSString stringWithFormat:@"结算(%d)",CartCount];
            payTimeLabel.backgroundColor = tarbarrossred;
            _delateAllbtn.backgroundColor = RGBCOLOR_I(237, 70, 56);
        }
        
    }else if (shopCount == self.viewmodel.dataArray.count)
    {
        allselectbtn.selected = YES;
        payTimeLabel.text = [NSString stringWithFormat:@"结算(%d)",CartCount];
        payTimeLabel.backgroundColor = tarbarrossred;
        _delateAllbtn.backgroundColor = RGBCOLOR_I(237, 70, 56);
    }
    _allmoneylable.text=[NSString stringWithFormat:@"合计：￥%.1f",allMoney];
    _lable.text=[NSString stringWithFormat:@"比专柜节省¥%.1f",shopprice];
}

#pragma mark 结算
-(void)pay:(UIButton*)sender
{
    NSMutableArray *shopArray=[NSMutableArray array];
    NSMutableString *shopCodes=[NSMutableString string];
    
    BOOL haveType=NO;
    CGFloat allResavePrice=0;
    for(int i=0 ;i<self.viewmodel.dataArray.count;i++){
        ShopDetailModel *model=self.viewmodel.dataArray[i];
        if (model.shop_list.count) {
            for (int j=0; j<model.shop_list.count; j++) {
                ShopDetailModel *model2=model.shop_list[j];
                [shopCodes appendFormat:@"%@,",model2.shop_code];
                [shopArray addObject:model2];
                allResavePrice += model2.shop_se_price.floatValue*model2.shop_num.intValue*0.1;
            }
            haveType=YES;
        }else if(model.selectShop){
            [shopCodes appendFormat:@"%@,",model.shop_code];
            [shopArray addObject:model];
        }
    }
    if(shopArray.count==0){
        [MBProgressHUD show:@"亲，请选择商品" icon:nil view:self.view];
    }else{
        [YFShareModel getShareModelWithKey:[shopCodes substringToIndex:shopCodes.length-1] type:StatisticalTypeSettlement tabType:StatisticalTabTypeCommodity success:nil];
        [TFStatisticsClickVM handleDataWithPageType:nil withClickType:@"购物车页面结算" success:^(id data, Response *response) {
        } failure:^(NSError *error) {
        }];
        
        OrderTableViewController *view = [[OrderTableViewController alloc]init];
        view.hidesBottomBarWhenPushed=YES;
        view.sortArray = shopArray;
        view.haveType=haveType;
        view.allResavePrice=allResavePrice;
        kSelfWeak;
        view.affirmOrder=^{
            
//            [ShopCarManager deleteAllWidthType:ShopCarTypeCar];
            //删除已经下单的商品
            for(int i =0;i<self.viewmodel.dataArray.count;i++)
            {
                ShopDetailModel *model = self.viewmodel.dataArray[i];
                if(model.selectShop)
                {
                    [self deleteHttp:model type:NO DelArr:self.viewmodel.dataArray ISalldelate:YES];
                }
            }

            [weakSelf reloadTableviewData];
            
            [self changeTabbarCartNum];
            
        };
        [self.navigationController pushViewController:view animated:YES];
    }
}
-(void)reloadTableviewData{
    
    [self.viewmodel.dataArray removeAllObjects];
//    [self creatData];//重新获取数据
    
    if(self.viewmodel.dataArray.count==0)
    {
        self.editButtonn.userInteractionEnabled = NO;
        [self.editButtonn setTitle:@"编辑" forState:UIControlStateNormal];
        [self.editButtonn setTitleColor:RGBCOLOR_I(125, 125, 125) forState:UIControlStateNormal];
    }
    
    CGFloat Heigh = self.ShopCart_Type==ShopCart_TarbarType?49:0;
    if (self.viewmodel.dataArray.count==0&&self.viewmodel.invalidArray.count==0) {
        _FootView.hidden=YES;
        self.MycollectionView.height=self.view.height-Heigh-Height_NavBar;

    }else if (self.viewmodel.dataArray.count==0&&self.viewmodel.invalidArray.count!=0) {
        
        _FootView.hidden=YES;
        self.MycollectionView.height=self.view.height-Heigh-Height_NavBar;
    }
    else{
        _FootView.hidden=NO;
        self.MycollectionView.height=self.view.height-50-Heigh-Height_NavBar;
    }
    [self changeResavePrice];
    [self.MycollectionView reloadData];

    
    [[NSUserDefaults standardUserDefaults]setObject:@"1" forKey:@"RFTCart"];//用于刷新tabbar的购物车
}

- (void)back:(UIButton*)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (NavgationbarView*)mentionview
{
    if(_mentionview==nil)
    {
        _mentionview=[[NavgationbarView alloc]init];
    }
    return _mentionview;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (NSMutableArray*)likeArray
{
    if(_likeArray == nil)
    {
        _likeArray = [NSMutableArray array];
    }
    return _likeArray;
}

- (TFShoppingVM *)viewModel
{
    if (!_viewModel) {
        _viewModel = [[TFShoppingVM alloc] init];
    }
    return _viewModel;
}
@end
