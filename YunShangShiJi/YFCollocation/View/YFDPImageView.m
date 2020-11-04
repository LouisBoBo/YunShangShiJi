//
//  YFDPImageView.m
//  YunShangShiJi
//
//  Created by zgl on 16/6/16.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import "YFDPImageView.h"
#import "YFTriangleView.h"
#import "GlobalTool.h"

#define scax 1

@interface YFDPImageView ()

@property (nonatomic, strong) UIImageView *shadeImageV;
@property (nonatomic, strong) UIImageView *topicsImageV;
@property (nonatomic, strong) YFTriangleView *triangleV;
@end

@implementation YFDPImageView {
    UIButton *clothesBtn;
    UIButton *pantsBtn;
    YFTagsView *tagLView;
    YFTagsView *tagRView;
    NSMutableArray *tags;
}

// 全能初始化方法.
- (instancetype)initWithFrame:(CGRect)frame imageViewType:(YFDPImageViewType)imageViewType isTriangle:(BOOL)isTriangle isShade:(BOOL)isShade isTitle:(BOOL)isTitle isTopics:(BOOL)isTopics isMainTitle:(BOOL)isMainTitle isSubTitle:(BOOL)isSubTitle {
    if (self = [super initWithFrame:frame]) {
        if (isShade) {
            _isShade = isShade;
            [self addSubview:self.shadeImageV];
        }
        if (isTriangle) {
            _isTriangle = isTriangle;
            [self addSubview:self.triangleV];
        }
        
        if (isTitle) {
            _isTitle = isTitle;
            //标题
            [self addSubview:self.titleLabel];
        }
        
        if (isTopics) {
            _isTopics = isTopics;
            [self addSubview:self.topicsImageV];
        }
        
        if (isMainTitle) {
            _isMainTitle = isMainTitle;
            [self addSubview:self.mainTitleLabel];
        }
        
        if (isSubTitle) {
            _isSubTitle = isSubTitle;
            [self addSubview:self.subTitleLabel];
        }
        
        tags = [NSMutableArray array];
        _imageViewType = imageViewType;
        
        self.userInteractionEnabled = YES;
        
    }
    return self;
}

// 正常的专题商品
- (instancetype)initWithFrame:(CGRect)frame isTriangle:(BOOL)isTriangle isShade:(BOOL)isShade isTopics:(BOOL)isTopics
{
    return [self initWithFrame:frame imageViewType:YFDPImageViewType_Topics isTriangle:isTriangle isShade:isShade isTitle:NO isTopics:isTopics isMainTitle:YES isSubTitle:YES];
}

// 正常的搭配商品
- (instancetype)initWithFrame:(CGRect)frame isTriangle:(BOOL)isTriangle isShade:(BOOL)isShade isTitle:(BOOL)isTitle
{
    return [self initWithFrame:frame imageViewType:YFDPImageViewType_Nomal isTriangle:isTriangle isShade:isShade isTitle:isTitle isTopics:NO isMainTitle:NO isSubTitle:NO];
}

- (void)reloadData {
    if (self.delegate) {
        //标签数量
        NSInteger number = 0;
        if ([self.delegate respondsToSelector:@selector(numberOfTag)]) {
            number = [self.delegate numberOfTag];
        }
        //创建标签
        [tags makeObjectsPerformSelector:@selector(removeFromSuperview)];
        
        if ([self.delegate respondsToSelector:@selector(tagBtn:tagForRowAtindex:)]) {
            for (int index = 0; index < number; index++) {
                YFTagButton *tagBtn = nil;
                if (index < tags.count) {
                    tagBtn = [tags objectAtIndex:index];
                } else {
                    tagBtn = [YFTagButton buttonWithType:YFTagsViewTypeLeft maxWidth:self.width];
                    [tagBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
                    [tags addObject:tagBtn];
                }
                [self.delegate tagBtn:tagBtn tagForRowAtindex:index];
                [self addSubview:tagBtn];
            }
        }
    }
}
- (void)reloadDataTagData
{
    if (self.delegate) {
        //标签数量
        NSInteger number = 0;
        if ([self.delegate respondsToSelector:@selector(numberOfTag)]) {
            number = [self.delegate numberOfTag];
        }
        //创建标签
        [tags makeObjectsPerformSelector:@selector(removeFromSuperview)];
        
        if ([self.delegate respondsToSelector:@selector(tagButton:tagForRowAtindex:)]) {
            for (int index = 0; index < number; index++) {
                HBTagButton *tagBtn = nil;
                if (index < tags.count) {
                    tagBtn = [tags objectAtIndex:index];
                } else {
                    tagBtn = [HBTagButton buttonWithType:YFTagsViewTypeLeft maxWidth:self.width];
                    [tagBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
                    [tags addObject:tagBtn];
                }
                [self.delegate tagButton:tagBtn tagForRowAtindex:index];
                [self addSubview:tagBtn];
            }
        }
    }

}
- (void)btnClick:(UIButton *)sender {
    //标签点击
    if ([self.delegate respondsToSelector:@selector(imageView:didSelectRowAtIndex:)]) {
        NSInteger index = [tags indexOfObject:sender];
        [self.delegate imageView:self didSelectRowAtIndex:index];
    }
}

#pragma mark - setter 方法
- (void)setIsShade:(BOOL)isShade
{
    _isShade = isShade;
    if (isShade) {
        [self addSubview:self.shadeImageV];
        self.shadeImageV.frame = CGRectMake(0, self.frame.size.height - kZoom6pt(82), self.frame.size.width, kZoom6pt(82));
    } else {
        [self.shadeImageV removeFromSuperview];
    }
    
}

- (void)setIsTitle:(BOOL)isTitle
{
    _isTitle = isTitle;
    if (isTitle) {
        [self addSubview:self.titleLabel];
        [self.titleLabel setY:self.frame.size.height - kZoom6pt(32)];
    } else {
        [self.titleLabel removeFromSuperview];
    }
    
}

- (void)setIsTriangle:(BOOL)isTriangle
{
    _isTriangle = isTriangle;
    if (isTriangle) {
        [self addSubview:self.triangleV];
        self.triangleV.frame = CGRectMake((self.frame.size.width - kZoom6pt(20))/2,
                                          self.frame.size.height - kZoom6pt(10), kZoom6pt(20), kZoom6pt(10));
    } else {
        [self.triangleV removeFromSuperview];
    }
    
}

- (void)setIsTopics:(BOOL)isTopics
{
    _isTopics = isTopics;
    if (isTopics) {
        [self addSubview:self.topicsImageV];
    } else {
        [self.topicsImageV removeFromSuperview];
    }
}

- (void)setIsMainTitle:(BOOL)isMainTitle
{
    _isMainTitle = isMainTitle;
    if (isMainTitle) {
        [self addSubview:self.mainTitleLabel];
        self.mainTitleLabel.frame = CGRectMake(0, self.height * 0.5 - ZOOM6(10) - ZOOM6(50), self.width, ZOOM6(50));
    } else {
        [self.mainTitleLabel removeFromSuperview];
    }
    
}

- (void)setIsSubTitle:(BOOL)isSubTitle
{
    _isSubTitle = isSubTitle;
    if (isSubTitle) {
        [self addSubview:self.subTitleLabel];
        self.subTitleLabel.frame = CGRectMake(0, self.height * 0.5 + ZOOM6(10), self.width, ZOOM6(35));
    } else {
        [self.subTitleLabel removeFromSuperview
         ];
    }
}

- (void)setImageViewType:(YFDPImageViewType)imageViewType
{
    _imageViewType = imageViewType;
    if (imageViewType == YFDPImageViewType_Topics) {
        self.isMainTitle = YES;
        self.isSubTitle = YES;
        for (UIView *view in self.subviews) {
            if ([view isKindOfClass:[YFTagButton class]]) {
                [view removeFromSuperview];
            }
            if ([view isKindOfClass:[HBTagButton class]]) {
                [view removeFromSuperview];
            }
        }
    } else {
        self.isMainTitle = NO;
        self.isSubTitle = NO;
    }
}

- (UIImageView *)shadeImageV
{
    if (!_shadeImageV) {
        // 阴影
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.frame.size.height - kZoom6pt(82), self.frame.size.width, kZoom6pt(82))];
        imageView.image = [UIImage imageNamed:@"zhezhao_dp"];
        _shadeImageV = imageView;
    }
    return _shadeImageV;
}

- (YFTriangleView *)triangleV
{
    if (!_triangleV) {
        YFTriangleView *view = [[YFTriangleView alloc] initWithFrame:CGRectMake((self.frame.size.width - kZoom6pt(20))/2,
                                                                                self.frame.size.height - kZoom6pt(10), kZoom6pt(20), kZoom6pt(10))];
        view.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin;
        _triangleV = view;
    }
    return _triangleV;
}

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(kZoom6pt(10), self.frame.size.height - kZoom6pt(32), self.frame.size.width - kZoom6pt(20), kZoom6pt(17))];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.font = [UIFont boldSystemFontOfSize:kZoom6pt(15)];
        _titleLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    }
    return _titleLabel;
}

- (UIImageView *)topicsImageV
{
    if (!_topicsImageV) {
        UIImageView *topImageV = [[UIImageView alloc] init];
        UIImage *image = [UIImage imageNamed:@"Collocation_zt_label"];
        topImageV.image = image;
        CGFloat width = ZOOM6(75);
        CGFloat height = [UIImage imageConvertHeightWithImage:image fromWidth:width];
        topImageV.frame = CGRectMake(ZOOM6(35), 0, width, height);
        
        _topicsImageV = topImageV;
    }
    return _topicsImageV;
}

- (UILabel *)mainTitleLabel
{
    if (!_mainTitleLabel) {
        UILabel *mainTitleL = [[UILabel alloc] initWithFrame:CGRectMake(0, self.height * 0.5 - ZOOM6(10) - ZOOM6(50), self.width, ZOOM6(50))];
        mainTitleL.textColor = RGBCOLOR_I(255, 255, 255);
        mainTitleL.font = [UIFont boldSystemFontOfSize:ZOOM6(42)];
        mainTitleL.text = @"";
        mainTitleL.textAlignment = NSTextAlignmentCenter;
        _mainTitleLabel = mainTitleL;
    }
    return _mainTitleLabel;
}

- (UILabel *)subTitleLabel
{
    if (!_subTitleLabel) {
        UILabel *subTitleL = [[UILabel alloc] initWithFrame:CGRectMake(0, self.height * 0.5 + ZOOM6(10), self.width, ZOOM6(35))];
        subTitleL.textColor = RGBCOLOR_I(255, 255, 255);
        subTitleL.font = [UIFont systemFontOfSize:ZOOM6(30)];
        subTitleL.text = @"";
        subTitleL.textAlignment = NSTextAlignmentCenter;
        _subTitleLabel = subTitleL;
    }
    return _subTitleLabel;
    
}



+ (UIImage *)dpImageWidthImage:(UIImage *)image datas:(NSArray <NSDictionary *> *)datas {
    CGSize size = image.size;
    YFDPImageView *imageView = [[YFDPImageView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height) isTriangle:NO isShade:NO isTitle:NO];
    imageView.image = image;
    for (int index = 0; index < datas.count; index++) {
        YFTagButton *tagBtn = nil;
        tagBtn = [YFTagButton buttonWithType:YFTagsViewTypeLeft maxWidth:size.width];
        NSDictionary *dic = datas[index];
//        CGFloat price = [dic[@"shop_se_price"] floatValue] - [dic[@"kickback"] intValue];
        CGFloat price = [dic[@"shop_se_price"] floatValue];
        [tagBtn setTitle:dic[@"shop_name"]
                   price:[NSString stringWithFormat:@"¥%.1f",price]
                  origin:CGPointMake([dic[@"shop_x"] floatValue],[dic[@"shop_y"] floatValue])
                   isImg:NO
                   ispic:NO
                    type:index%2];
        [imageView addSubview:tagBtn];
    }
    UIGraphicsBeginImageContext(size);
    [imageView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    return newImage;
}

@end
