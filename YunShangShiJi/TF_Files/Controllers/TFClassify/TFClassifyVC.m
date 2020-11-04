//
//  TFClassifyVC.m
//  YunShangShiJi
//
//  Created by jingaiweiyi on 2017/1/19.
//  Copyright © 2017年 ios-1. All rights reserved.
//

#import "TFClassifyVC.h"
#import "TYSlidePageScrollView.h"
#import "CustomTitleView.h"
#import "TFSubClassifyVC.h"
#import "SqliteManager.h"
@interface TFClassifyVC () <TYSlidePageScrollViewDelegate, TYSlidePageScrollViewDataSource> {
    CGFloat HeaderView_H;
    CGFloat FooterView_H;
    CGFloat TabPageMenu_H;
}

@property (nonatomic, strong) TYSlidePageScrollView *slidePageScrollView;
@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) UIView *footerView;
@property (nonatomic, strong) CustomTitleView *titleView;
@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation TFClassifyVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setData];
    
    [self setupUI];
    
    [self getData];
}

- (void)setData {
    HeaderView_H = 0;
    FooterView_H = 0;
    TabPageMenu_H = kZoom6pt(35);

}

- (void)getData {
    SqliteManager *manager = [SqliteManager sharedManager];
//    NSArray *shopTypeArray = [manager getShopTypeItemForSuperId:@"0"];
    
    /**< 手动添加的 */
    NSMutableArray *shopTypeArray = [NSMutableArray array];
    NSArray *typeNames = @[@"上衣", @"裤子", @"裙子", @"套装"];
    NSArray *typeIds = @[@"2", @"4", @"3", @"7"];
    for (int i = 0; i< typeNames.count; i++) {
        ShopTypeItem *item = [[ShopTypeItem alloc] init];
        item.type_name = typeNames[i];
        item.ID = typeIds[i];
        item.is_show = @"1";
        [shopTypeArray addObject:item];
    }
    
    NSMutableArray *shopTypeMuArray = [NSMutableArray arrayWithArray:shopTypeArray];
    if (shopTypeMuArray.count) {
        NSArray *sortArray = [manager sortShopTypeArrayWithSequenceFromSourceArray:shopTypeMuArray];
        
        [self buildTypeIndexArray:sortArray firstArray:@[]];
        
        [self addCollectionViewWithPageScrollView];
        
        NSMutableArray *names = [NSMutableArray array];
        for (ShopTypeItem *item in self.dataSource) {
            [names addObject:item.type_name];
        }
        
        [self.titleView refreshTitleViewUI:names withImgNames:nil];
    }
    [_slidePageScrollView reloadData];
}

- (void)setupUI {
    [self setNavigationItemLeft:@"分类"];
    UIView *lineV = [[UIView alloc] init];
    lineV.backgroundColor = RGBCOLOR_I(240, 240, 240);
    [self.navigationView addSubview:lineV];
    [lineV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.navigationView);
        make.bottom.equalTo(@0);
        make.centerX.equalTo(self.navigationView.mas_centerX);
    }];
    
    [self addSlidePageScrollView];
    [self addHeaderView];
    [self addFooterView];
    [self addTabPageMenu];

}
#pragma mark - set SlidePageScrollView
- (void)addSlidePageScrollView {
    CGRect frame = CGRectMake(0, Height_NavBar, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame) - Height_NavBar);
    TYSlidePageScrollView *slidePageScrollView = [[TYSlidePageScrollView alloc] initWithFrame:frame];
    slidePageScrollView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    slidePageScrollView.pageTabBarIsStopOnTop = YES;
    slidePageScrollView.tyDataSource = self;
    slidePageScrollView.tyDelegate = self;
    slidePageScrollView.backgroundColor = RGBCOLOR_I(240, 240, 240);
    slidePageScrollView.pageTabBarStopOnTopHeight = 0;
    [self.view addSubview:slidePageScrollView];
    _slidePageScrollView = slidePageScrollView;
}
- (void)addHeaderView {
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(_slidePageScrollView.frame), HeaderView_H)];
    _slidePageScrollView.headerView = _headerView = headerView;
}
- (void)addFooterView {
    CGRect frame = CGRectMake(0, 0, CGRectGetWidth(_slidePageScrollView.frame), FooterView_H);
    UIView *footerView = [[UIView alloc]initWithFrame:frame];
    footerView.backgroundColor = [UIColor yellowColor];
    _slidePageScrollView.footerView = _footerView = footerView;
}
- (void)addTabPageMenu {
    
    CGRect frame = CGRectMake(0, 0, CGRectGetWidth(_slidePageScrollView.frame), TabPageMenu_H);
    CustomTitleView *titleView = [CustomTitleView scrollWithFrame:frame withTag:0 withIndex:0 withButtonNames:nil withImage:nil];
    titleView.backColor = [UIColor whiteColor];
    int page = (int)[_slidePageScrollView curPageIndex];
    titleView.index = page;
    _slidePageScrollView.pageTabBar = _titleView = titleView;
}
#pragma mark - SlidePageScrollView delegate

- (NSInteger)numberOfPageViewOnSlidePageScrollView {
    return self.dataSource.count;
}

- (UIScrollView *)slidePageScrollView:(TYSlidePageScrollView *)slidePageScrollView pageVerticalScrollViewForIndex:(NSInteger)index {
    TFSubClassifyVC *subVC = self.childViewControllers[index];
    subVC.headerView_H = HeaderView_H;
    return subVC.collectionView;
}

#pragma mark - Tools Mothed
- (void)addCollectionViewWithPageScrollView
{
    for (int i = 0; i<self.dataSource.count; i++) {
        [self addCollectionViewWithShopTypeItem:self.dataSource[i]];
    }
}

- (void)addCollectionViewWithShopTypeItem:(ShopTypeItem *)item
{
    TFSubClassifyVC *subVC = [[TFSubClassifyVC alloc] init];
    subVC.item = item;
    subVC.headerView_H = HeaderView_H;
    [self addChildViewController:subVC];
}


/**
 *  构建商品类型数组
 *
 *  @param array 排序后数组
 */
- (void)buildTypeIndexArray:(NSArray *)array firstArray:(NSArray *)firstArray
{
    __block int i = 0;
    [firstArray enumerateObjectsUsingBlock:^(NSString *obj, NSUInteger firstIdx, BOOL * _Nonnull stop) {
        [array enumerateObjectsUsingBlock:^(ShopTypeItem *item, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([item.type_name isEqualToString:obj] && [item.is_show intValue] == 1) {
                [self.dataSource addObject:item];
                i++;
            }
        }];
    }];
    
    [array enumerateObjectsUsingBlock:^(ShopTypeItem *item, NSUInteger idx, BOOL * _Nonnull stop) {
        if (![firstArray containsObject:item.type_name] && [item.is_show intValue] == 1) {
            [self.dataSource addObject:item];
            i++;
        }
    }];
}

#pragma mark - getter
- (NSMutableArray *)dataSource {
    if (_dataSource != nil) {
        return _dataSource;
    }
    NSMutableArray *dataSource = [NSMutableArray array];
    return _dataSource = dataSource;
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
