//
//  MyCouponsCell.m
//  YunShangShiJi
//
//  Created by zgl on 16/5/20.
//  Copyright © 2016年 ios-1. All rights reserved.
//  我的卡券Cell

#import "MyCouponsCell.h"
#import "GlobalTool.h"
#import "MyCardModel.h"
#import "VoucherModel.h"
/// 高／宽 比
#define BGIMGHAW_MULTIPLIED(image) (image.size.height/image.size.width)

#pragma mark - 父类 MyCouponsCell interface
@interface MyCouponsCell ()

@property (nonatomic, strong) UIImageView *bgImageView; //背景图片
@property (nonatomic, strong) UILabel *moneyLabel; //金额
@property (nonatomic, strong) UILabel *signLabel; //人民币符号
@property (nonatomic, strong) UILabel *unitLabel; //单位

@end


#pragma mark - 抵用券 VouchersCell interface
@interface VouchersCell : MyCouponsCell

@property (nonatomic, strong) UILabel *numberLabel;  //数量
@property (nonatomic, strong) UILabel *promptLabel;  //提示文字

@end


#pragma mark - 优惠券 CouponCell interface
@interface CouponCell : MyCouponsCell
{
    BOOL _isUse; //是否失效
}
@property (nonatomic, strong) UIImageView *icoImageView; //已使用／已过期标识
@property (nonatomic, strong) UILabel *titleLabel;  //标题
@property (nonatomic, strong) UILabel *timeLabel;  //使用期限
@property (nonatomic, strong) UILabel *termLable;  //使用条件

/// 初始化方法：isUse (YES为失效Cell，NO为未失效Cell）
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier isUse:(BOOL)isUse;

@end


#pragma mark - 父类 MyCouponsCell implementation
@implementation MyCouponsCell

/// cell的创建与复用
+ (instancetype)cellWithType:(MyCouponsCellType)type tableView:(UITableView *)tableView {
    static NSString *VoucherName = @"MyCouponsCellTypeVoucher";
    static NSString *CouponName = @"MyCouponsCellTypeCoupon";
    MyCouponsCell *cell = nil;
    switch (type) {
        case MyCouponsCellTypeVoucher:
        {
            cell = [tableView dequeueReusableCellWithIdentifier:VoucherName];
            if (nil == cell) {
                cell = [[VouchersCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:VoucherName];
            }
        }
            break;
        case MyCouponsCellTypeCoupon:
        {
            cell = [tableView dequeueReusableCellWithIdentifier:CouponName];
            if (nil == cell) {
                cell = [[CouponCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CouponName isUse:NO];
            }
        }
            break;
        case MyCouponsCellTypeCouponFail:
        {
            cell = [tableView dequeueReusableCellWithIdentifier:CouponName];
            if (nil == cell) {
                cell = [[CouponCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CouponName isUse:YES];
            }
        }
            break;
        default:
            break;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}

/// 数据更新（子类重写）
- (void)receiveDataModel:(MyCardModel *)model {
    
}

/// getter
- (UIImageView *)bgImageView {
    if (nil == _bgImageView) {
        _bgImageView  = [[UIImageView alloc] init];
        _bgImageView.clipsToBounds = YES;
    }
    return _bgImageView;
}

- (UILabel *)moneyLabel {
    if (nil == _moneyLabel) {
        _moneyLabel = [[UILabel alloc] init];
        _moneyLabel.font = [UIFont systemFontOfSize:kZoom6pt(38)];
        _moneyLabel.textColor = [UIColor whiteColor];
    }
    return _moneyLabel;
}

- (UILabel *)signLabel {
    if (nil == _signLabel) {
        _signLabel = [[UILabel alloc] init];
        _signLabel.font = [UIFont boldSystemFontOfSize:kZoom6pt(17)];
        _signLabel.textColor = [UIColor whiteColor];
        _signLabel.text = @"￥";
    }
    return _signLabel;
}

- (UILabel *)unitLabel {
    if (nil == _unitLabel) {
        _unitLabel = [[UILabel alloc] init];
        _unitLabel.font = [UIFont boldSystemFontOfSize:kZoom6pt(17)];
        _unitLabel.textColor = [UIColor whiteColor];
    }
    return _unitLabel;
}

@end


#pragma mark - 抵用券 VouchersCell implementation
@implementation VouchersCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setUI];
    }
    return self;
}

/// 创建UI
- (void)setUI {
    [self.contentView addSubview:self.bgImageView];
    [self.bgImageView addSubview:self.signLabel];
    [self.bgImageView addSubview:self.moneyLabel];
    [self.bgImageView addSubview:self.unitLabel];
    [self.bgImageView addSubview:self.numberLabel];
    [self.bgImageView addSubview:self.promptLabel];
    
    self.bgImageView.image = [UIImage imageNamed:@"diyongquan_weishiyong_BG"];
    self.unitLabel.text = @"元抵用券";

    [self.bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@0);
        make.centerX.equalTo(self.contentView);
        make.left.equalTo(@kZoom6pt(15));
        make.right.equalTo(@kZoom6pt(-15));
        make.height.equalTo(self.bgImageView.mas_width).multipliedBy(BGIMGHAW_MULTIPLIED(self.bgImageView.image));
    }];
    
    [self.signLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@kZoom6pt(58));
        make.bottom.equalTo(self.moneyLabel).offset(kZoom6pt(-6));
    }];
    
    [self.moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.signLabel.mas_right).offset(0);
        make.centerY.equalTo(self.bgImageView).offset(-kZoom6pt(8));
    }];
    
    [self.unitLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.moneyLabel.mas_right).offset(kZoom6pt(5));
        make.bottom.equalTo(self.signLabel);
    }];
    
    [self.numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.bgImageView);
        make.centerX.equalTo(self.bgImageView.mas_right).offset(-kZoom6pt(55));
    }];
    
    [self.promptLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.unitLabel.mas_bottom).offset(kZoom6pt(5));
        make.left.equalTo(self.signLabel);
    }];
}

/// 更新数据
- (void)receiveDataModel:(id)model {
    VoucherModel *voucherModel = model;
    self.moneyLabel.text = [NSString stringWithFormat:@"%.0f",voucherModel.price];
    self.numberLabel.text = [NSString stringWithFormat:@"x%d",voucherModel.snum];
}

/// getter
- (UILabel *)numberLabel {
    if (nil == _numberLabel) {
        _numberLabel = [[UILabel alloc] init];
        _numberLabel.font = [UIFont systemFontOfSize:kZoom6pt(17)];
        _numberLabel.textColor = tarbarrossred;
    }
    return _numberLabel;
}

- (UILabel *)promptLabel {
    if (nil == _promptLabel) {
        _promptLabel = [[UILabel alloc] init];
        _promptLabel.font = [UIFont systemFontOfSize:kZoom6pt(12)];
        _promptLabel.textColor = [UIColor whiteColor];
        _promptLabel.text = @"无门槛、可叠加使用";
    }
    return _promptLabel;
}

@end


#pragma mark - 优惠券 CouponCell implementation
@implementation CouponCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setUI];
    }
    return self;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier isUse:(BOOL)isUse {
    _isUse = isUse;
    return [self initWithStyle:style reuseIdentifier:reuseIdentifier];
}

/// 创建UI
- (void)setUI {
    UIView *letfView = [[UIView alloc] init];
    UIView *leftContView = [[UIView alloc] init];
    
    NSString *imageName = _isUse?@"youhuiquan_yishixiao_BG":@"youhuiquan_weishiyong_BG";
    self.bgImageView.image = [UIImage imageNamed:imageName];
    self.unitLabel.text = @"元";
    
    [self.contentView addSubview:self.bgImageView];
    [self.bgImageView addSubview:self.titleLabel];
    [self.bgImageView addSubview:self.timeLabel];
    [self.bgImageView addSubview:self.termLable];
    [letfView addSubview:leftContView];
    [leftContView addSubview:self.signLabel];
    [leftContView addSubview:self.moneyLabel];
    [leftContView addSubview:self.unitLabel];
    [self.bgImageView addSubview:letfView];
    [self.bgImageView addSubview:self.icoImageView];
    
    [self.bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@0);
        make.centerX.equalTo(self.contentView);
        make.left.equalTo(@kZoom6pt(15));
        make.right.equalTo(@kZoom6pt(-15));
        make.height.equalTo(self.bgImageView.mas_width).multipliedBy(BGIMGHAW_MULTIPLIED(self.bgImageView.image));
    }];
    
    [letfView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.equalTo(@0);
        make.width.equalTo(@kZoom6pt(120));
    }];
    
    [leftContView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(letfView);
    }];
    
    [self.signLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.bottom.equalTo(self.moneyLabel).offset(kZoom6pt(-6));
    }];
    
    [self.moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.signLabel.mas_right).offset(0);
        make.top.bottom.equalTo(@0);
    }];
    
    [self.unitLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.moneyLabel.mas_right).offset(kZoom6pt(5));
        make.right.equalTo(@0);
        make.bottom.equalTo(self.signLabel);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@kZoom6pt(26));
        make.left.equalTo(letfView.mas_right).offset(kZoom6pt(15));
    }];
    
    [self.termLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel.mas_right).offset(kZoom6pt(5));
        make.centerY.equalTo(self.titleLabel);
    }];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(kZoom6pt(5));
        make.left.equalTo(self.titleLabel);
    }];
    
    [self.icoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel);
        make.centerY.equalTo(self.bgImageView);
        make.width.equalTo(@kZoom6pt(89));
        make.height.equalTo(@kZoom6pt(76));
    }];
}

/// 更新数据
- (void)receiveDataModel:(id)model {
    MyCardModel *carModel = model;
    NSString *time1 = [self timeInfoWithDateString:[NSString stringWithFormat:@"%lld",carModel.c_add_time.longLongValue/1000]];
    NSString *time2 = [self timeInfoWithDateString:[NSString stringWithFormat:@"%lld",carModel.c_last_time.longLongValue/1000]];
    NSString *imgName = carModel.is_use.intValue == 2 ?@"yinzhang_yishiyong":@"yinzhang_yiguoqi";
    NSString *term = [NSString stringWithFormat:@"(满%@元可用)",carModel.c_cond];
    
    self.termLable.text = term;
    self.timeLabel.text = [NSString stringWithFormat:@"使用时间：%@-%@",time1,time2];
    self.moneyLabel.text = [NSString stringWithFormat:@"%d",carModel.c_price.intValue];
    self.icoImageView.image = [UIImage imageNamed:imgName];
    self.icoImageView.hidden = !_isUse;
}

/// 显示时间
- (NSString *)timeInfoWithDateString:(NSString *)timeString
{
    NSDate *oldDate = [NSDate dateWithTimeIntervalSince1970:[timeString longLongValue]];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy.MM.dd"];
    NSString *showOldDate = [formatter stringFromDate:oldDate];
    return showOldDate;
}

/// getter
- (UIImageView *)icoImageView {
    if (nil == _icoImageView) {
        _icoImageView  = [[UIImageView alloc] init];
        _icoImageView.clipsToBounds = YES;
        _icoImageView.hidden = !_isUse;
    }
    return _icoImageView;
}

- (UILabel *)titleLabel {
    if (nil == _titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont boldSystemFontOfSize:kZoom6pt(17)];
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.text = @"优惠券";
    }
    return _titleLabel;
}

- (UILabel *)timeLabel {
    if (nil == _timeLabel) {
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.font = [UIFont systemFontOfSize:kZoom6pt(11)];
        _timeLabel.textColor = [UIColor whiteColor];
    }
    return _timeLabel;
}

- (UILabel *)termLable {
    if (nil == _termLable) {
        _termLable = [[UILabel alloc] init];
        _termLable.font = [UIFont systemFontOfSize:kZoom6pt(11)];
        _termLable.textColor = [UIColor whiteColor];
    }
    return _termLable;
}

@end