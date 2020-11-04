//
//  ReusableView.m
//  PlainLayout
//
//  Created by hebe on 15/7/30.
//  Copyright (c) 2015年 ___ZhangXiaoLiang___. All rights reserved.
//

#import "ReusableView.h"
#import "GlobalTool.h"

@implementation ReusableView {
    NSInteger number;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)receiveWithNames:(NSArray *)nameArr pubIndex:(NSInteger)pubIndex targe:(id)targe action:(SEL)action {
    
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    NSArray *titleArr = @[@"上衣",@"裤子"];
    if(nameArr.count)
    {
        titleArr = nameArr;
    }
    
    CGFloat btnwidth = ZOOM6(120);
    for(int i=0;i<titleArr.count;i++)
    {
        UIButton *shopbtn = [UIButton buttonWithType:UIButtonTypeCustom];
        shopbtn.frame = CGRectMake((kScreenWidth/2-btnwidth)/2 + (kScreenWidth/2)*i, 12, btnwidth, 20);
        [shopbtn setTitle:titleArr[i] forState:UIControlStateNormal];
        
        [shopbtn setTitleColor:RGBCOLOR_I(62, 62, 62) forState:UIControlStateNormal];
        shopbtn.tag = 3333+i;
        shopbtn.titleLabel.font = [UIFont systemFontOfSize:ZOOM6(30)];
        [shopbtn addTarget:targe action:action forControlEvents:UIControlEventTouchUpInside];
        
        UILabel *shoplable = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(shopbtn.frame), CGRectGetMaxY(shopbtn.frame)+ZOOM6(5), btnwidth, ZOOM6(4))];
        shoplable.textColor = [UIColor clearColor];
        shoplable.tag = 4444+i;
        [self addSubview:shopbtn];
        [self addSubview:shoplable];
        
        if(i==pubIndex)
        {
            [shopbtn setTitleColor:tarbarrossred forState:UIControlStateNormal];
            shopbtn.selected = YES;
            shoplable.backgroundColor = tarbarrossred;
        }
    }
}

@end
