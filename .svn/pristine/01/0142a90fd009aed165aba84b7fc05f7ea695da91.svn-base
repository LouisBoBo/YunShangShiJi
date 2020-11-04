//
//  TagsCell.h
//  YunShangShiJi
//
//  Created by jingaiweiyi on 2017/2/16.
//  Copyright © 2017年 ios-1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GlobalTool.h"
#define kICTagsCellLeftRight_Width ZOOM6(15)
#define kICCellIdentifier_TagsCell @"TagsCell"
@interface TagsCell : UICollectionViewCell
@property (nonatomic, strong) UILabel *textLabel;
- (void)setText:(NSString *)text withSelected:(BOOL)isSelected;
- (void)setTextWithTags:(NSString *)text selected:(BOOL)isSelected;
- (void)setText:(NSString *)text withSelected:(BOOL)isSelected selectedBackgroundColor:(UIColor *)selectedColor selectedTextColor:(UIColor *)selectedTextColor;
- (void)setText:(NSString *)text withSelected:(BOOL)isSelected selectedBackgroundColor:(UIColor *)selectedColor selectedTextColor:(UIColor *)selectedTextColor BackgroundColor:(UIColor *)backgroundColor TextColor:(UIColor *)TextColor;
+(CGSize)cellSizeWithObj:(NSString *)text;
@end
