//
//  TFScreeningView.m
//  YunShangShiJi
//
//  Created by 云商 on 15/7/31.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//

#import "TFScreeningView.h"
#import "UIImageView+WebCache.h"

#define DefaultMargin_V (10)
#define DefaultMargin_H (15)
#define DefaultFont (14)
#define DefaultBtnH (30)
#define DefaultHeadH (20)         
#define DefaultLRMargin (10)


@implementation TFScreeningView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
//    LogFunc;
    
    if (self.contentArray.count != 0) {
        
        CGFloat hMargin = self.h_Margin==0?DefaultMargin_H:self.h_Margin;
        CGFloat vMargin = self.v_Margin==0?DefaultMargin_V:self.v_Margin;
        CGFloat SH = self.btnH==0?DefaultBtnH:self.btnH;
        CGFloat fontSize = self.titleFontSize==0?DefaultFont:self.titleFontSize;
        CGFloat btnFontSize = self.btnFontSize==0?DefaultFont:self.btnFontSize;
        CGFloat lrMargin = self.lrMargin==0?DefaultLRMargin:self.lrMargin;
        CGFloat headHeight = self.headH==0?DefaultHeadH:self.headH;
        CGFloat headH = self.headH==0?DefaultHeadH:self.headH;
        
        UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectMake(ZOOM(50), 0, headH, headH)];
        
//        //%@", self.imgUrl);
        
        [iv sd_setImageWithURL:[NSURL URLWithString:self.imgUrl]];
        iv.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:_headImgView = iv];
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(iv.frame.origin.x+iv.frame.size.width+ZOOM(28), 0, ZOOM(300), headH)];
        titleLabel.text = self.title;
        titleLabel.font = [UIFont systemFontOfSize:fontSize];
        titleLabel.textColor = RGBCOLOR_I(152,152,152);
        [self addSubview:titleLabel];
        
        int k = 0;
        NSMutableArray *hwArr = [NSMutableArray array];
        for (int i = 0; i<self.contentArray.count; i++) {
            
            CGFloat x = 0;
            CGFloat y = 0;
            CGFloat w = 0;
            CGFloat h = 0;
            
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            
            NSDictionary *dic = self.contentArray[i];
            
            [btn setTitle:dic[@"name"] forState:UIControlStateNormal];
            [btn setTitleColor:COLOR_ROSERED forState:UIControlStateSelected];
            [btn setTitleColor:RGBACOLOR_F(0.5,0.5,0.5,0.6) forState:UIControlStateNormal];
            btn.titleLabel.font = [UIFont systemFontOfSize:btnFontSize];
            btn.tag = 1000000+i;
            
            UIImage *btnSelectImage = [UIImage  imageNamed:@"筛选_选中.png"];
            CGSize  btnSelectImageSize = btnSelectImage.size;
            UIImage *btnSelectImageTemp = [btnSelectImage  stretchableImageWithLeftCapWidth:btnSelectImageSize.width*0.5  topCapHeight:btnSelectImageSize.height*0.5];
            [btn  setBackgroundImage:btnSelectImageTemp  forState:UIControlStateSelected];
            
            UIImage *btnNormalImage = [UIImage  imageNamed:@"筛选_未选中.png"];
            CGSize  btnNormalImageSize = btnNormalImage.size;
            UIImage *btnNormalImageTemp = [btnNormalImage  stretchableImageWithLeftCapWidth:btnNormalImageSize.width*0.5  topCapHeight:btnNormalImageSize.height*0.5];
            [btn  setBackgroundImage:btnNormalImageTemp  forState:UIControlStateNormal];
            
            
//            [btn setBackgroundImage:[self imageWithColor:COLOR_ROSERED] forState:UIControlStateSelected];
//            [btn setBackgroundImage:[self imageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
//            [btn setBackgroundImage:[self imageWithColor:[UIColor whiteColor]] forState:UIControlStateHighlighted];
//            btn.layer.borderColor = [RGBCOLOR_I(220,220,220) CGColor];
//            btn.layer.borderWidth = 1.0f;
//            btn.layer.cornerRadius = SH/2.0;
            
            
            
            
            [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
            
//            CGSize btnSize = [btn.titleLabel sizeThatFits:CGSizeMake(200, SH)];
//            
//            CGFloat oldW = 0;
//            for (int j= 0 ; j<hwArr.count; j++) {
//                oldW = [hwArr[j] floatValue]+oldW;
//            }
//            
//            if ((kScreenWidth-lrMargin-oldW)<(btnSize.width+lrMargin*2+hMargin)) {
//                k++;
//                [hwArr removeAllObjects];
//                oldW = 0;
//            }
//            x = oldW+hMargin;
//            y = headHeight+k*SH+(k+1)*vMargin;
//            h = SH;
//            w = btnSize.width+lrMargin*2;
//            
//            [hwArr addObject:[NSNumber numberWithFloat:(btnSize.width+lrMargin*2+hMargin)]];
//            btn.frame = CGRectMake(x, y, w, h);
            
            int m = i%4;
            int n = i/4;
            w = (kScreenWidth-lrMargin*2-hMargin*3)/4;
            x = lrMargin+m*(hMargin+w);
            y = headH+vMargin+n*(vMargin+SH);
            h = SH;
            btn.frame = CGRectMake(x, y, w, h);
            
            [self addSubview:btn];
        }
    }
}

- (void)btnClick:(UIButton *)sender
{

    for (int i = 0; i<self.contentArray.count; i++) {
        UIButton *btn = (UIButton *)[self viewWithTag:1000000+i];
        if (btn.tag!=sender.tag) {
            btn.selected = NO;
//            btn.layer.borderColor = [RGBCOLOR_I(220,220,220) CGColor];
//            btn.layer.borderWidth = 1.0f;
//            btn.layer.cornerRadius = self.btnH/2.0;
        }
    }
    sender.selected = !sender.selected;
    if (sender.selected == YES) {

//        sender.layer.masksToBounds = YES;
//        sender.layer.borderWidth = 0.0f;
//        sender.layer.cornerRadius = self.btnH/2.0;
        if ([self.delegate respondsToSelector:@selector(selectBtnEnd:withBtnIndex:)]) {
            [self.delegate selectBtnEnd:self withBtnIndex:(int)sender.tag-1000000];
        }
    } else if (sender.selected == NO) {
//        sender.layer.borderColor = [RGBCOLOR_I(220,220,220) CGColor];
//        sender.layer.borderWidth = 1.0f;
//        sender.layer.cornerRadius = self.btnH/2.0;
        if ([self.delegate respondsToSelector:@selector(cancelSelectBtnEnd:withBtnIndex:)]) {
            [self.delegate cancelSelectBtnEnd:self withBtnIndex:(int)sender.tag-1000000];
        }
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
