//
//  TFSalePurchaseTwoViewController.m
//  YunShangShiJi
//
//  Created by 云商 on 15/11/27.
//  Copyright © 2015年 ios-1. All rights reserved.
//

#import "TFSalePurchaseTwoViewController.h"

#import "SalePListModel.h"
#import "SaleShopListModel.h"
#import "SalePurchaseShopListCell.h"
#import "SalePListModel.h"
#import "ShopDetailViewController.h"
@interface TFSalePurchaseTwoViewController () <UITableViewDataSource, UITableViewDelegate>


@property (nonatomic, assign)NSInteger page;

@end

@implementation TFSalePurchaseTwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self dataInit];
    
}

- (void)dataInit
{
    self.page = 1;
    
     [self httpGetSaleData];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return ZOOM(420);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    SalePurchaseShopListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SALESHOPLIST"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.separatorInset = UIEdgeInsetsMake(0, SIZE.width, 0, 0);
    
    cell.type = self.type;
    
//    [cell receiveDataModel:self.dataArr[indexPath.row]];
    
    [cell receiveDataModel:self.dataArr[indexPath.row] withPListModel:self.pListArr[indexPath.row]];
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SaleShopListModel *model = self.dataArr[indexPath.row];
    ShopDetailViewController *detail = [[ShopDetailViewController alloc] initWithNibName:@"ShopDetailViewController" bundle:nil];
    //pcode = %@", model.p_code);
    
    detail.shop_code = model.p_code;
    detail.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:detail animated:YES];
}

- (UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 20, SIZE.width, SIZE.height-20)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = COLOR_244;
        
        UIView *footView = [[UIView alloc] init];
        footView.backgroundColor = COLOR_244;
        _tableView.tableFooterView = footView;
        
        [self.view addSubview:_tableView];
        UIImage *img = [UIImage imageNamed:@"0_主图"];
        
        CGFloat H_iv = img.size.height/img.size.width*SIZE.width+10;
        
        [_tableView registerNib:[UINib nibWithNibName:@"SalePurchaseShopListCell" bundle:nil] forCellReuseIdentifier:@"SALESHOPLIST"];
        
        
        NSArray *normalImgArr = [NSArray arrayWithObjects:[UIImage imageNamed:@"0元区_默认"],
                                 [UIImage imageNamed:@"9元区_默认"],
                                 [UIImage imageNamed:@"19元区_默认"],
                                 [UIImage imageNamed:@"29元区_默认"], nil];
        
        UIImage *img2 = normalImgArr[0];
        
        CGFloat W_btn = SIZE.width/normalImgArr.count;
        CGFloat H_btn = img2.size.height/img2.size.width*W_btn;
        
        _tableView.topLoadHeight = [NSNumber numberWithFloat:H_iv+H_btn];
        [_tableView addTopTarget:self andAction:@selector(headRefreshData) withView:nil];
        
        __weak TFSalePurchaseTwoViewController *ssc = self;
        
        [_tableView addFooterWithCallback:^{
            //上拉刷新");
            ssc.page++;
            [ssc httpGetSaleData];
            
        }];
    }
    return _tableView;
    
}

- (void)headRefreshData
{
    //下拉刷新");
    
    self.page = 1;
    [self httpGetSaleData];

}

- (void)httpGetSaleData
{
    //    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    //    NSString *token = [ud objectForKey:USER_TOKEN];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    NSString *urlStr = [NSString stringWithFormat:@"%@shop/queryPackageList?version=%@&type=%@&pager.curPage=%d&pager.order=%@&pager.pageSize=%@",URLHTTP,VERSION,self.type,(int)self.page,@"desc",@"10"];
    NSString *URL = [MyMD5 authkey:urlStr];
    [manager POST:URL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self.tableView headerEndRefreshing];
        [self.tableView footerEndRefreshing];
        
        if (self.page == 1) {
            [self.dataArr removeAllObjects];
        }
        //type %@ = %@", self.type, responseObject);
        if (responseObject!=nil) {
            
            NSArray *shopListArr;
            if (responseObject[@"shopList"]!=nil) {
                shopListArr = responseObject[@"shopList"];
            }
            
            NSArray *pListArr;
            if (responseObject[@"pList"]!=nil) {
                pListArr = responseObject[@"pList"];
            }
            
            for (NSDictionary *dic in pListArr) {
                SalePListModel *spModel = [[SalePListModel alloc] init];
                [spModel setValuesForKeysWithDictionary:dic];
                [self.pListArr addObject:spModel];
                
                
                
            }
            
            for (NSDictionary *dic in shopListArr) {
                SaleShopListModel *ssModel = [[SaleShopListModel alloc] init];
                [ssModel setValuesForKeysWithDictionary:dic];
                [self.dataArr addObject:ssModel];
            }
            
            [self.tableView reloadData];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self.tableView headerEndRefreshing];
        [self.tableView footerEndRefreshing];
    }];
}

- (NSMutableArray *)dataArr
{
    if (_dataArr == nil) {
        _dataArr = [[NSMutableArray alloc] init];
    }
    
    return _dataArr;
}

- (NSMutableArray *)pListArr
{
    if (_pListArr == nil) {
        _pListArr = [[NSMutableArray alloc] init];
    }
    
    return _pListArr;
}

- (void)dealloc
{
    [self.tableView removeObserver:self.tableView forKeyPath:@"contentOffset" context:nil];
    [self.tableView removeFromSuperview];
    self.tableView = nil;

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
