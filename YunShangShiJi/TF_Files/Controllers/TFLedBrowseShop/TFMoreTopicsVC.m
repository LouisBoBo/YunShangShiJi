//
//  TFMoreTopicsVC.m
//  YunShangShiJi
//
//  Created by jingaiweiyi on 2016/12/2.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import "TFMoreTopicsVC.h"
#import "TFMoreTopicsVM.h"
#import "YFDPImageView.h"
#import "SpecialDetailViewController.h"
#import "UIImageView+WebCache.h"
#import "CollocationModel.h"
@interface TFMoreTopicsVC ()
@property (nonatomic, assign) NSInteger currPage;
@property (nonatomic, strong) UITableView *tableV;
@property (nonatomic, strong) TFMoreTopicsVM *shopVM;
@property (nonatomic, strong) UIView *tableVFooterV;
@end

@implementation TFMoreTopicsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupUI];
    
    [self setData];
    
}

- (void)pushVCWithDataModel:(TFTopicsShop *)model
{
    SpecialDetailViewController *special = [[SpecialDetailViewController alloc]init];
    special.isMoreTopVC = YES;
    special.hidesBottomBarWhenPushed = YES;
    special.collocationCode = model.collocation_code;
    CollocationModel *collocationM = [[CollocationModel alloc] init];
    collocationM.collocation_code = model.collocation_code;
    collocationM.collocation_name = model.collocation_name;
    collocationM.collocation_name2 = model.collocation_name2;
    collocationM.collocation_pic = model.collocation_pic;
    
    special.collcationModel = collocationM;
    [self.navigationController pushViewController:special animated:YES];

}

- (void)setData {
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
    [self.shopVM getTopicsShopListWithCurPage:self.currPage success:^(id data) {
        [self.tableV headerEndRefreshing];
        [self.tableV footerEndRefreshing];
        [MBProgressHUD hideHUDForView:self.view];

        TFMoreTopicsVM *model = data;
        
        if (!(model.status == 250 || model.status == 404)) {
            if (model.status != 1) {
                NavgationbarView *nv = [[NavgationbarView alloc] init];
                [nv showLable:model.message Controller:self];
            }
            
            
            if (self.shopVM.tableViewService.dataSource.count <= 0) {
                
                [self showBackgroundTabBar:NO setY:ZOOM6(80) type:ShowBackgroundTypeListEmpty message:@"没有你想要的结果"];
            } else {
                
                [self cleanShowBackground];
            }
            
            
            if (self.shopVM.tableViewService.dataSource.count >= model.pager.rowCount) {
                
                self.tableV.tableFooterView = self.tableVFooterV;
                self.tableV.footerHidden = YES;
                
            }
            [self.tableV reloadData];
        } else {
            
            [self showBackgroundTabBar:NO setY:ZOOM6(80) type:ShowBackgroundTypeNetError message:nil];
            
            NavgationbarView *nv = [[NavgationbarView alloc] init];
            [nv showLable:model.message Controller:self];
        }
    }];
}

- (void)setupUI {
    [self setNavigationItemLeft:@"更多专题"];
    [self.view addSubview:self.tableV];
    [self.tableV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.navigationView.mas_bottom);
        make.left.and.right.equalTo(self.view);
        make.bottom.equalTo(self.view.mas_bottom);
    }];
}

- (TFMoreTopicsVM *)shopVM {
    if (!_shopVM) {
        _shopVM = [[TFMoreTopicsVM alloc] init];
        
        
        [_shopVM.tableViewService didSelectRowAtIndexPathBlock:^(UITableView *tableView, NSIndexPath *indexPath) {
            
            TFTopicsShop *model = self.shopVM.tableViewService.dataSource[indexPath.row];
            [self pushVCWithDataModel:model];
        }];
        
        [_shopVM.tableViewService heightForRowAtIndexPathBlock:^CGFloat(UITableView *tableView, NSIndexPath *indexPath) {
            CGFloat cellHeight = kScreen_Width / 1.5;
            if (self.shopVM.tableViewService.dataSource.count-1 != indexPath.row) {
                cellHeight += ZOOM6(16);
            }
            return cellHeight;
        }];
        
        [_shopVM.tableViewService cellForRowAtIndexPathBlock:^UITableViewCell *(UITableView *tableView, NSIndexPath *indexPath) {
            static NSString *cellId = @"CellId";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
            if (!cell) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                YFDPImageView *imageV = [[YFDPImageView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Width/ 1.5) isTriangle:NO isShade:NO isTopics:NO];
                imageV.tag = 200;
                imageV.backgroundColor = lineGreyColor;
                imageV.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin;
                imageV.contentMode = UIViewContentModeScaleAspectFill;
                imageV.clipsToBounds = YES;

                [cell.contentView addSubview:imageV];
            }
            YFDPImageView *imageV = (YFDPImageView *)[cell.contentView viewWithTag:200];
            TFTopicsShop *shopModel = (TFTopicsShop *)self.shopVM.tableViewService.dataSource[indexPath.row];
            
            [imageV setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", [NSObject baseURLStr_Upy], shopModel.collocation_pic]] placeholderImage:[UIImage imageDefaultWithSize:CGSizeMake(kScreen_Width, kScreen_Width / 1.5)] progress:nil completed:nil];
            
            imageV.mainTitleLabel.text = shopModel.collocation_name;
            imageV.subTitleLabel.text = shopModel.collocation_name2.length !=0?[NSString stringWithFormat:@"【%@】", shopModel.collocation_name2]: @"";
            [imageV reloadData];
            
            return cell;
        }];
    }
    return _shopVM;
}

- (UITableView *)tableV {
    if (!_tableV) {
        _tableV = [UITableView new];
        _tableV.delegate = self.shopVM.tableViewService;
        _tableV.dataSource = self.shopVM.tableViewService;
        _tableV.backgroundColor = RGBCOLOR_I(240, 240, 240);
        _tableV.tableFooterView = [[UIView alloc] init];
        
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
        [self.tableV setSeparatorInset:UIEdgeInsetsMake(0, kScreen_Width, 0, 0)];
    }
    
    if ([self.tableV respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.tableV setLayoutMargins:UIEdgeInsetsMake(0, kScreen_Width, 0, 0)];
    }
}

- (UIView *)tableVFooterV
{
    if (!_tableVFooterV) {
        _tableVFooterV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, ZOOM6(100))];
        _tableVFooterV.backgroundColor = [UIColor whiteColor];
        
        UILabel *lab = [UILabel new];
        lab.textColor = RGBCOLOR_I(125, 125, 125);
        lab.text = @"The end";
        lab.font = kFont6px(24);
        lab.textAlignment = NSTextAlignmentCenter;
        [_tableVFooterV addSubview:lab];
        
        [lab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(_tableVFooterV);
            make.height.mas_equalTo(ZOOM6(40));
        }];
    }
    return _tableVFooterV;
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
