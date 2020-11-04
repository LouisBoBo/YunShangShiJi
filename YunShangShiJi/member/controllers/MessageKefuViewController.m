//
//  MessageKefuViewController.m
//  YunShangShiJi
//
//  Created by hebo on 2019/5/16.
//  Copyright © 2019年 ios-1. All rights reserved.
//

#import "MessageKefuViewController.h"

@interface MessageKefuViewController ()

@end

@implementation MessageKefuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RGBCOLOR_I(237, 237, 237);

    self.shopmessage = self.shopmessage ? self.shopmessage : @"心仪的商品";
    [self setNavigationItemLeft:@"申请发货"];
    [self setMainView];
}

- (void)setMainView
{
    
    UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[NSObject baseURLStr_XCX_Upy],@"small-iconImages/heboImg/sqfh_wx_newbgimgage.jpg"]]]];
    CGFloat imageHeigh = image.size.height*kScreen_Width/image.size.width;
    
    UIScrollView *scrollview = [[UIScrollView alloc]initWithFrame:CGRectMake(0, Height_NavBar, kScreen_Width, kScreen_Height-Height_NavBar-40)];
    scrollview.userInteractionEnabled = YES;
    scrollview.contentMode =UIViewContentModeScaleAspectFill;
    scrollview.contentSize = CGSizeMake(0, imageHeigh);
    [self.view addSubview:scrollview];
    
    UIButton *addcard = [UIButton buttonWithType:UIButtonTypeCustom];
    addcard.frame = CGRectMake(0, CGRectGetMaxY(scrollview.frame), kScreen_Width, 40);
    addcard.backgroundColor = tarbarrossred;
    [addcard setTitle:@"复制客服微信号" forState:UIControlStateNormal];
    [addcard setTitleColor:kWiteColor forState:UIControlStateNormal];
    addcard.titleLabel.font = [UIFont systemFontOfSize:ZOOM6(36)];
    [addcard addTarget:self action:@selector(addcardClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addcard];
    
    UIImageView *logoimage = [[UIImageView alloc]initWithFrame:CGRectMake(ZOOM6(14), ZOOM6(30), ZOOM6(75), ZOOM6(75))];
    [logoimage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[NSObject baseURLStr_XCX_Upy],@"small-iconImages/ad_pic/ic_launcher.png"]]];
    logoimage.contentMode = UIViewContentModeScaleAspectFit;
    [scrollview addSubview:logoimage];
    
    UIImageView *testimage = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(logoimage.frame)+ZOOM6(10), ZOOM6(60), ZOOM6(12), ZOOM6(20))];
    [testimage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[NSObject baseURLStr_XCX_Upy],@"small-iconImages/heboImg/sqfh_wx_sanjiao.png"]]];
    [scrollview addSubview:testimage];
    
    UIView *baseview = [[UIView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(testimage.frame), ZOOM6(30), kScreenWidth*0.683, ZOOM6(300))];
    baseview.backgroundColor = kWiteColor;
    baseview.layer.cornerRadius = 4;
    [scrollview addSubview:baseview];
    
    UILabel *contentLab = [[UILabel alloc]init];
    contentLab.font = [UIFont systemFontOfSize:ZOOM6(31)];
    contentLab.numberOfLines = 0;
    contentLab.text = [NSString stringWithFormat:@"恭喜您使用会员优惠券以0元的价格买到了%@，请加微信：%@,联系客服发货。",self.shopmessage,self.weixinNum];
    contentLab.lineBreakMode = NSLineBreakByWordWrapping;
    
    NSMutableAttributedString *mutab = [[NSMutableAttributedString alloc]initWithString:contentLab.text];
    if(contentLab.text.length>0)
    {
        NSRange range = [contentLab.text rangeOfString:self.weixinNum options:NSCaseInsensitiveSearch];
        [mutab addAttribute:NSForegroundColorAttributeName value:tarbarrossred range:NSMakeRange(range.location, range.length)];
        [mutab addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:ZOOM6(34)] range:NSMakeRange(range.location, range.length)];
    }
    [contentLab setAttributedText:mutab];
    
    CGSize size = [contentLab sizeThatFits:CGSizeMake(baseview.frame.size.width-ZOOM6(40), MAXFLOAT)];
    contentLab.frame = CGRectMake(ZOOM6(20), ZOOM6(20), baseview.frame.size.width-ZOOM6(40), size.height);
    [baseview addSubview:contentLab];
    
    baseview.frame = CGRectMake(baseview.frame.origin.x, baseview.frame.origin.y, baseview.frame.size.width, CGRectGetMaxY(contentLab.frame)+ZOOM6(20));
    
    UIImageView *imageview = [[UIImageView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(baseview.frame)+ZOOM6(40), kScreen_Width, imageHeigh)];
    imageview.image = image;
    imageview.contentMode = UIViewContentModeScaleAspectFit;
    [scrollview addSubview:imageview];
    
    scrollview.contentSize = CGSizeMake(0, CGRectGetMaxY(imageview.frame));
}

//长按复制客服微信号
- (void)addcardClick:(UIButton*)sender
{
    [MBProgressHUD show:@"内容已复制" icon:nil view:self.view];
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = @"复制的内容";
}
- (void)leftBarButtonClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
