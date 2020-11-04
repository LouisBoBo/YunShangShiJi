//
//  BrokerageCell.m
//  YunShangShiJi
//
//  Created by yssj on 15/10/28.
//  Copyright © 2015年 ios-1. All rights reserved.
//

#import "BrokerageCell.h"
#import "GlobalTool.h"
#import "MyMD5.h"

@implementation BrokerageCell

- (void)awakeFromNib {
    // Initialization code
    _nameLabel.frame=CGRectMake(ZOOM(56), ZOOM(67), kScreenWidth/2-ZOOM(56), 25);
    _moneyLabel.frame=CGRectMake(kScreenWidth/2-ZOOM(73),_nameLabel.frame.origin.y, kScreenWidth/2, _nameLabel.frame.size.height);
    _timeLabel.frame=CGRectMake(_nameLabel.frame.origin.x, CGRectGetMaxY(_nameLabel.frame)+ZOOM(10), _nameLabel.frame.size.width, _nameLabel.frame.size.height);
    _successLabel.frame=CGRectMake(kScreenWidth/2-ZOOM(80), _timeLabel.frame.origin.y, _moneyLabel.frame.size.width, _timeLabel.frame.size.height);
    
    _nameLabel.font=[UIFont systemFontOfSize:ZOOM(48)];
    _moneyLabel.font=[UIFont systemFontOfSize:ZOOM(50)];
    _timeLabel.font=[UIFont systemFontOfSize:ZOOM(40)];
    _successLabel.font=[UIFont systemFontOfSize:ZOOM(40)];
    _moneyLabel.textColor=tarbarrossred;
    _timeLabel.textColor=RGBCOLOR_I(152, 152, 152);
    _successLabel.textColor=RGBCOLOR_I(152, 152, 152);
    

}
-(void)refreshModel:(DistributionModel *)model
{
    _nameLabel.text=[NSString stringWithFormat:@"%@",model.NICKNAME];
    _timeLabel.text=[MyMD5 getTimeToShowWithTimestamp:[NSString stringWithFormat:@"%@",model.add_date]];
    _moneyLabel.text=[NSString stringWithFormat:@"%.2f",model.money.floatValue];
    
    switch (model.is_free.intValue) {
        case 1:
            _successLabel.text=@"成功";
            break;
        case 0:
        {
            if (model.status.intValue==1) {
                _successLabel.text=@"失败";

            }else
                _successLabel.text=@"冻结";
        }
            break;
        default:
            break;
    }
    
}
-(void)refreshModelWithdrawals:(DistributionModel *)model
{
    _nameLabel.text=[NSString stringWithFormat:@"%@****%@",model.collect_bank_name,model.collect_bank_code];
    _timeLabel.text=[MyMD5 getTimeToShowWithTimestamp:[NSString stringWithFormat:@"%@",model.add_date]];
    _moneyLabel.text=[NSString stringWithFormat:@"%@",model.money];
    
    switch (model.check.intValue) {
        case 0:
            _successLabel.text=@"待审核";
            break;
        case 1:
            _successLabel.text=@"通过";
            break;
        case 2:
            _successLabel.text=@"不通过";
            break;
        case 3:
            _successLabel.text=@"成功到账";
            break;
        default:
            break;
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
