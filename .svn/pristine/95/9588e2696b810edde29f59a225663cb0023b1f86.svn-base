//
//  FriendSharePopview.h
//  YunShangShiJi
//
//  Created by ios-1 on 2017/11/1.
//  Copyright © 2017年 ios-1. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FriendSharePopview : UIView
typedef NS_ENUM(NSInteger , FriendShareType)
{
    FriendShare_success = 1,      //分享成功
    
};

- (id)initWithHeadImage:(UIImage *)headImage
            contentText:(NSString *)content
          upButtonTitle:(NSString *)upTitle
        downButtonTitle:(NSString *)downTitle
             RawardType:(FriendShareType)type Raward:(CGFloat)raward;

- (void)show;

@property (nonatomic, copy)void (^headBlock)();
@property (nonatomic, copy)void (^upBlock)();
@property (nonatomic, copy)void (^downBlock)();
@property (nonatomic, copy)void (^dismissBlock)();
@property (nonatomic, assign) FriendShareType friendShareType;
@property (nonatomic, strong) UIImageView *backgroundView;

@end
