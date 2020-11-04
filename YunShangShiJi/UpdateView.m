//
//  UpdateView.m
//  YunShangShiJi
//
//  Created by zgl on 16/9/6.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import "UpdateView.h"
#import "GlobalTool.h"

#define topSpace ZOOMPT(30) //上间距
#define bottomSpace ZOOMPT(25)//下间距
#define space ZOOMPT(15) //左右间距
#define titlespace ZOOMPT(20) //左右间距

#define UPDATE_TITLE @"衣蝠发新版啦~"
#define UPDATE_SUBTITLE @"更新了以下内容"

///创建Label
static inline UILabel *createLabel(UIColor *color, int fontSize, NSTextAlignment textAlignment, int numberOfLines, NSString *title){
    UILabel *label = [[UILabel alloc] init];
    label.textColor = color;
    label.text = title;
    label.font = [UIFont systemFontOfSize:fontSize];
    label.textAlignment = textAlignment;
    label.numberOfLines = numberOfLines;
    return label;
}

///创建Button
static inline UIButton *createButton(UIColor *bgcolor, UIColor *titlecolor, float borderWidth, NSString *title, NSString *norimg, NSString *selimg, id tager, SEL action){
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.backgroundColor = bgcolor;
    btn.titleLabel.font = [UIFont systemFontOfSize:ZOOMPT(18)];
    btn.layer.cornerRadius = 4;
    btn.layer.borderColor = titlecolor.CGColor;
    btn.layer.borderWidth = borderWidth;
    [btn setTitle:title?:@"" forState:UIControlStateNormal];
    [btn setTitleColor:titlecolor forState:UIControlStateNormal];
    [btn addTarget:tager action:action forControlEvents:UIControlEventTouchUpInside];
    if (norimg) {
        [btn setBackgroundImage:[UIImage imageNamed:norimg] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:norimg] forState:UIControlStateNormal|UIControlStateHighlighted];
    }
    if (selimg) {
        [btn setBackgroundImage:[UIImage imageNamed:selimg] forState:UIControlStateSelected];
        [btn setBackgroundImage:[UIImage imageNamed:selimg] forState:UIControlStateSelected|UIControlStateHighlighted];
    }
    return btn;
}

@interface UpdateView ()
@property (nonatomic, assign) UpdateViewType type;
@property (nonatomic, copy) dispatch_block_t block;
@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UILabel *title;
@property (nonatomic, strong) UILabel *subtitle;
@property (nonatomic, strong) UITextView *content;
@property (nonatomic, strong) UIButton *noBtn;
@property (nonatomic, strong) UIButton *okBtn;
@property (nonatomic, strong) UIButton *selectBtn;
@property (nonatomic, strong) UILabel *remind;
@end


@implementation UpdateView

- (instancetype)initWithType:(UpdateViewType)type{
    self = [super initWithFrame:CGRectMake(0, 0,kScreenWidth, kScreenHeight)];
    if (self) {
        self.backgroundColor = [[UIColor colorWithRed:0 green:0 blue:0 alpha:0] colorWithAlphaComponent:0];
        _type = type;
        [self createUI];
    }
    return self;
}

#pragma mark - UI
- (void)createUI {
    _backView = [[UIView alloc] init];
    _backView.backgroundColor = [UIColor whiteColor];
    _backView.layer.cornerRadius = 5;
    _backView.clipsToBounds = YES;
    _backView.transform = CGAffineTransformMakeScale(0.25, 0.25);
    _backView.alpha = 0;
    
    _title = createLabel(RGBA(62,62,62,1),ZOOMPT(18),NSTextAlignmentCenter,0,@"");
    _subtitle = createLabel(RGBA(62,62,62,1),ZOOMPT(15),NSTextAlignmentLeft,0,@"");
    _content = [[UITextView alloc] init];
    _content.textColor = RGBA(125,125,125,1);
    _content.font = [UIFont systemFontOfSize:ZOOMPT(14)];
    _content.editable = NO;
    _content.selectable = NO;
    _okBtn = createButton(tarbarrossred,kWiteColor,0,@"立即更新",nil,nil,self,@selector(okClick:));
    
    if (_type == UpdateViewChooseType) {
        _remind = createLabel(RGBA(125,125,125,1),ZOOMPT(14),NSTextAlignmentLeft,1,@"不再提醒");
        _noBtn = createButton(kWiteColor,tarbarrossred,0.5,@"暂不更新",nil,nil,self,@selector(noClick:));
        _selectBtn = createButton(kWiteColor,tarbarrossred,0,nil,@"remind_nor",@"remind_cel",self,@selector(selectClick:));
        [_backView addSubview:_remind];
        [_backView addSubview:_noBtn];
        [_backView addSubview:_selectBtn];
    }
    
    [_backView addSubview:_title];
    [_backView addSubview:_subtitle];
    [_backView addSubview:_content];
    [_backView addSubview:_okBtn];
    [self addSubview:_backView];
}

#pragma mark - btnClick
- (void)noClick:(UIButton *)sender {
    NSUserDefaults *userDef = [NSUserDefaults standardUserDefaults];
    [userDef setDouble:[NSDate date].timeIntervalSince1970 forKey:UPDATE_TIME];
    [userDef setBool:_selectBtn.selected forKey:UPDATE_SHOW];
    
    [UIView animateWithDuration:0.5 animations:^{
        self.backgroundColor = [[UIColor colorWithRed:0 green:0 blue:0 alpha:0] colorWithAlphaComponent:0];
        self.backView.transform = CGAffineTransformMakeScale(0.25, 0.25);
        self.backView.alpha = 0;
    } completion:^(BOOL finish) {
        [self removeFromSuperview];
        if (self.block) self.block();
    }];
}

- (void)okClick:(UIButton *)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://itunes.apple.com/cn/app/yi-fu/id1029741842?mt=8"]];
}

- (void)selectClick:(UIButton *)sender {
    sender.selected = !sender.selected;
}

#pragma mark - UIView方法
- (void)layoutSubviews {
    [super layoutSubviews];
    [_backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(ZOOMPT(45));
        make.right.mas_equalTo(-ZOOMPT(45));
        make.centerY.equalTo(self);
    }];
    
    [_title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(topSpace);
        make.left.mas_equalTo(space);
        make.right.mas_equalTo(-space);
    }];
    
    [_subtitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_title.mas_bottom).offset(space);
        make.left.mas_equalTo(titlespace);
        make.right.mas_equalTo(-titlespace);
    }];
    
    CGSize size = [_content sizeThatFits:CGSizeMake(kScreenWidth - ZOOMPT(90) - 2*space, MAXFLOAT)];
    _content.scrollEnabled = size.height > ZOOMPT(150);
    CGFloat height = _content.scrollEnabled?ZOOMPT(150):size.height;
    [_content mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_subtitle.mas_bottom).offset(ZOOMPT(5));
        make.left.mas_equalTo(space);
        make.right.mas_equalTo(-space);
        make.height.mas_equalTo(height);
    }];
    
    [_okBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_content.mas_bottom).offset(topSpace - ZOOMPT(5));
        make.right.mas_equalTo(-space);
        make.height.mas_equalTo(ZOOMPT(40));
        if (_type == UpdateViewChooseType) {
            make.left.equalTo(_noBtn.mas_right).offset(space);
        } else {
            make.left.mas_equalTo(space);
            make.bottom.mas_equalTo(-bottomSpace);
        }
    }];
    
    if (_type == UpdateViewChooseType) {
        [_noBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.height.width.equalTo(_okBtn);
            make.left.mas_equalTo(space);
        }];
        
        [_selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_noBtn.mas_bottom).offset(space);
            make.left.mas_equalTo(ZOOMPT(15));
            make.height.width.mas_equalTo(ZOOMPT(20));
            make.bottom.mas_equalTo(-bottomSpace);
        }];
        
        [_remind mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_selectBtn.mas_right).offset(ZOOMPT(6));
            make.centerY.equalTo(_selectBtn);
            make.right.mas_equalTo(-space);
        }];
    }
}

- (void)didMoveToSuperview {
    [super didMoveToSuperview];
    [UIView animateWithDuration:0.5 animations:^{
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
        self.backView.transform = CGAffineTransformMakeScale(1, 1);
        self.backView.alpha = 1;
    }];
}

#pragma mark - show
+ (void)showType:(UpdateViewType)type title:(NSString *)title subtitle:(NSString *)subtitle text:(NSString *)text toView:(UIView *)view removeBlock:(dispatch_block_t)block{
    if (type == UpdateViewChooseType) {
        NSString *version = [DataManager sharedManager].version;
        NSUserDefaults *userDef = [NSUserDefaults standardUserDefaults];
        NSString *oversion = [userDef objectForKey:UPDATE_VERSION];
        
        if (oversion != nil && [version isEqualToString:oversion]) {
            BOOL isShow = [userDef boolForKey:UPDATE_SHOW];
            NSTimeInterval time = [NSDate date].timeIntervalSince1970 - [userDef doubleForKey:UPDATE_TIME];
            if (isShow || time < 72*60*60) {
                return;
            }
        } else {
            [userDef setBool:NO forKey:UPDATE_SHOW];
            [userDef setObject:version forKey:UPDATE_VERSION];
            [userDef setDouble:0.0 forKey:UPDATE_TIME];
        }
    }
    
    UpdateView *updateView = [[UpdateView alloc] initWithType:type];
    updateView.block = block;
    updateView.title.text = title?:UPDATE_TITLE;
    updateView.subtitle.text = subtitle?:[NSString stringWithFormat:@"%@%@",[DataManager sharedManager].version, UPDATE_SUBTITLE];
    updateView.content.attributedText = [NSString attributedStringWithString:text?:@"" paragraphSpacing:ZOOMPT(5) lineSpacing:0 fontSize:ZOOMPT(14) color:RGBA(125,125,125,1)];
    if (view == nil) {
        view = [UIApplication sharedApplication].keyWindow;
    }
    [view addSubview:updateView];
}

@end
