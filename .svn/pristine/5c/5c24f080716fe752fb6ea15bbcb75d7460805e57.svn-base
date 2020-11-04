//
//  YFTagsView.h
//  YunShangShiJi
//
//  Created by zgl on 16/6/18.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, YFTagsViewType) {
    YFTagsViewTypeLeft = 0, //左侧
    YFTagsViewTypeRight = 1 //右侧
};

@interface YFTagsView : UIView

@property (nonatomic, copy) NSString *title;    //标题
@property (nonatomic, strong) UIImage *ico;     //图标
@property (nonatomic, assign) BOOL isImage;     //是否显示图标
@property (nonatomic, assign) BOOL isHighlight;     //是否高亮图标
@property (nonatomic, assign) CGFloat minWidth; //最小宽度
@property (nonatomic, assign) CGFloat maxWidth; //最大宽度
@property (nonatomic, assign) YFTagsViewType type;
/*
 * 创建方法：
 * frame位置大小（YFTagsViewTypeLeft：右侧固定，宽度随变化。YFTagsViewTypeRight：相反）
 * type:类型
 */
- (instancetype)initWithFrame:(CGRect)frame Type:(YFTagsViewType)type;

@end
