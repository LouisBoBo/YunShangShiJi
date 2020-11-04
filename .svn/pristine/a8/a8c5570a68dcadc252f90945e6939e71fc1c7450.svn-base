//
//  TFBusinessCategoryBackgroundView.m
//  YunShangShiJi
//
//  Created by 云商 on 15/10/27.
//  Copyright © 2015年 ios-1. All rights reserved.
//

#import "TFBusinessCategoryBackgroundView.h"

#define DefaultMargin_V (10)
#define DefaultMargin_H (15)
#define DefaultFont (14)
#define DefaultBtnH (30)
#define DefaultHeadH (20)        
#define DefaultLRMargin (10)

@interface TFBusinessCategoryBackgroundView ()

@end



@implementation TFBusinessCategoryBackgroundView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    //    LogFunc;
    
    CGFloat headH = self.headH==0?DefaultHeadH:self.headH;
    CGFloat btnH = self.btnH==0?DefaultBtnH:self.btnH;
    CGFloat h_Margin = self.h_Margin==0?DefaultMargin_H:self.h_Margin;
    CGFloat v_Margin = self.v_Margin==0?DefaultMargin_V:self.v_Margin;
    CGFloat fontSize = self.titleFontSize==0?DefaultFont:self.titleFontSize;
    CGFloat btnFontSize = self.btnFontSize==0?DefaultFont:self.btnFontSize;
    CGFloat lrMargin = self.lrMargin==0?DefaultLRMargin:self.lrMargin;
    
    CGFloat cate_v_Margin = self.cate_v_Margin==0?DefaultMargin_V:self.cate_v_Margin;
    
    self.BusinessCategoryScrollView = [[TFBusinessCategoryScrollView alloc] initWithFrame:CGRectMake(0, 0, rect.size.width, rect.size.height-40)];
    self.BusinessCategoryScrollView.backgroundColor = [UIColor whiteColor];
    self.BusinessCategoryScrollView.categoryArr = self.categoryArr;
    self.BusinessCategoryScrollView.charArr = self.charArr;
    self.BusinessCategoryScrollView.titleFontSize = fontSize;
    self.BusinessCategoryScrollView.btnFontSize = btnFontSize;
    self.BusinessCategoryScrollView.lrMargin = lrMargin;
    self.BusinessCategoryScrollView.h_Margin = h_Margin;
    self.BusinessCategoryScrollView.v_Margin = v_Margin;
    self.BusinessCategoryScrollView.btnH = btnH;
    self.BusinessCategoryScrollView.headH = headH;
    self.BusinessCategoryScrollView.cate_v_Margin = cate_v_Margin;
    [self addSubview:self.BusinessCategoryScrollView];
    
    self.commitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.commitBtn.frame = CGRectMake(0, rect.size.height-40, rect.size.width, 40);
    [self.commitBtn setTitle:@"应用" forState:UIControlStateNormal];
    [self.commitBtn setBackgroundImage:[UIImage imageWithColor:COLOR_ROSERED] forState:UIControlStateNormal];
//    [self.commitBtn setBackgroundImage:[self imageWithColor:[UIColor whiteColor]] forState:UIControlStateHighlighted];
    [self.commitBtn addTarget:self action:@selector(commitBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.commitBtn];
    
}


- (void)selectBtnEnd:(TFBusinessCategoryView *)screeningView withBtnIndex:(int)index
{
    int i = (int)screeningView.tag-10000;
    
    NSMutableDictionary *muDic = [[NSMutableDictionary alloc] init];
    [muDic setValue:[self.categoryArr[i] objectForKey:@"id"] forKey:@"bus_type"];
    [muDic setValue:[self.charArr[i][index] objectForKey:@"id"] forKey:@"bus_type_two"];
    [muDic setValue:[self.charArr[i][index] objectForKey:@"name"] forKey:@"title"];
    [muDic setValue:[NSString stringWithFormat:@"%d",i] forKey:@"chooseIndex"];
    
    int flag = 0;
    for (NSDictionary *dic in self.chooseArr) {
        if ([dic[@"bus_type"] isEqualToString:muDic[@"bus_type"]]) {
            flag = 0;
            break;
        } else {
            flag = 1;
            break;
        }
    }
    
    if (flag == 1) {
        int i = [[self.chooseArr[0] objectForKey:@"chooseIndex"] intValue];
        TFBusinessCategoryView *bus = (TFBusinessCategoryView *)[self.BusinessCategoryScrollView viewWithTag:10000+i];
        [bus clearChooseChar];
    }

    [self.chooseArr removeAllObjects];
    [self.chooseArr addObject:muDic];
    
    
}

- (void)cancelSelectBtnEnd:(TFBusinessCategoryView *)screeningView withBtnIndex:(int)index
{
    [self.chooseArr removeAllObjects];

}

- (void)commitBtnClick:(UIButton *)sender
{

    if ([self.delegate respondsToSelector:@selector(selectBtnEnd:withChooseArray:)]) {
        [self.delegate selectBtnEnd:self withChooseArray:self.chooseArr];
    }
}

- (NSMutableArray *)chooseArr
{
    if (_chooseArr == nil) {
        _chooseArr = [[NSMutableArray alloc] init];
    }
    return _chooseArr;
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
