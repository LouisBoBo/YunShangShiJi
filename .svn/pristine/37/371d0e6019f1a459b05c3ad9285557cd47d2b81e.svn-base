//
//  TFPopBackgroundView.h
//  YunShangShiJi
//
//  Created by jingaiweiyi on 16/6/25.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GlobalTool.h"

typedef void(^CancelBlock)();
typedef void(^ConfirmBlock)();
typedef void(^NoOperationBlock)();
typedef void(^CloseBlock)();
@interface TFPopBackgroundView : UIView

@property (nonatomic, strong) UIView *backgroundView;
@property (nonatomic, assign) CGFloat margin;
@property (nonatomic, assign) CGFloat fontSize;
@property (nonatomic, assign) NSTextAlignment textAlignment;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *message;
@property (nonatomic, assign) BOOL showCancelBtn; /**< 显示关闭按钮 */
@property (nonatomic, copy) NSString *leftText; /**< 按钮文本 */
@property (nonatomic, copy) NSString *rightText;
@property (nonatomic, copy) CloseBlock  closeBlock;
@property (nonatomic, copy) CancelBlock cancelClickBlock; /**< 取消 */
@property (nonatomic, copy) ConfirmBlock confirmClickBlock; /**< 确定 */
@property (nonatomic, copy) NoOperationBlock  noOperationBlock; /**<  无操作 */
@property (nonatomic, copy) NSString *headerTitle; /**< 红色标题 */
@property (nonatomic, strong) UIView *contentView; /**< 自定义内容View */
@property (nonatomic, assign) BOOL isManualDismiss; /**< 是否手动关闭 */
@property (nonatomic, assign) CGFloat contentViewWidth;
@property (nonatomic, strong) UIView *showView;
@property (nonatomic, strong) UILabel *titleLabel;

- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message showCancelBtn:(BOOL)show leftBtnText:(NSString *)leftText rightBtnText:(NSString *)rightText margin:(CGFloat)margin contentFont:(CGFloat)fontSize;

- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message showCancelBtn:(BOOL)show leftBtnText:(NSString *)leftText rightBtnText:(NSString *)rightText;

- (void)show;

- (void)showCancelBlock:(CancelBlock)canBlock withConfirmBlock:(ConfirmBlock)conBlock withNoOperationBlock:(NoOperationBlock)noOperatBlock;

- (void)setCancelBlock:(CancelBlock)canBlock withConfirmBlock:(ConfirmBlock)conBlock withNoOperationBlock:(NoOperationBlock)noOperatBlock;

- (void)showCancelBlock:(CancelBlock)canBlock withConfirmBlock:(ConfirmBlock)conBlock withNoOperationBlock:(NoOperationBlock)noOperatBlock withCloseBlock:(CloseBlock)closeBlock;

- (void)dismissAlert:(BOOL)animation;

@end
