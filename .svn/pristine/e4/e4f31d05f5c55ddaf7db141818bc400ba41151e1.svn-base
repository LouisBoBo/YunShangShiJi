//
//  UIWindow+TFCommon.m
//  YunShangShiJi
//
//  Created by jingaiweiyi on 2016/10/27.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import "UIWindow+TFCommon.h"

@implementation UIWindow (TFCommon)
#pragma mark - 方法一 (针对keyWindow.rootViewController是UIViewController/UITabBarController/UINavigationController 的各种情况)
- (UIViewController *)visibleViewController {
    UIViewController *rootViewController =[[[[UIApplication sharedApplication] delegate] window] rootViewController];
    
    /**< 
     1、[[[UIApplication sharedApplication] keyWindow] rootViewController] 有时为nil 比如当页面有菊花在转的时候，这个rootViewController就为nil;所以使用[[[[UIApplication sharedApplication] delegate] window] rootViewController] 或者
     [[[[UIApplication sharedApplication] windows] objectAtIndex:0] rootViewController] */
    return [UIWindow getVisibleViewControllerFrom:rootViewController];
}

+ (UIViewController *) getVisibleViewControllerFrom:(UIViewController *) vc {
    if ([vc isKindOfClass:[UINavigationController class]]) {
        return [UIWindow getVisibleViewControllerFrom:[((UINavigationController *) vc) visibleViewController]];
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        return [UIWindow getVisibleViewControllerFrom:[((UITabBarController *) vc) selectedViewController]];
    } else {
        if (vc.presentedViewController) {
            return [UIWindow getVisibleViewControllerFrom:vc.presentedViewController];
            
            /**< 
             presentedViewController 和 presentingViewController
             当A弹出B
             A.presentedViewController=B
             B.presentingViewController=A */
        } else {
            return vc;
        }
    }
    
}

#pragma mark - 方法二 (针对keyWindow.rootViewController是UIViewController/UITabBarController/UINavigationController 的各种情况)
- (UIViewController*)topViewControllerWithRootViewController:(UIViewController*)rootViewController {
    if ([rootViewController isKindOfClass:[UITabBarController class]]) {
        UITabBarController* tabBarController = (UITabBarController*)rootViewController;
        return [self topViewControllerWithRootViewController:tabBarController.selectedViewController];
    } else if ([rootViewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController* navigationController = (UINavigationController*)rootViewController;
        return [self topViewControllerWithRootViewController:navigationController.visibleViewController];
    } else if (rootViewController.presentedViewController) {
        UIViewController* presentedViewController = rootViewController.presentedViewController;
        return [self topViewControllerWithRootViewController:presentedViewController];
    } else {
        return rootViewController;
    }
    
}

#pragma mark - 方法三 (针对Window.rootViewController是UIViewController 开始的)
- (UIViewController *)appRootViewController
{
    UIViewController *appRootVC = self.rootViewController;
    UIViewController *topVC = appRootVC;
    while (topVC.presentedViewController) {
        topVC = topVC.presentedViewController;
    }
    return topVC;
}

@end
