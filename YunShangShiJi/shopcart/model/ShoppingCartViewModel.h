//
//  ShoppingCartViewModel.h
//  YunShangShiJi
//
//  Created by ios-1 on 2017/1/16.
//  Copyright © 2017年 ios-1. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShoppingCartViewModel : NSObject
@property (strong, nonatomic) NSMutableArray *dataArray;           //有效数据
@property (strong, nonatomic) NSMutableArray *invalidArray;        //失效数据
@property (strong, nonatomic) NSMutableArray *likeArray;           //喜欢数据
- (void)getData:(void (^)())success Fail:(void (^)())fail;
- (void)getLikeData:(void(^)())success;
@end
