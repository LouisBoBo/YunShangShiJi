//
//  TFScreeningBackgroundView.m
//  YunShangShiJi
//
//  Created by 云商 on 15/8/18.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//

#import "TFScreeningBackgroundView.h"
#define DefaultMargin_V (10) 
#define DefaultMargin_H (15)
#define DefaultFont (14)
#define DefaultBtnH (30)
#define DefaultHeadH (20)
#define DefaultLRMargin (10)

@interface TFScreeningBackgroundView ()

@end



@implementation TFScreeningBackgroundView 

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    
    CGFloat headH       = self.headH==0?DefaultHeadH:self.headH;
    CGFloat btnH        = self.btnH==0?DefaultBtnH:self.btnH;
    CGFloat h_Margin    = self.h_Margin==0?DefaultMargin_H:self.h_Margin;
    CGFloat v_Margin    = self.v_Margin==0?DefaultMargin_V:self.v_Margin;
    CGFloat fontSize    = self.titleFontSize==0?DefaultFont:self.titleFontSize;
    CGFloat btnFontSize = self.btnFontSize==0?DefaultFont:self.btnFontSize;
    CGFloat lrMargin    = self.lrMargin==0?DefaultLRMargin:self.lrMargin;

    CGFloat cate_v_Margin = self.cate_v_Margin==0?DefaultMargin_V:self.cate_v_Margin;
    


    self.screeningScrollView = [[TFScreeningScrollView alloc] initWithFrame:CGRectMake(0,0, rect.size.width, rect.size.height-40)];
    self.screeningScrollView.backgroundColor = [UIColor whiteColor];
    self.screeningScrollView.categoryArr = self.categoryArr;
    self.screeningScrollView.charArr = self.charArr;
    self.screeningScrollView.titleFontSize = fontSize;
    self.screeningScrollView.btnFontSize = btnFontSize;
    self.screeningScrollView.lrMargin = lrMargin;
    self.screeningScrollView.h_Margin = h_Margin;
    self.screeningScrollView.v_Margin = v_Margin;
    self.screeningScrollView.btnH = btnH;
    self.screeningScrollView.headH = headH;
    self.screeningScrollView.cate_v_Margin = cate_v_Margin;
    [self addSubview:self.screeningScrollView];
    
    self.commitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.commitBtn.frame = CGRectMake(0, rect.size.height-40, rect.size.width, 40);
    [self.commitBtn setTitle:@"提交" forState:UIControlStateNormal];
    [self.commitBtn setBackgroundImage:[UIImage imageNamed:@"退出账号框"] forState:UIControlStateNormal];
    [self.commitBtn setBackgroundImage:[UIImage imageNamed:@"退出账号框高亮"] forState:UIControlStateHighlighted];
    [self.commitBtn addTarget:self action:@selector(commitBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.commitBtn];

}

#pragma mark - 代理
- (void)selectBtnEnd:(TFScreeningView *)screeningView withBtnIndex:(int)index
{

//    //screen title = %@", screeningView.title);
    
//    NSArray *cateArr = @[@"fix_price",@"age",@"favorite",@"size",@"sys_color",@"occasion",@"style",@"pattern",@"stuff",@"stuff2",@"stuff3",@"stuff4",@"trait",@"trait2",@"trait3"];
//    NSArray *cateArr2 = @[@"定价",@"年龄",@"最爱",@"尺寸",@"色系",@"场合",@"风格",@"图案",@"材质-四季",@"材质-春秋冬",@"材质-秋冬",@"材质-冬",@"特点1",@"特点2",@"特点3"];
    
//    int j = 0;
//    for (int k = 0; k<cateArr2.count; k++) {
//        if ([cateArr2[k] isEqualToString:screeningView.title]) {
//            j = k;
//            break;
//        }
//    }
    
    NSString *cate_e_name;
    for (NSDictionary *dic in self.categoryArr) {
        if ([dic[@"name"] isEqualToString:screeningView.title]) {
            cate_e_name = dic[@"ename"];
            break;
        }
    }
    
    int i = (int)screeningView.tag-10000;
    
    NSDictionary *tmpDic;
    for (NSDictionary *dic in self.chooseArr) {
        if ([dic[@"cate"] isEqualToString:cate_e_name]) {
            tmpDic = dic;
        }
    }
    [self.chooseArr removeObject:tmpDic];
    

    NSMutableDictionary *muDic = [NSMutableDictionary dictionary];
    [muDic setValue:cate_e_name forKey:@"cate"];
    

    [muDic setValue:[[self.charArr[i] objectAtIndex:index] objectForKey:@"id"] forKey:@"chac"];
    [self.chooseArr addObject:muDic];
    
//    //chooseArr = %@",self.chooseArr);
    
}

- (void)cancelSelectBtnEnd:(TFScreeningView *)screeningView withBtnIndex:(int)index
{

//    NSArray *cateArr = @[@"fix_price",@"age",@"favorite",@"size",@"sys_color",@"occasion",@"style",@"pattern",@"stuff",@"stuff2",@"stuff3",@"stuff4",@"trait",@"trait2",@"trait3"];
//    
//    NSArray *cateArr2 = @[@"定价",@"年龄",@"最爱",@"尺寸",@"色系",@"场合",@"风格",@"图案",@"材质-四季",@"材质-春秋冬",@"材质-秋冬",@"材质-冬",@"特点1",@"特点2",@"特点3"];
//    
//    int j = 0;
//    for (int k = 0; k<cateArr2.count; k++) {
//        if ([cateArr2[k] isEqualToString:screeningView.title]) {
//            j = k;
//            break;
//        }
//    }
    
    NSString *cate_e_name;
    for (NSDictionary *dic in self.categoryArr) {
        if ([dic[@"name"] isEqualToString:screeningView.title]) {
            cate_e_name = dic[@"ename"];
            break;
        }
    }
    
    NSDictionary *tmpDic;
    for (NSDictionary *dic in self.chooseArr) {
        if ([dic[@"cate"] isEqualToString:cate_e_name]) {
            tmpDic = dic;
        }
    }
    [self.chooseArr removeObject:tmpDic];
//    //chooseArr = %@",self.chooseArr);
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
