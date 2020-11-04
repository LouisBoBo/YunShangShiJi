//
//  TFMemberSuccessViewController.m
//  YunShangShiJi
//
//  Created by 云商 on 16/2/26.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import "TFMemberSuccessViewController.h"
#import "MymineViewController.h"
@interface TFMemberSuccessViewController ()

@end

@implementation TFMemberSuccessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setNavigationItemLeft:@"激活成功"];
    

    [self createUI];

    [self dataInit];
    
}

- (void)dataInit
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *member = [NSString stringWithFormat:@"%@",@"2"]; //会员
    [ud setObject:member forKey:USER_MEMBER];
    [MyMD5 changeMemberPriceRate];
}

- (void)createUI
{
    CGFloat M_ud = ZOOM(500);
    
    CGFloat W_H_headIV = 100;
    
    UIImageView *headIV = [[UIImageView alloc] initWithFrame:CGRectMake((kScreenWidth-W_H_headIV)*0.5, M_ud, W_H_headIV, W_H_headIV)];
    
    headIV.layer.borderColor = [[UIColor blackColor] CGColor];
    headIV.layer.borderWidth = 1;
    headIV.layer.cornerRadius = W_H_headIV*0.5;
    headIV.layer.masksToBounds = YES;
    
    /**
     *  设置头像
     */
    NSUserDefaults *ud   = [NSUserDefaults standardUserDefaults];
    NSString *User_id    = [ud objectForKey:USER_ID];
    NSString *defaultPic = [ud objectForKey:USER_HEADPIC];

    NSString *aPath=[NSString stringWithFormat:@"%@/Documents/headImgae%@.png",NSHomeDirectory(),User_id];
    UIImage *imgFromUrl=[[UIImage alloc] initWithContentsOfFile:aPath];
    
    //defaultPic  %@",defaultPic);
    if (imgFromUrl!=nil) { //判断用户是否登陆
        headIV.image = imgFromUrl;
    } else {
        if ([defaultPic hasPrefix:@"http://"]) {
            [headIV sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",defaultPic]]];
        } else
            [headIV sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", [NSObject baseURLStr_Upy],defaultPic]]];
        //2.缓存图片到沙盒
        NSString *aPath=[NSString stringWithFormat:@"%@/Documents/headImgae%@.png",NSHomeDirectory(),User_id];
        NSData *imgData = UIImagePNGRepresentation(headIV.image);
        [imgData writeToFile:aPath atomically:YES];
    }

    [self.view addSubview:headIV];
    
    
    CGFloat X_center = headIV.center.x;
    CGFloat Y_center = headIV.center.y;
    
    UIImage *memberImg = [UIImage imageNamed:@"premium-services-big"];
    CGSize size_img = memberImg.size;
    
    CGFloat H_memImg = 40;
    
    CGFloat W = size_img.width*H_memImg/size_img.height;
    
    UIImageView *memberIV = [[UIImageView alloc] initWithFrame:CGRectMake(X_center+16, Y_center-H_memImg-28, W, H_memImg)];
    memberIV.image = memberImg;
    [self.view addSubview:memberIV];
    
    
    CGFloat M_ud_label = ZOOM(120);
    CGFloat H_label = ZOOM(67);
    CGFloat M_ud_label_label = ZOOM(60);
    
    NSArray *labelArr = [NSArray arrayWithObjects:@"支付成功", @"您已成功激活衣蝠至尊会员", nil];
    
    for (int i = 0; i<labelArr.count; i++) {
        
        CGFloat X_label     = 0;
        CGFloat Y_label     = CGRectGetMaxY(headIV.frame)+M_ud_label+i*H_label+i*M_ud_label_label;

        UILabel *label      = [[UILabel alloc] initWithFrame:CGRectMake(X_label, Y_label, kScreenWidth, H_label)];
        label.text          = labelArr[i];
        label.textAlignment = NSTextAlignmentCenter;
        label.font          = [UIFont systemFontOfSize:ZOOM(50)];
        [self.view addSubview:label];

    }
    
    [NSTimer weakTimerWithTimeInterval:2 target:self selector:@selector(back) userInfo:nil repeats:NO];
}


- (void)back
{
    for(UIViewController *vv in self.navigationController.viewControllers)
    {
        if([vv isKindOfClass:[MymineViewController class]])
        {
            [self.navigationController popToViewController:vv animated:YES];
            return;
        }
    }
        
}


- (void)leftBarButtonClick
{
    Mtarbar.selectedIndex = 4;
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
