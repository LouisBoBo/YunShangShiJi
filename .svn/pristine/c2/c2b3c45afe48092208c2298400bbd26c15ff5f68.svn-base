//
//  MJPhotoBrowser.m
//
//  Created by mj on 13-3-4.
//  Copyright (c) 2013年 itcast. All rights reserved.

#import <QuartzCore/QuartzCore.h>
#import "CFPhotoBrowser.h"
#import "MJPhoto.h"
#import "SDWebImageManager+MJ.h"
#import "MJPhotoView.h"
#import "MJPhotoToolbar.h"


#import "GlobalTool.h"
#import "BaseModel.h"

#define kKeyWindow [UIApplication sharedApplication].keyWindow
#define kPadding 10
#define kPhotoViewTagOffset 1000
#define kPhotoViewIndex(photoView) ([photoView tag] - kPhotoViewTagOffset)
#define kScreen_Bounds [UIScreen mainScreen].bounds



@interface CFPersonPhoto : BaseModel
@property (nonatomic,strong)NSString *content;
@property (nonatomic,strong)NSString *pic;
@property (nonatomic,strong)NSNumber *theme_id;
@property (nonatomic,strong)NSNumber *theme_type;//1.精选推荐  2.穿搭   3.普通话题
@property (nonatomic,strong)NSString *title;
@property (nonatomic,strong)NSNumber *user_id;
@property (nonatomic,strong)NSDictionary *shop_list;
@end

@implementation CFPersonPhoto

@end



@interface CFPhotoBrowser () <MJPhotoViewDelegate>
@property (strong, nonatomic) UIView *view;
@property (strong, nonatomic) UIScrollView *photoScrollView;
@property (strong, nonatomic) NSMutableSet *visiblePhotoViews, *reusablePhotoViews;
@property (strong, nonatomic) MJPhotoToolbar *toolbar;

@property (nonatomic,strong)UILabel *headLabel;
@property (nonatomic,strong)UIView  *footView;
@property (nonatomic,strong)UILabel *footLabel;
@property (nonatomic,strong)UIButton *footBtn;

@end

@implementation CFPhotoBrowser

#pragma mark - init M

- (instancetype)init
{
    self = [super init];
    if (self) {
        _showSaveBtn = YES;
    }
    return self;
}

#pragma mark - get M

- (UIView *)view{
    if (!_view) {
        _view = [[UIView alloc] initWithFrame:kScreen_Bounds];
        _view.backgroundColor = [UIColor blackColor];
    }
    return _view;
}

- (UIScrollView *)photoScrollView{
    if (!_photoScrollView) {
        CGRect frame = self.view.bounds;
        frame.origin.x -= kPadding;
        frame.size.width += (2 * kPadding);
        _photoScrollView = [[UIScrollView alloc] initWithFrame:frame];
        _photoScrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _photoScrollView.pagingEnabled = YES;
        _photoScrollView.delegate = self;
        _photoScrollView.showsHorizontalScrollIndicator = NO;
        _photoScrollView.showsVerticalScrollIndicator = NO;
        _photoScrollView.backgroundColor = [UIColor clearColor];
    }
    return _photoScrollView;
}

- (MJPhotoToolbar *)toolbar{
    if (!_toolbar) {
        CGFloat barHeight = 49;
        CGFloat barY = self.view.frame.size.height - barHeight;
        _toolbar = [[MJPhotoToolbar alloc] init];
        _toolbar.showSaveBtn = _showSaveBtn;
        _toolbar.frame = CGRectMake(0, barY, self.view.frame.size.width, barHeight);
        _toolbar.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    }
    return _toolbar;
}

- (void)show:(UIView *)view
{

//    [kKeyWindow endEditing:YES];
    
    //初始化数据
    {
        if (!_visiblePhotoViews) {
            _visiblePhotoViews = [NSMutableSet set];
        }
        if (!_reusablePhotoViews) {
            _reusablePhotoViews = [NSMutableSet set];
        }
        self.toolbar.photos = self.photos;
        
        
        CGRect frame = self.view.bounds;
        frame.origin.x -= kPadding;
        frame.size.width += (2 * kPadding);
        self.photoScrollView.contentSize = CGSizeMake(frame.size.width * self.photos.count, 0);
        self.photoScrollView.contentOffset = CGPointMake(self.currentPhotoIndex * frame.size.width, 0);
        
        [self.view addSubview:self.photoScrollView];
//        [self.view addSubview:self.toolbar];
        
        [self.view addSubview:self.headLabel];
        [self.view addSubview:self.footView];
        [self changeInfo];
        
        [self updateTollbarState];
        [self showPhotos];
    }
    //渐变显示
    self.view.alpha = 0;
    [view addSubview:self.view];
    [UIView animateWithDuration:0.3 animations:^{
        self.view.alpha = 1.0;
    } completion:^(BOOL finished) {
//        [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationFade];
    }];
}

#pragma mark - set M
- (void)setPhotos:(NSArray *)photos
{
    _photos = photos;
    if (_photos.count <= 0) {
        return;
    }
    for (int i = 0; i<_photos.count; i++) {
        MJPhoto *photo = _photos[i];
        photo.index = i;
    }
}

- (void)setCurrentPhotoIndex:(NSUInteger)currentPhotoIndex
{
    _currentPhotoIndex = currentPhotoIndex;
    
    if (_photoScrollView) {
        _photoScrollView.contentOffset = CGPointMake(_currentPhotoIndex * _photoScrollView.frame.size.width, 0);
        
        // 显示所有的相片
        [self showPhotos];
    }
}

#pragma mark - Show Photos
- (void)showPhotos
{
    CGRect visibleBounds = _photoScrollView.bounds;
    int firstIndex = (int)floorf((CGRectGetMinX(visibleBounds)+kPadding*2) / CGRectGetWidth(visibleBounds));
    int lastIndex  = (int)floorf((CGRectGetMaxX(visibleBounds)-kPadding*2-1) / CGRectGetWidth(visibleBounds));
    if (firstIndex < 0) firstIndex = 0;
    if (firstIndex >= _photos.count) firstIndex = (int)_photos.count - 1;
    if (lastIndex < 0) lastIndex = 0;
    if (lastIndex >= _photos.count) lastIndex = (int)_photos.count - 1;
    
    // 回收不再显示的ImageView
    NSInteger photoViewIndex;
    for (MJPhotoView *photoView in _visiblePhotoViews) {
        photoViewIndex = kPhotoViewIndex(photoView);
        if (photoViewIndex < firstIndex || photoViewIndex > lastIndex) {
            [_reusablePhotoViews addObject:photoView];
            [photoView removeFromSuperview];
        }
    }
    
    [_visiblePhotoViews minusSet:_reusablePhotoViews];
    while (_reusablePhotoViews.count > 2) {
        [_reusablePhotoViews removeObject:[_reusablePhotoViews anyObject]];
    }
    
    for (NSUInteger index = firstIndex; index <= lastIndex; index++) {
        if (![self isShowingPhotoViewAtIndex:index]) {
            [self showPhotoViewAtIndex:(int)index];
        }
    }
    
}

//  显示一个图片view
- (void)showPhotoViewAtIndex:(int)index
{
    MJPhotoView *photoView = [self dequeueReusablePhotoView];
    if (!photoView) { // 添加新的图片view
        photoView = [[MJPhotoView alloc] init];
        photoView.photoViewDelegate = self;
    }
    
    // 调整当前页的frame
    CGRect bounds = _photoScrollView.bounds;
    CGRect photoViewFrame = bounds;
    photoViewFrame.size.width -= (2 * kPadding);
    photoViewFrame.origin.x = (bounds.size.width * index) + kPadding;
    photoView.tag = kPhotoViewTagOffset + index;
    
    MJPhoto *photo = _photos[index];
    photoView.frame = photoViewFrame;
    photoView.photo = photo;
    
    [_visiblePhotoViews addObject:photoView];
    [_photoScrollView addSubview:photoView];
    
    [self loadImageNearIndex:index];
}

//  加载index附近的图片
- (void)loadImageNearIndex:(int)index
{
    if (index > 0) {
        MJPhoto *photo = _photos[index - 1];
        [SDWebImageManager downloadWithURL:photo.url];
    }
    
    if (index < _photos.count - 1) {
        MJPhoto *photo = _photos[index + 1];
        [SDWebImageManager downloadWithURL:photo.url];
    }
}

//  index这页是否正在显示
- (BOOL)isShowingPhotoViewAtIndex:(NSUInteger)index {
    for (MJPhotoView *photoView in _visiblePhotoViews) {
        if (kPhotoViewIndex(photoView) == index) {
            return YES;
        }
    }
    return  NO;
}
// 重用页面
- (MJPhotoView *)dequeueReusablePhotoView
{
    MJPhotoView *photoView = [_reusablePhotoViews anyObject];
    if (photoView) {
        [_reusablePhotoViews removeObject:photoView];
    }
    return photoView;
}

#pragma mark - updateTollbarState
- (void)updateTollbarState
{
    _currentPhotoIndex = _photoScrollView.contentOffset.x / _photoScrollView.frame.size.width;
    _toolbar.currentPhotoIndex = _currentPhotoIndex;
}



#pragma mark - MJPhotoViewDelegate
- (void)photoViewSingleTap:(MJPhotoView *)photoView
{
//    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationNone];
    // 移除工具条
    [self.toolbar removeFromSuperview];
    
    [UIView animateWithDuration:0.15 animations:^{
        self.view.alpha = 0;
        if (self.dismissBlock) {
            self.dismissBlock();
        }
    } completion:^(BOOL finished) {
        
        [self.view removeFromSuperview];
    }];
    
    
}

- (void)photoViewImageFinishLoad:(MJPhotoView *)photoView
{
    [self updateTollbarState];
}

#pragma mark - UIScrollView Delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self showPhotos];
    [self updateTollbarState];
    [self changeInfo];
}


- (UIButton *)footBtn {
    if (_footBtn==nil) {
        _footBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        _footBtn.frame=CGRectMake(kScreenWidth-ZOOM6(200), ZOOM6(20), ZOOM6(180), ZOOM6(100)-ZOOM6(40));
        [_footBtn setBackgroundColor:tarbarrossred];
        [_footBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        //        [_footBtn setTitle:@"查看详情" forState:UIControlStateNormal];
        [_footBtn.titleLabel setFont:[UIFont systemFontOfSize:ZOOM6(30)]];
        [_footBtn handleClickEvent:UIControlEventTouchUpInside withClickBlock:^(UIButton *sender) {
            if (self.footBtnClick) {
                self.footBtnClick(self.currentPhotoIndex);
            }
//            PersonPhoto *model=self.modelArray[self.index];
//            if (model.theme_type.integerValue==1) {
//                ShopDetailViewController *shopdetail = [[ShopDetailViewController alloc]init];
//                shopdetail.shop_code = model.shop_list[@"shop_code"];
//                shopdetail.theme_id = [model.theme_id stringValue];
//                shopdetail.stringtype = @"订单详情";
//                [self.navigationController pushViewController:shopdetail animated:YES];
//            }else{
//                TopicdetailsViewController *topic = [[TopicdetailsViewController alloc]init];
//                topic.theme_id = [NSString stringWithFormat:@"%@",model.theme_id];
//                [self.navigationController pushViewController:topic animated:YES];
//            }
        }];
        _footBtn.layer.cornerRadius=3;
    }
    return _footBtn;
}
- (UILabel *)footLabel {
    if (_footLabel==nil) {
        _footLabel=[[UILabel alloc]initWithFrame:CGRectMake(ZOOM6(20), 0, kScreenWidth-ZOOM6(220), ZOOM6(100))];
        _footLabel.textColor=[UIColor whiteColor];
        _footLabel.textAlignment=NSTextAlignmentLeft;
        _footLabel.numberOfLines=2;
        _footLabel.font=[UIFont systemFontOfSize:ZOOM6(30)];
        
    }
    return _footLabel;
}
- (UIView *)footView {
    if (_footView==nil) {
        _footView=[[UIView alloc]initWithFrame:CGRectMake(0, kScreenHeight-ZOOM6(100), kScreenWidth, ZOOM6(100))];
        _footView.backgroundColor=[[UIColor blackColor]colorWithAlphaComponent:0.5];
        [_footView addSubview:self.footLabel];
        [_footView addSubview:self.footBtn];
    }
    return _footView;
}
- (UILabel *)headLabel {
    if (_headLabel==nil) {
        _headLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, ZOOM6(100))];
        _headLabel.textColor=[UIColor whiteColor];
        _headLabel.backgroundColor=[[UIColor blackColor]colorWithAlphaComponent:0.5];
        _headLabel.textAlignment=NSTextAlignmentCenter;
        _headLabel.text=[NSString stringWithFormat:@"%zd / %zd",_currentPhotoIndex+1,self.photos.count];
    }
    return _headLabel;
}
- (void)changeInfo {
    
    self.headLabel.text=[NSString stringWithFormat:@"%zd / %zd",self.currentPhotoIndex+1,self.modelArray.count];
    
    CFPersonPhoto *model=self.modelArray[self.currentPhotoIndex];
    
    if (model.theme_type.integerValue==1) {
        NSString *title=[model.shop_list[@"shop_name"] length]>10?[NSString stringWithFormat:@"%@...",[model.shop_list[@"shop_name"] substringToIndex:10]]:model.shop_list[@"shop_name"];
        NSString *price=[NSString stringWithFormat:@"¥%.2f",[model.shop_list[@"shop_price"]doubleValue] ];
        NSString *allStr=[NSString stringWithFormat:@"%@\n¥%.2f %@",title,[model.shop_list[@"shop_se_price"] doubleValue],price];
        
        NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:allStr];
        NSMutableDictionary *stringDict = [NSMutableDictionary dictionary];
        NSRange stringRange = [allStr rangeOfString:price];
        [stringDict setObject:[UIFont systemFontOfSize:ZOOM6(25)] forKey:NSFontAttributeName];
        [stringDict setObject:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle) forKey:NSStrikethroughStyleAttributeName];
        [attri setAttributes:stringDict range:stringRange];
        [self.footLabel setAttributedText:attri];
        
        [_footBtn setTitle:@"立即购买" forState:UIControlStateNormal];
        _footBtn.backgroundColor = [model.shop_list[@"shop_status"] integerValue]==2?tarbarrossred:kbackgrayColor;
        _footBtn.userInteractionEnabled = [model.shop_list[@"shop_status"] integerValue]==2;
    }else{
        if (model.theme_type.integerValue==2) {
            NSString *title=[NSString stringWithFormat:@"#%@#",model.title.length>10?[NSString stringWithFormat:@"%@...",[model.title substringToIndex:10]]:model.title];
            [self.footLabel setAttributedText:[NSString getOneColorInLabel:[NSString stringWithFormat:@"%@\n%@",title,model.content] ColorString:title Color:tarbarrossred fontSize:ZOOM6(30)]];
        }else
            self.footLabel.text=model.content;
        [_footBtn setTitle:@"查看详情" forState:UIWindowLevelNormal];
        _footBtn.backgroundColor=tarbarrossred;
        _footBtn.userInteractionEnabled=YES;
    }
}
@end
