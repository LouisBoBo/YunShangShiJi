//
//  membersCell.m
//  YunShangShiJi
//
//  Created by yssj on 15/10/27.
//  Copyright © 2015年 ios-1. All rights reserved.
//

#import "membersCell.h"
#import "GlobalTool.h"
#import "MyMD5.h"
#import "UIImageView+WebCache.h"

#define kLabelColor RGBCOLOR_I(102, 102, 102)
#define kLabelFont ZOOM(35)

const CGFloat kLabelWidth = 80;
const CGFloat kHeadImgWidth = 85;
@implementation membersCell

- (void)awakeFromNib {
    // Initialization code
    
    _headImg.frame=CGRectMake(ZOOM(40), ZOOM(55), kHeadImgWidth, kHeadImgWidth);
    _nameLabel.frame=CGRectMake(CGRectGetMaxX(_headImg.frame)+ZOOM(42), ZOOM(60), 200, 25);
    _card_noLabel.frame=CGRectMake(_nameLabel.frame.origin.x, CGRectGetMaxY(_nameLabel.frame)+ZOOM(20), 320, 21);
    _addressImg.frame=CGRectMake(_nameLabel.frame.origin.x, CGRectGetMaxY(_card_noLabel.frame)+ZOOM(20), 18, 18);
    _addressLabel.frame=CGRectMake(CGRectGetMaxX(_addressImg.frame)+ZOOM(10), _addressImg.frame.origin.y, 90, 21);
    _phoneImg.frame=CGRectMake(CGRectGetMaxX(_addressLabel.frame)+ZOOM(20), _addressImg.frame.origin.y, 18, 18);
    _phoneLabel.frame=CGRectMake(CGRectGetMaxX(_phoneImg.frame)+ZOOM(10), _addressImg.frame.origin.y, 120, 21);
    _membersLabel.frame=CGRectMake(kScreenWidth-ZOOM(40)-kLabelWidth, ZOOM(66), kLabelWidth, 21);
    _moneyLabel.frame=CGRectMake(kScreenWidth-ZOOM(40)-kLabelWidth, ZOOM(66), kLabelWidth, 21);

    
    
    _plaintextLabel.frame=CGRectMake(kScreenWidth-ZOOM(40)-_card_noLabel.frame.size.width, _card_noLabel.frame.origin.y, _card_noLabel.frame.size.width, 21);
    
    _plaintextLabel.textAlignment=NSTextAlignmentRight;
    _membersLabel.textAlignment=NSTextAlignmentRight;
    _moneyLabel.textAlignment=NSTextAlignmentRight;

    
    _moneyLabel.textColor=tarbarrossred;
    _plaintextLabel.textColor=kLabelColor;
    _card_noLabel.textColor=kLabelColor;
    _addressLabel.textColor=kLabelColor;
    _phoneLabel.textColor=kLabelColor;
    _nameLabel.textColor=kLabelColor;
    _membersLabel.textColor=kLabelColor;
    _nameLabel.font = [UIFont systemFontOfSize:kLabelFont];
    _card_noLabel.font = [UIFont systemFontOfSize:kLabelFont];
    _addressLabel.font = [UIFont systemFontOfSize:kLabelFont];
    _phoneLabel.font = [UIFont systemFontOfSize:kLabelFont];
    _plaintextLabel.font = [UIFont systemFontOfSize:kLabelFont];
    _moneyLabel.font = [UIFont systemFontOfSize:kLabelFont];

    _membersLabel.font = [UIFont systemFontOfSize:kLabelFont];
    
    _headImg.backgroundColor = DRandomColor;
//    _addressImg.backgroundColor=DRandomColor;
//    _phoneImg.backgroundColor=DRandomColor;
    
//    [_membersLabel setAttributedText:[self changString:@"12" withString:@"个成员" fontSize:kLabelFont colorName:tarbarrossred]];
//    [_nameLabel setAttributedText:[self changString:@"某某某" withString:@"  (Justin Grey)" fontSize:ZOOM(40) colorName:[UIColor blackColor]]];
}
-(NSMutableAttributedString *)changString:(NSString *)str withString:(NSString *)str2 fontSize:(CGFloat )fontSize    colorName:(UIColor *)name
{
    NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@%@",str,str2]];
    NSRange redRange = NSMakeRange(0, str.length);
    [noteStr addAttributes:@{NSForegroundColorAttributeName:name,NSFontAttributeName:[UIFont systemFontOfSize:fontSize]} range:redRange];
 
    return noteStr;
}

-(void)refreshModel:(DistributionModel *)model
{
    if ([model.start_time isEqual:[NSNull null]]||model.start_time==nil) {
        [_nameLabel setAttributedText:[self changString:model.nickname withString:@"" fontSize:ZOOM(40) colorName:[UIColor blackColor]]];
    }else
        [_nameLabel setAttributedText:[self changString:[NSString stringWithFormat:@"%@      ",model.nickname] withString:[MyMD5 getTimeToShowWithTimestampHour:model.start_time] fontSize:ZOOM(40) colorName:[UIColor blackColor]]];

    [_phoneLabel setText:model.phone];
    [_timeLabel setText:[MyMD5 getTimeToShowWithTimestampHour:model.time]];
    
    

    if ([model.pic hasPrefix:@"http://"]) {
        [_headImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",model.pic]]];
    }else{
        [_headImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", [NSObject baseURLStr_Upy],model.pic]]];

    }


    if (model.phone==nil||[model.phone isEqual:[NSNull null]]) {
        _phoneImg.hidden=YES; _phoneLabel.hidden=YES;
    }

    if (model.count==nil) {
           [_membersLabel setAttributedText:[self changString:@"0" withString:@"个成员" fontSize:kLabelFont colorName:tarbarrossred]];
    }else
           [_membersLabel setAttributedText:[self changString:model.count withString:@"个成员" fontSize:kLabelFont colorName:tarbarrossred]];
    
    if (model.city!=nil&&model.province!=nil) {
        NSArray *array=[self getAddressStateID:model.province withCityID:model.city witAreaID:nil withStreetID:nil];
        [_addressLabel setText:[NSString stringWithFormat:@"%@%@",array[0],array[1]]];
    }else
    {
        _addressImg.hidden=YES; _addressLabel.hidden=YES;
        _phoneImg.frame=CGRectMake(_nameLabel.frame.origin.x, CGRectGetMaxY(_card_noLabel.frame)+ZOOM(20), 18, 18);
        _phoneLabel.frame=CGRectMake(CGRectGetMaxX(_phoneImg.frame)+ZOOM(10), _phoneImg.frame.origin.y, 100, 21);
    }
    _card_noLabel.text=[NSString stringWithFormat:@"卡号:%@  激活码:%@",model.card_no,model.plaintext];
//    _plaintextLabel.text=[NSString stringWithFormat:@"激活码:%@",model.plaintext];

    
    if (model.money==nil) {
        _moneyLabel.text = @"+0.00";
    }else
        _moneyLabel.text = [NSString stringWithFormat:@"+%.2f",model.money.floatValue];

    
    
    
}
#pragma mark - 获取地址
- (NSArray *)getAddressStateID:(NSNumber *)stateNum withCityID:(NSNumber *)cityNum witAreaID:(NSNumber *)areaNum withStreetID:(NSNumber *)streetNum
{
    NSString *state;
    NSString *city;
    NSString *area;
    NSString *street;
    
    NSArray *stateArr = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"areatbl" ofType:@"plist"]];
    if ([stateNum intValue]!=0) { //查询省
        for (NSDictionary *dic in stateArr) {
            if ([dic[@"id"] intValue] == [stateNum intValue]) { //找到省
                state = dic[@"state"];
                if ([cityNum intValue]!=0) {
                    NSArray *citiesArr = dic[@"cities"];
                    for (NSDictionary *dic in citiesArr) {
                        if ([dic[@"id"] intValue] == [cityNum intValue]) { //找到市
                            city = dic[@"city"];
                            if ([areaNum intValue]!=0) {
                                NSArray *areasArr = dic[@"areas"];
                                for (NSDictionary *dic in areasArr) {
                                    if ([dic[@"id"] intValue] == [areaNum intValue]) { //找到区
                                        area = dic[@"area"];
                                        if ([streetNum intValue]!=0) {
                                            NSArray *streetsArr = dic[@"streets"];
                                            for (NSDictionary *dic in streetsArr) {
                                                if ([streetNum intValue] == [dic[@"id"] intValue]) { //找到街道
                                                    street = dic[@"street"];
                                                    break;
                                                }
                                            }
                                        }
                                        break;
                                    }
                                }
                            }
                            break;
                        }
                    }
                }
                break;
            }
        }
    }
    if (area!=nil&&street!=nil) {
        return [NSArray arrayWithObjects:state,city,area,street, nil];
    } else if (area!=nil&&street == nil) {
        return [NSArray arrayWithObjects:state,city,area, nil];
    } else if (area ==nil&&street == nil) {
        return [NSArray arrayWithObjects:state,city, nil];
    } else
        return nil;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    self.selectionStyle=UITableViewCellSelectionStyleNone;
    // Configure the view for the selected state
}

@end
