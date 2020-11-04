//
//  YDPageDetailsVC.m
//  YunShangShiJi
//
//  Created by yssj on 2016/12/14.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import "YDPageDetailsVC.h"
#import "TFGlobalTool.h"

//VC
#import "TYSlidePageScrollView.h"
#import "YDTableViewController.h"

//view
#import "TYTitlePageTabBar.h"
#import "CustomTitleView.h"



@interface YDPageDetailsVC ()<TYSlidePageScrollViewDelegate,TYSlidePageScrollViewDataSource>

@property (nonatomic,strong)TYSlidePageScrollView *slidePageScrollView;

@end

@implementation YDPageDetailsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self setNavgationView];
    [self setUI];
}

- (void)setUI {
    [self addChildViewControllers];
    [self addSlidePageScrollView];
    [self addHeaderView];
    [self addTabPageMenu];
    
    [_slidePageScrollView reloadData];
}

- (void)addSlidePageScrollView {
    CGRect frame = CGRectMake(0, 64, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)-64);
    TYSlidePageScrollView *slidePageScrollView = [[TYSlidePageScrollView alloc]initWithFrame:frame];
    slidePageScrollView.pageTabBarIsStopOnTop = YES;
//    slidePageScrollView.pageTabBarStopOnTopHeight = 64;
    slidePageScrollView.tyDataSource = self;
    slidePageScrollView.tyDelegate = self;
    slidePageScrollView.backgroundColor = RGBCOLOR_I(240, 240, 240);
    [self.view addSubview:slidePageScrollView];
    _slidePageScrollView = slidePageScrollView;
}

- (void)addChildViewControllers {
    for (int i=0; i<_type; i++) {
        YDTableViewController *tableVC=[[YDTableViewController alloc]init];
        [self addChildViewController:tableVC];
    }  
}
- (void)addHeaderView {
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.slidePageScrollView.frame), 200)];
    imageView.backgroundColor=DRandomColor;
    self.slidePageScrollView.headerView = imageView;

}
- (void)addTabPageMenu {
    NSArray *arr = _type==YDPageVCTypeYidou ? @[@"消耗",@"增加",@"冻结"] : @[@"新增额度",@"使用额度"];
//    TYTitlePageTabBar *titlePageTabBar = [[TYTitlePageTabBar alloc]initWithTitleArray:arr];
//    titlePageTabBar.frame = CGRectMake(0, 0, CGRectGetWidth(_slidePageScrollView.frame), 40);
//    titlePageTabBar.backgroundColor = [UIColor lightGrayColor];
    
    CustomTitleView *title = [CustomTitleView scrollWithFrame:CGRectMake(0, 0, CGRectGetWidth(_slidePageScrollView.frame), 40) withTag:0 withIndex:0 withButtonNames:arr withImage:arr];
    title.index=(int)[_slidePageScrollView curPageIndex];
    title.backgroundColor=[UIColor whiteColor];
    _slidePageScrollView.pageTabBar = title;
}

#pragma mark - dataSource

- (NSInteger)numberOfPageViewOnSlidePageScrollView
{
    return _type;
}

- (UIScrollView *)slidePageScrollView:(TYSlidePageScrollView *)slidePageScrollView pageVerticalScrollViewForIndex:(NSInteger)index
{
    YDTableViewController *tableViewVC = self.childViewControllers[index];
    return tableViewVC.tableView;
}


- (void)setNavgationView {
    //导航条
    UIImageView *headview=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kApplicationWidth, 63)];
    headview.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:headview];
    headview.userInteractionEnabled=YES;
    
    UIButton *backbtn=[UIButton buttonWithType:UIButtonTypeCustom];
    backbtn.frame=CGRectMake(0, 20, 46, 46);
    [backbtn setImage:[UIImage imageNamed:@"返回按钮_正常"] forState:UIControlStateNormal];
    [backbtn addTarget:self action:@selector(goBack:) forControlEvents:UIControlEventTouchUpInside];
    [headview addSubview:backbtn];
    
    UILabel *titlelable=[[UILabel alloc]init];
    titlelable.frame=CGRectMake(0, 0, 300, 40);
    titlelable.center=CGPointMake(kApplicationWidth/2, headview.frame.size.height/2+10);
    titlelable.text = _type==YDPageVCTypeYidou ? @"衣豆明细" : @"获得额度明细";
    titlelable.font = [UIFont systemFontOfSize:ZOOM(57)];
    titlelable.textColor=kMainTitleColor;
    titlelable.textAlignment=NSTextAlignmentCenter;
    [headview addSubview:titlelable];
    
    UILabel *rightLabel=[[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth-ZOOM(42)-100, 25, 100, 30)];
    rightLabel.text= _type==YDPageVCTypeYidou ? @"衣豆说明" : @"额度说明";
    rightLabel.font = [UIFont systemFontOfSize:ZOOM6(32)];
    rightLabel.textColor=RGBCOLOR_I(125, 125, 125);
    rightLabel.textAlignment = NSTextAlignmentRight;
    [headview addSubview:rightLabel];
    
    UIButton *rightBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame=CGRectMake(kScreenWidth-ZOOM(42)-100, 25, 100, 30);
    [rightBtn addTarget:self action:@selector(rightBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [headview addSubview:rightBtn];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, headview.frame.size.height, kApplicationWidth, 0.5)];
    line.backgroundColor = kNavLineColor;
    [headview addSubview:line];
    
}


- (void)goBack:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)rightBtnClick {
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
