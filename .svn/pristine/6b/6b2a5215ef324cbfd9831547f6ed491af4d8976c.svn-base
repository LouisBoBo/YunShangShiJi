
    //
//  TFGroupBuysVC.m
//  YunShangShiJi
//
//  Created by jingaiweiyi on 2016/11/24.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import "TFGroupBuysVC.h"
#import "TFGroupBuyVM.h"
#import "GroupBuysCell.h"
#import "ShopDetailViewController.h"
static CGFloat LMargin;

@interface TFGroupBuysVC ()

@property (nonatomic, strong) UITableView *tableV;
@property (nonatomic, strong) TFGroupBuyVM *groupBuyVM;

@property (nonatomic, assign) NSUInteger currPage;

@end

@implementation TFGroupBuysVC

+ (void)initialize {
    if (self == [TFGroupBuysVC class]) {
        LMargin = ZOOM6(20);
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavigationItemLeft:@"拼团广场"];
    
    [self setupUI];
    
    [self setDate];
}

- (void)setupUI {
    
    UIView *lineV = [UIView new];
    lineV.backgroundColor = RGBCOLOR_I(220, 220, 220);
    [self.navigationView addSubview:lineV];
    [lineV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(self.navigationView);
        make.height.mas_equalTo(1);
        make.bottom.equalTo(self.navigationView.mas_bottom);
    }];
    
    UILabel *titleL = [UILabel new];
    titleL.text = @"以下小伙伴正在发起拼团，快来一起组团吧~";
    titleL.font = kFont6px(28);
    titleL.textColor = RGBCOLOR_I(125, 125, 125);
    [self.view addSubview:titleL];
    [titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(ZOOM6(80));
        make.left.equalTo(self.view.mas_left).offset(LMargin);
        make.right.equalTo(self.view.mas_right);
        make.top.equalTo(self.navigationView.mas_bottom);
    }];
    
    UIView *bottomlineV = [UIView new];
    bottomlineV.backgroundColor = RGBCOLOR_I(220, 220, 220);
    [self.view addSubview:bottomlineV];
    [bottomlineV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(1);
        make.top.equalTo(titleL.mas_bottom);
    }];
    
    [self.view addSubview:self.tableV];
    [self.tableV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(bottomlineV.mas_bottom);
        make.bottom.equalTo(self.view.mas_bottom);
    }];
}

- (void)setDate {

    self.currPage = 1;
    [MBProgressHUD showHUDAddTo:self.view animated:YES];
    
    [self getData];
    
    kWeakSelf(self);
    [self reloadDataBlock:^{
        [MBProgressHUD showHUDAddTo:self.view animated:YES];
        [weakself getData];
    }];
}

- (void)getData {
    [self.groupBuyVM getGroupBuysShopListWithCurPage:self.currPage success:^(id data) {
        
        [self.tableV headerEndRefreshing];
        [self.tableV footerEndRefreshing];
        [MBProgressHUD hideHUDForView:self.view];

        TFGroupBuyVM *model = data;
        
        if (!(model.status == 250 || model.status == 404)) {
            if (model.status != 1) {
                NavgationbarView *nv = [[NavgationbarView alloc] init];
                [nv showLable:model.message Controller:self];
            }
            
            
            if (self.groupBuyVM.tableViewService.dataSource.count <= 0) {
                
                [self showBackgroundTabBar:NO setY:ZOOM6(80) type:ShowBackgroundTypeListEmpty message:@"没有你想要的结果"];
            } else {
                
                [self cleanShowBackground];
            }
            
            
            if (self.groupBuyVM.tableViewService.dataSource.count >= model.pager.rowCount && self.currPage>1 && model.list.count == 0) {
                NavgationbarView *nv = [[NavgationbarView alloc] init];
                [nv showLable:@"没有更多商品了哦~" Controller:self];
            }
            
            [self.tableV reloadData];
        } else {
            
            [self showBackgroundTabBar:NO setY:ZOOM6(80) type:ShowBackgroundTypeNetError message:nil];
            
            NavgationbarView *nv = [[NavgationbarView alloc] init];
            [nv showLable:model.message Controller:self];
        }
    }];
}

- (void)pushShopDetailVC:(TFGroupBuyShop *)model {
    
    ShopDetailViewController *detail = [[ShopDetailViewController alloc]init];
    detail.shop_code = model.shop_code;
    detail.r_code = model.r_code;
    detail.stringtype = @"活动商品";
    detail.is_group = YES;
    [self.navigationController pushViewController:detail animated:YES];
}

- (TFGroupBuyVM *)groupBuyVM
{
    if (!_groupBuyVM) {
        _groupBuyVM = [[TFGroupBuyVM alloc] init];
        
        [_groupBuyVM.tableViewService didSelectRowAtIndexPathBlock:^(UITableView *tableView, NSIndexPath *indexPath) {
            
            TFGroupBuyShop *model = self.groupBuyVM.tableViewService.dataSource[indexPath.row];
            ShopDetailViewController *detail = [[ShopDetailViewController alloc]init];
            detail.shop_code = model.shop_code;
            detail.r_code = model.r_code;
            detail.stringtype = @"活动商品";
            detail.is_group = YES;
            [self.navigationController pushViewController:detail animated:YES];
        }];
        
        [_groupBuyVM.tableViewService cellForRowAtIndexPathBlock:^UITableViewCell *(UITableView *tableView, NSIndexPath *indexPath) {
            
            static NSString *cellId = @"cellId";
            GroupBuysCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
            if (cell == nil) {
                cell = [[GroupBuysCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;

            }
            cell.indexPath = indexPath;
            [cell setData:self.groupBuyVM.tableViewService.dataSource[indexPath.row]];
            
            kWeakSelf(self);
            cell.block = ^(TFGroupBuyShop *model, NSIndexPath *indexPath) {
                [weakself pushShopDetailVC:self.groupBuyVM.tableViewService.dataSource[indexPath.row]];
            };
            
            return cell;
        }];
        
        [_groupBuyVM.tableViewService heightForRowAtIndexPathBlock:^CGFloat(UITableView *tableView, NSIndexPath *indexPath) {
            static GroupBuysCell *cell;
            static dispatch_once_t onceToken;
            dispatch_once(&onceToken, ^{
                cell = [[GroupBuysCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellId"];
            });
            
            return [cell cellHeight];
        }];
    }
    return _groupBuyVM;
}

- (UITableView *)tableV
{
    if (!_tableV) {
        _tableV = [[UITableView alloc] init];
        _tableV.delegate = self.groupBuyVM.tableViewService;
        _tableV.dataSource = self.groupBuyVM.tableViewService;
        _tableV.tableFooterView = [[UIView alloc] init];
        _tableV.backgroundColor = RGBCOLOR_I(240, 240, 240);
        kWeakSelf(self);
        [_tableV addHeaderWithCallback:^{
            weakself.currPage = 1;
            [weakself getData];
        }];
        
        [_tableV addFooterWithCallback:^{
            weakself.currPage ++;
            [weakself getData];
        }];
    }
    return _tableV;
}

-(void)viewDidLayoutSubviews
{
    if ([self.tableV respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableV setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, 0)];
    }
    
    if ([self.tableV respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.tableV setLayoutMargins:UIEdgeInsetsMake(0, 0, 0, 0)];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)leftBarButtonClick
{
    [self.navigationController popViewControllerAnimated:YES];
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
