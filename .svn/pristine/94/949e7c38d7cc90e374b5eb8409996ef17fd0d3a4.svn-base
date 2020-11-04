//
//  TFCustomTitleView.m
//  YunShangShiJi
//
//  Created by 云商 on 15/11/30.
//  Copyright © 2015年 ios-1. All rights reserved.
//

#import "TFCustomTitleView.h"
#import "GlobalTool.h"
#import <math.h>

typedef NS_ENUM(NSInteger, ButtonType) {
    ButtonTypeImage = 100,
    ButtonTypeText
    
};

@interface TFCustomTitleView ()

@property (nonatomic, strong)NSArray *normalImage;
@property (nonatomic, strong)NSArray *selectImage;
@property (nonatomic, strong) NSArray *buttonNames;

@property (nonatomic, assign) ButtonType buttonType;

@end

@implementation TFCustomTitleView

- (instancetype)initWithFrame:(CGRect)frame withTag:(int)tag withIndex:(int)index withButtonNames:(NSArray *)buttonNames
{
    if (self = [super initWithFrame:frame]) {
        _buttonNames = buttonNames;
        self.tag = tag;
        self.buttonType = ButtonTypeText;
        [self setupView];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame withTag:(int)tag wintIndex:(int)index withNormalImage:(NSArray *)normalImages withSelectImage:(NSArray *)selectImages
{
    self = [super initWithFrame:frame];
    if (self) {
        self.tag = tag;
        self.normalImage = normalImages;
        self.selectImage = selectImages;
        self.buttonType = ButtonTypeImage;
        [self setupUI];
        
    }
    return self;
}

+ (instancetype)scrollWithFrame:(CGRect)frame withTag:(int)tag wintIndex:(int)index withNormalImage:(NSArray *)normalImages withSelectImage:(NSArray *)selectImages
{
    return [[self alloc] initWithFrame:frame withTag:tag wintIndex:index withNormalImage:normalImages withSelectImage:selectImages];
}

- (void)drawRect:(CGRect)rect
{
//    [self setupUI];
}

- (void)setupView
{
    ESWeakSelf;
    self.backgroundColor = [UIColor whiteColor];
    if (self.buttonNames.count) {
        UIView *lineV = [UIView new];
        lineV.backgroundColor = RGBCOLOR_I(240, 240, 240);
        [self addSubview:lineV];
        
        [lineV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(1);
            make.left.right.bottom.equalTo(__weakSelf);
        }];
        
        CGFloat W_btn = (kScreenWidth)/self.buttonNames.count;
        CGFloat H_btn = CGRectGetHeight(self.frame)-1;
        
        UIButton *tempBtn = nil;
        for (int i = 0; i< self.buttonNames.count; i++) {
            
            NSString *btnString = self.buttonNames[i];
            
            UIButton *btn = [UIButton new];
            btn.titleLabel.font = [UIFont systemFontOfSize:ZOOM6(32)];
            btn.tag = 1234+i;
            [btn setTitleColor:COLOR_ROSERED forState:UIControlStateSelected];
            [btn setTitleColor:RGBCOLOR_I(68, 68, 68) forState:UIControlStateNormal];
            [btn setTitle:btnString forState:UIControlStateNormal];
            [btn setTitle:btnString forState:UIControlStateSelected];
            [btn setTitle:btnString forState:UIControlStateHighlighted];
            btn.backgroundColor = [UIColor whiteColor];
            [self addSubview:btn];
            
            [btn addTarget:self action:@selector(sectionBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                
                if (!tempBtn) {
                    btn.selected = YES;
                    CGSize titleSize = [btnString boundingRectWithSize:CGSizeMake(1000, W_btn) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:ZOOM6(32)]} context:nil].size;
                    UIImage *btnImg = [UIImage imageNamed:@"0_icon_hot.png"];
                    [btn setImage:btnImg forState:UIControlStateNormal];
                    [btn setImage:btnImg forState:UIControlStateSelected];
                    [btn setImage:btnImg forState:UIControlStateHighlighted];
                    
                    CGSize imgSize = btn.imageView.bounds.size;
//                    MyLog(@"imgI: %@", NSStringFromUIEdgeInsets(btn.imageEdgeInsets));
//                    MyLog(@"textI: %@",NSStringFromUIEdgeInsets(btn.titleEdgeInsets));
                    
                    [btn setImageEdgeInsets:UIEdgeInsetsMake(-4, titleSize.width+4, 0, -titleSize.width)];
                    [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, -imgSize.width-titleSize.width, 0, imgSize.width)];
                    
                    make.left.equalTo(__weakSelf.mas_left);
                    
                } else {
                    make.left.equalTo(tempBtn.mas_right).offset(3);
                    
                }
                
                make.height.mas_equalTo(H_btn);
                make.top.equalTo(__weakSelf);
                make.width.mas_equalTo(W_btn);
            }];
            
            tempBtn = btn;
            
//            if (i!=self.buttonNames.count-1) {
//                UIView *lineV = [UIView new];
//                lineV.backgroundColor = RGBCOLOR_I(240, 240, 240);
//                [self addSubview:lineV];
//                
//                [lineV mas_makeConstraints:^(MASConstraintMaker *make) {
//                    make.left.equalTo(tempBtn.mas_right).offset(1);
//                    make.width.mas_equalTo(1);
//                    make.top.equalTo(self).offset(ZOOM6(15));
//                    make.bottom.equalTo(self).offset(-ZOOM6(15));
//                }];
//            }
        }
        
    }
}

- (void)myBtnClick:(UIButton *)sender
{
    
}

- (void)setupUI
{
    if (self.normalImage.count) {
        UIImage *img = self.normalImage[0];
        CGFloat W_btn_new = ceil((kScreenWidth/self.normalImage.count));
        CGFloat H_btn_new = ceil((img.size.height/img.size.width*W_btn_new));
        
        for (int i = 0; i<self.selectImage.count; i++) {
            CGFloat x = i*W_btn_new;
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(x, 0, W_btn_new, H_btn_new);
            ;
            UIImage *normalImage = self.normalImage[i];
            UIImage *selectImage = self.selectImage[i];
            [btn setBackgroundImage:normalImage forState:UIControlStateNormal];
            [btn setBackgroundImage:selectImage forState:UIControlStateSelected];
            [btn setBackgroundImage:selectImage forState:UIControlStateSelected | UIControlStateHighlighted];
        
            btn.tag = 1234+i;
            btn.adjustsImageWhenHighlighted = NO;
            [btn addTarget:self action:@selector(sectionBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            if (i == self.index) {
                btn.selected = YES;
            }
            [self addSubview:btn];
        }
    }
}

- (void)sectionBtnClick:(UIButton *)sender
{
    int index = (int)sender.tag-1234;
    BOOL bl = NO;
    if ([self.tfCustomTitleViewDelegate respondsToSelector:@selector(selectEndWithView:withBtnIndex:)]) {
        bl = [self.tfCustomTitleViewDelegate selectEndWithView:self withBtnIndex:index];
        
//        MyLog(@"bl: %d", bl);
    }
    
    if (bl) {
        self.index = (int)sender.tag-1234;
        if (self.buttonType == ButtonTypeImage) {
            for (int i = 0; i<self.selectImage.count; i++) {
                UIButton *btn = (UIButton *)[self viewWithTag:1234+i];
                
                [btn setBackgroundImage:self.normalImage[i] forState:UIControlStateNormal];
                [btn setBackgroundImage:self.selectImage[i] forState:UIControlStateSelected];
                [btn setBackgroundImage:self.selectImage[i] forState:UIControlStateSelected | UIControlStateHighlighted];
                btn.selected = NO;
            }
        } else {
            for (int i = 0; i<self.buttonNames.count; i++) {
                UIButton *btn = (UIButton *)[self viewWithTag:1234+i];
                btn.selected = NO;
            }
        }
        
        sender.selected = YES;
    }
}

- (void)switchToPageIndex:(int)index
{
    if (self.buttonType == ButtonTypeImage) {
        for (int i = 0; i<self.selectImage.count; i++) {
            UIButton *btn = (UIButton *)[self viewWithTag:1234+i];
            
            [btn setBackgroundImage:self.normalImage[i] forState:UIControlStateNormal];
            [btn setBackgroundImage:self.selectImage[i] forState:UIControlStateSelected];
            [btn setBackgroundImage:self.selectImage[i] forState:UIControlStateSelected | UIControlStateHighlighted];
            if (i != index) {
                btn.selected = NO;
            } else {
                btn.selected = YES;
            }
        }
    } else {
        for (int i = 0; i<self.buttonNames.count; i++) {
            UIButton *btn = (UIButton *)[self viewWithTag:1234+i];
            if (i != index) {
                btn.selected = NO;
            } else {
                btn.selected = YES;
            }
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
