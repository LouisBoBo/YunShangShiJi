//
//  PopoverView.m
//  ArrowView
//
//  Created by guojiang on 4/9/14.
//  Copyright (c) 2014年 LINAICAI. All rights reserved.


#import "PopoverView.h"
#import "GlobalTool.h"

#define kArrowHeight 10.f
#define kArrowCurvature 6.f
#define SPACE 2.f
#define ROW_HEIGHT 35.f
#define TITLE_FONT [UIFont systemFontOfSize:16]
#define RGB(r, g, b)    [UIColor colorWithRed:(r)/255.f green:(g)/255.f blue:(b)/255.f alpha:1.f]

@interface PopoverView ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSArray *imageArray;
@property (nonatomic) CGPoint showPoint;

@property (nonatomic, strong) UIButton *handerView;

@end

@implementation PopoverView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
//        self.borderColor = RGB(37, 37, 37);
        
//        self.borderColor = [UIColor redColor];
        self.backgroundColor = [UIColor clearColor];
//        self.backgroundColor = [UIColor redColor];
        
    }
    return self;
}

-(id)initWithPoint:(CGPoint)point titles:(NSArray *)titles images:(NSArray *)imageArr withSceenWith:(CGFloat )sceenWith popWith:(CGFloat)popwith cellTextFont:(CGFloat)cellTextFont{
    self = [super init];
    if (self) {
        self.showPoint = point;
        self.titleArray = titles;
        self.imageArray = imageArr;
        self.sceenWith = sceenWith;
        self.popWith = popwith;
        self.cellTextFont = cellTextFont;
        self.frame = [self getViewFrame:sceenWith];
        self.backgroundColor = [UIColor clearColor];
        //%f", self.popWith);
        
        [self addSubview:self.tableView];
        
    }
    return self;
}

-(CGRect)getViewFrame:(CGFloat )sceenWith
{
    CGRect frame = CGRectZero;
    
    frame.size.height = [self.titleArray count] * ROW_HEIGHT + SPACE + kArrowHeight;
    
    if ([self.titleArray count] == [self.imageArray count]) {
        frame.size.width = 10 + 25 + 10 + frame.size.width + 140;
    }
    else{

        //%f", self.popWith);
        if (self.popWith > 0) {
            
             frame.size.width = self.popWith;
            
        } else  {
        
            frame.size.width = sceenWith / 3;
        
        }
    }
    
//    //sp = %f ----- pw = %f ", self.showPoint.x, frame.size.width);
    
    frame.origin.x = self.showPoint.x - frame.size.width/2;
//    frame.origin.y = self.showPoint.y;
//    frame.origin.x = self.showPoint.x;
    frame.origin.y = self.showPoint.y;
    
    //左间隔最小5x
    if (frame.origin.x < 10) {
        frame.origin.x = 10;
    }
    //右间隔最小5x
    if ((frame.origin.x + frame.size.width) > sceenWith-10) {
        frame.origin.x = sceenWith - frame.size.width-10;
    }
    
//    //frame = %@", NSStringFromCGRect(frame));
    
    return frame;
}


-(void)show
{
    self.handerView = [UIButton buttonWithType:UIButtonTypeCustom];
    [_handerView setFrame:[UIScreen mainScreen].bounds];
    [_handerView setBackgroundColor:[UIColor clearColor]];
    [_handerView addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    [_handerView addSubview:self];
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
    [window addSubview:_handerView];
    
    CGPoint arrowPoint = [self convertPoint:self.showPoint fromView:_handerView];
    self.layer.anchorPoint = CGPointMake(arrowPoint.x / self.frame.size.width, arrowPoint.y / self.frame.size.height);
    self.frame = [self getViewFrame:self.sceenWith ];
    
    self.alpha = 0.f;
    self.transform = CGAffineTransformMakeScale(0.1f, 0.1f);
    [UIView animateWithDuration:0.2f delay:0.f options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.transform = CGAffineTransformMakeScale(1.05f, 1.05f);
        self.alpha = 1.f;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.08f delay:0.f options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.transform = CGAffineTransformIdentity;
        } completion:nil];
    }];
}

-(void)dismiss
{
    [self dismiss:YES];
    
    if ([self.delegate respondsToSelector:@selector(dismissPopverView:)]) {
        
        [self.delegate dismissPopverView:self];
    }
}

-(void)dismiss:(BOOL)animate
{
    if(self.dismissblock)
    {
        self.dismissblock();
    }

    if (!animate) {
        [_handerView removeFromSuperview];
        return;
    }
    
    [UIView animateWithDuration:0.3f animations:^{
        self.transform = CGAffineTransformMakeScale(0.1f, 0.1f);
        self.alpha = 0.f;
    } completion:^(BOOL finished) {
        [_handerView removeFromSuperview];
        
    }];
    
}


#pragma mark - UITableView

-(UITableView *)tableView
{
    if (_tableView != nil) {
        return _tableView;
    }
    
    CGRect rect = self.frame;
    rect.origin.x = SPACE;
    rect.origin.y = kArrowHeight + SPACE;
    rect.size.width -= SPACE * 2;
    rect.size.height -= (SPACE - kArrowHeight);
    

    
    self.tableView = [[UITableView alloc] initWithFrame:rect style:UITableViewStylePlain];

    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.alwaysBounceHorizontal = NO;
    _tableView.alwaysBounceVertical = NO;
    _tableView.showsHorizontalScrollIndicator = NO;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.scrollEnabled = NO;
    _tableView.backgroundColor = [UIColor clearColor];
    
    _tableView.rowHeight=30;
  

    
//    _tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    
    return _tableView;
}

#pragma mark - UITableView DataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_titleArray count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    cell.backgroundView = [[UIView alloc] init];
#pragma mark - xj在这里改颜色
//    cell.backgroundView.backgroundColor = RGB(37, 37, 37);
    cell.backgroundView.backgroundColor = [UIColor whiteColor];

    
    if ([_imageArray count] == [_titleArray count]) {
        cell.imageView.image = [UIImage imageNamed:[_imageArray objectAtIndex:indexPath.row]];
    }
    if (self.cellTextFont > 0) {
        cell.textLabel.font = [UIFont systemFontOfSize:ZOOM(40)];
    } else {
        cell.textLabel.font = [UIFont systemFontOfSize:ZOOM(40)];
    
    }
//    cell.textLabel.font = [UIFont systemFontOfSize:16];
    cell.textLabel.textColor = RGBCOLOR_I(62, 62, 62);
    cell.textLabel.text = [_titleArray objectAtIndex:indexPath.row];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 7.0) {
        cell.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    }
    
    return cell;
}

#pragma mark - UITableView Delegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if (self.selectRowAtIndex) {
        self.selectRowAtIndex(indexPath.row);
    }
    
    if ([self.delegate respondsToSelector:@selector(seletRowAtIndex:didSelectRowAtIndexPath:)]) {
        
        [self.delegate seletRowAtIndex:self didSelectRowAtIndexPath:indexPath];
        
    }
    [self dismiss:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return ROW_HEIGHT;

}



// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
//    [self.borderColor set]; //设置线条颜色
    [[UIColor whiteColor] set]; //设置线条颜色
    
    CGRect frame = CGRectMake(0, 10, self.bounds.size.width, self.bounds.size.height - kArrowHeight);
    
    float xMin = CGRectGetMinX(frame);
    float yMin = CGRectGetMinY(frame);
    
    float xMax = CGRectGetMaxX(frame);
    float yMax = CGRectGetMaxY(frame);
    
    float radius = 5.f; //Radius of the curvature.
    
    float cpOffset = 3.f; //Control Point Offset.  Modifies how "curved" the corners are.
    
    CGPoint arrowPoint = [self convertPoint:self.showPoint fromView:_handerView];
    
    UIBezierPath *popoverPath = [UIBezierPath bezierPath];
    [popoverPath moveToPoint:CGPointMake(xMin, yMin+radius)];//左上角
    [popoverPath addCurveToPoint:CGPointMake(xMin + radius, yMin) controlPoint1:CGPointMake(xMin, yMin + radius - cpOffset) controlPoint2:CGPointMake(xMin + radius - cpOffset, yMin)];//LT2

    /********************向上的箭头**********************/
    [popoverPath addLineToPoint:CGPointMake(arrowPoint.x - kArrowHeight, yMin)];//left side
    [popoverPath addCurveToPoint:arrowPoint
                   controlPoint1:CGPointMake(arrowPoint.x - kArrowHeight + kArrowCurvature, yMin)
                   controlPoint2:arrowPoint];//actual arrow point
    
    [popoverPath addCurveToPoint:CGPointMake(arrowPoint.x + kArrowHeight, yMin)
                   controlPoint1:arrowPoint
                   controlPoint2:CGPointMake(arrowPoint.x + kArrowHeight - kArrowCurvature, yMin)];//right side
    /********************向上的箭头**********************/
    
    
    [popoverPath addLineToPoint:CGPointMake(xMax-radius, yMin)];//右上角
    [popoverPath addCurveToPoint:CGPointMake(xMax, yMin + radius) controlPoint1:CGPointMake(xMax - radius + cpOffset, yMin) controlPoint2:CGPointMake(xMax, yMin + radius - cpOffset)];//RT2

    [popoverPath addLineToPoint:CGPointMake(xMax, yMax - radius)];//RB1
    [popoverPath addCurveToPoint:CGPointMake(xMax - radius, yMax) controlPoint1:CGPointMake(xMax, yMax - radius + cpOffset) controlPoint2:CGPointMake(xMax - radius + cpOffset, yMax)];//RB2

    [popoverPath addLineToPoint:CGPointMake(xMin + radius, yMax)];//LB1
    [popoverPath addCurveToPoint:CGPointMake(xMin, yMax - radius) controlPoint1:CGPointMake(xMin + radius - cpOffset, yMax) controlPoint2:CGPointMake(xMin, yMax - radius + cpOffset)];//LB2

    //填充颜色
    [[UIColor whiteColor] setFill];
    [popoverPath fill];
    
    [popoverPath closePath];
    [popoverPath stroke];
}


@end
