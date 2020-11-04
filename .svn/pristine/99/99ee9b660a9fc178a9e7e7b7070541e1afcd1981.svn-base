//
//  MemberPayStyleTableViewCell.m
//  YunShangShiJi
//
//  Created by hebo on 2019/2/27.
//  Copyright © 2019年 ios-1. All rights reserved.
//

#import "MemberPayStyleTableViewCell.h"
#import "GlobalTool.h"
@implementation MemberPayStyleTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = RGBCOLOR_I(247, 247, 247);
    self.ruleLable.numberOfLines = 0;
    self.ruleLable.textColor = RGBA(125,125,125,1);
    
    self.ruleTitle.font = [UIFont systemFontOfSize:ZOOM6(32)];
    self.ruleLable.font = [UIFont systemFontOfSize:ZOOM6(28)];
    
    NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc]initWithString:self.ruleTitle.text];
    [noteStr addAttribute:NSForegroundColorAttributeName value:RGBA(125,125,125,1) range:NSMakeRange(0, noteStr.length)];
    [noteStr addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:ZOOM6(30)] range:NSMakeRange(0, noteStr.length)];
    [self.ruleTitle setAttributedText:noteStr];
}

- (void)refreshData:(vipDataModel*)ruleModel Price:(NSString*)price Count:(NSString*)count;
{
    self.ruleLable.text = ruleModel.ruledata;
    
    if(ruleModel.markrule.count)
    {
        NSMutableAttributedString *noteStr ;
        if(self.ruleLable.text)
        {
            noteStr = [[NSMutableAttributedString alloc]initWithString:self.ruleLable.text];
            
            for(int i =0;i < ruleModel.markrule.count; i++)
            {
                NSString *str = [NSString stringWithFormat:@"%@",ruleModel.markrule[i]];
                NSRange range = [self.ruleLable.text rangeOfString:str];
                if([str isEqualToString:@"今日剩余免费领商品次数："])
                {
                    [noteStr addAttribute:NSForegroundColorAttributeName value:RGBA(125,125,125,1) range:NSMakeRange(range.location, range.length)];
                    [noteStr addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:ZOOM6(30)] range:NSMakeRange(range.location, range.length)];
                }
                else{
                    
                    NSArray *rangeArray = [self rangeOfSubString:str inString:self.ruleLable.text];
                    for(int k =0;k < rangeArray.count;k++)
                    {
                        NSRange range = [rangeArray[k] rangeValue];
                        [noteStr addAttribute:NSForegroundColorAttributeName value:tarbarrossred range:NSMakeRange(range.location, range.length)];
                        [noteStr addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:ZOOM6(28)] range:NSMakeRange(range.location, range.length)];
                    }
                }
            }
            
            //lable的行间距 段间距
            NSMutableParagraphStyle * paragraphStyle1 = [[NSMutableParagraphStyle alloc] init];
            [paragraphStyle1 setLineSpacing:ZOOM6(4)];
            [paragraphStyle1 setParagraphSpacing:ZOOM6(10)];
            [noteStr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle1 range:NSMakeRange(0, [self.ruleLable.text length])];
            
            [self.ruleLable setAttributedText:noteStr];
        }
    }
}

//获取字符串中多个相同字符串的所有range
- (NSArray*)rangeOfSubString:(NSString*)subStr inString:(NSString*)string {
    NSMutableArray *rangeArray = [NSMutableArray array];
    NSString*string1 = [string stringByAppendingString:subStr];
    NSString *temp;
    for(int i =0; i < string.length; i ++) {
        temp = [string1 substringWithRange:NSMakeRange(i, subStr.length)];
        if ([temp isEqualToString:subStr]) {
            NSRange range = {i,subStr.length};
            [rangeArray addObject: [NSValue valueWithRange:range]];
        }
    }
    return rangeArray;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
