//
//  CustomTitleView.m
//  TFTestCollctionViewDemo
//
//  Created by 云商 on 15/8/21.
//  Copyright (c) 2015年 云商. All rights reserved.
//

#import "CustomTitleView.h"
#import "GlobalTool.h"
#import "UIImageView+WebCache.h"

#define TitleViewColor [UIColor colorWithRed:234/225.0 green:234/225.0 blue:234/225.0 alpha:1];
#define DefaultBackColor [UIColor whiteColor]
#define DefaultButtonFont 15
#define DefaultButtonNums 5
#define DefaultButtonWidth 50
#define DefaultImageW ZOOM(75)

#define Margin self.margin

@interface CustomTitleView () <UIScrollViewDelegate>

@property (nonatomic, strong)NSArray *buttonNames;
@property (nonatomic, strong)NSArray *imageNames;

@property (nonatomic, assign)CGFloat margin;


@end

@implementation CustomTitleView

- (instancetype)initWithFrame:(CGRect)frame withTag:(int)tag wintIndex:(int)index withButtonNames:(NSArray *)names withImage:(NSArray *)images
{
    self = [super initWithFrame:frame];
    if (self) {
        self.tag = tag;
        self.buttonNames = names;
        self.imageNames = images;
        self.index = index;
    }
    return self;
}

+ (instancetype)scrollWithFrame:(CGRect)frame withTag:(int)tag withIndex:(int)index withButtonNames:(NSArray *)names withImage:(NSArray *)images
{
    return [[self alloc] initWithFrame:frame withTag:tag wintIndex:index withButtonNames:names withImage:images];
}

- (void)drawRect:(CGRect)rect
{
    [self createAll];
}

- (void)createAll
{
//    NSLog(@"buttonNames: %@", self.buttonNames);
    
    self.backgroundColor = self.backColor?self.backColor:DefaultBackColor;
    self.buttonNums = self.buttonNums?self.buttonNums:DefaultButtonNums;
    CGFloat buttonWidth = self.buttonWidth?self.buttonWidth:DefaultButtonWidth;
    CGFloat imgW = self.imageW?self.imageW:DefaultImageW;
//    int BtnNums = self.buttonNames?self.buttonNums:DefaultButtonNums;
    
    CGFloat H = self.frame.size.height;
    CGFloat W =0;
    
    self.bgScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    self.bgScrollView.showsHorizontalScrollIndicator = NO;
    self.bgScrollView.backgroundColor = self.backColor;
    self.bgScrollView.delegate = self;
    self.bgScrollView.scrollsToTop = NO;
    [self addSubview:self.bgScrollView];
    
    
    Margin = 0.0f;
    if (self.buttonNames.count!=0) {
        if (self.buttonNames.count<self.buttonNums) {
            Margin = ((self.bgScrollView.frame.size.width/self.buttonNames.count)-(imgW+buttonWidth))/2;
            W = self.bgScrollView.frame.size.width/self.buttonNames.count;
            self.bgScrollView.contentSize = CGSizeMake(self.frame.size.width, self.frame.size.height);
            
        } else {
            Margin = (self.bgScrollView.frame.size.width/self.buttonNums-(imgW+buttonWidth))/2;
            W = self.bgScrollView.frame.size.width/self.buttonNums;
            self.bgScrollView.contentSize = CGSizeMake(self.bgScrollView.frame.size.width/self.buttonNums*self.buttonNames.count,self.bgScrollView.frame.size.height);
        }
        for (int i = 0; i<self.buttonNames.count; i++) {
            CGFloat X = i*W;
            CGFloat Y = 0;
            
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(X, Y, W, H)];

            [self.bgScrollView addSubview:view];
            
            NSString *buttonName = self.buttonNames[i];
            CGSize size = [buttonName getSizeWithFont:kFont6pt(14) constrainedToSize:CGSizeMake(100, CGRectGetHeight(self.frame))];
            
            UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake((W - size.width * 2) * 0.5, view.frame.size.height-2, size.width * 2, 2)];
            lineView.backgroundColor = COLOR_ROSERED;
            lineView.hidden = YES;
            lineView.tag = 30000+i;
//            [view addSubview:lineView];
            
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.tag = 10000+i;
            btn.frame = CGRectMake(0, 0, W, H);
            [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
            
            [btn setTitle:self.buttonNames[i] forState:UIControlStateNormal];
            btn.titleLabel.font = kFont6pt(16);
            [btn setTitleColor:RGBCOLOR_I(62, 62, 62) forState:UIControlStateNormal];
            [btn setTitleColor:COLOR_ROSERED forState:UIControlStateSelected];
            [view addSubview:btn];
            
            if (i != self.buttonNames.count-1 && self.isShopping) {
                UIView *verV = [[UIView alloc] initWithFrame:CGRectMake(W, (H - 0.6*H) * 0.5 , 1, H * 0.6)];
                verV.backgroundColor = RGBCOLOR_I(240, 240, 240);
                [view addSubview:verV];
            }
            if (i != self.buttonNames.count-1 && self.isSecretFriend) {
                UIView *line=[[UIView alloc]initWithFrame:CGRectMake(0, H-0.5, kScreenWidth, 0.5)];
                line.backgroundColor=kTableLineColor;
                [view addSubview:line];
            }
            
            if (self.index == i) {
                btn.selected = YES;
                lineView.hidden = NO;
            }
        }
        
        // by 赵官林 2016.5.17  刚进入时菜单移动到对应位置
        int flagIndex= self.buttonNums-1;
        //每个按钮的宽度
        CGFloat newMargin = self.bgScrollView.frame.size.width/self.buttonNums;
        //button的总数
        int buttonCount = (int)self.buttonNames.count;

        if (_index>=flagIndex) {
            CGFloat contentOff = (_index - flagIndex + 1)*newMargin;
            if (contentOff > (buttonCount - self.buttonNums)*newMargin) {
                contentOff = (buttonCount - self.buttonNums)*newMargin;
            }
            [self.bgScrollView setContentOffset:CGPointMake(contentOff, 0) animated:NO];
        }
 
    }
}

- (void)btnClick:(UIButton *)sender
{
    int index = (int)sender.tag-10000;
    BOOL bl = NO;
    if ([self.customTitleViewDelegate respondsToSelector:@selector(selectEndWithView:withBtnIndex:)]) {
       bl = [self.customTitleViewDelegate selectEndWithView:self withBtnIndex:index];
    }
    
//    MyLog(@"bl: %d", bl);
    
    if (bl) {
        [self switchToPageIndex:index];
    }
}

- (void)mobileScrollView
{
    //每一个宽度
    CGFloat newMargin = self.bgScrollView.frame.size.width/self.buttonNums;
    //偏移x
    CGFloat offset_x = self.bgScrollView.contentOffset.x;
    //保存一下偏移x
    CGFloat tempOffset_x = offset_x;
    if ((int)offset_x%(int)newMargin!=0) {
        if (offset_x<newMargin) { //左偏移未超过一个宽度
            if (offset_x<newMargin/2.0) { //未超过半个宽度
                self.bgScrollView.contentOffset = CGPointMake(0, 0);
            } else {    //超过半个宽度
                self.bgScrollView.contentOffset = CGPointMake(newMargin, 0);
            }
            
        } else { //左偏移超过一个宽度以上
            int i = 0;
            while (tempOffset_x>newMargin) {
                i++;
                tempOffset_x = offset_x-i*newMargin;
            }
            if (tempOffset_x>=newMargin/2.0) {
                self.bgScrollView.contentOffset = CGPointMake((i+1)*newMargin, 0);
            } else {
                self.bgScrollView.contentOffset = CGPointMake(i*newMargin, 0);
            }
        }
        
    }
}

- (BOOL)isRight:(CGRect)frame
{
    CGFloat newMargin = self.bgScrollView.frame.size.width/self.buttonNums;
    if (((frame.origin.x-self.bgScrollView.contentOffset.x)/(self.buttonNums-1)) == newMargin) {
        return YES;
    } else
        return NO;
}

- (BOOL)isLeft:(CGRect)frame
{

    if (frame.origin.x-self.bgScrollView.contentOffset.x == 0) {
        return YES;
    } else
        return NO;
}

- (void)refreshIndex:(int)index withContentOffset:(CGPoint)point
{
    
//    for (int i = 0; i<self.buttonNames.count; i++) {
//        UIButton *btn = (UIButton *)[self.bgScrollView viewWithTag:10000+i];
//        UIView *lineView = (UIView *)[self.bgScrollView viewWithTag:30000+i];
//        
////        if (index+10000 != btn.tag) {
//            btn.selected = NO;
//            lineView.hidden = YES;
////        } else {
////            btn.selected = YES;
////            lineView.hidden = NO;
////        }
//        
//    }
    
    UIButton *selectedBtn = (UIButton *)[self.bgScrollView viewWithTag:10000+self.index];
    UIView *selectedLineView = (UIView *)[self.bgScrollView viewWithTag:30000+self.index];
    selectedBtn.selected = NO;
    selectedLineView.hidden = YES;
    
    UIButton *currBtn = (UIButton *)[self.bgScrollView viewWithTag:10000+index];
    UIView *currLineView = (UIView *)[self.bgScrollView viewWithTag:30000+index];
    currBtn.selected = YES;
    currLineView.hidden = NO;
    
    self.bgScrollView.contentOffset = point;
}

- (void)refreshTitleViewUI:(NSArray *)btnNames withImgNames:(NSArray *)imgNames
{
    self.buttonNames = btnNames;
    self.imageNames = imgNames;
    
    [self createAll];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{

}

- (void)switchToPageIndex:(int)index
{
    [self mobileScrollView];
    
    int flagIndex= self.buttonNums-1;
    
    //每个按钮的宽度
    CGFloat newMargin = self.bgScrollView.frame.size.width/self.buttonNums;
    //button的总数
    int buttonCount = (int)self.buttonNames.count;
    int rightButtonCount = buttonCount-index-1;
    
    
    if (index<flagIndex) {  //
        [self.bgScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    } else if (index>=flagIndex) {
        if (rightButtonCount>=self.buttonNums-flagIndex) {
            [self.bgScrollView setContentOffset:CGPointMake((index-(flagIndex-1))*newMargin, 0) animated:YES];
        }
    }
    
    [self refreshIndex:(int)index withContentOffset:self.bgScrollView.contentOffset];
    self.index = index;
    
//    //何波修改
//    NSString *token = [[NSUserDefaults standardUserDefaults]objectForKey:USER_TOKEN];
//    if(token !=nil)
//    {
//        [self mobileScrollView];
//        
//        int flagIndex= self.buttonNums-1;
//        
//        //每个按钮的宽度
//        CGFloat newMargin = self.bgScrollView.frame.size.width/self.buttonNums;
//        //button的总数
//        int buttonCount = (int)self.buttonNames.count;
//        int rightButtonCount = buttonCount-index-1;
//        
//        
//        if (index<flagIndex) {  //
//            [self.bgScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
//        } else if (index>=flagIndex) {
//            if (rightButtonCount>=self.buttonNums-flagIndex) {
//                [self.bgScrollView setContentOffset:CGPointMake((index-(flagIndex-1))*newMargin, 0) animated:YES];
//            }
//        }
//        
//        [self refreshIndex:(int)index withContentOffset:self.bgScrollView.contentOffset];
//        self.index = index;
//
//    }else{
//    
//        if(self.loginBlock)
//        {
//            self.loginBlock();
//        }
//    }
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
