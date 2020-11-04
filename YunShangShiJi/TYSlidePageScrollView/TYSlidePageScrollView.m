//
//  TYSlidePageScrollView.m
//  TYSlidePageScrollViewDemo
//
//  Created by tanyang on 15/7/16.
//  Copyright (c) 2015年 tanyang. All rights reserved.
//

#import "TYSlidePageScrollView.h"
#import "UIScrollView+ty_swizzle.h"
#import "UIScrollView+MyRefresh.h"

//#define TFRefreshHeaderViewHeight 60

@interface TYSlidePageScrollView ()<UIScrollViewDelegate,CustomTitleViewDelegate>{
    struct {
        unsigned int horizenScrollToPageIndex   :1;
        unsigned int horizenScrollViewDidScroll :1;
        unsigned int horizenScrollViewDidEndDecelerating :1;
        unsigned int horizenScrollViewWillBeginDragging :1;
        unsigned int verticalScrollViewDidScroll :1;
        unsigned int pageTabBarScrollOffset :1;
    }_delegateFlags;
}
@property (nonatomic, weak) UIScrollView    *horScrollView;     // horizen scroll View
@property (nonatomic, weak) UIView          *headerContentView; // contain header and pageTab
@property (nonatomic, strong) NSArray       *pageViewArray;


@property (nonatomic, assign)BOOL isDownLoose;

@end

@implementation TYSlidePageScrollView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self setPropertys];
        
        [self addHorScrollView];
        
        [self addHeaderContentView];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        [self setPropertys];
        
        [self addHorScrollView];
        
        [self addHeaderContentView];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    _horScrollView.frame = self.bounds;
    for (UIView *view in _pageViewArray) {
        [UIView animateWithDuration:0.5 animations:^{
            view.height = self.height;
        }];
    }
}

#pragma mark - setter getter

- (void)setPropertys
{
    _curPageIndex = 0;
//    _pageTabBarStopOnTopHeight = 0;
    _pageTabBarIsStopOnTop = YES;
    _automaticallyAdjustsScrollViewInsets = NO;
    _changeToNextIndexWhenScrollToWidthOfPercent = 0.5;
}

- (void)resetPropertys
{
    [self addPageViewKeyPathOffsetWithOldIndex:_curPageIndex newIndex:-1];
    _curPageIndex = 0;
    [_headerContentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [_footerView removeFromSuperview];
    [_pageViewArray makeObjectsPerformSelector:@selector(removeFromSuperview)];
}

- (UIViewController *)viewController
{
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController*)nextResponder;
        }
    }
    return nil;
}

- (void)setTyDelegate:(id<TYSlidePageScrollViewDelegate>)tyDelegate
{
    _tyDelegate = tyDelegate;
    
    _delegateFlags.horizenScrollToPageIndex = [tyDelegate respondsToSelector:@selector(slidePageScrollView:horizenScrollToPageIndex:)];
    _delegateFlags.horizenScrollViewDidScroll = [tyDelegate respondsToSelector:@selector(slidePageScrollView:horizenScrollViewDidScroll:)];
    _delegateFlags.horizenScrollViewDidEndDecelerating = [tyDelegate respondsToSelector:@selector(slidePageScrollView:horizenScrollViewDidEndDecelerating:)];
    _delegateFlags.horizenScrollViewWillBeginDragging = [tyDelegate respondsToSelector:@selector(slidePageScrollView:horizenScrollViewWillBeginDragging:)];
    _delegateFlags.verticalScrollViewDidScroll = [tyDelegate respondsToSelector:@selector(slidePageScrollView:verticalScrollViewDidScroll:)];
    _delegateFlags.pageTabBarScrollOffset = [tyDelegate respondsToSelector:@selector(slidePageScrollView:pageTabBarScrollOffset:state:)];
}


#pragma mark - add subView

- (void)addHorScrollView
{
    UIScrollView *scrollView = [[UIScrollView alloc]init];
    scrollView.backgroundColor = RGBCOLOR_I(240, 240, 240);
    scrollView.delegate = self;
    scrollView.pagingEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    //水平的取消置顶
    scrollView.scrollsToTop = NO;
    
    [self addSubview:scrollView];
    scrollView.clipsToBounds = YES;
    _horScrollView = scrollView;
}

- (void)addHeaderContentView
{
    self.clipsToBounds = YES;
    UIView *headerContentView = [[UIView alloc]init];
    [self addSubview:headerContentView];
    _headerContentView = headerContentView;
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panClick:)];
    [headerContentView addGestureRecognizer:pan];
}

#pragma mark - private method

- (void)setViewControllerAdjustsScrollView
{
    UIViewController *viewController = [self viewController];
    if ([viewController respondsToSelector:@selector(automaticallyAdjustsScrollViewInsets)]) {
        viewController.automaticallyAdjustsScrollViewInsets = _automaticallyAdjustsScrollViewInsets;
    }
}

- (void)updateHeaderContentView
{
    CGFloat viewWidth = CGRectGetWidth(self.frame);
    CGFloat headerContentViewHieght = 0;
    
    if (_headerView) {
        _headerView.frame = CGRectMake(0, 0, viewWidth, CGRectGetHeight(_headerView.frame));
        [_headerContentView addSubview:_headerView];
        headerContentViewHieght += CGRectGetHeight(_headerView.frame);
    }
    
    if (_pageTabBar) {
        _pageTabBar.customTitleViewDelegate = self;
        _pageTabBar.frame = CGRectMake(0, headerContentViewHieght, viewWidth, CGRectGetHeight(_pageTabBar.frame));
        [_headerContentView addSubview:_pageTabBar];
        headerContentViewHieght += CGRectGetHeight(_pageTabBar.frame);
    } 
    _headerContentView.frame = CGRectMake(0, 0, viewWidth, headerContentViewHieght);
}

- (void)updateFooterView
{
    if (_footerView) {
        CGFloat footerViewY = CGRectGetHeight(self.frame)-CGRectGetHeight(_footerView.frame);
        _footerView.frame = CGRectMake(0, footerViewY, CGRectGetWidth(self.frame), CGRectGetHeight(_footerView.frame));
        [self addSubview:_footerView];
    }
}

- (void)updatePageViews
{
    _horScrollView.frame = self.bounds;
    CGFloat viewWidth = CGRectGetWidth(self.frame);
    CGFloat viewHight = CGRectGetHeight(self.frame);
    CGFloat headerContentViewHieght = CGRectGetHeight(_headerContentView.frame);
    CGFloat footerViewHieght = CGRectGetHeight(_footerView.frame);
    NSInteger pageNum = [_tyDataSource numberOfPageViewOnSlidePageScrollView];
    NSMutableArray *scrollViewArray = [NSMutableArray arrayWithCapacity:pageNum];
    
    for (NSInteger index = 0; index < pageNum; ++index) {
        UIScrollView *pageVerScrollView = [_tyDataSource slidePageScrollView:self pageVerticalScrollViewForIndex:index];
        pageVerScrollView.frame = CGRectMake(index * viewWidth, 0, viewWidth, viewHight);
        pageVerScrollView.contentInset = UIEdgeInsetsMake(headerContentViewHieght, 0, footerViewHieght, 0);
        pageVerScrollView.scrollIndicatorInsets = UIEdgeInsetsMake(headerContentViewHieght, 0, footerViewHieght, 0);
        [_horScrollView addSubview:pageVerScrollView];
        
        [scrollViewArray addObject:pageVerScrollView];
        if (_curPageIndex == index) {
            pageVerScrollView.scrollsToTop = YES;
        } else {
            pageVerScrollView.scrollsToTop = NO;
        }
        
    }
    _pageViewArray = [scrollViewArray copy];
    _horScrollView.contentSize = CGSizeMake(viewWidth*pageNum, 0);
}

- (void)addPageViewKeyPathOffsetWithOldIndex:(NSInteger)oldIndex newIndex:(NSInteger)newIndex
{
    if (oldIndex == newIndex) {
        return;
    }
    
    if (oldIndex >= 0 && oldIndex < _pageViewArray.count) {
        [_pageViewArray[oldIndex] removeObserver:self forKeyPath:@"contentOffset" context:nil];
    }
    if (newIndex >= 0 && newIndex < _pageViewArray.count) {
        [_pageViewArray[newIndex] addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"contentOffset"]) {
        [self pageScrollViewDidScroll:object changeOtherPageViews:NO];
    }
}

- (CGFloat)scrollViewMinContentSizeHeight
{
    CGFloat viewHeight = CGRectGetHeight(self.frame);
    CGFloat pageTabBarHieght = CGRectGetHeight(_pageTabBar.frame);
    CGFloat footerHeight = CGRectGetHeight(_footerView.frame);
    
    NSInteger scrollMinContentSizeHeight = viewHeight - (pageTabBarHieght + _pageTabBarStopOnTopHeight + footerHeight);
    
    if (!_pageTabBarIsStopOnTop) {
        scrollMinContentSizeHeight = viewHeight - footerHeight;
    }
    return scrollMinContentSizeHeight;
}

- (void)dealPageScrollViewMinContentSize:(UIScrollView *)pageScrollView
{
    NSInteger scrollMinContentSizeHeight = [self scrollViewMinContentSizeHeight];
    pageScrollView.minContentSizeHeight = scrollMinContentSizeHeight;
    
    if (pageScrollView.contentSize.height < scrollMinContentSizeHeight) {
        pageScrollView.contentSize = CGSizeMake(pageScrollView.contentSize.width, scrollMinContentSizeHeight);
    }
}

- (void)dealAllPageScrollViewMinContentSize
{
    [_pageViewArray enumerateObjectsUsingBlock:^(UIScrollView *obj, NSUInteger idx, BOOL *stop) {
        [self dealPageScrollViewMinContentSize:obj];
    }];
}

- (void)changeAllPageScrollViewOffsetY:(CGFloat)offsetY isOnTop:(BOOL)isOnTop
{
    [_pageViewArray enumerateObjectsUsingBlock:^(UIScrollView *pageScrollView, NSUInteger idx, BOOL *stop) {
        if (idx != _curPageIndex && !(isOnTop && pageScrollView.contentOffset.y > offsetY)) {

            [pageScrollView setContentOffset:CGPointMake(pageScrollView.contentOffset.x, offsetY)];
        }
    }];
}

- (void)resetPageScrollViewContentOffset
{
    if (_curPageIndex >= 0 && _curPageIndex < _pageViewArray.count) {
        UIScrollView *pagescrollView = _pageViewArray[_curPageIndex];
        pagescrollView.contentOffset = CGPointMake(pagescrollView.contentOffset.x, -CGRectGetHeight(_headerContentView.frame));
    }
}

#pragma mark - public method

- (void)reloadData
{
    [self resetPropertys];
    
    [self setViewControllerAdjustsScrollView];
    
    [self updateHeaderContentView];
    
    [self updateFooterView];
    
    [self updatePageViews];
    
    [self addPageViewKeyPathOffsetWithOldIndex:-1 newIndex:_curPageIndex];
    
    [self dealAllPageScrollViewMinContentSize];
    
    [self resetPageScrollViewContentOffset];
}


- (UIScrollView *)pageScrollViewForIndex:(NSInteger)index
{
    if (index < 0 || index >= _pageViewArray.count) {
        //pageScrollViewForIndex index illegal");
        return nil;
    }
    
    return _pageViewArray[index];
}

- (NSInteger)indexOfPageScrollView:(UIScrollView *)pageScrollView
{
    return [_pageViewArray indexOfObject:pageScrollView];
}

#pragma mark - delegate
// horizen scrollView
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if (_delegateFlags.horizenScrollViewWillBeginDragging) {
        [_tyDelegate slidePageScrollView:self horizenScrollViewWillBeginDragging:scrollView];
    }
    
//    [self pageScrollViewDidScroll:_pageViewArray[_curPageIndex] changeOtherPageViews:YES];
}

// horizen scrollView
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    if (_delegateFlags.horizenScrollViewDidScroll) {
        [_tyDelegate slidePageScrollView:self horizenScrollViewDidScroll:_horScrollView];
    }
    
    NSInteger index = (NSInteger)(scrollView.contentOffset.x/CGRectGetWidth(scrollView.frame) + _changeToNextIndexWhenScrollToWidthOfPercent);
    
    if (_curPageIndex != index) {
        if (index >= _pageViewArray.count) {
            index = _pageViewArray.count-1;
        }
        if (index < 0) {
            index = 0;
        }
        
        // 加
        [self pageScrollViewDidScroll:_pageViewArray[_curPageIndex] changeOtherPageViews:YES];
        
        [self addPageViewKeyPathOffsetWithOldIndex:_curPageIndex newIndex:index];
        _curPageIndex = index;
        
        
        if (_pageTabBar) {
            [_pageTabBar switchToPageIndex:(int)_curPageIndex];
        }
        if (_delegateFlags.horizenScrollToPageIndex) {
            [_tyDelegate slidePageScrollView:self horizenScrollToPageIndex:_curPageIndex];
            
        }
        
        // 加
        NSInteger pageNum = [_tyDataSource numberOfPageViewOnSlidePageScrollView];
        for (NSInteger newIndex = 0; newIndex < pageNum; ++newIndex) {
            UIScrollView *pageVerScrollView = [_tyDataSource slidePageScrollView:self pageVerticalScrollViewForIndex:newIndex];
            
            if (_curPageIndex == newIndex) {
                pageVerScrollView.scrollsToTop = YES;
            } else {
                pageVerScrollView.scrollsToTop = NO;
            }
            
        }
        
    }
    
}

- (BOOL)scrollToPageIndex:(NSInteger)index animated:(BOOL)animated
{
    //    NSLog(@"_headerContentView: %@", _headerContentView);
    if (index < 0 || index >= _pageViewArray.count) {
        NSLog(@"scrollToPageIndex index illegal");
        return NO;
    }
    
//    [self pageScrollViewDidScroll:_pageViewArray[_curPageIndex] changeOtherPageViews:YES];
    
    //使用自己的动画
//    [UIView animateWithDuration:0.15 animations:^{
//
//    }];
    
    [_horScrollView setContentOffset:CGPointMake(index * CGRectGetWidth(_horScrollView.frame), 0) animated:animated];
    
//    /**********************/
//    [self addPageViewKeyPathOffsetWithOldIndex:_curPageIndex newIndex:index];
//    _curPageIndex = index;
    
//    if (_delegateFlags.horizenScrollToPageIndex) {
//        [_tyDelegate slidePageScrollView:self horizenScrollToPageIndex:_curPageIndex];
//    }
    
    
//    NSInteger pageNum = [_tyDataSource numberOfPageViewOnSlidePageScrollView];
//    for (NSInteger newIndex = 0; newIndex < pageNum; ++newIndex) {
//        UIScrollView *pageVerScrollView = [_tyDataSource slidePageScrollView:self pageVerticalScrollViewForIndex:newIndex];
//        
//        if (_curPageIndex == newIndex) {
//            pageVerScrollView.scrollsToTop = YES;
//        } else {
//            pageVerScrollView.scrollsToTop = NO;
//        }
//        
//    }
    
    return YES;
}

// page scrollView
- (void)pageScrollViewDidScroll:(UIScrollView *)pageScrollView changeOtherPageViews:(BOOL)isNeedChange
{
    if (_delegateFlags.verticalScrollViewDidScroll) {
        [_tyDelegate slidePageScrollView:self verticalScrollViewDidScroll:pageScrollView];
    }
    
    CGFloat headerContentViewheight = CGRectGetHeight(_headerContentView.frame);
    CGFloat pageTabBarHieght = CGRectGetHeight(_pageTabBar.frame);
    
    CGFloat pageTabBarIsStopOnTop = _pageTabBarStopOnTopHeight;
    if (!_pageTabBarIsStopOnTop) {
        pageTabBarIsStopOnTop = - pageTabBarHieght;
    }
    
    CGFloat viewWidth = CGRectGetWidth(self.frame);
    CGFloat offsetY = pageScrollView.contentOffset.y;
    
    if ((int)offsetY <=(int) (-headerContentViewheight)) {
        
        CGFloat subY = -offsetY-headerContentViewheight;
        // headerContentView full show
        CGRect frame = CGRectMake(0, subY, viewWidth, headerContentViewheight);
        //
        if (!CGRectEqualToRect(_headerContentView.frame, frame)) {
            _headerContentView.frame = frame;
            
            if (_delegateFlags.pageTabBarScrollOffset) {
                [_tyDelegate slidePageScrollView:self pageTabBarScrollOffset:offsetY state:TYPageTabBarStateStopOnButtom];
            }
        }
        
        if (isNeedChange) {
            [self changeAllPageScrollViewOffsetY:-headerContentViewheight isOnTop:NO];
        }
    } else if (-1*ceil(-1*offsetY) < -1*ceil(pageTabBarHieght+pageTabBarIsStopOnTop)) {
        // scroll headerContentView
        
        CGRect frame = CGRectMake(0, -(offsetY+headerContentViewheight), viewWidth, headerContentViewheight);
        _headerContentView.frame = frame;
        if (_delegateFlags.pageTabBarScrollOffset) {
            [_tyDelegate slidePageScrollView:self pageTabBarScrollOffset:offsetY state:TYPageTabBarStateScrolling];
        }
        
        if (isNeedChange) {
            [self changeAllPageScrollViewOffsetY:pageScrollView.contentOffset.y isOnTop:NO];
        }
        
    } else {
        // pageTabBar on the top
        CGRect frame = CGRectMake(0, -headerContentViewheight+pageTabBarHieght + pageTabBarIsStopOnTop, viewWidth, headerContentViewheight);
        
        if (!CGRectEqualToRect(_headerContentView.frame, frame)) {
            _headerContentView.frame = frame;
            
            if (_delegateFlags.pageTabBarScrollOffset) {
                [_tyDelegate slidePageScrollView:self pageTabBarScrollOffset:offsetY state:TYPageTabBarStateStopOnTop];
            }
        }
        
        if (isNeedChange) {
            [self changeAllPageScrollViewOffsetY:-pageTabBarHieght-pageTabBarIsStopOnTop isOnTop:YES];
        }
    }
    
    
    
    if (_headerContentView.frame.origin.y>20) {
        _horScrollView.scrollEnabled = NO;
    } else {
        _horScrollView.scrollEnabled = YES;
    }
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    //    //左右停止滚动");
    if (_delegateFlags.horizenScrollViewDidEndDecelerating) {
        [_tyDelegate slidePageScrollView:self horizenScrollViewDidEndDecelerating:_horScrollView];
    }
    
    
//    NSInteger index = (NSInteger)(scrollView.contentOffset.x/CGRectGetWidth(scrollView.frame) + _changeToNextIndexWhenScrollToWidthOfPercent);
//    
//    if (_curPageIndex != index) {
//        if (index >= _pageViewArray.count) {
//            index = _pageViewArray.count-1;
//        }
//        if (index < 0) {
//            index = 0;
//        }
//        
//        [self addPageViewKeyPathOffsetWithOldIndex:_curPageIndex newIndex:index];
//        
//        _curPageIndex = index;
//        
//        if (_pageTabBar) {
//            [_pageTabBar switchToPageIndex:(int)_curPageIndex];
//        }
//        if (_delegateFlags.horizenScrollToPageIndex) {
//            [_tyDelegate slidePageScrollView:self horizenScrollToPageIndex:_curPageIndex];
//        }
//    }
//    
//    //点击状态栏置顶
//    NSInteger pageNum = [_tyDataSource numberOfPageViewOnSlidePageScrollView];
//    //    NSMutableArray *scrollViewArray = [NSMutableArray arrayWithCapacity:pageNum];
//    for (NSInteger newIndex = 0; newIndex < pageNum; ++newIndex) {
//        UIScrollView *pageVerScrollView = [_tyDataSource slidePageScrollView:self pageVerticalScrollViewForIndex:newIndex];
//        
//        if (_curPageIndex == newIndex) {
//            pageVerScrollView.scrollsToTop = YES;
//            //            //%d置顶", (int)newIndex);
//        } else {
//            pageVerScrollView.scrollsToTop = NO;
//        }
//        
//    }
//    
    
}


- (BOOL)selectEndWithView:(CustomTitleView *)cusTomTitleView withBtnIndex:(int)index
{
    if ([self.tyDelegate respondsToSelector:@selector(selectTitleViewWithBtnIndex:)]) {
        return [self.tyDelegate selectTitleViewWithBtnIndex:index];
    }else
        return [self scrollToPageIndex:index animated:YES];
}

- (void)panClick:(UIPanGestureRecognizer *)sender
{
    CGPoint translation = [sender translationInView:self];

    
    if (translation.y>=0 && sender.state == UIGestureRecognizerStateChanged) {
        
        UIScrollView *pageScrollView ;
       
        if(_pageViewArray.count)
        {
            pageScrollView = _pageViewArray[_curPageIndex];
        }
        CGPoint offset = CGPointMake(pageScrollView.contentOffset.x, pageScrollView.contentOffset.y-translation.y);
        
        if (offset.y<-CGRectGetHeight(_headerContentView.frame)-80) {
            if (offset.y<-CGRectGetHeight(_headerContentView.frame)-160) {
                pageScrollView.isLoosen = [NSNumber numberWithBool:NO];
                return;
            } else {
                pageScrollView.isLoosen = [NSNumber numberWithBool:NO];
                pageScrollView.contentOffset = CGPointMake(pageScrollView.contentOffset.x, pageScrollView.contentOffset.y-translation.y/5.0);
            }
        } else {
            pageScrollView.isLoosen = [NSNumber numberWithBool:NO];
            pageScrollView.contentOffset = offset;
        }
    }
    
    if (sender.state == UIGestureRecognizerStateEnded) {
        
        UIScrollView *pageScrollView ;
        
        if(_pageViewArray.count)
        {
            pageScrollView = _pageViewArray[_curPageIndex];
        }

        CGPoint offset = pageScrollView.contentOffset;
        CGFloat headHeight = (int)CGRectGetHeight(_headerContentView.frame);
        if (offset.y>-headHeight-TFRefreshHeaderViewHeight && offset.y<=-headHeight) {
            pageScrollView.isLoosen = [NSNumber numberWithBool:YES];
            [UIView animateWithDuration:0.5 animations:^{
                pageScrollView.contentOffset = CGPointMake(pageScrollView.contentOffset.x, -headHeight);;
            }];
        } else if (offset.y<=-headHeight-TFRefreshHeaderViewHeight) {
            pageScrollView.isLoosen = [NSNumber numberWithBool:YES];
            [UIView animateWithDuration:0.5 animations:^{
                pageScrollView.contentOffset = CGPointMake(pageScrollView.contentOffset.x, -headHeight-TFRefreshHeaderViewHeight);
            }];
            

            
        }
    }
    if (translation.y<0 && sender.state == UIGestureRecognizerStateChanged) {
        UIScrollView *pageScrollView = _pageViewArray[_curPageIndex];
        
        
        CGPoint offset = CGPointMake(pageScrollView.contentOffset.x, pageScrollView.contentOffset.y-translation.y);
        pageScrollView.contentOffset = offset;
    }
    
    [sender setTranslation:CGPointZero inView:self];
}

-(void)dealloc
{
    [self resetPropertys];
}

@end
