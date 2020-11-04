//
//  AuthorView.m
//  YunShangShiJi
//
//  Created by zgl on 16/6/1.
//  Copyright © 2016年 ios-1. All rights reserved.
//  晒单详情用户信息

#import "AuthorView.h"
#import "GlobalTool.h"

@interface AuthorView ()
{
    void (^_block)(UIButton *);
}

@property (nonatomic, strong) UIView *memberView; // 会员
@property (nonatomic, strong) UIImageView *mBIco; // 会员图标
@property (nonatomic, strong) UILabel *mBTypeLable; // 会员类型
@end

@implementation AuthorView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setUI];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)setUI {
    _iconImgView = [[UIImageView alloc] init];
    _iconImgView.clipsToBounds = YES;
    _iconImgView.layer.cornerRadius = kZoom6pt(AuthorViewHeight/2);
    [self addSubview:_iconImgView];
    
    _nickLabel = [[UILabel alloc] init];
    _nickLabel.textColor = kTitleColor;
    _nickLabel.font = [UIFont boldSystemFontOfSize:kZoom6pt(16)];
    [self addSubview:_nickLabel];
    
    _memberView = [[UIView alloc] init];
    _memberView.hidden = YES;
    [self addSubview:_memberView];
    
    _mBIco = [[UIImageView alloc] init];
    _mBIco.image = [UIImage imageNamed:@"icon_huiyuan"];
    [_memberView addSubview:_mBIco];
    
    _mBTypeLable = [[UILabel alloc] init];
    _mBTypeLable.textColor = bodyrossred;
    _mBTypeLable.font = [UIFont boldSystemFontOfSize:kZoom6pt(12)];
    _mBTypeLable.text = @"至尊会员";
    [_memberView addSubview:_mBTypeLable];
    
    _timeLabel = [[UILabel alloc] init];
    _timeLabel.textColor = kTextColor;
    _timeLabel.font = [UIFont systemFontOfSize:kZoom6pt(12)];
    [self addSubview:_timeLabel];

    [self addSubview:self.topLikeBtn];

    [self autoLayout];
}

- (void)autoLayout {
    [_iconImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(@(0));
        make.width.equalTo(_iconImgView.mas_height);
    }];
    
    [_nickLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(_iconImgView.mas_right).offset(kZoom6pt(10));
    }];
    
    [_memberView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(_nickLabel.mas_right).offset(kZoom6pt(10));
    }];
    
    [_mBIco mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.equalTo(@(0));
        make.height.width.equalTo(@(kZoom6pt(12)));
    }];
    
    [_mBTypeLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(0));
        make.left.equalTo(_mBIco.mas_right).offset(kZoom6pt(5));
        make.centerY.equalTo(_memberView);
    }];
    
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(_nickLabel.mas_right).offset(kZoom6pt(10));
    }];
    [_topLikeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.right.equalTo(self);
    }];
}
- (UIButton *)topLikeBtn {
    if (nil == _topLikeBtn) {
        _topLikeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_topLikeBtn setImage:[UIImage imageNamed:@"icon_dianzan"] forState:UIControlStateNormal];
        [_topLikeBtn setImage:[UIImage imageNamed:@"icon_dianzan_press"] forState:UIControlStateSelected];
        [_topLikeBtn setImage:[UIImage imageNamed:@"icon_dianzan_press"] forState:UIControlStateSelected | UIControlStateHighlighted];
        [_topLikeBtn setTitle:@"0" forState:UIControlStateNormal];
        [_topLikeBtn setTitleColor:kTextColor forState:UIControlStateNormal];
        [_topLikeBtn.titleLabel setFont:[UIFont systemFontOfSize:kZoom6pt(14)]];
        [_topLikeBtn setTag:2002];
        [_topLikeBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_topLikeBtn setTitleEdgeInsets:UIEdgeInsetsMake(5, 5, 0, -5)];
    }
    return _topLikeBtn;
}
#pragma mark - 点击事件
- (void)btnClick:(UIButton *)sender {
    if (_block) {
        _block(sender);
    }
}

#pragma mark - setter
- (void)setLikeBtnBlock:(void (^)(UIButton *))block {
    _block = block;
}
- (void)setIsMember:(BOOL)isMember {
    _isMember = isMember;
    _memberView.hidden = !_isMember;
}

@end
