//
//  AwardsCardView.m
//  YunShangShiJi
//
//  Created by zgl on 16/6/1.
//  Copyright © 2016年 ios-1. All rights reserved.
//  晒单详情夺宝情况

#import "AwardsCardView.h"
#import "GlobalTool.h"

@interface AwardsCardView ()
{
    void (^_block)(UIButton *);
}
@property (nonatomic, strong) UILabel *shopNLabel; // 获得商品
@property (nonatomic, strong) UILabel *issueNLabel; // 期号
@property (nonatomic, strong) UILabel *numberNLabel; // 幸运号码
@property (nonatomic, strong) UILabel *peopleNLabel; // 人次
@property (nonatomic, strong) UILabel *timeNLabel; // 揭晓时间
@property (nonatomic, strong) UIButton *moreBtn; // 查看详情

@end

@implementation AwardsCardView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setUI];
        self.backgroundColor = [UIColor colorWithRed:252.0/255 green:244.0/255 blue:230.0/255 alpha:1];
    }
    return self;
}

#pragma mark - 创建UI
- (void)setUI {
    _shopNLabel = [self labelWithText:@"获得商品："];
    _issueNLabel = [self labelWithText:@"期号："];
    _numberNLabel = [self labelWithText:@"幸运号码："];
    _peopleNLabel = [self labelWithText:@"本期参与："];
    _timeNLabel = [self labelWithText:@"揭晓时间："];
    
    _shopLabel = [self labelWithText:@""];
    _issueLabel = [self labelWithText:@""];
    _numberLabel = [self labelWithText:@""];
    _peopleLabel = [self labelWithText:@""];
    _timeLabel = [self labelWithText:@""];
    
    _moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _moreBtn.titleLabel.font = [UIFont systemFontOfSize:kZoom6pt(12)];
    _moreBtn.tag = 2001;
    [_moreBtn setTitle:@"查看详情 >" forState:UIControlStateNormal];
    [_moreBtn setTitleColor:kTextColor forState:UIControlStateNormal];
    [_moreBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];

    [self addSubview:_shopLabel];
    [self addSubview:_issueLabel];
    [self addSubview:_numberLabel];
    [self addSubview:_peopleLabel];
    [self addSubview:_timeLabel];
    [self addSubview:_shopNLabel];
    [self addSubview:_issueNLabel];
    [self addSubview:_numberNLabel];
    [self addSubview:_peopleNLabel];
    [self addSubview:_timeNLabel];
    [self addSubview:_moreBtn];
    
    [self autoLayout];
}

// 布局
- (void)autoLayout {
    [_shopNLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(@(kZoom6pt(10)));
    }];
    [_shopLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_shopNLabel);
        make.left.equalTo(_shopNLabel.mas_right);
        make.right.mas_lessThanOrEqualTo(kZoom6pt(-10));
    }];
    
    [_issueNLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_shopNLabel.mas_bottom).offset(kZoom6pt(10));
        make.right.equalTo(_shopNLabel);
    }];
    [_issueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_issueNLabel);
        make.left.equalTo(_shopLabel);
        make.right.mas_lessThanOrEqualTo(kZoom6pt(-10));
    }];
    
    [_numberNLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_issueNLabel.mas_bottom).offset(kZoom6pt(10));
        make.right.equalTo(_shopNLabel);
    }];
    [_numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_numberNLabel);
        make.left.equalTo(_shopLabel);
        make.right.mas_lessThanOrEqualTo(kZoom6pt(-10));
    }];
    
    [_peopleNLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_numberNLabel.mas_bottom).offset(kZoom6pt(10));
        make.right.equalTo(_shopNLabel);
    }];
    [_peopleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_peopleNLabel);
        make.left.equalTo(_shopLabel);
        make.right.mas_lessThanOrEqualTo(kZoom6pt(-10));
    }];
    
    [_timeNLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_peopleNLabel.mas_bottom).offset(kZoom6pt(10));
        make.right.equalTo(_shopNLabel);
        make.bottom.equalTo(@(kZoom6pt(-10)));
    }];
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_timeNLabel);
        make.left.equalTo(_shopLabel);
        make.right.mas_lessThanOrEqualTo(kZoom6pt(-10));
    }];
    
    [_moreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(kZoom6pt(-10)));
        make.centerY.equalTo(_timeNLabel);
    }];
}

#pragma mark - 点击事件
- (void)btnClick:(UIButton *)sender {
    if (_block) {
        _block(sender);
    }
}

#pragma mark - setter
- (void)setDetailsBlock:(void (^)(UIButton *))block {
    _block = block;
}

#pragma mark - getter方法
- (UILabel *)labelWithText:(NSString *)text {
    UILabel *label = [[UILabel alloc] init];
    label.textColor = kTextColor;
    label.font = [UIFont systemFontOfSize:kZoom6pt(12)];
    label.text = text;
    return label;
}

@end
