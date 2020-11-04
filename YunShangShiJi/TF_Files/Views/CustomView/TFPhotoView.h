//
//  TFPhotoView.h
//  YunShangShiJi
//
//  Created by 云商 on 15/7/25.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//

#import "TFBaseView.h"

@interface TFPhotoView : TFBaseView

@property (nonatomic, strong)UIButton *addImageBtn;

@property (nonatomic, assign)BOOL isShake;

@property (nonatomic, strong)NSString *typestr;

- (void)receiveImageArray:(NSArray *)imgArr;




@end
