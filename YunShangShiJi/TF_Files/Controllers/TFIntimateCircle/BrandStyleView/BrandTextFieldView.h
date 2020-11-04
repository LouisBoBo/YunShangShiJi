//
//  BrandTextFieldView.h
//  BrandStyleView
//
//  Created by yssj on 2017/4/11.
//  Copyright © 2017年 CooFree. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^BrandTextFieldViewBlock)(NSString *str,NSString *ID);

@interface BrandTextFieldView : UIView

@property (nonatomic,copy)BrandTextFieldViewBlock confirmBlock;
-(instancetype)initWithData:(NSArray *)data;

- (void)show;

@end
