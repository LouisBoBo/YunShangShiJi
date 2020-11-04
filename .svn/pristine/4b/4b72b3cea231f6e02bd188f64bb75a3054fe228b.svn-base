//
//  YFDPAddShopCell.m
//  YunShangShiJi
//
//  Created by zgl on 16/6/18.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import "YFDPAddShopCell.h"
#import "GlobalTool.h"
#import "YFStepperView.h"
#import "AddShopModel.h"
#import "UIImageView+WebCache.h"
#import "DefaultImgManager.h"

#define DefaultImg(size) [[DefaultImgManager sharedManager] defaultImgWithSize:(size)]
#define space       kZoom6pt(10)
#define items       5
#define itemWidth   (kScreenWidth - kZoom6pt(10) - space*items)/items
#define itemHeight  kZoom6pt(30)

@interface YFDPAddShopCell ()

@property (nonatomic, strong) UIImageView *imgView;//图片
@property (nonatomic, strong) UIButton *selectBtn;//选择按钮
@property (nonatomic, strong) UILabel *titleLabel;//商品名称
@property (nonatomic, strong) UILabel *priceLabel;//出售价格
@property (nonatomic, strong) UILabel *originalLabel;//原价
@property (nonatomic, strong) YFStepperView *stepperView;//数量选择
@property (nonatomic, strong) UIView *colorView;//颜色
@property (nonatomic, strong) UIView *sizeView;//尺码
@property (nonatomic, assign) NSInteger colorIndex;//选中颜色
@property (nonatomic, assign) NSInteger sizeIndex;//选中尺码
@property (nonatomic, assign) NSUInteger sTag;//尺码tag开始值
@property (nonatomic, copy) NSArray *colors;//颜色相关信息数组

@end

@implementation YFDPAddShopCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
#if 0
        _selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _selectBtn.frame = CGRectMake(kZoom6pt(10), kZoom6pt(40), kZoom6pt(20), kZoom6pt(20));
        [_selectBtn setImage:[UIImage imageNamed:@"icon_dapeigou_normal"] forState:UIControlStateNormal];
        [_selectBtn setImage:[UIImage imageNamed:@"icon_dapeigou_celect"] forState:UIControlStateSelected];
        [_selectBtn setImage:[UIImage imageNamed:@"icon_dapeigou_normal"] forState:UIControlStateNormal|UIControlStateHighlighted];
        [_selectBtn setImage:[UIImage imageNamed:@"icon_dapeigou_celect"] forState:UIControlStateSelected|UIControlStateHighlighted];
        [_selectBtn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_selectBtn];
#endif
        _imgView = [[UIImageView alloc] initWithFrame:CGRectMake(kZoom6pt(10), kZoom6pt(15), kZoom6pt(70), kZoom6pt(70))];
        _imgView.backgroundColor = kBackgroundColor;
        _imgView.contentMode = UIViewContentModeScaleAspectFill;
        _imgView.clipsToBounds = YES;
        [self.contentView addSubview:_imgView];
        
        _titleLabel = [self labelWithColor:[UIColor colorWithWhite:62/255. alpha:1] FontSize:kZoom6pt(15)];
        [self.contentView addSubview:_titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_imgView);
            make.left.equalTo(_imgView.mas_right).offset(kZoom6pt(10));
            make.right.equalTo(@(-kZoom6pt(10)));
        }];
        
        _priceLabel = [self labelWithColor:[UIColor colorWithWhite:62/255. alpha:1] FontSize:kZoom6pt(15)];
        [self.contentView addSubview:_priceLabel];
        [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_titleLabel.mas_bottom).offset(kZoom6pt(5));
            make.left.equalTo(_titleLabel);
        }];
        
        _originalLabel = [self labelWithColor:[UIColor colorWithWhite:168/255. alpha:1] FontSize:kZoom6pt(12)];
        [self.contentView addSubview:_originalLabel];
        [_originalLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(_priceLabel);
            make.left.equalTo(_priceLabel.mas_right).offset(kZoom6pt(5));
        }];
        
        UIView *linView = [[UIView alloc] init];
        linView.backgroundColor = [UIColor colorWithWhite:168/255. alpha:1];
        [_originalLabel addSubview:linView];
        [linView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(@0);
            make.centerY.equalTo(_originalLabel);
            make.height.equalTo(@1);
        }];
        
        _stepperView = [[YFStepperView alloc] initWithFrame:CGRectMake(kZoom6pt(90), kZoom6pt(60), kZoom6pt(100), kZoom6pt(25))];
        [self.contentView addSubview:_stepperView];
        
        UIView *spaceView = [[UIView alloc] init];
        spaceView.backgroundColor = kBackgroundColor;
        [self.contentView addSubview:spaceView];
        [spaceView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(@0);
            make.height.equalTo(@(kZoom6pt(10)));
        }];
    }
    return self;
}

#pragma mark - 点击事件
/// 颜色尺码点击
- (void)btnClick:(UIButton *)sender {
    if (sender.selected) {
        return;
    }
    
    if (sender.tag < _sTag) {  //颜色
        _colorIndex = sender.tag - 2000;
    } else {  //尺码
        _sizeIndex = sender.tag - _sTag;
    }
    /// 更新按钮
    [self isNoSelect];
    /// 回调
    if (_colorSizeBlock&&_sizeIndex!=-1&&_colorIndex!=-1) {
        _colorSizeBlock(_colorIndex, _sizeIndex);
    }
}

/// 尺码是否可以选择
- (void)isNoSelect {
    NSDictionary *dicC = _colors.count > _colorIndex?_colors[_colorIndex]:nil;
    NSArray *aryC = [dicC objectForKey:@"isSelect"];
    //如果当前颜色存在尺码可选，并且当前选中尺码与颜色没有库存，则取有库存的第一个尺码
    if (aryC.count&&[aryC indexOfObject:@(_sizeIndex)] == NSNotFound) {
        _sizeIndex = ((NSNumber *)[aryC firstObject]).integerValue;
        
    }
    //更新尺码按钮
    [self changeBtnWithSuperView:_sizeView index:_sizeIndex noSelect:aryC sTag:_sTag];
    //更新颜色按钮
    [self changeBtnWithSuperView:_colorView index:_colorIndex noSelect:nil sTag:2000];
}

/// 更新按钮
- (void)changeBtnWithSuperView:(UIView *)superView index:(NSInteger)index noSelect:(NSArray *)array sTag:(NSInteger)sTag{
    for (UIView *view in superView.subviews) {
        if ([view isKindOfClass:[UIButton class]]) {
            UIButton *button = (UIButton *)view;
            NSInteger tag = button.tag - sTag;
            if (tag == index && (_stepperView.maximumValue > 0||superView == _colorView)) {
                //选中
                button.selected = YES;
                button.layer.borderWidth = 0.;
                button.userInteractionEnabled = YES;
            } else if([array indexOfObject:@(tag)] != NSNotFound) {
                //可选
                [button setTitleColor:[UIColor colorWithWhite:125/255.0 alpha:1] forState:UIControlStateNormal];
                [button setTitleColor:[UIColor colorWithWhite:125/255.0 alpha:1] forState:UIControlStateNormal|UIControlStateHighlighted];
                button.layer.borderColor = [UIColor colorWithWhite:168/255.0 alpha:1].CGColor;
                button.layer.borderWidth = 0.5;
                button.userInteractionEnabled = YES;
                button.selected = NO;
            } else {
                //不可选
                [button setTitleColor:[UIColor colorWithWhite:197/255.0 alpha:1] forState:UIControlStateNormal];
                [button setTitleColor:[UIColor colorWithWhite:197/255.0 alpha:1] forState:UIControlStateNormal|UIControlStateHighlighted];
                button.layer.borderColor = [UIColor colorWithWhite:197/255.0 alpha:1].CGColor;
                button.userInteractionEnabled = NO;
                button.selected = NO;
                button.layer.borderWidth = 0.5;

            }
        }
    }
}

/// 选中点击
- (void)click:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (_selectBlock) {
        _selectBlock(sender.selected);
    }
}

#pragma mark - 更新数据
- (void)receiveDataModel:(DPShopModel *)model {
    _stepperView.value = model.shopNumber;
    _stepperView.minimumValue = 1;
    _stepperView.maximumValue = model.stock;
    _stepperView.stepValue = 1;
    _colorIndex = model.colorIndex;
    _sizeIndex = model.sizeIndex;
    _titleLabel.text = model.shop_name;
    _priceLabel.text = [NSString stringWithFormat:@"¥%@",model.price];
    _originalLabel.text = [NSString stringWithFormat:@"¥%@",model.shop_price];
    
    NSString *supcode  = [model.shop_code substringWithRange:NSMakeRange(1, 3)];
    NSString *url = [NSString stringWithFormat:@"%@%@/%@/%@",[NSObject baseURLStr_Upy],supcode,model.shop_code,model.pic];
    NSURL *imgUrl = [NSURL URLWithString:url];
    
    [_imgView sd_setImageWithURL:imgUrl placeholderImage:DefaultImg(_imgView.bounds.size)];
    _selectBtn.userInteractionEnabled = model.stock > 0;
    _selectBtn.selected = model.stock > 0?model.isSelect:NO;
    [_colorView removeFromSuperview];
    [_sizeView removeFromSuperview];
    _colorView = nil;
    _sizeView = nil;
    
    _sTag = model.colors.count + 2000;
    _colors = model.colors;
    
    if (model.colors.count) {
        _colorView = [self listViewWithTitle:@"颜色" data:model.colors tag:2000];
        _colorView.frame = CGRectMake(kZoom6pt(10), kZoom6pt(95), CGRectGetWidth(_colorView.bounds), CGRectGetHeight(_colorView.bounds));
        [self.contentView addSubview:_colorView];
    }
    
    if (model.sizes.count) {
        CGFloat top = (_colorView == nil)?kZoom6pt(95):kZoom6pt(110)+CGRectGetHeight(_colorView.bounds);
        _sizeView = [self listViewWithTitle:@"尺码" data:model.sizes tag:_sTag];
        _sizeView.frame = CGRectMake(kZoom6pt(10), top, CGRectGetWidth(_sizeView.bounds), CGRectGetHeight(_sizeView.bounds));
        [self.contentView addSubview:_sizeView];
    }
    
    [self isNoSelect];
}

#pragma mark - 创建视图公共方法
/// 创建颜色或尺码
- (UIView *)listViewWithTitle:(NSString *)title data:(NSArray *)data tag:(NSInteger)tag{
    [YFDPAddShopCell widthAndFrameWithArray:data];
    
    UIView *view = [[UIView alloc] init];
    CGFloat textHeight = [NSString heightWithString:@"颜色" font:[UIFont systemFontOfSize:kZoom6pt(14)] constrainedToWidth:100];
    UILabel *nameLabel = [self labelWithColor:[UIColor colorWithWhite:62/255. alpha:1] FontSize:kZoom6pt(14)];
    nameLabel.text = title;
    nameLabel.frame = CGRectMake(0, 0, kScreenWidth - kZoom6pt(20), textHeight);
    [view addSubview:nameLabel];
    
    CGFloat height = textHeight;
    for (int i = 0; i < data.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageWithColor:tarbarrossred] forState:UIControlStateSelected];
        [button setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal|UIControlStateHighlighted];
        [button setBackgroundImage:[UIImage imageWithColor:tarbarrossred] forState:UIControlStateSelected|UIControlStateHighlighted];
        [button setTitleColor:[UIColor colorWithWhite:125/255.0 alpha:1] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor colorWithWhite:125/255.0 alpha:1] forState:UIControlStateNormal|UIControlStateHighlighted];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected|UIControlStateHighlighted];
        NSDictionary *dic = data[i];
        [button setTitle:[dic objectForKey:@"name"] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:kZoom6pt(12)];
        button.titleLabel.numberOfLines = 0;
        button.tag = tag + i;
        button.layer.borderColor = [UIColor colorWithWhite:168/255.0 alpha:1].CGColor;
        button.layer.borderWidth = 0.5;
        button.layer.cornerRadius = 2.;
        button.layer.masksToBounds = YES;
        [button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:button];
        
        NSValue *value = [dic objectForKey:@"frame"];
        CGRect frame;
        [value getValue:&frame];
        button.frame = frame;
        height = frame.origin.y + frame.size.height;
    }
    view.bounds = CGRectMake(0, 0, kScreenWidth - kZoom6pt(20), height);
    return view;
}

///创建label
- (UILabel *)labelWithColor:(UIColor *)color FontSize:(NSInteger)size {
    UILabel *label = [[UILabel alloc] init];
    label.textColor = color;
    label.textAlignment = NSTextAlignmentLeft;
    label.font = [UIFont systemFontOfSize:size];
    return label;
}

#pragma mark - setter
- (void)setNumberBlock:(void (^)(NSInteger))numberBlock {
    _stepperView.valueChangeBlock = numberBlock;
}

#pragma mark - cell高度
+ (CGFloat)cellHeightWithModel:(DPShopModel *)model {
    CGFloat height = kZoom6pt(100);
    if (model.colors.count) {
        height += [self widthAndFrameWithArray:model.colors] + kZoom6pt(10);
    }
    
    if (model.sizes.count) {
        CGFloat top = model.colors.count?kZoom6pt(15):kZoom6pt(10);
        height += [self widthAndFrameWithArray:model.sizes] + top;
    }
    
    return height + kZoom6pt(10);
}

+ (CGFloat)widthAndFrameWithArray:(NSArray *)array {
    CGFloat textHeight = [NSString heightWithString:@"颜色" font:[UIFont systemFontOfSize:kZoom6pt(14)] constrainedToWidth:100];
    CGFloat x = 0;
    CGFloat y = textHeight + kZoom6pt(8);
    for (NSMutableDictionary *dict in array) {
        CGFloat width = [NSString widthWithString:dict[@"name"] font:[UIFont systemFontOfSize:kZoom6pt(12)] constrainedToHeight:itemHeight] + ZOOMPT(30);
        if (width < itemWidth) {
            width = itemWidth;
        }
        
        if (x + width > kScreenWidth - kZoom6pt(20)) {
            x = 0;
            y += itemHeight + space;
        }
        NSValue *value = [NSValue valueWithCGRect:CGRectMake(x, y, width, itemHeight)];
        [dict setObject:value forKey:@"frame"];
        x += width + space;
    }
    
    return y + itemHeight;
}

@end
