//
//  TFPhotoView.m
//  YunShangShiJi
//
//  Created by 云商 on 15/7/25.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//

#import "TFPhotoView.h"



@implementation TFPhotoView


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
    [self.addImageBtn setBackgroundImage:[UIImage imageNamed:@"+图片"] forState:UIControlStateNormal];
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
    int k =0;
    if (imgArr.count == 0) {
        self.addImageBtn.frame = CGRectMake(0, 0, H, H);
    } else if (imgArr.count>=1) {
        for (int i = 0; i<imgArr.count ; i++) {
            CGRect rect = CGRectMake(0+i*15+i*H, 0, H, H);
            UIImageView *iv = [[UIImageView alloc] initWithFrame:rect];
            [iv setContentMode:UIViewContentModeScaleAspectFit];
            iv.tag = 200+i;
            iv.userInteractionEnabled = YES;
            iv.image = imgArr[i];
            [self addSubview:iv];
            
            if([self.typestr isEqualToString:@"抽奖晒单"])
            {
                UIButton *deleatebtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
                deleatebtn.tag = 3000 + k;
                k++;
                
                deleatebtn.frame = CGRectMake(iv.frame.size.width-20, 0, 20, 20);
                [deleatebtn setBackgroundImage:[UIImage imageNamed:@"icon_delele"] forState:UIControlStateNormal];
                [deleatebtn addTarget:self action:@selector(delateimage:) forControlEvents:UIControlEventTouchUpInside];
                
                [iv addSubview:deleatebtn];
            
            }
            
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
  
//    if (self.isShake == NO) {
        UIImageView *iv = (UIImageView *)tap.view;
        
        int currPage = (int)iv.tag-200+1;

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

- (void)delateimage:(UIButton*)sender
{
    MyLog(@"删除");
    
    int currPage = (int)sender.tag-3000;
    NSNotification *notification = [NSNotification notificationWithName:@"imgDelectPClickNoti" object:[NSString stringWithFormat:@"%d",currPage]];
    [[NSNotificationCenter defaultCenter] postNotification:notification];

}

//-(void)longPressTap:(UILongPressGestureRecognizer  *)recognizer
//{
//    if (recognizer.state == UIGestureRecognizerStateBegan)
//    {
//        //begin");
//        int i = 0;//获取数组中得view位置
//        for (UIView * view in self.subviews)
//        {
//            if ([view isKindOfClass:[UIImageView class]]) {
//                i = i + 1;
//                //角度偏移矩阵
//                CGAffineTransform t1 = CGAffineTransformMakeRotation(0.03);
//                CGAffineTransform t2 = CGAffineTransformMakeRotation(-0.03);
//                
//                if (i%2 == 1)
//                {
//                    view.transform = t1;
//                }
//                else
//                {
//                    view.transform = t2;
//                }
//                
//                [UIView animateWithDuration:0.1 delay:0.0 options:UIViewAnimationOptionAutoreverse|UIViewAnimationOptionRepeat animations:^{
//                    //[UIView setAnimationRepeatCount:12.0];
//                    if (i%2 == 1)
//                    {
//                        view.transform = t2;
//                    }
//                    else
//                    {
//                        view.transform = t1;
//                    }
//                    
//                } completion:^(BOOL finished){
//                    
//                    [UIView animateWithDuration:0.2 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^
//                     {
//                         CGAffineTransform t = CGAffineTransformMakeScale(1,1);
//                         for (UIView * view in self.subviews)
//                         {
//                             view.transform = t;
//                         }
//                     } completion:^(BOOL finished)
//                     {
//                         //完成");
//                     }];
//                    
//                    
//                }];
//            }
//        }
//        self.isShake = YES;
//    }
//    else if (recognizer.state == UIGestureRecognizerStateChanged)
//    {
//        //changed");
//    }
//    else if(recognizer.state == UIGestureRecognizerStateEnded)
//    {
//        //end");
//        
//    }
//}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
