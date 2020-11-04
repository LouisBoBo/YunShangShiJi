//
//  SOContentView.m
//  YunShangShiJi
//
//  Created by zgl on 16/6/2.
//  Copyright © 2016年 ios-1. All rights reserved.
//  晒单分享详情主体内容

#import "SOContentView.h"
#import "AuthorView.h"
#import "AwardsCardView.h"
#import "GlobalTool.h"
#import "SDWebImage/UIImageView+WebCache.h"

@interface SOContentView ()
{
    CGFloat height;
}
@property (nonatomic, strong) AuthorView *authorView; // 分享人信息
@property (nonatomic, strong) AwardsCardView *cardView; // 获奖信息
@property (nonatomic, strong) UILabel *contentLabel; // 内容文字
@property (nonatomic, strong) UIView *contentImgView; // 内容图片
@property (nonatomic, strong) UIButton *likeBtn; // 点赞
@property (nonatomic, strong) UIButton *messageBtn; // 留言
@property (nonatomic, strong) UIView *headerView; // 整体背景

@end

@implementation SOContentView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setUI];
    }
    return self;
}

- (void)setUI {
    // 头部线条
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = lineGreyColor;
//    // 图片后分割线
//    UIView *lineView2 = [[UIView alloc] init];
//    lineView2.backgroundColor = lineGreyColor;
//    // 按钮之间分割线
//    UIView *lineView3 = [[UIView alloc] init];
//    lineView3.backgroundColor = lineGreyColor;
//    // 底部线条
//    UIView *lineView4 = [[UIView alloc] init];
//    lineView4.backgroundColor = lineGreyColor;
    
    [self addSubview:self.headerView];
    [self.headerView addSubview:lineView];
//    [self.headerView addSubview:lineView2];
//    [self.headerView addSubview:lineView3];
//    [self.headerView addSubview:lineView4];
    [self.headerView addSubview:self.authorView];
    [self.headerView addSubview:self.cardView];
    [self.headerView addSubview:self.contentLabel];
    [self.headerView addSubview:self.contentImgView];
//    [self.headerView addSubview:self.likeBtn];
//    [self.headerView addSubview:self.messageBtn];

    // 自动布局
    [self.headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(@(0));
        make.top.equalTo(@(kZoom6pt(10)));
    }];
    
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.headerView);
        make.height.equalTo(@(0.5));
    }];
    
    [self.authorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(@(kZoom6pt(15)));
        make.right.equalTo(@(kZoom6pt(-15)));
        make.height.equalTo(@(kZoom6pt(AuthorViewHeight)));
    }];
    
    [self.cardView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.authorView.mas_bottom).offset(kZoom6pt(10));
        make.left.right.equalTo(self.authorView);
    }];
    
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.cardView.mas_bottom).offset(kZoom6pt(10));
        make.left.right.equalTo(self.authorView);
    }];
    
    [self.contentImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentLabel.mas_bottom).offset(kZoom6pt(10));
        make.left.right.equalTo(self.authorView);
    }];

    /*
    [lineView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.authorView);
        make.height.equalTo(@(0.5));
        make.top.equalTo(self.contentImgView.mas_bottom).offset(kZoom6pt(10));
    }];
    
    [self.likeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineView2.mas_bottom).offset(kZoom6pt(15));
        make.centerX.equalTo(self.authorView.mas_centerX).multipliedBy(0.5);
        make.bottom.equalTo(@(kZoom6pt(-15)));
    }];
    
    [self.messageBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.likeBtn);
        make.centerX.equalTo(self.authorView.mas_centerX).multipliedBy(1.5);
    }];
    
    [lineView3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.likeBtn);
        make.width.equalTo(@(0.5));
        make.centerX.equalTo(self.headerView);
    }];
    
    [lineView4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(@(0));
        make.height.equalTo(@(0.5));
    }];
    */
}

#pragma mark - 点击事件
- (void)btnClick:(UIButton *)sender {
    if (_delegate && [_delegate respondsToSelector:@selector(buttonClick:index:)]) {
        [_delegate buttonClick:sender index:sender.tag - 2000];
    }
}

#pragma mark - 更新数据
- (void)receiveDataModel:(SOCommentModel *)model {
    NSURL *url = nil;
    if ([model.user_url hasPrefix:@"http"]) {
        url = [NSURL URLWithString:[NSString stringWithFormat:@"%@",model.user_url]];
    } else {
        url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[NSObject baseURLStr_Upy],model.user_url]];
    }
    
    [_authorView.iconImgView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"default"]];
    _authorView.nickLabel.text = model.user_name?:@"";
    _authorView.timeLabel.text = [NSString getTimeStyle:TimeStrStyleArticle time:model.add_date/1000];
    _authorView.isMember = NO;
    _contentLabel.attributedText = [NSString attributedStringWithString:model.content paragraphSpacing:kZoom6pt(10) lineSpacing:2 fontSize:kZoom6pt(14) color:_contentLabel.textColor];
    [_likeBtn setTitle:[NSString stringWithFormat:@"%ld",model.click_size] forState:UIControlStateNormal];
    [_messageBtn setTitle:[NSString stringWithFormat:@"%ld",model.comment_size] forState:UIControlStateNormal];
    _likeBtn.selected = [model.shop_code isEqualToString:model.click];

    [_authorView.topLikeBtn setTitle:[NSString stringWithFormat:@"%ld",model.click_size] forState:UIControlStateNormal];
    _authorView.topLikeBtn.selected = [model.shop_code isEqualToString:model.click];

    _cardView.shopLabel.text = model.shop_name?:@"";
    _cardView.issueLabel.text = [NSString stringWithFormat:@"%@期",model.issue_code];
    _cardView.numberLabel.text = model.lucky_number?:@"";
    NSString *count = [NSString stringWithFormat:@"%ld",model.count];
    NSString *countText = [NSString stringWithFormat:@"%@人次",count];
    _cardView.peopleLabel.attributedText = [NSString getOneColorInLabel:countText ColorString:count Color:UIColorHex(0xFF448E) fontSize:kZoom6pt(12)];
    _cardView.timeLabel.text = [NSString getTimeStyle:TimeStrStyleDefault time:model.otime/1000];
    
    // 计算高度
    CGFloat carH = 5*[NSString heightWithString:@"测" font:[UIFont systemFontOfSize:kZoom6pt(12)] constrainedToWidth:40];
    CGFloat textH = [_contentLabel.attributedText boundingRectWithSize:CGSizeMake(kApplicationWidth - kZoom6pt(30), CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size.height;
//    height = kZoom6pt(145+AuthorViewHeight) + 18 + carH + textH;
    height = kZoom6pt(100+AuthorViewHeight) + 18 + carH + textH;

    self.bounds = CGRectMake(0, 0, kApplicationWidth, height);
    
    // 添加图片
    if (![model.pic isEqualToString:@""]&&model.pic != nil) {
        NSArray *array = [model.pic componentsSeparatedByString:@","];
        [self addImageWithArrar:array];
    }
}

/// 添加图片
- (void)addImageWithArrar:(NSArray *)array {
    [_contentImgView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [array enumerateObjectsUsingBlock:^(id  obj, NSUInteger idx, BOOL *stop) {
        NSString *imgPath = [NSString stringWithFormat:@"%@shareOrder%@",[NSObject baseURLStr_Upy],obj];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        [_contentImgView addSubview:imageView];
        [imageView sd_setImageWithURL:[NSURL URLWithString:imgPath] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            UIImage *img = [image scaleImageMaxWidth:(kApplicationWidth - kZoom6pt(30))];
            imageView.image = img;
            imageView.bounds = CGRectMake(0, 0, img.size.width, img.size.height);
            height += img.size.height + kZoom6pt(10);
            self.bounds = CGRectMake(0, 0, kApplicationWidth, height);
            if (_delegate && [_delegate respondsToSelector:@selector(contentViewWillChangeHeight)]) {
                [_delegate contentViewWillChangeHeight];
            }
        }];
        
        UIImageView *imgView = nil;
        if (idx == 0) {
            [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(@(0));
                make.centerX.equalTo(_contentImgView);
            }];
        }else if (idx == array.count) {
            imgView = _contentImgView.subviews[idx - 1];
            [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(imgView.mas_bottom).offset(kZoom6pt(10));
                make.bottom.equalTo(@(0));
                make.centerX.equalTo(_contentImgView);
            }];
        } else {
            imgView = _contentImgView.subviews[idx - 1];
            [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(imgView.mas_bottom).offset(kZoom6pt(10));
                make.centerX.equalTo(_contentImgView);
            }];
        }
    }];
}

#pragma mark - getter方法
- (AuthorView *)authorView {
    if (nil == _authorView) {
        _authorView = [[AuthorView alloc] initWithFrame:CGRectZero];
        kSelfWeak;
        [_authorView setLikeBtnBlock:^(UIButton *sender) {
            [weakSelf btnClick:sender];
        }];
    }
    return _authorView;
}

- (AwardsCardView *)cardView {
    if (nil == _cardView) {
        _cardView = [[AwardsCardView alloc] initWithFrame:CGRectZero];
        __weak typeof(self) weakSelf = self;
        [_cardView setDetailsBlock:^(UIButton *sender){
            [weakSelf btnClick:sender];
        }];
    }
    return _cardView;
}

- (UILabel *)contentLabel {
    if (nil == _contentLabel) {
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.textColor = kTitleColor;
        _contentLabel.font = [UIFont systemFontOfSize:kZoom6pt(14)];
        _contentLabel.numberOfLines = 0;
    }
    return _contentLabel;
}

- (UIView *)contentImgView {
    if (nil == _contentImgView) {
        _contentImgView = [[UIView alloc] init];
    }
    return _contentImgView;
}

- (UIButton *)likeBtn {
    if (nil == _likeBtn) {
        _likeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_likeBtn setImage:[UIImage imageNamed:@"icon_dianzan"] forState:UIControlStateNormal];
        [_likeBtn setImage:[UIImage imageNamed:@"icon_dianzan_press"] forState:UIControlStateSelected];
        [_likeBtn setImage:[UIImage imageNamed:@"icon_dianzan_press"] forState:UIControlStateSelected | UIControlStateHighlighted];
        [_likeBtn setTitle:@"0" forState:UIControlStateNormal];
        [_likeBtn setTitleColor:kTextColor forState:UIControlStateNormal];
        [_likeBtn.titleLabel setFont:[UIFont systemFontOfSize:kZoom6pt(14)]];
        [_likeBtn setTag:2002];
        [_likeBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_likeBtn setTitleEdgeInsets:UIEdgeInsetsMake(5, 5, 0, -5)];
    }
    return _likeBtn;
}

- (UIButton *)messageBtn {
    if (nil == _messageBtn) {
        _messageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_messageBtn setImage:[UIImage imageNamed:@"icon_pinlun"] forState:UIControlStateNormal];
        [_messageBtn setTitle:@"0" forState:UIControlStateNormal];
        [_messageBtn setTitleColor:kTextColor forState:UIControlStateNormal];
        [_messageBtn.titleLabel setFont:[UIFont systemFontOfSize:kZoom6pt(14)]];
        [_messageBtn setTag:2003];
        [_messageBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_messageBtn setTitleEdgeInsets:UIEdgeInsetsMake(5, 5, 0, -5)];
    }
    return _messageBtn;
}

- (UIView *)headerView {
    if (nil == _headerView) {
        _headerView = [[UIView alloc] initWithFrame:CGRectZero];
        _headerView.backgroundColor = [UIColor whiteColor];
    }
    return _headerView;
}

#pragma mark - setter方法
- (void)setCommentSize:(NSInteger)size {
    [_messageBtn setTitle:[NSString stringWithFormat:@"%ld",size] forState:UIControlStateNormal];
}

@end
