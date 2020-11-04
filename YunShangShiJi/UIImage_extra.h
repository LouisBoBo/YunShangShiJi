//
//      
//  SmartBattery
//
//  Created by 徐仁杰 on 13-7-4.
//  Copyright (c) 2013年 徐仁杰. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
@interface UIImage (extra)
+ (UIImage *)imageScaleNamed:(NSString *)name;
//1.等比率缩放
- (UIImage *)scaleImageToScale:(float)scaleSize;
//2.自定长宽
- (UIImage *)reSizeImageToSize:(CGSize)reSize;
//3.处理某个特定View 只要是继承UIView的object 都可以处理
-(UIImage*)captureView:(UIView *)theView;
//4.处理选择图片后旋转的问题
- (UIImage *)fixOrientation;

/**
 * 获取经过模糊处理的图片
 * @param blur 模糊半径，取值范围0.05~2.0
 * @return 经过模糊处理后的图片，blur小于0.05时，返回原图，大于2.0时，返回blur=2.0的图片
 */
- (UIImage *)blurWithLevel:(CGFloat)blur;

/**
 * 用指定颜色生成一个1x1像素的图片
 */
+ (UIImage *)imageWithColor:(UIColor *)color;

+ (UIImage *)imageWithBezierPath:(UIBezierPath *)path fillColor:(UIColor *)fillColor lineColor:(UIColor *)lineColor;


- (UIImage *) renderAtSize:(const CGSize) size;
- (UIImage *) maskWithImage:(const UIImage *) maskImage;

@end
