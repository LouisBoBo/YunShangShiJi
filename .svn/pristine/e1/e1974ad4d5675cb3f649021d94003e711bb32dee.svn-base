//
//  ScrollView.m
//  FDC
//
//  Created by wzz on 15/2/5.
//  Copyright (c) 2015年 JinZongCai. All rights reserved.
//

#import "ScrollView.h"
#import "GlobalTool.h"
@interface ScrollView ()<UIScrollViewDelegate>{
    
    
    UIImageView *leftImageView;
    UIImageView *centerImageView;
    UIImageView *rightImageView;
    
    NSInteger CurrectPage;
}



@end


@implementation ScrollView

-(instancetype)initWithFrame:(CGRect)frame pictures:(NSArray*)PictureArray animationDuration:(NSTimeInterval)animationDuration{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        self.scrollview = [[UIScrollView alloc]initWithFrame:frame];
        self.scrollview.bounces = NO;
        self.scrollview.showsHorizontalScrollIndicator = NO;
        self.scrollview.showsVerticalScrollIndicator = NO;
        self.scrollview.delegate = self;
        self.scrollview.pagingEnabled = YES;
        [self addSubview:self.scrollview];
        
        self.pictureArray = [PictureArray mutableCopy];
        
        if (PictureArray.count) {
            
            
            if (!self.pageControl) {
                self.pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(0, frame.size.height-30, frame.size.width, 30)];
                self.pageControl.currentPage = 0;
                self.pageControl.numberOfPages = PictureArray.count;
                self.pageControl.currentPageIndicatorTintColor = tarbarrossred;
                [self addSubview:self.pageControl];
            }
            
            
            NSString *FirstStr = PictureArray.lastObject;
            NSString *lastStr = PictureArray.firstObject;
            
            NSMutableArray* pictureArray_M = [[NSMutableArray alloc]initWithArray:PictureArray];
            [pictureArray_M insertObject:FirstStr atIndex:0];
            [pictureArray_M addObject:lastStr];
            
            self.scrollview.contentSize = CGSizeMake(pictureArray_M.count*self.frame.size.width, self.frame.size.height);
            
            for (int i = 0; i<pictureArray_M.count; i++) {
                
                UIImageView *imageview = [[UIImageView alloc]init];
                CGRect rect = self.bounds;
                rect.origin.x = i*self.frame.size.width;
                imageview.frame = rect;
                
//                [imageview setImageWithUrlStr:pictureArray_M[i] placeholder:nil];
                imageview.userInteractionEnabled = YES;
                
                UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick)];
                [imageview addGestureRecognizer:tap];
                
                [self.scrollview addSubview:imageview];
            }
            
            self.scrollview.contentOffset = CGPointMake(self.frame.size.width, 0);
            
        }
        
        CurrectPage  =  0 ;
    }
    
    if (animationDuration>0) {
        
        
    }
    
    
    return self;
}

-(void)scrollViewDidScroll:(UIScrollView *)ascrollView{
    
    
    CGFloat pageWidth = self.frame.size.width;
    int page = floor((self.scrollview.contentOffset.x - pageWidth / 2) / pageWidth)+1;
    CurrectPage = page;
    self.pageControl.currentPage = page-1;
    
    
}

- (NSInteger)getValidNextPageIndexWithPageIndex:(NSInteger)currentPageIndex;
{
    if(currentPageIndex == -1) {
        return self.pictureArray.count - 1;
    } else if (currentPageIndex == self.pictureArray.count) {
        return 0;
    } else {
        return currentPageIndex;
    }
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
    
    NSLog(@"currentPage====%d",self.pageControl.currentPage);
    
    if (self.getTapClickPage) {
        self.getTapClickPage(self.pageControl.currentPage);
        NSLog(@"currentPage====%d",self.pageControl.currentPage);
    }
    
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
