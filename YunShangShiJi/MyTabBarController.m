//
//  XNTabBarController.m
//  车辆监控1.1版本
//
//  Created by Allen_12138 on 15-1-23.
//  Copyright (c) 2015年 粤峰通讯科技有限公司. All rights reserved.
//

#import "MyTabBarController.h"
#import "AppDelegate.h"
#import "GlobalTool.h"
#import "UIView+Animation.h"
#import "LoginViewController.h"
#import "MymineViewController.h"
#import "UIView+Animation.h"
#import "CFImagePickerVC.h"
@interface MyTabBarController ()
{
    NSArray *aryImage;    //未选中时的图片
    NSArray *arySelImage; //选中时的图片
    NSArray *aryTitle;    //所有标题
    int num;   //按钮的数量
    //    UIImageView *_Myview;
    NSUInteger lastIndex;
    
    CGRect _oldframe;
    
    BOOL selectTwoIndex;//判断是否有选择2的动画
    
    UIImageView *qdnImgView;
    UIImageView *qdaImgView;
}
//@property (nonatomic, assign) BOOL isAnimation;
//设置之前选中的按钮
@property (nonatomic,strong) UIButton *selectedBtn;
@property (nonatomic,strong) UIImageView *selectTwoImg;

@end

@implementation MyTabBarController
{
    //    UIButton *_btn;
    //    UIImageView *_imageView;
    //    UILabel *_labTitle;
}

- (void)showBadgeOnItemIndex:(int)index{
    
    
    //移除之前的小红点
    [self removeBadgeOnItemIndex:index];
    
    //新建小红点
    //    UIImageView *badgeView = [[UIImageView alloc]init];
    //    badgeView.image=[UIImage imageNamed:@"红点"];
    UILabel *badgeView = [[UILabel alloc]init];
    //    badgeView.layer.borderWidth=1.f;
    badgeView.layer.borderColor=[UIColor whiteColor].CGColor;
    badgeView.backgroundColor = tarbarrossred;
    badgeView.textColor=[UIColor whiteColor];
    badgeView.font=[UIFont systemFontOfSize:10];
    badgeView.textAlignment=NSTextAlignmentCenter;
    badgeView.tag=88+index;
    //    badgeView.frame = CGRectMake(kScreenWidth/num*index+kScreenWidth/num*7/12-2,5, 10, 10);
    badgeView.frame = CGRectMake(kScreenWidth/num*index+kScreenWidth/num/2+5,5, ZOOMPT(8), ZOOMPT(8));
    badgeView.layer.cornerRadius = ZOOMPT(4);
    //    badgeView.clipsToBounds=YES;
    badgeView.layer.masksToBounds = YES;//very important
    
    [self.tabBar addSubview:badgeView];
    
}
-(void)changeBadgeNumOnItemIndex:(int)index withNum:(NSString *)Num
{
    for (UILabel *subView in self.tabBar.subviews) {
        if (subView.tag == 88+index) {
            if (Num.integerValue!=0) {
                subView.frame = CGRectMake(kScreenWidth/num*index+kScreenWidth/num/2+5,2, 16, 16);
                subView.layer.cornerRadius = 8;
            }else{
                subView.frame = CGRectMake(kScreenWidth/num*index+kScreenWidth/num/2+5,5, ZOOMPT(8), ZOOMPT(8));
                subView.layer.cornerRadius = ZOOMPT(4);
            }
            subView.text=[NSString stringWithFormat:@"%@",Num.integerValue<100?Num:@"99"];
        }
    }
}
- (void)hideBadgeOnItemIndex:(int)index{
    
    //移除小红点
    [self removeBadgeOnItemIndex:index];
    
}

- (void)removeBadgeOnItemIndex:(int)index{
    
    //按照tag值进行移除
    for (UIView *subView in self.tabBar.subviews) {
        if (subView.tag == 88+index) {
            [subView removeFromSuperview];
        }
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.selectedViewController beginAppearanceTransition: YES animated: animated];
}

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.selectedViewController endAppearanceTransition];
}

- (void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.selectedViewController beginAppearanceTransition: NO animated: animated];
}

- (void) viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [self.selectedViewController endAppearanceTransition];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tabBarController.navigationController.delegate=self;
    [self.tabBar setBackgroundImage:[UIImage imageWithColor:[UIColor clearColor]]];
    [self.tabBar setShadowImage:[UIImage imageWithColor:[UIColor clearColor]]];
    
    //添加数据
//    num = 5;
//    lastIndex = 1;
//    aryImage = [[NSArray alloc] initWithObjects:@"icon_home_normal",@"icon_shoping_normal",@"icon_show_nor",@"tarbar_gouwuche_normal",@"icon_wode_normal", nil];
//    arySelImage = [[NSArray alloc] initWithObjects:@"icon_home_pressed",@"icon_shopping_pressed",@"icon_show_pre",@"tarbar_gouwuche_pre",@"icon_wode_pressed", nil];
//    aryTitle = [[NSArray alloc] initWithObjects:@"首页",@"购物",@"",@"购物车",@"我的", nil];
    
    num = 3;
    lastIndex = 1;
    aryImage = [[NSArray alloc] initWithObjects:@"icon_home_normal",@"icon_shoping_normal",@"icon_wode_normal", nil];
    arySelImage = [[NSArray alloc] initWithObjects:@"icon_home_pressed",@"icon_shopping_pressed",@"icon_wode_pressed", nil];
    aryTitle = [[NSArray alloc] initWithObjects:@"首页",@"购物",@"我的", nil];
    
    
    //删除现有的tabBar
    CGRect rect = self.tabBar.bounds;
    
    //添加自己的视图
    Myview= [[UIImageView alloc] init];
    Myview.userInteractionEnabled = YES;
//    Myview.frame = rect;
    Myview.frame = CGRectMake(rect.origin.x, rect.origin.y, rect.size.width, Height_NavBar);
    Myview.backgroundColor=[UIColor whiteColor];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 0.5)];
    line.backgroundColor=RGBCOLOR_I(197, 197, 197);;
    [Myview addSubview:line];
    
    [self.tabBar addSubview:Myview];
    for (int i = 0; i <num; i++) {
        
        
        //添加按钮
        UIButton  *btn = [[UIButton alloc] init];
        CGFloat x = i * Myview.frame.size.width / num;
        btn.frame = CGRectMake(x, 0, Myview.frame.size.width / num, Myview.frame.size.height);
        btn.userInteractionEnabled = YES;
        [Myview addSubview:btn];
        
        
        //添加图标
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake((btn.bounds.size.width-25)/2, 6, 23, 23)];
        _oldframe = imageView.frame;
        
//        if (i==2) {
//            imageView.frame=CGRectMake((btn.bounds.size.width-ZOOM6(126))/2,(49-ZOOM6(34))/2, ZOOM6(126), ZOOM6(34));
//            qdnImgView = imageView;
//            qdaImgView = [[UIImageView alloc] initWithFrame:imageView.frame];
//            qdaImgView.layer.opacity = 0;
//            [btn addSubview:qdaImgView];
//            /*
//            NSString *time = [[NSUserDefaults standardUserDefaults] objectForKey:IconAnimationTime];
//            NSString *currTime = [MyMD5 getCurrTimeString:@"year-month-day"];
//            if (time == nil || ![time isEqualToString:currTime]) {
//                [qdnImgView opacityStatus:YES time:2 fromValue:1 toValue:0];
//                [qdaImgView opacityStatus:YES time:2 fromValue:0 toValue:1];
//            } else {
//                [qdnImgView opacityStatus:NO time:2 fromValue:1 toValue:0];
//                [qdaImgView opacityStatus:NO time:2 fromValue:0 toValue:1];
//            }
//            */
//        }
        imageView.tag = 200+i;
        imageView.image = [UIImage imageNamed:aryImage[i]];
        [btn addSubview:imageView];
        
        //标题
        UILabel *labTitle = [[UILabel alloc] init];
        labTitle.tag = 300+i;
        labTitle.frame = CGRectMake(-1, 33, btn.bounds.size.width, 10);
        labTitle.textColor=RGBCOLOR_I(168, 168, 168);
        labTitle.text=aryTitle[i];
        labTitle.backgroundColor = [UIColor clearColor];
        labTitle.font = [UIFont systemFontOfSize:ZOOM(34)];
        labTitle.textAlignment = NSTextAlignmentCenter;
        [btn addSubview:labTitle];
        
        btn.tag = i+111;//设置按钮的标记, 方便来索引当前的按钮,并跳转到相应的视图
        
        
        //设置刚进入时,第一个按钮为选中状态
        if (1 == i) {
            
            imageView.image = [UIImage imageNamed:arySelImage[i]];
            labTitle.textColor = tarbarrossred;
            btn.selected = YES;
            self.selectedBtn = btn;  //设置该按钮为选中的按钮
        }
        
    }
}

-(void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
    [[UIApplication sharedApplication] setStatusBarHidden:FALSE];
    /*
    NSString *time = [[NSUserDefaults standardUserDefaults] objectForKey:IconAnimationTime];
    NSString *currTime = [MyMD5 getCurrTimeString:@"year-month-day"];
    if (time == nil || ![time isEqualToString:currTime]) {
        [qdnImgView opacityStatus:YES time:2 fromValue:1 toValue:0];
        [qdaImgView opacityStatus:YES time:2 fromValue:0 toValue:1];
    } else {
        [qdnImgView opacityStatus:NO time:2 fromValue:1 toValue:0];
        [qdaImgView opacityStatus:NO time:2 fromValue:0 toValue:1];
    }
    */
    NSUInteger tabIndex = [tabBar.items indexOfObject:item];
    //    UIButton *button = (UIButton *)[Myview viewWithTag:111+tabIndex];
//    if (tabIndex == self.selectedIndex){
//        if(tabIndex == 2 && self.selectTwoImg)
//        {
//            [self subclick];
//        }
//        return;
//    }
    
    if (tabIndex==4 || tabIndex==3) {
        if (tabIndex==4) {
            [[NSUserDefaults standardUserDefaults]setObject:[MyMD5 getCurrTimeString:@"year-month-day"] forKey:[NSString stringWithFormat:@"%@fourIndex",[[NSUserDefaults standardUserDefaults]objectForKey:USER_ID]]];
        }
        [Mtarbar hideBadgeOnItemIndex:(int)tabIndex];
    }
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:USER_TOKEN]==nil && (tabIndex == 4||tabIndex==3||tabIndex==2)) {
        kSelfWeak;
        [self.selectedViewController loginSuccess:^{
            weakSelf.selectedIndex = tabIndex;
        }];
    } else {
        NSInteger tag=self.selectedBtn.tag-111;
        UIImageView *imgView = (UIImageView *)[self.selectedBtn viewWithTag:200+tag];
        imgView.image = [UIImage imageNamed:aryImage[self.selectedBtn.tag-111]];
        UILabel *labTitle = (UILabel *)[self.selectedBtn viewWithTag:300+tag];
        labTitle.textColor=RGBCOLOR_I(168, 168, 168);
        
        
        self.selectedBtn = (UIButton *)[Myview viewWithTag:111+tabIndex];
        UIImageView *imgView2 = (UIImageView *)[self.selectedBtn viewWithTag:200+tabIndex];
        imgView2.image = [UIImage imageNamed:arySelImage[tabIndex]];
        UILabel *labTitle2 = (UILabel *)[self.selectedBtn viewWithTag:300+tabIndex];
        labTitle2.textColor = tarbarrossred;
        
//        if(tabIndex == 2){
//            [self changeTabbar];
//        }else {
            if (selectTwoIndex) {
                UIButton *qdbutton = (UIButton *)[Myview viewWithTag:111+2];
                qdbutton.transform = CGAffineTransformMakeScale(0.1, 0.1);
                [UIView animateWithDuration:0.25f animations:^{
                    self.selectTwoImg.transform = CGAffineTransformMakeScale(0.2, 0.2);
                    self.selectTwoImg.alpha = 0;
                    qdbutton.transform = CGAffineTransformMakeScale(1, 1);
                    qdbutton.alpha=1;
                    selectTwoIndex = NO;
                } completion:^(BOOL finish) {

                }];
            }
//        }
        /*
         for (int i=0; i<num; i++) {
         UIButton *btn = (UIButton *)[Myview viewWithTag:111+i];
         UILabel *labTitle = (UILabel *)[btn viewWithTag:300+i];
         UIImageView *imgView = (UIImageView *)[btn viewWithTag:200+i];
         imgView.frame = _oldframe;
         imgView.image = [UIImage imageNamed:aryImage[i]];
         labTitle.textColor=RGBCOLOR_I(168, 168, 168);
         labTitle.backgroundColor=[UIColor clearColor];
         if(i + 111 == button.tag ){
         if(i == 2){
         [self changeTabbar];
         }else {
         if (_selectTwoImg.superview) {
         UIButton *qdbutton = (UIButton *)[Myview viewWithTag:111+2];
         qdbutton.transform = CGAffineTransformMakeScale(0.1, 0.1);
         [UIView animateWithDuration:0.25f animations:^{
         _selectTwoImg.transform = CGAffineTransformMakeScale(0.2, 0.2);
         _selectTwoImg.alpha = 0;
         qdbutton.transform = CGAffineTransformMakeScale(1, 1);
         qdbutton.alpha=1;
         self.isAnimation = YES;
         } completion:^(BOOL finish) {
         selectTwoIndex = NO;
         [_selectTwoImg removeFromSuperview];
         self.isAnimation = NO;
         }];
         
         }
         imgView.image = [UIImage imageNamed:arySelImage[i]];
         labTitle.textColor = tarbarrossred;
         }
         
         }
         
         }
         */
    }
    
    NSArray *titleArray = @[@"小店",@"底部购物按钮",@"签到",@"购物车",@"我的"];
    
    [TFStatisticsClickVM handleDataWithPageType:nil withClickType:titleArray[tabIndex] success:nil failure:nil];
}

- (void)setSelectedIndex:(NSUInteger)selectedIndex
{
    [super setSelectedIndex:selectedIndex];
    
    NSInteger tag=self.selectedBtn.tag-111;
    UIImageView *imgView = (UIImageView *)[self.selectedBtn viewWithTag:200+tag];
    imgView.image = [UIImage imageNamed:aryImage[self.selectedBtn.tag-111]];
    UILabel *labTitle = (UILabel *)[self.selectedBtn viewWithTag:300+tag];
    labTitle.textColor=RGBCOLOR_I(168, 168, 168);
    
    
    UIButton *btn2 = (UIButton *)[Myview viewWithTag:selectedIndex+111];
    UIImageView *imgView2 = (UIImageView *)[btn2 viewWithTag:200+selectedIndex];
    UILabel *label2 = (UILabel *)[btn2 viewWithTag:300+selectedIndex];
    label2.textColor=tarbarrossred;
    imgView2.image=[UIImage imageNamed:arySelImage[selectedIndex]];
    
//    if(selectedIndex == 2 && selectTwoIndex == NO) {
//        [self changeTabbar];
//
//    }else if(selectTwoIndex && selectedIndex!=2) {
//        UIButton *qdbutton = (UIButton *)[Myview viewWithTag:111+2];
//        qdbutton.transform = CGAffineTransformMakeScale(0.1, 0.1);
//        [UIView animateWithDuration:0.25f animations:^{
//            self.selectTwoImg.transform = CGAffineTransformMakeScale(0.2, 0.2);
//            self.selectTwoImg.alpha = 0;
//            qdbutton.transform = CGAffineTransformMakeScale(1, 1);
//            qdbutton.alpha=1;
//        } completion:^(BOOL finish) {
//            selectTwoIndex = NO;
//        }];
//    }
    
    if(selectedIndex)
    {
        UIButton *qdbutton = (UIButton *)[Myview viewWithTag:111+2];
        qdbutton.transform = CGAffineTransformMakeScale(0.1, 0.1);
        [UIView animateWithDuration:0.25f animations:^{
            self.selectTwoImg.transform = CGAffineTransformMakeScale(0.2, 0.2);
            self.selectTwoImg.alpha = 0;
            qdbutton.transform = CGAffineTransformMakeScale(1, 1);
            qdbutton.alpha=1;
        } completion:^(BOOL finish) {
            selectTwoIndex = NO;
        }];
    }
    
    self.selectedBtn = btn2;
    
    
    /*
     for (int i = 0; i<aryImage.count; i++) {
     UIButton *btn = (UIButton *)[Myview viewWithTag:i+111];
     UIImageView *imgView = (UIImageView *)[btn viewWithTag:200+i];
     UILabel *label = (UILabel *)[btn viewWithTag:300+i];
     
     if (btn.tag != selectedIndex+111) {
     
     label.textColor=RGBCOLOR_I(168, 168, 168);
     if(i !=2)
     {
     //                label.textColor=RGBCOLOR_I(168, 168, 168);
     imgView.image = [UIImage imageNamed:aryImage[i]];
     
     }else{
     UIButton *qdbutton = (UIButton *)[Myview viewWithTag:111+2];
     
     if(selectTwoIndex == YES && selectedIndex != 2) {
     qdbutton.transform = CGAffineTransformMakeScale(0.1, 0.1);
     [UIView animateWithDuration:0.25f animations:^{
     self.selectTwoImg.transform = CGAffineTransformMakeScale(0.2, 0.2);
     self.selectTwoImg.alpha = 0;
     qdbutton.transform = CGAffineTransformMakeScale(1, 1);
     qdbutton.alpha=1;
     self.isAnimation = YES;
     } completion:^(BOOL finish) {
     selectTwoIndex = NO;
     //                        [_selectTwoImg removeFromSuperview];
     self.isAnimation = NO;
     }];
     
     }
     
     }
     
     
     
     } else {
     
     if(i == 2 && selectTwoIndex == NO)
     {
     [self changeTabbar];
     }
     
     label.textColor=tarbarrossred;
     imgView.frame = _oldframe;
     imgView.image=[UIImage imageNamed:arySelImage[i]];
     
     self.selectedBtn.selected = NO;
     btn.selected = YES;
     self.selectedBtn = btn;
     
     }
     
     }
     */
}
- (UIImageView *)selectTwoImg {
    if (_selectTwoImg==nil) {
        _selectTwoImg = [[UIImageView alloc]init];
//        _selectTwoImg.image = [UIImage imageNamed:@"bg_icon_qiandaoyouli"];
        _selectTwoImg.image = [UIImage imageNamed:@"icon_show_pre"];
        _selectTwoImg.userInteractionEnabled = YES;
        _selectTwoImg.clipsToBounds = YES;
        _selectTwoImg.layer.cornerRadius = 5;
        [Myview addSubview:_selectTwoImg];
        
        CGFloat Imgwith = 65;
        
        
//        UIImageView *qiandaoimg = [[UIImageView alloc]initWithFrame:CGRectMake((Imgwith-25)/2, 9, 25, 25)];
//        qiandaoimg.image = [UIImage imageNamed:@"icon_gift_pressed"];
//        
//        [_selectTwoImg addSubview:qiandaoimg];
        
        _selectTwoImg.frame=CGRectMake(2*Myview.frame.size.width/num+(Myview.frame.size.width / num-Imgwith)/2, -10, Imgwith, Imgwith);
    }
    return _selectTwoImg;
}
-(void)changeTabbar
{
    //    [_selectTwoImg removeFromSuperview];
    //    _selectTwoImg = [[UIImageView alloc]init];
    //    _selectTwoImg.image = [UIImage imageNamed:@"bg_icon_qiandaoyouli"];
    //    _selectTwoImg.userInteractionEnabled = YES;
    //    _selectTwoImg.clipsToBounds = YES;
    //    _selectTwoImg.layer.cornerRadius = 5;
    //    [Myview addSubview:_selectTwoImg];
    //    CGFloat Imgwith = 63;
    //
    //
    //    UIImageView *qiandaoimg = [[UIImageView alloc]initWithFrame:CGRectMake((Imgwith-25)/2, 9, 25, 25)];
    //    qiandaoimg.image = [UIImage imageNamed:@"icon_zhuanqian_pressed"];
    //
    //    [_selectTwoImg addSubview:qiandaoimg];
    //
    //    _selectTwoImg.frame=CGRectMake(2*Myview.frame.size.width/num+(Myview.frame.size.width / num-63)/2, 3, Imgwith, 43);
    
    self.selectTwoImg.transform = CGAffineTransformMakeScale(0.2, 0.2);
    
    UIButton *qdbutton = (UIButton *)[Myview viewWithTag:111+2];
    qdbutton.alpha=0;
    [UIView animateWithDuration:0.8f delay:0 usingSpringWithDamping:0.5f initialSpringVelocity:20.0f options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.selectTwoImg.transform = CGAffineTransformMakeScale(0.9, 0.9);
        self.selectTwoImg.alpha=1;
        selectTwoIndex = YES;
        
    } completion:^(BOOL finished) {
        
    }];
    
    NSString *currTime = [MyMD5 getCurrTimeString:@"year-month-day"];
    [[NSUserDefaults standardUserDefaults] setObject:currTime forKey:IconAnimationTime];
//    [qdnImgView opacityStatus:NO time:2 fromValue:1 toValue:0];
//    [qdaImgView opacityStatus:NO time:2 fromValue:0 toValue:1];
}

- (void)subclick
{
    kSelfWeak;
    [weakSelf loginSuccess:^{
        
        CFImagePickerVC *doimg = [[CFImagePickerVC alloc] init];
        doimg.nColumnCount = 4;
        doimg.nResultType = DO_PICKER_RESULT_UIIMAGE;
        doimg.nMaxCount = 1;
        doimg.isPublish=YES;
        doimg.refreshBlock = ^{
            
        };
        UINavigationController *nav=[[UINavigationController alloc]initWithRootViewController:doimg];
        [self presentViewController:nav animated:YES completion:nil];
        
    }];
}


/*
 [UIView animateKeyframesWithDuration:0.25f
 delay:0.0
 options:UIViewKeyframeAnimationOptionCalculationModeLinear
 animations:^{
 [UIView addKeyframeWithRelativeStartTime:0.0   // 相对于6秒所开始的时间（第0秒开始动画）
 relativeDuration:199/200.0 // 相对于6秒动画的持续时间（动画持续2秒）
 animations:^{
 _selectTwoImg.transform = CGAffineTransformMakeScale(1.2, 1.2);
 }];
 qiandaoimg.transform = CGAffineTransformMakeScale(0.6,0.6);
 
 [UIView addKeyframeWithRelativeStartTime:199/200.0 // 相对于6秒所开始的时间（第2秒开始动画）
 relativeDuration:1/200.0 // 相对于6秒动画的持续时间（动画持续2秒）
 animations:^{
 _selectTwoImg.transform = CGAffineTransformMakeScale(0.9, 0.9);
 qiandaoimg.transform = CGAffineTransformMakeScale(0.7, 0.7);
 selectTwoIndex = YES;
 }];
 
 }
 completion:^(BOOL finished) {
 
 }];
 */
//                        [UIView animateWithDuration:0.25f animations:^{
//                           _selectTwoImg.transform = CGAffineTransformMakeScale(1.2, 1.2);
////                            qiandaoimg.transform = CGAffineTransformMakeScale(0.7,0.7);
////                            qiandaoimg.alpha=1;
//                        } completion:^(BOOL finished) {
////                            [UIView animateWithDuration:0.02f animations:^{
////                                qiandaoimg.transform = CGAffineTransformMakeScale(0.8, 0.8);
//                                _selectTwoImg.transform = CGAffineTransformMakeScale(0.9, 0.9);
//                                selectTwoIndex = YES;
////                            } completion:^(BOOL finished) {
////                            }];
//                        }];
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)selectedToIndexViewController:(NSInteger)index
{
    UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
    UIViewController *topVC = [keyWindow topViewControllerWithRootViewController:keyWindow.rootViewController];
    //    UIViewController *visiaVC = [keyWindow visibleViewController];
    self.selectedIndex = index;
    [topVC.navigationController popToRootViewControllerAnimated:YES];
}


@end