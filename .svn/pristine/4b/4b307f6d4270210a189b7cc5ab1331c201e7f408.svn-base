//
//  YFDPImageView.h
//  YunShangShiJi
//
//  Created by zgl on 16/6/16.
//  Copyright © 2016年 ios-1. All rights reserved.
//  搭配大图

#import <UIKit/UIKit.h>
#import "YFTagButton.h"
#import "HBTagButton.h"
typedef NS_ENUM(NSInteger, YFDPImageViewType) {
    YFDPImageViewType_Nomal = 0, // 正常
    YFDPImageViewType_Topics     // 专题
};

@class YFDPImageView;

@protocol YFDPImageViewDelegate <NSObject>
///标签数量
- (NSInteger)numberOfTag;
///当前标签及所在索引（给标签赋值）
- (void)tagBtn:(YFTagButton *)tagBtn tagForRowAtindex:(NSInteger)index;
- (void)tagButton:(HBTagButton *)tagBtn tagForRowAtindex:(NSInteger)index;
///点击标签
- (void)imageView:(YFDPImageView *)imageView didSelectRowAtIndex:(NSInteger)index;

@end


@interface YFDPImageView : UIImageView
@property (nonatomic, assign) YFDPImageViewType imageViewType; // 类型
@property (nonatomic, strong) UILabel *mainTitleLabel; // 主标题
@property (nonatomic, strong) UILabel *subTitleLabel;// 副标题
@property (nonatomic, strong) UILabel *titleLabel; //标题
@property (nonatomic, assign) BOOL isTriangle;
@property (nonatomic, assign) BOOL isShade;
@property (nonatomic, assign) BOOL isTitle;
@property (nonatomic, assign) BOOL isTopics;
@property (nonatomic, assign) BOOL isMainTitle;
@property (nonatomic, assign) BOOL isSubTitle;
@property (nonatomic, weak) id <YFDPImageViewDelegate> delegate;
///初始化：isTriangle是否显示小三角
// 遮罩层


/**
 普通搭配

 @param frame <#frame description#>
 @param isTriangle 三角
 @param isShade 阴影
 @param isTitle 下标题
 @return <#return value description#>
 */
- (instancetype)initWithFrame:(CGRect)frame isTriangle:(BOOL)isTriangle isShade:(BOOL)isShade isTitle:(BOOL)isTitle;

/**
 专题

 @param frame <#frame description#>
 @param isTriangle 三角
 @param isShade 阴影
 @param isTopics 专题标示
 @return <#return value description#>
 */
- (instancetype)initWithFrame:(CGRect)frame isTriangle:(BOOL)isTriangle isShade:(BOOL)isShade isTopics:(BOOL)isTopics;

///刷新
- (void)reloadData;
- (void)reloadDataTagData;
///生成分享图片
+ (UIImage *)dpImageWidthImage:(UIImage *)image datas:(NSArray<NSDictionary *> *)datas;
@end
