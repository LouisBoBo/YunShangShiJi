//
//  YFDoubleSucessVC.m
//  YunShangShiJi
//
//  Created by zgl on 16/7/1.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import "YFDoubleSucessVC.h"
#import "TFPopBackgroundView.h"
#import "TFMyWalletViewController.h"

@interface YFDoubleSucessVC ()

@end

@implementation YFDoubleSucessVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setUI];
    
}

- (void)setUI {
    [self setNavigationWithTitle:@"开启成功" rightBtnTitle:@"特权说明"];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(kZoom6pt(60), kZoom6pt(35) + 64, kZoom6pt(63), kZoom6pt(92))];
    imageView.image = [UIImage imageNamed:@"girl"];
    [self.view addSubview:imageView];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(imageView.right + kZoom6pt(7), imageView.top + kZoom6pt(18), kScreenWidth - kZoom6pt(190), kZoom6pt(20))];
    titleLabel.textColor = [UIColor colorWithWhite:62/255.0 alpha:1];
    titleLabel.font = [UIFont systemFontOfSize:kZoom6pt(18)];
    titleLabel.text = @"已成功开启特权啦！";
    [self.view addSubview:titleLabel];
    
    NSString *text = [NSString stringWithFormat:@"亲，您已成功开启余额x%ld倍特权，现在就去买买买吧。",(long)[DataManager sharedManager].twofoldness];
    CGFloat height = [NSString heightWithString:text font:[UIFont systemFontOfSize:kZoom6pt(15)] constrainedToWidth:kScreenWidth - kZoom6pt(190)];
    UILabel *contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(titleLabel.left, titleLabel.bottom + kZoom6pt(15), kScreenWidth - kZoom6pt(190), height)];
    contentLabel.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleBottomMargin;
    contentLabel.textColor = [UIColor colorWithWhite:125/255.0 alpha:1];
    contentLabel.font = [UIFont systemFontOfSize:kZoom6pt(15)];
    contentLabel.numberOfLines = 0;
    contentLabel.text = text;
    [self.view addSubview:contentLabel];
    
    CGFloat width = (kScreenWidth - kZoom6pt(95))/2;
    UIButton *leftBtn = [self buttonWithTag:2001];
    leftBtn.frame = CGRectMake(kZoom6pt(40), imageView.bottom + kZoom6pt(50), width, kZoom6pt(44));
    [self.view addSubview:leftBtn];
    UIButton *rightBtn = [self buttonWithTag:2002];
    rightBtn.frame = CGRectMake(leftBtn.right + kZoom6pt(15), leftBtn.top, width, kZoom6pt(44));
    [self.view addSubview:rightBtn];
}

- (UIButton *)buttonWithTag:(NSInteger)tag {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.tag = tag;
    btn.backgroundColor = tag == 2001?[UIColor whiteColor]:tarbarrossred;
    [btn setTitleColor:tag == 2001?tarbarrossred:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setTitle:tag == 2001?@"查余额":@"买买买" forState:UIControlStateNormal];
    btn.layer.borderColor = tarbarrossred.CGColor;
    btn.layer.borderWidth = 1;
    btn.layer.cornerRadius = 5;
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    return btn;
}

- (void)btnClick:(UIButton *)sender {
    switch (sender.tag) {
        case 2001:
            if (self.navigationController == [Mtarbar.viewControllers objectAtIndex:Mtarbar.viewControllers.count-1]) {
                for (UIViewController *vc in self.navigationController.viewControllers) {
                    if ([vc isKindOfClass:[TFMyWalletViewController class]]) {
                        [self.navigationController popToViewController:vc animated:YES];
                    }
                }
            } else {
                [self.navigationController pushViewController:[[TFMyWalletViewController alloc] init] animated:YES];
            }
            break;
        case 2002:
            Mtarbar.selectedIndex = 0;
            [self.navigationController popToRootViewControllerAnimated:YES];
            break;
        default:
            break;
    }
}

#pragma mark - 父类方法重写
- (void)rightButtonClick {
    NSString *str = [NSString stringWithFormat:@"%ld",(long)[DataManager sharedManager].twofoldness];
    NSString *message;
    if(self.flag == 1)
    {
        message =[NSString stringWithFormat:@"亲，余额X%@倍特权是开启余额翻倍后24小时之内余额变为原来余额的%@倍，可直接用于购物，24小时之后余额变为原来的金额",str,str];

    }else{
        message =[NSString stringWithFormat:@"亲，余额%@倍是指在开店成功后24小时之内余额为原来余额的%@倍，可直接用于购物，24小时之后余额变为原来的金额",str,str];
    }
    
    TFPopBackgroundView *openShopView = [[TFPopBackgroundView alloc] initWithTitle:[NSString stringWithFormat:@"什么是余额X%@倍特权？",str] message:message showCancelBtn:NO leftBtnText:nil rightBtnText:@"知道了" margin:kZoom6pt(10) contentFont:kZoom6pt(12)];
    openShopView.textAlignment = NSTextAlignmentLeft;
    [openShopView show];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
