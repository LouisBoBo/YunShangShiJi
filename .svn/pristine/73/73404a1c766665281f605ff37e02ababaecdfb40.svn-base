//
//  BrandStyleView.m
//  BrandStyleView
//
//  Created by yssj on 2017/3/31.
//  Copyright © 2017年 CooFree. All rights reserved.
//

#import "BrandStyleView.h"
#import "MultilevelMenu.h"
#import "LeftStyleView.h"
#import "NavgationbarView.h"

#import "GlobalTool.h"
#import "WaterFallFlowViewModel.h"

#define kScreenWidth          [[UIScreen mainScreen] bounds].size.width           //(e.g. 320)
#define kScreenHeight         [[UIScreen mainScreen] bounds].size.height          //(e.g. 480)
#define kRedColor [UIColor colorWithRed:255/255.0 green:63/255.0 blue:139/255.0 alpha:255/255.0]


typedef void(^BtnClickBlock)(NSInteger index);
@interface BSTopView : UIView {
    CALayer *_indicatorLayer;
}

@property (nonatomic,assign)BOOL rightBtnEnabled;
@property (copy,nonatomic)BtnClickBlock btnBlock;
@property (copy, nonatomic) NSMutableArray *items;
@property (assign, nonatomic) UIButton *selectedItem;

@property (nonatomic,strong)UIButton *leftBtn;
@property (nonatomic,strong)UIButton *rightBtn;
@property (nonatomic,strong)UIImageView *imgView;

- (void)setSelectedItem:(UIButton *)selectedItem;
- (void)selectBtnAtIndex:(NSInteger )afterIndex;

@end
@implementation BSTopView

- (NSMutableArray *)items {
    if (_items==nil) {
        _items=[NSMutableArray array];
    }
    return _items;
}
- (UIButton *)leftBtn {
    if (_leftBtn==nil) {
        _leftBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        _leftBtn.frame=CGRectMake(0, 0, self.frame.size.width/2, self.frame.size.height);
        [_leftBtn setTitleColor:kMainTitleColor forState:UIControlStateNormal];
        [_leftBtn setTitleColor:kMainTitleColor forState:UIControlStateNormal|UIControlStateHighlighted];
        [_leftBtn setTitleColor:kRedColor forState:UIControlStateSelected];
        [_leftBtn setTitleColor:kRedColor forState:UIControlStateSelected|UIControlStateHighlighted];
        [_leftBtn setTitle:@"选择风格" forState:UIControlStateNormal];
        [_leftBtn addTarget:self action:@selector(setSelectedItem:) forControlEvents:UIControlEventTouchUpInside];
        _leftBtn.titleLabel.font = [UIFont systemFontOfSize:ZOOM6(30)];
    }
    return _leftBtn;
}
- (UIButton *)rightBtn {
    if (_rightBtn==nil) {
        _rightBtn=[[UIButton alloc]initWithFrame:CGRectMake(self.frame.size.width/2, 0, self.frame.size.width/2, self.frame.size.height)];
        [_rightBtn setTitleColor:kMainTitleColor forState:UIControlStateNormal];
        [_rightBtn setTitleColor:kMainTitleColor forState:UIControlStateNormal|UIControlStateHighlighted];
        [_rightBtn setTitleColor:kRedColor forState:UIControlStateSelected];
        [_rightBtn setTitleColor:kRedColor forState:UIControlStateSelected|UIControlStateHighlighted];
        [_rightBtn setTitle:@"选择类目" forState:UIControlStateNormal];
        [_rightBtn addTarget:self action:@selector(setSelectedItem:) forControlEvents:UIControlEventTouchUpInside];
        _rightBtn.titleLabel.font = [UIFont systemFontOfSize:ZOOM6(30)];
    }
    return _rightBtn;
}
- (UIImageView *)imgView {
    if (_imgView==nil) {
        _imgView=[[UIImageView alloc]initWithFrame:CGRectMake(self.frame.size.width/2-ZOOM6(10), self.frame.size.height/2-ZOOM6(10), ZOOM6(20), ZOOM6(20))];
        _imgView.contentMode=UIViewContentModeScaleAspectFit;
//        _imgView.backgroundColor=[UIColor brownColor];
        _imgView.image=[UIImage imageNamed:@"help_more"];
    }
    return _imgView;
}
- (instancetype)initWithFrame:(CGRect)frame {
    if (self=[super initWithFrame:frame]) {
        [self addSubview:self.leftBtn];
        [self addSubview:self.rightBtn];
        [self addSubview:self.imgView];
        
        //按钮数组
        [self.items addObject:self.leftBtn];
        [self.items addObject:self.rightBtn];
        
        //线条
        _indicatorLayer = [CALayer layer];
        [_indicatorLayer setBackgroundColor:[kRedColor CGColor]];
        [self.layer addSublayer:_indicatorLayer];
        
        //设置选中左按钮
        [self setSelectedItem:self.leftBtn];

    }
    return self;
}
- (void)layoutIndicatorLayerWithButton:(UIButton *)button
{
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    CGFloat height = CGRectGetHeight(self.bounds);
    [_indicatorLayer setFrame:(CGRect){
        CGRectGetMinX(button.frame)+CGRectGetWidth(button.frame)/4, height - 2.0,
        CGRectGetWidth(button.frame)/2, 2.0
    }];
    [CATransaction commit];
}
- (void)setSelectedItem:(UIButton *)selectedItem
{
    if (!_rightBtnEnabled&&selectedItem==self.rightBtn) {//是否可点击右按钮
        NavgationbarView *mentionview=[[NavgationbarView alloc]init];
        [mentionview showLable:@"请选择风格" Controller:nil];
        return;
    }
    
    NSInteger afterIndex = [_items indexOfObject:selectedItem];

//    if (_selectedItem != selectedItem) {
    
        if (self.btnBlock) {
            self.btnBlock(afterIndex);
        }
        [self selectBtnAtIndex:afterIndex];
    
//    }
}
- (void)selectBtnAtIndex:(NSInteger )afterIndex {
    NSUInteger beforeIndex = [_items indexOfObject:_selectedItem];
    if (beforeIndex != NSNotFound) {
        [self.items[beforeIndex] setSelected:NO];
    }
    if (afterIndex != NSNotFound) {
        UIButton *button = self.items[afterIndex];
        _selectedItem = [_items objectAtIndex:afterIndex];
        [button setSelected:YES];
        
        [self layoutIndicatorLayerWithButton:button];
    }
}
@end

#pragma mark - BrandStyleView
@interface BrandStyleView()<UIScrollViewDelegate>
{
    CGFloat kBS_Height;
    CGFloat topHeight;

}

@property (nonatomic,strong)UIView *contentView;
@property (nonatomic,strong)UIScrollView *ScrollView;
@property (nonatomic,strong)BSTopView *topView;
@property (nonatomic,strong)LeftStyleView *leftStyleView;
@property (nonatomic,strong)MultilevelMenu *rightMenu;
@property(strong,nonatomic,readonly) NSArray * allData;

@end

@implementation BrandStyleView

-(instancetype)initWithData:(NSArray *)data {
    self=[super init];
    if (self) {
        _allData=data;
    }
    return self;
}

- (void)setLeftData:(NSArray *)leftData {
    if (_leftData != leftData) {
        _leftData=leftData;
    }
}
- (void)setUI {
    
//    kBS_Height = MAX((kScreenWidth), (kScreenWidth-ZOOM6(20)*2)*5);
    kBS_Height=(kScreenWidth-ZOOM6(20)*2);
    topHeight = ZOOM6(80);
    self.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
    self.contentView.transform = CGAffineTransformMakeScale(0, 0);

    UIButton *btn=[[UIButton alloc]initWithFrame:self.frame];
    [btn addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
//    if (_allData.count==0||_leftData.count==0) {
        [self addSubview:btn];
//    }
    
    
    [self addSubview:self.contentView];
    [self.contentView addSubview:self.topView];
    [self.contentView addSubview:self.ScrollView];
    [self.ScrollView addSubview:self.leftStyleView];
    [self.ScrollView addSubview:self.rightMenu];

}
- (void)show {
    [self setUI];
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    [window addSubview:self];
    
    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.6 initialSpringVelocity:0.1 options:UIViewAnimationOptionCurveEaseIn animations:^{
        self.backgroundColor = [[UIColor colorWithRed:0 green:0 blue:0 alpha:0] colorWithAlphaComponent:0.5];
        self.contentView.transform = CGAffineTransformMakeScale(1, 1);
        self.contentView.alpha = 1;
        
    } completion:^(BOOL finished) {
        //
    }];
}
- (void)dismiss {
    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        self.alpha = 0;
        self.contentView.transform = CGAffineTransformMakeScale(0.25, 0.25);
        self.contentView.alpha = 0;
    } completion:^(BOOL finished) {
        [self.contentView removeFromSuperview];
        [self removeFromSuperview];
    }];
}
- (UIScrollView *)ScrollView {
    if (_ScrollView==nil) {
        _ScrollView =[[UIScrollView alloc]initWithFrame:CGRectMake(0, topHeight, kScreenWidth-ZOOM6(30)*2, kBS_Height)];
        _ScrollView.contentSize=CGSizeMake((kScreenWidth-ZOOM6(30)*2)*2, kBS_Height);
        _ScrollView.delegate=self;
        _ScrollView.showsHorizontalScrollIndicator=NO;
        _ScrollView.pagingEnabled=YES;
        _ScrollView.scrollEnabled=NO;
    }
    return _ScrollView;
}
- (UIView *)contentView {
    if (_contentView==nil) {
        _contentView=[[UIView alloc]initWithFrame:CGRectMake(ZOOM6(30), 0, kScreenWidth-ZOOM6(30)*2, kBS_Height+topHeight)];
        _contentView.backgroundColor = [UIColor whiteColor];
        _contentView.layer.masksToBounds = YES;
        _contentView.layer.cornerRadius = 5;
        _contentView.center=self.center;
    }
    return _contentView;
}
- (BSTopView *)topView {
    if (_topView==nil) {
        _topView=[[BSTopView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth-ZOOM6(30)*2, topHeight)];
        _topView.backgroundColor=[UIColor whiteColor];
        __weak typeof(self) weakSelf = self;
        _topView.btnBlock = ^(NSInteger index) {
            [weakSelf.ScrollView scrollRectToVisible:CGRectMake(index*(kScreenWidth-ZOOM6(30)*2),0,kScreenWidth-ZOOM6(30)*2,64*4) animated:YES];
        };
    }
    return _topView;
}
- (LeftStyleView *)leftStyleView {
    if (_leftStyleView==nil) {
        __weak typeof(self) weakSelf = self;
        _leftStyleView=[[LeftStyleView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth-ZOOM6(30)*2, kBS_Height) WithData:self.leftData withSelectIndex:^(NSInteger left, id right, id info) {
            weakSelf.topView.rightBtnEnabled=YES;
            weakSelf.ScrollView.scrollEnabled=YES;
            [weakSelf.topView setSelectedItem:weakSelf.topView.rightBtn];
            [weakSelf.delegate leftMenuSelectLeft:left right:right info:info];
        }];
    }
    return _leftStyleView;
}
- (MultilevelMenu *)rightMenu {
    if (_rightMenu==nil) {
        /**
         默认是 选中第一行
         */
        __weak typeof(self) weakSelf = self;
        MultilevelMenu * view=[[MultilevelMenu alloc] initWithFrame:CGRectMake(kScreenWidth-ZOOM6(30)*2, 0, kScreenWidth-ZOOM6(30)*2, kBS_Height) WithData:_allData withSelectIndex:^(NSInteger left, NSInteger right,rightMeun* info) {
            [weakSelf.delegate rightMenuSelectLeft:left right:right info:info];
            [weakSelf dismiss];
        }];
        
        view.needToScorllerIndex=0;
        view.isRecordLastScroll=YES;
        _rightMenu=view;
    }
    return _rightMenu;
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView.isDragging) {
        NSInteger newSelectedIndex = round(scrollView.contentOffset.x / scrollView.contentSize.width * 2);
        newSelectedIndex = MIN(1, MAX(0, newSelectedIndex));
        NSInteger afterIndex = [self.topView.items indexOfObject:self.topView.selectedItem];

        if (newSelectedIndex!=afterIndex) {
//            [self.topView setSelectedItem:newSelectedIndex?self.topView.rightBtn:self.topView.leftBtn];
            [self.topView selectBtnAtIndex:newSelectedIndex];
        }
    }
}
@end
