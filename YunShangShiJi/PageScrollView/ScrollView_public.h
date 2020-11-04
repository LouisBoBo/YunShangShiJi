//
//  ScrollView_public.h
//  FDC
//
//  Created by wzz on 15/2/6.
//  Copyright (c) 2015年 JinZongCai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TaoTaoPageControl.h"

typedef NS_ENUM(NSUInteger, contentModestyle) {
    Fill_contentModestyle = 0,
    Fit_contentModestyle = 1
};
@interface ScrollView_public : UIView

@property (nonatomic, strong) UIScrollView *scrollview;
@property (nonatomic, strong) TaoTaoPageControl *pageControl;
@property (nonatomic, strong) NSMutableArray *pictureArray;
@property (nonatomic, copy) void (^getTapClickPage)(NSInteger page);
@property (nonatomic, copy) NSString *type;

-(instancetype)initWithFrame:(CGRect)frame pictures:(NSArray*)PictureArray animationDuration:(NSTimeInterval)animationDuration contentMode_style:(contentModestyle)style Haveshiping:(BOOL)haveshiping;

@end
