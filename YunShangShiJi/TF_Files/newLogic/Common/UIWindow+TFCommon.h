//
//  UIWindow+TFCommon.h
//  YunShangShiJi
//
//  Created by jingaiweiyi on 2016/10/27.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIWindow (TFCommon)

/**
 获取当前显示的控制器

 @return <#return value description#>
 */
- (UIViewController *)visibleViewController;

+ (UIViewController *) getVisibleViewControllerFrom:(UIViewController *)vc;

/**
 方法二 获取当前显示的控制器

 @return <#return value description#>
 */
- (UIViewController*)topViewControllerWithRootViewController:(UIViewController*)rootViewController;
/**
 方法三

 @return <#return value description#>
 */
- (UIViewController *)appRootViewController;
@end
