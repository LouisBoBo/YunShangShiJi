//
//  SalePurchasePListCell.m
//  YunShangShiJi
//
//  Created by 云商 on 15/12/2.
//  Copyright © 2015年 ios-1. All rights reserved.
//

#import "SalePurchasePListCell.h"

@implementation SalePurchasePListCell

- (void)awakeFromNib {
    // Initialization code
    self.W_progressView.constant = ZOOM(110*3.375);
    self.W_nameLabel.constant = ZOOM(80*3.375);
    
    /**
     @property (weak, nonatomic) IBOutlet UILabel *foreTitleLabel;
     @property (weak, nonatomic) IBOutlet UILabel *nameLabel;
     @property (weak, nonatomic) IBOutlet UILabel *postLabel;
     */
    
    self.foreTitleLabel.font = [UIFont systemFontOfSize:ZOOM(40)];
    self.nameLabel.font = [UIFont systemFontOfSize:ZOOM(40)];
    self.postLabel.font = [UIFont systemFontOfSize:ZOOM(40)];
    
}

- (void)receiveDataModel:(SalePListModel *)model
{
    NSArray *numArr = [NSArray arrayWithObjects:@"零",@"一", @"二", @"三", @"四", @"五", @"六", @"七", @"八", @"九", @"十", @"十一", @"十二", @"十三", @"十四", @"十五", nil];
    
    NSString *numST = numArr[model.shopNum];
    
    NSString *st;
    NSMutableAttributedString *maStr;
    if (model.shopNum == 0||model.shopNum == 1) {
        st = [NSString stringWithFormat:@"邮费%@元",model.postage];
        maStr = [[NSMutableAttributedString alloc] initWithString:st];
        [maStr addAttributes:@{NSForegroundColorAttributeName:COLOR_ROSERED} range:NSMakeRange(2, st.length-3)];
    } else {
        st = [NSString stringWithFormat:@"%@件邮费%@元", numST,model.postage];
        maStr = [[NSMutableAttributedString alloc] initWithString:st];
        [maStr addAttributes:@{NSForegroundColorAttributeName:COLOR_ROSERED} range:NSMakeRange(4, st.length-5)];
    }
    
    NSMutableAttributedString *maNameStr;
    NSString *nameSt = [NSString stringWithFormat:@"%@", model.name];
    
    if ([self.type isEqualToString:@"1"]) {
        maNameStr = [[NSMutableAttributedString alloc] initWithString:nameSt];
    } else {
        NSString *priSt;
        if ([self.type isEqualToString:@"2"]) {
            priSt = @"9元";
        } else if ([self.type isEqualToString:@"3"]) {
            priSt = @"19元";
        } else if ([self.type isEqualToString:@"4"]) {
            priSt = @"29元";
        }
        
        NSString *stTemp = [NSString stringWithFormat:@"%@%@", nameSt, priSt];

        maNameStr = [[NSMutableAttributedString alloc] initWithString:stTemp];
        
        [maNameStr addAttributes:@{NSForegroundColorAttributeName:COLOR_ROSERED} range:NSMakeRange(nameSt.length, stTemp.length-nameSt.length)];
    }
    
    
    self.nameLabel.attributedText = maNameStr;
    
//    if (model.shopNum == 1) {
//        self.nameLabel.text = @"超值单品";
//    } else if (model.shopNum >1) {
//        self.nameLabel.text = @"超值套餐";
//    }
    
    self.postLabel.attributedText = maStr;
    
    if ([model.r_num intValue]<=[model.num intValue] && model.r_num!=nil) {

        if([model.r_num intValue] !=0 && [model.num intValue]!=0) {
            self.W_foreView.constant = (float)[model.r_num intValue]/[model.num intValue]*self.W_progressView.constant;
        }
    } else {
        self.W_foreView.constant = self.W_progressView.constant*0;
    }
    
    if ([model.r_num intValue]>=0 && model.r_num!=nil) {
        self.foreTitleLabel.text = [NSString stringWithFormat:@"仅剩%@套", model.r_num];
    } else {
        self.foreTitleLabel.text = [NSString stringWithFormat:@"仅剩0套"];
    }

    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
