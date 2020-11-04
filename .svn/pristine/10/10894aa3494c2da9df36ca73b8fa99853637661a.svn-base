//
//  MyGoldCouponsCell.m
//  YunShangShiJi
//
//  Created by yssj on 2016/10/9.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import "MyGoldCouponsCell.h"
#import "GlobalTool.h"
#import "VoucherModel.h"
#import "NSDate+Helper.h"
#import "GoldCouponsManager.h"

/// 高／宽 比
#define BGIMGHAW_MULTIPLIED(image) (image.size.height/image.size.width)
#define kGlodColor [UIColor colorWithRed:255/255.0 green:183/255.0 blue:69/255.0 alpha:255/255.0]

#pragma mark - 父类 MyCouponsCell interface
@interface MyGoldCouponsCell ()

@property (nonatomic, strong) UIImageView *bgImageView; //背景图片
@property (nonatomic, strong) UILabel *moneyLabel; //金额
@property (nonatomic, strong) UILabel *signLabel; //人民币符号
@property (nonatomic, strong) UILabel *unitLabel; //单位

@end


#pragma mark - 抵用券 VouchersCell interface
@interface MyVouchersCell : MyGoldCouponsCell

@property (nonatomic, strong) UILabel *numberLabel;  //数量
@property (nonatomic, strong) UILabel *promptLabel;  //提示文字

@end


#pragma mark - 优惠券 CouponCell interface
@interface MyCouponCell : MyGoldCouponsCell
{
    BOOL _isUse; //是否失效
    BOOL _isGold; //是否金券
    __block NSTimer *_timer;
}
@property (nonatomic, strong) UIImageView *icoImageView; //已使用／已过期标识
@property (nonatomic, strong) UILabel *titleLabel;  //标题
@property (nonatomic, strong) UILabel *timeLabel;  //使用期限
@property (nonatomic, strong) UILabel *termLable;  //使用条件

/// 初始化方法：isUse (YES为失效Cell，NO为未失效Cell）
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier isUse:(BOOL)isUse isGold:(BOOL)isGold;

@end



#pragma mark - 父类 MyCouponsCell implementation
@implementation MyGoldCouponsCell

/// cell的创建与复用
+ (instancetype)cellWithType:(MyGoldCouponsCellType)type tableView:(UITableView *)tableView {
    static NSString *VoucherName = @"MyGoldCouponsCellTypeVoucher";
    static NSString *CouponName = @"MyGoldCouponsCellTypeCoupon";
    static NSString *GoldName = @"MyGoldCouponsCellTypeGold";

    MyGoldCouponsCell *cell = nil;
    switch (type) {
        case MyGoldCouponsCellTypeVoucher:
        {
            cell = [tableView dequeueReusableCellWithIdentifier:VoucherName];
            if (nil == cell) {
                cell = [[MyVouchersCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:VoucherName];
            }
        }
            break;
        case MyGoldCouponsCellTypeCoupon:
        {
            cell = [tableView dequeueReusableCellWithIdentifier:CouponName];
            if (nil == cell) {
                cell = [[MyCouponCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CouponName isUse:NO isGold:NO];
            }
        }
            break;
        case MyGoldCouponsCellTypeCouponFail:
        {
            cell = [tableView dequeueReusableCellWithIdentifier:CouponName];
            if (nil == cell) {
                cell = [[MyCouponCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CouponName isUse:YES isGold:NO];
            }
        }
            break;
        case MyGoldCouponsCellTypeGold:
        {
            cell = [tableView dequeueReusableCellWithIdentifier:GoldName];
            if (nil == cell) {
                cell = [[MyCouponCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:GoldName isUse:NO isGold:YES];
            }
        }
            break;
        case MyGoldCouponsCellTypeGoldFail:
        {
            cell = [tableView dequeueReusableCellWithIdentifier:GoldName];
            if (nil == cell) {
                cell = [[MyCouponCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:GoldName isUse:YES isGold:YES];
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
        _bgImageView.userInteractionEnabled = YES;
    }
    return _bgImageView;
}

- (UILabel *)moneyLabel {
    if (nil == _moneyLabel) {
        _moneyLabel = [[UILabel alloc] init];
        _moneyLabel.font = [UIFont systemFontOfSize:kZoom6pt(38)];
        _moneyLabel.textColor = tarbarrossred;
    }
    return _moneyLabel;
}

- (UILabel *)signLabel {
    if (nil == _signLabel) {
        _signLabel = [[UILabel alloc] init];
        _signLabel.font = [UIFont boldSystemFontOfSize:kZoom6pt(17)];
        _signLabel.textColor = tarbarrossred;
        _signLabel.text = @"￥";
    }
    return _signLabel;
}

- (UILabel *)unitLabel {
    if (nil == _unitLabel) {
        _unitLabel = [[UILabel alloc] init];
        _unitLabel.font = [UIFont boldSystemFontOfSize:kZoom6pt(17)];
        _unitLabel.textColor = tarbarrossred;
    }
    return _unitLabel;
}

- (UIButton *)userButton {
    if (nil == _userButton) {
        _userButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _userButton.layer.cornerRadius=3;
        [_userButton setTitle:@"使用" forState:UIControlStateNormal];
        [_userButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_userButton addTarget:self action:@selector(BtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _userButton;
}

- (void)BtnClick {
    if (self.UseBtnBlock) {
        self.UseBtnBlock();
    }
}

@end



#pragma mark - 抵用券 VouchersCell implementation
@implementation MyVouchersCell

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
    
    self.bgImageView.image = [UIImage imageNamed:@"diyongquan_bg"];
    self.unitLabel.text = @"元";
    
    [self.bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@0);
        make.centerX.equalTo(self.contentView);
        make.left.equalTo(@kZoom6pt(15));
        make.right.equalTo(@kZoom6pt(-15));
//        make.height.equalTo(self.bgImageView.mas_width).multipliedBy(BGIMGHAW_MULTIPLIED(self.bgImageView.image));
        make.height.offset(kZoom6pt(95));
    }];
    
    [self.signLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@kZoom6pt(90));
        make.bottom.equalTo(self.moneyLabel.mas_bottom).offset(kZoom6pt(-6));
    }];
    
    [self.moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.signLabel.mas_right).offset(0);
        make.centerY.equalTo(self.bgImageView.mas_centerY).offset(-kZoom6pt(10));
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
        _promptLabel.textColor = tarbarrossred;
        _promptLabel.text = @"无门槛、可叠加使用";
    }
    return _promptLabel;
}

@end


#pragma mark - 优惠券 CouponCell implementation
@implementation MyCouponCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setUI];
    }
    return self;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier isUse:(BOOL)isUse isGold:(BOOL)isGold{
    _isUse = isUse;
    _isGold = isGold;
    return [self initWithStyle:style reuseIdentifier:reuseIdentifier];
}

/// 创建UI
- (void)setUI {

    
    NSString *imageName = _isUse?(_isGold?@"jinquan_shixiao_bg":@"youhuiquan_shixiao_bg"):(_isGold?@"jinquan_bg":@"youhuiquan_bg");

    self.bgImageView.image = [UIImage imageNamed:imageName];
    self.unitLabel.text = @"元";
    
    self.unitLabel.textColor = _isUse?kSubTitleColor:(_isGold?kGlodColor:tarbarrossred);
    self.signLabel.textColor = _isUse?kSubTitleColor:(_isGold?kGlodColor:tarbarrossred);
    self.moneyLabel.textColor = _isUse?kSubTitleColor:(_isGold?kGlodColor:tarbarrossred);
    self.timeLabel.hidden = _isUse&&_isGold;
    self.userButton.hidden = _isUse;
    self.userButton.backgroundColor = _isGold?kGlodColor:tarbarrossred;

    [self.contentView addSubview:self.bgImageView];
    [self.bgImageView addSubview:self.titleLabel];
    [self.bgImageView addSubview:self.timeLabel];
    [self.bgImageView addSubview:self.termLable];

    [self.bgImageView addSubview:self.signLabel];
    [self.bgImageView addSubview:self.moneyLabel];
    [self.bgImageView addSubview:self.unitLabel];
    
    [self.bgImageView addSubview:self.userButton];

    [self.bgImageView addSubview:self.icoImageView];
    
    [self.bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@0);
        make.centerX.equalTo(self.contentView);
        make.left.equalTo(@kZoom6pt(15));
        make.right.equalTo(@kZoom6pt(-15));
//        make.height.equalTo(self.bgImageView.mas_width).multipliedBy(BGIMGHAW_MULTIPLIED(self.bgImageView.image));
        make.height.offset(kZoom6pt(95));

    }];

    
    [self.userButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@kZoom6pt(-15));
        make.centerY.equalTo(self.bgImageView);
        make.height.equalTo(@kZoom6pt(30));
        make.width.equalTo(@kZoom6pt(70));
    }];

    [self.termLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@kZoom6pt(90));
        if(_isUse&&_isGold){
            make.bottom.equalTo(self.userButton.mas_bottom).offset(kZoom6pt(8));
        }else
            make.bottom.equalTo(self.userButton);
    }];
    
    [self.signLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@kZoom6pt(90));
        make.bottom.equalTo(self.termLable.mas_top).offset(kZoom6pt(-3));
    }];
    
    [self.moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.signLabel.mas_right).offset(0);
        make.bottom.equalTo(self.termLable.mas_top).offset(kZoom6pt(3));
    }];
    
    [self.unitLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.moneyLabel.mas_right).offset(kZoom6pt(5));
        make.bottom.equalTo(self.signLabel);
    }];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.termLable.mas_bottom).offset(kZoom6pt(5));
        make.left.equalTo(self.signLabel);
    }];
    
    
    [self.icoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@kZoom6pt(-25));
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
    if (_isGold&&!_isUse) {
//        [self doubleTime:[carModel.c_last_time longLongValue]];
        [self doubleTime:[GoldCouponsManager goldcpManager].goldcp_end_date];
    }else
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
        _timeLabel.textColor = kSubTitleColor;
    }
    return _timeLabel;
}

- (UILabel *)termLable {
    if (nil == _termLable) {
        _termLable = [[UILabel alloc] init];
        _termLable.font = [UIFont systemFontOfSize:kZoom6pt(11)];
        _termLable.textColor = _isUse?kSubTitleColor:(_isGold?kGlodColor:tarbarrossred);
    }
    return _termLable;
}


- (void)doubleTime:(long long)endtime {
    kSelfWeak;
//    [NSDate systemCurrentTime:^(long long time) {
    if (_timer==nil) {
        long long time = [[[NSUserDefaults standardUserDefaults]objectForKey:@"systemCurrentTime"]longLongValue];
        
        __block  NSInteger  _timeout = (NSInteger)(endtime/1000 - time/1000);
        //            [self countdownTime];
        _timer = [NSTimer weakTimerWithTimeInterval:1.0 target:self userInfo:nil repeats:YES block:^(id target, NSTimer *timer) {
            
            if(_timeout<=0){ //倒计时结束，关闭
                if (self.GoldTimeoutBlock) {
                    self.GoldTimeoutBlock();
                }
                [_timer invalidate];
                _timer=nil;
            } else {
                int hour = (int) (_timeout%(60*60*24))/60/60;
                int minute = (int)( _timeout%(60*60))/60;
                int seconds = (int)_timeout%60;
                NSString *strTime = [NSString stringWithFormat:@"距离失效还剩：%02d时%02d分%02d秒", hour, minute, seconds];
                weakSelf.timeLabel.attributedText=[self getOneColorInLabel:strTime Color:tarbarrossred fontSize:kZoom6pt(11)];
                _timeout--;
            }
        }];
    }

        
//    }];
    
}
- (NSMutableAttributedString *)getOneColorInLabel:(NSString *)allstring Color:(UIColor*)color fontSize:(float)size
{
    //这是我们的测试用的文本字符串数据
    NSArray *number = @[@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9"];
    NSMutableAttributedString *attributeString  = [[NSMutableAttributedString alloc]initWithString:allstring];
    for (int i = 0; i < allstring.length; i ++) {
        //这里的小技巧，每次只截取一个字符的范围
        NSString *a = [allstring substringWithRange:NSMakeRange(i, 1)];
        //判断装有0-9的字符串的数字数组是否包含截取字符串出来的单个字符，从而筛选出符合要求的数字字符的范围NSMakeRange
        if ([number containsObject:a]) {
            [attributeString setAttributes:@{NSForegroundColorAttributeName:color,NSFontAttributeName:[UIFont systemFontOfSize:size]} range:NSMakeRange(i, 1)];
        }
    }
    return attributeString;
}
/*
/// 倒计时
- (void)countdownTime {
    kSelfWeak;
    if (_timer != nil) {
        return;
    }
    _timer = [NSTimer weakTimerWithTimeInterval:1.0 target:self userInfo:nil repeats:YES block:^(id target, NSTimer *timer) {
        kSelfStrong;
        if(strongSelf -> _timeout<=0){ //倒计时结束，关闭
            [strongSelf -> _timer invalidate];
            strongSelf -> _timer = nil;
        } else {
            int hour = (int)strongSelf -> _timeout/60/60;
            int minute = (int)(strongSelf -> _timeout%(60*60))/60;
            int seconds = (int)strongSelf -> _timeout%60;
            NSString *strTime = [NSString stringWithFormat:@"距余额翻倍结束还剩：%02d时%02d分%02d秒", hour, minute, seconds];
            [NSString getOneColorInLabel:strTime strs:@[[NSString stringWithFormat:@"%d",hour],[NSString stringWithFormat:@"%d",minute],[NSString stringWithFormat:@"%d",seconds]] Color:tarbarrossred fontSize:kZoom6pt(11)];
            strongSelf -> _timeout--;
        }
    }];
}
*/
@end



