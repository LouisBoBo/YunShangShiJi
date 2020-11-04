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

#import "DXRecordView.h"
#import "GlobalTool.h"
@interface DXRecordView ()
{
    NSTimer *_timer;
    // 显示动画的ImageView
    UIImageView *_recordAnimationView;
    // 提示文字
    UILabel *_textLabel;
    
    UIImageView *bgView;
}

@end

@implementation DXRecordView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
//        UIView *bgView = [[UIView alloc] initWithFrame:self.bounds];
//        bgView.backgroundColor = [UIColor grayColor];
//        bgView.layer.cornerRadius = 5;
//        bgView.layer.masksToBounds = YES;
//        bgView.alpha = 0.6;
//        [self addSubview:bgView];
        bgView = [[UIImageView alloc] initWithFrame:self.bounds];
        bgView.contentMode = UIViewContentModeScaleAspectFit;
        bgView.image = [UIImage imageNamed:@"Home_voice1"];
        bgView.animationImages = @[ImageNamed(@"Home_voice1"),ImageNamed(@"Home_voice2"),ImageNamed(@"Home_voice3"),ImageNamed(@"Home_voice4")];
        bgView.animationDuration = 1.0;
        bgView.animationRepeatCount = 0;
        bgView.backgroundColor = [UIColor clearColor];
        [self addSubview:bgView];
        
        

        
        
        _recordAnimationView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 0, self.bounds.size.width - 20, self.bounds.size.height - 10)];
//        _recordAnimationView.image = [UIImage imageNamed:@"VoiceSearchFeedback001"];
        
        CGRect rect = Frame((FrameW(bgView)-FrameW(bgView)/2+8)/2, (FrameH(bgView)-FrameW(bgView)/2+8)/2, FrameW(bgView)/2-8, FrameW(bgView)/2-8);
        CGRect huatongRect = _recordAnimationView.frame;
        huatongRect.origin.x = rect.origin.x+35;
        huatongRect.origin.y = rect.origin.y+20;
        
        huatongRect.origin.x = (rect.size.width-rect.size.width/3*2)/2+rect.origin.x;
        huatongRect.origin.y = 10+rect.origin.y;
        //    +(rect.size.height-rect.size.height/3*2)/2;
        huatongRect.size.height = rect.size.height/3*2-10;
        huatongRect.size.width = rect.size.width/3*2;
        
        huatongRect.size.height = rect.size.height/3*2-25;
        
        _recordAnimationView.frame = huatongRect;
        _recordAnimationView.contentMode = UIViewContentModeScaleAspectFit;
        [bgView addSubview:_recordAnimationView];
        _recordAnimationView.image = [UIImage imageNamed:@"microphone1"];
//        _recordAnimationView.frame = Frame(10, 10, self.bounds.size.width-20, self.bounds.size.height-50);
        _recordAnimationView.contentMode = UIViewContentModeScaleAspectFit;
        
        
        [self addSubview:_recordAnimationView];
        
        _textLabel = [[UILabel alloc] initWithFrame:CGRectMake(5,
                                                               self.bounds.size.height - 30,
                                                               self.bounds.size.width - 10,
                                                               25)];
        
        _textLabel.textAlignment = NSTextAlignmentCenter;
        _textLabel.backgroundColor = [UIColor clearColor];
        _textLabel.numberOfLines = 2;
//        _textLabel.text = NSLocalizedString(@"message.toolBar.record.upCancel", @"Fingers up slide, cancel sending");
//        _textLabel.text = @" 手指上滑，取消发送 ";
        _textLabel.text = @"手指上滑\n取消发送";
        [self addSubview:_textLabel];
        _textLabel.font = [UIFont systemFontOfSize:13];
//        _textLabel.textColor = [UIColor blackColor];
        _textLabel.textColor = [UIColor whiteColor];
        _textLabel.layer.cornerRadius = 5;
        _textLabel.layer.borderColor = [[UIColor redColor] colorWithAlphaComponent:0.5].CGColor;
        _textLabel.layer.masksToBounds = YES;
        
        _textLabel.frame = CGRectMake(rect.origin.x,
                                      huatongRect.origin.y+huatongRect.size.height,
                                      rect.size.width,
                                      40);
        
        
    }
    return self;
}

// 录音按钮按下
-(void)recordButtonTouchDown
{
    // 需要根据声音大小切换recordView动画
//    _textLabel.text = NSLocalizedString(@"message.toolBar.record.upCancel", @"Fingers up slide, cancel sending");
    _textLabel.text = @"手指上滑\n取消发送";
    _textLabel.backgroundColor = [UIColor clearColor];
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.05
                                              target:self
                                            selector:@selector(setVoiceImage)
                                            userInfo:nil
                                             repeats:YES];
    
    [bgView startAnimating];//wzz
    
}
// 手指在录音按钮内部时离开
-(void)recordButtonTouchUpInside
{
    [_timer invalidate];
    [bgView stopAnimating];//wzz
}
// 手指在录音按钮外部时离开
-(void)recordButtonTouchUpOutside
{
    [_timer invalidate];
    [bgView stopAnimating];//
}
// 手指移动到录音按钮内部
-(void)recordButtonDragInside
{
//    _textLabel.text = NSLocalizedString(@"message.toolBar.record.upCancel", @"Fingers up slide, cancel sending");
    _textLabel.text = @"手指上滑\n取消发送";
    _textLabel.backgroundColor = [UIColor clearColor];
}

// 手指移动到录音按钮外部
-(void)recordButtonDragOutside
{
//    _textLabel.text = NSLocalizedString(@"message.toolBar.record.loosenCancel", @"loosen the fingers, to cancel sending");// 松开手指，取消发送
    _textLabel.text = @"松开手指\n取消发送";
//    _textLabel.backgroundColor = [UIColor redColor];
    _textLabel.backgroundColor = [UIColor clearColor];
}

-(void)setVoiceImage {
//    _recordAnimationView.image = [UIImage imageNamed:@"VoiceSearchFeedback001"];//microphone9
    _recordAnimationView.image = [UIImage imageNamed:@"microphone1"];
    double voiceSound = 0;
    
#if 0
//    voiceSound = [[EaseMob sharedInstance].deviceManager peekRecorderVoiceMeter];
    
    
  /*  if (0 < voiceSound <= 0.05) {
        [_recordAnimationView setImage:[UIImage imageNamed:@"VoiceSearchFeedback001"]];
    }else if (0.05<voiceSound<=0.10) {
        [_recordAnimationView setImage:[UIImage imageNamed:@"VoiceSearchFeedback002"]];
    }else if (0.10<voiceSound<=0.15) {
        [_recordAnimationView setImage:[UIImage imageNamed:@"VoiceSearchFeedback003"]];
    }else if (0.15<voiceSound<=0.20) {
        [_recordAnimationView setImage:[UIImage imageNamed:@"VoiceSearchFeedback004"]];
    }else if (0.20<voiceSound<=0.25) {
        [_recordAnimationView setImage:[UIImage imageNamed:@"VoiceSearchFeedback005"]];
    }else if (0.25<voiceSound<=0.30) {
        [_recordAnimationView setImage:[UIImage imageNamed:@"VoiceSearchFeedback006"]];
    }else if (0.30<voiceSound<=0.35) {
        [_recordAnimationView setImage:[UIImage imageNamed:@"VoiceSearchFeedback007"]];
    }else if (0.35<voiceSound<=0.40) {
        [_recordAnimationView setImage:[UIImage imageNamed:@"VoiceSearchFeedback008"]];
    }else if (0.40<voiceSound<=0.45) {
        [_recordAnimationView setImage:[UIImage imageNamed:@"VoiceSearchFeedback009"]];
    }else if (0.45<voiceSound<=0.50) {
        [_recordAnimationView setImage:[UIImage imageNamed:@"VoiceSearchFeedback010"]];
    }else if (0.50<voiceSound<=0.55) {
        [_recordAnimationView setImage:[UIImage imageNamed:@"VoiceSearchFeedback011"]];
    }else if (0.55<voiceSound<=0.60) {
        [_recordAnimationView setImage:[UIImage imageNamed:@"VoiceSearchFeedback012"]];
    }else if (0.60<voiceSound<=0.65) {
        [_recordAnimationView setImage:[UIImage imageNamed:@"VoiceSearchFeedback013"]];
    }else if (0.65<voiceSound<=0.70) {
        [_recordAnimationView setImage:[UIImage imageNamed:@"VoiceSearchFeedback014"]];
    }else if (0.70<voiceSound<=0.75) {
        [_recordAnimationView setImage:[UIImage imageNamed:@"VoiceSearchFeedback015"]];
    }else if (0.75<voiceSound<=0.80) {
        [_recordAnimationView setImage:[UIImage imageNamed:@"VoiceSearchFeedback016"]];
    }else if (0.80<voiceSound<=0.85) {
        [_recordAnimationView setImage:[UIImage imageNamed:@"VoiceSearchFeedback017"]];
    }else if (0.85<voiceSound<=0.90) {
        [_recordAnimationView setImage:[UIImage imageNamed:@"VoiceSearchFeedback018"]];
    }else if (0.90<voiceSound<=0.95) {
        [_recordAnimationView setImage:[UIImage imageNamed:@"VoiceSearchFeedback019"]];
    }else {
        [_recordAnimationView setImage:[UIImage imageNamed:@"VoiceSearchFeedback020"]];
    }*/
    
    if (0 < voiceSound <= 0.05) {
        [_recordAnimationView setImage:[UIImage imageNamed:@"microphone1"]];
    }else if (0.05<voiceSound<=0.10) {
        [_recordAnimationView setImage:[UIImage imageNamed:@"microphone1"]];
    }else if (0.10<voiceSound<=0.15) {
        [_recordAnimationView setImage:[UIImage imageNamed:@"microphone2"]];
    }else if (0.15<voiceSound<=0.20) {
        [_recordAnimationView setImage:[UIImage imageNamed:@"microphone2"]];
    }else if (0.20<voiceSound<=0.25) {
        [_recordAnimationView setImage:[UIImage imageNamed:@"microphone3"]];
    }else if (0.25<voiceSound<=0.30) {
        [_recordAnimationView setImage:[UIImage imageNamed:@"microphone3"]];
    }else if (0.30<voiceSound<=0.35) {
        [_recordAnimationView setImage:[UIImage imageNamed:@"microphone4"]];
    }else if (0.35<voiceSound<=0.40) {
        [_recordAnimationView setImage:[UIImage imageNamed:@"microphone4"]];
    }else if (0.40<voiceSound<=0.45) {
        [_recordAnimationView setImage:[UIImage imageNamed:@"microphone5"]];
    }else if (0.45<voiceSound<=0.50) {
        [_recordAnimationView setImage:[UIImage imageNamed:@"microphone5"]];
    }else if (0.50<voiceSound<=0.55) {
        [_recordAnimationView setImage:[UIImage imageNamed:@"microphone6"]];
    }else if (0.55<voiceSound<=0.60) {
        [_recordAnimationView setImage:[UIImage imageNamed:@"microphone6"]];
    }else if (0.60<voiceSound<=0.65) {
        [_recordAnimationView setImage:[UIImage imageNamed:@"microphone7"]];
    }else if (0.65<voiceSound<=0.70) {
        [_recordAnimationView setImage:[UIImage imageNamed:@"microphone7"]];
    }else if (0.70<voiceSound<=0.75) {
        [_recordAnimationView setImage:[UIImage imageNamed:@"microphone8"]];
    }else if (0.75<voiceSound<=0.80) {
        [_recordAnimationView setImage:[UIImage imageNamed:@"microphone8"]];
    }else if (0.80<voiceSound<=0.85) {
        [_recordAnimationView setImage:[UIImage imageNamed:@"microphone9"]];
    }else if (0.85<voiceSound<=0.90) {
        [_recordAnimationView setImage:[UIImage imageNamed:@"microphone9"]];
    }else if (0.90<voiceSound<=0.95) {
        [_recordAnimationView setImage:[UIImage imageNamed:@"microphone10"]];
    }else {
        [_recordAnimationView setImage:[UIImage imageNamed:@"microphone10"]];
    }
    
#endif
}

@end
