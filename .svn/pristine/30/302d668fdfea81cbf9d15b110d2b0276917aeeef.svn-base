//
//  OrderFootView.m
//  YunShangShiJi
//
//  Created by yssj on 16/6/24.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import "OrderFootView.h"
#import "GlobalTool.h"

#define leftSpace ZOOM(62)
#define rightSpace ZOOM(42)


@interface OrderFootView ()

@property (nonatomic,strong)UIView *contentView;

@end

@implementation OrderFootView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.contentView];
    }
    return self;
}
-(void)hidBottomLabel:(NSInteger)label hidden:(BOOL)hidden{
    switch (label) {
        case 2:
            _bottomLabel2.hidden=hidden;_bottomMoneyLabel2.hidden=hidden;
            _bottomLabel3.top += hidden?-ZOOM(100):ZOOM(100);
            _bottomLabel4.top += hidden?-ZOOM(100):ZOOM(100);
            break;
        case 3:
            _bottomLabel3.hidden=hidden;_bottomMoneyLabel3.hidden=hidden;
            _bottomLabel4.top += hidden?-ZOOM(100):ZOOM(100);
            break;
        case 4:
            _bottomLabel4.hidden=hidden;_bottomMoneyLabel4.hidden=hidden;
            _bottomLabel4.top += hidden?-ZOOM(100):ZOOM(100);
            break;
        case 5:
            _bottomLabel5.hidden=hidden;_bottomMoneyLabel5.hidden=hidden;
            break;
        case 6:
            _bottomLabel6.hidden=hidden;_bottomMoneyLabel6.hidden=hidden;
            break;
        case 7:
            _bottomLabel7.hidden=hidden;_bottomMoneyLabel7.hidden=hidden;
            break;
        default:
            break;
    }
    self.height += hidden?-ZOOM(100):ZOOM(100);

    _bottomLabel5.top = _bottomLabel5.hidden?_bottomLabel4.top:_bottomLabel4.top+ZOOM(100);
    _bottomLabel6.top = _bottomLabel5.top+ZOOM(100);
    _bottomLabel7.top = _bottomLabel6.top+ZOOM(100);

    _bottomMoneyLabel3.top=_bottomLabel3.top;
    _bottomMoneyLabel4.top=_bottomLabel4.top;
    _bottomMoneyLabel5.top=_bottomLabel5.top;
    _bottomMoneyLabel6.top=_bottomLabel6.top;
    _bottomMoneyLabel7.top=_bottomLabel7.top;

    
}

-(UIView *)contentView{
    if (_contentView==nil) {
        _contentView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth,self.frame.size.height)];
        
        UIView *line6=[[UIView alloc]initWithFrame:CGRectMake(0, 10, kScreenWidth, ZOOM6(20))];
        line6.backgroundColor=[UIColor colorWithRed:244/255.0 green:244/255.0 blue:244/255.0 alpha:1.0];
        [_contentView addSubview:line6];
        
        
        CGFloat yPoint=CGRectGetMaxY(line6.frame)+ZOOM(20);
        NSArray *array=@[@"商品金额",@"运费",@"搭配购",@"抵用券",@"预存抵扣",@"优惠券",@"积分"];

        _bottomLabel1=[[UILabel alloc]initWithFrame:CGRectMake(leftSpace, yPoint, kScreenWidth/2, ZOOM(100))];
        _bottomLabel2=[[UILabel alloc]initWithFrame:CGRectMake(leftSpace, yPoint+ZOOM(100), kScreenWidth/2, ZOOM(100))];
        _bottomLabel3=[[UILabel alloc]initWithFrame:CGRectMake(leftSpace, yPoint+ZOOM(100)*2, kScreenWidth/2, ZOOM(100))];
        _bottomLabel4=[[UILabel alloc]initWithFrame:CGRectMake(leftSpace, yPoint+ZOOM(100)*3, kScreenWidth/2, ZOOM(100))];
        _bottomLabel5=[[UILabel alloc]initWithFrame:CGRectMake(leftSpace, yPoint+ZOOM(100)*4, kScreenWidth/2, ZOOM(100))];
        _bottomLabel6=[[UILabel alloc]initWithFrame:CGRectMake(leftSpace, yPoint+ZOOM(100)*5, kScreenWidth/2, ZOOM(100))];
        _bottomLabel7=[[UILabel alloc]initWithFrame:CGRectMake(leftSpace, yPoint+ZOOM(100)*6, kScreenWidth/2, ZOOM(100))];

        _bottomLabel1.text=array[0];
        _bottomLabel2.text=array[1];
        _bottomLabel3.text=array[2];
        _bottomLabel4.text=array[3];
        _bottomLabel5.text=array[4];
        _bottomLabel6.text=array[5];
        _bottomLabel7.text=array[6];

        _bottomLabel1.textColor=kMainTitleColor;
        _bottomLabel2.textColor=kMainTitleColor;
        _bottomLabel3.textColor=kMainTitleColor;
        _bottomLabel4.textColor=kMainTitleColor;
        _bottomLabel5.textColor=kMainTitleColor;
        _bottomLabel6.textColor=kMainTitleColor;
        _bottomLabel7.textColor=kMainTitleColor;

        _bottomLabel1.font=[UIFont systemFontOfSize:ZOOM(48)];
        _bottomLabel2.font=[UIFont systemFontOfSize:ZOOM(48)];
        _bottomLabel3.font=[UIFont systemFontOfSize:ZOOM(48)];
        _bottomLabel4.font=[UIFont systemFontOfSize:ZOOM(48)];
        _bottomLabel5.font=[UIFont systemFontOfSize:ZOOM(48)];
        _bottomLabel6.font=[UIFont systemFontOfSize:ZOOM(48)];
        _bottomLabel7.font=[UIFont systemFontOfSize:ZOOM(48)];

        
        [_contentView addSubview:_bottomLabel1];
        [_contentView addSubview:_bottomLabel2];
        [_contentView addSubview:_bottomLabel3];
        [_contentView addSubview:_bottomLabel4];
        [_contentView addSubview:_bottomLabel5];
        [_contentView addSubview:_bottomLabel6];
        [_contentView addSubview:_bottomLabel7];

        
        _bottomMoneyLabel1=[[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth/2-rightSpace, yPoint, kScreenWidth/2, ZOOM(100))];
        _bottomMoneyLabel2=[[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth/2-rightSpace, yPoint+ZOOM(100), kScreenWidth/2, ZOOM(100))];
        _bottomMoneyLabel3=[[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth/2-rightSpace, yPoint+ZOOM(100)*2, kScreenWidth/2, ZOOM(100))];
        _bottomMoneyLabel4=[[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth/2-rightSpace, yPoint+ZOOM(100)*3, kScreenWidth/2, ZOOM(100))];
        _bottomMoneyLabel5=[[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth/2-rightSpace, yPoint+ZOOM(100)*4, kScreenWidth/2, ZOOM(100))];
        _bottomMoneyLabel6=[[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth/2-rightSpace, yPoint+ZOOM(100)*5, kScreenWidth/2, ZOOM(100))];
        _bottomMoneyLabel7=[[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth/2-rightSpace, yPoint+ZOOM(100)*6, kScreenWidth/2, ZOOM(100))];



        _bottomMoneyLabel1.textColor=tarbarrossred;
        _bottomMoneyLabel2.textColor=tarbarrossred;
        _bottomMoneyLabel3.textColor=tarbarrossred;
        _bottomMoneyLabel4.textColor=tarbarrossred;
        _bottomMoneyLabel5.textColor=tarbarrossred;
        _bottomMoneyLabel6.textColor=tarbarrossred;
        _bottomMoneyLabel7.textColor=tarbarrossred;

        _bottomMoneyLabel1.font=[UIFont systemFontOfSize:ZOOM(48)];
        _bottomMoneyLabel2.font=[UIFont systemFontOfSize:ZOOM(48)];
        _bottomMoneyLabel3.font=[UIFont systemFontOfSize:ZOOM(48)];
        _bottomMoneyLabel4.font=[UIFont systemFontOfSize:ZOOM(48)];
        _bottomMoneyLabel5.font=[UIFont systemFontOfSize:ZOOM(48)];
        _bottomMoneyLabel6.font=[UIFont systemFontOfSize:ZOOM(48)];
        _bottomMoneyLabel7.font=[UIFont systemFontOfSize:ZOOM(48)];

        _bottomMoneyLabel1.textAlignment=NSTextAlignmentRight;
        _bottomMoneyLabel2.textAlignment=NSTextAlignmentRight;
        _bottomMoneyLabel3.textAlignment=NSTextAlignmentRight;
        _bottomMoneyLabel4.textAlignment=NSTextAlignmentRight;
        _bottomMoneyLabel5.textAlignment=NSTextAlignmentRight;
        _bottomMoneyLabel6.textAlignment=NSTextAlignmentRight;
        _bottomMoneyLabel7.textAlignment=NSTextAlignmentRight;
        
        
        _bottomLabel1.hidden = NO;
        _bottomLabel2.hidden = NO;
        _bottomLabel3.hidden = NO;
        _bottomLabel4.hidden = NO;
        _bottomLabel5.hidden = NO;
        _bottomLabel6.hidden = NO;
        _bottomLabel7.hidden = NO;
        
        _bottomMoneyLabel1.hidden = NO;
        _bottomMoneyLabel2.hidden = NO;
        _bottomMoneyLabel3.hidden = NO;
        _bottomMoneyLabel4.hidden = NO;
        _bottomMoneyLabel5.hidden = NO;
        _bottomMoneyLabel6.hidden = NO;
        _bottomMoneyLabel7.hidden = NO;

        [_contentView addSubview:_bottomMoneyLabel1];
        [_contentView addSubview:_bottomMoneyLabel2];
        [_contentView addSubview:_bottomMoneyLabel3];
        [_contentView addSubview:_bottomMoneyLabel4];
        [_contentView addSubview:_bottomMoneyLabel5];
        [_contentView addSubview:_bottomMoneyLabel6];
        [_contentView addSubview:_bottomMoneyLabel7];

        
    }
    
    return _contentView;
}


@end
