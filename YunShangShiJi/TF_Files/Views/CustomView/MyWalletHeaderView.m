//
//  MyWalletHeaderView.m
//  YunShangShiJi
//
//  Created by zgl on 16/6/25.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import "MyWalletHeaderView.h"
#import "GlobalTool.h"
#import "YFOpenButton.h"

@interface MyWalletHeaderView ()
@property (nonatomic, strong) UIView *topView;
@property (nonatomic, strong) UIView *centerView;
@property (nonatomic, strong) UIView *bottomView;

//@property (nonatomic, strong) UILabel *multipleLabel; //倍数
@property (nonatomic, strong) YFOpenButton *openBtn; //开启按钮
@property (nonatomic, strong) UILabel *leftLabel;
@property (nonatomic, strong) UILabel *rightLabel;

@end

@implementation MyWalletHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    frame.size.height = ZOOM6(450);
    self = [super initWithFrame:frame];
    if (self) {
        [self setMainUI];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

#pragma mark - 创建UI
- (void)setMainUI {
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, ZOOM6(450))];
    [self addSubview:_topView = topView];
    
    //顶部
    UIView *contentTopView = [[UIView alloc] initWithFrame:CGRectZero];
    [topView addSubview:contentTopView];
    
    UILabel *titleLabel0 = [self labelWithText:@"我的余额" color:tarbarrossred font:[UIFont systemFontOfSize:ZOOM6(30)]];
    [contentTopView addSubview:titleLabel0];
    
    _yueLabel = [self labelWithText:@"0.00" color:tarbarrossred font:[UIFont boldSystemFontOfSize:ZOOM6(72)]];
    [contentTopView addSubview:_yueLabel];
    
    [contentTopView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(ZOOM6(224));
        make.width.mas_equalTo(kScreen_Width);
        make.left.top.equalTo(@0);
    }];
    [titleLabel0 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(@0);
        make.top.mas_equalTo(ZOOM6(60));
    }];
    [_yueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(@0);
        make.top.equalTo(titleLabel0.mas_bottom);
    }];
    
    // 左边
    UIView *contentLeftView = [[UIView alloc] initWithFrame:CGRectZero];
    [topView addSubview:contentLeftView];
    UILabel *titleLabel = [self labelWithText:@"我的收益" color:tarbarrossred font:[UIFont systemFontOfSize:ZOOM6(30)]];
    [contentLeftView addSubview:titleLabel];
    
    _overLabel = [self labelWithText:@"0.00元" color:tarbarrossred font:[UIFont systemFontOfSize:ZOOM6(52)]];
    NSString *ostring = _overLabel.text;
    NSString *findstr = @"元";
    [_overLabel setAttributedText:[NSString getOneColorInLabel:ostring ColorString:findstr Color:tarbarrossred font:kFont6px(30)]];
    [contentLeftView addSubview:_overLabel];
    
    [contentLeftView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(ZOOM6(224));
        make.width.mas_equalTo(kScreen_Width * 0.5);
        make.top.equalTo(contentTopView.mas_bottom);
        make.left.equalTo(@0);
    }];
    
    [_overLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(@0);
        make.top.mas_equalTo(ZOOM6(60));
    }];
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(@0);
        make.top.equalTo(_overLabel.mas_bottom);
    }];
    
    UIView *midline = [[UIView alloc]initWithFrame:CGRectZero];
    midline.backgroundColor = tarbarrossred;
    [topView addSubview:midline];
    [midline mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(topView.mas_centerX);
        make.centerY.equalTo(contentLeftView.mas_centerY);
        make.width.mas_equalTo(ZOOM6(2));
        make.height.mas_equalTo(ZOOM6(60));
    }];
    
    // 右边
    UIView *contentRightView = [[UIView alloc] initWithFrame:CGRectZero];
    [topView addSubview:contentRightView];
    UILabel *titleLabel2 = [self labelWithText:@"可提现收益" color:tarbarrossred font:[UIFont systemFontOfSize:ZOOM6(30)]];
    [contentRightView addSubview:titleLabel2];
    
    _canWithCashLabel = [self labelWithText:@"0.00元" color:tarbarrossred font:[UIFont systemFontOfSize:ZOOM6(52)]];
    [contentRightView addSubview:_canWithCashLabel];
    
    [contentRightView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(contentLeftView.mas_centerY);
        make.size.equalTo(contentLeftView);
        make.right.equalTo(@0);
    }];
    [titleLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(@0);
        make.top.equalTo(_canWithCashLabel.mas_bottom);
    }];
    
    [_canWithCashLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(@0);
        make.top.mas_equalTo(ZOOM6(60));
    }];
    
    UIView *line = [[UIView alloc]init];
    line.backgroundColor = lineGreyColor;
    [topView addSubview:line];
    UILabel *leftLabel = [[UILabel alloc]init];
    leftLabel.textAlignment = NSTextAlignmentCenter;
    leftLabel.textColor = kMainTitleColor;
    leftLabel.font = kFont6px(30);
    leftLabel.text = @"提现额度";
    [topView addSubview:leftLabel];
    
    UILabel *rightLabel = [[UILabel alloc]init];
    rightLabel.textAlignment = NSTextAlignmentCenter;
    rightLabel.textColor = kMainTitleColor;
    rightLabel.font = kFont6px(30);
    rightLabel.text = @"提现冻结";
    [topView addSubview:rightLabel];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(@0);
        make.top.mas_equalTo(ZOOM6(224));
//        make.top.equalTo(contentLeftView.mas_bottom);
        make.height.equalTo(@0.5);
    }];
    
//    [leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(line.mas_bottom);
//        make.left.equalTo(@0);
//        make.width.mas_equalTo(kScreen_Width * 0.5);
//        make.height.mas_equalTo(ZOOM6(100));
//    }];
//    [rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(line.mas_bottom);
//        make.right.equalTo(@0);
//        make.width.mas_equalTo(kScreen_Width * 0.5);
//        make.height.mas_equalTo(ZOOM6(100));
//    }];
    _leftLabel = leftLabel;
    _rightLabel = rightLabel;
    
    // 线
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, ZOOM6(224)-0.5, self.width, 0.5)];
    lineView.backgroundColor = lineGreyColor;
//    [topView addSubview:lineView];
    
    // 灰色条
    UIView *backView = [[UIView alloc] initWithFrame:CGRectZero];
    backView.backgroundColor = kBackgroundColor;
    backView.tag = 2009;
    
    [self addSubview:backView];
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.height.mas_equalTo(10);
    }];
    
}

- (void)setUI {
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, kZoom6pt(170))];
    [self addSubview:_topView = topView];
    // 左边
    UIView *contentLeftView = [[UIView alloc] initWithFrame:CGRectZero];
    [topView addSubview:contentLeftView];
    UILabel *titleLabel = [self labelWithText:@"我的余额" color:kTextColor font:[UIFont systemFontOfSize:kZoom6pt(16)]];
    [contentLeftView addSubview:titleLabel];
    
    _overLabel = [self labelWithText:@"¥0" color:tarbarrossred font:[UIFont boldSystemFontOfSize:kZoom6pt(30)]];
    [contentLeftView addSubview:_overLabel];
    
    [contentLeftView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(ZOOM6(130));
        make.width.mas_equalTo(kScreen_Width * 0.5);
        make.centerY.equalTo(topView.mas_centerY);
        make.left.equalTo(@0);
    }];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(@0);
    }];
    
    [_overLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(@0);
    }];
    
    // 右边
    UIView *contentRightView = [[UIView alloc] initWithFrame:CGRectZero];
    [topView addSubview:contentRightView];
    UILabel *titleLabel2 = [self labelWithText:@"可提现" color:kTextColor font:[UIFont systemFontOfSize:kZoom6pt(16)]];
    [contentRightView addSubview:titleLabel2];
    
    _canWithCashLabel = [self labelWithText:@"¥0" color:tarbarrossred font:[UIFont boldSystemFontOfSize:kZoom6pt(30)]];
    [contentRightView addSubview:_canWithCashLabel];
    
    [contentRightView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(contentLeftView.mas_centerY);
        make.size.equalTo(contentLeftView);
        make.right.equalTo(@0);
    }];
    [titleLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(@0);
    }];
    
    [_canWithCashLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(@0);
    }];

    // 线
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, kZoom6pt(170)-0.5, self.width, 0.5)];
    lineView.backgroundColor = lineGreyColor;
    [topView addSubview:lineView];
    
    // 灰色条
    UIView *backView = [[UIView alloc] initWithFrame:CGRectZero];
    backView.backgroundColor = kBackgroundColor;
    backView.tag = 2009;
    
    [self addSubview:backView];
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.height.mas_equalTo(10);
    }];

}

#pragma mark - 点击事件
- (void)btnClick:(UIView *)sender {
    switch (sender.tag) {
        case 2001:
            if (_block)
                _block(HeaderViewBtnTypeShop);
                break;
        case 2002:
            if (_block)
                _block(HeaderViewBtnTypeWithdraw);
            break;
        case 2003:
            if (_block)
                _block(HeaderViewBtnTypeShopping);
            break;
        default:
            break;
    }
}
- (void)loadDataWithStr:(NSString *)str str2:(NSString *)str2 str3:(NSString *)str3 str4:(NSString *)str4 {
    self.yueLabel.text = str;
    self.canWithCashLabel.text = [NSString stringWithFormat:@"%@元",str2];
    
    NSString *ostring = self.canWithCashLabel.text;
    NSString *findstr = @"元";
    [self.canWithCashLabel setAttributedText:[NSString getOneColorInLabel:ostring ColorString:findstr Color:tarbarrossred font:kFont6px(30)]];
    
    NSString *string = [NSString stringWithFormat:@"提现额度：%@",str3];
    NSString *string2 = [NSString stringWithFormat:@"提现冻结：%@",str4];
    [self.leftLabel setAttributedText:[NSString getOneColorInLabel:string ColorString:str3 Color:tarbarrossred font:kFont6px(30)]];
    [self.rightLabel setAttributedText:[NSString getOneColorInLabel:string2 ColorString:str4 Color:tarbarrossred font:kFont6px(30)]];
}
#pragma mark - 根据不同的模式显示UI
- (void)loadViewWithType:(HeaderViewType)type {
    switch (type) {
        case HeaderViewTypeDefault: //默认
            [self.centerView removeFromSuperview];
            [self addBottomViewWithType:HeaderViewTypeDefault];
            self.height = ZOOM6(450)+kZoom6pt(13)*2+ZOOM6(85)+10;
//            _overLabel.textColor = [UIColor colorWithWhite:62/255.0 alpha:1];
//            _canWithCashLabel.textColor = [UIColor colorWithWhite:62/255.0 alpha:1];
            
            break;
        case HeaderViewTypeOpen: //已开店但没开启余额翻倍
            if (self.centerView.superview == nil) {
                [self addSubview:self.centerView];
            }
            [self addBottomViewWithType:HeaderViewTypeOpen];
            self.height = kZoom6pt(360);
            _openBtn.userInteractionEnabled = YES;
            _overLabel.textColor = [UIColor colorWithWhite:62/255.0 alpha:1];
            _canWithCashLabel.textColor = [UIColor colorWithWhite:62/255.0 alpha:1];
            
            break;
        case HeaderViewTypeOpenEnd://已开店也开启了余额翻倍
            [self.centerView removeFromSuperview];
            [self addBottomViewWithType:HeaderViewTypeOpenEnd];
            self.height = kZoom6pt(330);
            _openBtn.userInteractionEnabled = NO;
            _overLabel.textColor = tarbarrossred;
            _canWithCashLabel.textColor = tarbarrossred;
            
            break;
        case HeaderViewTypeDefault_NoTiXian:
            [[self viewWithTag:2009] removeFromSuperview];
            self.height = ZOOM6(224);
        
            break;
        default:
            break;
    }
}

#pragma mark - getter
///创建Label便捷方法
- (UILabel *)labelWithText:(NSString *)text color:(UIColor *)color font:(UIFont *)font {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    label.textAlignment = NSTextAlignmentCenter;
    label.numberOfLines = 1;
    label.textColor = color;
    label.font = font;
    label.text = text;
    return label;
}

- (void)addBottomViewWithType:(HeaderViewType)type {
    
    [self.bottomView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.bottomView removeFromSuperview];
    
    [self addSubview:self.bottomView];
    UIView *backView = [self viewWithTag:2009];
    
    [self.bottomView mas_updateConstraints:^(MASConstraintMaker *make) {
        if (type != HeaderViewTypeOpen) {
            make.top.equalTo(self.topView.mas_bottom);
        } else { // 有开启余额翻倍权限
            make.top.equalTo(self.centerView.mas_bottom);
        }
        make.left.right.equalTo(@0);
        make.bottom.equalTo(backView.mas_top);
    }];
    
    UIButton *shoppingBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    shoppingBtn.tag = 2002;
    [shoppingBtn setBackgroundColor:tarbarrossred];
    [shoppingBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [shoppingBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    shoppingBtn.clipsToBounds = YES;
    shoppingBtn.layer.cornerRadius = kZoom6pt(5);
    [self.bottomView addSubview:shoppingBtn];
    
    self.timeLabel2 = [self labelWithText:@"距余额翻倍结束还剩：" color:tarbarrossred font:[UIFont  boldSystemFontOfSize:kZoom6pt(12)]];
    [self.bottomView addSubview:self.timeLabel2];
    
    UIButton *cashBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cashBtn.tag = 2002;
    [cashBtn setBackgroundColor:[UIColor whiteColor]];
    [cashBtn setTitle:@"提 现" forState:UIControlStateNormal];
    [cashBtn setTitleColor:COLOR_ROSERED forState:UIControlStateNormal];
    [cashBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    cashBtn.clipsToBounds = YES;
    cashBtn.layer.borderWidth = 1;
    cashBtn.layer.borderColor = [COLOR_ROSERED CGColor];
    cashBtn.layer.cornerRadius = kZoom6pt(5);
    [self.bottomView addSubview:cashBtn];
    
    NSString *shopBtnText = @"提 现";
    CGFloat H_time = 1;
    CGFloat H_cashBtn = 1;
    if (type == HeaderViewTypeOpenEnd) {
        shopBtnText = @"买买买";
        shoppingBtn.tag = 2003;
        H_time = ZOOM6(60);
        H_cashBtn = ZOOM6(85);
    } else if (type == HeaderViewTypeDefault || HeaderViewTypeOpen) {
        shopBtnText = @"提 现";
        shoppingBtn.tag = 2002;
        H_time = 0;
        H_cashBtn = 0;
    }
    // 设置数据
    [shoppingBtn setTitle:shopBtnText forState:UIControlStateNormal];
    
    [shoppingBtn mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bottomView.mas_top).offset(kZoom6pt(13));
        make.left.mas_equalTo(kZoom6pt(15));
        make.right.mas_equalTo(kZoom6pt(-15));
        make.height.mas_equalTo(ZOOM6(85));
    }];
    
    
    [self.timeLabel2 mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(shoppingBtn.mas_bottom);
        make.left.and.right.equalTo(shoppingBtn);
        make.height.mas_equalTo(H_time);
    }];
    
    [cashBtn mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(shoppingBtn);
        make.height.mas_equalTo(H_cashBtn);
        make.bottom.equalTo(self.bottomView.mas_bottom).offset(-ZOOM6(30));
    }];
    
}

- (UIView *)bottomView {
    if (_bottomView != nil) {
        return _bottomView;
    }
    _bottomView = [UIView new];
    
    return _bottomView;
}

///中间余额翻倍相关View
- (UIView *)centerView {
    if (nil == _centerView) {
        _centerView = [[UIView alloc] initWithFrame:CGRectMake(0, kZoom6pt(170), self.width, kZoom6pt(110))];
        CGFloat height = [NSString heightWithString:@"高度" font:[UIFont systemFontOfSize:kZoom6pt(14)] constrainedToWidth:100];
        
        UILabel *label = [self labelWithText:[NSString stringWithFormat:@"新用户立享余额X%ld倍特权，可以用来任性买买买哦。",(long)[DataManager sharedManager].twofoldness] color:[UIColor colorWithWhite:125/255.0 alpha:1.0] font:[UIFont systemFontOfSize:kZoom6pt(14)]];
        label.frame = CGRectMake(0, kZoom6pt(15), self.width, height);
        [_centerView addSubview:label];
        
        _openBtn = [[YFOpenButton alloc] initWithFrame:CGRectMake((self.width - kZoom6pt(120))/2, label.bottom + kZoom6pt(10), kZoom6pt(120), kZoom6pt(30))];
        _openBtn.tag = 2001;
        [_openBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_centerView addSubview:_openBtn];
        
        height = [NSString heightWithString:@"高度" font:[UIFont systemFontOfSize:kZoom6pt(12)] constrainedToWidth:100];
        _timeLabel = [self labelWithText:@"距余额翻倍结束还剩：" color:tarbarrossred font:[UIFont  boldSystemFontOfSize:kZoom6pt(12)]];
        _timeLabel.frame = CGRectMake(0, _centerView.height - height - kZoom6pt(15), self.width, height);
        [_centerView addSubview:_timeLabel];
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, kZoom6pt(110)-0.5, self.width, 0.5)];
        lineView.backgroundColor = lineGreyColor;
        [_centerView addSubview:lineView];
    }
    return _centerView;
}

@end