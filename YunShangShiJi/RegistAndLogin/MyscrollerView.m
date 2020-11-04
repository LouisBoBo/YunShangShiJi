//
//  MyscrollerView.m
//  YunShangShiJi
//
//  Created by hyj on 15/9/1.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//

#import "MyscrollerView.h"
#import "SubmitBackgroundView.h"
#import "GlobalTool.h"
 
#import "UIImageView+WebCache.h"

#define DefaultMargin_V ZOOM(10*3.375)
#define DefaultMargin_H ZOOM(15*3.375)
#define DefaultFont ZOOM(12*3.375)
#define DefaultBtnH ZOOM(30*3.375)
#define DefaultHeadH ZOOM(20*3.375)
#define DefaultLRMargin ZOOM(10*3.375)
#define HeadvieHeigh (70)

static CGRect rect;
@implementation MyscrollerView
- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        rect = frame;
        self.backgroundColor = [UIColor whiteColor];
    
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    [self createView];
}

- (void)createView
{
    //    //charr = %@",self.charArr);
    
    CGFloat headH = self.headH==0?DefaultHeadH:self.headH;
    CGFloat h_Margin = self.h_Margin==0?DefaultMargin_H:self.h_Margin;
    CGFloat v_Margin = self.v_Margin==0?DefaultMargin_V:self.v_Margin;
    CGFloat fontSize = self.fontSize==0?DefaultFont:self.fontSize;
    CGFloat lrMargin = self.lrMargin==0?DefaultLRMargin:self.lrMargin;
    CGFloat btnH = self.btnH==0?DefaultBtnH:self.btnH;
    
    CGFloat H = 0.0f;
    for (NSArray *arr in self.charArr) {
        H = H+[self calHeight:arr[1]];
    }
    H = H;
    
    self.frame = CGRectMake(rect.origin.x, rect.origin.y, rect.size.width, rect.size.height);
    self.contentSize = CGSizeMake(rect.size.width, H+HeadvieHeigh);
    
    
    //headview
    UILabel *headlable = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, kApplicationWidth-20, 60)];
//    headlable.text=@"衣蝠是全球首个智能推款女装网购APP,告诉我们您的喜爱吧，衣蝠每天会推荐您最爱的女装哦~以下选项为单选，选项决定衣蝠自动推荐给您最爱衣衣的精准度，请按喜好认真选择哦";
    
    headlable.text=@"请您选择您喜欢的衣服类型，每个类别为单选项，小店将根据您的喜好自动推荐美衣噢~";
    headlable.numberOfLines = 0;
    headlable.textColor=kTextColor;
    headlable.textAlignment = NSTextAlignmentCenter;
    headlable.font = [UIFont systemFontOfSize:ZOOM(48)];
    [self addSubview:headlable];
    
    UILabel *lableline = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(headlable.frame), kApplicationWidth, 1)];
    lableline.backgroundColor=kBackgroundColor;
    [self addSubview:lableline];

    NSMutableArray *yArr = [NSMutableArray array];
    
    [yArr addObject:[NSNumber numberWithFloat:0.0]]; //求出每一个Y
    
//    
//    //self.charArr = %@", self.charArr);
//    //self.categoryArr = %@", self.categoryArr);
    
    
    for (int i = 0; i<[self.categoryArr[0] count]; i++) {
        
        CGFloat Y = [yArr[i] floatValue];
        
        SubmitView *tv = [[SubmitView alloc] initWithFrame:CGRectMake(0, Y+HeadvieHeigh, self.frame.size.width, (int)[self calHeight:[self.charArr[i] objectAtIndex:1]])];
        [yArr addObject:[NSNumber numberWithFloat:[yArr[i] floatValue]+[self calHeight:[self.charArr[i] objectAtIndex:1]]]];
        tv.h_Margin = (int)h_Margin;
        tv.v_Margin = (int)v_Margin;
        tv.fontSize = (int)fontSize;
        tv.lrMargin = (int)lrMargin;
        tv.btnH = (int)btnH;
        tv.headH = (int)headH;
        
        tv.delegate = (SubmitBackgroundView *)self.superview;
        

        
        tv.contentArray = [self.charArr[i] objectAtIndex:1];
        tv.contentIDArray = [self.charArr[i] objectAtIndex:0];
        
        tv.title = [self.categoryArr[1] objectAtIndex:i];
        
//        [tv.headImgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[NSObject baseURLStr_Upy], self.categoryArr[2][i]]]];
        
        tv.tag = 10000+i;
        [self addSubview:tv];
        
        
//        [tv.headImgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[NSObject baseURLStr_Upy], self.categoryArr[2][i]]]];

        
        tv.headImgString = [NSString stringWithFormat:@"%@%@",[NSObject baseURLStr_Upy], self.categoryArr[2][i]];
        
//        //headImg = %@", [NSString stringWithFormat:@"%@%@",[NSObject baseURLStr_Upy], self.categoryArr[2][i]]);
        
    }
}

//计算高度
- (CGFloat)calHeight:(NSArray *)arr
{
    //    //arr = %@",arr);
    CGFloat H = 0;
    
    CGFloat hMargin = self.h_Margin==0?DefaultMargin_H:self.h_Margin;
    CGFloat vMargin = self.v_Margin==0?DefaultMargin_V:self.v_Margin;
    CGFloat SH = self.btnH==0?DefaultBtnH:self.btnH;
    CGFloat fontSize = self.fontSize==0?DefaultFont:self.fontSize;
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
//        NSString *str = arr[i];
//        
//        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//        btn.titleLabel.font = [UIFont systemFontOfSize:fontSize];
//        [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
//        [btn setTitle:str forState:UIControlStateNormal];
//        btn.backgroundColor = [UIColor grayColor];
//        CGSize btnSize = [btn.titleLabel sizeThatFits:CGSizeMake(200, SH)];
//        
//        CGFloat oldW = 0;
//        for (int j= 0 ; j<hwArr.count; j++) {
//            oldW = [hwArr[j] floatValue]+oldW;
//        }
//        
//        if ((SIZE.width-hMargin-oldW)<(btnSize.width+lrMargin*2+hMargin)) {
//            k++;
//            [hwArr removeAllObjects];
//            oldW = 0;
//        }
//        x = oldW+hMargin;
//        y = k*SH+k*vMargin;
//        h = SH;
//        w = btnSize.width+lrMargin*2;
//        
//        [hwArr addObject:[NSNumber numberWithFloat:(btnSize.width+hMargin+lrMargin*2)]];
    }
    
//    H = (k+1)*SH+(k+2)*vMargin+headH;
    
    if (arr.count%4 == 0) {
        k = (int)arr.count/4;
    } else {
        k = ceil(arr.count/4)+1;
    }
    H = k*SH+headH+(k+1)*vMargin;
    
    //    //H = %f",H);
    return H;
}

@end
