//
//  FightgroupsViewController.m
//  YunShangShiJi
//
//  Created by ios-1 on 2017/7/8.
//  Copyright © 2017年 ios-1. All rights reserved.
//

#import "FightgroupsViewController.h"
#import "CollectionHeaderView.h"
#import "TFBrowseShopVM.h"
#import "WaterFLayout.h"
#import "WaterFlowCell.h"
#import "ShopDetailViewController.h"
#import "TFPopBackgroundView.h"
#import "TFGroupBuysVC.h"
#import "SpecialShopModel.h"
#import "FJWaterfallFlowLayout.h"
#import "SpecialDetailModel.h"
#import "TFShoppingM.h"
#import "GroupBuyDetailVC.h"
@interface FightgroupsViewController ()<FJWaterfallFlowLayoutDelegate>
@property (nonatomic, strong) TFBrowseShopVM *shopVM;
@property (nonatomic, assign) NSInteger currPage;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UIView *headerView;

@end
#define IMAGEHEIGH kScreenWidth*0.57
@implementation FightgroupsViewController
{
    CGFloat _tableviewHeigh;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavigationItemLeft:@"拼团商品专区"];
    
    [self setupUI];
    
    [self setData];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if([DataManager sharedManager].fightData.count == 1)
    {
//        NavgationbarView *mentinview = [[NavgationbarView alloc]init];
//        [mentinview showLable:@"超级拼团购9块9可选两件，你还可以\n再选一件" Controller:self];
    }else if ([DataManager sharedManager].fightData.count == 2)
    {
        [[DataManager sharedManager].fightData removeObjectAtIndex:1];
    }
}
- (void)setData
{
    self.currPage = 1;
    [self httpData];
    
    [self httpActivityRule];
    
    [self reloadDataBlock:^{
        [self httpData];
    }];
}
- (void)disccriptionData
{
//    NSString *str2 = [NSString stringWithFormat:@"2、获得超级拼团购资格的用户，团长和团员均可在衣蝠当天的100款活动商品中%@，享受%@的价格。再也不怕和好友撞衫啦。",self.discripfindArray[0],self.discripfindArray[1]];
//    NSString *str5 = [NSString stringWithFormat:@"5、所有参团用户也是在衣蝠当天的%@，再也不怕和好友们撞衫啦。开团后快把这个超级福利告诉朋友们，邀请她们来参团吧。",self.discripfindArray[3]];
    [self.discripfindArray addObject:@"开团与参团均无需付款，团满后即视为拼团成功，需在规定时间内完成付款，逾期即视为拼团失败。"];


    NSString *str2 = [NSString stringWithFormat:@"2、获得超级拼团购资格的用户，团长和团员均可在衣蝠当天的%@。再也不怕和好友撞衫啦。",self.discripfindArray[0]];
    NSArray *dataArr = @[@"1、超级拼团购是衣蝠给用户的超级福利。恭喜你被砸中了。",
                         str2,
                         @"3、所有商品均为一线快时尚女装品牌制造商生产。均为正价商品参与活动。",
                         @"4、超级拼团购仅限未在衣蝠购物的新用户参团哦。",
                         @"5、开团与参团均无需付款，团满后即视为拼团成功，需在规定时间内完成付款，逾期即视为拼团失败。拼团费会在5-7个工作日内返还至付款账号，0风险。",
                         @"6、本次活动真实有效，最终解释权归衣蝠所有。"];//@[@"1、超级拼团购是衣蝠给用户的超级福利。恭喜你被砸中了。",str2,@"3、所有商品均为一线快时尚女装品牌制造商生产。均为正价商品参与活动。",@"4、超级拼团购仅限未在衣蝠购物的新用户参团哦。",str5,@"6、开团与参团都无需付款，达到拼团人数后即视为拼团成功，全体成员需在规定时间内完成付款，逾期即视为拼团失败哦。你支付的拼团费会在5-7个工作日内原路退回至付款账号，0风险。",@"7、本次活动最终解释权归衣蝠平台所有。"];//@[@"1、超级拼团购是衣蝠给用户的超级福利。恭喜你被砸中了。",str2,@"3、所有商品均为一线快时尚女装品牌制造商生产。均为正价商品参与活动。",@"4、超级拼团购仅限未在衣蝠购物的新用户参团哦。",str5,@"6、如未达到拼团人数，你支付的拼团费会在5-7个工作日内原路退回至付款账号，0风险。",@"7、本次活动最终解释权归衣蝠平台所有。"];

    [self.discriptionArray addObjectsFromArray:dataArr];
    
    for(NSString *str in self.discriptionArray)
    {
        CGFloat heigh = [self getRowHeight:str fontSize:ZOOM6(26)];
        _tableviewHeigh += (heigh+10);
    }
    _tableviewHeigh += (kScreenWidth*0.57+ZOOM6(20));
    
    self.discriptionTalbeView.frame = CGRectMake(-ZOOM6(20), 0, CGRectGetWidth(_headerView.frame)+ZOOM6(20)*2, _tableviewHeigh);
    [self.discriptionTalbeView reloadData];
    [self.collectionView reloadData];
}

#pragma mark ***********************网络请求*********************
//拼团规则
- (void)httpActivityRule {

    NSString *url= [NSString stringWithFormat:@"%@paperwork/paperwork.json",[NSObject baseURLStr_Upy]];

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer.cachePolicy = NSURLRequestReloadIgnoringLocalCacheData;

    kSelfWeak;
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (responseObject!=nil) {

            if(responseObject[@"ptgwn"][@"n1"] != nil)
            {
                [weakSelf.discripfindArray addObject:[NSString stringWithFormat:@"100款活动商品中%@，享受9块9包邮的价格",responseObject[@"ptgwn"][@"n1"]]];
            }else{
                [weakSelf.discripfindArray addObject:@"100款活动商品中任选2件，享受9块9包邮的价格"];
            }
            /*
            if(responseObject[@"ptgwn"][@"n2"] != nil)
            {
                [weakSelf.discripfindArray addObject:responseObject[@"ptgwn"][@"n2"]];
            }else{
                [weakSelf.discripfindArray addObject:@"9块9包邮"];
            }
            if(responseObject[@"ptgwn"][@"n3"] != nil)
            {
                [weakSelf.discripfindArray addObject:responseObject[@"ptgwn"][@"n3"]];
            }else{
                [weakSelf.discripfindArray addObject:@"两件9块9包邮"];
            }
            if(responseObject[@"ptgwn"][@"n4"] != nil)
            {
                [weakSelf.discripfindArray addObject:responseObject[@"ptgwn"][@"n4"]];
            }

            //                [self.discripfindArray addObject:@"，享受9块9包邮的价格，"];
            [weakSelf.discripfindArray addObject:@"开团后快把这个超级福利告诉朋友们，邀请她们来参团吧。"];
            [weakSelf.discripfindArray addObject:@"5-7个工作日内原路退回至付款账号"];
            */
        }
//        if(weakSelf.discripfindArray.count >=4)
//        {
      

            [weakSelf disccriptionData];
//        }
    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {

    }];

    /*
    [[APIClient sharedManager]netWorkGeneralRequestWithApi:@"signIn2_0/queryText?" caches:NO cachesTimeInterval:0 token:YES success:^(id data, Response *response) {
        if (response.status == 1) {
            
            NSDictionary *responseDic=data;
            
            NSString *str2=responseDic[@"ptgwn"];
            NSData *jsonData2 = [str2 dataUsingEncoding:NSUTF8StringEncoding];
            NSError *err2;
            NSDictionary *dic2 = [NSJSONSerialization JSONObjectWithData:jsonData2
                                                                 options:NSJSONReadingMutableContainers
                                                                   error:&err2];
            if(dic2 != nil)
            {
                if(dic2[@"n1"] != nil)
                {
                    [self.discripfindArray addObject:dic2[@"n1"]];
                }else{
                    [self.discripfindArray addObject:@"任选2件"];
                }
                if(dic2[@"n2"] != nil)
                {
                    [self.discripfindArray addObject:dic2[@"n2"]];
                }else{
                    [self.discripfindArray addObject:@"9块9包邮"];
                }
                if(dic2[@"n3"] != nil)
                {
                    [self.discripfindArray addObject:dic2[@"n3"]];
                }else{
                    [self.discripfindArray addObject:@"两件9块9包邮"];
                }
                if(dic2[@"n4"] != nil)
                {
                    [self.discripfindArray addObject:dic2[@"n4"]];
                }
                
//                [self.discripfindArray addObject:@"，享受9块9包邮的价格，"];
                [self.discripfindArray addObject:@"开团后快把这个超级福利告诉朋友们，邀请她们来参团吧。"];
                [self.discripfindArray addObject:@"5-7个工作日内原路退回至付款账号"];
            }
        }
        
        if(self.discripfindArray.count >=4)
        {
            [self disccriptionData];
        }
    } failure:^(NSError *error) {
        
    }];
     */
}
//列表数据
- (void)httpData
{
    [self.shopVM handleActivityShopDataWithFromPageNum:10 curPager:self.currPage success:^(NSArray *modelArray, Response *response) {
        [self.collectionView headerEndRefreshing];
        [self.collectionView footerEndRefreshing];
        if (response.status == 1) {
            if (self.currPage == 1) {
                [self.shopVM.service.dataSource removeAllObjects];
            }
            //加载成功
            [self.shopVM.service.dataSource addObjectsFromArray:modelArray];
            
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
}

#pragma mark ***********************UI界面*********************
- (void)setupUI
{
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.navigationView.mas_bottom);
        make.left.right.bottom.equalTo(self.view);
    }];
    
    UIButton *goBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [goBtn setBackgroundImage:[UIImage imageNamed:@"ptxq_go"] forState:UIControlStateNormal];
    goBtn.tag = 100;
    [goBtn handleClickEvent:UIControlEventTouchUpInside withClickBlock:^(UIButton *sender) {
        
        GroupBuyDetailVC *vc = [[GroupBuyDetailVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }];
    [self.view addSubview:goBtn];
    [goBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(ZOOM6(140), ZOOM6(140)));
        make.right.equalTo(self.view.mas_right).offset(-ZOOM6(20));
        make.bottom.equalTo(self.view.mas_top).offset(+ZOOM6(580));
    }];
}

- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        
        FJWaterfallFlowLayout *fjWaterfallFlowLayout = [[FJWaterfallFlowLayout alloc] init];
        fjWaterfallFlowLayout.itemSpacing = 5;
        fjWaterfallFlowLayout.lineSpacing = 0;
        fjWaterfallFlowLayout.sectionInset = UIEdgeInsetsMake(0, 5, 0, 5);
        fjWaterfallFlowLayout.colCount = 2;
        fjWaterfallFlowLayout.delegate = self;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, Height_NavBar, kScreenWidth, kScreenHeight-Height_NavBar) collectionViewLayout:fjWaterfallFlowLayout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [self.view addSubview:_collectionView];
        
        [_collectionView registerNib:[UINib nibWithNibName:@"WaterFlowCell" bundle:nil] forCellWithReuseIdentifier:@"WATERFLOWCELLID"];
        
        [_collectionView registerClass:[CollectionHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView"];
        
        [_collectionView registerClass:[CollectionHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"FooterView"];
        //下拉刷新
        kWeakSelf(self);
        [_collectionView addHeaderWithCallback:^{
            weakself.currPage = 1;
            [weakself httpData];
        }];
        
        //上拉加载
        [_collectionView addFooterWithCallback:^{
            weakself.currPage ++;
            [weakself httpData];
        }];
        
    }
    return _collectionView;
}

- (UIView*)headerView
{
    if(_headerView == nil)
    {
        _headerView = [[UIView alloc]init];
        _headerView.frame = CGRectMake(0, 0, kScreenWidth, _tableviewHeigh);
        
        [_headerView addSubview:self.discriptionTalbeView];
    }
    return _headerView;
}

- (UITableView *)discriptionTalbeView
{
    if(!_discriptionTalbeView)
    {
        _discriptionTalbeView = [[UITableView alloc]initWithFrame:CGRectMake(-ZOOM6(20), 0, CGRectGetWidth(_headerView.frame)+ZOOM6(20)*2, CGRectGetHeight(_headerView.frame)) style:UITableViewStylePlain];
        _discriptionTalbeView.backgroundColor = RGBCOLOR_I(242, 24, 64);
        _discriptionTalbeView.tableHeaderView = self.tableHeadView;
        _discriptionTalbeView.separatorStyle = UITableViewCellSelectionStyleNone;
        _discriptionTalbeView.scrollEnabled = NO;
        _discriptionTalbeView.delegate = self;
        _discriptionTalbeView.dataSource = self;
    }
    return _discriptionTalbeView;
}

- (UIImageView *)tableHeadView
{
    if(_tableHeadView == nil)
    {
        _tableHeadView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, IMAGEHEIGH)];
        _tableHeadView.image = [UIImage imageNamed:@"fight_bg_pt"];
        _tableHeadView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _tableHeadView;
}

#pragma mark collectionViewDatasouce
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.shopVM.service.dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    WaterFlowCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"WATERFLOWCELLID" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    cell.bottomView_new.layer.borderWidth = 1;
    cell.bottomView_new.layer.borderColor = kBackgroundColor.CGColor;
    cell.selectBtn.hidden = YES;
    
    TFShoppingM *model = self.shopVM.service.dataSource[indexPath.item];
    if(self.shopVM.service.dataSource.count)
    {
        [cell receiveDataModel5:model];
    }
    
    kWeakSelf(self);
    cell.selectBlock = ^{
        model.isSelect = NO;
        [weakself.collectionView reloadData];
        [[DataManager sharedManager].fightData removeAllObjects];
    };

    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    TFShoppingM *shopmodel = self.shopVM.service.dataSource[indexPath.item];
    
    ShopDetailViewController *detail = [[ShopDetailViewController alloc]init];
    detail.shop_code = shopmodel.shop_code;
    detail.stringtype = @"活动商品";
    detail.browseCount = -1;
    detail.isFight = YES;
    kWeakSelf(self)
    detail.FightselectBlock = ^{
        
        if([DataManager sharedManager].fightData.count == 1)
        {
            NavgationbarView *mentinview = [[NavgationbarView alloc]init];
            [mentinview showLable:@"超级拼团购9块9可选两件，你还可以\n再选一件" Controller:self];
        }
        
        shopmodel.isSelect = YES;
        [weakself.collectionView reloadData];
    };
    detail.FightBackBlock = ^{
        if([DataManager sharedManager].fightData.count == 1)
        {
            NavgationbarView *mentinview = [[NavgationbarView alloc]init];
            [mentinview showLable:@"超级拼团购9块9可选两件，你还可以\n再选一件" Controller:self];
        }
    };
    [self.navigationController pushViewController:detail animated:YES];
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

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        
        CollectionHeaderView *headerView =(CollectionHeaderView *)[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView" forIndexPath:indexPath];
        
        [headerView addSubview:self.headerView];
        
        return headerView;
    }else{
        CollectionHeaderView *footView =(CollectionHeaderView *)[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"FooterView" forIndexPath:indexPath];
        return footView;
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(FJWaterfallFlowLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{

    return CGSizeMake(CGRectGetWidth(self.view.frame), _tableviewHeigh);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(FJWaterfallFlowLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    return CGSizeZero;
}

#pragma mark UItabaleViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *str = self.discriptionArray[indexPath.row];
    CGFloat heigh = [self getRowHeight:str fontSize:ZOOM6(26)];
    return heigh+10;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.discriptionArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if(!cell)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.text = self.discriptionArray[indexPath.row];
    cell.textLabel.numberOfLines = 0;
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.textLabel.font = [UIFont systemFontOfSize:ZOOM6(26)];

    if(indexPath.row == 1 || indexPath.row == 4)// || indexPath.row == 5)
    {
        NSMutableAttributedString *noteStr ;
        if(cell.textLabel.text)
        {
            noteStr = [[NSMutableAttributedString alloc]initWithString:cell.textLabel.text];
        }
        for(int i =0;i < self.discripfindArray.count; i++)
        {
            NSString *str = [NSString stringWithFormat:@"%@",self.discripfindArray[i]];
            NSRange range = [cell.textLabel.text rangeOfString:str];
            [noteStr addAttribute:NSForegroundColorAttributeName value:RGBCOLOR_I(255, 244, 0) range:NSMakeRange(range.location, range.length)];
            [noteStr addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:ZOOM6(26)] range:NSMakeRange(range.location, range.length)];
        }
        [cell.textLabel setAttributedText:noteStr];
    }
    return cell;
}

-(CGFloat)getRowHeight:(NSString *)text fontSize:(CGFloat)fontSize
{
    //文字高度
    CGFloat height = 0;
    if([[[UIDevice currentDevice]systemVersion] floatValue]>=7.0){
        
        CGRect rect=[text boundingRectWithSize:CGSizeMake(kScreenWidth-ZOOM6(20), 10000) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:fontSize] forKey:NSFontAttributeName] context:nil];
        
        height=rect.size.height;
    }
    
    return height;
}

- (TFBrowseShopVM *)shopVM
{
    if (!_shopVM) {
        _shopVM = [[TFBrowseShopVM alloc] init];
    }
    return _shopVM;
}
- (NSMutableArray *)discriptionArray
{
    if(_discriptionArray == nil)
    {
        _discriptionArray = [NSMutableArray array];
    }
    return _discriptionArray;
}
- (NSMutableArray *)discripfindArray
{
    if(_discripfindArray == nil)
    {
        _discripfindArray = [NSMutableArray array];
    }
    return _discripfindArray;
}
- (void)leftBarButtonClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
