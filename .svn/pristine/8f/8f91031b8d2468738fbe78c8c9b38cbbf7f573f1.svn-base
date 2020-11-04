//
//  SubmitView.m
//  YunShangShiJi
//
//  Created by hyj on 15/9/1.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//

#import "SubmitView.h"
#import "UIButton+TFButton.h"
#import "UIImageView+WebCache.h"
#define SIZE [[UIScreen mainScreen] bounds].size

#define DefaultMargin_V ZOOM(10*3.375)
#define DefaultMargin_H ZOOM(15*3.375)
#define DefaultFont ZOOM(12*3.375)
#define DefaultBtnH ZOOM(30*3.375)
#define DefaultHeadH ZOOM(20*3.375)
#define DefaultLRMargin ZOOM(10*3.375)
//#define HeadvieHeigh (110)

@implementation SubmitView
- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
//        [self createView];
        
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
    NSUserDefaults *userdefaul = [NSUserDefaults standardUserDefaults];
    NSMutableString *idstr = [userdefaul objectForKey:USER_HOBBY];
    
    NSArray *chooseIdArr = [idstr componentsSeparatedByString:@","];
    
//    MyLog(@"chooseIdArr = %@",chooseIdArr);
    
    if (self.contentArray.count != 0) {
        
        CGFloat hMargin = self.h_Margin==0?DefaultMargin_H:self.h_Margin; //按钮水平间隔
        CGFloat vMargin = self.v_Margin==0?DefaultMargin_V:self.v_Margin; //按钮垂直间隔
        CGFloat SH = self.btnH==0?DefaultBtnH:self.btnH;      //按钮高度
        CGFloat fontSize = self.fontSize==0?DefaultFont:self.fontSize;
        CGFloat lrMargin = self.lrMargin==0?DefaultLRMargin:self.lrMargin;
        CGFloat headHeight = self.headH==0?DefaultHeadH:self.headH;
        
        CGFloat headH = self.headH==0?DefaultHeadH:self.headH;

        
        UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectMake((10), (headH-ZOOM(20*3.375))*0.5, ZOOM(20*3.375), ZOOM(20*3.375))];
        iv.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:_headImgView = iv];   //设置头像
        
        [self.headImgView sd_setImageWithURL:[NSURL URLWithString:self.headImgString] placeholderImage:nil];
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake( iv.right+(5), 0, (100), CGRectGetHeight(self.headImgView.frame))];
        titleLabel.text = self.title;
        titleLabel.font = [UIFont systemFontOfSize:fontSize];
        titleLabel.textColor = RGBACOLOR_F(0.5,0.5,0.5,0.6);
        [self addSubview:titleLabel];
        
        int k = 0; //记录行
        NSMutableArray *hwArr = [NSMutableArray array];
        for (int i = 0; i<self.contentArray.count; i++) {
            
            NSNumber *contenID = self.contentIDArray[i];
            
            CGFloat x= 0;
            CGFloat y = 0;
            CGFloat w = 0;
            CGFloat h = 0;
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            
//            MyLog(@"titlle = %@",self.contentArray[i]);
            
            [btn setTitle:self.contentArray[i] forState:UIControlStateNormal];
            [btn setTitleColor:COLOR_ROSERED forState:UIControlStateSelected];
            [btn setTitleColor:RGBACOLOR_F(0.5,0.5,0.5,0.6) forState:UIControlStateNormal];
            
            
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
            btn.titleLabel.font = [UIFont systemFontOfSize:fontSize];
            btn.titleLabel.lineBreakMode = NSLineBreakByClipping;
//            btn.layer.masksToBounds = YES;
            btn.tag = 1000000+i;
//            btn.layer.borderColor = [RGBCOLOR_I(220,220,220) CGColor];
//            btn.layer.borderWidth = 1.0f;
//            btn.layer.cornerRadius = SH/2.0;
            btn.selected = NO;
            
            btn.btnFlag = [NSNumber numberWithInt:[contenID intValue]];
            
            [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
//            CGSize btnSize = [btn.titleLabel sizeThatFits:CGSizeMake(200, 30)];
            
            int m = i%4;
            int n = i/4;
            w = (SIZE.width-lrMargin*2-hMargin*3)/4;
            x = lrMargin+m*(hMargin+w);
            y = headH+vMargin+n*(vMargin+SH);
            h = SH;
            btn.frame = CGRectMake(x, y, w, h);
            
            [self addSubview:btn];
            
            for (int j = 0; j<chooseIdArr.count; j++) {
                
                NSNumber *contentID = chooseIdArr[j];
                
                if ([btn.btnFlag intValue] == [contentID intValue]) {
                    
//                    btn.selected = YES;
//                    btn.layer.masksToBounds = YES;
//                    btn.layer.borderWidth = 0.0f;
//                    btn.layer.cornerRadius = self.btnH/2.0;
                    
                    [self btnClick:btn];
                    
                }
            }
            
        }
    } else {
        self.frame = CGRectMake(0, 0, 0, 0);
    }
}

- (void)btnClick:(UIButton *)sender
{
    
    //    //sender.tag = %d", (int)sender.tag);
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
        //        sender.layer.borderColor = [RGBCOLOR_I(220,220,220) CGColor];
//        sender.layer.masksToBounds = YES;
//        sender.layer.borderWidth = 0.0f;
//        sender.layer.cornerRadius = self.btnH/2.0;
        if ([self.delegate respondsToSelector:@selector(selectBtnEnd:withBtnIndex:)]) {
            [self.delegate selectBtnEnd:self withBtnIndex:(int)sender.tag-1000000];
        }
    } else if (sender.selected == NO) { //取消了
//        sender.layer.borderColor = [RGBCOLOR_I(220,220,220) CGColor];
//        sender.layer.borderWidth = 1.0f;
//        sender.layer.cornerRadius = self.btnH/2.0;
        if ([self.delegate respondsToSelector:@selector(cancelSelectBtnEnd:withBtnIndex:)]) {
            [self.delegate cancelSelectBtnEnd:self withBtnIndex:(int)sender.tag-1000000];
        }
    }
    
    

}


//计算高度
- (CGFloat)calHeight:(NSArray *)arr
{
    CGFloat H = 0;
    
    CGFloat hMargin = self.h_Margin==0?DefaultMargin_H:self.h_Margin; //按钮水平间隔
    CGFloat vMargin = self.v_Margin==0?DefaultMargin_V:self.v_Margin; //按钮垂直间隔
    CGFloat SH = self.btnH==0?DefaultBtnH:self.btnH;      //按钮高度
    CGFloat fontSize = self.fontSize==0?DefaultFont:self.fontSize;
    CGFloat lrMargin = self.lrMargin==0?DefaultLRMargin:self.lrMargin;
    
    int k = 0; //记录行
    NSMutableArray *hwArr = [NSMutableArray array];
    
    for (int i = 0; i<arr.count; i++) {
        CGFloat x= 0;
        CGFloat y = 0;
        CGFloat w = 0;
        CGFloat h = 0;
        NSString *str = arr[i];
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.titleLabel.font = [UIFont systemFontOfSize:fontSize];
        [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [btn setTitle:str forState:UIControlStateNormal];
        btn.backgroundColor = [UIColor grayColor];
        CGSize btnSize = [btn.titleLabel sizeThatFits:CGSizeMake(200, SH)];
        
        CGFloat oldW = 0;
        for (int j= 0 ; j<hwArr.count; j++) {
            oldW = [hwArr[j] floatValue]+oldW;
        }
        
        if ((SIZE.width-hMargin-oldW)<(btnSize.width+lrMargin*2+hMargin)) { //不可以放的下
            k++;
            [hwArr removeAllObjects];
            oldW = 0;
        }
        x = oldW+hMargin;
        y = k*SH+k*vMargin;
        h = SH;
        w = btnSize.width+lrMargin*2;
        
        [hwArr addObject:[NSNumber numberWithFloat:(btnSize.width+hMargin+lrMargin*2)]];
    }
    
    H = k*SH+k*vMargin;
    return H;
}


@end
