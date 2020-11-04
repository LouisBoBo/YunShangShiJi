//
//  TagsCell.m
//  YunShangShiJi
//
//  Created by jingaiweiyi on 2017/2/16.
//  Copyright © 2017年 ios-1. All rights reserved.
//

#import "TagsCell.h"
#import "IntimateCircleModel.h"
#import "GlobalTool.h"
#define KICTagsFont kFont6px(25)
@implementation TagsCell
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setText:(NSString *)text withSelected:(BOOL)isSelected selectedBackgroundColor:(UIColor *)selectedColor selectedTextColor:(UIColor *)selectedTextColor {
    if (!self.textLabel) {
        self.textLabel = [[UILabel alloc] initWithFrame:CGRectMake(kICTagsCellLeftRight_Width, 0, [TagsCell cellSizeWithObj:text].width - 2*kICTagsCellLeftRight_Width, ZOOM6(56))];
        self.textLabel.textAlignment = NSTextAlignmentCenter;
        self.textLabel.font = KICTagsFont;
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius=3;
        [self.contentView addSubview:self.textLabel];
    }
    self.textLabel.frame = CGRectMake(kICTagsCellLeftRight_Width, 0, [TagsCell cellSizeWithObj:text].width - 2*kICTagsCellLeftRight_Width, ZOOM6(56));
    self.textLabel.text = text;
    if (isSelected) {
        self.textLabel.textColor = selectedTextColor;
        self.contentView.backgroundColor = selectedColor;
    } else {
        self.textLabel.textColor = kTextColor;
        self.contentView.backgroundColor = RGBCOLOR_I(240, 240, 240);
    }
}
- (void)setText:(NSString *)text withSelected:(BOOL)isSelected selectedBackgroundColor:(UIColor *)selectedColor selectedTextColor:(UIColor *)selectedTextColor BackgroundColor:(UIColor *)backgroundColor TextColor:(UIColor *)TextColor {
    if (!self.textLabel) {
        self.textLabel = [[UILabel alloc] initWithFrame:CGRectMake(kICTagsCellLeftRight_Width, 0, [TagsCell cellSizeWithObj:text].width - 2*kICTagsCellLeftRight_Width, ZOOM6(56))];
        self.textLabel.textAlignment = NSTextAlignmentCenter;
        self.textLabel.font = KICTagsFont;
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius=3;
        [self.contentView addSubview:self.textLabel];
    }
    self.textLabel.frame = CGRectMake(kICTagsCellLeftRight_Width, 0, [TagsCell cellSizeWithObj:text].width - 2*kICTagsCellLeftRight_Width, ZOOM6(56));
    self.textLabel.text = text;
    if (isSelected) {
        self.textLabel.textColor = selectedTextColor;
        self.contentView.backgroundColor = selectedColor;
    } else {
        self.textLabel.textColor = kTextColor;
        self.contentView.backgroundColor = [UIColor whiteColor];
    }
}

- (void)setText:(NSString *)text withSelected:(BOOL)isSelected {
    [self setText:text withSelected:isSelected selectedBackgroundColor:RGBCOLOR_I(251, 229, 238) selectedTextColor:COLOR_ROSERED];
}

- (void)setTextWithTags:(NSString *)text selected:(BOOL)isSelected {
    [self setText:text withSelected:isSelected selectedBackgroundColor:RGBCOLOR_I(238, 101, 118) selectedTextColor:[UIColor whiteColor]];
}


+(CGSize)cellSizeWithObj:(NSString *)text {
    CGSize itemSize = CGSizeZero;
    if ([text isKindOfClass:[NSString class]]) {
        CGFloat width = [text getWidthWithFont:KICTagsFont constrainedToSize:CGSizeMake(MAXFLOAT, ZOOM6(56))];
        itemSize = CGSizeMake(width + 2 * kICTagsCellLeftRight_Width, ZOOM6(56));
        
    }
    return itemSize;
}
@end
