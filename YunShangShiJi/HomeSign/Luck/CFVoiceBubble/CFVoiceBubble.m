//
//  CFVoiceBubble.m
//  CFVoiceBubble
//
//  Created by YF on 2017/6/29.
//  Copyright © 2017年 CooFree. All rights reserved.
//

#import "CFVoiceBubble.h"
#import <AVFoundation/AVFoundation.h>

#define kCFVoiceBubbleShouldStopNotification @"CFVoiceBubbleShouldStopNotification"
#define UIImageNamed(imageName) [[UIImage imageNamed:[NSString stringWithFormat:@"%@", imageName]] imageWithRenderingMode:UIImageRenderingModeAutomatic]

@interface CFVoiceBubble ()<AVAudioPlayerDelegate>

@property (strong, nonatomic) AVAudioPlayer *player;
@property (strong, nonatomic) AVURLAsset    *asset;
@property (strong, nonatomic) NSArray       *animationImages;
@property (weak  , nonatomic) UIButton      *contentButton;
@property (weak  , nonatomic) UILabel      *contentLabel;


@end

@implementation CFVoiceBubble


- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        [self initialize];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self initialize];
    }
    return self;
}

- (void)initialize
{
    self.backgroundColor = [UIColor clearColor];
    self.clipsToBounds = NO;
    self.waveColor = [UIColor colorWithRed:0/255.0 green:102/255.0 blue:51/255.0 alpha:1.0];

    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    //    [button setImage:[UIImageNamed(@"fs_icon_wave_2") imageWithOverlayColor:self.waveColor]  forState:UIControlStateNormal];
    [button setImage:UIImageNamed(@"集赞语音06") forState:UIControlStateNormal];
    [button setImage:UIImageNamed(@"集赞语音06") forState:UIControlStateHighlighted];


    UIImage *buttonImageNomal=[UIImage imageNamed:@"集赞语音"];
    UIImage *stretchableButtonImageNomal=[buttonImageNomal stretchableImageWithLeftCapWidth:12 topCapHeight:0];
    [button setBackgroundImage:stretchableButtonImageNomal forState:UIControlStateNormal];

//    [button setBackgroundImage:[UIImage imageNamed:@"集赞语音"] forState:UIControlStateNormal];
//    [button setTitle:@"0\"" forState:UIControlStateNormal];

//    [button setTitleColor:[UIColor colorWithRed:255/255.0 green:63/255.0 blue:139/255.0 alpha:255/255.0] forState:UIControlStateNormal];
//    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];

    [button addTarget:self action:@selector(voiceClicked:) forControlEvents:UIControlEventTouchUpInside];
    button.backgroundColor                = [UIColor clearColor];
    button.titleLabel.font                = [UIFont systemFontOfSize:12];
    button.adjustsImageWhenHighlighted    = YES;
    button.imageView.animationDuration    = 2.0;
    button.imageView.animationRepeatCount = 30;
    button.imageView.clipsToBounds        = NO;
    button.imageView.contentMode          = UIViewContentModeCenter;
    button.contentHorizontalAlignment     = UIControlContentHorizontalAlignmentLeft;
    [self addSubview:button];
    self.contentButton = button;

    UILabel *contentLabel = [[UILabel alloc]init];
    contentLabel.font = [UIFont systemFontOfSize:12];
    contentLabel.textColor = [UIColor colorWithRed:255/255.0 green:63/255.0 blue:139/255.0 alpha:255/255.0];
    [self addSubview:contentLabel];
    self.contentLabel=contentLabel;

    _animatingWaveColor = [UIColor whiteColor];
    _exclusive = YES;
    _durationInsideBubble = NO;

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(bubbleShouldStop:) name:kCFVoiceBubbleShouldStopNotification object:nil];


}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kCFVoiceBubbleShouldStopNotification object:nil];

}

- (void)layoutSubviews
{
    [super layoutSubviews];
    _contentButton.frame = CGRectMake(0, 0, self.frame.size.width-30, self.frame.size.height);
    _contentLabel.frame = CGRectMake(_contentButton.frame.size.width+3, 0, 30, self.frame.size.height);

    NSString *title = [_contentButton titleForState:UIControlStateNormal];
    if (title && title.length) {
//        NSDictionary *attributes = @{NSFontAttributeName: [UIFont systemFontOfSize:14]};
//        NSAttributedString *attributedString = [[NSAttributedString alloc] initWithString:[_contentButton titleForState:UIControlStateNormal] attributes:attributes];
//        _contentButton.imageEdgeInsets = UIEdgeInsetsMake(0,
//                                                          -self.bounds.size.width + 50,
//                                                          0,
//                                                          self.bounds.size.width - 50);
//        NSInteger textPadding = _invert ? 2 : 4;
//        if (_durationInsideBubble) {
//            _contentButton.titleEdgeInsets = UIEdgeInsetsMake(1, -8, 0, 8);
//        } else {
//            _contentButton.titleEdgeInsets = UIEdgeInsetsMake(self.bounds.size.height - attributedString.size.height,
//                                                              attributedString.size.width + textPadding,
//                                                              0,
//                                                              -attributedString.size.width - textPadding);
//        }
        self.layer.transform = _invert ? CATransform3DMakeRotation(M_PI, 0, 1.0, 0) : CATransform3DIdentity;
//        _contentButton.titleLabel.layer.transform = _invert ? CATransform3DMakeRotation(M_PI, 0.0, 1.0, 0.0) : CATransform3DIdentity;

    }else {
//        _contentButton.imageEdgeInsets = UIEdgeInsetsMake(0,
//                                                          -self.bounds.size.width + 40,
//                                                          0,
//                                                          self.bounds.size.width - 40);
    }
}

# pragma mark - 1️⃣➢➢➢ Setter & Getter

- (void)setTintColor:(UIColor *)tintColor
{
    [super setTintColor:tintColor];
}

- (void)setWaveColor:(UIColor *)waveColor
{
    if (![_waveColor isEqual:waveColor]) {
        _waveColor = waveColor;
        //        [_contentButton setImage:[UIImageNamed(@"fs_icon_wave_2") imageWithOverlayColor:waveColor]  forState:UIControlStateNormal];
    }
}

- (void)setInvert:(BOOL)invert
{
    if (_invert != invert) {
        _invert = invert;
        [self setNeedsLayout];
    }
}

- (void)setBubbleImage:(UIImage *)bubbleImage
{
    [_contentButton setBackgroundImage:bubbleImage forState:UIControlStateNormal];
}

- (UIImage *)bubbleImage
{
    return [_contentButton backgroundImageForState:UIControlStateNormal];
}

#pragma mark - 1️⃣➢➢➢ AVAudioPlayer Delegate

- (void)audioPlayerBeginInterruption:(AVAudioPlayer *)player
{
    [self pause];
}

- (void)audioPlayerEndInterruption:(AVAudioPlayer *)player withOptions:(NSUInteger)flags
{
    [self play];
}

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    [self stopAnimating];
}

#pragma mark - 1️⃣➢➢➢ Nofication

- (void)bubbleShouldStop:(NSNotification *)notification
{
    if (_player.isPlaying) {
        [self stop];
    }
}

#pragma mark - 1️⃣➢➢➢ Target Action

- (void)voiceClicked:(id)sender
{
    if (self.isLoad==NO) {

        NSString *docDirPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
//        NSString *filePath = [NSString stringWithFormat:@"%@/%@.mp4", docDirPath , @"temp"];
        NSString *filePath = [NSString stringWithFormat:@"%@/%@.mp4", docDirPath , [_URLStr substringWithRange:NSMakeRange(_URLStr.length-10, 6)]];


        // 要检查的文件目录
        NSFileManager *fileManager = [NSFileManager defaultManager];
        if ([fileManager fileExistsAtPath:filePath]) {
            NSLog(@"文件存在");
        }
        else {
            NSLog(@"文件不存在");
            //将数据保存到本地指定位置
            NSURL *url = [[NSURL alloc]initWithString:_URLStr];
            NSData * audioData = [NSData dataWithContentsOfURL:url];
            [audioData writeToFile:filePath atomically:YES];
        }

        self.contentURL = [NSURL fileURLWithPath:filePath];
        self.isLoad=YES;
        [self setNeedsLayout];
    }
    if (_player.playing && _contentButton.imageView.isAnimating) {
        [self stop];
    } else {
        if (_exclusive) {
            [[NSNotificationCenter defaultCenter] postNotificationName:kCFVoiceBubbleShouldStopNotification object:nil];
        }
        [self play];
        if (_delegate && [_delegate respondsToSelector:@selector(voiceBubbleDidStartPlaying:)]) {
            [_delegate voiceBubbleDidStartPlaying:self];
        }
    }
}

#pragma mark - 1️⃣➢➢➢ Public

- (void)setAudioLength:(NSString *)audioLength {
    if (![_audioLength isEqual:audioLength]) {
        _audioLength = audioLength;
        if (_audioLength&&_audioLength.length) {

            _contentLabel.text = [NSString stringWithFormat:@"%@\"",_audioLength];
            _contentButton.imageEdgeInsets = UIEdgeInsetsMake(0,
                                                              15,
                                                              0,
                                                              0);



        }
    }
}
- (void)setContentURL:(NSURL *)contentURL
{
    if (![_contentURL isEqual:contentURL]) {
        _contentURL = contentURL;

        if (_audioLength&&_audioLength.length) {
//            [_contentButton setTitle:[NSString stringWithFormat:@"%@\"",_audioLength] forState:UIControlStateNormal];
        }
//        [_contentButton setTitle:@"0\"" forState:UIControlStateNormal];

        /*
        _asset = [[AVURLAsset alloc] initWithURL:_contentURL options:nil];
        CMTime duration = _asset.duration;
        NSInteger seconds = CMTimeGetSeconds(duration);
        NSError *error;
        if (seconds > 60) {
            error = [NSError errorWithDomain:@"A voice audio should't last longer than 60 seconds" code:300 userInfo:nil];
        }
        NSString *title = [NSString stringWithFormat:@"%@\"",@(seconds)];
        [_contentButton setTitle:title forState:UIControlStateNormal];
        NSDictionary *attributes = @{NSFontAttributeName: [UIFont systemFontOfSize:14]};
        CGFloat titleWidth = [[[NSAttributedString alloc] initWithString:title attributes:attributes] size].width;

        _contentButton.titleEdgeInsets = UIEdgeInsetsMake(0,
                                                          self.bounds.size.width - 5 - [_contentButton imageForState:UIControlStateNormal].size.width - titleWidth - 2.5,
                                                          0,
                                                          0);
        */
    }
}

- (void)prepareToPlay
{
    if (!_player) {
        [_player stop];
        _player = nil;
    }
    NSError *error;
    _player = [[AVAudioPlayer alloc] initWithContentsOfURL:_contentURL error:&error];
    _player.delegate = self;
    [_player prepareToPlay];
    if (error) {
        [self showError:error.localizedDescription];
    }
}

- (void)startAnimating
{
    if (!_contentButton.imageView.isAnimating) {
        //        UIImage *image0 = [UIImageNamed(@"fs_icon_wave_0") imageWithOverlayColor:_animatingWaveColor];
        //        UIImage *image1 = [UIImageNamed(@"fs_icon_wave_1") imageWithOverlayColor:_animatingWaveColor];
        //        UIImage *image2 = [UIImageNamed(@"fs_icon_wave_2") imageWithOverlayColor:_animatingWaveColor];
        //        _contentButton.imageView.animationImages = @[image0, image1, image2];
        UIImage *image1 = UIImageNamed(@"集赞语音01");
        UIImage *image2 = UIImageNamed(@"集赞语音02");
        UIImage *image3 = UIImageNamed(@"集赞语音03");
        UIImage *image4 = UIImageNamed(@"集赞语音04");
        UIImage *image5 = UIImageNamed(@"集赞语音05");
        UIImage *image6 = UIImageNamed(@"集赞语音06");
        _contentButton.imageView.animationImages = @[image1, image2, image3,image4,image5,image6];

        [_contentButton.imageView startAnimating];
    }
}

- (void)stopAnimating
{
    if (_contentButton.imageView.isAnimating) {
        [_contentButton.imageView stopAnimating];
    }
}

- (void)play
{
    if (!_player) {
        [self prepareToPlay];
    }
    if (!_player.playing&&_player) {
        [_player play];
        [self startAnimating];
    }
}

- (void)pause
{
    if (_player.playing) {
        [_player pause];
        [self stopAnimating];
    }
}

- (void)stop
{
    if (_player.playing) {
        [_player stop];
        _player.currentTime = 0;
        [self stopAnimating];
    }
}

#pragma mark - 1️⃣➢➢➢ Private

- (void)showError:(NSString *)error
{
    MyLog(@"FSVoiceBubble error");
//    [[[UIAlertView alloc] initWithTitle:@"FSVoiceBubble" message:@"error" delegate:nil cancelButtonTitle:@"Got it!" otherButtonTitles:nil, nil] show];
}

@end





