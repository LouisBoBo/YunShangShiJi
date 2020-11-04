//
//  GoodsDetailViewController.m
//  YunShangShiJi
//
//  Created by ios-1 on 15/4/28.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//

#import "GoodsDetailViewController.h"
#import "GlobalTool.h"
@interface GoodsDetailViewController ()

@end

@implementation GoodsDetailViewController
{
    UIPageControl *_pageview;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //导航条
    UIImageView *headview=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kApplicationWidth, Height_NavBar)];
    //
    [self.view addSubview:headview];
    headview.userInteractionEnabled=YES;
    
    UIButton *backbtn=[UIButton buttonWithType:UIButtonTypeCustom];
    backbtn.frame=CGRectMake(0, 20, 44, 44);
    backbtn.centerY = View_CenterY(headview);
    [backbtn setImage:[UIImage imageNamed:@"返回按钮_正常"] forState:UIControlStateNormal];
    [backbtn addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    [headview addSubview:backbtn];
    
    UILabel *titlelable=[[UILabel alloc]init];
    titlelable.frame=CGRectMake(0, 0, 300, 40);
    titlelable.center=CGPointMake(kApplicationWidth/2, headview.frame.size.height/2+10);
    titlelable.text=@"宝贝详情";
    titlelable.font=kNavTitleFontSize;
    titlelable.textColor=[UIColor whiteColor];
    titlelable.textAlignment=NSTextAlignmentCenter;
    [headview addSubview:titlelable];
    
    [self creatView];
}

-(void)creatView
{
    self.MyScrollview.contentSize=CGSizeMake(0, kApplicationHeight*2);
    self.MyScrollview.backgroundColor=[UIColor groupTableViewBackgroundColor];
    self.MyScrollview.delegate=self;
    
    self.HeadScrollview.contentSize=CGSizeMake(kApplicationWidth*6, 0);
    self.HeadScrollview.pagingEnabled=YES;
    self.HeadScrollview.delegate=self;
    
    for(int i=0;i<6;i++)
    {
        UIView *view=[[UIView alloc]initWithFrame:CGRectMake(kApplicationWidth*i, 0, kApplicationWidth, self.HeadScrollview.frame.size.height)];
        view.backgroundColor=DRandomColor;
        [self.HeadScrollview addSubview:view];
    }

    if(kScreenWidth==320)
    {
        _pageview=[[UIPageControl alloc]initWithFrame:CGRectMake(0, self.HeadScrollview.frame.size.height-30, kScreenWidth, 25)];
    }else{
        _pageview=[[UIPageControl alloc]initWithFrame:CGRectMake(0, self.HeadScrollview.frame.size.height-40, kScreenWidth-50, 25)];
        
    }
    _pageview.numberOfPages=6;
    _pageview.userInteractionEnabled = NO;
    [self.MyScrollview addSubview:_pageview];

}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
   
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if(scrollView==self.HeadScrollview)
    {
        int page = self.HeadScrollview.contentOffset.x/kApplicationWidth;
        _pageview.currentPage = page;
    }
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    Myview.hidden=YES;
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    Myview.hidden=NO;
}

- (void)back:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}


@end
