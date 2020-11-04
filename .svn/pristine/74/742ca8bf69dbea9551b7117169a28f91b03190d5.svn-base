//
//  ViewModelClass.m
//  YunShangShiJi
//
//  Created by jingaiweiyi on 16/7/5.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import "PublicViewModel.h"
#import "NetTool.h"
@implementation PublicViewModel
#pragma 获取网络可到达状态
-(void) netWorkStateWithNetConnectBlock: (NetWorkBlock) netConnectBlock WithURlStr: (NSString *) strURl;
{
    BOOL netState = [[NetTool shareManager] netWorkReachabilityWithURLString:strURl];
    netConnectBlock(netState);
}

- (NSMutableArray *)viewModelDataSource
{
    if (!_viewModelDataSource) {
        _viewModelDataSource = [NSMutableArray array];
    }
    return _viewModelDataSource;
}

@end
