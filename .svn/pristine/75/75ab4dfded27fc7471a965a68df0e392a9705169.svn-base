//
//  CFPhotoEditViewController.m
//  YunShangShiJi
//
//  Created by YF on 2017/10/26.
//  Copyright © 2017年 ios-1. All rights reserved.
//

#import "CFPhotoEditViewController.h"
#import "AddTagsViewController.h"

#pragma mark- UI components
@interface ZLClippingCircle : UIView

@property (nonatomic, strong) UIColor *bgColor;

@end

@implementation ZLClippingCircle

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGRect rct = self.bounds;
    rct.origin.x = rct.size.width/2-rct.size.width/6;
    rct.origin.y = rct.size.height/2-rct.size.height/6;
    rct.size.width /= 3;
    rct.size.height /= 3;
    
    CGContextSetFillColorWithColor(context, self.bgColor.CGColor);
    CGContextFillEllipseInRect(context, rct);
}

@end

//!!!!: ZLRatio
@interface ZLRatio : NSObject
@property (nonatomic, assign) BOOL isLandscape;
@property (nonatomic, readonly) CGFloat ratio;
@property (nonatomic, strong) NSString *titleFormat;

- (id)initWithValue1:(CGFloat)value1 value2:(CGFloat)value2;

@end

@implementation ZLRatio
{
    CGFloat _longSide;
    CGFloat _shortSide;
}

- (id)initWithValue1:(CGFloat)value1 value2:(CGFloat)value2
{
    self = [super init];
    if(self){
        _longSide  = MAX(fabs(value1), fabs(value2));
        _shortSide = MIN(fabs(value1), fabs(value2));
    }
    return self;
}

- (NSString*)description
{
    NSString *format = (self.titleFormat) ? self.titleFormat : @"%g : %g";
    
    if(self.isLandscape){
        return [NSString stringWithFormat:format, _longSide, _shortSide];
    }
    return [NSString stringWithFormat:format, _shortSide, _longSide];
}

- (CGFloat)ratio
{
    if(_longSide==0 || _shortSide==0){
        return 0;
    }
    
    if(self.isLandscape){
        return _shortSide / (CGFloat)_longSide;
    }
    return _longSide / (CGFloat)_shortSide;
}

@end

//!!!!: ZLRatioMenuItem
@interface ZLRatioMenuItem : UIView

@property (nonatomic, strong) UIImageView *iconView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) ZLRatio *ratio;
@property (nonatomic, assign) BOOL selected;
- (void)changeOrientation;
@end

@implementation ZLRatioMenuItem

- (id)initWithFrame:(CGRect)frame target:(id)target action:(SEL)action
{
    self = [self initWithFrame:frame];
    if(self){
        UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:target action:action];
        [self addGestureRecognizer:gesture];
        
        CGFloat W = frame.size.width;
        CGFloat H = frame.size.height;
        _iconView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, W, H-10-ZOOM6(20))];
        _iconView.clipsToBounds = YES;
        _iconView.layer.cornerRadius = 2;
        _iconView.layer.borderWidth = 2;
        _iconView.layer.borderColor = kSubTitleColor.CGColor;
        [self addSubview:_iconView];
        
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, H-15-ZOOM6(20), W, 15)];
        _titleLabel.font = kFont6px(20);
        _titleLabel.textColor = kSubTitleColor;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_titleLabel];
    }
    return self;
}

- (void)setRatio:(ZLRatio *)ratio
{
    if(ratio != _ratio){
        _ratio = ratio;
    }
}

- (void)setSelected:(BOOL)selected {
    if (_selected != selected) {
        _selected = selected;
        _titleLabel.textColor = selected ? tarbarrossred : kSubTitleColor;
        _iconView.layer.borderColor = selected ? tarbarrossred.CGColor : kSubTitleColor.CGColor;
    }
}

- (void)refreshViews
{
    _titleLabel.text = [_ratio description];
    
    CGPoint center = _iconView.center;
    CGFloat W, H;
    if(_ratio.ratio!=0){
        if(_ratio.isLandscape){
            W = 50;
            H = 50*_ratio.ratio;
        }
        else{
            W = 50/_ratio.ratio;
            H = 50;
        }
    }
    else{
        CGFloat maxW  = MAX(_iconView.image.size.width, _iconView.image.size.height);
        W = 50 * _iconView.image.size.width / maxW;
        H = 50 * _iconView.image.size.height / maxW;
    }
    _iconView.frame = CGRectMake(center.x-W/2, center.y-H/2, W, H);
}

- (void)changeOrientation
{
    self.ratio.isLandscape = !self.ratio.isLandscape;
    
    [UIView animateWithDuration:0.2 animations:^{
        [self refreshViews];
    }];
}


@end

@interface ZLGridLayar : CALayer
@property (nonatomic, assign) CGRect clippingRect;
@property (nonatomic, strong) UIColor *bgColor;
@property (nonatomic, strong) UIColor *gridColor;

@end

@implementation ZLGridLayar

+ (BOOL)needsDisplayForKey:(NSString*)key
{
    if ([key isEqualToString:@"clippingRect"]) {
        return YES;
    }
    return [super needsDisplayForKey:key];
}

- (id)initWithLayer:(id)layer
{
    self = [super initWithLayer:layer];
    if(self && [layer isKindOfClass:[ZLGridLayar class]]){
        self.bgColor   = ((ZLGridLayar *)layer).bgColor;
        self.gridColor = ((ZLGridLayar *)layer).gridColor;
        self.clippingRect = ((ZLGridLayar *)layer).clippingRect;
    }
    return self;
}

- (void)drawInContext:(CGContextRef)context
{
    CGRect rct = self.bounds;
    CGContextSetFillColorWithColor(context, self.bgColor.CGColor);
    CGContextFillRect(context, rct);
    
    CGContextClearRect(context, _clippingRect);
    
    CGContextSetStrokeColorWithColor(context, self.gridColor.CGColor);
    CGContextSetLineWidth(context, 1);
    
    rct = self.clippingRect;
    
    CGContextBeginPath(context);
    CGFloat dW = 0;
    for(int i=0;i<4;++i){
        CGContextMoveToPoint(context, rct.origin.x+dW, rct.origin.y);
        CGContextAddLineToPoint(context, rct.origin.x+dW, rct.origin.y+rct.size.height);
        dW += _clippingRect.size.width/3;
    }
    
    dW = 0;
    for(int i=0;i<4;++i){
        CGContextMoveToPoint(context, rct.origin.x, rct.origin.y+dW);
        CGContextAddLineToPoint(context, rct.origin.x+rct.size.width, rct.origin.y+dW);
        dW += rct.size.height/3;
    }
    CGContextStrokePath(context);
}

@end

//!!!!: edit vc
@interface CFPhotoEditViewController ()
{
    UIImageView *_imageView;
    UILabel *_titleLabel;
    UIButton *_nextBtn;
    NSInteger curImgIndex;
    
    ZLGridLayar *_gridLayer;
    ZLClippingCircle *_ltView;
    ZLClippingCircle *_lbView;
    ZLClippingCircle *_rtView;
    ZLClippingCircle *_rbView;
    
    //比例底滚动视图
    UIScrollView *_menuScroll;
}

@property (nonatomic, strong) ZLRatioMenuItem *selectedMenu;
@property (nonatomic, assign) CGRect clippingRect;
@property (nonatomic, strong) ZLRatio *clippingRatio;
@property (nonatomic, strong) NSMutableArray *editPhotos;

@end

@implementation CFPhotoEditViewController

- (NSMutableArray *)editPhotos {
    if (!_editPhotos) {
        _editPhotos = [NSMutableArray array];
    }
    return _editPhotos;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    UIEdgeInsets inset = UIEdgeInsetsZero;
    CGFloat w = kScreenWidth;
    CGFloat maxH = kScreenHeight-Height_NavBar-ZOOM6(120)-inset.bottom-inset.top;
    
    CGFloat h = w * self.oriImage.size.height / self.oriImage.size.width;
    if (h > maxH) {
        h = maxH;
        w = h * self.oriImage.size.width / self.oriImage.size.height;
    }
    _imageView.frame = CGRectMake((kScreenWidth-w)/2, (kScreenHeight-h)/2-Height_NavBar, w, h);
    _imageView.center = CGPointMake(kScreenWidth/2, (kScreenHeight-Height_NavBar-ZOOM6(120))/2+Height_NavBar);
    _gridLayer.frame = _imageView.bounds;
    [self clippingRatioDidChange];
 
    _menuScroll.frame = CGRectMake(inset.left, kScreenHeight-ZOOM6(120)-inset.bottom, kScreenWidth-ZOOM6(160), ZOOM6(120));
    _menuScroll.center = CGPointMake(kScreenWidth/2, _menuScroll.center.y);
}

- (void)initUI
{
    self.view.backgroundColor = [UIColor blackColor];
    //禁用返回手势
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.delegate = nil;
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
    [self setBottomMenu];
    [self loadImage];
    
    _gridLayer = [[ZLGridLayar alloc] init];
    _gridLayer.bgColor   = [[UIColor blackColor] colorWithAlphaComponent:.5];
    _gridLayer.gridColor = [UIColor whiteColor];
    [_imageView.layer addSublayer:_gridLayer];
    
    _ltView = [self clippingCircleWithTag:0];
    _lbView = [self clippingCircleWithTag:1];
    _rtView = [self clippingCircleWithTag:2];
    _rbView = [self clippingCircleWithTag:3];
    
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGridView:)];
    _imageView.userInteractionEnabled = YES;
    [_imageView addGestureRecognizer:panGesture];
    
    [self setNavgationView];

}
- (void)setNavgationView {
    UIImageView *headview=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, Height_NavBar)];
    headview.image=[UIImage imageNamed:@"导航背景"];
    headview.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:headview];
    headview.userInteractionEnabled=YES;
    
    UIButton *backbtn=[UIButton buttonWithType:UIButtonTypeCustom];
    backbtn.frame=CGRectMake(0, Height_NavBar-58, 46, 46);
    backbtn.centerY = View_CenterY(headview);
    [backbtn addTarget:self action:@selector(cancelBtn_click) forControlEvents:UIControlEventTouchUpInside];
    [backbtn setImage:[UIImage imageNamed:@"返回按钮_正常"] forState:UIControlStateNormal];
    [headview addSubview:backbtn];
    
    UIButton *setbtn=[UIButton buttonWithType:UIButtonTypeCustom];
    setbtn.frame=CGRectMake(kScreenWidth-80, Height_NavBar-57, 80, 44);
    setbtn.centerY = View_CenterY(headview);
    [setbtn addTarget:self action:@selector(btnDone_click) forControlEvents:UIControlEventTouchUpInside];
    [setbtn setTitle:self.imgArr.count==1?@"下一步":@"下一张" forState:UIControlStateNormal];
    [setbtn setTitleColor:tarbarrossred forState:UIControlStateNormal];
    [setbtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 20, 0, 0)];
    [headview addSubview:setbtn];
    _nextBtn = setbtn;
    
    curImgIndex = 1;
    UILabel *titlelable=[[UILabel alloc]init];
    titlelable.frame=CGRectMake(0, 0, headview.frame.size.width, 40);
    titlelable.center=CGPointMake(kScreenWidth/2, headview.frame.size.height/2+10);
    titlelable.text= [NSString stringWithFormat:@"裁剪（%zd/%zd）",curImgIndex,self.imgArr.count];
    titlelable.font = kNavTitleFontSize;
    titlelable.textColor=kMainTitleColor;
    titlelable.textAlignment=NSTextAlignmentCenter;
    [headview addSubview:titlelable];
    _titleLabel = titlelable;
}


/**
 改变标题  按钮文字
 */
- (void)changeTitle {
    self.oriImage = self.imgArr[curImgIndex];
    _imageView.image = self.oriImage;
    curImgIndex += 1;

    _titleLabel.text= [NSString stringWithFormat:@"裁剪（%zd/%zd）",curImgIndex,self.imgArr.count];
    [_nextBtn setTitle:self.imgArr.count==curImgIndex?@"下一步":@"下一张" forState:UIControlStateNormal];
}


- (void)loadImage
{
    self.oriImage = self.imgArr.firstObject;
    //imageview
    _imageView = [[UIImageView alloc] init];
    _imageView.image = self.oriImage;
    _imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:_imageView];
    
}

- (UIImage *)scaleImage:(UIImage *)image toSize:(CGSize)size
{
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *newImage=UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return  newImage;
}
- (void)setBottomMenu {
    UIView *bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, kScreenHeight-ZOOM6(120), kScreenWidth, ZOOM6(120))];
    bottomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bottomView];
    //这只是初始坐标，实际坐标在viewdidlayoutsubviews里面布局
    _menuScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, ZOOM6(120))];
    _menuScroll.backgroundColor = [UIColor clearColor];
    _menuScroll.showsHorizontalScrollIndicator = NO;
    _menuScroll.clipsToBounds = NO;
    _menuScroll.bounces = NO;
    [self.view addSubview:_menuScroll];
    
    NSArray *ratios = @[@{@"value1": @(1),
                          @"value2": @(1),
                          @"titleFormat": @"%g:%g"},
                        @{@"value1": @(4),
                          @"value2": @(3),
                          @"titleFormat": @"%g:%g"},
                        @{@"value1": @(16),
                          @"value2": @(9),
                          @"titleFormat": @"%g:%g"}];
    
    CGFloat W = (kScreenWidth-ZOOM6(160))/3;//ratios.count;
    CGFloat x = 0;
    for (int i=0; i<3; i++) {
        NSDictionary *info = ratios[i];
        CGFloat val1 = [info[@"value1"] floatValue];
        CGFloat val2 = [info[@"value2"] floatValue];
        
        ZLRatio *ratio = [[ZLRatio alloc] initWithValue1:val1 value2:val2];
        ratio.titleFormat = info[@"titleFormat"];
        
        ratio.isLandscape = NO;
        
        ZLRatioMenuItem *view = [[ZLRatioMenuItem alloc] initWithFrame:CGRectMake(x, 0, W, _menuScroll.frame.size.height) target:self action:@selector(tappedMenu:)];
        view.ratio = ratio;
        view.titleLabel.text = [ratio description];
        [_menuScroll addSubview:view];
        x += W;
        
        if (i==0) {
            view.iconView.frame = CGRectMake(W/2-ZOOM6(15), view.titleLabel.y-ZOOM6(30), ZOOM6(30), ZOOM6(30));
        }else if (i==1) {
            view.iconView.frame = CGRectMake(W/2-ZOOM6(15), view.titleLabel.y-ZOOM6(40), ZOOM6(30), ZOOM6(40));
        }else if (i==2) {
            view.iconView.frame = CGRectMake(W/2-ZOOM6(15), view.titleLabel.y-ZOOM6(54), ZOOM6(30), ZOOM6(54));
        }
        
        if(self.selectedMenu==nil){
            self.selectedMenu = view;
        }
    }
    
}


- (void)tappedMenu:(UITapGestureRecognizer*)sender
{
    ZLRatioMenuItem *view = (ZLRatioMenuItem*)sender.view;
    self.selectedMenu = view;
}

- (void)setSelectedMenu:(ZLRatioMenuItem *)selectedMenu
{
    if(selectedMenu != _selectedMenu){
        [_selectedMenu setSelected:NO];
        
        _selectedMenu = selectedMenu;
        [_selectedMenu setSelected:YES];
        
        if(selectedMenu.ratio.ratio==0){
            self.clippingRatio = nil;
        } else {
            self.clippingRatio = selectedMenu.ratio;
        }
    }
}

- (void)setClippingRatio:(ZLRatio *)clippingRatio
{
    if(clippingRatio != _clippingRatio){
        _clippingRatio = clippingRatio;
        [self clippingRatioDidChange];
    }
}

- (void)clippingRatioDidChange
{
    CGRect rect = _imageView.bounds;
    if (self.clippingRatio) {
        CGFloat H = rect.size.width * self.clippingRatio.ratio;
        if (H<=rect.size.height) {
            rect.size.height = H;
        } else {
            rect.size.width *= rect.size.height / H;
        }
        
        rect.origin.x = (_imageView.bounds.size.width - rect.size.width) / 2;
        rect.origin.y = (_imageView.bounds.size.height - rect.size.height) / 2;
    }
    [self setClippingRect:rect animated:YES];
}

- (void)setClippingRect:(CGRect)clippingRect animated:(BOOL)animated
{
    if (animated) {
        [UIView animateWithDuration:0.2 animations:^{
            _ltView.center = [self.view convertPoint:CGPointMake(clippingRect.origin.x, clippingRect.origin.y) fromView:_imageView];
            _lbView.center = [self.view convertPoint:CGPointMake(clippingRect.origin.x, clippingRect.origin.y+clippingRect.size.height) fromView:_imageView];
            _rtView.center = [self.view convertPoint:CGPointMake(clippingRect.origin.x+clippingRect.size.width, clippingRect.origin.y) fromView:_imageView];
            _rbView.center = [self.view convertPoint:CGPointMake(clippingRect.origin.x+clippingRect.size.width, clippingRect.origin.y+clippingRect.size.height) fromView:_imageView];
        }
         ];
        
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"clippingRect"];
        animation.duration = 0.2;
        animation.fromValue = [NSValue valueWithCGRect:_clippingRect];
        animation.toValue = [NSValue valueWithCGRect:clippingRect];
        [_gridLayer addAnimation:animation forKey:nil];
        
        _gridLayer.clippingRect = clippingRect;
        _clippingRect = clippingRect;
        [_gridLayer setNeedsDisplay];
    } else {
        self.clippingRect = clippingRect;
    }
}

- (ZLClippingCircle*)clippingCircleWithTag:(NSInteger)tag
{
    ZLClippingCircle *view = [[ZLClippingCircle alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    view.backgroundColor = [UIColor clearColor];
    view.bgColor = [UIColor whiteColor];
    view.tag = tag;
    
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panCircleView:)];
    [view addGestureRecognizer:panGesture];
    
    [self.view addSubview:view];
    
    return view;
}

- (void)setClippingRect:(CGRect)clippingRect
{
    _clippingRect = clippingRect;
    
    _ltView.center = [self.view convertPoint:CGPointMake(_clippingRect.origin.x, _clippingRect.origin.y) fromView:_imageView];
    _lbView.center = [self.view convertPoint:CGPointMake(_clippingRect.origin.x, _clippingRect.origin.y+_clippingRect.size.height) fromView:_imageView];
    _rtView.center = [self.view convertPoint:CGPointMake(_clippingRect.origin.x+_clippingRect.size.width, _clippingRect.origin.y) fromView:_imageView];
    _rbView.center = [self.view convertPoint:CGPointMake(_clippingRect.origin.x+_clippingRect.size.width, _clippingRect.origin.y+_clippingRect.size.height) fromView:_imageView];
    
    _gridLayer.clippingRect = clippingRect;
    [_gridLayer setNeedsDisplay];
}

#pragma mark - 拖动
- (void)panCircleView:(UIPanGestureRecognizer*)sender
{
    CGPoint point = [sender locationInView:_imageView];
    CGPoint dp = [sender translationInView:_imageView];
    
    CGRect rct = self.clippingRect;
    
    const CGFloat W = _imageView.frame.size.width;
    const CGFloat H = _imageView.frame.size.height;
    CGFloat minX = 0;
    CGFloat minY = 0;
    CGFloat maxX = W;
    CGFloat maxY = H;
    
    CGFloat ratio = (sender.view.tag == 1 || sender.view.tag==2) ? -self.clippingRatio.ratio : self.clippingRatio.ratio;
    
    switch (sender.view.tag) {
        case 0: // upper left
        {
            maxX = MAX((rct.origin.x + rct.size.width)  - 0.1 * W, 0.1 * W);
            maxY = MAX((rct.origin.y + rct.size.height) - 0.1 * H, 0.1 * H);
            
            if (ratio!=0) {
                CGFloat y0 = rct.origin.y - ratio * rct.origin.x;
                CGFloat x0 = -y0 / ratio;
                minX = MAX(x0, 0);
                minY = MAX(y0, 0);
                
                point.x = MAX(minX, MIN(point.x, maxX));
                point.y = MAX(minY, MIN(point.y, maxY));
                
                if(-dp.x*ratio + dp.y > 0){ point.x = (point.y - y0) / ratio; }
                else{ point.y = point.x * ratio + y0; }
            } else {
                point.x = MAX(minX, MIN(point.x, maxX));
                point.y = MAX(minY, MIN(point.y, maxY));
            }
            
            rct.size.width  = rct.size.width  - (point.x - rct.origin.x);
            rct.size.height = rct.size.height - (point.y - rct.origin.y);
            rct.origin.x = point.x;
            rct.origin.y = point.y;
            break;
        }
        case 1: // lower left
        {
            maxX = MAX((rct.origin.x + rct.size.width)  - 0.1 * W, 0.1 * W);
            minY = MAX(rct.origin.y + 0.1 * H, 0.1 * H);
            
            if (ratio!=0) {
                CGFloat y0 = (rct.origin.y + rct.size.height) - ratio* rct.origin.x ;
                CGFloat xh = (H - y0) / ratio;
                minX = MAX(xh, 0);
                maxY = MIN(y0, H);
                
                point.x = MAX(minX, MIN(point.x, maxX));
                point.y = MAX(minY, MIN(point.y, maxY));
                
                if(-dp.x*ratio + dp.y < 0){ point.x = (point.y - y0) / ratio; }
                else{ point.y = point.x * ratio + y0; }
            } else {
                point.x = MAX(minX, MIN(point.x, maxX));
                point.y = MAX(minY, MIN(point.y, maxY));
            }
            
            rct.size.width  = rct.size.width  - (point.x - rct.origin.x);
            rct.size.height = point.y - rct.origin.y;
            rct.origin.x = point.x;
            break;
        }
        case 2: // upper right
        {
            minX = MAX(rct.origin.x + 0.1 * W, 0.1 * W);
            maxY = MAX((rct.origin.y + rct.size.height) - 0.1 * H, 0.1 * H);
            
            if (ratio!=0) {
                CGFloat y0 = rct.origin.y - ratio * (rct.origin.x + rct.size.width);
                CGFloat yw = ratio * W + y0;
                CGFloat x0 = -y0 / ratio;
                maxX = MIN(x0, W);
                minY = MAX(yw, 0);
                
                point.x = MAX(minX, MIN(point.x, maxX));
                point.y = MAX(minY, MIN(point.y, maxY));
                
                if(-dp.x*ratio + dp.y > 0){ point.x = (point.y - y0) / ratio; }
                else{ point.y = point.x * ratio + y0; }
            } else {
                point.x = MAX(minX, MIN(point.x, maxX));
                point.y = MAX(minY, MIN(point.y, maxY));
            }
            
            rct.size.width  = point.x - rct.origin.x;
            rct.size.height = rct.size.height - (point.y - rct.origin.y);
            rct.origin.y = point.y;
            break;
        }
        case 3: // lower right
        {
            minX = MAX(rct.origin.x + 0.1 * W, 0.1 * W);
            minY = MAX(rct.origin.y + 0.1 * H, 0.1 * H);
            
            if (ratio!=0) {
                CGFloat y0 = (rct.origin.y + rct.size.height) - ratio * (rct.origin.x + rct.size.width);
                CGFloat yw = ratio * W + y0;
                CGFloat xh = (H - y0) / ratio;
                maxX = MIN(xh, W);
                maxY = MIN(yw, H);
                
                point.x = MAX(minX, MIN(point.x, maxX));
                point.y = MAX(minY, MIN(point.y, maxY));
                
                if(-dp.x*ratio + dp.y < 0){ point.x = (point.y - y0) / ratio; }
                else{ point.y = point.x * ratio + y0; }
            } else {
                point.x = MAX(minX, MIN(point.x, maxX));
                point.y = MAX(minY, MIN(point.y, maxY));
            }
            
            rct.size.width  = point.x - rct.origin.x;
            rct.size.height = point.y - rct.origin.y;
            break;
        }
        default:
            break;
    }
    self.clippingRect = rct;
}

- (void)panGridView:(UIPanGestureRecognizer*)sender
{
    static BOOL dragging = NO;
    static CGRect initialRect;
    
    if (sender.state==UIGestureRecognizerStateBegan) {
        CGPoint point = [sender locationInView:_imageView];
        dragging = CGRectContainsPoint(_clippingRect, point);
        initialRect = self.clippingRect;
    } else if(dragging) {
        CGPoint point = [sender translationInView:_imageView];
        CGFloat left  = MIN(MAX(initialRect.origin.x + point.x, 0), _imageView.frame.size.width-initialRect.size.width);
        CGFloat top   = MIN(MAX(initialRect.origin.y + point.y, 0), _imageView.frame.size.height-initialRect.size.height);
        
        CGRect rct = self.clippingRect;
        rct.origin.x = left;
        rct.origin.y = top;
        self.clippingRect = rct;
    }
}

#pragma mark - action
- (void)cancelBtn_click
{
//    ZLImageNavigationController *nav = (ZLImageNavigationController *)self.navigationController;
//    if (nav.editAfterSelectThumbnailImage &&
//        nav.maxSelectCount == 1) {
//        [nav.arrSelectedModels removeAllObjects];
//    }
    UIViewController *vc = [self.navigationController popViewControllerAnimated:YES];
    if (!vc) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)btnDone_click
{
    if (_isFromPublish) {
        [self.editPhotos addObject:[self clipImage]];

        if (curImgIndex == self.imgArr.count) {
            if (_isFromPublish && _editPhotosBlock) {
                _editPhotosBlock([self.editPhotos copy]);
            }
        }else {
            [self changeTitle];
        }
    }else {
        //确定裁剪
        kSelfWeak;
        AddTagsViewController *vc=[[AddTagsViewController alloc]init];
        vc.refreshBlock = ^{
            if (weakSelf.refreshBlock) {
                weakSelf.refreshBlock();
            }
        };
        vc.tagImage=[self clipImage];
        [self.navigationController pushViewController:vc animated:YES];
    }
   
   
}

- (UIImage *)clipImage
{
    CGFloat zoomScale = _imageView.bounds.size.width / _imageView.image.size.width;
    CGRect rct = self.clippingRect;
    rct.size.width  /= zoomScale;
    rct.size.height /= zoomScale;
    rct.origin.x    /= zoomScale;
    rct.origin.y    /= zoomScale;
    
    CGPoint origin = CGPointMake(-rct.origin.x, -rct.origin.y);
    UIImage *img = nil;
    
    UIGraphicsBeginImageContextWithOptions(rct.size, NO, _imageView.image.scale);
    [_imageView.image drawAtPoint:origin];
    img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return img;
}

@end
