//
//  TFIndianaRecordViewController.m
//  YunShangShiJi
//
//  Created by jingaiweiyi on 16/5/27.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import "TFIndianaRecordViewController.h"

@interface TFIndianaRecordViewController ()

@property (nonatomic, strong) TFIndianaRecordSubViewController *subVC_A;
@property (nonatomic, strong) TFIndianaRecordSubViewController *subVC_B;
@property (nonatomic ,strong) UIViewController *currentVC;

@end

@implementation TFIndianaRecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
//    [self setNavigationItem];
    [self setNavigationView];
}
- (void)setNavigationView
{
    [self setNavigationItemLeft: (_type & (IndianaRecords|IndianaRecords_TreasureGrop)) ? @"抽奖记录" : @"往期揭晓"];

    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = RGBCOLOR_I(220,220,220);
    [self.navigationView addSubview:lineView];

    kSelfWeak;
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(1);
        make.left.and.right.and.bottom.equalTo(weakSelf.navigationView).with.offset(0);
    }];

    NSArray *titleArray = @[@"我的参与纪录",
                            @"我的晒单纪录"];
    NSArray *titleArray2 = @[@"往期揭晓",
                             @"晒单分享"];

    if (_type & (IndianaRecords|IndianaRecords_TreasureGrop)) {
        TFIndianaRecordSubViewController *subVC_A = [[TFIndianaRecordSubViewController alloc] init];
        _subVC_A = subVC_A;
        _subVC_A.selectIndex = _type==IndianaRecords ? SelectTypeMy : SelectTypeMy_TreasureGroup;
        _subVC_A.titleArray = titleArray;

        [self addChildViewController:self.subVC_A];
        [self.view addSubview:self.subVC_A.view];
        self.currentVC  = self.subVC_A;
    }else {
        TFIndianaRecordSubViewController *subVC_B = [[TFIndianaRecordSubViewController alloc] init];
        _subVC_B = subVC_B;
        _subVC_B.selectIndex = _type==IndianaAnnounce ? SelectTypeOthers : SelectTypeOthers_TreasureGrop;
        _subVC_B.titleArray = titleArray2;
        [self addChildViewController:self.subVC_B];
        [self.view addSubview:self.subVC_B.view];
    }

}
- (void)setNavigationItem
{
    ESWeakSelf;
    [self setNavigationItemLeft:@""];
    
    NSArray *segArray = @[@"抽奖纪录", @"往期揭晓"];
    
    UISegmentedControl *segControl = [[UISegmentedControl alloc] initWithItems:segArray];
    CGFloat segW = ZOOM6(400);
    CGFloat segH = 29;

    [segControl setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                        [UIFont systemFontOfSize:ZOOM6(32)],NSFontAttributeName,nil] forState:UIControlStateNormal];
    
    segControl.tintColor = COLOR_ROSERED;
    [self.navigationView addSubview:segControl];
    segControl.selectedSegmentIndex = 0;
    [segControl addTarget:self
                                action:@selector(segAction:)
         forControlEvents:UIControlEventValueChanged];
    [segControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(segW);
        make.centerX.equalTo(__weakSelf.navigationView.mas_centerX);
        make.top.equalTo(@27);
        make.height.mas_equalTo(segH);
    }];
    
    
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = RGBCOLOR_I(220,220,220);
    [self.navigationView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(1);
        make.left.and.right.and.bottom.equalTo(__weakSelf.navigationView).with.offset(0);
    }];
    
    NSArray *titleArray = @[@"我的参与纪录",
                            @"我的晒单纪录"];
    NSArray *titleArray2 = @[@"往期揭晓",
                            @"晒单分享"];
    
    TFIndianaRecordSubViewController *subVC_A = [[TFIndianaRecordSubViewController alloc] init];
    _subVC_A = subVC_A;
    _subVC_A.selectIndex = SelectTypeMy;
    _subVC_A.titleArray = titleArray;

    TFIndianaRecordSubViewController *subVC_B = [[TFIndianaRecordSubViewController alloc] init];
    _subVC_B = subVC_B;
    _subVC_B.selectIndex = SelectTypeOthers;
    _subVC_B.titleArray = titleArray2;
    [self addChildViewController:self.subVC_A];
    [self.view addSubview:self.subVC_A.view];
    self.currentVC  = self.subVC_A;
    
}

- (void)segAction:(UISegmentedControl *)sender
{
//    MyLog(@"seletorIndex = %ld", (unsigned long)sender.selectedSegmentIndex);

    if ((self.currentVC == self.subVC_A && sender.selectedSegmentIndex == 0)||(self.currentVC == self.subVC_B && sender.selectedSegmentIndex == 1)) {
        return;
    } else {
        switch (sender.selectedSegmentIndex) {
            case 0:
                [self replaceController:self.currentVC newController:self.subVC_A];
                break;
            case 1:
                [self replaceController:self.currentVC newController:self.subVC_B];
                break;
            default:
                break;
        }
    }    
}

- (void)replaceController:(UIViewController *)oldController newController:(UIViewController *)newController
{
    [self addChildViewController:newController];
    [self transitionFromViewController:oldController toViewController:newController duration:0 options:0 animations:nil completion:^(BOOL finished) {
        
        if (finished) {
            
            [newController didMoveToParentViewController:self];
            [oldController removeFromParentViewController];
            self.currentVC = newController;
            
        } else{
            
            self.currentVC = oldController;
            
        }
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
