//
//  commentPhotoView.m
//  YunShangShiJi
//
//  Created by yssj on 15/11/4.
//  Copyright © 2015年 ios-1. All rights reserved.
//

#import "commentPhotoView.h"

@implementation commentPhotoView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame]) {
        [self viewInit];
    }
    return self;
}

- (void)viewInit
{
    CGFloat H = self.frame.size.height;
    self.addImageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.addImageBtn.frame = CGRectMake(0, 0, H, H);
    [self addSubview:self.addImageBtn];
}

- (void)receiveImageArray:(NSArray *)imgArr
{
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:[UIImageView class]]) {
            [view removeFromSuperview];
        }
    }
    
    CGFloat H = self.frame.size.height;
    
    if (imgArr.count == 0) {
        self.addImageBtn.frame = CGRectMake(0, 0, H, H);
    } else if (imgArr.count>=1) {
        for (int i = 0; i<imgArr.count ; i++) {
            CGRect rect = CGRectMake(0+i*H, 0, H, H);
            UIImageView *iv = [[UIImageView alloc] initWithFrame:rect];
            [iv setContentMode:UIViewContentModeScaleAspectFit];
            iv.tag = 200+i;
            iv.userInteractionEnabled = YES;
            iv.image = imgArr[i];
            [self addSubview:iv];
            
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClcik:)];
            [iv addGestureRecognizer:tap];
            UILongPressGestureRecognizer *longP = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPClick:)];
            [iv addGestureRecognizer:longP];
        }
        UIImageView *iv = (UIImageView *)[self viewWithTag:200+imgArr.count-1];
        
        self.addImageBtn.frame = CGRectMake(iv.frame.size.width+iv.frame.origin.x+15, 0, H, H);
        
    }
}

- (void)tapClcik:(UITapGestureRecognizer *)tap
{
    //    //123456789");
    //
    //    if (self.isShake == NO) {
    UIImageView *iv = (UIImageView *)tap.view;
    
    int currPage = (int)iv.tag-200+1;
    //注册通知
    NSNotification *notification = [NSNotification notificationWithName:@"imgClickNoti" object:[NSString stringWithFormat:@"%d",currPage]];
    [[NSNotificationCenter defaultCenter] postNotification:notification];
    //    } else {
    //        for (UIView *view in self.subviews) {
    //            if ([view isKindOfClass:[UIImageView class]]) {
    //                [UIView animateWithDuration:0.2 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^
    //                 {
    //                     CGAffineTransform t = CGAffineTransformMakeScale(1,1);
    //                     view.transform = t;
    //                 } completion:^(BOOL finished)
    //                 {
    //                     //完成！");
    //                 }];
    //            }
    //        }
    //        self.isShake = NO;
    //    }
}

- (void)longPClick:(UILongPressGestureRecognizer *)longP
{
    if (longP.state == UIGestureRecognizerStateBegan) {
        UIImageView *iv = (UIImageView *)longP.view;
        int currPage = (int)iv.tag-200;
        NSNotification *notification = [NSNotification notificationWithName:@"imgLongPClickNoti" object:[NSString stringWithFormat:@"%d",currPage]];
        [[NSNotificationCenter defaultCenter] postNotification:notification];
    }
    
}

@end
