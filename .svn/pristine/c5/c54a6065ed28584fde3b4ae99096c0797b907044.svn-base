//
//  TFPopBackgroundView.m
//  YunShangShiJi
//
//  Created by jingaiweiyi on 16/6/25.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import "TFPopBackgroundView.h"

@implementation TFPopBackgroundView

- (instancetype)init
{
    if (self = [super init]) {
        _title = nil;
        _message = nil;
        _showCancelBtn = NO;
        _rightText = nil;
        _leftText = nil;
        _margin  = ZOOM6(10);
        _fontSize = ZOOM6(28);
        _textAlignment = NSTextAlignmentLeft;
    }
    return self;
}

- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message showCancelBtn:(BOOL)show leftBtnText:(NSString *)leftText rightBtnText:(NSString *)rightText margin:(CGFloat)margin contentFont:(CGFloat)fontSize
{
    if (self = [super init]) {
        _title = title;
        _message = message;
        _showCancelBtn = show;
        _rightText = rightText;
        _leftText = leftText;
        _margin  = margin;
        _fontSize = fontSize;
        _textAlignment = NSTextAlignmentCenter;
    }
    return self;
}

- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message showCancelBtn:(BOOL)show leftBtnText:(NSString *)leftText rightBtnText:(NSString *)rightText 
{
    if (self = [super init]) {
        _title = title;
        _message = message;
        _showCancelBtn = show;
        _rightText = rightText;
        _leftText = leftText;
        _margin  = ZOOM6(20);
        _fontSize = ZOOM6(28);
        _textAlignment = NSTextAlignmentLeft;
    }
    return self;
}

- (void)setupUI
{
    UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGRClick:)];
    [self addGestureRecognizer:tapGR];
    
    ESWeakSelf;
    self.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    
    // 宽
    CGFloat W_backgrd = kScreenWidth- ZOOM6(85)*2;
    // 高
    CGFloat H_backgrd = 0;
    
    // 头部标题高
    CGFloat H_headerTitle = self.headerTitle == nil? 0: ZOOM6(80);
    // 标题高
    CGFloat H_titleLab = self.title == nil? 0: ZOOM6(40);
    // 按钮高
    CGFloat H_btn;
    if(self.leftText == nil && self.rightText == nil) {
        H_btn = 0;
    } else {
        H_btn = ZOOM6(80);
    }
    
    NSString *string = self.message;
    CGSize sizeString = [string boundingRectWithSize:CGSizeMake(W_backgrd-ZOOM6(40)*2, 1000)
                                             options:NSStringDrawingUsesLineFragmentOrigin
                                          attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:self.fontSize]}
                                             context:nil].size;
    // 文本高
    CGFloat H_contentLab = ceil(sizeString.height);
    
    [self.contentView setNeedsLayout];
    [self.contentView layoutIfNeeded];
    // contentView 高
    CGFloat H_contentV = self.contentView.height;
    
//    MyLog(@"H_contentV: %f", H_contentV);
    CGFloat padding_ud_text = ZOOM6(50);
    CGFloat padding_ud_btn = (H_btn == 0)? 0: ZOOM6(50);
    
    CGFloat margin1 = ((H_contentLab == 0)? 0:self.margin);
    CGFloat margin2 = ((H_contentV == 0)? 0:self.margin);
    H_backgrd = H_headerTitle +
                padding_ud_text +
                H_titleLab +
                margin1 +
                H_contentLab +
                margin2 +
                H_contentV +
                padding_ud_text +
                H_btn +
                padding_ud_btn;
    
    /**< 界面 */
    if (!self.backgroundView) {
        UIView *backgroundView = [UIView new];
        //    backgroundView.tag = 200;
        backgroundView.layer.masksToBounds = YES;
        backgroundView.layer.cornerRadius = ZOOM6(10);
        backgroundView.backgroundColor = [UIColor whiteColor];
        backgroundView.clipsToBounds = YES;
        [self addSubview:_backgroundView = backgroundView];
    } else {
        [self addSubview:self.backgroundView];
    }
    
    // 头部
    UILabel *headerTitle = [[UILabel alloc] init];
    headerTitle.backgroundColor = COLOR_ROSERED;
    headerTitle.textColor = [UIColor whiteColor];
    headerTitle.font = [UIFont systemFontOfSize:ZOOM6(36)];
    headerTitle.text = self.headerTitle;
    headerTitle.textAlignment = NSTextAlignmentCenter;
    [self.backgroundView addSubview:headerTitle];
    
    // 标题
    UILabel *titleLabel = [UILabel new];
    titleLabel.text = self.title;
    titleLabel.textAlignment = [self.title isEqualToString:@"填写邀请码"]? NSTextAlignmentLeft:NSTextAlignmentCenter;
    titleLabel.font = [UIFont systemFontOfSize:ZOOM6(36)];
    titleLabel.textColor = RGBCOLOR_I(62, 62, 62);
    titleLabel.backgroundColor = [UIColor whiteColor];
    [self.backgroundView addSubview:self.titleLabel = titleLabel];
    
    // x 按钮
    UIButton *xBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [xBtn setImage:[UIImage imageNamed:@"icon_close"] forState:UIControlStateNormal];
//    xBtn.userInteractionEnabled = YES;
    xBtn.hidden = !self.showCancelBtn;
    [self.backgroundView addSubview:xBtn];
    
    // 内容
    UILabel *contentLabel = [UILabel new];
    contentLabel.font = [UIFont systemFontOfSize:self.fontSize];
    contentLabel.text = string;
    contentLabel.textColor = RGBCOLOR_I(125, 125, 125);
    contentLabel.numberOfLines = 0;
    contentLabel.textAlignment = self.textAlignment;
    [self.backgroundView addSubview:contentLabel];
    
    // 关闭按钮
    UIButton *canBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [canBtn setTitle:self.leftText forState:UIControlStateNormal];
    [canBtn setTitleColor:COLOR_ROSERED forState:UIControlStateNormal];
    [canBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    canBtn.layer.masksToBounds = YES;
    canBtn.layer.cornerRadius = ZOOM6(8);
    canBtn.layer.borderColor = [COLOR_ROSERED CGColor];
    canBtn.layer.borderWidth = 1;
    canBtn.titleLabel.font = [UIFont systemFontOfSize:ZOOM6(36)];
    [canBtn setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
    [canBtn setBackgroundImage:[UIImage imageWithColor:COLOR_ROSERED] forState:UIControlStateHighlighted];
    canBtn.hidden = (self.leftText == nil);
    [self.backgroundView addSubview:canBtn];
    
    // 确定按钮
    UIButton *conBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    conBtn.layer.masksToBounds = YES;
    conBtn.layer.cornerRadius = ZOOM6(8);
    [conBtn setTitle:self.rightText forState:UIControlStateNormal];
    [conBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    conBtn.titleLabel.font = [UIFont systemFontOfSize:ZOOM6(36)];
    
    [conBtn setBackgroundImage:[UIImage imageWithColor:COLOR_ROSERED] forState:UIControlStateNormal];
    [conBtn setBackgroundImage:[UIImage imageWithColor:RGBCOLOR_I(204, 20, 93)] forState:UIControlStateHighlighted];
    conBtn.hidden = (self.rightText == nil);
    [self.backgroundView addSubview:conBtn];
    
    /**< 布局 */
    [headerTitle mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.backgroundView);
        make.height.mas_equalTo(H_headerTitle);
    }];
    
    [titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(headerTitle.mas_bottom).offset(padding_ud_text);
//        make.left.right.equalTo(self.backgroundView);
        make.left.equalTo(self.backgroundView).offset(ZOOM6(40));
        make.right.equalTo(self.backgroundView).offset(-ZOOM6(40));
        make.height.mas_equalTo(H_titleLab);
    }];

    [xBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.backgroundView).offset(ZOOM6(20));
        make.right.equalTo(self.backgroundView).offset(-ZOOM6(40));
        make.size.mas_equalTo(CGSizeMake(ZOOM6(40), ZOOM6(44)));
    }];
    
    [contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.backgroundView).offset(ZOOM6(40));
        make.right.equalTo(self.backgroundView).offset(-ZOOM6(40));
        make.top.equalTo(titleLabel.mas_bottom).offset(margin1);
        make.height.mas_equalTo(H_contentLab);
    }];
    
    // 自定义内容的View
    [self.backgroundView addSubview:self.contentView];
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(contentLabel.mas_bottom).offset(margin2);
        make.left.equalTo(self.backgroundView).offset(ZOOM6(40));
        make.right.equalTo(self.backgroundView).offset(-ZOOM6(40));
        make.height.mas_equalTo(H_contentV);
    }];

    CGFloat W_leftBtn = W_backgrd*0.5-ZOOM6(40)-ZOOM6(15);
    CGFloat W_rightBtn = W_backgrd*0.5-ZOOM6(40)-ZOOM6(15);
    if (self.leftText == nil) {
        W_leftBtn = 0;
        W_rightBtn = W_backgrd - ZOOM6(40)*2;
    }
    [canBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentLabel.mas_left);
        make.centerY.equalTo(conBtn.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(W_leftBtn, H_btn));
    }];
    
    [conBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(contentLabel.mas_right);
        make.bottom.equalTo(self.backgroundView.mas_bottom).offset(-padding_ud_btn);
        make.size.mas_equalTo(CGSizeMake(W_rightBtn, H_btn));
    }];
    
    [self.backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(__weakSelf);
        make.centerY.equalTo(__weakSelf);
        make.size.mas_equalTo(CGSizeMake(W_backgrd, H_backgrd));
    }];
    
    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
    self.backgroundView.transform = CGAffineTransformMakeScale(0, 0);
    
    [canBtn addTarget:self action:@selector(canBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [conBtn addTarget:self action:@selector(conBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [xBtn addTarget:self action:@selector(closeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)setCancelBlock:(CancelBlock)canBlock withConfirmBlock:(ConfirmBlock)conBlock withNoOperationBlock:(NoOperationBlock)noOperatBlock
{
    self.cancelClickBlock = canBlock;
    self.confirmClickBlock = conBlock;
    self.noOperationBlock = noOperatBlock;
}

- (void)show
{
    [self setupUI];
    
    if (!self.showView) {
        UIWindow *window = [[UIApplication sharedApplication] keyWindow];
        [window addSubview:self];
    }else
        [self.showView addSubview:self];
   
    
    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.6 initialSpringVelocity:0.1 options:UIViewAnimationOptionCurveEaseIn animations:^{
        self.backgroundColor = [[UIColor colorWithRed:0 green:0 blue:0 alpha:0] colorWithAlphaComponent:0.5];
        self.backgroundView.transform = CGAffineTransformMakeScale(1, 1);
        self.backgroundView.alpha = 1;

    } completion:^(BOOL finished) {
        //
    }];
    
//    [UIView animateWithDuration:0.5 animations:^{
//        self.backgroundColor = [[UIColor colorWithRed:0 green:0 blue:0 alpha:0] colorWithAlphaComponent:0.5];
//        backgroundView.transform = CGAffineTransformMakeScale(1, 1);
//        backgroundView.alpha = 1;
//    } completion:^(BOOL finish) {
//        
//    }];
    
}

- (void)showCancelBlock:(CancelBlock)canBlock withConfirmBlock:(ConfirmBlock)conBlock withNoOperationBlock:(NoOperationBlock)noOperatBlock
{
    [self showCancelBlock:canBlock withConfirmBlock:conBlock withNoOperationBlock:noOperatBlock withCloseBlock:nil];
}

- (void)showCancelBlock:(CancelBlock)canBlock withConfirmBlock:(ConfirmBlock)conBlock withNoOperationBlock:(NoOperationBlock)noOperatBlock withCloseBlock:(CloseBlock)closeBlock {
    self.cancelClickBlock = canBlock;
    self.confirmClickBlock = conBlock;
    self.noOperationBlock = noOperatBlock;
    self.closeBlock = closeBlock;
    [self show];
}

- (void)tapGRClick:(UITapGestureRecognizer *)sender
{
    if (self.noOperationBlock) {
        self.noOperationBlock();
    }
    if (!self.isManualDismiss) {
        [self dismissAlert:YES];
    }
}

- (void)closeBtnClick:(UIButton *)sender {
    if (self.closeBlock) {
        self.closeBlock();
    }
    if (!self.isManualDismiss) {
        [self dismissAlert:YES];
    }
}

- (void)canBtnClick:(UIButton *)sender
{
    if (self.cancelClickBlock) {
        self.cancelClickBlock();
    }
    if (!self.isManualDismiss) {
        [self dismissAlert:YES];
    }
}

- (void)conBtnClick:(UIButton *)sender
{
    if (self.confirmClickBlock) {
        self.confirmClickBlock();
    }
    if (!self.isManualDismiss) {
        [self dismissAlert:YES];
    }
}

- (void)dismissAlert:(BOOL)animation
{
//    UIView *backgroundView = (UIView *)[self viewWithTag:200];
    if (animation) {
        
        [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
            self.alpha = 0;
            self.backgroundView.transform = CGAffineTransformMakeScale(0.25, 0.25);
            self.backgroundView.alpha = 0;
        } completion:^(BOOL finished) {
            [self.backgroundView removeFromSuperview];
            [self removeFromSuperview];
        }];
    } else {
        [self.backgroundView removeFromSuperview];
        [self removeFromSuperview];
    }
}


- (CGFloat)contentViewWidth
{
    return kScreenWidth- ZOOM6(85)*2-ZOOM6(40)*2;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
