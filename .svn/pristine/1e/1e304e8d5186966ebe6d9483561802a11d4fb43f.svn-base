//
//  View1.m
//  XLScrollViewerDemo
//
//  Created by hebe on 15/1/13.
//  Copyright (c) 2015年 ___HebeTien___. All rights reserved.
//

#import "View1.h"
#import "ShopStoreViewController.h"
#import "MyTabBarController.h"
@implementation View1

-(instancetype)initWithFrame:(CGRect)frame{
    self =[super initWithFrame:frame];
    if (self) {
        
        
        self.backgroundColor =[UIColor whiteColor];
        
        
        UISwitch *switch1 =[[UISwitch alloc]initWithFrame:CGRectMake(20, 20, 50, 30)]; //移动按钮 动画开关
        switch1.on =YES;
        [switch1 addTarget:self action:@selector(switch1:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:switch1];
        
        UISwitch *switch2 =[[UISwitch alloc]initWithFrame:CGRectMake(20, 60, 50, 30)]; //缩放按钮 动画开关
        switch2.on =YES;
        [switch2 addTarget:self action:@selector(switch2:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:switch2];
        
        UISwitch *switch3 =[[UISwitch alloc]initWithFrame:CGRectMake(20, 100, 50, 30)]; //滑动滑块 动画开关
        switch3.on =YES;
        [switch3 addTarget:self action:@selector(switch3:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:switch3];
        
        UILabel *label1 =[[UILabel alloc]initWithFrame:CGRectMake(80, 20, 300, 30)];
        label1.text =@"滑动视图 移动按钮动画开关";
        label1.font =[UIFont systemFontOfSize:14];
        [self addSubview:label1];
        UILabel *label2 =[[UILabel alloc]initWithFrame:CGRectMake(80, 60, 300, 30)];
        label2.text =@"点击未被选中的按钮 缩放按钮动画开关";
        label2.font =[UIFont systemFontOfSize:14];
        [self addSubview:label2];
        UILabel *label3 =[[UILabel alloc]initWithFrame:CGRectMake(80, 100, 300, 30)];
        label3.text =@"点击未被选中的按钮 滑动滑块动画开关";
        label3.font =[UIFont systemFontOfSize:14];
        [self addSubview:label3];
        
        
        UILabel *label =[[UILabel alloc]initWithFrame:CGRectMake(20, 180, 220, 100)];
        label.numberOfLines =0;
        label.text =@"更多自定义属性，下载查看\n                              By章晓亮";
        [self addSubview:label];
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(click:)];
        label.userInteractionEnabled=YES;
        [label addGestureRecognizer:tap];
        
        
        UIButton *button=[UIButton buttonWithType:UIButtonTypeRoundedRect];
        button.frame=CGRectMake(0, 200, 100, 40);
        button.backgroundColor=[UIColor redColor];
        [button addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
    }
    return self;
}

-(void)click:(UIButton*)sender
{
//    ShopStoreViewController *nav =(ShopStoreViewController *)self.window.rootViewController;
//    ShopStoreViewController *vc =nav.childViewControllers[0];


}
-(void)switch1:(UISwitch *)sender {
    
//    UINavigationController *nav =(UINavigationController *)self.window.rootViewController;
//    ShopStoreViewController *vc =nav.childViewControllers[0];
    
    
}

-(void)switch2:(UISwitch *)sender {
    
//    UINavigationController *nav =(UINavigationController *)self.window.rootViewController;
//    ShopStoreViewController *vc =nav.childViewControllers[0];
   
    
}

-(void)switch3:(UISwitch *)sender {
    
//    UINavigationController *nav =(UINavigationController *)self.window.rootViewController;
//    ShopStoreViewController *vc =nav.childViewControllers[0];
    
    
}



@end

// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com 
