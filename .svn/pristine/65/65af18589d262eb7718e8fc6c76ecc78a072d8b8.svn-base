//
//  TFBusinessCategoryScrollView.m
//  YunShangShiJi
//
//  Created by 云商 on 15/10/27.
//  Copyright © 2015年 ios-1. All rights reserved.
//

#import "TFBusinessCategoryScrollView.h"
 
#import "TFBusinessCategoryBackgroundView.h"
#import "UIImageView+WebCache.h"
#define DefaultMargin_V (10)  
#define DefaultMargin_H (15)
#define DefaultFont (14)
#define DefaultBtnH (30)
#define DefaultHeadH (20)
#define DefaultLRMargin (10)


@implementation TFBusinessCategoryScrollView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
    }
    
    return self;
}

- (void)drawRect:(CGRect)rect
{
    //    LogFunc;
    
    CGFloat headH = self.headH==0?DefaultHeadH:self.headH;
    CGFloat h_Margin = self.h_Margin==0?DefaultMargin_H:self.h_Margin;
    CGFloat v_Margin = self.v_Margin==0?DefaultMargin_V:self.v_Margin;
    CGFloat fontSize = self.titleFontSize==0?DefaultFont:self.titleFontSize;
    CGFloat btnFontSize = self.titleFontSize==0?DefaultFont:self.btnFontSize;
    CGFloat lrMargin = self.lrMargin==0?DefaultLRMargin:self.lrMargin;
    CGFloat btnH = self.btnH==0?DefaultBtnH:self.btnH;
    CGFloat cate_v_Margin = self.cate_v_Margin==0?DefaultMargin_V:self.cate_v_Margin;
    CGFloat H = 0.0f;
    
    for (NSArray *arr in self.charArr) {
        H = H+[self calHeight:arr]+cate_v_Margin;
    }
    
    CGFloat H_head = ZOOM(250);
    
    H = H+H_head;
    self.contentSize = CGSizeMake(rect.size.width, H);
    
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, H_head)];
//    headView.backgroundColor = COLOR_RANDOM;
    [self addSubview:headView];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(ZOOM(50), ZOOM(77), kScreenWidth-ZOOM(50), ZOOM(100))];
    label.text = @"请认真选择商家所属类目";
    label.font = [UIFont systemFontOfSize:ZOOM(50)];
    label.textColor = RGBCOLOR_I(102,102,102);
    [headView addSubview:label];
    
    NSMutableArray *yArr = [NSMutableArray array];
    
    [yArr addObject:[NSNumber numberWithFloat:H_head+cate_v_Margin]]; //求出每一个Y
    
    TFBusinessCategoryBackgroundView *tbv = (TFBusinessCategoryBackgroundView *)[self superview];
    
    for (int i = 0; i< self.categoryArr.count; i++) {
        
        CGFloat Y = (int)[yArr[i] floatValue];
        CGFloat HH = (int)[self calHeight:self.charArr[i]];
        
        TFBusinessCategoryView *tv = [[TFBusinessCategoryView alloc] initWithFrame:CGRectMake(0, Y, self.frame.size.width, HH)];
        [yArr addObject:[NSNumber numberWithFloat:[yArr[i] floatValue]+HH+cate_v_Margin]];
        tv.h_Margin = h_Margin;
        tv.v_Margin = v_Margin;
        tv.titleFontSize = fontSize;
        tv.lrMargin = lrMargin;
        tv.btnFontSize = btnFontSize;
        tv.btnH = btnH;
        tv.delegate = tbv;
        tv.headH = headH;
        tv.imgUrl = [NSString stringWithFormat:@"%@%@", [NSObject baseURLStr_Upy],[self.categoryArr[i] objectForKey:@"icon"]];
        tv.contentArray = self.charArr[i];
        tv.title = [self.categoryArr[i] objectForKey:@"name"];
        tv.tag = 10000+i;
        
        [self addSubview:tv];
    }
}

- (CGFloat)calHeight:(NSArray *)arr
{
    //    LogFunc;
    
    CGFloat H = 0;
    CGFloat hMargin = self.h_Margin==0?DefaultMargin_H:self.h_Margin;
    CGFloat vMargin = self.v_Margin==0?DefaultMargin_V:self.v_Margin;
    CGFloat SH = self.btnH==0?DefaultBtnH:self.btnH;
    CGFloat btnFontSize = self.titleFontSize==0?DefaultFont:self.btnFontSize;
    CGFloat lrMargin = self.lrMargin==0?DefaultLRMargin:self.lrMargin;
    CGFloat headH = self.headH==0?DefaultHeadH:self.headH;
    
    int k = 0; //记录行
    NSMutableArray *hwArr = [NSMutableArray array];
    
    for (int i = 0; i<arr.count; i++) {
//        
//        CGFloat x= 0;
//        CGFloat y = 0;
//        CGFloat w = 0;
//        CGFloat h = 0;
//        
//        NSDictionary *dic = [arr objectAtIndex:i];
//        NSString *str = [NSString stringWithFormat:@"%@",dic[@"name"]];
//        
//        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//        btn.titleLabel.font = [UIFont systemFontOfSize:btnFontSize];
//        [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
//        [btn setTitle:str forState:UIControlStateNormal];
//        btn.backgroundColor = [UIColor grayColor];
//        
////        CGSize btnSize = [btn.titleLabel sizeThatFits:CGSizeMake(200, SH)];
//        CGSize btnSize = CGSizeMake((SIZE.width-(6*lrMargin))/5, SH);
//        
//        CGFloat oldW = 0;
//        for (int j= 0 ; j<hwArr.count; j++) {
//            oldW = [hwArr[j] floatValue]+oldW;
//        }
//        
//        if ((SIZE.width-lrMargin-oldW)<(btnSize.width+lrMargin*2+hMargin)) {
//            k++;
//            [hwArr removeAllObjects];
//            oldW = 0;
//        }
//        x = oldW+hMargin;
//        y = k*SH+k*vMargin;
//        h = SH;
//        w = btnSize.width+lrMargin*2;
//        
//        [hwArr addObject:[NSNumber numberWithFloat:(btnSize.width+lrMargin*2+hMargin)]];
    }
//    H = (k+1)*SH+(k+2)*vMargin+headH;
    if (arr.count%4 == 0) {
        k = (int)arr.count/4;
    } else {
        k = ceil(arr.count/4)+1;
    }
    H = k*SH+headH+(k+1)*vMargin;
    
    return H;
}
@end