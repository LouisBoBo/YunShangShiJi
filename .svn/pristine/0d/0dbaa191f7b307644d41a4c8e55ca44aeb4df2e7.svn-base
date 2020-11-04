//
//  YFTagButton.m
//  YunShangShiJi
//
//  Created by zgl on 16/7/11.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import "YFTagButton.h"

#define scax 1

@implementation YFTagButton {
    UIImageView *imgView;
    UILabel *priceLabel;
    YFTagsView *tagView;
    CGPoint _origin;
    NSString *_title;
    NSString *_price;
    BOOL _isImg;
    BOOL _ispic;
    YFTagsViewType _type;
    CGFloat scale;
}

+ (instancetype)buttonWithType:(YFTagsViewType)type maxWidth:(CGFloat)width {
    YFTagButton *btn = [[YFTagButton alloc] initWithType:type maxWidth:width];
    return btn;
}

- (instancetype)initWithType:(YFTagsViewType)type maxWidth:(CGFloat)width {
    self = [super init];
    if (self) {
        _type = type;
        scale = width/375;
        [self setUI];
    }
    return self;
}

- (instancetype)init {
    if (self = [super init]) {
        [self setUI];
    }
    return self;
}

- (void)setUI {
    imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"price_ tag"]];
    imgView.frame = CGRectMake(-16*scale, -5*scale, 32*scale, 43*scale);
    [self addSubview:imgView];
    priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, imgView.height - 20*scale, 32*scale, 20*scale)];
     priceLabel.font = [UIFont systemFontOfSize:9*scale];
    priceLabel.textColor = [UIColor whiteColor];
    priceLabel.textAlignment = NSTextAlignmentCenter;
    [imgView addSubview:priceLabel];
    tagView = [[YFTagsView alloc] initWithFrame:CGRectMake(_type == YFTagsViewTypeRight?-5*scale:-20*scale, -12*scale, 25*scale, 24*scale) Type:_type];
    tagView.userInteractionEnabled = NO;
    [self addSubview:tagView];
}

- (void)setTitle:(NSString *)title price:(NSString *)price origin:(CGPoint)origin isImg:(BOOL)isImg ispic:(BOOL)ispic type:(YFTagsViewType)type{
    _type = type;
    _origin = origin;
    _title = title?:@"";
    _price = price?:@"";
    _isImg = isImg;
    _ispic = ispic;
    if (self.superview == nil) {
        return;
    }
    
    tagView.frame = CGRectMake(_type == YFTagsViewTypeRight?-5*scale:-20*scale, -12*scale, 25*scale, 24*scale);
    CGPoint point = _type == YFTagsViewTypeLeft?CGPointMake(168*scale,110*scale):CGPointMake(204*scale,237*scale);
    if (origin.x||origin.y) {
        CGFloat h = (scax*self.superview.width - self.superview.height)/2;
        point = CGPointMake(self.superview.width*origin.x, origin.y*self.superview.width*scax - h);
    }
    self.origin = point;
    CGFloat maxWidth = _type == YFTagsViewTypeLeft?point.x + 5*scale:self.superview.width - point.x + 5*scale;
    tagView.type = type;
    tagView.maxWidth = maxWidth;
    tagView.isImage = isImg;
    tagView.title = title?:@"";
    priceLabel.text = price?:@"";
    imgView.hidden = ispic;
    self.userInteractionEnabled = isImg;
    
}

- (void)setIsHighlight:(BOOL)isHighlight
{
    _isHighlight = isHighlight;
    tagView.isHighlight = isHighlight;
}

- (void)didMoveToSuperview {
    [super didMoveToSuperview];
    [self setTitle:_title price:_price origin:_origin isImg:_isImg ispic:_ispic type:_type];
}

- (BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
    CGPoint tagPoint =  [touch locationInView:tagView];
    CGPoint imgPoint =  [touch locationInView:imgView];
    if ([tagView pointInside:tagPoint withEvent:event]||[imgView pointInside:imgPoint withEvent:event]) {
        [self sendActionsForControlEvents:UIControlEventTouchUpInside];
    }
    return NO;
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    UIView *view = [super hitTest:point withEvent:event];
    if (view == nil&&self.userInteractionEnabled) {
        CGPoint tagPoint = [tagView convertPoint:point fromView:self];
        CGPoint imgPoint = [imgView convertPoint:point fromView:self];
        if ([tagView pointInside:tagPoint withEvent:event]||[imgView pointInside:imgPoint withEvent:event]) {
            view = self;
        }
    }
    return view;
}

@end
