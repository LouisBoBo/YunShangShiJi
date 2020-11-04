//
//  TFScreeningScrollView.m
//  YunShangShiJi
//
//  Created by 云商 on 15/7/31.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//

#import "TFScreeningScrollView.h"
#import "GlobalTool.h"
 
#import "TFScreeningBackgroundView.h"
#import "UIImageView+WebCache.h"
#define DefaultMargin_V (10)  
#define DefaultMargin_H (15)
#define DefaultFont (14)
#define DefaultBtnH (30)
#define DefaultHeadH (20)         
#define DefaultLRMargin (10)


@implementation TFScreeningScrollView
- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
    }

    return self;
}

- (void)drawRect:(CGRect)rect
{

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
    H = H;
    
    NSMutableArray *yArr = [NSMutableArray array];
    
    [yArr addObject:[NSNumber numberWithFloat:cate_v_Margin]];
    
    TFScreeningBackgroundView *tbv = (TFScreeningBackgroundView *)[self superview];
    
    
    UILabel *remindLabel = [[UILabel alloc]init];
    NSString *string =@"以下每个选项为单选哦，可同时选多个选项。如喜欢韩版女装，就单选“韩系”点提交，喜欢韩版修身，同时选“韩系”和“修身款”，再点提交就可以啦。";
    remindLabel.numberOfLines=0;
    NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:17]};
    CGSize textSize = [string boundingRectWithSize:CGSizeMake(kScreenWidth-ZOOM(42)*2, 300) options: NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attributes context:nil].size;
    remindLabel.frame=CGRectMake(ZOOM(42),0, kScreenWidth-ZOOM(42)*2, textSize.height+ZOOM(42));
    remindLabel.textColor=kTextColor;
    remindLabel.text=string;
    [self addSubview:remindLabel];
    
    UILabel *line = [[UILabel alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(remindLabel.frame)+ZOOM(42),kScreenWidth*2, 3)];
    line.text=@"---------------------------------------------------------------";
//    line.backgroundColor=DRandomColor;
//    line.textAlignment=NSTextAlignmentRight;
    line.textColor=kTextColor;
    [self addSubview:line];
    
    self.scrollsToTop = NO;
    self.contentSize = CGSizeMake(rect.size.width, H+CGRectGetHeight(remindLabel.frame)+CGRectGetHeight(line.frame)+v_Margin);
    
    for (int i = 0; i< self.categoryArr.count; i++) {
        
        CGFloat Y = (int)[yArr[i] floatValue];
        
        CGFloat HH = (int)[self calHeight:self.charArr[i]];
        
        TFScreeningView *tv = [[TFScreeningView alloc] initWithFrame:CGRectMake(0, Y+CGRectGetMaxY(line.frame), self.frame.size.width, HH)];
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
        
//        tv.backgroundColor = COLOR_RANDOM;
        
        [self addSubview:tv];
    }
}

- (CGFloat)calHeight:(NSArray *)arr
{

    CGFloat H = 0;
    CGFloat hMargin = self.h_Margin==0?DefaultMargin_H:self.h_Margin;
    CGFloat vMargin = self.v_Margin==0?DefaultMargin_V:self.v_Margin;
    CGFloat SH = self.btnH==0?DefaultBtnH:self.btnH;
    CGFloat btnFontSize = self.titleFontSize==0?DefaultFont:self.btnFontSize;
    CGFloat lrMargin = self.lrMargin==0?DefaultLRMargin:self.lrMargin;
    CGFloat headH = self.headH==0?DefaultHeadH:self.headH;
    
    int k = 0;
    NSMutableArray *hwArr = [NSMutableArray array];
    
    for (int i = 0; i<arr.count; i++) {
        
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
//        CGSize btnSize = [btn.titleLabel sizeThatFits:CGSizeMake(200, SH)];
//        CGFloat oldW = 0;
//        for (int j= 0 ; j<hwArr.count; j++) {
//            oldW = [hwArr[j] floatValue]+oldW;
//        }
//        
//        if ((kScreenWidth-lrMargin-oldW)<(btnSize.width+lrMargin*2+hMargin)) {
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
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
