//
//  ScrollView_public.m
//  FDC
//
//  Created by wzz on 15/2/6.
//  Copyright (c) 2015年 JinZongCai. All rights reserved.
//

#import "ScrollView_public.h"
#import "GlobalTool.h"
#import "UIImageView+WebCache.h"
@interface ScrollView_public ()<UIScrollViewDelegate>{
    
    
    UIImageView *leftImageView;
    UIImageView *centerImageView;
    UIImageView *rightImageView;
    BOOL isshouye;
    NSInteger CurrectPage;
}

@property (nonatomic, strong) NSTimer *animationTimer;
@property (nonatomic, assign) NSTimeInterval animationDuration;

@end

@implementation ScrollView_public

- (instancetype)initWithFrame:(CGRect)frame pictures:(NSArray*)PictureArray animationDuration:(NSTimeInterval)animationDuration contentMode_style:(contentModestyle)style Haveshiping:(BOOL)haveshiping {
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
       
//        self.scrollview = [[UIScrollView alloc]initWithFrame:frame];
        self.scrollview = [[UIScrollView alloc]initWithFrame:self.bounds];
        self.scrollview.bounces = NO;
        self.scrollview.showsHorizontalScrollIndicator = NO;
        self.scrollview.showsVerticalScrollIndicator = NO;
        self.scrollview.delegate = self;
        self.scrollview.pagingEnabled = YES;
        self.scrollview.clipsToBounds = YES;
        self.scrollview.directionalLockEnabled = YES;
        [self addSubview:self.scrollview];
        
        if (!PictureArray.count) {
            return self;
        }
        
        
        self.pictureArray = [PictureArray mutableCopy];
        
         NSMutableArray *newpictureArray = [@[] mutableCopy];
        if ([PictureArray.firstObject isKindOfClass:[NSDictionary class]]) {
            isshouye=YES;
           
            for (int i = 0; i< PictureArray.count; i++) {
                [newpictureArray addObject:PictureArray[i][@"img"]];
            }
            PictureArray=[NSArray arrayWithArray:newpictureArray];
        }

        if (PictureArray.count) {
            if (PictureArray.count == 1) {
                UIImageView *imageview = [[UIImageView alloc] init];
                
                CGRect rect = self.bounds;
                rect.origin.x = self.frame.size.width*0;
                imageview.frame = rect;
                
                
                if ([PictureArray[0] isKindOfClass:[NSString class]]) {
                    
                    NSURL *imgUrl = [NSURL URLWithString:PictureArray[0]];
                    //
                    __block float d = 0;
                    __block BOOL isDownlaod = NO;
                    [imageview sd_setImageWithURL:imgUrl placeholderImage:[UIImage imageDefaultWithSize:CGSizeMake(imageview.size.width, imageview.size.height) compress:0.3] options:SDWebImageRetryFailed progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                        d = (float)receivedSize/expectedSize;
                        isDownlaod = YES;
                    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                        if (image != nil && isDownlaod == YES) {
                            imageview.alpha = 0;
                            [UIView animateWithDuration:0.5 animations:^{
                                imageview.alpha = 1;
                            } completion:^(BOOL finished) {
                            }];
                        } else if (image != nil && isDownlaod == NO) {
                            imageview.image = image;
                        }
                    }];
                } else if([PictureArray[0] isKindOfClass:[UIImage class]]){
                    
                    imageview.image = PictureArray[0];
                    
                    
                } else if([PictureArray[0] isKindOfClass:[UIImageView class]]){
                    
                    UIImageView *iv = (UIImageView *)PictureArray[0];
                    imageview.image = iv.image;

                    
                }
                
                imageview.userInteractionEnabled = YES;
   
                switch (style) {
                    case Fill_contentModestyle:
                        imageview.contentMode = UIViewContentModeScaleAspectFill;
                        break;
                    case Fit_contentModestyle:
                    {
                        imageview.contentMode = UIViewContentModeScaleAspectFit;
                        //                        {top, left, bottom, right};
                        UIImage *image1=   [imageview.image resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, imageview.bounds.size.height-10) resizingMode:UIImageResizingModeStretch];
                        imageview.image = image1;
                        imageview.contentMode = UIViewContentModeScaleToFill;
                        
                        
                    }
                        break;
                    default:
                        imageview.contentMode = UIViewContentModeScaleToFill;
                        break;
                }
                
                
                UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick)];
                [imageview addGestureRecognizer:tap];
                
                

                self.scrollview.contentOffset = CGPointMake(0, 0);
                self.scrollview.contentSize = CGSizeMake(self.frame.size.width, self.frame.size.height);
                [self.scrollview addSubview:imageview];
                
            } else {
                

                if (!self.pageControl) {

                    
                    self.pageControl = [[TaoTaoPageControl alloc] initWithFrame:CGRectMake(0, frame.size.height-15, frame.size.width, 15)];
                    self.pageControl.indicatorDiameter = 7.0f;
                    self.pageControl.currentPage = 0;
                    self.pageControl.numberOfPages = PictureArray.count;
                    self.pageControl.currentPageIndicatorTintColor = tarbarrossred;
                    self.pageControl.pageIndicatorTintColor = kTextColor;
                    [self addSubview:self.pageControl];
                    
                    if (PictureArray.count==1) {
                        self.pageControl.numberOfPages = 0;
                    }
                    if (isshouye) {
                        
                        self.pageControl.indicatorMargin = 4.0f;
                        self.pageControl.backgroundColor=[UIColor clearColor];
                        self.pageControl.frame = Frame(frame.size.width-PictureArray.count*11-7, frame.size.height-30, PictureArray.count*11, 30);
                    }
                }
                
                
                id FirstStr = PictureArray.lastObject;
                id lastStr = PictureArray.firstObject;
                
                
                NSMutableArray* pictureArray_M = [[NSMutableArray alloc]initWithArray:PictureArray];
                
                [pictureArray_M insertObject:FirstStr atIndex:0];
                [pictureArray_M addObject:lastStr];
                
                self.scrollview.contentSize = CGSizeMake(pictureArray_M.count*self.frame.size.width, self.frame.size.height);
                
                //            //pictureArray_M = %@", pictureArray_M);
                
                for (int i = 0; i<pictureArray_M.count; i++) {
                    
                    UIImageView *imageview = [[UIImageView alloc] init];
                    
                    CGRect rect = self.bounds;
                    rect.origin.x = i*self.frame.size.width;
                    imageview.frame = rect;
                    
                    if ([pictureArray_M[i] isKindOfClass:[NSString class]]) {

                        
                        NSURL *imgUrl = [NSURL URLWithString:pictureArray_M[i]];
                        
                        __block float d = 0;
                        __block BOOL isDownlaod = NO;
                        [imageview sd_setImageWithURL:imgUrl placeholderImage:[UIImage imageDefaultWithSize:CGSizeMake(imageview.size.width, imageview.size.height) compress:0.3] options:SDWebImageRetryFailed progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                            d = (float)receivedSize/expectedSize;
                            isDownlaod = YES;
                        } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                            if (image != nil && isDownlaod == YES) {
                                imageview.alpha = 0;
                                [UIView animateWithDuration:0.5 animations:^{
                                    imageview.alpha = 1;
                                } completion:^(BOOL finished) {
                                }];
                            } else if (image != nil && isDownlaod == NO) {
                                imageview.image = image;
                            }
                        }];
                        
                    } else if([pictureArray_M[i] isKindOfClass:[UIImage class]]){
                        
                        imageview.image = pictureArray_M[i];
                        
                    } else if([pictureArray_M[i] isKindOfClass:[UIImageView class]]){
                        
                        UIImageView *iv = (UIImageView *)pictureArray_M[i];
                        imageview.image = iv.image;

                    }
                    
                    imageview.userInteractionEnabled = YES;
                    
                    switch (style) {
                        case Fill_contentModestyle:
                            imageview.contentMode = UIViewContentModeScaleAspectFill;
                            break;
                        case Fit_contentModestyle:
                        {
                            imageview.contentMode = UIViewContentModeScaleAspectFit;
                            //                        {top, left, bottom, right};
                            UIImage *image1=   [imageview.image resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, imageview.bounds.size.height-10) resizingMode:UIImageResizingModeStretch];
                            imageview.image = image1;
                            imageview.contentMode = UIViewContentModeScaleToFill;
                            
                            
                        }
                            break;
                        default:
                            imageview.contentMode = UIViewContentModeScaleToFill;
                            break;
                    }
                    
                    
                    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick)];
                    [imageview addGestureRecognizer:tap];
                    
                    [self.scrollview addSubview:imageview];
                    
                    
                }
                
                self.scrollview.contentOffset = CGPointMake(self.frame.size.width, 0);
                
                
                CurrectPage  =  1 ;
                
                if (animationDuration>0) {
                    
                    self.animationTimer = [NSTimer scheduledTimerWithTimeInterval:(self.animationDuration = animationDuration) target:self selector:@selector(animationTimerDid:) userInfo:nil repeats:YES];
                    
                }

                
            }
            
        }
        
    }
    return self;
}

-(void)scrollViewDidScroll:(UIScrollView *)ascrollView{
    
    
    CGFloat pageWidth = self.frame.size.width;
    int page = floor((self.scrollview.contentOffset.x - pageWidth / 2) / pageWidth)+1;
    CurrectPage = page;
    self.pageControl.currentPage = page-1;
    
   
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)aScrollView {
    
    if (0==CurrectPage) {
        [self.scrollview setContentOffset:CGPointMake([self.pictureArray count]*self.bounds.size.width, 0)];
    }
    if (([self.pictureArray count]+1)==CurrectPage) {
        [self.scrollview setContentOffset:CGPointMake(self.bounds.size.width, 0)];
    }
}

#pragma mark- 点击方法
-(void)tapClick{
    
//    NSLog(@"currentPage====%d",(int)self.pageControl.currentPage);
    
    if (self.getTapClickPage) {
        self.getTapClickPage(self.pageControl.currentPage);
//        NSLog(@"currentPage====%d",(int)self.pageControl.currentPage);
    }
    
}

#pragma mark- 定时器相关
-(void)animationTimerDid:(NSTimer*)timer{
    
//    //oldOffset = %f", self.scrollview.contentOffset.x);
    
    CGPoint newOffset = CGPointMake(self.scrollview.contentOffset.x + CGRectGetWidth(self.scrollview.frame), self.scrollview.contentOffset.y);
    
//    //newOffset = %f", newOffset.x);
    
    int page = newOffset.x/self.scrollview.frame.size.width;
    
//    //page = %d", page);
    
    newOffset = CGPointMake(page*self.scrollview.frame.size.width, newOffset.y);
    
    if (page == CurrectPage+1) {
        
        
    }
    
//    DLog(@"CurrectPage===%d-----///////%d",CurrectPage,self.pictureArray.count);
    
//    if (page == (self.pictureArray.count+2)) {
//    if (CurrectPage == self.pictureArray.count) {
//        [self.scrollview setContentOffset:CGPointMake(self.bounds.size.width, 0)];
//    }
    [self.scrollview setContentOffset:newOffset animated:YES];
    
}
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    
    if (CurrectPage == self.pictureArray.count+1) {
        
         [self.scrollview setContentOffset:CGPointMake(self.bounds.size.width, 0)];
    }

}

- (void)scrollViewWillBeginDragging:(UIScrollView *)ascrollView
{
    
//    [self.animationTimer pauseTimer];
   
}

- (void)scrollViewDidEndDragging:(UIScrollView *)ascrollView willDecelerate:(BOOL)decelerate
{
//    [self.animationTimer resumeTimerAfterTimeInterval:self.animationDuration];
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
