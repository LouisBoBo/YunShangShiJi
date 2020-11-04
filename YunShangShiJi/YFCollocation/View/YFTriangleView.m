//
//  YFTriangleView.m
//  YunShangShiJi
//
//  Created by zgl on 16/6/16.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import "YFTriangleView.h"
#define kArrorHeight 10

@implementation YFTriangleView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
    CGRect rrect = rect;
    CGFloat minx = CGRectGetMinX(rrect),
    midx = CGRectGetMidX(rrect),
    maxx = CGRectGetMaxX(rrect);
    CGFloat miny = CGRectGetMinY(rrect),
    maxy = CGRectGetMaxY(rrect);
    CGContextMoveToPoint(context, midx, miny);
    CGContextAddLineToPoint(context,minx, maxy);
    CGContextAddLineToPoint(context,maxx, maxy);
    CGContextClosePath(context);
    CGContextFillPath(context);
}

@end
