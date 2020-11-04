//
//  TFCustomCameraViewController.h
//  YunShangShiJi
//
//  Created by 云商 on 15/7/28.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TFCustomCamera;

@protocol TFCameraDelegate <NSObject>

@required
-(void)SelectPhotoEnd:(TFCustomCamera *)Manager WithPhotoArray:(NSArray *)PhotoArray;

@end

@interface TFCustomCamera : UIViewController


@property (nonatomic, assign)int maxPhotoCount;

@property (nonatomic, weak)id <TFCameraDelegate> delegate;

@end
