//
//  RawardRedPopview.h
//  YunShangShiJi
//
//  Created by ios-1 on 2016/12/17.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger , RawardRedType)
{
    RawardRed_success = 1,      //抽中红包
    RawardRed_fail = 2,         //没抽中
    RawardRed_open = 3,         //折红包
    RawardRed_order_open = 4,   //订单未完成
    RawardMondayRed_success =11,//疯狂星期一抽中红包
    Rawardfive_order_open = 5,  //50元订单红包
    Rawardfive_order_fail = 6,  //订单红包没抽中
    Rawardfive_order_success = 7,//订单红包抽中
};


@interface RawardRedPopview : UIView
- (id)initWithHeadImage:(UIImage *)headImage
            contentText:(NSString *)content
          upButtonTitle:(NSString *)upTitle
        downButtonTitle:(NSString *)downTitle
             RawardType:(RawardRedType)type Raward:(CGFloat)raward CashorEdu:(NSInteger)cash;

- (void)show;

@property (nonatomic, copy)void (^headBlock)();
@property (nonatomic, copy)void (^upBlock)();
@property (nonatomic, copy)void (^downBlock)();
@property (nonatomic, copy)void (^dismissBlock)();
@property (nonatomic, assign) RawardRedType rawardRedType;
@property (nonatomic, strong) UIImageView *backgroundView;
@end
