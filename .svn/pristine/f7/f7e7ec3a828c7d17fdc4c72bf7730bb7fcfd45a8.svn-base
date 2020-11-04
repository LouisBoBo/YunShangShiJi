
//
//  TFDrawView.m
//  YunShangShiJi
//
//  Created by 云商 on 15/7/7.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//

#import "TFDrawView.h"

#import <math.h>
#import "SaleManageModel.h"


@implementation TFDrawView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        //
        [self createUI];

    }
    return self;
}

- (void)createUI
{

}

- (void)drawRect:(CGRect)rect {
    
    NSArray *subviews = self.subviews;
    [subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    self.interval = (40);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGFloat XZero = self.interval;
    
//    [self setClearsContextBeforeDrawing:YES];

    UIView *lineV = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height-1, self.frame.size.width, 1)];
    lineV.backgroundColor = RGBACOLOR_F(0.5, 0.5, 0.5,0.4);
    [self addSubview:lineV];
    
    
    if (self.dataArr.count!=0) {
        [self drawPosition:rect];

        CGContextSetLineWidth(ctx, 1.5);
        [[UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.6] set];
        CGContextSetLineCap(ctx, kCGLineCapRound);
        [self.color set];
        SaleManageModel *model = self.dataArr[0];
        if (self.dataArr.count == 1) {
            CGContextAddArc(ctx, XZero+self.xMargin, [self transformationY:[model.sum floatValue]], 2, 0, M_2_PI, 0);
        } else {
            CGContextMoveToPoint(ctx,XZero+self.xMargin, [self transformationY:[model.sum floatValue]]);
            for (int i = 1 ; i<self.dataArr.count; i++) {
                SaleManageModel *lmodel = self.dataArr[i];
                CGContextAddLineToPoint(ctx, XZero+self.xMargin*(i+1), [self transformationY:[lmodel.sum floatValue]]);
            }
        }
        CGContextStrokePath(ctx);
    }
}
- (CGFloat)transformationY:(float)y
{
    CGFloat H = self.frame.size.height;
    CGFloat Yzero = H-self.interval;
    return Yzero-y*self.yMargin/self.vInterval;
}
- (void)drawPosition:(CGRect)rect
{
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGFloat H = rect.size.height;
    CGFloat W = rect.size.width;
    CGFloat XZero = self.interval;
    CGFloat Yzero = H-self.interval;
    
    CGFloat XLen = W-2*self.interval;
    CGFloat YLen = H-2*self.interval;
    
    double maxSum = 0.0f;
    SaleManageModel *model = self.dataArr[0];
    maxSum = [model.sum floatValue];
    for (SaleManageModel *model in self.dataArr) {
        if ([model.sum floatValue]>maxSum) {
            maxSum = [model.sum floatValue];
        }
    }
    double tmp = maxSum/self.dataArr.count;
    MyLog(@"tmp = %f",tmp);
    double margin = 0;
    int i = 1;

    if (tmp>=10) {
        while (1) {
            i = i*10;
            margin = tmp/i;
            if (margin<10&&margin>=1) {
                break;
            }
        }
        int marginI = margin*10;
        int f = marginI%10;
        int g = marginI/10;
        
        if (f>=5) {
            margin = ceil(margin);
        } else {
            margin = g+0.5;
        }
        margin = margin*i;
    } else if (tmp<10&&tmp>=1){
        margin = tmp;
        int marginI = margin*10;
        int f = marginI%10;
        int g = marginI/10;
        
        if (f>=5) {
            margin = ceil(margin);
        } else {
            margin = g+0.5;
        }
        margin = margin*i;
    } else if (tmp<1&&tmp>=0.5) {
        margin = 1;
    } else if (tmp<0.5&&tmp>=0) {
        margin = 0.5;
    }

    self.vInterval = margin;
    
    //self.vInterval = %f",self.vInterval);
    self.yMargin = YLen/(self.dataArr.count+1);
    self.xMargin = XLen/(self.dataArr.count+1);
    
    CGContextMoveToPoint(ctx, self.interval, self.interval);
    CGContextAddLineToPoint(ctx, self.interval, H-self.interval);
    CGContextAddLineToPoint(ctx, W-self.interval, H-self.interval);
    
    CGContextSetLineWidth(ctx, 1);
    [[UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.6] set];
    CGContextSetLineCap(ctx, kCGLineCapRound);
    CGContextStrokePath(ctx);

    for (int i = 0; i<self.dataArr.count+1; i++) {
        CGContextMoveToPoint(ctx, XZero, Yzero-i*self.yMargin);
        CGContextAddLineToPoint(ctx, XZero-(3), Yzero-i*self.yMargin);
        CGContextSetLineWidth(ctx, 1);
        [[UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.6] set];
        CGContextSetLineCap(ctx, kCGLineCapRound);
        CGContextStrokePath(ctx);
        
        UILabel *Ylabel = [[UILabel alloc] initWithFrame:CGRectMake(0, Yzero-i*self.yMargin-self.yMargin/2, XZero-(3), YLen/(self.dataArr.count+1))];
        Ylabel.font = [UIFont systemFontOfSize:(10)];
        Ylabel.adjustsFontSizeToFitWidth = YES;
        Ylabel.textAlignment = NSTextAlignmentCenter;
        Ylabel.textColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.6];

        if (self.vInterval>1) {
            Ylabel.text = [NSString stringWithFormat:@"%.0f",i*self.vInterval];
            [self addSubview:Ylabel];
        } else {
            Ylabel.text = [NSString stringWithFormat:@"%.1f",(float)i*self.vInterval];
            [self addSubview:Ylabel];
        }
    }

    for (int i = 1; i<self.dataArr.count+1; i++) {
        CGContextMoveToPoint(ctx, XZero+i*self.xMargin, Yzero);
        CGContextAddLineToPoint(ctx, XZero+i*self.xMargin, Yzero+(3));
        CGContextSetLineWidth(ctx, 1);
        [[UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.6] set];
        CGContextSetLineCap(ctx, kCGLineCapRound);
        CGContextStrokePath(ctx);
        
        UILabel *Xlabel = [[UILabel alloc] initWithFrame:CGRectMake(XZero+i*self.xMargin-self.xMargin/2, Yzero+(3), self.xMargin, H-Yzero-(3))];
        Xlabel.font = [UIFont systemFontOfSize:(10)];
        Xlabel.adjustsFontSizeToFitWidth = YES;
        Xlabel.textAlignment = NSTextAlignmentCenter;
        Xlabel.textColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.6];
        SaleManageModel *model = self.dataArr[i-1];
        Xlabel.text = model.t;
        [self addSubview:Xlabel];
    }
}

- (NSMutableArray *)xPointArr
{
    if (_xPointArr == nil) {
        _xPointArr = [[NSMutableArray alloc] init];
    }
    return _xPointArr;
}

- (NSMutableArray *)yPointArr
{
    if (_yPointArr == nil) {
        _yPointArr = [[NSMutableArray alloc] init];
    }
    return _yPointArr;
}
@end