//
//  TFNewBuildViewController.m
//  YunShangShiJi
//
//  Created by 云商 on 15/7/20.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//

#import "TFNewBuildViewController.h"
#import "CityModel.h"
#import "AreaModel.h"
#import "StateModel.h"
#import "TFReceivingAddressViewController.h"
@interface TFNewBuildViewController () <UITextViewDelegate,UIPickerViewDataSource,UIPickerViewDelegate,UITextFieldDelegate>

@property (nonatomic, strong) UIScrollView *backgroundScrollView;

@property (nonatomic, assign)BOOL isBeginEdit;
@property (nonatomic, strong)UILabel *addressLabel; //地址
@property (nonatomic, strong)UITextView *detailTextView; //详细地址

@property (nonatomic, strong)UIView *bgView;
//选择省市区
@property (nonatomic, strong)NSMutableArray *dataArr;
@property (nonatomic, strong)UIPickerView *pickerView;

//地址字符串
@property (nonatomic, copy)NSString *addressStr;
@property (nonatomic, copy)NSString *state; //省
@property (nonatomic, copy)NSString *city; //市
@property (nonatomic, copy)NSString *area; //区
@property (nonatomic, copy)NSString *street; //街道

@property (nonatomic, strong)NSNumber *stateID;
@property (nonatomic, strong)NSNumber *cityID;
@property (nonatomic, strong)NSNumber *areaID;
@property (nonatomic, strong)NSNumber *streetID;
@end

@implementation TFNewBuildViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [super setNavigationItemLeft:@"新建收货地址"];
    [self setupUI];
    
}

- (void)setupUI
{
    //使用 通知  监听键盘出现
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    //监听键盘消失
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    CGFloat Margin_lr = ZOOM(62);
    CGFloat H_textField = ZOOM(120);
    CGFloat Margin_ud =ZOOM(35);
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick:)];
    [self.view addGestureRecognizer:tap];
    
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, kNavigationheightForIOS7, kScreenWidth, kScreenHeight-kNavigationheightForIOS7)];
    [self.view addSubview:_backgroundScrollView = scrollView];
    
    NSArray *titleArr = [NSArray arrayWithObjects:@"收件人姓名",@"手机号码",@"省-市-区",@"详情地址", nil];
    for (int i = 0; i<titleArr.count; i++) {
        if ([titleArr[i] isEqualToString:@"收件人姓名"] || [titleArr[i] isEqualToString:@"手机号码"]) {
            UITextField *tf = [[UITextField alloc] initWithFrame:CGRectMake(Margin_lr, ZOOM(80)+i*H_textField+i*Margin_ud, kScreenWidth-2*Margin_lr, H_textField)];
            tf.borderStyle = UITextBorderStyleRoundedRect;
            
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, ZOOM(300), tf.frame.size.height)];
            label.textColor = RGBACOLOR_F(0.5,0.5,0.5,0.6);
            tf.tag = 200+i;
            label.text = [NSString stringWithFormat:@"  %@",titleArr[i]];
            label.font = kFont6px(32);
            tf.leftView = label;
            tf.delegate = self;
            tf.leftViewMode = UITextFieldViewModeAlways;
            [self.backgroundScrollView addSubview:tf];
            if (![titleArr[i] isEqualToString:@"手机号码"]) {
                tf.returnKeyType = UIReturnKeyNext;
            } else {
                tf.returnKeyType = UIReturnKeyDone;
                if ([[NSUserDefaults standardUserDefaults] objectForKey:USER_PHONE]) {
                    
                    NSString *phone = [NSString stringWithFormat:@"%@", [[NSUserDefaults standardUserDefaults] objectForKey:USER_PHONE]];
                    tf.text = phone;
                }
            }
        }
        if ([titleArr[i] isEqualToString:@"省-市-区"]) {
            UITextField *tf = (UITextField *)[self.view viewWithTag:201];
            
            UIView *backview = [[UIView alloc]initWithFrame:CGRectMake(Margin_lr,  tf.bottom+Margin_ud, kScreenWidth-2*Margin_lr, tf.frame.size.height)];
            backview.layer.borderWidth = 1;
            backview.layer.borderColor = [RGBCOLOR_I(220,220,220) CGColor];
            backview.layer.cornerRadius = ZOOM(15);
            backview.tag = 200+i;
            [self.backgroundScrollView addSubview:backview];
            
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(ZOOM(22), 0, ZOOM(250), tf.frame.size.height)];
            label.text = [NSString stringWithFormat:@"%@",titleArr[i]];
            label.textAlignment = NSTextAlignmentLeft;
            label.font = kFont6px(32);
            label.textColor = RGBACOLOR_F(0.5,0.5,0.5,0.6);
            label.font = [UIFont systemFontOfSize:ZOOM(48)];
            [backview addSubview:label];
            
            self.addressLabel = [[UILabel alloc] initWithFrame:CGRectMake( label.right, label.frame.origin.y, kScreenWidth-Margin_lr- label.right, label.frame.size.height)];
            self.addressLabel.font = kFont6px(32);
            self.addressLabel = [[UILabel alloc] initWithFrame:CGRectMake( label.right, label.frame.origin.y, kScreenWidth-(20)- label.right-(5)- Margin_lr, label.frame.size.height)];
            self.addressLabel.font = kFont6px(32);
            self.addressLabel.numberOfLines = 0;
//            self.addressLabel.adjustsFontSizeToFitWidth = YES;

            [backview addSubview:self.addressLabel];
            
            UIView *line = [[UIView alloc] initWithFrame:CGRectMake(Margin_lr,  label.bottom+ZOOM(10), tf.frame.size.width, 1)];
            line.backgroundColor = RGBCOLOR_I(220,220,220);
            
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(0, 0, tf.frame.size.width, tf.frame.size.height);
            [backview addSubview:btn];
            [btn addTarget:self action:@selector(addressBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            

        }
        if ([titleArr[i] isEqualToString:@"详情地址"]) {
            UIView *lv = (UIView *)[self.view viewWithTag:202];
            
            self.detailTextView = [[UITextView alloc] initWithFrame:CGRectMake(Margin_lr,  lv.bottom+ZOOM(30), lv.frame.size.width, ZOOM(200))];
            self.detailTextView.text = titleArr[i];
            self.detailTextView.textColor = RGBCOLOR_I(152,152,152);
            self.detailTextView.scrollEnabled = YES;
            self.detailTextView.font = kFont6px(32);
            self.detailTextView.delegate = self;
            self.detailTextView.layer.borderWidth = 1;
            self.detailTextView.layer.borderColor = [RGBCOLOR_I(220,220,220) CGColor];
            self.detailTextView.showsVerticalScrollIndicator = NO;
            self.detailTextView.layer.masksToBounds = YES;
            self.detailTextView.layer.cornerRadius = ZOOM(10);
            [self.backgroundScrollView addSubview:self.detailTextView];
            
            CGFloat H_btn = ZOOM(120);
//            CGFloat Margin_ud_btn = ZOOM(300);
            
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(Margin_lr, CGRectGetMaxY(self.detailTextView.frame)+kZoom6pt(200), kScreenWidth-2*Margin_lr, H_btn);
            [btn setBackgroundImage:[UIImage imageNamed:@"退出账号框"] forState:UIControlStateNormal];
            [btn setBackgroundImage:[UIImage imageNamed:@"退出账号框高亮"] forState:UIControlStateHighlighted];
            [btn setTitle:@"保存" forState:UIControlStateNormal];
            btn.titleLabel.font = kFont6px(32);
//            [btn setTitleColor:COLOR_ROSERED forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(saveBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            btn.tag = 100;
//            [self.backgroundScrollView addSubview:btn];
        }
    }
    
//    UIButton *btn = (UIButton *)[self.backgroundScrollView viewWithTag:100];
    
    self.backgroundScrollView.contentSize = CGSizeMake(0, CGRectGetMaxY(self.detailTextView.frame)+ZOOM(62));
    [self performSelector:@selector(showKeyBord) withObject:nil afterDelay:0.6];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"保存" forState:UIControlStateNormal];
    [self.navigationView addSubview:btn];
    [btn addTarget:self action:@selector(saveBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn setTitleColor:COLOR_ROSERED forState:UIControlStateHighlighted];
    btn.titleLabel.font = [UIFont systemFontOfSize:15];
    ESWeak(self, weakSelf);
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.navigationView).offset(10);
        make.right.equalTo(weakSelf.navigationView.mas_right).offset(-5);
        make.size.mas_equalTo(CGSizeMake(80, 44));
    }];
    
}

- (void)showKeyBord
{
    UITextField *tf = (UITextField *)[self.backgroundScrollView viewWithTag:200];
    [tf becomeFirstResponder];
}
- (void)createPickView
{
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    self.bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    self.bgView.backgroundColor = RGBACOLOR_F(0.5,0.5,0.5,0.6);
    [window addSubview:self.bgView];
    
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, self.bgView.frame.size.height-216, kScreenWidth, 216)];
    bottomView.backgroundColor = [UIColor whiteColor];
    [self.bgView addSubview:bottomView];
    
    //创建PickView
    UIPickerView *pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 216)];
    pickerView.dataSource = self;
    pickerView.delegate = self;
    pickerView.showsSelectionIndicator = YES;
    self.pickerView = pickerView;
    [bottomView addSubview:self.pickerView];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(barButton:)];
    UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 35)];
    UIBarButtonItem *spaceItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    toolBar.items = @[spaceItem,spaceItem,spaceItem,spaceItem,spaceItem,spaceItem,spaceItem,spaceItem,item,spaceItem];
    [bottomView addSubview:toolBar];
    
}

#pragma mark - 按钮
//保存
- (void)saveBtnClick:(UIButton *)sender
{
    UITextField *tf1 = (UITextField *)[self.view viewWithTag:200];
    UITextField *tf2 = (UITextField *)[self.view viewWithTag:201];
//    UITextField *tf3 = (UITextField *)[self.view viewWithTag:202];
    
    BOOL phoneBl = [self isString:tf2.text toCompString:@"1234567890"]; //检查手机号
//    BOOL postBl = [self isString:tf3.text toCompString:NUMBER]&&(tf3.text.length==6);
    BOOL beginEdBl = self.isBeginEdit;                               //检查是否输入详细地址
    BOOL adressBl = ![self.detailTextView.text isEqualToString:@""]; //输入了详细地址
    BOOL adressLengthBl = [MyMD5 asciiLengthOfString:self.detailTextView.text]<=50;;
    BOOL nameBl = (![tf1.text isEqualToString:@""])&&([MyMD5 asciiLengthOfString:tf1.text]<=8);
    
//    //nameBl = %d", nameBl);
//    //length = %d, adressLengthBl = %d", (int)self.detailTextView.text.length,adressLengthBl);
    
    if ([TFPublicClass stringContainsEmoji:tf1.text] || [TFPublicClass stringContainsEmoji:tf2.text]|| [TFPublicClass stringContainsEmoji:self.detailTextView.text]) {
        [MBProgressHUD showError:@"不支持Emoji表情符号!"];
        return;
    }
    
    if (nameBl&&phoneBl&&adressBl&&beginEdBl&&self.addressStr!=nil&&adressLengthBl) {
        [self httpAddAddress];
    } else if (!nameBl) {
        if([tf1.text isEqualToString:@""]||tf1.text.length==0){
            [MBProgressHUD showError:@"收货人姓名不能为空"];
        }else
            [MBProgressHUD showError:@"收货人姓名不得超过8个字符"];
    } else if (!phoneBl) {
        if([tf2.text isEqualToString:@""]||tf2.text.length==0){
            [MBProgressHUD showError:@"手机号码不能为空"];
        }else
            [MBProgressHUD showError:@"请输入正确的手机号!"];
    }
//    else if (!postBl) {
//        [MBProgressHUD showError:@"邮编为6位数字!"];
//    }
    else if (!adressBl&&beginEdBl) {
        [MBProgressHUD showError:@"请输入详细地址!"];
    } else if (!beginEdBl) {
        [MBProgressHUD showError:@"请输入详细地址!"];
    } else if (!adressLengthBl) {
        [MBProgressHUD showError:@"详细地址大于50字符,保存失败"];
    } else if (self.addressStr ==nil) {
        [MBProgressHUD showError:@"请选择省-市-区"];
    } else {
        [MBProgressHUD showError:@"请正确输入!"];
    }
}
//省市区
- (void)addressBtnClick:(UIButton *)sender
{
    [self.view endEditing:YES];
    [self createPickView];
}

//完成按钮
- (void)barButton:(UIBarButtonItem *)sender
{
    self.state = nil;
    self.city = nil;
    self.area = nil;
    self.street = nil;
    
    NSInteger com0Row = [self.pickerView selectedRowInComponent:0]; //获取0列点行
    NSInteger com1Row = [self.pickerView selectedRowInComponent:1];
    NSInteger com2Row = [self.pickerView selectedRowInComponent:2];
    NSInteger com3Row = [self.pickerView selectedRowInComponent:3];
    
    StateModel *model;
    CityModel *model1;
    AreaModel *model2;
    StreetModel *model3;

    if (self.dataArr.count>com0Row) {
        model = self.dataArr[com0Row];
        self.state = model.state;
        self.stateID = model.ID;
    }
    if (model.CITIES.count>com1Row) {
        model1 = model.CITIES[com1Row];
        self.city = model1.city;
        self.cityID = model1.ID;
    }
    if (model1.AREAS.count>com2Row) {
        model2 = model1.AREAS[com2Row];
        self.area = model2.area;
        self.areaID = model2.ID;
    }
    if (model2.STREETS.count>com3Row) {
        model3 = model2.STREETS[com3Row];
        self.street = model3.street;
        self.streetID = model3.ID;
    }
    
    //判断
    if (self.areaID == nil) {
        self.areaID = @0;
    }
    if (self.streetID == nil) {
        self.streetID = @0;
    }
    
    if (self.area!=nil&&self.street!=nil) {
        self.addressStr = [NSString stringWithFormat:@"%@-%@-%@-%@",self.state,self.city,self.area,self.street];
    } else if (self.street == nil&&self.area!=nil) {
        self.addressStr = [NSString stringWithFormat:@"%@-%@-%@",self.state,self.city,self.area];
    } else if (self.area == nil) {
        self.addressStr = [NSString stringWithFormat:@"%@-%@",self.state,self.city];
    }
    
    self.addressLabel.text = self.addressStr;
    [self.bgView removeFromSuperview];
}

#pragma mark - 网络相关
//添加地址
- (void)httpAddAddress
{
    UITextField *tf1 = (UITextField *)[self.view viewWithTag:200];
    UITextField *tf2 = (UITextField *)[self.view viewWithTag:201];
//    UITextField *tf3 = (UITextField *)[self.view viewWithTag:202];
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *token = [ud objectForKey:USER_TOKEN];
    NSString *address = self.detailTextView.text; //详细地址
    NSString *consignee = tf1.text;               //收货人
    NSString *phone = tf2.text;                   //号码
//    NSString *postcode = tf3.text;                //邮编
    
    NSString *urlStr = [NSString stringWithFormat:@"%@address/insert?version=%@&token=%@&province=%@&city=%@&area=%@&street=%@&address=%@&consignee=%@&phone=%@",[NSObject baseURLStr],VERSION,token,self.stateID,self.cityID,self.areaID,self.streetID,address,consignee,phone];
    NSString *URL = [MyMD5 authkey:urlStr];
    //URL = %@",URL);
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:URL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //
        responseObject = [NSDictionary changeType:responseObject];
        if (responseObject!=nil) {
            if ([responseObject[@"status"] intValue] == 1) {
                //添加成功
                [MBProgressHUD showSuccess:@"添加成功"];
                
                for (UIViewController *view in self.navigationController.viewControllers) {
                    if ([view isKindOfClass:[TFReceivingAddressViewController class]]) {
                        [(TFReceivingAddressViewController*)view httpReceivingAddress];
                    }
                }
//                TFReceivingAddressViewController *tfRv = (TFReceivingAddressViewController *)self.navigationController.viewControllers[self.navigationController.viewControllers.count-2];
//                
//                [tfRv httpReceivingAddress];
                
                [self.navigationController popViewControllerAnimated:YES];
            } else {
                [MBProgressHUD showError:responseObject[@"message"]];
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        [MBProgressHUD showError:@"网络连接失败,请检查网络设置"];
        NavgationbarView *mentionview=[[NavgationbarView alloc]init];
        [mentionview showLable:@"网络开小差啦,请检查网络" Controller:self];
    }];
}

#pragma mark - textField相关

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField.tag == 201) {
        if (range.location>=11) {
//            return NO;
        }
    } else if (textField.tag == 202) {
        if (range.location>=6) {
//            return NO;
        }
    }
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{

    if (textField.tag < 201) {
        //注销当前文本为第一响应者 (此时无文本编辑，键盘会自动收起)
        //        [textField resignFirstResponder];
        //成为第一响应者，（让键盘出来）
        //        [textField becomeFirstResponder];
        UITextField *tf = (UITextField *)[self.view viewWithTag:textField.tag+1];
//        MyLog(@"tf = %@",tf);
        //再让其成为第一响应者 , (此时自动弹出键盘)
        [tf becomeFirstResponder];
    } else if (textField.tag == 201){
        [self.view endEditing:YES];
    }
    return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    [UIView animateWithDuration:0.8 animations:^{
        [self.backgroundScrollView setContentOffset:CGPointMake(0, 0)];
    }];
    return YES;
}

#pragma mark - textView相关
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    
    if (kDevice_Is_iPhone4) {
        [UIView animateWithDuration:0.8 animations:^{
            [self.backgroundScrollView setContentOffset:CGPointMake(0, 80)];
        }];
    } else if (kDevice_Is_iPhone5) {
        [UIView animateWithDuration:0.8 animations:^{
            [self.backgroundScrollView setContentOffset:CGPointMake(0, 0)];
        }];
    } else if (kDevice_Is_iPhone6) {
        [UIView animateWithDuration:0.8 animations:^{
            [self.backgroundScrollView setContentOffset:CGPointMake(0, 0)];
        }];
    } else if (kDevice_Is_iPhone6Plus) {
        [UIView animateWithDuration:0.8 animations:^{
            [self.backgroundScrollView setContentOffset:CGPointMake(0, 0)];
        }];
    }
    
    if ([textView.text isEqualToString:@"详情地址"]&&self.isBeginEdit==NO) {
        textView.text = @"";
        self.isBeginEdit = YES;
        textView.textColor = [UIColor blackColor];
        return YES;
    } else {
        return YES;
    }
}

#pragma mark - PickView相关
//返回多少列
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 4;
}


//返回某一列多少行
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component == 0) {           //第0列
        return [self.dataArr count];
    } else if (component == 1) {    //第1列
        NSInteger zeroRow = [self.pickerView selectedRowInComponent:0];         //第0列选择的行
        if (self.dataArr.count>zeroRow) {
            StateModel *model = self.dataArr[zeroRow];
            return [model.cities count];
        }
    } else if (component == 2) {
        NSInteger zeroRow = [self.pickerView selectedRowInComponent:0];         //第0列选中的行
        NSInteger firstRow = [self.pickerView selectedRowInComponent:1];        //第1列选中的行
        if (self.dataArr.count>zeroRow) {
            StateModel *model = self.dataArr[zeroRow];
            if (model.CITIES.count>firstRow) {
                CityModel *sModel = model.CITIES[firstRow];
                return [sModel.areas count];
            }
        }
    } else if (component == 3) {
        NSInteger zeroRow = [self.pickerView selectedRowInComponent:0];         //第0列选中的行
        NSInteger firstRow = [self.pickerView selectedRowInComponent:1];        //第1列选中的行
        NSInteger twoRow = [self.pickerView selectedRowInComponent:2];          //第2列选中的行
        if (self.dataArr.count>zeroRow) {
            StateModel *sModel = self.dataArr[zeroRow];
            if (sModel.CITIES.count>firstRow) {
                CityModel *cModel = sModel.CITIES[firstRow];
                if (cModel.AREAS.count>twoRow) {
                    AreaModel *aModel = cModel.AREAS[twoRow];
                    return [aModel.streets count];
                }
            }
        }
    } else {
        return 0;
    }
    return 0;
}
//某一行显示的内容
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (component == 0) {
        StateModel *model = self.dataArr[row];
        return model.state;
    } else if (component == 1) {
        //第0列选择的行
        NSInteger zeroRow = [self.pickerView selectedRowInComponent:0];
        if (self.dataArr.count>zeroRow) {
            StateModel *model = self.dataArr[zeroRow];
            if (model.CITIES.count>row) {
                CityModel *sModel = model.CITIES[row];
                return sModel.city;
            }
        }
    } else if (component == 2) {
        NSInteger zeroRow = [self.pickerView selectedRowInComponent:0];
        NSInteger firstRow = [self.pickerView selectedRowInComponent:1];
        
        if (self.dataArr.count>zeroRow) {
            StateModel *model = self.dataArr[zeroRow];
            if (model.CITIES.count>firstRow) {
                CityModel *sModel = model.CITIES[firstRow];
                if (sModel.AREAS.count>row) {
                    AreaModel *ssModel = sModel.AREAS[row];
                    return ssModel.area;
                }
            }
        }
    } else if (component == 3) {
        NSInteger zeroRow = [self.pickerView selectedRowInComponent:0];         //第0列选中的行
        NSInteger firstRow = [self.pickerView selectedRowInComponent:1];        //第1列选中的行
        NSInteger twoRow = [self.pickerView selectedRowInComponent:2];          //第2列选中的行
        
        if (self.dataArr.count>zeroRow) {
            StateModel *model = self.dataArr[zeroRow];
            if (model.CITIES.count>firstRow) {
                CityModel *sModel = model.CITIES[firstRow];
                if (sModel.AREAS.count>twoRow) {
                    AreaModel *ssModel = sModel.AREAS[twoRow];
                    if (ssModel.STREETS.count>row) {
                        StreetModel *stModel = ssModel.STREETS[row];
                        return stModel.street;
                    }
                }
            }
        }

    }
    return nil;
}

//调整字体
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel* pickerLabel = (UILabel*)view;
    if (!pickerLabel){
        pickerLabel = [[UILabel alloc] init];
        // Setup label properties - frame, font, colors etc
        //adjustsFontSizeToFitWidth property to YES
        pickerLabel.adjustsFontSizeToFitWidth = YES;
        pickerLabel.textAlignment = NSTextAlignmentCenter;
        [pickerLabel setBackgroundColor:[UIColor clearColor]];
        [pickerLabel setFont:[UIFont boldSystemFontOfSize:16]];
    }
    // Fill the label text here
    pickerLabel.textAlignment = NSTextAlignmentCenter;
    pickerLabel.adjustsFontSizeToFitWidth = YES;
    
//    pickerLabel.backgroundColor  =COLOR_RANDOM;
    
    pickerLabel.text = [self pickerView:pickerView titleForRow:row forComponent:component];
    return pickerLabel;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    
    return kScreenWidth/4.0;
}

//滑动事件
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (component == 0) { //第0列
        [self.pickerView selectRow:0 inComponent:1 animated:NO];
        [self.pickerView selectRow:0 inComponent:2 animated:NO];
        [self.pickerView selectRow:0 inComponent:3 animated:NO];
        [self.pickerView reloadComponent:1];
        [self.pickerView reloadComponent:2];
        [self.pickerView reloadComponent:3];
    } else if (component == 1) {
        [self.pickerView selectRow:0 inComponent:2 animated:NO];
        [self.pickerView selectRow:0 inComponent:3 animated:NO];
        [self.pickerView reloadComponent:2];
        [self.pickerView reloadComponent:3];
    } else if (component == 2) {
        [self.pickerView selectRow:0 inComponent:3 animated:NO];
        [self.pickerView reloadComponent:3];
    }
}

#pragma mark - 懒加载数据
- (NSMutableArray *)dataArr
{
    if (_dataArr == nil) {
        _dataArr = [[NSMutableArray alloc] init];
        NSArray *array = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"areatbl" ofType:@"plist"]];
        for (NSDictionary *dic in array) { //存储模型
            StateModel *model = [[StateModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            model.ID = dic[@"id"];
            [_dataArr addObject:model];
        }
    }
    return _dataArr;
}

#pragma mark - 键盘出现和消失
//键盘出现
- (void)keyboardWillShow:(NSNotification *)noti
{
    //键盘高度
    //    CGFloat keyboardHeight = [noti.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
    
}

//键盘消失,其他坐标归位
- (void)keyboardWillHide:(NSNotification *)noti
{
    [UIView animateWithDuration:0.8 animations:^{
        self.backgroundScrollView.contentOffset = CGPointMake(0, 0);
    }];
}

//- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
//{
//    [self.view endEditing:YES];
//    [UIView animateWithDuration:0.8 animations:^{
//        self.view.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
//    }];
//}
- (void)tapClick:(UITapGestureRecognizer *)tap
{
    [self.view endEditing:YES];
    [UIView animateWithDuration:0.8 animations:^{
        self.backgroundScrollView.contentOffset = CGPointMake(0, 0);
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
