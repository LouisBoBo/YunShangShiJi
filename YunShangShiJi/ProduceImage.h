//
//  ProduceImage.h
//  TFTestDemo
//
//  Created by 云商 on 15/8/29.
//  Copyright (c) 2015年 云商. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShareShopModel.h"
@interface ProduceImage : UIView


/**
 <#Description#>

 @param image      二维码底图
 @param QRImage    二维码
 @param text       作判断的条件
 @param price      价格
 @param sharetitle 分享的文字

 @return <#return value description#>
 */
- (UIImage *)getImage:(UIImage *)image withQRCodeImage:(UIImage *)QRImage withText:(NSString *)text withPrice:(NSString*)price WithTitle:(NSString*)sharetitle;

- (UIImage *)getH5Image:(UIImage *)image withQRCodeImage:(UIImage *)QRImage withText:(NSString *)text;

- (UIImage *)getImage:(UIImage *)image withQRCodeImage:(UIImage *)QRImage;

- (UIImage *)getQRImage:(UIImage *)image withQRCodeImage:(UIImage *)QRImage WithzhezhaoImg:(UIImage*)zhezhaoimg WithBaseImg:(UIImage*)baseImg;
- (UIImage *)getShareImage:(UIImage *)image WithBaseImg:(UIImage*)baseImg WithPrice:(NSString*)price;
/**
 邀请好友  分享到朋友圈的二维码图片

 @param bgImg       背景图
 @param QRCodeImage 二维码
 @param title       title description
 @param subTitle    subTitle description

 @return
 */
- (UIImage *)QRImageWithBgImg:(UIImage *)bgImg withQRCodeImage:(UIImage *)QRCodeImage withTitle:(NSString *)title WithSubTitle:(NSString*)subTitle;

@end
