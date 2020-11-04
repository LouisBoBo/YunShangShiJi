//
//  SpecialDetailViewController.m
//  YunShangShiJi
//
//  Created by ios-1 on 2016/12/2.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import "SpecialDetailViewController.h"
#import "ShopDetailViewController.h"
#import "FJWaterfallFlowLayout.h"
#import "WaterFlowCell.h"
#import "MJRefresh.h"
#import "GlobalTool.h"
#import "SpecialDetailModel.h"
#import "SpecialShopModel.h"
#import "MBProgressHUD.h"
#import "TFMoreTopicsVC.h"
#import "DefaultImgManager.h"
#import "UIImageView+WebCache.h"
#import "YFDPImageView.h"
#import "SpecialCollocationModel.h"
@interface SpecialDetailViewController ()<FJWaterfallFlowLayoutDelegate>

@end

@implementation SpecialDetailViewController
{
    SpecialDetailModel *_model;
    SpecialMainModel   *_mainModel;    //专题详情数据
    CGFloat _moveHeigh;                //专题描述文字高度
    CGFloat _footHeigh;                //专题尾高度
    
    //数据库
    const char *_sql_stmt;
}
#define HEAD_VIEWHEIGH ZOOM6(580)
#define FOOT_VIEWHEIGH ZOOM6(1800)
#define DefaultImg(size) [[DefaultImgManager sharedManager] defaultImgWithSize:(size)]

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self creatUI];
    
    [self creatData];
//    [self creatTuijianData];
    [self httpGetDataSource];
    
    //加载失败重复加载
    kWeakSelf(self);
    [self loadFailBtnBlock:^{
        [weakself creatData];
        [weakself httpGetDataSource];
    }];

}

#pragma mark *****************界面*******************
- (void)creatUI
{
    [self creatNavagationbar];
    
    [self creatCollectionView];
}
- (void)creatNavagationbar
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
    titlelable.text=@"专题详情";
    titlelable.font=kNavTitleFontSize;
    titlelable.textColor=kMainTitleColor;
    titlelable.textAlignment=NSTextAlignmentCenter;
    [self.tabheadview addSubview:titlelable];
    
}
- (void)creatCollectionView
{
    FJWaterfallFlowLayout *fjWaterfallFlowLayout = [[FJWaterfallFlowLayout alloc] init];
    fjWaterfallFlowLayout.itemSpacing = 5;
    fjWaterfallFlowLayout.lineSpacing = 0;
    fjWaterfallFlowLayout.sectionInset = UIEdgeInsetsMake(0, 5, 0, 5);
    fjWaterfallFlowLayout.colCount = 2;
    fjWaterfallFlowLayout.delegate = self;

    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, Height_NavBar, kScreenWidth, kScreenHeight-Height_NavBar) collectionViewLayout:fjWaterfallFlowLayout];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.view addSubview:self.collectionView];
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"WaterFlowCell" bundle:nil] forCellWithReuseIdentifier:@"WATERFLOWCELLID"];
    
    [self.collectionView registerClass:[CollectionHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView"];
    
    [self.collectionView registerClass:[CollectionHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"FooterView"];
    
    //下拉刷新
    __weak SpecialDetailViewController *myController = self;
//    [self.collectionView addHeaderWithCallback:^{
//        
//        [myController creatData];
//        
//        [myController.RecommendList removeAllObjects];
//        [myController httpGetDataSource];
//    }];
    
    //上拉加载
    [self.collectionView addFooterWithCallback:^{
        
        [myController httpGetDataSource];
    }];

}

//专题的标题
- (void)gettitle:(UIImageView*)imageview Name1:(NSString*)name1 Name2:(NSString*)name2
{
    UILabel *biglab = [[UILabel alloc]initWithFrame:CGRectMake(ZOOM6(20), ZOOM6(204), kScreenWidth-2*ZOOM6(20), ZOOM6(50))];
    biglab.textColor = [UIColor whiteColor];
    biglab.font = [UIFont fontWithName:@"Helvetica-Bold" size:ZOOM6(45)];
    biglab.textAlignment = NSTextAlignmentCenter;
    biglab.text = name1;
    
    UILabel *smalab = [[UILabel alloc]initWithFrame:CGRectMake(ZOOM6(20), CGRectGetMaxY(biglab.frame)+ZOOM6(20), CGRectGetWidth(biglab.frame), ZOOM6(30))];
    smalab.textColor = [UIColor whiteColor];
    smalab.textAlignment = NSTextAlignmentCenter;
    smalab.font = [UIFont systemFontOfSize:ZOOM6(30)];
    smalab.text = [NSString stringWithFormat:@"【%@】",name2];
    [imageview addSubview:biglab];
    [imageview addSubview:smalab];
}
//列表头
- (UIView*)headview
{
    CGFloat heigh = _moveHeigh - ZOOM6(500);
    
    UIView *headview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, _moveHeigh)];
    headview.backgroundColor = [UIColor whiteColor];
    
    UIImageView *heardImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0,kScreenWidth,ZOOM6(500))];
    heardImgView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    heardImgView.contentMode = UIViewContentModeScaleAspectFill;
    NSString *pic;
    if(self.collcationModel.collocation_pic)
    {
        pic = self.collcationModel.collocation_pic;
    }else{
        pic = _mainModel.collocation_pic;
    }
    [heardImgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[NSNumber baseURLStr_Upy],pic]] placeholderImage:DefaultImg(heardImgView.size)];
    heardImgView.clipsToBounds = YES;
    [headview addSubview:heardImgView];
    
    NSString *name1 = [NSString stringWithFormat:@"%@",_mainModel.collocation_name];
    NSString *name2 = [NSString stringWithFormat:@"%@",_mainModel.collocation_name2];
    
    [self gettitle:heardImgView Name1:name1 Name2:name2];
    
    UILabel *timelable = [[UILabel alloc]initWithFrame:CGRectMake(0, ZOOM6(350), kScreenWidth, ZOOM6(30))];
    NSString *addtime = [MyMD5 getTimeToShowWithTimestampHour:[NSString stringWithFormat:@"%@",_mainModel.add_time]];
    timelable.text = addtime;
    timelable.textAlignment = NSTextAlignmentCenter;
    timelable.font = [UIFont systemFontOfSize:ZOOM6(28)];
    timelable.textColor = [UIColor whiteColor];
    [heardImgView addSubview:timelable];

    UILabel *discriptionlab = [[UILabel alloc]initWithFrame:CGRectMake(ZOOM6(20), CGRectGetMaxY(heardImgView.frame), kScreenWidth-ZOOM6(20)*2, heigh)];
    discriptionlab.numberOfLines = 0;
    discriptionlab.textColor = RGBCOLOR_I(62, 62, 62);
    discriptionlab.font = [UIFont systemFontOfSize:ZOOM6(28)];
    NSString *title = [NSString stringWithFormat:@"%@",_mainModel.collocation_remark];
    title = [title stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    discriptionlab.text = [NSString stringWithFormat:@"%@",title];
    [headview addSubview:discriptionlab];
    return headview;
}

- (UIView*)getSecondHeadview
{
    UIView *headview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
    headview.backgroundColor = [UIColor whiteColor];

    UILabel *lableline = [[UILabel alloc]initWithFrame:CGRectMake((kScreenWidth-ZOOM6(220))/2, 40/2, ZOOM6(220), 1)];
    lableline.backgroundColor = tarbarrossred;
    [headview addSubview:lableline];
    
    UILabel *shoplab = [[UILabel alloc]initWithFrame:CGRectMake((kScreenWidth-ZOOM6(160))/2, 0, ZOOM6(160), CGRectGetHeight(headview.frame))];
    shoplab.backgroundColor = [UIColor whiteColor];
    shoplab.text = @"热门推荐";
    shoplab.textColor = RGBCOLOR_I(255, 63, 139);
    shoplab.font = [UIFont systemFontOfSize:ZOOM6(30)];
    shoplab.textAlignment = NSTextAlignmentCenter;
    [headview addSubview:shoplab];
    
    return headview;
}
//列表尾
- (UIView*)footView
{
    int count = (int)_mainModel.collocationList.count;
    CGFloat heigh = 0;
    if(count >=0)
    {
        if(count != 0)
        {
            heigh = (_footHeigh-ceil(ZOOM6(100))-ceil(ZOOM6(150))) / count;
        }
        UIView *footview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, _footHeigh)];
        footview.backgroundColor = [UIColor whiteColor];
        
        UILabel *moreSpecialView = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, ceil(ZOOM6(100)))];
        moreSpecialView.backgroundColor = [UIColor whiteColor];
        moreSpecialView.userInteractionEnabled = YES;
        moreSpecialView.clipsToBounds = YES;
        [footview addSubview:moreSpecialView];
        
        if(_model != nil)
        {
            UILabel *lableline = [[UILabel alloc]initWithFrame:CGRectMake((kScreenWidth-ZOOM6(220))/2, ZOOM6(100)/2, ZOOM6(220), 1)];
            lableline.backgroundColor = tarbarrossred;
            [moreSpecialView addSubview:lableline];
            
            UILabel *shoplab = [[UILabel alloc]initWithFrame:CGRectMake((kScreenWidth-ZOOM6(160))/2, 0, ZOOM6(160), CGRectGetHeight(moreSpecialView.frame))];
            shoplab.backgroundColor = [UIColor whiteColor];
            shoplab.text = @"更多专题";
            shoplab.textColor = RGBCOLOR_I(255, 63, 139);
            shoplab.font = [UIFont systemFontOfSize:ZOOM6(30)];
            shoplab.textAlignment = NSTextAlignmentCenter;
            [moreSpecialView addSubview:shoplab];
            
            UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            button.frame = CGRectMake((kScreenWidth-ZOOM6(320))/2, _footHeigh-ZOOM6(150)+ZOOM6(30), ZOOM6(320), ZOOM6(88));
            [button setTitle:@"查看更多专题" forState:UIControlStateNormal];
            [button setTintColor:[UIColor whiteColor]];
            [button setBackgroundColor:tarbarrossred];
            button.layer.cornerRadius = ZOOM6(8);
            button.titleLabel.font = [UIFont systemFontOfSize:ZOOM6(36)];
            [footview addSubview:button];
            
            [button addTarget:self action:@selector(moreclick) forControlEvents:UIControlEventTouchUpInside];
        }

        for(int i = 0 ;i<count;i++)
        {
            SpecialCollocationModel *collocationModel = _mainModel.collocationList[i];
            
            UIImageView *imageview = [[UIImageView alloc]initWithFrame:CGRectMake(0, heigh*i+CGRectGetHeight(moreSpecialView.frame), kScreenWidth, heigh-ZOOM6(20))];
            imageview.tag = 30000+i;
            
            NSString *imgstr = collocationModel.collocation_pic;
            imageview.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin;
            imageview.contentMode = UIViewContentModeScaleAspectFill;
            imageview.clipsToBounds = YES;
            [imageview sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[NSNumber baseURLStr_Upy],imgstr]] placeholderImage:DefaultImg(imageview.size)];
            
            [footview addSubview:imageview];
            
            NSString *name1 = collocationModel.collocation_name;
            NSString *name2 = collocationModel.collocation_name2;
            [self gettitle:imageview Name1:name1 Name2:name2];
            
            imageview.userInteractionEnabled = YES;
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(morespecial:)];
            [imageview addGestureRecognizer:tap];
        }

        return footview;
    }
    return nil;
}

#pragma mark 专题
- (void)morespecial:(UITapGestureRecognizer*)tap
{
    int tag = tap.view.tag %30000;
    
    SpecialDetailViewController *special = [[SpecialDetailViewController alloc]init];
    SpecialCollocationModel *specialcollocaModel = _mainModel.collocationList[tag];
    if(specialcollocaModel != nil)
    {
        special.collocationCode = specialcollocaModel.collocation_code;
        
        CollocationModel *collocationmodel = [CollocationModel alloc];
        collocationmodel.collocation_pic = specialcollocaModel.collocation_pic;
        collocationmodel.collocation_name = specialcollocaModel.collocation_name;
        collocationmodel.collocation_name2 = specialcollocaModel.collocation_name2;
        
        special.collcationModel = collocationmodel;
        
        if([self.stringtype isEqualToString:@"签到领现金"])
        {
            /**< 签到新增 */
            special.stringtype = self.stringtype;
            special.rewardType = self.rewardType;
            special.rewardValue = self.rewardValue;
            special.Browsedic = self.Browsedic;
            special.currTimeCount = self.currTimeCount;
            special.showGetMoneyWindow = self.showGetMoneyWindow;
            special.browseCount = self.browseCount;
            special.index_id = self.index_id;
            special.index_day = self.index_day;
            special.rewardCount = self.rewardCount;
            
        }
    }
    [self.navigationController pushViewController:special animated:YES];
}
#pragma mark 更多专题
- (void)moreclick
{
    if (self.isMoreTopVC) {
        [self.navigationController popViewControllerAnimated:YES];
        return;
    }
    MyLog(@"更多");
    TFMoreTopicsVC *vc = [[TFMoreTopicsVC alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    
}
#pragma mark collectionViewDatasouce
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if(section == 0)
    {
        return self.shopList.count;
    }else{
        return self.RecommendList.count;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    WaterFlowCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"WATERFLOWCELLID" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    cell.bottomView_new.layer.borderWidth = 1;
    cell.bottomView_new.layer.borderColor = kBackgroundColor.CGColor;
    cell.selectBtn.hidden = YES;
    
    if(indexPath.section==0)
    {
        if(self.shopList.count)
        {
            SpecialShopModel *shopModel = self.shopList[indexPath.item];
            [cell receiveDataModel2:shopModel];
        }
    }else{
        if(self.RecommendList.count)
        {
            SpecialShopModel *shopModel = self.RecommendList[indexPath.item];
            [cell receiveDataModel2:shopModel];
        }
    }
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        
        _headerView =(CollectionHeaderView *)[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView" forIndexPath:indexPath];
        if(indexPath.section==0)
        {
            [_headerView addSubview:[self headview]];
        }else{
            for (UIView *view in _headerView.subviews) {
                [view removeFromSuperview];
            }
            [_headerView addSubview:[self getSecondHeadview]];
        }
        return _headerView;
    }else{
        
        _footView =(CollectionHeaderView *)[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"FooterView" forIndexPath:indexPath];
        if(indexPath.section==0)
        {
            [_footView addSubview:[self footView]];
        }else{
            for (UIView *view in _footView.subviews) {
                [view removeFromSuperview];
            }
        }
        return _footView;
    }
}

#pragma mark FJWaterfallFlowLayoutDelegate
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(FJWaterfallFlowLayout*)collectionViewLayout heightForWidth:(CGFloat)width atIndexPath:(NSIndexPath*)indexPath
{
    CGFloat imgH = 900;
    CGFloat imgW = 600;
    
    CGFloat W = (kScreenWidth-15)/2.0;
    CGFloat H = imgH*W/imgW;
    
    return H+5;
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(FJWaterfallFlowLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    
    if(section == 0)
    {
        NSString *title = [NSString stringWithFormat:@"%@",_mainModel.collocation_remark];
        title = [title stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        CGFloat heigh = [self getRowHeight:title fontSize:ZOOM6(28)]+ZOOM6(40);
        
        if(heigh > ZOOM6(30))
        {
            _moveHeigh = ceil(ZOOM6(500))+ceil(heigh);
        }else{
            _moveHeigh = ceil(HEAD_VIEWHEIGH);
        }
        
        return CGSizeMake(CGRectGetWidth(self.view.frame), _moveHeigh);
    }else{
        return CGSizeMake(CGRectGetWidth(self.view.frame), 40);
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(FJWaterfallFlowLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    if(section==0)
    {
        int count = (int)_mainModel.collocationList.count;
        if(count == 0)
        {
            _footHeigh = ceil(ZOOM6(100))+ceil(ZOOM6(150));
        }else{
            if(count < 4)
            {
                _footHeigh = (ceil(ZOOM6(500))+ceil(ZOOM6(20)))*count+ceil(ZOOM6(100))+ceil(ZOOM6(150));
            }else{
                _footHeigh = ceil(FOOT_VIEWHEIGH);
            }
        }
        return CGSizeMake(CGRectGetWidth(self.view.frame), _footHeigh);
    }else{
        return CGSizeMake(CGRectGetWidth(self.view.frame), 0);
    }
}

#pragma mark - UICollectionViewDelegate
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    SpecialShopModel *model ;
    if(indexPath.section == 0)
    {
        model = self.shopList[indexPath.item];
    }else{
        model = self.RecommendList[indexPath.item];
    }
    
    ShopDetailViewController *detail=[[ShopDetailViewController alloc] init];
    
    if([self.stringtype isEqualToString:@"签到领现金"])
    {
        /**< 签到新增 */
        detail.stringtype = self.stringtype;
        detail.rewardType = self.rewardType;
        detail.rewardValue = self.rewardValue;
        detail.Browsedic = self.Browsedic;
        detail.currTimeCount = self.currTimeCount;
        detail.showGetMoneyWindow = self.showGetMoneyWindow;
        detail.browseCount = self.browseCount;
        detail.index_id = self.index_id;
        detail.index_day = self.index_day;
        detail.rewardCount = self.rewardCount;
        
        kWeakSelf(self);
        detail.browseCountBlock = ^() {
            if (weakself.browseCountBlock) {
                weakself.browseCountBlock(model.shop_code);
            }
        };
    }else{
        detail.stringtype = @"订单详情";
    }

    detail.shop_code = model.shop_code;
    [self.navigationController pushViewController:detail animated:YES];
}

//返回这个UICollectionView是否可以被选择
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
#pragma mark *****************网络*******************
- (void)creatData
{
    [SpecialDetailModel getSpecialDetailData:self.collocationCode Success:^(id data) {
        [self.collectionView headerEndRefreshing];
        [self.collectionView ffRefreshHeaderEndRefreshing];
    
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        _model = data;
        if(_model.status == 1)
        {
            _mainModel = (SpecialMainModel*)_model.shop;
            self.shopList = _mainModel.shopList;
            [self.collectionView reloadData];

        }else{
            if(_model.status != 10030)
            {
                [MBProgressHUD show:@"网络开小差,请检查网络~" icon:nil view:nil];
                [self loadingDataBackgroundView:self.collectionView img:[UIImage imageNamed:@"哭脸"] text:@"亲,没网了"];
            }
        }
    }];
    
}

- (void)creatTuijianData
{
    [SpecialDetailModel getSpecialDetailData:self.collocationCode Success:^(id data) {
        
        [self.collectionView footerEndRefreshing];
        [self.collectionView ffRefreshHeaderEndRefreshing];
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        _model = data;
        if(_model.status == 1)
        {
            _mainModel = (SpecialMainModel*)_model.shop;
            [self.RecommendList addObjectsFromArray:_mainModel.shopList];
            [self.collectionView reloadData];
            
        }else{
            if(_model.status != 10030)
            {
                [MBProgressHUD show:@"网络开小差,请检查网络~" icon:nil view:nil];
                [self loadingDataBackgroundView:self.collectionView img:[UIImage imageNamed:@"哭脸"] text:@"亲,没网了"];
            }
        }
    }];

}

- (void)httpGetDataSource
{
    if(self.currPage == 0)
    {
        self.currPage = 1;
    }

    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *token = [ud objectForKey:USER_TOKEN];
    NSString *urlStr;
    if (token != nil) {
       
        urlStr = [NSString stringWithFormat:@"%@shop/queryCondition?token=%@&version=%@&pager.curPage=%d&pager.pageSize=10&notType=true&pager.sort=actual_sales&pager.sort=actual_sales",[NSObject baseURLStr],token,VERSION,(int)self.currPage];
        
    } else {
        
        urlStr = [NSString stringWithFormat:@"%@shop/queryConUnLogin?version=%@&pager.curPage=%d&pager.pageSize=10&notType=true&pager.sort=actual_sales&pager.sort=actual_sales",[NSObject baseURLStr],VERSION,(int)self.currPage];
    }
    
    NSString *URL = [MyMD5 authkey:urlStr];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:URL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        responseObject = [NSDictionary changeType:responseObject];
        [self.collectionView footerEndRefreshing];   //停止刷新
        [self.collectionView headerEndRefreshing];   //停止刷新
        [self.collectionView ffRefreshHeaderEndRefreshing];
        
        NSLog(@"url = %@",urlStr);
        NSLog(@"responseObject = %@",responseObject);
        
        if (responseObject!=nil) {
            if ([responseObject[@"status"] intValue] == 1) {
                self.currPage ++;
                NSArray *dataArr = responseObject[@"listShop"];
                for (NSDictionary *dic in dataArr) {
                    ShopDetailModel *sModel = [[ShopDetailModel alloc] init];
                    [sModel setValuesForKeysWithDictionary:dic];
                    [self.RecommendList addObject:sModel];
                }
                
                [self.collectionView reloadData];
            } else {
                [MBProgressHUD showError:responseObject[@"message"]];
            }
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self.collectionView footerEndRefreshing];   //停止刷新
        [self.collectionView headerEndRefreshing];   //停止刷新
        [self.collectionView ffRefreshHeaderEndRefreshing];
        
        NavgationbarView *mentionview=[[NavgationbarView alloc]init];
        [mentionview showLable:@"网络开小差啦,请检查网络" Controller:self];
    }];

}

#pragma mark 获取文字高度
-(CGFloat)getRowHeight:(NSString *)text fontSize:(CGFloat)fontSize
{
    text = [text stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    text = [text stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    
    //文字高度
    CGFloat height;
    if([[[UIDevice currentDevice]systemVersion] floatValue]>=7.0){
        
        CGRect rect=[text boundingRectWithSize:CGSizeMake(kScreenWidth-2*ZOOM6(20), 10000) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:fontSize] forKey:NSFontAttributeName] context:nil];
        
        height=rect.size.height;

    }
    return height;
}


- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (NSMutableArray*)RecommendList
{
    if(_RecommendList==nil)
    {
        _RecommendList = [NSMutableArray array];
    }
    return _RecommendList;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
