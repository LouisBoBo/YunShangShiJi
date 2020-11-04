//
//  DiscountViewController.m
//  YunShangShiJi
//
//  Created by ios-1 on 15/10/30.
//  Copyright © 2015年 ios-1. All rights reserved.
//

#import "DiscountViewController.h"
#import "GlobalTool.h"
#import "KeyboardTool.h"

#define fildFont ZOOM(48)
@interface DiscountViewController ()<KeyboardToolDelegate>
{
    KeyboardTool *_keyboardtool;
    UITextField *_discountfild;
    UITextView *_textview;
}
@end

@implementation DiscountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self creatKeyboard];
    
    [self creatNavagation];
    
    [self creatView];
}

-(void)creatNavagation
{
    //导航条
    UIImageView *headview=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kApplicationWidth, Height_NavBar)];
    //
    headview.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:headview];
    headview.userInteractionEnabled=YES;
    
    UIButton *backbtn=[UIButton buttonWithType:UIButtonTypeCustom];
    backbtn.frame=CGRectMake(0, 20, 44, 44);
    backbtn.centerY = View_CenterY(headview);
    [backbtn setImage:[UIImage imageNamed:@"返回按钮_正常"] forState:UIControlStateNormal];
    [backbtn addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    [headview addSubview:backbtn];
    
    UILabel *titlelable=[[UILabel alloc]init];
    titlelable.frame=CGRectMake(0, 0, 300, 40);
    titlelable.center=CGPointMake(kApplicationWidth/2, headview.frame.size.height/2+10);
    titlelable.text=@"会员折扣";
    titlelable.font = kNavTitleFontSize;
    titlelable.textColor=kMainTitleColor;
    titlelable.textAlignment=NSTextAlignmentCenter;
    [headview addSubview:titlelable];
    
   

}
-(void)creatKeyboard
{
    _keyboardtool = [KeyboardTool keyboardTool];
    _keyboardtool.delegate = self;
    _keyboardtool.frame=CGRectMake(0, _keyboardtool.frame.origin.y, kScreenWidth, 40);
}


#pragma mark 创建界面
-(void)creatView
{
    //会员折扣
    self.view.backgroundColor = kBackgroundColor;
    
    UIView *discountview =[[UIView alloc]initWithFrame:CGRectMake(0, ZOOM(100)+Height_NavBar, kApplicationWidth, ZOOM(150))];
    discountview.backgroundColor = [UIColor whiteColor];
    
    UILabel *consumptionlable =[[UILabel alloc]initWithFrame:CGRectMake(ZOOM(60), ZOOM(30), ZOOM(220), ZOOM(90))];
    consumptionlable.text = @"会员折扣:";
    consumptionlable.textColor = kTextColor;
    consumptionlable.font = [UIFont systemFontOfSize:fildFont];
    [discountview addSubview:consumptionlable];

    
    _discountfild =[[UITextField alloc]initWithFrame:CGRectMake(ZOOM(60)+consumptionlable.frame.size.width, 0, discountview.frame.size.width-2*ZOOM(60)-consumptionlable.frame.size.width, discountview.frame.size.height)];
    
    if(!self.discount.length == 0)
    {
        NSArray *arr =[self.discount componentsSeparatedByString:@":"];
        if(arr.count == 2)
        {
            NSString *str = arr[1];
            _discountfild.text = [NSString stringWithFormat:@"%.1f",str.floatValue];
        }
        
    }
    else{
        _discountfild.text = @"";
    }
   
    _discountfild.textColor = kTextColor;
    _discountfild.inputAccessoryView = _keyboardtool;
    _discountfild.font = [UIFont systemFontOfSize:ZOOM(48)];
    [discountview addSubview:_discountfild];
    
    [self.view addSubview:discountview];
    
    //会员折扣说明
    CGFloat discriptionviewY =CGRectGetMaxY(discountview.frame);
    UIView *discriptionview =[[UIView alloc]initWithFrame:CGRectMake(0, ZOOM(60)+discriptionviewY, kApplicationWidth, ZOOM(230))];
    discriptionview.backgroundColor = [UIColor whiteColor];
    
    _textview = [[UITextView alloc]initWithFrame:CGRectMake(ZOOM(42), 0, kApplicationWidth-2*ZOOM(42), discriptionview.frame.size.height)];
    
    if(!self.discountCription.length == 0)
    {
        _textview.text = self.discountCription;
    }
    else{
        _textview.text = @"会员折扣说明(限制15字)";
    }

    _textview.textColor = kTextColor;
    _textview.delegate = self;
    _textview.tag = 888;
    _textview.inputAccessoryView = _keyboardtool;
    _textview.font = [UIFont systemFontOfSize:ZOOM(48)];
    [discriptionview addSubview:_textview];
    
    [self.view addSubview:discriptionview];
}

//键盘
- (void)keyboardTool:(KeyboardTool *)keyboardTool itemClick:(KeyboardToolItemType)itemType
{
    if (itemType == KeyboardToolItemTypePrevious) { // 上一个
        //----上一个----");
    } else if (itemType == KeyboardToolItemTypeNext) { // 下一个
        //----下一个----");
    } else { // 完成
        //----完成----");
        if(_textview.text.length == 0)
        {
            _textview.text = @"会员折扣说明(限制15字)";
        }
        
        [self.view endEditing:YES];
    }
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
-(void)textViewDidBeginEditing:(UITextView *)textView
{
    textView.text=@"";
}
-(void)back:(UIButton*)sender
{
    if(_discountfild.text.length != 0 && _textview.text.length !=0)
    {
        NSMutableArray *arr = [[NSMutableArray alloc]init];
        [arr addObject:_discountfild.text];
        [arr addObject:_textview.text];
        

        if(arr.count)
        {
        
            NSNotification *note =[NSNotification notificationWithName:@"discount" object:arr];
            [[NSNotificationCenter defaultCenter] postNotification:note];
        }
        
        
    }

    
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}


@end
