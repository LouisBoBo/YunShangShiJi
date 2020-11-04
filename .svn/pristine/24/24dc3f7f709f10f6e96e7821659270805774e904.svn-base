//
//  FollowCell.m
//  YunShangShiJi
//
//  Created by jingaiweiyi on 2017/2/16.
//  Copyright © 2017年 ios-1. All rights reserved.
//

#import "FollowCell.h"

@interface FollowCell ()
@property (nonatomic, strong) UIImageView *mengcengImageView;
@end

@implementation FollowCell
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setUI];
    }
    return self;
}

- (void)setUI {
    [self.contentView addSubview:self.imageView];
    [self.imageView addSubview:self.mengcengImageView];
    [self.imageView addSubview:self.titleLabel];
    [self.contentView addSubview:self.priceLabel];
}

- (void)layoutSubviews {
    self.imageView.frame = CGRectMake(0, kICFollowCellLeftTop, self.width, self.width);
    self.mengcengImageView.frame = CGRectMake(0, self.imageView.height - ZOOM6(80), self.imageView.width, ZOOM6(80));
    self.titleLabel.frame = CGRectMake(0, self.imageView.height - ZOOM6(40), self.imageView.width, ZOOM6(40));
    self.priceLabel.frame = CGRectMake(0, self.imageView.bottom, self.width, self.height - self.imageView.bottom);
    
    if([DataManager sharedManager].is_OneYuan)
    {
        UILabel* fengqiangLabel = [[UILabel alloc]initWithFrame:CGRectMake((CGRectGetWidth(self.priceLabel.frame)-ZOOM6(150))/2, ZOOM6(15), ZOOM6(80), CGRectGetHeight(self.priceLabel.frame)-ZOOM6(30))];
        fengqiangLabel.backgroundColor = [UIColor whiteColor];
        fengqiangLabel.font = [UIFont systemFontOfSize:kZoom6pt(10)];
        fengqiangLabel.textAlignment = NSTextAlignmentCenter;
        fengqiangLabel.layer.borderColor = [UIColor redColor].CGColor;
        fengqiangLabel.layer.borderWidth = 1;
        fengqiangLabel.clipsToBounds = YES;
        fengqiangLabel.layer.cornerRadius = 5;
        fengqiangLabel.text = @"疯抢价";
        fengqiangLabel.textColor = [UIColor redColor];
        [self.priceLabel addSubview:fengqiangLabel];
        
        UILabel* oneyuanLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(fengqiangLabel.frame)+ZOOM6(2), ZOOM6(15), ZOOM6(70), CGRectGetHeight(fengqiangLabel.frame))];
        oneyuanLabel.backgroundColor = kWiteColor;
        oneyuanLabel.font = [UIFont systemFontOfSize:kZoom6pt(10)];
        oneyuanLabel.textAlignment = NSTextAlignmentRight;
        oneyuanLabel.text = [NSString stringWithFormat:@"%.1f元",[DataManager sharedManager].app_value];
        oneyuanLabel.textColor = [UIColor redColor];
        self.oneyuanLabel = oneyuanLabel;
        [self.priceLabel addSubview:oneyuanLabel];
    }
}

- (void)setImageUrl:(NSString *)url title:(NSString *)title price:(NSString *)price {
    NSString *name = [NSString stringWithFormat:@"%@", title];
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageDefaultWithSize:CGSizeMake(self.imageView.width, self.imageView.width)]];
    self.imageView.clipsToBounds = YES;
    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    self.titleLabel.text = name.length>7?[NSString stringWithFormat:@"%@...", [name substringToIndex:7]] : title;
    self.priceLabel.text = @"";
    self.oneyuanLabel.text = [NSString stringWithFormat:@"%@元",price];
}

#pragma mark - getter
- (UIImageView *)imageView {
    if (_imageView == nil) {
        _imageView = [[UIImageView alloc] init];
        
    }
    return _imageView;
}

- (UILabel *)titleLabel {
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.font = kFont6px(24);
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

- (UILabel *)priceLabel {
    if (_priceLabel == nil) {
        _priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
        _priceLabel.textColor = tarbarrossred;
        _priceLabel.textAlignment = NSTextAlignmentCenter;
        _priceLabel.font = kFont6px(28);

    }
    return _priceLabel;
}

- (UIImageView *)mengcengImageView {
    if (_mengcengImageView == nil) {
        _mengcengImageView = [[UIImageView alloc] init];
        UIImage *image = [UIImage imageNamed:@"miyou_mengceng"];
        image = [image stretchableImageWithLeftCapWidth:image.size.width * 0.5 topCapHeight:image.size.height * 0.5];
        _mengcengImageView.image = image;
    }
    return _mengcengImageView;
}

+(CGSize)cellSizeWithObj:(id)obj {
    CGSize size = CGSizeZero;
    if ([obj isKindOfClass:[IntimateCircleModel class]]) {
        
    }
//    size = CGSizeMake(ZOOM6(150), ZOOM6(240));
    size = CGSizeMake(ZOOM6(180), ZOOM6(270));
    return size;
}

@end
