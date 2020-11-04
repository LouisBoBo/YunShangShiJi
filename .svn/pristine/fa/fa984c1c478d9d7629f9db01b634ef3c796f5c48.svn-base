//
//  LabelCollectionViewCell.m
//  FJWaterfallFlow
//
//  Created by ios-1 on 2016/12/26.
//  Copyright © 2016年 fujin. All rights reserved.
//

#import "LabelCollectionViewCell.h"
#import "GlobalTool.h"
@implementation LabelCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectbtn.backgroundColor = [UIColor whiteColor];
    [self.selectbtn setTintColor:RGBCOLOR_I(168, 168,168)];
}

- (void)setCellData:(HobbyModel *)dataModel
{
    [self.selectbtn setTitle:dataModel.title forState:UIControlStateNormal];
    [self.selectbtn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    
    if(dataModel.is_SaleMark)
    {
        [self.selectbtn setBackgroundImage:[UIImage imageNamed:@"wodexihao_xuanzhong"] forState:UIControlStateNormal];
         [self.selectbtn setTintColor:tarbarrossred];
    }else{
        [self.selectbtn setBackgroundImage:[UIImage imageNamed:@"wodexihao_moren"] forState:UIControlStateNormal];
         [self.selectbtn setTintColor:RGBCOLOR_I(168, 168,168)];
    }

}

- (void)click:(UIButton*)sender
{
    if(self.clickBlock)
    {
        self.clickBlock();
    }
}
@end
