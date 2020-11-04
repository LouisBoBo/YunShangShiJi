//
//  TFTableViewService.m
//  YunShangShiJi
//
//  Created by jingaiweiyi on 16/7/8.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import "TFTableViewService.h"

@implementation TFTableViewService

#pragma mark Block
- (void)numberOfRowsInSectionBlock:(NumberOfRowsInSectionBlock)numberOfRowsInSectionBlock
{
    self.numberOfRowsInSectionBlock = numberOfRowsInSectionBlock;
}

- (void)cellForRowAtIndexPathBlock:(CellForRowAtIndexPathBlock)cellForRowAtIndexPathBlock
{
    self.cellForRowAtIndexPathBlock = cellForRowAtIndexPathBlock;
}

- (void)heightForRowAtIndexPathBlock:(HeightForRowAtIndexPathBlock)heightForRowAtIndexPathBlock
{
    self.heightForRowAtIndexPathBlock = heightForRowAtIndexPathBlock;
}
- (void)didSelectRowAtIndexPathBlock:(DidSelectRowAtIndexPathBlock)didSelectRowAtIndexPathBlock
{
    self.didSelectRowAtIndexPathBlock = didSelectRowAtIndexPathBlock;
}
#pragma mark - delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.numberOfRowsInSectionBlock) {
        return self.numberOfRowsInSectionBlock(tableView, section);
    } else {
        return [self.dataSource count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.cellForRowAtIndexPathBlock) {
        return self.cellForRowAtIndexPathBlock(tableView, indexPath);
    } else {
        static NSString *idenf = @"cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:idenf];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idenf];
        }
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.heightForRowAtIndexPathBlock) {
        return self.heightForRowAtIndexPathBlock(tableView, indexPath);
    } 
    return 44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.didSelectRowAtIndexPathBlock) {
        self.didSelectRowAtIndexPathBlock(tableView, indexPath);
    }
}

- (NSMutableArray *)dataSource
{
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

@end
