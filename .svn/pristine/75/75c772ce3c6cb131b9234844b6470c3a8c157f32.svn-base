//
//  TreasureTableCollectionCell.m
//  YunShangShiJi
//
//  Created by YF on 2017/9/1.
//  Copyright © 2017年 ios-1. All rights reserved.
//

#import "TreasureTableCollectionCell.h"
#import "GlobalTool.h"


@implementation TreasureTableCollectionCell
- (void)loadHeadImg:(NSString *)pic name:(NSString *)name {
    //头像
    NSURL *url = nil;
    NSString *headimage = pic;
    if ([headimage hasPrefix:@"http"]) {
        url = [NSURL URLWithString:[NSString stringWithFormat:@"%@",headimage]];
    } else {
        if ([headimage hasPrefix:@"/"]) {
            url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[NSObject baseURLStr_Upy],[headimage substringFromIndex:1]]];
        } else {
            url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[NSObject baseURLStr_Upy],headimage]];
        }
    }
    [self.headImg sd_setImageWithURL:url];
    self.name.text = name;
}
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {

        [self.contentView addSubview:self.headImg];
        [self.contentView addSubview:self.userIco];
        [self.contentView addSubview:self.name];
        [self.headImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.offset(0);
            make.centerX.equalTo(self.contentView);
            make.width.height.offset(ZOOM6(120));
        }];
        [self.name mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.width.equalTo(self.headImg);
            make.top.equalTo(self.headImg.mas_bottom).offset(ZOOM6(5));
        }];
        self.headImg.layer.cornerRadius = ZOOM6(60);
        self.headImg.clipsToBounds = YES;
    }
    return self;
}
- (UIImageView *)userIco {
    if (!_userIco) {
        UIImageView *userIco = [[UIImageView alloc]init];
        userIco.image = [UIImage imageNamed:@"团长"];
        userIco.frame = CGRectMake(ZOOM6(56), 0, ZOOM6(64), ZOOM6(36));
        _userIco = userIco;
    }
    return _userIco;
}
- (UIImageView *)headImg {
    if (!_headImg) {
        _headImg = [[UIImageView alloc]init];
        UILabel *userLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, ZOOM6(120), ZOOM6(120))];
        userLabel.layer.cornerRadius = ZOOM6(60);
        userLabel.layer.borderColor = tarbarrossred.CGColor;
        userLabel.layer.borderWidth = 1;
        userLabel.textAlignment = NSTextAlignmentCenter;
        userLabel.font = kFont6px(24);
        userLabel.textColor = tarbarrossred;
        userLabel.numberOfLines=2;
        userLabel.hidden = YES;
        _userLabel = userLabel;
        [_headImg addSubview:userLabel];

    }
    return _headImg;
}
- (UILabel *)name {
    if (!_name) {
        _name = [[UILabel alloc]init];
        _name.textColor = kSubTitleColor;
        _name.textAlignment = NSTextAlignmentCenter;
        _name.font = kFont6px(20);
    }
    return _name;
}

@end
