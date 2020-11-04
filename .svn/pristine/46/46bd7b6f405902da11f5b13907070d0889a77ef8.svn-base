//
//  SubmitBackgroundView.m
//  YunShangShiJi
//
//  Created by hyj on 15/9/1.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//

#import "SubmitBackgroundView.h"
#import "GlobalTool.h"

#define SIZE [[UIScreen mainScreen] bounds].size

#define DefaultMargin_V ZOOM(10*3.375)
#define DefaultMargin_H ZOOM(15*3.375)
#define DefaultFont ZOOM(12*3.375)
#define DefaultBtnH ZOOM(30*3.375)
#define DefaultHeadH ZOOM(20*3.375)
#define DefaultLRMargin ZOOM(10*3.375)

@interface SubmitBackgroundView ()

{
    CGRect _rect;
}

@end


@implementation SubmitBackgroundView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        _rect = frame;
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    [self createUI:_rect];
}

- (void)createUI:(CGRect)frame
{
    
//    //btn = %f", self.btnH);
    
    CGFloat headH = self.headH==0?DefaultHeadH:self.headH;
    CGFloat h_Margin = self.h_Margin==0?DefaultMargin_H:self.h_Margin;
    CGFloat v_Margin = self.v_Margin==0?DefaultMargin_V:self.v_Margin;
    CGFloat fontSize = self.fontSize==0?DefaultFont:self.fontSize;
    CGFloat lrMargin = self.lrMargin==0?DefaultLRMargin:self.lrMargin;
    CGFloat btnH = self.btnH==0?DefaultBtnH:self.btnH;
    
    self.screeningScrollView = [[MyscrollerView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height-40)];
    self.screeningScrollView.fontSize = (int)fontSize;
    self.lrMargin = lrMargin;
    self.screeningScrollView.h_Margin = (int)h_Margin;
    self.screeningScrollView.v_Margin = (int)v_Margin;
    self.screeningScrollView.btnH = (int)btnH;
    self.screeningScrollView.headH = (int)headH;
    
//    //self.categoryArr = %@", self.categoryArr);
//    //self.charArr = %@", self.charArr);
    
    self.screeningScrollView.categoryArr = self.categoryArr;
    self.screeningScrollView.charArr = self.charArr;
    
    [self addSubview:self.screeningScrollView];
    
    
    self.commitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.commitBtn.frame = CGRectMake(0, frame.size.height-40, frame.size.width, 40);
    [self.commitBtn setTitle:@"选好了" forState:UIControlStateNormal];
//    [self.commitBtn setBackgroundImage:[UIImage imageNamed:@"退出账号框"] forState:UIControlStateNormal];
//    [self.commitBtn setBackgroundImage:[UIImage imageNamed:@"退出账号框高亮"] forState:UIControlStateHighlighted];
    
    [self.commitBtn setBackgroundImage:[UIImage imageWithColor:COLOR_ROSERED] forState:UIControlStateNormal];
    
    [self.commitBtn addTarget:self action:@selector(commitBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.commitBtn];
    
}


#pragma mark - 代理
//选中的btn
- (void)selectBtnEnd:(SubmitView *)screeningView withBtnIndex:(int)index
{

    NSArray *nameArr = self.categoryArr[1];
    NSArray *ename = self.categoryArr[4];


    int j = 0;
    for (int i =0; i<nameArr.count; i++) {
        if ([screeningView.title isEqualToString:nameArr[i]]) {
            j = i;
            break;
        }
    }
    

    int i = (int)screeningView.tag-10000;
    
    NSDictionary *tmpDic;
    for (NSDictionary *dic in self.chooseArr) {
        if ([dic[@"cate"] isEqualToString:ename[j]]) {
            tmpDic = dic;
        }
    }
    [self.chooseArr removeObject:tmpDic]; //先删除
    
    NSMutableDictionary *muDic = [NSMutableDictionary dictionary];
    [muDic setValue:ename[j] forKey:@"cate"];
    [muDic setValue:[[self.charArr[i] objectAtIndex:0] objectAtIndex:index] forKey:@"chac"];
    [self.chooseArr addObject:muDic];
    
    
//    //替换选中过的
//    NSUserDefaults *userdefaul = [NSUserDefaults standardUserDefaults];
//    NSString *idstr = [userdefaul objectForKey:USER_HOBBY];
//    
//    NSArray *idarray = [idstr componentsSeparatedByString:@","];
    
//    //chooseArr = %@",self.chooseArr);
}
//取消的btn
- (void)cancelSelectBtnEnd:(SubmitView *)screeningView withBtnIndex:(int)index
{
    
    NSArray *nameArr = self.categoryArr[1];
    NSArray *ename = self.categoryArr[4];
    
    
    int j = 0;
    for (int i =0; i<nameArr.count; i++) {
        if ([screeningView.title isEqualToString:nameArr[i]]) {
            j = i;
            break;
        }
    }

//    int i = (int)screeningView.tag-10000;
    NSDictionary *tmpDic;
    for (NSDictionary *dic in self.chooseArr) {
        if ([dic[@"cate"] isEqualToString:ename[j]]) {
            tmpDic = dic;
        }
    }
    [self.chooseArr removeObject:tmpDic]; //删除
    
    //chooseArr = %@",self.chooseArr);
}

- (void)commitBtnClick:(UIButton *)sender
{
    
    
    //
    //提交: %@",self.chooseArr);
    
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



@end
