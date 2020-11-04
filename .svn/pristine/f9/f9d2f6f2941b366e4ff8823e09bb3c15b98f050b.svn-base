//
//  AddressDetailViewController.m
//  YunShangShiJi
//
//  Created by 云商 on 15/7/22.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//

#import "TFAddressDetailViewController.h"
#import "TFLabelView.h"
#import "TFReviseAddressViewController.h"
#import "TFReceivingAddressViewController.h"
#import "TFPopBackgroundView.h"

@interface TFAddressDetailViewController ()

@property (nonatomic, assign)BOOL isDefault;


@property (nonatomic, copy)NSString *addressStr; //地区

@end

@implementation TFAddressDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if ([self.model.is_default intValue] == 1) {
        self.isDefault = YES;
        [super setNavigationItemLeft:@"默认收货地址"];
    } else {
        self.isDefault = NO;
        [super setNavigationItemLeft:@"收货地址"];
    }
    
    [self createUI];
}

- (void)createUI
{
    NSArray *array = self.model.addressArray;
    if (array.count == 4) {
        self.addressStr = [NSString stringWithFormat:@"%@%@%@%@",array[0],array[1],array[2],array[3]];
    } else if (array.count == 3) {
        self.addressStr = [NSString stringWithFormat:@"%@%@%@",array[0],array[1],array[2]];
    } else if (array.count == 2) {
        self.addressStr = [NSString stringWithFormat:@"%@%@",array[0],array[1]];
    }
    //设置部分
    //修改按钮
//    UIButton *changeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [changeBtn setTitle:@"修改" forState:UIControlStateNormal];
//    changeBtn.frame = CGRectMake(kScreenWidth-80, 20, 80, 44);
//    changeBtn.titleLabel.font = [UIFont systemFontOfSize:ZOOM(50)];
//    [changeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];;
//    changeBtn.backgroundColor = [UIColor clearColor];
//    [changeBtn addTarget:self action:@selector(changeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:changeBtn];
    
    
    UIView *lineView0 = [[UIView alloc] initWithFrame:CGRectMake(0, kNavigationheightForIOS7+ZOOM(60), kScreenWidth, 1)];
    lineView0.backgroundColor = RGBCOLOR_I(220,220,220);
    [self.view addSubview:lineView0];
    
    NSArray *titleArr = [NSArray arrayWithObjects:@"收货人",@"手机号码",@"邮政编码",@"所在地区",@"详情地址", nil];
    
    
    CGFloat H_label = ZOOM(112);
    
    for (int i = 0; i<titleArr.count; i++) {
        TFLabelView *tl = [[TFLabelView alloc] initWithFrame:CGRectMake(0, kNavigationheightForIOS7+ZOOM(90)+H_label*i, kScreenWidth, H_label)];
        tl.titleLabel.textColor = RGBCOLOR_I(152,152,152);
        tl.titleLabel.font = [UIFont systemFontOfSize:ZOOM(48)];
        tl.titleLabel.text = titleArr[i];
        tl.tag = 200+i;
        tl.detailLabel.font = [UIFont systemFontOfSize:ZOOM(48)];
        tl.detailLabel.textColor = RGBCOLOR_I(34,34,34);
//        tl.detailLabel.adjustsFontSizeToFitWidth = YES;
        [self.view addSubview:tl];
        if (i == 0) {
            tl.detailLabel.text = self.model.consignee;
            tl.detailLabel.font = [UIFont systemFontOfSize:ZOOM(48)];
        } else if (i == 1) {
            tl.detailLabel.text = self.model.phone;
        } else if (i == 2) {
            tl.detailLabel.text = self.model.postcode;
        } else if (i == 3) {
            tl.detailLabel.text = self.addressStr;
        } else if (i == 4) {
            tl.detailLabel.text = self.model.address;
        }
    }
    
    TFLabelView *tl = (TFLabelView *)[self.view viewWithTag:204];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0,  tl.bottom+ZOOM(250), kScreenWidth, 1)];
    lineView.backgroundColor = RGBCOLOR_I(220,220,220);
//    [self.view addSubview:lineView];
    
    TFLabelView *tll = [[TFLabelView alloc] initWithFrame:CGRectMake(0,  lineView.bottom, kScreenWidth, H_label)];
    tll.titleLabel.textColor = COLOR_ROSERED;
    tll.titleLabel.frame = CGRectMake(ZOOM(62), 0, ZOOM(300), tll.frame.size.height);
    tll.titleLabel.text = @"删除收货地址";
    tll.lineView.hidden = YES;
    tll.titleLabel.font=[UIFont systemFontOfSize:ZOOM(46)];
    tll.btn.tag = 100;
    [tll.btn addTarget:self action:@selector(deleteBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:tll];
    
    if (!self.isDefault) {
        
        CGFloat Margin_lr = ZOOM(62);
        CGFloat H_btn = ZOOM(120);
        CGFloat Margin_lr_btn = ZOOM(173);
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(Margin_lr_btn, self.view.frame.size.height-Margin_lr-H_btn, self.view.frame.size.width-2*Margin_lr_btn, H_btn);
        [btn setBackgroundImage:[UIImage imageNamed:@"添加地址框"] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"添加地址框"] forState:UIControlStateHighlighted];
        [btn setTitle:@"设成默认收货地址" forState:UIControlStateNormal];
        btn.titleLabel.font=[UIFont systemFontOfSize:ZOOM(46)];
        [btn setTitleColor:COLOR_ROSERED forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(addressBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
    }
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"修改" forState:UIControlStateNormal];
    [self.navigationView addSubview:btn];
    [btn addTarget:self action:@selector(changeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn setTitleColor:COLOR_ROSERED forState:UIControlStateHighlighted];
    btn.titleLabel.font = [UIFont systemFontOfSize:15];
    ESWeak(self, weakSelf);
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.navigationView).offset(10);
        make.right.equalTo(weakSelf.navigationView.mas_right).offset(-5);
        make.size.mas_equalTo(CGSizeMake(80, 44));
    }];
    
}
#pragma mark - 按钮
//设成默认地址
- (void)addressBtnClick:(UIButton *)sender
{
    [self httpSetDefault];
}

//删除地址
- (void)deleteBtnClick:(UIButton *)sender
{
    
    TFPopBackgroundView *popView = [[TFPopBackgroundView alloc] initWithTitle:nil message:@"确定删除收货地址,此操作不可逆" showCancelBtn:NO leftBtnText:@"取消" rightBtnText:@"确定"];
    popView.textAlignment = NSTextAlignmentCenter;
    [popView setCancelBlock:^{
        
    } withConfirmBlock:^{
        [self httpDeleteAddress];
    } withNoOperationBlock:^{
        //
    }];
    [popView show];
    
}

//修改
- (void)changeBtnClick:(UIButton *)sender
{
    TFReviseAddressViewController *trvc = [[TFReviseAddressViewController alloc] init];
    trvc.model = self.model;
    [self.navigationController pushViewController:trvc animated:YES];
}

#pragma mark - 网络
- (void)httpDeleteAddress
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *token = [ud objectForKey:USER_TOKEN];
    NSString *urlStr;
    if (self.isDefault) {
        urlStr = [NSString stringWithFormat:@"%@address/delete?version=%@&token=%@&id=%@&is_default=1",[NSObject baseURLStr],VERSION,token,self.model.ID];
    } else {
        urlStr = [NSString stringWithFormat:@"%@address/delete?version=%@&token=%@&id=%@",[NSObject baseURLStr],VERSION,token,self.model.ID];
    }
    NSString *URL = [MyMD5 authkey:urlStr];
    //
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:URL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //
//        responseObject = [NSDictionary changeType:responseObject];
        if (responseObject!=nil) {
            
            if ([responseObject[@"status"] intValue] == 1) {
                [MBProgressHUD showSuccess:@"删除成功"];
                
                for (UIViewController *view in self.navigationController.viewControllers) {
                    if ([view isKindOfClass:[TFReceivingAddressViewController class]]) {
                        [(TFReceivingAddressViewController *)view httpReceivingAddress];
                    }
                }
//                TFReceivingAddressViewController *tfRv = (TFReceivingAddressViewController *)self.navigationController.viewControllers[self.navigationController.viewControllers.count-2];
//                
//                [tfRv httpReceivingAddress];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"deleteAddress" object:self.model];

                [self.navigationController popViewControllerAnimated:YES];
            } else {
                [MBProgressHUD showError:responseObject[@"message"]];
            }

        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MBProgressHUD showError:@"网络请求失败,请检查网络设置"];
    }];
}

- (void)httpSetDefault
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *token = [ud objectForKey:USER_TOKEN];
    
    NSString *urlStr = [NSString stringWithFormat:@"%@address/update?token=%@&version=%@&is_default=1&id=%@",[NSObject baseURLStr],token,VERSION,self.model.ID];
    NSString *URL = [MyMD5 authkey:urlStr];
    //
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:URL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //
//        responseObject = [NSDictionary changeType:responseObject];
        if (responseObject!=nil) {
            if ([responseObject[@"status"] intValue] == 1) {
                [MBProgressHUD showSuccess:@"设置成功"];
                
                
                TFReceivingAddressViewController *tfRv = (TFReceivingAddressViewController *)self.navigationController.viewControllers[self.navigationController.viewControllers.count-2];
                
                [tfRv httpReceivingAddress];
                
                [self.navigationController popViewControllerAnimated:YES];
            } else {
                [MBProgressHUD showError:responseObject[@"message"]];
            }

        }
        
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MBProgressHUD showError:@"网络请求失败,请检查网络设置"];
    }];

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
