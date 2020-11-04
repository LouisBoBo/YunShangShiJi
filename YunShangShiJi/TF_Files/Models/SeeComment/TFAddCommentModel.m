//
//  TFAddCommentModel.m
//  YunShangShiJi
//
//  Created by 云商 on 15/8/11.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//

#import "TFAddCommentModel.h"

@implementation TFAddCommentModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

- (NSMutableArray *)picArr
{
    if (_picArr == nil) {
        _picArr = [[NSMutableArray alloc] init];
        
        if (self.pic.length!=0) {
            NSArray *picArray = [self.pic componentsSeparatedByString:@","];
            for (NSString *picUrl in picArray) {
                if (picUrl.length!=0) {
                    [_picArr addObject:picUrl];
                }
            }
        }
        
    }
    return _picArr;
}


@end
