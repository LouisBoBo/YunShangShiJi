/************************************************************
  *  * EaseMob CONFIDENTIAL 
  * __________________ 
  * Copyright (C) 2013-2014 EaseMob Technologies. All rights reserved. 
  *  
  * NOTICE: All information contained herein is, and remains 
  * the property of EaseMob Technologies.
  * Dissemination of this information or reproduction of this material 
  * is strictly forbidden unless prior written permission is obtained
  * from EaseMob Technologies.
  */

#import "DXChatBarMoreView.h"

#define CHAT_BUTTON_SIZE 60
#define INSETS 8

@implementation DXChatBarMoreView

- (instancetype)initWithFrame:(CGRect)frame typw:(ChatMoreType)type
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setupSubviewsForType:type];
    }
    return self;
}

- (void)setupSubviewsForType:(ChatMoreType)type
{
    self.backgroundColor = [UIColor clearColor];
    CGFloat insets = (self.frame.size.width - 4 * CHAT_BUTTON_SIZE) / 5;
    
    _photoButton =[UIButton buttonWithType:UIButtonTypeCustom];
    [_photoButton setFrame:CGRectMake(insets, 10, CHAT_BUTTON_SIZE , CHAT_BUTTON_SIZE)];
//    [_photoButton setImage:[UIImage imageNamed:@"chatBar_colorMore_photo"] forState:UIControlStateNormal];//FDC_Chat_image
//    [_photoButton setImage:[UIImage imageNamed:@"chatBar_colorMore_photoSelected"] forState:UIControlStateHighlighted];
    
    [_photoButton setImage:[UIImage imageNamed:@"FDC_Chat_image"] forState:UIControlStateNormal];
    
    [_photoButton addTarget:self action:@selector(photoAction) forControlEvents:UIControlEventTouchUpInside];
    
    CGRect picRect = _photoButton.frame;
    picRect.origin.y = _photoButton.frame.origin.y+_photoButton.frame.size.height;
    picRect.size.height = 30;
    UILabel *_picLable = [[UILabel alloc]initWithFrame:picRect];
    _picLable.text = @"图片";
    _picLable.textAlignment = NSTextAlignmentCenter;
    _picLable.textColor = [UIColor grayColor];
    [self addSubview:_picLable];
    
    [self addSubview:_photoButton];
    
    _locationButton =[UIButton buttonWithType:UIButtonTypeCustom];
    [_locationButton setFrame:CGRectMake(insets * 2 + CHAT_BUTTON_SIZE, 10, CHAT_BUTTON_SIZE , CHAT_BUTTON_SIZE)];
//    [_locationButton setImage:[UIImage imageNamed:@"chatBar_colorMore_location"] forState:UIControlStateNormal];//FDC_Chat_map
//    [_locationButton setImage:[UIImage imageNamed:@"chatBar_colorMore_locationSelected"] forState:UIControlStateHighlighted];
    
    [_locationButton setImage:[UIImage imageNamed:@"FDC_Chat_map"] forState:UIControlStateNormal];
    _locationButton.frame = CGRectMake(insets * 3 + CHAT_BUTTON_SIZE * 2, 10, CHAT_BUTTON_SIZE , CHAT_BUTTON_SIZE);
    [_locationButton addTarget:self action:@selector(locationAction) forControlEvents:UIControlEventTouchUpInside];
    
    CGRect locationRect = _locationButton.frame;
    locationRect.origin.y = _locationButton.frame.origin.y+_locationButton.frame.size.height;
    locationRect.size.height = 30;
    UILabel *_locationLable = [[UILabel alloc]initWithFrame:locationRect];
    _locationLable.text = @"地图";
    _locationLable.textAlignment = NSTextAlignmentCenter;
    _locationLable.textColor = [UIColor grayColor];
    [self addSubview:_locationLable];
    
    [self addSubview:_locationButton];
    
    //名片暂时隐藏
 /*
    _takePicButton =[UIButton buttonWithType:UIButtonTypeCustom];
    [_takePicButton setFrame:CGRectMake(insets * 3 + CHAT_BUTTON_SIZE * 2, 10, CHAT_BUTTON_SIZE , CHAT_BUTTON_SIZE)];
//    [_takePicButton setImage:[UIImage imageNamed:@"chatBar_colorMore_camera"] forState:UIControlStateNormal];//FM_Chat_card
//    [_takePicButton setImage:[UIImage imageNamed:@"chatBar_colorMore_cameraSelected"] forState:UIControlStateHighlighted];
    [_takePicButton setImage:[UIImage imageNamed:@"FM_Chat_card"] forState:UIControlStateNormal];
    _takePicButton.frame = CGRectMake(insets * 4 + CHAT_BUTTON_SIZE * 3, 10, CHAT_BUTTON_SIZE , CHAT_BUTTON_SIZE);
    
    [_takePicButton addTarget:self action:@selector(takePicAction) forControlEvents:UIControlEventTouchUpInside];
    
    CGRect _takePicButtonRect = _takePicButton.frame;
    _takePicButtonRect.origin.y = _takePicButton.frame.origin.y+_takePicButton.frame.size.height;
    _takePicButtonRect.size.height = 30;
    UILabel *__takePicRectLable = [[UILabel alloc]initWithFrame:_takePicButtonRect];
    __takePicRectLable.text = @"名片";
    __takePicRectLable.textAlignment = NSTextAlignmentCenter;
    __takePicRectLable.textColor = [UIColor grayColor];
    [self addSubview:__takePicRectLable];
    
    
    [self addSubview:_takePicButton];
    
  */
  
    
    _videoButton =[UIButton buttonWithType:UIButtonTypeCustom];
    [_videoButton setFrame:CGRectMake(insets * 4 + CHAT_BUTTON_SIZE * 3, 10, CHAT_BUTTON_SIZE , CHAT_BUTTON_SIZE)];
//    [_videoButton setImage:[UIImage imageNamed:@"chatBar_colorMore_video"] forState:UIControlStateNormal];//FM_Chat_video
//    [_videoButton setImage:[UIImage imageNamed:@"chatBar_colorMore_videoSelected"] forState:UIControlStateHighlighted];
    
    
    _videoButton.frame = CGRectMake(insets * 2 + CHAT_BUTTON_SIZE, 10, CHAT_BUTTON_SIZE , CHAT_BUTTON_SIZE);
    [_videoButton setImage:[UIImage imageNamed:@"FM_Chat_video"] forState:UIControlStateNormal];
    [_videoButton addTarget:self action:@selector(takeVideoAction) forControlEvents:UIControlEventTouchUpInside];
    
    CGRect videoRect = _videoButton.frame;
    videoRect.origin.y = _videoButton.frame.origin.y+_videoButton.frame.size.height;
    videoRect.size.height = 30;
    
    UILabel *_videoRectLable = [[UILabel alloc]initWithFrame:videoRect];
    _videoRectLable.text = @"视频";
    _videoRectLable.textAlignment = NSTextAlignmentCenter;
    _videoRectLable.textColor = [UIColor grayColor];
    [self addSubview:_videoRectLable];
    
    
    [self addSubview:_videoButton];
    
    CGRect frame = self.frame;
    
    frame.size.height = 110;//wzz
    self.frame = frame;//wzz
    return;//wzz

    if (type == ChatMoreTypeChat) {
        frame.size.height = 150;
        
        _audioCallButton =[UIButton buttonWithType:UIButtonTypeCustom];
        [_audioCallButton setFrame:CGRectMake(insets, 10 * 2 + CHAT_BUTTON_SIZE, CHAT_BUTTON_SIZE , CHAT_BUTTON_SIZE)];
        [_audioCallButton setImage:[UIImage imageNamed:@"chatBar_colorMore_audioCall"] forState:UIControlStateNormal];
        [_audioCallButton setImage:[UIImage imageNamed:@"chatBar_colorMore_audioCallSelected"] forState:UIControlStateHighlighted];
        [_audioCallButton addTarget:self action:@selector(takeAudioCallAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_audioCallButton];
    }
    else if (type == ChatMoreTypeGroupChat)
    {
        frame.size.height = 80;
    }
    self.frame = frame;
    
  
    
}

#pragma mark - action

- (void)takePicAction{
    //暂时隐藏
    /*
    if(_delegate && [_delegate respondsToSelector:@selector(moreViewTakePicAction:)]){
        [_delegate moreViewTakePicAction:self];
    }
     */
}

- (void)photoAction
{
    UIActionSheet *sheet = [[UIActionSheet alloc]initWithTitle:@"选择图片来源" delegate:nil cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"相册",@"拍照", nil];
    
    __weak DXChatBarMoreView *weakSelf = self;
#if 0
    [sheet showInView:[[UIApplication sharedApplication].delegate window]withCompletionHandler:^(NSInteger buttonIndex)
    {
        
        

        
        if (buttonIndex == 0) {//相册
            if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(moreViewPhotoAction:)]) {
                [weakSelf.delegate moreViewPhotoAction:self];
            }
        }
        
        if (buttonIndex == 1) {//拍照
            
            if(weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(moreViewTakePicAction:)]){
                [weakSelf.delegate moreViewTakePicAction:self];
            }
            
            return ;
        }
        
       
        
    }];
    
#endif
    
}
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex==0)//支付宝支付
    {
        

    }else if (buttonIndex==1)//微信支付
    {
        NSLog(@"wx");

        
    }
}


- (void)locationAction
{
    if (_delegate && [_delegate respondsToSelector:@selector(moreViewLocationAction:)]) {
        [_delegate moreViewLocationAction:self];
    }
}

- (void)takeVideoAction{
    if (_delegate && [_delegate respondsToSelector:@selector(moreViewLocationAction:)]) {
        [_delegate moreViewVideoAction:self];
    }
}

- (void)takeAudioCallAction
{
    if (_delegate && [_delegate respondsToSelector:@selector(moreViewAudioCallAction:)]) {
        [_delegate moreViewAudioCallAction:self];
    }
}

@end
