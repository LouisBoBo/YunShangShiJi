//
//  WTFAddressView.m
//  YunShangShiJi
//
//  Created by yssj on 16/6/23.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import "WTFAddressView.h"
#import "GlobalTool.h"

#define leftSpace ZOOM(62)

@interface WTFAddressView()

@property (nonatomic, strong) UIButton *btnView;
@property (nonatomic, strong) UIView *topView;
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UIView *emptyView;

@end

@implementation WTFAddressView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setSubView];
    }
    return self;
}
-(void)setSubView
{
    [self addSubview:self.topView];
    [self addSubview:self.emptyView];
    [self addSubview:self.contentView];
    [self addSubview:self.btnView];

    self.type=WTFAddressEmpty;
    
}

-(void)setHiddenTopView:(BOOL)hidden{
    
    self.topView.hidden=hidden;
    self.emptyView.top=hidden?0:ZOOM6(80);
    self.contentView.top=hidden?0:ZOOM6(80);

    [self changeFrame];
}
-(void)changeFrame{
    if (_type==WTFAddressEmpty) {
        _contentView.hidden=YES;_emptyView.hidden=NO;
        self.frame=CGRectMake(0, 0, kScreenWidth,_topView.hidden?ZOOM6(120):ZOOM6(120)+ZOOM6(80));
    }else{
        _emptyView.hidden=YES;_contentView.hidden=NO;
        self.frame=CGRectMake(0, 0, kScreenWidth,_topView.hidden?ZOOM6(190):ZOOM6(190)+ZOOM6(80));
    }
    _line.top=CGRectGetMaxY(self.frame)-ZOOM6(20);

}
-(void)setType:(WTFAddressType)type{
    _type=type;
    [self changeFrame];
}
-(UIButton *)btnView{
    if (_btnView==nil) {
        _btnView=[UIButton buttonWithType:UIButtonTypeCustom];
        _btnView.frame=CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        [_btnView addTarget:self action:@selector(btnViewClick) forControlEvents:UIControlEventTouchUpInside];
    
        _line=[[UIView alloc]initWithFrame:CGRectMake(0, self.frame.size.height-ZOOM6(20), kScreenWidth, ZOOM6(20))];
        _line.backgroundColor=[UIColor colorWithRed:244/255.0 green:244/255.0 blue:244/255.0 alpha:1.0];
        [_btnView addSubview:_line];
    }
    return _btnView;
}
-(void)btnViewClick{
    if (self.btnViewBlock) {
        self.btnViewBlock();
    }
}
- (UIView *)topView {
    if (nil == _topView) {
        _topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, ZOOM6(80))];
        _topView.backgroundColor =  [UIColor colorWithRed:1.0 green:1.0 blue:203/255.0 alpha:1];
        UILabel *label = [[UILabel alloc] init];
        label.textColor = kSubTitleColor;
        label.font = [UIFont systemFontOfSize:ZOOM6(30)];
        label.text = @"存在搭配购商品";
        [_topView addSubview:label];
        
        _subLabel = [[UILabel alloc]init];
        NSString *dpZheKou = [[NSUserDefaults standardUserDefaults]objectForKey:@"dpZheKou"];
        _subLabel.text=[NSString stringWithFormat:@"已享受%.1f折优惠，为你节省¥",dpZheKou.floatValue*10]; //@"已享受9折优惠，为你节省¥";
        _subLabel.font=[UIFont systemFontOfSize:ZOOM6(24)];
        _subLabel.textColor=tarbarrossred;
        [_topView addSubview:_subLabel];
        
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@(leftSpace));
            make.centerY.equalTo(_topView);
        }];
        [_subLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(@(-leftSpace));
            make.centerY.equalTo(_topView);
        }];
    }
    return _topView;
}
-(UIView *)contentView{
    if (_contentView==nil) {
        _contentView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height-ZOOM6(80))];
        
        _contentView.top=ZOOM6(80);
        UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(kApplicationWidth-ZOOM(42)-10, _contentView.frame.size.height/2-15, 10, 30)];
        img.contentMode = UIViewContentModeScaleAspectFit;
        img.image = [UIImage imageNamed:@"更多-副本-3"];
        [_contentView addSubview:img];
        
        _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(leftSpace,_contentView.frame.size.height/3-30, kApplicationWidth, 40)];
        _nameLabel.textColor=kMainTitleColor;
        _nameLabel.font=[UIFont systemFontOfSize:ZOOM(45)];
        _addressLabel = [[UILabel alloc]initWithFrame:CGRectMake(leftSpace, _contentView.frame.size.height/3, kApplicationWidth-leftSpace*2-10, 50)];
        _addressLabel.textColor=kMainTitleColor;
        _addressLabel.font=[UIFont systemFontOfSize:ZOOM(45)];
        _addressLabel.numberOfLines = 0;
        
        [_contentView addSubview:_nameLabel];
        [_contentView addSubview:_addressLabel];
    }
    return _contentView;
}
-(UIView *)emptyView{
    if (_emptyView==nil) {
        _emptyView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, ZOOM6(100))];
        
        _emptyView.top=ZOOM6(80);
        UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(kApplicationWidth-ZOOM(42), _emptyView.frame.size.height/2-15, 10, 30)];
        img.contentMode = UIViewContentModeScaleAspectFit;
        img.image = [UIImage imageNamed:@"更多-副本-3"];
        [_emptyView addSubview:img];
        
        
        UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(leftSpace,_emptyView.frame.size.height/2-15,30, 30)];
        imgView.image = [UIImage imageNamed:@"地址"];
        imgView.contentMode = UIViewContentModeScaleAspectFit;
        
        UILabel *addressLabel = [[UILabel alloc]initWithFrame:CGRectMake(imgView.frame.origin.x + imgView.frame.size.width ,_emptyView.frame.size.height/2-10,kScreenWidth, 20)];
        addressLabel.textColor=kMainTitleColor;
        addressLabel.text = @"请填写收货地址";
        addressLabel.font=[UIFont systemFontOfSize:ZOOM(45)];
        
        [_emptyView addSubview:addressLabel];
        [_emptyView addSubview:imgView];
        
       

    }
    return _emptyView;
}
@end
