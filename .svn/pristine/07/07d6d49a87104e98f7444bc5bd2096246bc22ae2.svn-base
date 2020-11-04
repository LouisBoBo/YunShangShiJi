//
//  HBmemberViewController.m
//  YunShangShiJi
//
//  Created by hebo on 2019/2/14.
//  Copyright © 2019年 ios-1. All rights reserved.
//

#import "HBmemberViewController.h"
#import "AddMemberCardViewController.h"
@interface HBmemberViewController ()

@end

@implementation HBmemberViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kWiteColor;
    [self setNavigationItemLeft:@"选择会员类型"];
    [self setMainView];
}

- (void)setMainView
{
    UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[NSObject baseURLStr_XCX_Upy],@"small-iconImages/heboImg/memberDiscription_becomeMember.jpg"]]]];
    CGFloat imageHeigh = image.size.height*kScreen_Width/image.size.width;
    
    UIScrollView *scrollview = [[UIScrollView alloc]initWithFrame:CGRectMake(0, Height_NavBar, kScreen_Width, kScreen_Height-Height_NavBar-40)];
    scrollview.userInteractionEnabled = YES;
    scrollview.contentMode =UIViewContentModeScaleAspectFill;
    scrollview.contentSize = CGSizeMake(0, imageHeigh);
    [self.view addSubview:scrollview];
    
    UIButton *addcard = [UIButton buttonWithType:UIButtonTypeCustom];
    addcard.frame = CGRectMake(0, CGRectGetMaxY(scrollview.frame), kScreen_Width, 40);
    addcard.backgroundColor = tarbarrossred;
    [addcard setTitle:@"立即开通会员" forState:UIControlStateNormal];
    [addcard setTitleColor:kWiteColor forState:UIControlStateNormal];
    addcard.titleLabel.font = [UIFont systemFontOfSize:ZOOM6(36)];
    [addcard addTarget:self action:@selector(addcardClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addcard];
    
    UIImageView *imageview = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, imageHeigh)];
    imageview.image = image;
    imageview.contentMode = UIViewContentModeScaleAspectFit;
    [scrollview addSubview:imageview];
    
}

- (void)addcardClick:(UIButton*)sender
{
    AddMemberCardViewController *addcard = [[AddMemberCardViewController alloc]init];
    addcard.from_vipType = self.from_vipType;
    [self.navigationController pushViewController:addcard animated:YES];
}
- (void)leftBarButtonClick
{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
