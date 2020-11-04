//
//  RemenComtCollectionViewCell.m
//  YunShangShiJi
//
//  Created by ios-1 on 2017/2/15.
//  Copyright © 2017年 ios-1. All rights reserved.
//

#import "RemenComtCollectionViewCell.h"
#import "GlobalTool.h"
@implementation RemenComtCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.title.textColor = tarbarrossred;
    self.line.frame = CGRectMake((kScreenWidth-ZOOM6(260))/2, self.line.frame.origin.y, ZOOM6(260), self.line.frame.size.height);
    self.title.frame = CGRectMake((kScreenWidth-ZOOM6(160))/2, self.title.frame.origin.y, ZOOM6(160), self.title.frame.size.height);
}
- (void)refreshTitle:(NSString*)title
{
    if([title hasPrefix:@"查看全部"])
    {
        self.line.hidden = YES;
        self.title.frame = CGRectMake((kScreenWidth-ZOOM6(360))/2, self.title.frame.origin.y, ZOOM6(360), self.title.frame.size.height);
    }else{
        self.line.hidden = NO;
    }
    self.title.text = title;
}
- (void)dealloc
{
    NSLog(@"释放了");
}

@end
