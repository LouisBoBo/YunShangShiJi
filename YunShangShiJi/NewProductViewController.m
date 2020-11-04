//
//  NewProductViewController.m
//  YunShangShiJi
//
//  Created by ios-1 on 2017/7/4.
//  Copyright © 2017年 ios-1. All rights reserved.
//

#import "NewProductViewController.h"
#import "ShopStoreViewController.h"
#import "GlobalTool.h"

#define NavigationHeight 44.0f
#define StatusTableHeight 20.0f
@interface NewProductViewController ()<TYSlidePageScrollViewDelegate>
@property (nonatomic , strong) UIView *backView;
@end

@implementation NewProductViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self creatNavagationView];
    [self creatMainView];
    
}

- (void)creatNavagationView
{
    //导航条
    UIImageView *headview=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kApplicationWidth, Height_NavBar)];
    headview.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:headview];
    headview.userInteractionEnabled=YES;
    
    UIButton *backbtn=[UIButton buttonWithType:UIButtonTypeCustom];
    backbtn.frame=CGRectMake(0, 20, 44, 44);
    backbtn.centerY = View_CenterY(headview);
    [backbtn setImage:[UIImage imageNamed:@"返回按钮_正常"] forState:UIControlStateNormal];
    [backbtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [headview addSubview:backbtn];
    
    UILabel *titlelable=[[UILabel alloc]init];
    titlelable.frame=CGRectMake(0, 0, 300, 40);
    titlelable.center=CGPointMake(kApplicationWidth/2, headview.frame.size.height/2+10);
    titlelable.text=@"新品专区";
    titlelable.font = kNavTitleFontSize;
    titlelable.textColor=kMainTitleColor;
    titlelable.textAlignment=NSTextAlignmentCenter;
    [headview addSubview:titlelable];
    
}

- (void)creatMainView
{
    self.backView = [[UIView alloc]initWithFrame:CGRectMake(0, Height_NavBar, kScreenWidth, kScreenHeight-Height_NavBar)];
    [self.view addSubview:self.backView];
    
    [self addChildTableView];
}

- (void)addChildTableView
{
    self.backView.clipsToBounds = YES;
    ShopStoreViewController*shopStoreVC = [[ShopStoreViewController alloc] init];
    shopStoreVC.isHeadView = NO;
    shopStoreVC.isFootView = NO;
    shopStoreVC.isVseron = YES;
    shopStoreVC.isNewProduction = YES;
    
    [shopStoreVC.view setFrame:CGRectMake(0, -NavigationHeight-StatusTableHeight,CGRectGetWidth(self.view.frame), CGRectGetHeight(self.backView.frame))];
    
    shopStoreVC.view.backgroundColor = [UIColor whiteColor];
    shopStoreVC.slidePageScrollView.pageTabBar.index = 0;
    [self addChildViewController:shopStoreVC];
    
    shopStoreVC.view.backgroundColor = [UIColor whiteColor];
    [self.backView addSubview:shopStoreVC.view];
    
    shopStoreVC.slidePageScrollView.tyDelegate = self;

}
- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
