//
//  WTFPickerView.m
//  YunShangShiJi
//
//  Created by yssj on 16/3/28.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import "WTFPickerView.h"
#define kWinH [[UIScreen mainScreen] bounds].size.height
#define kWinW [[UIScreen mainScreen] bounds].size.width
#define kBackgroundColor [UIColor colorWithRed:234/255.0 green:234/255.0 blue:234/255.0 alpha:1.0]
#define kTextBlueColor  [UIColor colorWithRed:30/255.0 green:181/255.0 blue:250/255.0 alpha:200/255.0]

// pickerView高度
#define kPVH (kWinH*0.35>230?230:(kWinH*0.35<200?200:kWinH*0.35))


@implementation WTFPickerView{

}


- (id)initWithDataArr:(NSArray *)dataArr 
{

    if (self = [super initWithFrame:[[UIScreen mainScreen] bounds]]) {

        
        [[[UIApplication sharedApplication] keyWindow] addSubview:self];
        //半透明背景按钮
        _bgButton = [[UIButton alloc] init];
        [self addSubview:_bgButton];
        [_bgButton addTarget:self action:@selector(dismissDatePicker) forControlEvents:UIControlEventTouchUpInside];
//        _bgButton.backgroundColor = [UIColor blackColor];
//        _bgButton.alpha = 0.2;
        _bgButton.frame = CGRectMake(0, 0, kWinW, kWinH);
        _bgButton.userInteractionEnabled=YES;
        
        
        _dataArr=dataArr;
        //生成选择器
        _pickerView=[[UIView alloc] initWithFrame:CGRectMake(0, kWinH, kWinW, kPVH)];
        _pickerView.backgroundColor=[UIColor whiteColor];
        [self addSubview:_pickerView];
        
        _picker=[[UIPickerView alloc]initWithFrame:CGRectMake(0, 0, kWinW, kPVH)];
        _picker.backgroundColor=kBackgroundColor;
        _picker.delegate=self;
        _picker.dataSource=self;
        _picker.userInteractionEnabled=YES;
        [_pickerView addSubview:_picker];
        
//        _selectLabel=[[UILabel alloc] initWithFrame:CGRectMake(0,0,kWinW/2,20)];
//        _selectLabel.text=title;
//        _selectLabel.textAlignment=NSTextAlignmentCenter;
//        _selectLabel.textColor=[UIColor darkGrayColor];
//        _selectLabel.backgroundColor=[UIColor whiteColor];
//        [_pickerView addSubview:_selectLabel];
        
        
//        _cancleButton=[UIButton buttonWithType:UIButtonTypeCustom];
//        _cancleButton.frame=CGRectMake(0,0,kWinW/2,20);
//        _cancleButton.frame=CGRectMake(10, 5, 50, 35);
//        [_cancleButton setTitle:@"取消" forState:UIControlStateNormal];
//        _cancleButton.userInteractionEnabled=YES;
//        [_cancleButton addTarget:self action:@selector(dismissDatePicker) forControlEvents:UIControlEventTouchUpInside];
//        [_cancleButton setTitleColor:kTextBlueColor forState:UIControlStateNormal];
//        _cancleButton.backgroundColor=[UIColor grayColor];
//        [_pickerView addSubview:_cancleButton];
        
        _endButton=[UIButton buttonWithType:UIButtonTypeCustom];
        _endButton.frame=CGRectMake(kWinW-60, 5, 50, 35);
        [_endButton setTitle:@"确定" forState:UIControlStateNormal];
        _endButton.userInteractionEnabled=YES;
        [_endButton addTarget:self action:@selector(confirmBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_endButton setTitleColor:kTextBlueColor forState:UIControlStateNormal];
//        _endButton.backgroundColor=[UIColor grayColor];
        [_pickerView addSubview:_endButton];
 
        
        [self pushDatePicker];
    }
    return self;
}

#pragma mark pickerViewDelegate
//列数
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}
//行数
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return _dataArr.count;
}
//每列显示的标题
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [_dataArr objectAtIndex:row];
}
//行高
//-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
//{
//    return 50;
//}
//选定row
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    _theRow=row;
}
-(UIView*)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, kWinW, 40)];
    label.textAlignment=NSTextAlignmentCenter;
    label.font=[UIFont systemFontOfSize:17];
    label.text=_dataArr[row];
    
    return label;
    
}



//确定
- (void)confirmBtnClick:(id)sender
{

    [self dismissDatePicker];
    
    if (_selectBlock) {
        _selectBlock([_dataArr objectAtIndex:_theRow]);
    }
}
-(void)didFinishSelectedString:(WTFPickerViewSelect)selectPickerViewString
{
    _selectBlock=selectPickerViewString;
}
//出现
- (void)pushDatePicker
{
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.2 animations:^{
        weakSelf.pickerView.frame = CGRectMake(0, kWinH - kPVH, kWinW, kPVH);
//        weakSelf.bgButton.alpha = 0.2;
    }];
}

//消失
- (void)dismissDatePicker
{
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.2 animations:^{
        weakSelf.pickerView.frame = CGRectMake(0, kWinH, kWinW, kPVH);
//        weakSelf.bgButton.alpha = 0.0;
    } completion:^(BOOL finished) {
        [weakSelf.pickerView removeFromSuperview];
        [weakSelf.bgButton removeFromSuperview];
        [weakSelf removeFromSuperview];
    }];
}

@end
