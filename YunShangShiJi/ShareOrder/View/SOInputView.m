//
//  SOInputView.m
//  YunShangShiJi
//
//  Created by zgl on 16/6/2.
//  Copyright © 2016年 ios-1. All rights reserved.
//  晒单详情底部输入控件

#import "SOInputView.h"
#import "GlobalTool.h"

@interface SOInputView ()<UITextFieldDelegate>

@property (nonatomic, strong) UIButton *sendBtn; // 发送
@property (nonatomic, strong) UITextField *textField; // 输入框
@property (nonatomic, strong) UIView *textFieldLeftView; // 右侧图标

@end

@implementation SOInputView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.textField];
        [self addSubview:self.sendBtn];
        self.backgroundColor = [UIColor whiteColor];
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectZero];
        [lineView setBackgroundColor:lineGreyColor];
        [self addSubview:lineView];
        
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(@(0));
            make.height.equalTo(@(0.5));
        }];
        
        [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@(kZoom6pt(15)));
            make.right.equalTo(self.sendBtn.mas_left).offset(kZoom6pt(-13));
            make.height.equalTo(@(kZoom6pt(38)));
            make.centerY.equalTo(self);
        }];
        
        [self.sendBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self.textField);
            make.right.equalTo(@(kZoom6pt(-15)));
            make.width.equalTo(@(kZoom6pt(60)));
        }];
    }
    return self;
}

#pragma mark - 类方法
- (void)textFileBecomeFirstResponder:(BOOL)isFirstResponder placeholder:(NSString *)placeholder{
    _textField.placeholder = placeholder;
    [self leftViewIsFirstResponder:isFirstResponder];
    if (isFirstResponder) {
        [_textField becomeFirstResponder];
    } else {
        [_textField resignFirstResponder];
        _textField.text = @"";
    }
}

/// 键盘状态调整左侧图标
- (void)leftViewIsFirstResponder:(BOOL)isFirstResponder {
    if (isFirstResponder) {
        _textFieldLeftView.frame = CGRectMake(0, 0, kZoom6pt(10), kZoom6pt(38));
        _textFieldLeftView.hidden = YES;
    } else {
        _textFieldLeftView.frame = CGRectMake(0, 0, kZoom6pt(35), kZoom6pt(38));
        _textFieldLeftView.hidden = NO;
    }
}

#pragma mark - 点击事件
- (void)btnClick {
    if (_sendBlock) {
        _sendBlock(_textField.text);
    }
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self btnClick];
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    [self leftViewIsFirstResponder:YES];
}

#pragma mark - getter
- (UITextField *)textField {
    if (nil == _textField) {
        _textField = [[UITextField alloc]initWithFrame:CGRectZero];
        _textField.layer.borderColor = UIColorHex(0xFF448E).CGColor;
        _textField.layer.borderWidth = 1;
        _textField.layer.cornerRadius = 4;
        _textField.font = [UIFont systemFontOfSize:14];
        _textField.placeholder = @"评论";
        _textFieldLeftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kZoom6pt(35), kZoom6pt(38))];
        _textFieldLeftView.backgroundColor = [UIColor whiteColor];
        UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_bianjipinglun"]];
        imgView.frame = CGRectMake(kZoom6pt(10), kZoom6pt(10), kZoom6pt(18), kZoom6pt(18));
        [_textFieldLeftView addSubview:imgView];
        _textField.leftView = _textFieldLeftView;
        _textField.leftViewMode = UITextFieldViewModeAlways;
        _textField.returnKeyType = UIReturnKeySend;
        _textField.delegate = self;
    }
    return _textField;
}

- (UIButton *)sendBtn {
    if (nil == _sendBtn) {
        _sendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _sendBtn.layer.cornerRadius = 4;
        [_sendBtn setTitle:@"发送" forState:UIControlStateNormal];
        [_sendBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_sendBtn.titleLabel setFont:[UIFont systemFontOfSize:kZoom6pt(16)]];
        [_sendBtn setBackgroundColor:UIColorHex(0xFF448E)];
        [_sendBtn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sendBtn;
}

@end
