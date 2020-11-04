//
//  WelcomeView.m
//  YunShangShiJi
//
//  Created by 云商 on 15/6/30.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//

#import "TFWelcomeView.h"
 
#import "CycleScrollView.h"


#define NUM 3

@interface TFWelcomeView () <UIScrollViewDelegate>
@property (nonatomic, strong)UIScrollView *scrollView;
@property (nonatomic, strong)UIPageControl *pageControl;
@property (nonatomic, assign)int index;
@end


@implementation TFWelcomeView

- (instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame]) {
        [self viewInit];
    }
    return self;
}

- (void)viewInit
{
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    self.scrollView.contentSize = CGSizeMake(NUM*kScreenWidth, kScreenHeight);
    self.scrollView.pagingEnabled = YES;
    self.scrollView.delegate = self;
    self.scrollView.bounces = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    [self addSubview:self.scrollView];
    
//    [self addSubview:self.pageControl];
    
    for (int i = 0; i<NUM; i++) {
        int j = i;
//        if (kDevice_Is_iPhone4) {
//            j = j+10;
//        }
        
        UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectMake(i*kScreenWidth, 0, kScreenWidth, kScreenHeight)];
        NSString *path = [NSString stringWithFormat:@"%@/welcome%d",[NSBundle mainBundle].resourcePath,j];
        iv.image = [UIImage imageWithContentsOfFile:path];
        [self.scrollView addSubview:iv];
        iv.userInteractionEnabled = YES;
        if (i == NUM-1) {
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick:)];
            [iv addGestureRecognizer:tap];
        }
    }
}
- (void)tapClick:(UITapGestureRecognizer *)tap
{
    if (self.welcomeBlock!=nil) {
        self.welcomeBlock();
        
        [UIView animateWithDuration:1 animations:^{
            self.transform = CGAffineTransformMakeScale(0.05, 0.05);
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
        }];
        

    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat f_index = (scrollView.contentOffset.x/CGRectGetWidth(scrollView.frame));
    
    int i_index = (int)(f_index*10)/10;

    if (i_index == NUM-1) {
        [self.pageControl removeFromSuperview];
    } else {
        BOOL bl = NO;
        for (UIView *view in self.subviews) {
            if (view == self.pageControl) {
                bl = YES;
            }
        }
        if (bl == NO) {
//            [self addSubview:self.pageControl];
        }
    }
    
    self.pageControl.currentPage = i_index;
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    self.index = scrollView.contentOffset.x/kScreenWidth;
    self.pageControl.currentPage = self.index;
    
    if (self.index == NUM-1) {
        
//        [self.pageControl removeFromSuperview];
    } else {
        BOOL bl = NO;
        for (UIView *view in self.subviews) {
            if (view == self.pageControl) {
                bl = YES;
            }
        }
        if (bl == NO) {
//            [self addSubview:self.pageControl];
        }
    }
    
}

- (UIPageControl *)pageControl
{
    if (_pageControl == nil) {
        _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, kScreenHeight-15, kScreenWidth, 10)];
        _pageControl.center = CGPointMake(self.frame.size.width/2, _pageControl.center.y);
        _pageControl.numberOfPages = NUM-1;
        _pageControl.tag = 10;
        _pageControl.tintColor = [UIColor whiteColor];
        _pageControl.currentPageIndicatorTintColor = COLOR_ROSERED;
    }
    return _pageControl;
}

@end
