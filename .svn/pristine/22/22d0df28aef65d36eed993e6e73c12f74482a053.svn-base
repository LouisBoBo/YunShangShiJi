//
//  TFTableViewBaseCell.m
//  YunShangShiJi
//
//  Created by 云商 on 15/7/13.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//

#import "TFTableViewBaseCell.h"

@implementation TFTableViewBaseCell

- (BOOL)isString:(NSString *)Sstring toCompString:(NSString *)CompString
{
    if (Sstring.length!=0) {

        NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:CompString] invertedSet];
        NSArray *arrayStr = [Sstring componentsSeparatedByCharactersInSet:cs];

        NSString *tmpStr = [arrayStr componentsJoinedByString:@""];

        BOOL bl = [Sstring isEqualToString:tmpStr];
        return bl;
    } else
        return NO;
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
