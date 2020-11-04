//
//  WTFPickerView.h
//  YunShangShiJi
//
//  Created by yssj on 16/3/28.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^WTFPickerViewSelect)(NSString *selectPickerViewString);

//@protocol WTFPickerViewDelegate <NSObject>
//
//-(void)WTFPickerViewDidClickConfirm:(NSString *)confirmString;
//
//@end

@interface WTFPickerView : UIView<UIPickerViewDataSource,UIPickerViewDelegate>{
    NSArray *_dataArr;//数据
    
    UILabel *_selectLabel;//选择器标题label
    UIButton *_endButton;//确定按钮
    UIButton *_cancleButton;//取消按钮

}
//- (id)initWithDataArr:(NSArray *)dataArr delegate:(id<WTFPickerViewDelegate>)delegate;

- (id)initWithDataArr:(NSArray *)dataArr;

-(void)didFinishSelectedString:(WTFPickerViewSelect)selectPickerViewString;

@property(strong, nonatomic)WTFPickerViewSelect selectBlock;
@property (strong, nonatomic) UIButton *bgButton;

@property (strong, nonatomic) NSString *selectString;

@property (strong, nonatomic) UIView *pickerView;//选择器背景view

@property (strong, nonatomic)UIPickerView *picker;

@property  NSInteger theRow;//确定选择的row

//@property (nonatomic,assign) id<WTFPickerViewDelegate>delegate;
@end
