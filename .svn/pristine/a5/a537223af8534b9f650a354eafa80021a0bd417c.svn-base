//
//  GroupBuysCell.m
//  YunShangShiJi
//
//  Created by jingaiweiyi on 2016/11/25.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import "GroupBuysCell.h"
#import "UITapImageView.h"
@interface GroupBuysCell ()
@property (nonatomic, strong) UITapImageView *shopImageV;
@property (nonatomic, strong) UILabel *shopNameL;
@property (nonatomic, strong) UILabel *shopPriceL;
@property (nonatomic, strong) UILabel *shopOldPriceL;
@property (nonatomic, strong) UIButton *shopBuyBtn;
@property (nonatomic, strong) UIImageView *userImageV;
@property (nonatomic, strong) UILabel *userNameL;

@property (nonatomic, strong) TFGroupBuyShop *model;
@end

@implementation GroupBuysCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    [self.contentView addSubview:self.shopImageV];
    [self.contentView addSubview:self.shopNameL];
    [self.contentView addSubview:self.shopPriceL];
    [self.contentView addSubview:self.shopOldPriceL];
    [self.contentView addSubview:self.shopBuyBtn];
    [self.contentView addSubview:self.userImageV];
    [self.contentView addSubview:self.userNameL];
    
    [self layoutUI];
}

- (void)layoutUI {
    
    CGFloat LMargin = ZOOM6(20);
    [self.shopImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(ZOOM6(240));
        make.height.mas_equalTo(ZOOM6(240 * 3 / 2));
        make.left.equalTo(self.contentView.mas_left).offset(LMargin);
        make.top.equalTo(self.contentView.mas_top).offset(LMargin);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-LMargin);
    }];
    
    [self.userImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.shopImageV.mas_top);
        make.left.equalTo(self.shopImageV.mas_right).offset(LMargin);
        make.size.mas_equalTo(CGSizeMake(ZOOM6(70), ZOOM6(70)));
    }];
    
    [self.userNameL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.userImageV);
        make.left.equalTo(self.userImageV.mas_right).offset(ZOOM6(10));
        make.height.equalTo(self.userImageV);
    }];
    
    [self.shopNameL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.left.equalTo(self.userImageV.mas_left);
        make.right.equalTo(self.contentView.mas_right).offset(-LMargin);
        make.height.mas_equalTo(ZOOM6(50));
    }];
    
    [self.shopBuyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.shopImageV.mas_bottom);
        make.right.equalTo(self.contentView.mas_right).offset(-LMargin);
        make.width.mas_equalTo(ZOOM6(200));
        make.height.mas_equalTo(ZOOM6(80));
    }];
    
    UILabel *label = [UILabel new];
    label.textColor = RGBCOLOR_I(168, 168, 168);
    label.font = kFont6px(24);
    [self.contentView addSubview:label];
    NSString *text = @"单独购买";
    label.text = text;
    
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.shopImageV.mas_bottom);
        make.height.mas_equalTo(ZOOM6(30));
//        make.width.mas_equalTo([text getWidthWithFont:kFont6px(24) constrainedToSize:CGSizeMake(100, ZOOM6(30))]);
        make.left.equalTo(self.userImageV.mas_left);
        make.right.equalTo(self.shopOldPriceL.mas_left);
    }];
    
    [self.shopOldPriceL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(label.mas_centerY);
        make.height.equalTo(label.mas_height);

    }];
    UIView *lineV = [UIView new];
    lineV.backgroundColor = RGBCOLOR_I(220, 220, 220);
    [self.shopOldPriceL addSubview:lineV];
    [lineV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(1);
        make.left.right.equalTo(self.shopOldPriceL);
        make.centerY.equalTo(self.shopOldPriceL.mas_centerY);
    }];
    
    [self.shopPriceL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.shopOldPriceL.mas_top).offset(ZOOM6(12));
        make.top.equalTo(self.shopBuyBtn.mas_top);
        make.left.equalTo(self.userImageV.mas_left);
        make.right.equalTo(self.shopBuyBtn.mas_left);
    }];
}


#pragma mark - 懒加载
- (UIButton *)shopBuyBtn
{
    if (!_shopBuyBtn) {
        
        _shopBuyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_shopBuyBtn setBackgroundImage:[UIImage imageWithColor:COLOR_ROSERED] forState:UIControlStateNormal];
        [_shopBuyBtn setBackgroundImage:[UIImage imageWithColor:RGBCOLOR_I(195, 195, 195)] forState:UIControlStateHighlighted];
        
        NSString *text = @"立即参团";
        UIImage *image = [UIImage imageNamed:@"groupBuy_icon_go_white"];
        
        [_shopBuyBtn setTitle:text forState:UIControlStateNormal];
        _shopBuyBtn.layer.masksToBounds = YES;
        _shopBuyBtn.layer.cornerRadius = ZOOM6(8);
        [_shopBuyBtn setImage:image forState:UIControlStateNormal];
        _shopBuyBtn.titleLabel.font = kFont6px(30);
        
        CGFloat textWidth = [text getWidthWithFont:kFont6px(30) constrainedToSize:CGSizeMake(100, 100)];
        CGFloat imageWidth = _shopBuyBtn.imageView.bounds.size.width;
        
        [_shopBuyBtn setImageEdgeInsets:UIEdgeInsetsMake(0, textWidth + 8, 0, -textWidth)];
        [_shopBuyBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, -imageWidth - textWidth + 18, 0, imageWidth)];
        
        kWeakSelf(self);
        [_shopBuyBtn handleClickEvent:UIControlEventTouchUpInside withClickBlock:^(UIButton *sender) {
            [weakself userBtnClicked];
        }];
    }
    return _shopBuyBtn;
}

- (UILabel *)userNameL
{
    if (!_userNameL) {
        _userNameL = [UILabel new];
        _userNameL.textColor = RGBCOLOR_I(125, 125, 125);
        _userNameL.font = kFont6px(28);
        
        _userNameL.text = @"";
    }
    return _userNameL;
}
- (UIImageView *)userImageV
{
    if (!_userImageV) {
        _userImageV = [UIImageView new];
        _userImageV.layer.cornerRadius = ZOOM6(70) * 0.5;
        _userImageV.layer.masksToBounds = YES;
        
    }
    return _userImageV;
}

- (UILabel *)shopOldPriceL
{
    if (!_shopOldPriceL) {
        _shopOldPriceL = [UILabel new];
        _shopOldPriceL.textColor = RGBCOLOR_I(168, 168, 168);
        _shopOldPriceL.font = kFont6px(24);
        
        _shopOldPriceL.text = @"¥0.0";
        
    }
    return _shopOldPriceL;
}
- (UITapImageView *)shopImageV
{
    if (!_shopImageV) {
        _shopImageV = [UITapImageView new];
    }
    return _shopImageV;
}

- (UILabel *)shopPriceL
{
    if (!_shopPriceL) {
        _shopPriceL = [UILabel new];
        _shopPriceL.textColor = COLOR_ROSERED;
        _shopPriceL.font = kFont6px(28);
        
        _shopPriceL.text = @"¥0.0";
        
    }
    return _shopPriceL;
}


- (UILabel *)shopNameL
{
    if (!_shopNameL) {
        _shopNameL = [UILabel new];
        _shopNameL.font = kFont6px(28);
        _shopNameL.textColor = RGBCOLOR_I(62, 62, 62);
        _shopNameL.numberOfLines = 1;
        
        _shopNameL.text = @"";
    }
    return _shopNameL;
}

#pragma mark - 数据
- (void)setData:(TFGroupBuyShop *)model
{
    self.model = model;
    [self setShopPriceText:[NSString stringWithFormat:@"%@", model.shop_roll]];
    [self setUserNameText:model.user_name];
    self.shopOldPriceL.text = [NSString stringWithFormat:@"¥%.1f", [model.shop_original doubleValue]];
    kWeakSelf(self);
    [self.shopImageV setImageWithUrl:[self setShopImage:model] placeholderImage:[UIImage imageDefaultWithSize:CGSizeMake(ZOOM6(240), ZOOM6(240))] tapBlock:^(id obj) {
        [weakself userBtnClicked];
    }];
    
    [self.userImageV setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", [NSObject baseURLStr_Upy], model.user_portrait]] placeholderImage:nil progress:nil completed:nil];
//    MyLog(@"userImage: %@", [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", [NSObject baseURLStr_Upy], model.user_portrait]]);
    self.shopNameL.text = [self setshopName:model.shop_name];
    
}

- (void)userBtnClicked
{
    if (self.block) {
        self.block(self.model, self.indexPath);
    }
}

- (NSString *)setshopName:(NSString *)text
{
    NSArray *textArray = [text componentsSeparatedByString:@"】"];
    if (textArray.count == 1) {
        return text;
    }
    NSString *textTemp;
    if (textArray.count == 2) {
        textTemp = [NSString stringWithFormat:@"%@%@】", textArray[1], textArray[0]];
    }
    return textTemp;
}

- (void)setShopPriceText:(NSString *)priceText
{
    double price = [priceText doubleValue];
    NSString *text = [NSString stringWithFormat:@"拼团价¥%.1f", price];
    
    NSMutableAttributedString *string = [NSString attributedSourceString:text targetString:[NSString stringWithFormat:@"¥%.1f", price] addAttributes:@{ NSFontAttributeName:[UIFont boldSystemFontOfSize:ZOOM6(36)]}];
    self.shopPriceL.attributedText = string;
    
}

- (NSURL *)setShopImage:(TFGroupBuyShop *)model
{
    NSMutableString *code = [NSMutableString stringWithString:[NSString stringWithFormat:@"%@",model.shop_code]];
    NSString *supCode  = [code substringWithRange:NSMakeRange(1, 3)];
    NSString *imageString = [NSString stringWithFormat:@"%@/%@/%@",supCode,model.shop_code,model.shop_url];

    NSString *imageSize;
    if (kDevice_Is_iPhone6Plus) {
        imageSize = @"!382";
    } else {
        imageSize = @"!280";
    }
    
    //!280
    NSURL *imageUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@",[NSObject baseURLStr_Upy],imageString,imageSize]];
    return imageUrl;
}

- (void)setUserNameText:(NSString *)nameText
{
    NSString *text = nameText;
    if (nameText.length > 1) {
        text = [NSString stringWithFormat:@"%@***%@", [nameText substringToIndex:1], [nameText substringFromIndex:nameText.length-1]];
    }
    self.userNameL.text = text;
}

- (CGFloat)cellHeight
{
    [self layoutIfNeeded];
    [self updateConstraintsIfNeeded];
    
    CGFloat height = [self.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    
    return height;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
