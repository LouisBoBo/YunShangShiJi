
//
//  TFIndianaRecordSubViewController.m
//  YunShangShiJi
//
//  Created by jingaiweiyi on 16/5/28.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import "TFIndianaRecordSubViewController.h"
#import "TFShareOrderViewController.h"
#import "TFInvolvedUncoverViewController.h"
@interface TFIndianaRecordSubViewController () <UIScrollViewDelegate>

@property (nonatomic, strong) TFInvolvedUncoverViewController *subVC_A;
@property (nonatomic, strong) TFShareOrderViewController *subVC_B;

@property (nonatomic, strong) UIViewController *currentVC;
@property (nonatomic, assign) NSInteger leftAndRightPage;

@end

@implementation TFIndianaRecordSubViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupUI];
    
}

- (void)setupUI
{
    self.view.backgroundColor = [UIColor whiteColor];
    ESWeakSelf;
    if (!_titleView) {
        
        _titleView = ({
            UIView *titleView = [UIView new];
            [self.view addSubview:titleView];
//            titleView.backgroundColor = COLOR_RANDOM;
            [titleView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(__weakSelf.view);
                make.left.and.right.equalTo(__weakSelf.view);
                make.height.mas_equalTo(ZOOM6(80));
            }];
            
            UIButton *leftBtn = [UIButton new];
//            leftBtn.backgroundColor = COLOR_RANDOM;
            [leftBtn setTitle:_titleArray[0] forState:UIControlStateNormal];
            leftBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
            [leftBtn setTitleColor:COLOR_ROSERED forState:UIControlStateSelected];
            leftBtn.titleLabel.font = kFont6px(30);
            leftBtn.tag = 100;
            [leftBtn setTitleColor:RGBCOLOR_I(62,62,62) forState:UIControlStateNormal];
            
            [titleView addSubview:leftBtn];
            
            UIButton *rightBtn = [UIButton new];
//            rightBtn.backgroundColor = COLOR_RANDOM;
            [rightBtn setTitle:_titleArray[1] forState:UIControlStateNormal];
            [rightBtn setTitleColor:COLOR_ROSERED forState:UIControlStateSelected];
            rightBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
            [rightBtn setTitleColor:RGBCOLOR_I(62,62,62) forState:UIControlStateNormal];
            rightBtn.titleLabel.font = kFont6px(30);
            rightBtn.tag = 101;
            [titleView addSubview:rightBtn];
            
            [leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.and.bottom.left.mas_equalTo(0);
                make.width.equalTo(titleView.mas_width).with.multipliedBy(0.5);
            }];
            
            [rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.and.bottom.right.mas_equalTo(0);
                make.width.equalTo(titleView.mas_width).with.multipliedBy(0.5);
            }];
            
            if (self.leftAndRightPage == 0) {
                leftBtn.selected = YES;
            } else {
                rightBtn.selected = YES;
            }
            
            UIView *leftLineView = [UIView new];
            leftLineView.backgroundColor = COLOR_ROSERED;
            [titleView addSubview:leftLineView];
            
            UIView *rightLineView = [UIView new];
            rightLineView.backgroundColor = COLOR_ROSERED;
            [titleView addSubview:rightLineView];
            
            leftLineView.tag = 200;
            rightLineView.tag = 201;
            
            leftLineView.hidden = !leftBtn.selected;
            rightLineView.hidden = !rightBtn.selected;
            
            [leftLineView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(leftBtn.mas_centerX);
                make.bottom.mas_equalTo(0);
                make.height.mas_equalTo(ZOOM6(4));
                make.width.mas_equalTo(ZOOM6(240));
                
            }];
            [rightLineView mas_makeConstraints:^(MASConstraintMaker *make) {
                
                make.centerX.equalTo(rightBtn.mas_centerX);
                make.bottom.mas_equalTo(0);
                make.height.mas_equalTo(ZOOM6(4));
                make.width.mas_equalTo(ZOOM6(240));
                
            }];
            
            [leftBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
            [rightBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
     
            titleView;
        });
       
    }
    
    if (!_backgroundScrollView) {
        _backgroundScrollView = ({
            UIScrollView *backgScrollView = [UIScrollView new];
            [self.view addSubview:backgScrollView];
            backgScrollView.pagingEnabled = YES;
            backgScrollView.backgroundColor = [UIColor whiteColor];
            
            [backgScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(_titleView.mas_bottom);
                make.left.and.right.and.bottom.mas_equalTo(0);
                make.width.mas_equalTo(kScreenWidth);
            }];
            
            TFInvolvedUncoverViewController *subVC_A = [[TFInvolvedUncoverViewController alloc] init];
            _subVC_A = subVC_A;
            self.currentVC = _subVC_A;
            
            if (self.selectIndex & (SelectTypeMy|SelectTypeMy_TreasureGroup)) {
                _subVC_A.myTypeIndex = self.selectIndex==SelectTypeMy ? MyTypeTheMine : MyTypeTheMine_TreasureGroup;
            } else {
                _subVC_A.myTypeIndex = self.selectIndex==SelectTypeOthers ? MyTypeTheOthers : MyTypeTheOthers_TreasureGroup;
            }
            
            [self addChildViewController:self.subVC_A];
            [backgScrollView addSubview:_subVC_A.view];
            
            TFShareOrderViewController *subVC_B = [[TFShareOrderViewController alloc] init];
            _subVC_B = subVC_B;
            if (self.selectIndex & (SelectTypeMy|SelectTypeMy_TreasureGroup)) {
                subVC_B.myShareTypeIndex = MyShareTypeMine;
            } else {
                subVC_B.myShareTypeIndex = self.selectIndex==SelectTypeOthers ? MyShareTypeOthers : MyShareTypeOthers_TreasureGrop;
            }
            [self addChildViewController:self.subVC_B];
            [backgScrollView addSubview:_subVC_B.view];
            
            backgScrollView.contentSize = CGSizeMake(kScreenWidth*self.titleArray.count, 0);
            backgScrollView.delegate = self;
            backgScrollView.scrollsToTop = NO;
            backgScrollView.showsHorizontalScrollIndicator = NO;
            
            backgScrollView;
        });
    }
    
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSInteger index = (NSInteger)scrollView.contentOffset.x / kScreenWidth;
    self.leftAndRightPage = index;
//    [self moveEvent:index];
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self indexWithscrollView:scrollView];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    [self indexWithscrollView:scrollView];
}

- (void)indexWithscrollView:(UIScrollView *)scrollView
{
    NSInteger index = (NSInteger)scrollView.contentOffset.x / kScreenWidth;
    [self moveEvent:index];
}

- (void)buttonClick:(UIButton *)sender
{
    NSInteger index = sender.tag-100;
    [self.backgroundScrollView setContentOffset:CGPointMake(kScreenWidth*index, 0) animated:YES];
    [self moveEvent:index];
}

- (void)moveEvent: (NSInteger)index
{
    self.leftAndRightPage = index;
    for (NSInteger i = 0; i<_titleArray.count; i++) {
        UIButton *btn = (UIButton *)[self.titleView viewWithTag:100+i];
        UIView *view = (UIView *)[self.titleView viewWithTag:200+i];
        if (btn.tag == 100 + index) {
            btn.selected = YES;
            view.hidden = !btn.selected;
        } else {
            btn.selected = NO;
            view.hidden = !btn.selected;
        }
    }
}

- (void)loadView
{
    UIView *view = [UIView new];
    view.frame = CGRectMake(0, kNavigationheightForIOS7, kScreenWidth, kScreenHeight-kNavigationheightForIOS7);
    self.view = view;
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
