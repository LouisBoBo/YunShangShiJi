//
//  UITextView+HDFTextView.h
//
//  Created by yssj on 15/9/9.
//  Copyright (c) 2015年 Jack. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>

/**
 * @author Jack.Lannister
 *
 * 给UITextView添加placeholder
 *
 */
@interface UIPlaceholderTextView : UITextView

/*******  灰色提示文字  *******/
@property(nonatomic, strong) NSString *placeholder;

@end