//
//  YFAddShopBottomView.m
//  YunShangShiJi
//
//  Created by zgl on 16/6/20.
//  Copyright © 2016年 ios-1. All rights reserved.
//  搭配购底部

#import "YFAddShopBottomView.h"
#import "GlobalTool.h"

@interface YFAddShopBottomView ()
{
    BOOL _isTopHiden;
}
@property (nonatomic, strong) UIView *topView;
@property (nonatomic, strong) UIView *centerView;
@property (nonatomic, strong) UIView *bottomView;

@end

@implementation YFAddShopBottomView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _isTopHiden = YES;
        [self addSubview:self.topView];
        [self addSubview:self.centerView];
        [self addSubview:self.bottomView];
    }
    return self;
}

#pragma mark - 点击
- (void)btnClick:(UIView *)sender {
    if (sender.tag - 20001 == 3 && ((UIButton *)sender).selected == NO)
        return;
    
    if (_delegate && [_delegate respondsToSelector:@selector(buttonClickType:)]) {
        [_delegate buttonClickType:sender.tag - 20001];
    }
}

#pragma mark - setter
- (void)setTopIsHidden:(BOOL)hidden {
    if (_isTopHiden == hidden) {
        return;
    }
    _isTopHiden = hidden;
    _topView.top = hidden?-kZoom6pt(40):kZoom6pt(40);
    _centerView.top = hidden?0:kZoom6pt(40);
    _bottomView.top = hidden?kZoom6pt(40):kZoom6pt(80);
    [UIView animateWithDuration:0.5 animations:^{
        _topView.top = 0;
    }];
}

- (void)setIsAllSelect:(BOOL)isAllSelect {
    _isAllSelect = isAllSelect;
    [_selectBtn setSelected:_isAllSelect];
    //不知道为什么iphone5上这个按钮有问题，只能这样设置了
    [_selectBtn setImage:[UIImage imageNamed:_isAllSelect?@"icon_dapeigou_celect":@"icon_dapeigou_normal"] forState:UIControlStateNormal];
}

#pragma mark - getter
- (UIView *)topView {
    if (nil == _topView) {
        _topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, kZoom6pt(40))];
        _topView.backgroundColor =  [UIColor colorWithWhite:0 alpha:0.8];
        UILabel *label = [[UILabel alloc] init];
        label.textColor = [UIColor whiteColor];
        label.font = [UIFont systemFontOfSize:kZoom6pt(14)];
        label.text = @"商品将保留30分钟";
        [_topView addSubview:label];

        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitleColor:tarbarrossred forState:UIControlStateNormal];
        [button setTitle:@"立即结算 >" forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:kZoom6pt(14)];
        button.tag = 20001;
        [button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_topView addSubview:button];
        
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@(kZoom6pt(10)));
            make.centerY.equalTo(_topView);
        }];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(@(-kZoom6pt(10)));
            make.centerY.equalTo(_topView);
        }];
    }
    return _topView;
}

- (UIView *)centerView {
    if (nil == _centerView) {
        _centerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, kZoom6pt(40))];
        _centerView.backgroundColor =  [UIColor colorWithRed:1.0 green:1.0 blue:203/255.0 alpha:1];
#if 0
        _selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _selectBtn.frame = CGRectMake(kZoom6pt(10), kZoom6pt(10), kZoom6pt(20), kZoom6pt(20));
        [_selectBtn setImage:[UIImage imageNamed:@"icon_dapeigou_normal"] forState:UIControlStateNormal];
        _selectBtn.tag = 20002;
        [_selectBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_centerView addSubview:_selectBtn];
#endif
        _centerLabel = [[UILabel alloc] initWithFrame:CGRectMake(kZoom6pt(10), 0, self.frame.size.width - kZoom6pt(20), kZoom6pt(40))];
        _centerLabel.textColor = [UIColor colorWithWhite:125/255. alpha:1];
        _centerLabel.font = [UIFont systemFontOfSize:kZoom6pt(12)];
        _centerLabel.attributedText = [NSString getOneColorInLabel:@"0件商品共¥0,搭配购为您节省¥0" strs:@[@"¥0",@"¥0"] Color:tarbarrossred fontSize:kZoom6pt(12)];
        [_centerView addSubview:_centerLabel];
    }
    return _centerView;
}

- (UIView *)bottomView {
    if (nil == _bottomView) {
        _bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, kZoom6pt(40), self.frame.size.width, kZoom6pt(50))];
        _bottomView.backgroundColor =  [UIColor whiteColor];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(kZoom6pt(10), 0, kScreenWidth/2 - kZoom6pt(20), kZoom6pt(50))];
        label.textColor = [UIColor colorWithWhite:168/255. alpha:1];
        label.font = [UIFont systemFontOfSize:kZoom6pt(11)];
        label.numberOfLines = 0;

        NSString *dpZheKou = [[NSUserDefaults standardUserDefaults]objectForKey:@"dpZheKou"];
        NSString *colorStr = [NSString stringWithFormat:@"%.1f折",dpZheKou.floatValue*10];
        NSString *text = [NSString stringWithFormat:@"任意2件商品\n可享受搭配购%@优惠",colorStr];//@"任意2件商品\n可享受搭配购9折优惠";
        label.attributedText = [NSString getOneColorInLabel:text ColorString:colorStr Color:tarbarrossred fontSize:kZoom6pt(11)];
        [_bottomView addSubview:label];
#if 0
        _carBtn = [[YFShopCarView alloc] initWithFrame:CGRectMake(kZoom6pt(132), 0, kScreenWidth - kZoom6pt(282), kZoom6pt(50))];
        _carBtn.tag = 20003;
        __weak typeof(self) weakSelf = self;
        _carBtn.btnClick = ^(YFShopCarView *view){
            [weakSelf btnClick:view];
        };
        [_bottomView addSubview:_carBtn];
#endif
        _addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _addBtn.frame = CGRectMake(kScreenWidth/2, 0, kScreenWidth/2, kZoom6pt(50));
        _addBtn.tag = 20004;
        [_addBtn setBackgroundImage:[UIImage imageWithColor:kbackgrayColor] forState:UIControlStateNormal];
        [_addBtn setBackgroundImage:[UIImage imageWithColor:tarbarrossred] forState:UIControlStateSelected];
        [_addBtn setBackgroundImage:[UIImage imageWithColor:kbackgrayColor] forState:UIControlStateNormal|UIControlStateHighlighted];
        [_addBtn setBackgroundImage:[UIImage imageWithColor:tarbarrossred] forState:UIControlStateSelected|UIControlStateHighlighted];
        [_addBtn setTitle:@"立即结算" forState:UIControlStateNormal];
        [_addBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _addBtn.titleLabel.font = [UIFont boldSystemFontOfSize:kZoom6pt(16)];
        [_addBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_bottomView addSubview:_addBtn];
        
        UIView *lineW = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth/2, 0.5)];
        lineW.backgroundColor = [UIColor colorWithWhite:220/255. alpha:1];
        [_bottomView addSubview:lineW];
    }
    return _bottomView;
}

@end
