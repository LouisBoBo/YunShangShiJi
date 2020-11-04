//
//  TFSalePurchaseFirstViewController.m
//  YunShangShiJi
//
//  Created by 云商 on 15/11/27.
//  Copyright © 2015年 ios-1. All rights reserved.
//

#import "TFSalePurchaseFirstViewController.h"
#import "SalePurchaseShopListCell.h"
#import "SalePurchasePListCell.h"
#import "SalePListModel.h"
#import "SaleShopListModel.h"
#import "SaleFootModel.h"
#import "SaleHaedModel.h"
#import "SalePurchaseHeadCell.h"
//#import "ComboShopDetailViewController.h"
#import "PListModel.h"
#import "ShopListSingle.h"
#import "ShopListPackage.h"
#import "AppDelegate.h"
@interface TFSalePurchaseFirstViewController () <UITableViewDataSource, UITableViewDelegate>
{
    int currIndex;
}
@property (nonatomic, assign)NSInteger page;

@end

@implementation TFSalePurchaseFirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self getData];

    
}

- (void)getData
{
    self.page = 1;
    
    UIScrollView *supScroll = (UIScrollView *)self.tableView.superview;
    int index = supScroll.contentOffset.x/kScreenWidth;
    currIndex = index;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSObject *model = self.dataArr[indexPath.row];
    if ([model isKindOfClass:[SaleShopListModel class]]) {
        return ZOOM(450);
    } else if ([model isKindOfClass:[SalePListModel class]]) {
        return ZOOM(100);
    } else if ([model isKindOfClass:[SaleFootModel class]]) {
        return ZOOM(45);
    } else if ([model isKindOfClass:[SaleHaedModel class]]) {
        return ZOOM(100);
    } else if ([model isKindOfClass:[PListModel class]]) {
        if (self.myChoose == ChooseBuyPackage) {
            return [ShopListPackage cellHeight];
        } else {
            return [ShopListSingle cellHeight];
        }
    }
    return 0;
    
}
-(void)viewDidLayoutSubviews
{
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsMake(0,0,0,0)];
    }
    
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.tableView setLayoutMargins:UIEdgeInsetsMake(0,0,0,0)];
    }
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataArr count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSObject *model = self.dataArr[indexPath.row];
    if ([model isKindOfClass:[SaleShopListModel class]]) {
        SalePurchaseShopListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SALESHOPLIST"];
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.separatorInset = UIEdgeInsetsMake(0, kScreenWidth, 0, 0);
        
        NSObject *model2 = self.dataArr[indexPath.row-1];
        
        if ([model2 isKindOfClass:[SalePListModel class]]) {
            cell.packageLabel.hidden = NO;
        } else {
            cell.packageLabel.hidden = YES;
        }
        
        cell.type = self.type;
        [cell receiveDataModel:self.dataArr[indexPath.row]];
        
        return cell;

    } else if ([model isKindOfClass:[SalePListModel class]]) {
        SalePurchasePListCell *cell =  [tableView dequeueReusableCellWithIdentifier:@"SALEPLIST"];
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.separatorInset = UIEdgeInsetsMake(0, kScreenWidth, 0, 0);
        
        cell.type = self.type;
       [cell receiveDataModel:self.dataArr[indexPath.row]];
        return cell;
    
    } else if ([model isKindOfClass:[SaleFootModel class]]) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FootID"];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"FootID"];
//            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.separatorInset = UIEdgeInsetsMake(0, kScreenWidth, 0, 0);
            
        }
        cell.backgroundColor = [UIColor whiteColor];
        return cell;
    } else if ([model isKindOfClass:[SaleHaedModel class]]) {
        SalePurchaseHeadCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SALEHEADCELL"];
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.type = self.type;
        
//        if (self.myChoose == ChooseBuySingle) {
//            cell.leftBtn.selected = YES;
//            cell.rightBtn.selected = NO;
//        } else {
//            cell.leftBtn.selected = NO;
//            cell.rightBtn.selected = YES;
//        }
        
//        [cell.leftBtn addTarget:self action:@selector(leftBtnClick:) forControlEvents:UIControlEventTouchUpInside];
//        [cell.rightBtn addTarget:self action:@selector(rightBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        cell.separatorInset = UIEdgeInsetsMake(0, kScreenWidth, 0, 0);
        return cell;
    } else if ([model isKindOfClass:[PListModel class]]) {
        
        if (self.myChoose == ChooseBuyPackage) {
            ShopListPackage *cell = [tableView dequeueReusableCellWithIdentifier:@"ShopListPackageCell"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
                [cell setSeparatorInset:UIEdgeInsetsMake(0, kScreenWidth, 0, 0)];
            }
            
            if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
                [cell setSeparatorInset:UIEdgeInsetsMake(0, kScreenWidth, 0, 0)];
            }
            
            cell.goShopDetailBlock = ^() {
                PListModel *modelTemp = (PListModel *)model;
                [self pushShopDetailVC:modelTemp];
            };
            
            [cell receiveDataModel:(PListModel *)model];
            
            return cell;
        } else {
            
            ShopListSingle *cell = [tableView dequeueReusableCellWithIdentifier:@"ShopListSingleCell"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            self.tableView.separatorColor = RGBCOLOR_I(229, 229, 299);
            cell.goShopDetailBlock = ^() {
                PListModel *modelTemp = (PListModel *)model;
                [self pushShopDetailVC:modelTemp];
            };
            
            if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
                [cell setSeparatorInset:UIEdgeInsetsZero];
            }
            
            if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
                [cell setLayoutMargins:UIEdgeInsetsZero];
            }
            
            [cell receiveDataModel:(PListModel *)model];
            
            return cell;
        }
        
        
    }
    
    return 0;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSObject *model = self.dataArr[indexPath.row];
//    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if ([model isKindOfClass:[SaleShopListModel class]]) {
        
//        SaleShopListModel *modelTemp = (SaleShopListModel *)model;
//        ComboShopDetailViewController *detail=[[ComboShopDetailViewController alloc] initWithNibName:@"ComboShopDetailViewController" bundle:nil];
//        detail.shop_code = modelTemp.pModel.code;
//        detail.hidesBottomBarWhenPushed = YES;
//        [self.navigationController pushViewController:detail animated:YES];
    } else if ([model isKindOfClass:[PListModel class]]) {
        PListModel *modelTemp = (PListModel *)model;
        [self pushShopDetailVC:modelTemp];
    }
}

- (void)pushShopDetailVC:(PListModel *)model
{
//    ComboShopDetailViewController *detail=[[ComboShopDetailViewController alloc] initWithNibName:@"ComboShopDetailViewController" bundle:nil];
//    detail.shop_code = model.code;
//    detail.r_num = model.r_num;
//    detail.p_status = model.p_status;
//    detail.isSaleOut = model.isSaleOut;
//    detail.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:detail animated:YES];
}

- (UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 20, kScreenWidth, kScreenHeight-20)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = RGBCOLOR_I(240, 240, 240);
        _tableView.separatorColor = RGBCOLOR_I(229, 229, 299);
        UIView *footView = [[UIView alloc] init];
        footView.backgroundColor = [UIColor whiteColor];
        _tableView.tableFooterView = footView;
        [_tableView registerNib:[UINib nibWithNibName:@"SalePurchaseShopListCell" bundle:nil] forCellReuseIdentifier:@"SALESHOPLIST"];
        
        [_tableView registerNib:[UINib nibWithNibName:@"SalePurchasePListCell" bundle:nil] forCellReuseIdentifier:@"SALEPLIST"];
        
        [_tableView registerNib:[UINib nibWithNibName:@"SalePurchaseHeadCell" bundle:nil] forCellReuseIdentifier:@"SALEHEADCELL"];
        
        
        [_tableView registerNib:[UINib nibWithNibName:@"ShopListPackage" bundle:nil] forCellReuseIdentifier:@"ShopListPackageCell"];
        
        [_tableView registerNib:[UINib nibWithNibName:@"ShopListSingle" bundle:nil] forCellReuseIdentifier:@"ShopListSingleCell"];
        
        [self.view addSubview:_tableView];
        
        _tableView.topLoadHeight = [NSNumber numberWithFloat:self.headHeight];

         [_tableView addTopTarget:self andAction:@selector(headRefreshData) withView:nil];
        __weak TFSalePurchaseFirstViewController *ssc = self;
        
        [_tableView addFooterWithCallback:^{
            ssc.page++;
            
            if (ssc.myChoose == ChooseBuyPackage) {
                [ssc httpGetSalePackageData];
            } else {
                [ssc httpGetSaleSingleData];
            }
            
        }];
        
        
    }
    return _tableView;
    
}

- (void)headRefreshData
{
    self.page = 1;
//    [self httpGetSalePackageData];
    
    if (self.myChoose == ChooseBuyPackage) {
        [self httpGetSalePackageData];
    } else {
        [self httpGetSaleSingleData];
    }
    
    
    if (self.customDelegate!=nil && [self.customDelegate respondsToSelector:@selector(salePurchaseDownRefresh:)]) {
        
        UIScrollView *supScroll = (UIScrollView *)self.tableView.superview;
        
        [self.customDelegate salePurchaseDownRefresh:supScroll.contentOffset.x/kScreenWidth];
    }
}

- (void)httpGetSalePackageData
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    NSString *urlStr = [NSString stringWithFormat:@"%@shop/queryPackageList?version=%@&pager.curPage=%d&pager.order=%@&pager.pageSize=%@&p_type=1",[NSObject baseURLStr],VERSION,(int)self.page,@"desc",@"10"];
    NSString *URL = [MyMD5 authkey:urlStr];
    [manager POST:URL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        responseObject = [NSDictionary changeType:responseObject];
        [self.tableView ffRefreshHeaderEndRefreshing];
        [self.tableView footerEndRefreshing];
        
        if (self.page == 1) {
            [self.dataArr removeAllObjects];
        }
        MyLog(@"0元购套餐: type %@ = %@", self.type, responseObject);
        
        if (responseObject!=nil) {
            
            if ([responseObject[@"status"] intValue] == 1) {
                
                
                [NSObject saveResponseData:responseObject toPath:urlStr];
                
                [self tableViewSalePackageData:responseObject];
                
            }

        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    
        MyLog(@"请求失败error: %@", error);

        [self.tableView ffRefreshHeaderEndRefreshing];
        [self.tableView footerEndRefreshing];
        
        id responseObject = [NSObject loadResponseWithPath:urlStr];
        [self tableViewSalePackageData:responseObject];
        
    }];
}

- (void)tableViewSalePackageData:(NSDictionary *)responseObject
{
    //获取商品和套餐
    NSArray *pListArr;
    if (responseObject[@"pList"]!=nil) {
        pListArr = responseObject[@"pList"];
        
        NSMutableArray *pListMuArr = [NSMutableArray array];
        
        for (NSDictionary *dic in pListArr) {
            PListModel *pModel = [[PListModel alloc] init];
            
            pModel.ID = dic[@"id"];
            [pModel setValuesForKeysWithDictionary:dic];
            [pListMuArr addObject:pModel];
            
        }
        
        if (pListMuArr.count>=2) {
            for (int i = 0; i<pListMuArr.count-1; i++) {
                for (int j = 0; j<pListMuArr.count-i-1; j++) {
                    PListModel *PList = pListMuArr[j];
                    PListModel *PList2 = pListMuArr[j+1];
                    
                    if ([PList.seq intValue]>[PList2.seq intValue]) {
                        [pListMuArr exchangeObjectAtIndex:j withObjectAtIndex:j+1];
                    }
                }
            }
        }
        
        [self.dataArr addObjectsFromArray:pListMuArr];
        
        [self.tableView reloadData];
    }

}

- (void)tableViewSaleSingleData:(NSDictionary *)responseObject
{
    //获取商品和套餐
    NSArray *pListArr;
    
    if (responseObject[@"pList"]!=nil) {
        
        pListArr = responseObject[@"pList"];
        
        //建立套餐模型
        NSMutableArray *pListMuArr = [NSMutableArray array];
        
        for (NSDictionary *dic in pListArr) {
            PListModel *pModel = [[PListModel alloc] init];
            
            pModel.ID = dic[@"id"];
            [pModel setValuesForKeysWithDictionary:dic];
            [pListMuArr addObject:pModel];
            
        }
        
        if (pListMuArr.count>=2) {
            for (int i = 0; i<pListMuArr.count-1; i++) {
                for (int j = 0; j<pListMuArr.count-i-1; j++) {
                    PListModel *PList = pListMuArr[j];
                    PListModel *PList2 = pListMuArr[j+1];
                    
                    if ([PList.seq intValue]>[PList2.seq intValue]) {
                        [pListMuArr exchangeObjectAtIndex:j withObjectAtIndex:j+1];
                    }
                }
            }
        }
        
        [self.dataArr addObjectsFromArray:pListMuArr];
        
        [self.tableView reloadData];
        
    }

}

- (void)httpGetSaleSingleData
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    NSString *urlStr = [NSString stringWithFormat:@"%@shop/queryPackageList?version=%@&pager.curPage=%d&pager.order=%@&pager.pageSize=%@&p_type=0",[NSObject baseURLStr],VERSION, (int)self.page,@"desc",@"10"];
    NSString *URL = [MyMD5 authkey:urlStr];
    
    [manager POST:URL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        responseObject = [NSDictionary changeType:responseObject];
        [self.tableView ffRefreshHeaderEndRefreshing];
        [self.tableView footerEndRefreshing];
        
        if (self.page == 1) {
            [self.dataArr removeAllObjects];
        }
        MyLog(@"0元购单品: type %@ = %@", self.type, responseObject);
        
        if (responseObject!=nil) {
            
            if ([responseObject[@"status"] intValue] == 1) {
                
                [NSObject saveResponseData:responseObject toPath:urlStr];

                [self tableViewSaleSingleData:responseObject];
            }
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        MyLog(@"请求失败error: %@", error);
        
        [self.tableView ffRefreshHeaderEndRefreshing];
        [self.tableView footerEndRefreshing];
        
        id responseObject = [NSObject loadResponseWithPath:urlStr];
        [self tableViewSalePackageData:responseObject];
    }];
}

- (NSMutableArray *)dataArr
{
    if (_dataArr == nil) {
        _dataArr = [[NSMutableArray alloc] init];
    }
    
    return _dataArr;
}

- (void)setMyChoose:(ChooseBuy)myChoose
{
    _myChoose = myChoose;
    self.page = 1;
    if (_myChoose == ChooseBuyPackage) {
        
        [self httpGetSalePackageData];
        
    } else {
        
        [self httpGetSaleSingleData];
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if (self.customDelegate!=nil && [self.customDelegate respondsToSelector:@selector(tableViewWithScrollViewWillBeginDragging:index:)]) {
        [self.customDelegate tableViewWithScrollViewWillBeginDragging:scrollView index:currIndex];
    }
    
}


- (void)scrollViewDidEndDragging:(nonnull UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (self.customDelegate!=nil && [self.customDelegate respondsToSelector:@selector(tableViewWithScrollViewDidEndDragging:willDecelerate:index:)]) {
        [self.customDelegate tableViewWithScrollViewDidEndDragging:scrollView willDecelerate:decelerate index:currIndex];
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
    if (self.customDelegate!=nil && [self.customDelegate respondsToSelector:@selector(tableViewWithScrollViewWillBeginDecelerating:index:)]) {
        [self.customDelegate tableViewWithScrollViewWillBeginDecelerating:scrollView index:currIndex];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (self.customDelegate!=nil && [self.customDelegate respondsToSelector:@selector(tableViewWithscrollViewDidEndDecelerating:index:)]) {
        [self.customDelegate tableViewWithscrollViewDidEndDecelerating:scrollView index:currIndex];
    }
}

- (void)dealloc
{
    [self.tableView removeObserver:self.tableView forKeyPath:observerRefreshHeaderViewKeyPath context:nil];
//    [self.tableView removeFromSuperview];
//    self.tableView = nil;

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
