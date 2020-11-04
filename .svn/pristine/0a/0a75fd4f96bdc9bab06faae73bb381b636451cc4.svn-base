//
//  CollectionImageMenuReusableView.m
//  YunShangShiJi
//
//  Created by ios-1 on 2017/9/19.
//  Copyright © 2017年 ios-1. All rights reserved.
//

#import "CollectionImageMenuReusableView.h"
#import "GlobalTool.h"

@implementation CollectionImageMenuReusableView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self=[super initWithFrame:frame]) {
        _headImgView = [[UIImageView alloc]init];
        _headImgView.frame = CGRectMake(0,0, kScreenWidth,frame.size.height - ZOOM6(70));

        [self addSubview:_headImgView];
        
        [self addSubview:self.menubackview];
    }
    return self;
}

- (NewTaskMenuButtonView *)menubackview
{
    if (!_menubackview) {
        _menubackview = [[NewTaskMenuButtonView alloc] init];
        _menubackview.frame = CGRectMake(0, self.frame.size.height-ZOOM6(70), kScreenWidth, ZOOM6(70));
        
        BOOL menu = [[NSUserDefaults standardUserDefaults]boolForKey:@"threemenu"];
        if(menu)
        {
            _menubackview.titleArray = @[@"最新",@"价格↑",@"价格↓"];
            [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"threemenu"];
            
        }else{
            _menubackview.titleArray = @[@"最新",@"热销",@"价格↑",@"价格↓"];
        }
        
        [_menubackview show];
    }
    return _menubackview;
}

@end

@implementation NewTaskMenuButtonView

- (instancetype)init
{
    if (self = [super init]) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame titleArray:(NSArray *)titleArray normalImgArray:(NSArray *)normalImgArray selectImgArray:(NSArray *)selectImgArray
{
    if (self = [super init]) {
        _titleArray = titleArray;
        _normalImgArray = normalImgArray;
        _selectImgArray = selectImgArray;
    }
    return self;
}

- (void)show
{
    ESWeakSelf;
    if (_titleArray.count) {
        //        CGFloat W_btn = CGRectGetWidth(self.frame)/self.titleArray.count;
        //        CGFloat H_btn = CGRectGetHeight(self.frame);
        
        //        MyLog(@"w: %f, h: %f", W_btn, H_btn);
        
        CGFloat scal = (CGFloat)1/self.titleArray.count;
        
        UIButton *lastBtn =  nil;
        for (int i = 0; i<self.titleArray.count; i++) {
            UIButton *btn = [UIButton new];
            //            btn.backgroundColor = COLOR_RANDOM;
            [btn setTitle:self.titleArray[i] forState:UIControlStateNormal];
            [btn setTitle:self.titleArray[i] forState:UIControlStateSelected];
            btn.titleLabel.font = [UIFont systemFontOfSize:ZOOM6(28)];
            [btn setTitleColor:COLOR_ROSERED forState:UIControlStateSelected];
            [btn setTitleColor:RGBCOLOR_I(68, 68, 68) forState:UIControlStateNormal];
            //            [btn setImage:self.selectImgArray[i] forState:UIControlStateSelected];
            //            [btn setImage:self.normalImgArray[i] forState:UIControlStateNormal];
            btn.tag = 100 + i;
            [btn addTarget:self action:@selector(menuBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            
            [self addSubview:btn];
            
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                if (!lastBtn) {
                    make.left.equalTo(__weakSelf.mas_left);
                } else {
                    make.left.equalTo(lastBtn.mas_right);
                }
                make.centerY.equalTo(__weakSelf.mas_centerY);
                make.width.equalTo(__weakSelf.mas_width).multipliedBy(scal);
                make.height.equalTo(__weakSelf.mas_height);
                //                make.size.mas_equalTo(CGSizeMake(100, ZOOM6(80)));
            }];
            lastBtn = btn;
        }
        
    }
}

- (void)menuBtnClick:(UIButton *)sender
{
    for (int i = 0; i<self.titleArray.count; i ++) {
        UIButton *btn = (UIButton *)[self viewWithTag:100+i];
        btn.selected = NO;
    }
    sender.selected = YES;
    
    NSInteger index = sender.tag - 100;
    if (self.menuBtnClickBlock) {
        self.menuBtnClickBlock(index);
    }
}

@end
