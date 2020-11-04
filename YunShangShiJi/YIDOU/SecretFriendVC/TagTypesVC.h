//
//  TagTypesVC.h
//  YunShangShiJi
//
//  Created by yssj on 2017/2/20.
//  Copyright © 2017年 ios-1. All rights reserved.
//

#import "TFBaseViewController.h"

typedef enum : NSUInteger {
    TagTypeArrow,
    TagTypeNone,
} TagType;

typedef void(^DidSelectTagRow)(NSString *str,NSString *str2);
@interface TagTypesVC : TFBaseViewController
@property (nonatomic,copy) DidSelectTagRow didSelectBlock;
@property (nonatomic,assign) TagType type;
@property (nonatomic,strong) NSMutableArray *tagArr;
@end
