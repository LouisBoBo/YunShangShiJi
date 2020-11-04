//
//  GifImageView.h
//  YunShangShiJi
//
//  Created by ios-1 on 2017/8/23.
//  Copyright © 2017年 ios-1. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GifImageView : UIView
- (id)initWithFrame:(CGRect)frame GifImageName:(NSString*)gitImageName;
- (void)refreshGif:(NSString*)gitImageName;
@end
