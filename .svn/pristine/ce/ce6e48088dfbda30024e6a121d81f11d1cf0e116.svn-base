//
//  KeyboardTool.h
//  xibDemo
//
//  Created by 晓杰 on 14-11-13.
//  Copyright (c) 2014年 晓杰. All rights reserved.
//

#import <UIKit/UIKit.h>
@class KeyboardTool;

typedef enum {
    KeyboardToolItemTypePrevious, // 上一个
    KeyboardToolItemTypeNext, // 下一个
    KeyboardToolItemTypeDone // 完成
} KeyboardToolItemType;

@protocol KeyboardToolDelegate <NSObject>

@optional
- (void)keyboardTool:(KeyboardTool *)keyboardTool itemClick:(KeyboardToolItemType)itemType;

@end

@interface KeyboardTool : UIView

- (IBAction)done:(UIBarButtonItem *)sender; // 完成

@property (nonatomic, weak) id<KeyboardToolDelegate> delegate;

+ (id)keyboardTool;
@end
