//
//  ContactKefuViewController.m
//  YunShangShiJi
//
//  Created by hebo on 2019/10/11.
//  Copyright © 2019 ios-1. All rights reserved.
//

#import "ContactKefuViewController.h"

@interface ContactKefuViewController ()
@property (nonatomic , strong) UILabel *weixinNbLabel;
@property (nonatomic , copy) NSString *weixinNumber;
@end

@implementation ContactKefuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kWiteColor;
    [self setNavigationItemLeft:@"联系客服"];
    [self setMainView];
    [self getWeixinNumber];
}

- (void)setMainView
{
    UIImage *image = [UIImage imageNamed:@"add_kefyu_img.png"];
    CGFloat imageHeigh = image.size.height*kScreen_Width/image.size.width;
    
    UIScrollView *scrollview = [[UIScrollView alloc]initWithFrame:CGRectMake(0, Height_NavBar, kScreen_Width, kScreen_Height-Height_NavBar-ZOOM6(250))];
    scrollview.userInteractionEnabled = YES;
    scrollview.contentMode =UIViewContentModeScaleAspectFill;
    scrollview.contentSize = CGSizeMake(0, imageHeigh);
    [self.view addSubview:scrollview];
    
    UILabel *linelab = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(scrollview.frame), kScreenWidth, 0.5)];
    linelab.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.view addSubview:linelab];
    
    UILabel *titlelab = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(linelab.frame)+ZOOM6(20), kScreenWidth, ZOOM6(100))];
    titlelab.text = [NSString stringWithFormat:@"请按以上步骤添加客服微信:\n%@",@""];
    titlelab.numberOfLines = 0;
    titlelab.textAlignment = NSTextAlignmentCenter;
    titlelab.font = [UIFont systemFontOfSize:ZOOM6(30)];
    [self.view addSubview:self.weixinNbLabel = titlelab];
    
    UIButton *addcard = [UIButton buttonWithType:UIButtonTypeCustom];
    addcard.frame = CGRectMake((kScreenWidth-ZOOM6(402))/2, CGRectGetMaxY(titlelab.frame)+ZOOM6(20), ZOOM6(402), ZOOM6(80));
    [addcard setBackgroundImage:[UIImage imageNamed:@"add_kefu_weixin.png"] forState:UIControlStateNormal];
    [addcard setTitleColor:kWiteColor forState:UIControlStateNormal];
    addcard.titleLabel.font = [UIFont systemFontOfSize:ZOOM6(36)];
    [addcard addTarget:self action:@selector(addcardClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addcard];
    
    UIImageView *imageview = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, imageHeigh)];
    imageview.image = image;
    imageview.contentMode = UIViewContentModeScaleAspectFit;
    [scrollview addSubview:imageview];
    
}
//获取微信号
-(void)getWeixinNumber{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *token = [ud objectForKey:USER_TOKEN];
    NSString *urlStr1 = [NSString stringWithFormat:@"%@order/queryWxhNumber?version=%@&token=%@",[NSObject baseURLStr],VERSION,token];
    NSString *URL1 = [MyMD5 authkey:urlStr1];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:URL1 parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        responseObject = [NSDictionary changeType:responseObject];
        
        if (responseObject!=nil) {
            
            if ([responseObject[@"status"] intValue] == 1) {
                
                NSString *weixinnum = responseObject[@"wxh"];
                self.weixinNumber = weixinnum;
                self.weixinNbLabel.text = [NSString stringWithFormat:@"请按以上步骤添加客服微信:\n%@",weixinnum];
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MBProgressHUD showError:@"网络连接失败,请检查网络设置"];
    }];
}

- (void)addcardClick:(UIButton*)sender
{
    UIPasteboard *pab = [UIPasteboard generalPasteboard];
    pab.string = self.weixinNumber;
    if (pab == nil) {
        [MBProgressHUD show:@"复制失败" icon:nil view:self.view];
    } else {
        [MBProgressHUD show:@"复制成功" icon:nil view:self.view];
        
        [self performSelector:@selector(copyNumber) withObject:nil afterDelay:1.0];
    }
}
//打开微信
- (void)copyNumber
{
    [MBProgressHUD hideHUDForView:self.view];
    
    NSURL *url = [NSURL URLWithString:@"weixin://"];
    BOOL canOpen = [[UIApplication sharedApplication] canOpenURL:url];
    if(canOpen)
    {
        [[UIApplication sharedApplication] openURL:url];;
    }else{
        [MBProgressHUD show:@"请先安装微信" icon:nil view:self.view];
    }
}
- (void)leftBarButtonClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
