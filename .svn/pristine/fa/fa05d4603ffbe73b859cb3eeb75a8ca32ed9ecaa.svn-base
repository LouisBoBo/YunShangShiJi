//
//  YFOpenButton.m
//  YunShangShiJi
//
//  Created by zgl on 16/6/29.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import "YFOpenButton.h"
#import "GlobalTool.h"

@implementation YFOpenButton {
    UILabel *titleLabel;
    UIImageView *imageView;
    BOOL isUEnabled;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        isUEnabled = YES;
        UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
        [self addSubview:view];
        view.userInteractionEnabled = NO;
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self);
        }];
        
        titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        titleLabel.textColor = tarbarrossred;
        titleLabel.font = [UIFont systemFontOfSize:kZoom6pt(15)];
        titleLabel.text = @"立即开启";
        titleLabel.userInteractionEnabled = NO;
        [view addSubview:titleLabel];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.bottom.equalTo(@0);
        }];
        
        imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_go"]];
        imageView.userInteractionEnabled = NO;
        [view addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(titleLabel.mas_right).offset(kZoom6pt(5));
            make.right.equalTo(@0);
            make.centerY.equalTo(titleLabel);
            make.size.mas_equalTo(CGSizeMake(kZoom6pt(15), kZoom6pt(15)));
        }];
        
        self.layer.borderColor = tarbarrossred.CGColor;
        self.layer.borderWidth = 1.0;
        self.layer.cornerRadius = frame.size.height/2;
        
    }
    return self;
}

- (void)layoutView {
    if (isUEnabled) {
        titleLabel.text = @"立即开启";
        imageView.image = [UIImage imageNamed:@"icon_go"];
        self.layer.borderWidth = 1.0;
        [titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.top.bottom.equalTo(@0);
        }];
        
        [imageView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(titleLabel.mas_right).offset(kZoom6pt(5));
            make.right.equalTo(@0);
            make.centerY.equalTo(titleLabel);
            make.size.mas_equalTo(CGSizeMake(kZoom6pt(15), kZoom6pt(15)));
        }];
    } else {
        titleLabel.text = @"已开启";
        imageView.image = [UIImage imageNamed:@"icon_dapeigou_celect"];
        self.layer.borderWidth = 0.0;
        [imageView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@0);
            make.centerY.equalTo(self);
            make.size.mas_equalTo(CGSizeMake(kZoom6pt(20), kZoom6pt(20)));
        }];
        [titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.top.bottom.equalTo(@0);
            make.left.equalTo(imageView.mas_right).offset(kZoom6pt(5));
        }];
    }
    [self layoutIfNeeded];
}

- (void)setUserInteractionEnabled:(BOOL)userInteractionEnabled {
    [super setUserInteractionEnabled:userInteractionEnabled];
    isUEnabled = userInteractionEnabled;
    [self layoutView];
}

@end
