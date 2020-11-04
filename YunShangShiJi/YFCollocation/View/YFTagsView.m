//
//  YFTagsView.m
//  YunShangShiJi
//
//  Created by zgl on 16/6/18.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import "YFTagsView.h"
#import "UIView+Animation.h"

#define space 0.70
#define scale self.height/25

@implementation YFTagsView {
    UILabel *titleLabel;
    UIImageView *imgView;
    UIView *view;
    NSArray *layers;
}

- (void)drawRect:(CGRect)rect {
    BOOL isbool = YES;
    if (_type == YFTagsViewTypeLeft) {
        isbool = NO;
    }
    
    CGRect rrect = self.bounds;
    CGFloat radius = scale*6,
    arrorRadius = scale*3,
    arrorWeight = isbool?CGRectGetHeight(rrect)*space:-CGRectGetHeight(rrect)*space,
    
    minx = isbool?CGRectGetMinX(rrect) + radius*2:CGRectGetMaxX(rrect) - radius*2,
    maxx = isbool?CGRectGetMaxX(rrect):CGRectGetMinX(rrect),
    
    miny = CGRectGetMinY(rrect),
    midy = CGRectGetMidY(rrect),
    maxy = CGRectGetMaxY(rrect);
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(minx, midy)];
    
    [path addCurveToPoint:CGPointMake(minx + arrorWeight, miny)
            controlPoint1:CGPointMake(minx, midy - arrorRadius)
            controlPoint2:CGPointMake(minx + arrorWeight - (isbool?arrorRadius:-arrorRadius), miny)];
    
    [path addLineToPoint:CGPointMake(maxx - (isbool?radius:-radius), miny)];
    [path addQuadCurveToPoint:CGPointMake(maxx, miny + radius) controlPoint:CGPointMake(maxx, miny)];
    
    [path addLineToPoint:CGPointMake(maxx, maxy - radius)];
    [path addQuadCurveToPoint:CGPointMake(maxx - (isbool?radius:-radius), maxy) controlPoint:CGPointMake(maxx, maxy)];
    
    [path addLineToPoint:CGPointMake(minx + arrorWeight, maxy)];
    [path addCurveToPoint:CGPointMake(minx, midy)
            controlPoint1:CGPointMake(minx + arrorWeight - (isbool?arrorRadius:-arrorRadius), maxy)
            controlPoint2:CGPointMake(minx, midy + arrorRadius)];
    
    [path closePath];
    UIColor *fillColor;
    if (self.isHighlight) {
        fillColor = [UIColor colorWithRed:210/255.0 green:210/255.0 blue:210/255.0 alpha:1];
    } else {
        fillColor = [UIColor colorWithWhite:0.0 alpha:0.65];
    }
    
    [fillColor set];
    [path fill];
}

- (instancetype)initWithFrame:(CGRect)frame Type:(YFTagsViewType)type {
    self = [super initWithFrame:frame];
    if (self) {
        _type = type;
        _minWidth = CGRectGetHeight(self.frame)*space + 32*scale;
        _maxWidth = [UIScreen mainScreen].bounds.size.width;
        self.backgroundColor = [UIColor clearColor];
        [self initSubViews];
    }
    return self;
}

- (void)initSubViews {
    imgView = [[UIImageView alloc] init];
    imgView.contentMode = UIViewContentModeScaleAspectFill;
    imgView.clipsToBounds = YES;
    imgView.image = [UIImage imageNamed:@"shoping"];;
    imgView.hidden = !_isImage;
    [self addSubview:imgView];
    
    titleLabel = [[UILabel alloc] init];
    titleLabel.font = [UIFont systemFontOfSize:scale*12];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    titleLabel.textAlignment = _type == YFTagsViewTypeLeft?NSTextAlignmentLeft:NSTextAlignmentRight;
    [self addSubview:titleLabel];
    
    view = [[UIView alloc] init];
    view.backgroundColor = [UIColor colorWithWhite:1 alpha:0.75];
    view.layer.cornerRadius = 5*scale;
    view.hidden = _isImage;
    [self addSubview:view];
    
    CALayer *layer1 = [CALayer layer];
    layer1.frame = CGRectMake(0, 0, 10*scale, 10*scale);
    layer1.cornerRadius = 5*scale;
    layer1.backgroundColor = [UIColor colorWithWhite:1 alpha:0.75].CGColor;
    [view.layer addSublayer:layer1];
    
    CALayer *layer2 = [CALayer layer];
    layer2.frame = CGRectMake(0, 0, 10*scale, 10*scale);
    layer2.cornerRadius = 5*scale;
    layer2.backgroundColor = [UIColor colorWithWhite:1 alpha:0.75].CGColor;
    [view.layer addSublayer:layer2];
    layers = @[layer1, layer2];
    
    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(2.5*scale, 2.5*scale, 5*scale, 5*scale)];
    view1.backgroundColor = [UIColor colorWithRed:255/255.0 green:63/255.0 blue:139/255.0 alpha:255/255.0];
    view1.layer.cornerRadius = 2.5*scale;
    [view addSubview:view1];
    
    [self loadFrame];
}

- (void)loadFrame {
    titleLabel.textAlignment = _type == YFTagsViewTypeLeft?NSTextAlignmentLeft:NSTextAlignmentRight;
    CGFloat width = 0;
    NSString *str = titleLabel.text;
    for (int i = 7; i > 0; i--) {
        if (i <= str.length) {
            NSString *subStr = [str substringToIndex:i];
            width = [NSString widthWithString:subStr
                                         font:[UIFont systemFontOfSize:12*scale]
                          constrainedToHeight:18*scale] + CGRectGetHeight(self.frame)*space;
            width += _isImage?40*scale:16*scale;
            if (width >= _minWidth && width <= _maxWidth) {
                break;
            }
        }
    }
    
    if (width <  _minWidth) {
        width = _minWidth;
    }
    
    CGRect frame = self.frame;
    CGFloat x = (width - frame.size.width);
    frame.size.width = width;
    
    if (_type == YFTagsViewTypeRight) {
        view.frame = CGRectMake(0, (frame.size.height - 10*scale)/2, 10*scale, 10*scale);
        imgView.frame = CGRectMake(frame.size.width - 24*scale, 3*scale, 18*scale, 18*scale);
        if (_isImage) {
            titleLabel.frame = CGRectMake(10*scale + CGRectGetHeight(self.frame)*space,3*scale, frame.size.width - 40*scale - CGRectGetHeight(self.frame)*space, 18*scale);
        } else {
            titleLabel.frame = CGRectMake(10*scale + CGRectGetHeight(self.frame)*space, 3*scale, frame.size.width - 16*scale - CGRectGetHeight(self.frame)*space, 18*scale);
        }
        self.frame = frame;
    } else if(_type == YFTagsViewTypeLeft){
        frame.origin.x -= x;
        view.frame = CGRectMake(frame.size.width - 10*scale, (frame.size.height - 10*scale)/2, 10*scale, 10*scale);
        imgView.frame = CGRectMake(6*scale, 3*scale, 18*scale, 18*scale);
        if (_isImage) {
            titleLabel.frame = CGRectMake(30*scale, 3*scale, frame.size.width - 40*scale - CGRectGetHeight(self.frame)*space, 18*scale);
        } else {
            titleLabel.frame = CGRectMake(6*scale, 3*scale, frame.size.width - 16*scale - CGRectGetHeight(self.frame)*space, 18*scale);
        }
        self.frame = frame;
    }
    [self setNeedsDisplay];
    [view scaleStatus:YES layers:layers];
}

- (void)setTitle:(NSString *)title {
    if ([title isEqual:[NSNull null]]) {
        title = @"";
    }
    NSArray *nameAry = [title componentsSeparatedByString:@"】"];
    NSString *name = [nameAry lastObject];
    _title = name?:@"";
    titleLabel.text = _title;
    [self loadFrame];
}

- (void)setIco:(UIImage *)ico {
    _ico = ico;
    imgView.image = _ico;
}

- (void)setIsImage:(BOOL)isImage {
    _isImage = isImage;
    imgView.hidden = !_isImage;
    [self loadFrame];
}

- (void)setIsHighlight:(BOOL)isHighlight
{
    _isHighlight = isHighlight;
    if (isHighlight) {
        titleLabel.textColor = [UIColor blackColor];
        [self setNeedsDisplay];
    } else {
        titleLabel.textColor = [UIColor whiteColor];
        [self setNeedsDisplay];
    }
}

- (void)setMinWidth:(CGFloat)minWidth {
    if (minWidth > CGRectGetHeight(self.frame)*space + 40*scale) {
        _minWidth = minWidth;
    } else {
        _minWidth = CGRectGetHeight(self.frame)*space + 40*scale;
    }
    
    if (minWidth > [UIScreen mainScreen].bounds.size.width) {
        _minWidth = [UIScreen mainScreen].bounds.size.width;
    }
}

- (void)setMaxWidth:(CGFloat)maxWidth {
    if (maxWidth < [UIScreen mainScreen].bounds.size.width) {
        _maxWidth = maxWidth;
    } else {
        _maxWidth = [UIScreen mainScreen].bounds.size.width;
    }
    
    if (maxWidth < CGRectGetHeight(self.frame)*space + 40*scale) {
        _maxWidth = CGRectGetHeight(self.frame)*space + 40*scale;
    }
}

@end
