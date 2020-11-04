//
//  ScrollView.h
//  FDC
//
//  Created by wzz on 15/2/5.
//  Copyright (c) 2015年 JinZongCai. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "UIImageView+LazyImage.h"

@interface ScrollView : UIView

@property (nonatomic, strong) UIScrollView *scrollview;

@property (nonatomic, strong) UIPageControl *pageControl;

@property (nonatomic, strong) NSMutableArray *pictureArray;


@property (nonatomic, copy) void (^getTapClickPage)(NSInteger page);

-(instancetype)initWithFrame:(CGRect)frame pictures:(NSArray*)PictureArray animationDuration:(NSTimeInterval)animationDuration;
@end
