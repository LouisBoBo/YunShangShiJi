//
//  HZAreaPickerView.m
//  areapicker
//
//  Created by Cloud Dai on 12-9-9.
//  Copyright (c) 2012年 clouddai.com. All rights reserved.
//

#import "HZAreaPickerView.h"
#import <QuartzCore/QuartzCore.h>
#import "GlobalTool.h"
#define kDuration 0.3

@interface HZAreaPickerView ()
{
    NSArray *provinces, *cities, *areas, *strees;
    UIView *bottomView;
}
@property (strong, nonatomic)UIView *bgView;

@end

@implementation HZAreaPickerView

@synthesize delegate=_delegate;
@synthesize pickerStyle=_pickerStyle;
@synthesize locate=_locate;
@synthesize locatePicker = _locatePicker;

- (void)dealloc
{
//    [_locate release];
//    [_locatePicker release];
//    [provinces release];
//    [super dealloc];
}

-(HZLocation *)locate
{
    if (_locate == nil) {
        _locate = [[HZLocation alloc] init];
    }
    
    return _locate;
}

-(UIView*)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel *vvvvv=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, kApplicationWidth/3, 40)];
    vvvvv.textAlignment=NSTextAlignmentCenter;
    vvvvv.font=[UIFont systemFontOfSize:15];
    
     if (self.pickerStyle == HZAreaPickerWithStateAndCityAndDistrict||self.pickerStyle==HZAddress)
     {
    if(component==0)
    {
       
        vvvvv.text=[[provinces objectAtIndex:row] objectForKey:@"state"];
       
        return vvvvv;
    }else if (component==1)
    {

        vvvvv.text=[[cities objectAtIndex:row] objectForKey:@"city"];

        return vvvvv;
        
    }else if (component==2)
    {
        vvvvv.text=[[areas objectAtIndex:row] objectForKey:@"area"];

        return vvvvv;
        
    }
     }else{
         if(strees)
         {
             vvvvv.text=[[strees objectAtIndex:row]objectForKey:@"street"];
         }
         return vvvvv;
     }
   
    return 0;
}


- (id)initWithStyle:(HZAreaPickerStyle)pickerStyle delegate:(id<HZAreaPickerDelegate>)delegate
{
    
    self = [[[NSBundle mainBundle] loadNibNamed:@"HZAreaPickerView" owner:self options:nil] objectAtIndex:0];
    if (self) {
        self.delegate = delegate;
        self.pickerStyle = pickerStyle;
        self.locatePicker.dataSource = self;
        self.locatePicker.delegate = self;
        
        //加载数据
        if (self.pickerStyle == HZAreaPickerWithStateAndCityAndDistrict||self.pickerStyle==HZAddress) {
            provinces = [[NSArray alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"areatbl.plist" ofType:nil]];
            cities = [[provinces objectAtIndex:0] objectForKey:@"cities"];
            
            self.locate.state = [[provinces objectAtIndex:0] objectForKey:@"state"];
            self.locate.stateID = [[provinces objectAtIndex:0] objectForKey:@"id"];
            
            self.locate.city = [[cities objectAtIndex:0] objectForKey:@"city"];
            self.locate.cityID = [[cities objectAtIndex:0] objectForKey:@"id"];
            
            areas = [[cities objectAtIndex:0] objectForKey:@"areas"];
            if (areas.count > 0 ) {
                self.locate.district = [areas objectAtIndex:0];
                self.locate.districtID = [areas objectAtIndex:0];
            } else{
                self.locate.district = @"";
            }
            
            
        } else{
           
            NSUserDefaults *userdefaul=[NSUserDefaults standardUserDefaults];
            NSString *ID= [userdefaul objectForKey:ADDRESS_ID];
            NSArray *arr=[ID componentsSeparatedByString:@"_"];
            
            
            
            provinces = [[NSArray alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"areatbl.plist" ofType:nil]];
            
            
            cities = [[provinces objectAtIndex:0] objectForKey:@"cities"];
        
            
            areas = [[cities objectAtIndex:0] objectForKey:@"areas"];
            
            NSString *provincesid=[NSString stringWithFormat:@"%@",arr[0]];
            NSString *citiesid=[NSString stringWithFormat:@"%@",arr[1]];
            NSString *areasid=[NSString stringWithFormat:@"%@",arr[2]];
            
            for(NSDictionary *dic in provinces)
            {
                NSString *ID=[NSString stringWithFormat:@"%@",dic[@"id"]];
                if([ID isEqualToString:provincesid] )
                {
                    //dic is %@",dic[@"state"]);
                    cities=dic[@"cities"];
                    for (NSDictionary *dic1 in cities) {
                        NSString *ID1=[NSString stringWithFormat:@"%@",dic1[@"id"]];
                        if([ID1 isEqualToString:citiesid])
                        {
                             //dic is %@",dic1[@"city"]);
                            areas=dic1[@"areas"];
                            for(NSDictionary *dic2 in areas)
                            {
                                  NSString *ID2=[NSString stringWithFormat:@"%@",dic2[@"id"]];
                                    if([ID2 isEqualToString:areasid])
                                    {
                                        //dic is %@",dic2[@"area"]);
                                        strees=dic2[@"streets"];
                                    }
                            
                            }
                        }
                    }
                }
            }
            
        }
    }
    
    
    if(strees.count)
    {
        self.locate.street=[[strees objectAtIndex:0]objectForKey:@"street"];
        self.locate.streetID=[[strees objectAtIndex:0]objectForKey:@"id"];
    }
    return self;
    
}

- (NSString*)fromIDgetAddress:(NSString *)addressID
{
    NSMutableString *addressString=[NSMutableString string];
    
    NSString *ID= addressID;
    NSArray *arr=[ID componentsSeparatedByString:@"_"];
    
    provinces = [[NSArray alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"areatbl.plist" ofType:nil]];
    
    cities = [[provinces objectAtIndex:0] objectForKey:@"cities"];
    
    areas = [[cities objectAtIndex:0] objectForKey:@"areas"];
    
    NSString *provincesid=[NSString stringWithFormat:@"%@",arr[0]];
    NSString *citiesid=[NSString stringWithFormat:@"%@",arr[1]];
    NSString *areasid=[NSString stringWithFormat:@"%@",arr[2]];
    NSString *streetid;
    if(arr.count==4)
    {
        streetid=[NSString stringWithFormat:@"%@",arr[3]];
    }
    
    NSUserDefaults *userdefaul=[NSUserDefaults standardUserDefaults];
    for(NSDictionary *dic in provinces)//省
    {
        NSString *ID=[NSString stringWithFormat:@"%@",dic[@"id"]];
        if([ID isEqualToString:provincesid] )
        {
            //dic is %@",dic[@"state"]);
            [addressString appendString:dic[@"state"]];
            
            cities=dic[@"cities"];
            for (NSDictionary *dic1 in cities) {//市
                NSString *ID1=[NSString stringWithFormat:@"%@",dic1[@"id"]];
                if([ID1 isEqualToString:citiesid])
                {
                    //dic is %@",dic1[@"city"]);
                    [addressString appendString:dic1[@"city"]];
                    areas=dic1[@"areas"];
                    for(NSDictionary *dic2 in areas)//区
                    {
                        NSString *ID2=[NSString stringWithFormat:@"%@",dic2[@"id"]];
                        if([ID2 isEqualToString:areasid])
                        {
                            //dic is %@",dic2[@"area"]);
                            [addressString appendString:dic2[@"area"]];
                            [userdefaul setObject:addressString forKey:ORDER_STATE_CITY_AREA];
                            
                            strees=dic2[@"streets"];
                            if(strees.count)
                            {
                                for(NSDictionary *dic3 in strees)//区
                                {
                                    NSString *ID3=[NSString stringWithFormat:@"%@",dic3[@"id"]];
                                    if([ID3 isEqualToString:streetid])
                                    {
                                        //dic is %@",dic3[@"street"]);
                                        [addressString appendString:dic3[@"street"]];
                                       
                                       
                                        [userdefaul setObject:dic3[@"street"] forKey:ORDER_STREET];
                                    }
                                    
                                }

                            }
                        }
                        
                    }
                }
            }
        }
    }
    
    return addressString;
}


#pragma mark - PickerView lifecycle 滑轮的数目

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    if (self.pickerStyle == HZAreaPickerWithStateAndCityAndDistrict) {
        return 3;
    } else if(self.pickerStyle==HZAddress){
        return 2;
    }else
        return 1;
}

#pragma mark 返回省 市 区 数目
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (self.pickerStyle == HZAreaPickerWithStateAndCityAndDistrict||self.pickerStyle==HZAddress)
    {
        switch (component) {
        case 0:
            return [provinces count];//省
            break;
        case 1:
            return [cities count];//市
            break;
        case 2:
            if (self.pickerStyle == HZAreaPickerWithStateAndCityAndDistrict) {
            
                return [areas count];//区
                break;
            }
        default:
            return 0;
            break;
        }
    }else{
        return [strees count];//街道
    }
}

#pragma mark 返回省 市 区 名称
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (self.pickerStyle == HZAreaPickerWithStateAndCityAndDistrict||self.pickerStyle==HZAddress) {
        switch (component) {
            case 0:
                return [[provinces objectAtIndex:row] objectForKey:@"state"];
                break;
            case 1:
                return [[cities objectAtIndex:row] objectForKey:@"city"];
                break;
            case 2:
                if ([areas count] > 0) {
                    return [[areas objectAtIndex:row] objectForKey:@"area"];
                    break;
                }
            default:
                return  @"";
                break;
        }
    } else{
        if(strees.count)
        {
            return [[strees objectAtIndex:row] objectForKey:@"street"];
        }
    }
    return 0;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (self.pickerStyle == HZAreaPickerWithStateAndCityAndDistrict) {
        switch (component) {
            case 0:
                cities = [[provinces objectAtIndex:row] objectForKey:@"cities"];
                [self.locatePicker selectRow:0 inComponent:1 animated:YES];
                [self.locatePicker reloadComponent:1];
                
                areas = [[cities objectAtIndex:0] objectForKey:@"areas"];
                [self.locatePicker selectRow:0 inComponent:2 animated:YES];
                [self.locatePicker reloadComponent:2];
                
                self.locate.state = [[provinces objectAtIndex:row] objectForKey:@"state"];
                self.locate.stateID=[[provinces objectAtIndex:row] objectForKey:@"id"];
                
                self.locate.city = [[cities objectAtIndex:0] objectForKey:@"city"];
                self.locate.cityID =[[cities objectAtIndex:0] objectForKey:@"id"];
                
                if ([areas count] > 0 ) {
                    self.locate.district = [[areas objectAtIndex:0] objectForKey:@"area"];
                    self.locate.districtID = [[areas objectAtIndex:0] objectForKey:@"id"];
                } else{
                    self.locate.district = @"";
                }
                break;
            case 1:
                areas = [[cities objectAtIndex:row] objectForKey:@"areas"];
                [self.locatePicker selectRow:0 inComponent:2 animated:YES];
                [self.locatePicker reloadComponent:2];
                
                self.locate.city = [[cities objectAtIndex:row] objectForKey:@"city"];
                self.locate.cityID =[[cities objectAtIndex:row] objectForKey:@"id"];
                if ([areas count] > 0) {
                    self.locate.district = [[areas objectAtIndex:0] objectForKey:@"area"];
                    self.locate.districtID = [[areas objectAtIndex:0] objectForKey:@"id"];
                } else{
                    self.locate.district = @"";
                }
                break;
            case 2:
                if ([areas count] > 0) {
                    self.locate.district = [[areas objectAtIndex:row] objectForKey:@"area"];
                    self.locate.districtID = [[areas objectAtIndex:row] objectForKey:@"id"];
                    strees=[[areas objectAtIndex:0] objectForKey:@"streets"];
                    if(strees.count)
                    {
                        self.locate.street=[[strees objectAtIndex:0]objectForKey:@"street"];
                    }

                    
                } else{
                    self.locate.district = @"";
                }
                break;
            default:
                break;
        }
    }else if (self.pickerStyle==HZAddress){
        switch (component) {
            case 0:
                cities = [[provinces objectAtIndex:row] objectForKey:@"cities"];
                [self.locatePicker selectRow:0 inComponent:1 animated:YES];
                [self.locatePicker reloadComponent:1];
                
                
                self.locate.state = [[provinces objectAtIndex:row] objectForKey:@"state"];
                self.locate.stateID=[[provinces objectAtIndex:row] objectForKey:@"id"];
                
                self.locate.city = [[cities objectAtIndex:0] objectForKey:@"city"];
                self.locate.cityID =[[cities objectAtIndex:0] objectForKey:@"id"];
                
                break;
            case 1:

                
                self.locate.city = [[cities objectAtIndex:row] objectForKey:@"city"];
                self.locate.cityID =[[cities objectAtIndex:row] objectForKey:@"id"];
              
                break;
            default:
                break;
        }
        
    }
    else{
        
        if(strees.count)
        {
            self.locate.street=[[strees objectAtIndex:row]objectForKey:@"street"];
             self.locate.streetID=[[strees objectAtIndex:row]objectForKey:@"id"];
        }

    }
    
    if([self.delegate respondsToSelector:@selector(pickerDidChaneStatus:)]) {
        [self.delegate pickerDidChaneStatus:self];
    }

}


#pragma mark - animation

- (void)showInView:(UIView *) view
{
    _bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    _bgView.backgroundColor = RGBACOLOR_F(0.5,0.5,0.5,0.6);
    [view addSubview:_bgView];
    
    bottomView = [[UIView alloc]init];
    bottomView.frame = CGRectMake(0, kApplicationHeight+30, bottomView.frame.size.width, bottomView.frame.size.height);
    bottomView.backgroundColor = [UIColor whiteColor];
    [_bgView addSubview:bottomView];
    
   

    [UIView animateWithDuration:0.3 animations:^{
        
         bottomView.frame=CGRectMake(0, _bgView.frame.size.height-216, kScreenWidth, 216);
        
    } completion:^(BOOL finished) {
        
       
    }];

    
    self.frame = CGRectMake(0, 35, kApplicationWidth, 216);
//    self.backgroundColor=[UIColor whiteColor];
//    UIButton*finishbtn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
//    finishbtn.frame=CGRectMake(kApplicationWidth-60, 0, 50, 40);
//    [finishbtn setTitle:@"完成" forState:UIControlStateNormal];
//    [finishbtn addTarget:self action:@selector(finishdid:) forControlEvents:UIControlEventTouchUpInside];
//    [self addSubview:finishbtn];
    
    [bottomView addSubview:self];
    
//    [UIView animateWithDuration:0.3 animations:^{
//        self.frame = CGRectMake(0, view.frame.size.height - self.frame.size.height, self.frame.size.width, self.frame.size.height);
//    }];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(barButton:)];
    item.tintColor=[UIColor blackColor];
    
    UIBarButtonItem *item2 = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancelBtnClick:)];
    item2.tintColor=[UIColor blackColor];
    
    UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 45)];
    UIBarButtonItem *spaceItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    toolBar.items = @[spaceItem,item2,spaceItem,spaceItem,spaceItem,spaceItem,spaceItem,spaceItem,spaceItem,spaceItem,item,spaceItem];
    [bottomView addSubview:toolBar];
    
}

- (void)cancelBtnClick:(UIBarButtonItem *)sender
{
    [UIView animateWithDuration:0.3
                     animations:^{
                         bottomView.frame = CGRectMake(0, bottomView.frame.origin.y+bottomView.frame.size.height, bottomView.frame.size.width, bottomView.frame.size.height);
                     }
                     completion:^(BOOL finished){
                         [self.bgView removeFromSuperview];
                         
                     }];
}

//完成按钮
- (void)barButton:(UIBarButtonItem *)sender
{
    [UIView animateWithDuration:0.3
                     animations:^{
                         bottomView.frame = CGRectMake(0, bottomView.frame.origin.y+bottomView.frame.size.height, bottomView.frame.size.width, bottomView.frame.size.height);
                     }
                     completion:^(BOOL finished){
                         [self.bgView removeFromSuperview];
                         
                     }];
    if([self.delegate respondsToSelector:@selector(doneClick:)]) {
        [self.delegate doneClick:self];
    }
    
}

-(void)finishdid:(UIButton*)sender
{
    [self cancelPicker];
    if([self.delegate respondsToSelector:@selector(doneClick:)]) {
        [self.delegate doneClick:self];
    }
}

- (void)cancelPicker
{
    
    [UIView animateWithDuration:0.3
                     animations:^{
                         self.frame = CGRectMake(0, self.frame.origin.y+self.frame.size.height, self.frame.size.width, self.frame.size.height);
                     }
                     completion:^(BOOL finished){
                         [self removeFromSuperview];
                         
                     }];
    
}

@end
