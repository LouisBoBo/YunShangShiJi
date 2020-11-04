//
//  TryViewController.h
//  JinZongCai
//
//  Created by JZC on 14-9-2.
//  Copyright (c) 2014年 Jacky. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CameraVC;

@protocol CameraDelegate <NSObject>

-(void)SelectPhotoEnd:(CameraVC *)Manager WithPhotoArray:(NSArray *)PhotoArray;

@end

@interface CameraVC : UIViewController

@property (nonatomic, weak) id <CameraDelegate> delegate;

@property (nonatomic,assign) NSInteger MaxImageNum;

@property (nonatomic, assign) NSInteger isheadImage;//(1：修改头像使用；默认为0：发布房源使用)

@end
