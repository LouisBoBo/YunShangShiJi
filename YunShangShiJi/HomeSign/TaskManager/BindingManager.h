//
//  BindingManager.h
//  YunShangShiJi
//
//  Created by ios-1 on 2017/9/17.
//  Copyright © 2017年 ios-1. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BindingManager : NSObject
@property (nonatomic , strong) dispatch_block_t BindingSuccessBlock;
+(instancetype)BindingManarer;
//检测是否绑定手机和微信
- (void)checkPhoneAndUnionID:(BOOL)redCount Success:(void (^)())success;
@end


typedef void(^CancelBlock)();
typedef void(^ConfirmBlock)();
@interface PopBindingPhoneView : UIView

@property (nonatomic, copy) CancelBlock cancelClickBlock;
@property (nonatomic, copy) ConfirmBlock confirmClickBlock;

- (void)show;
- (void)setCancelBlock:(CancelBlock)canBlock withConfirmBlock:(ConfirmBlock)conBlock;

@end
