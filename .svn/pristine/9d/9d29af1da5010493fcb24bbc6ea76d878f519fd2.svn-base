//
//  ChangShopTableViewCell.m
//  YunShangShiJi
//
//  Created by ios-1 on 2017/1/19.
//  Copyright © 2017年 ios-1. All rights reserved.
//

#import "ChangShopTableViewCell.h"
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


@implementation ChangShopTableViewCell


- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;

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
            make.right.equalTo(@(-kZoom6pt(40)));
        }];
        
        //关掉按钮
        UIButton* closebutton=[UIButton buttonWithType:UIButtonTypeRoundedRect];
        closebutton.frame=CGRectMake(kApplicationWidth-ZOOM(55*3.4), kZoom6pt(5), ZOOM(55*3.4), ZOOM(55*3.4));
        closebutton.titleLabel.font=[UIFont systemFontOfSize:25];
        [closebutton addTarget:self action:@selector(dismissSemiModalView) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:closebutton];
        UIImageView *closeimg = [[UIImageView alloc]initWithFrame:CGRectMake(ZOOM(55*3.4)-ZOOM(15*3.4)-ZOOM(40), 10, ZOOM(15*3.4), ZOOM(15*3.4))];
        closeimg.image = [UIImage imageNamed:@"×"];
        [closebutton addSubview:closeimg];

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
        
        _stepperView = [[YFStepperView alloc] init];
        _stepperView.tag = 88888;
        [self.contentView addSubview:_stepperView];
        
//        UIView *spaceView = [[UIView alloc] init];
//        spaceView.backgroundColor = kBackgroundColor;
//        [self.contentView addSubview:spaceView];
//        [spaceView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.right.bottom.equalTo(@0);
//            make.height.equalTo(@(kZoom6pt(10)));
//        }];
    }
    return self;
}

#pragma mark - 点击事件
/// 颜色尺码点击
- (void)btnClick:(UIButton *)sender {
    
    if (sender.selected) {
        return;
    }
    if(self.isSpecialShop)
    {
        if(sender.tag < _sTag)
        {
            _colorIndex = sender.tag - 2000;
        }else if (self.tag < _oTag)
        {
            _sizeIndex = sender.tag - _sTag;
        }else{
            _otherIndex = sender.tag - _oTag;
        }
        /// 更新按钮
        [self isNoSelect];
        /// 回调
        if (_colorSizeOtherBlock&&_sizeIndex!=-1&&_colorIndex!=-1&&_otherIndex!=-1) {
            _colorSizeOtherBlock(_colorIndex, _sizeIndex,_otherIndex);
        }
    }else{
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
    
}

/// 尺码是否可以选择
- (void)isNoSelect {
    NSDictionary *dicC = _colors.count > _colorIndex?_colors[_colorIndex]:nil;
    NSArray *aryC = [dicC objectForKey:@"isSelect"];
    //如果当前颜色存在尺码可选，并且当前选中尺码与颜色没有库存，则取有库存的第一个尺码
    if (aryC.count&&[aryC indexOfObject:@(_sizeIndex)] == NSNotFound) {
        _sizeIndex = ((NSNumber *)[aryC firstObject]).integerValue;
        
    }
    
    //更新颜色按钮
    [self changeBtnWithSuperView:_colorView index:_colorIndex noSelect:nil sTag:2000];
    
    //更新尺码按钮
    [self changeBtnWithSuperView:_sizeView index:_sizeIndex noSelect:aryC sTag:_sTag];
    
    //更新其它按钮
    [self changeBtnWithSuperView:_otherView index:_otherIndex noSelect:aryC sTag:_oTag];
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

//确定
- (void)okClick:(UIButton*)sender
{
    if(self.okchange && self.dpModel.stock>0)
    {
        self.okchange();
    }
    [self dismissSemiModalView];
}

//关闭
- (void)dismissSemiModalView
{
    if(self.dismissModalView)
    {
        self.dismissModalView();
    }
}
#pragma mark - 更新数据
- (void)receiveDataModel:(DPShopModel *)model MiniShare:(BOOL)shareSuccess;
{
    self.dpModel = model;
    _stepperView.value = model.shopNumber;
    _stepperView.minimumValue = 1;
    _stepperView.maximumValue = model.stock>2?2:model.stock;
    
    if(model.isFight || shareSuccess)
    {
        _stepperView.maximumValue = 1;
    }
    _stepperView.stepValue = 1;
    _colorIndex = model.colorIndex;
    _sizeIndex = model.sizeIndex;
    _titleLabel.text = model.shop_name;
    _priceLabel.hidden = [model.price floatValue] < 0;
    _priceLabel.text = [NSString stringWithFormat:@"¥%.1f",[model.price floatValue]];
    
    NSString *supcode  = [model.shop_code substringWithRange:NSMakeRange(1, 3)];
    NSString *url = [NSString stringWithFormat:@"%@%@/%@/%@",[NSObject baseURLStr_Upy],supcode,model.shop_code,model.pic];
    NSURL *imgUrl = [NSURL URLWithString:url];
    
    [_imgView sd_setImageWithURL:imgUrl placeholderImage:DefaultImg(_imgView.bounds.size)];
    _selectBtn.userInteractionEnabled = model.stock > 0;
    _selectBtn.selected = model.stock > 0?model.isSelect:NO;
    [_colorView removeFromSuperview];
    [_sizeView removeFromSuperview];
    [_otherView removeFromSuperview];
    
    
    _colorView = nil;
    _sizeView = nil;
    _otherView = nil;
    
    _sTag = model.colors.count + 2000;
    _colors = model.colors;
    
    if (model.colors.count) {
        _colorView = [self listViewWithTitle:@"颜色" data:model.colors tag:2000];
        _colorView.frame = CGRectMake(kZoom6pt(10), kZoom6pt(105), CGRectGetWidth(_colorView.bounds), CGRectGetHeight(_colorView.bounds));
        [self.contentView addSubview:_colorView];
    }
    
    if (model.sizes.count) {
        CGFloat top = (_colorView == nil)?kZoom6pt(105):kZoom6pt(130)+CGRectGetHeight(_colorView.bounds);
        _sizeView = [self listViewWithTitle:@"尺码" data:model.sizes tag:_sTag];
        _sizeView.frame = CGRectMake(kZoom6pt(10), top, CGRectGetWidth(_sizeView.bounds), CGRectGetHeight(_sizeView.bounds));
        [self.contentView addSubview:_sizeView];
    }
    

    if(model.colors.count || model.sizes.count)//新增
    {
        CGFloat textHeight = [NSString heightWithString:@"数量" font:[UIFont systemFontOfSize:kZoom6pt(14)] constrainedToWidth:100];
        [_nameLabel removeFromSuperview];
        _nameLabel = [self labelWithColor:[UIColor colorWithWhite:62/255. alpha:1] FontSize:kZoom6pt(14)];
        _nameLabel.text = @"数量";
        
        _nameLabel.frame = CGRectMake(kZoom6pt(10), CGRectGetMaxY(_sizeView.frame)+ZOOM6(50), kScreenWidth - kZoom6pt(20), textHeight);
        
        
        [self.contentView addSubview:_nameLabel];
        
        _stepperView.frame = CGRectMake(kZoom6pt(10), CGRectGetMaxY(_nameLabel.frame)+ZOOM6(20), kZoom6pt(100), kZoom6pt(25));
        
        [_stocklable removeFromSuperview];
        _stocklable = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_stepperView.frame)+ZOOM6(20), CGRectGetMinY(_stepperView.frame), ZOOM6(200), CGRectGetHeight(_stepperView.frame))];
        _stocklable.text = [NSString stringWithFormat:@"库存%d件",(int)model.stock];
        _stocklable.font = [UIFont systemFontOfSize:ZOOM6(22)];
        _stocklable.textColor = RGBCOLOR_I(125, 125, 125);
        [self.contentView addSubview:_stocklable];
        
        [_okbtn removeFromSuperview];
        _okbtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        
        
        _okbtn.frame = CGRectMake(kZoom6pt(10), CGRectGetMaxY(_stepperView.frame)+ZOOM6(50), kScreenWidth-kZoom6pt(20), ZOOM6(88));
        _okbtn.titleLabel.font = [UIFont systemFontOfSize:ZOOM6(36)];
//        _okbtn.backgroundColor = tarbarrossred;
        _okbtn.layer.cornerRadius = 5;
        [_okbtn setTintColor:[UIColor whiteColor]];
        [_okbtn setTitle:@"确定" forState:UIControlStateNormal];
        [_okbtn addTarget:self action:@selector(okClick:) forControlEvents:UIControlEventTouchUpInside];
        _okbtn.backgroundColor = model.stock>0?tarbarrossred:RGBCOLOR_I(197, 197, 197);
        [self.contentView addSubview:_okbtn];
    }
    [self isNoSelect];
}

- (void)receiveSpecialDataModel:(DPShopModel *)model MiniShare:(BOOL)shareSuccess;
{
    self.isSpecialShop = YES;
    self.dpModel = model;
    _stepperView.value = model.shopNumber;
    _stepperView.minimumValue = 1;
    _stepperView.maximumValue = model.stock>2?2:model.stock;
    
    if(model.isFight || shareSuccess)
    {
        _stepperView.maximumValue = 1;
    }
    _stepperView.stepValue = 1;
    _colorIndex = model.colorIndex;
    _sizeIndex = model.sizeIndex;
    _otherIndex = model.otherIndex;
    
    _titleLabel.text = model.shop_name;
    _priceLabel.hidden = model.price.floatValue < 0;
    _priceLabel.text = [NSString stringWithFormat:@"¥%.1f",[model.price floatValue]];
    
    NSString *supcode  = [model.shop_code substringWithRange:NSMakeRange(1, 3)];
    NSString *url = [NSString stringWithFormat:@"%@%@/%@/%@",[NSObject baseURLStr_Upy],supcode,model.shop_code,model.pic];
    NSURL *imgUrl = [NSURL URLWithString:url];
    
    [_imgView sd_setImageWithURL:imgUrl placeholderImage:DefaultImg(_imgView.bounds.size)];
    _selectBtn.userInteractionEnabled = model.stock > 0;
    _selectBtn.selected = model.stock > 0?model.isSelect:NO;
    [_colorView removeFromSuperview];
    [_sizeView removeFromSuperview];
    [_otherView removeFromSuperview];
    

    _colorView = nil;
    _sizeView = nil;
    _otherView = nil;
    
    _sTag = model.colors.count + 2000;
    _oTag = model.colors.count + 3000;
    _colors = model.colors;
    
    if (model.colors.count) {
        _colorView = [self listViewWithTitle:model.colorTitle data:model.colors tag:2000];
        _colorView.frame = CGRectMake(kZoom6pt(10), kZoom6pt(105), CGRectGetWidth(_colorView.bounds), CGRectGetHeight(_colorView.bounds));
        [self.contentView addSubview:_colorView];
    }
    
    if (model.sizes.count) {
        CGFloat top = (_colorView == nil)?kZoom6pt(105):kZoom6pt(130)+CGRectGetHeight(_colorView.bounds);
        _sizeView = [self listViewWithTitle:model.sizeTitle data:model.sizes tag:_sTag];
        _sizeView.frame = CGRectMake(kZoom6pt(10), top, CGRectGetWidth(_sizeView.bounds), CGRectGetHeight(_sizeView.bounds));
        [self.contentView addSubview:_sizeView];
    }
    
    if (model.others.count) {
        CGFloat top = (_sizeView == nil)?kZoom6pt(105):kZoom6pt(130)+CGRectGetHeight(_sizeView.bounds);
        _otherView = [self listViewWithTitle:model.otherTitle data:model.others tag:_oTag];
        _otherView.frame = CGRectMake(kZoom6pt(10), top, CGRectGetWidth(_otherView.bounds), CGRectGetHeight(_otherView.bounds));
        [self.contentView addSubview:_otherView];
    }
    
    if(model.colors.count || model.sizes.count || model.others.count)//新增
    {
        CGFloat textHeight = [NSString heightWithString:@"数量" font:[UIFont systemFontOfSize:kZoom6pt(14)] constrainedToWidth:100];
        [_nameLabel removeFromSuperview];
        _nameLabel = [self labelWithColor:[UIColor colorWithWhite:62/255. alpha:1] FontSize:kZoom6pt(14)];
        _nameLabel.text = @"数量";
        if(model.others.count)
        {
            _nameLabel.frame = CGRectMake(kZoom6pt(10), CGRectGetMaxY(_otherView.frame)+ZOOM6(50), kScreenWidth - kZoom6pt(20), textHeight);
        }else if(model.sizes.count){
            _nameLabel.frame = CGRectMake(kZoom6pt(10), CGRectGetMaxY(_sizeView.frame)+ZOOM6(50), kScreenWidth - kZoom6pt(20), textHeight);
        }else{
            _nameLabel.frame = CGRectMake(kZoom6pt(10), CGRectGetMaxY(_colorView.frame)+ZOOM6(50), kScreenWidth - kZoom6pt(20), textHeight);
        }
        
        [self.contentView addSubview:_nameLabel];
        
        _stepperView.frame = CGRectMake(kZoom6pt(10), CGRectGetMaxY(_nameLabel.frame)+ZOOM6(20), kZoom6pt(100), kZoom6pt(25));
        
        [_stocklable removeFromSuperview];
        _stocklable = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_stepperView.frame)+ZOOM6(20), CGRectGetMinY(_stepperView.frame), ZOOM6(200), CGRectGetHeight(_stepperView.frame))];
        _stocklable.text = [NSString stringWithFormat:@"库存%d件",(int)model.stock];
        _stocklable.font = [UIFont systemFontOfSize:ZOOM6(22)];
        _stocklable.textColor = RGBCOLOR_I(125, 125, 125);
        [self.contentView addSubview:_stocklable];
        
        [_okbtn removeFromSuperview];
        _okbtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        
        CGFloat okbtnY = CGRectGetMaxY(_stepperView.frame);
        _okbtn.frame = CGRectMake(kZoom6pt(10), okbtnY<ZOOM6(680)?ZOOM6(680):okbtnY+ZOOM6(50), kScreenWidth-kZoom6pt(20), ZOOM6(88));
        _okbtn.titleLabel.font = [UIFont systemFontOfSize:ZOOM6(36)];
        //        _okbtn.backgroundColor = tarbarrossred;
        _okbtn.layer.cornerRadius = 5;
        [_okbtn setTintColor:[UIColor whiteColor]];
        [_okbtn setTitle:@"确定" forState:UIControlStateNormal];
        [_okbtn addTarget:self action:@selector(okClick:) forControlEvents:UIControlEventTouchUpInside];
        _okbtn.backgroundColor = model.stock>0?tarbarrossred:RGBCOLOR_I(197, 197, 197);
        [self.contentView addSubview:_okbtn];
    }
    [self isNoSelect];
}

#pragma mark - 创建视图公共方法
/// 创建颜色或尺码
- (UIView *)listViewWithTitle:(NSString *)title data:(NSArray *)data tag:(NSInteger)tag{
    [ChangShopTableViewCell widthAndFrameWithArray:data];
    
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
        
        //设置初始选中的颜色尺码
       
        for(int i =0; i <self.dpModel.colors.count;i++)
        {
            if([self.dpModel.selectcolor isEqualToString:[self.dpModel.colors[i] objectForKey:@"name"]])
            {
                _colorIndex = i;
                break;
            }
        }
        
        for(int i =0; i <self.dpModel.sizes.count;i++)
        {
            if([self.dpModel.selectsize isEqualToString:[self.dpModel.sizes[i] objectForKey:@"name"]])
            {
                _sizeIndex = i;
                break;
            }
        }
        
        for(int i =0; i <self.dpModel.others.count;i++)
        {
            if([self.dpModel.selectsize isEqualToString:[self.dpModel.others[i] objectForKey:@"name"]])
            {
                _otherIndex = i;
                break;
            }
        }
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
    CGFloat height = kZoom6pt(255);
    if (model.colors.count) {
        height += [self widthAndFrameWithArray:model.colors] + kZoom6pt(10);
    }
    
    if (model.sizes.count) {
        CGFloat top = model.colors.count?kZoom6pt(15):kZoom6pt(10);
        height += [self widthAndFrameWithArray:model.sizes] + top;
    }
    
    if (model.others.count) {
        CGFloat top = model.others.count?kZoom6pt(15):kZoom6pt(10);
        height += [self widthAndFrameWithArray:model.others] + top;
    }
    
    return (height + kZoom6pt(10))<ZOOM6(780)?ZOOM6(800):(height + kZoom6pt(10));
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


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
}

@end
