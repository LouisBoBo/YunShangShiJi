//
//  MySearchDisplayController.m
//  YunShangShiJi
//
//  Created by 云商 on 16/3/8.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import "MySearchDisplayController.h"

@implementation MySearchDisplayController

- (void)setActive:(BOOL)visible animated:(BOOL)animated
{
    [super setActive: visible animated: animated];
    
    [self.searchContentsController.navigationController setNavigationBarHidden: NO animated: NO];
}

@end
