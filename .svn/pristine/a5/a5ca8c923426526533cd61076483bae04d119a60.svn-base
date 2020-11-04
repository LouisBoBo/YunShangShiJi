//
//  CFVoiceBubble.h
//  CFVoiceBubble
//
//  Created by YF on 2017/6/29.
//  Copyright © 2017年 CooFree. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CFVoiceBubble;


/**
 <#Description#>
 */
@protocol CFVoiceBubbleDelegate <NSObject>

- (void)voiceBubbleDidStartPlaying:(CFVoiceBubble *)voiceBubble;

@end


@interface CFVoiceBubble : UIView

/**
 <#Description#>
 */
@property (assign, nonatomic) BOOL    isLoad;

/**
 <#Description#>
 */
@property (strong, nonatomic) NSString *URLStr;

@property (strong, nonatomic) NSString *audioLength;


/**
 <#Description#>
 */
@property (strong, nonatomic) NSURL *contentURL;

/**
 <#Description#>
 */
@property (strong, nonatomic) IBInspectable UIColor *waveColor;

/**
 <#Description#>
 */
@property (strong, nonatomic) IBInspectable UIColor *animatingWaveColor;

/**
 <#Description#>
 */
@property (strong, nonatomic) IBInspectable UIImage *bubbleImage;

/**
 <#Description#>
 */
@property (assign, nonatomic) IBInspectable BOOL    invert;

/**
 <#Description#>
 */
@property (assign, nonatomic) IBInspectable BOOL    exclusive;

/**
 <#Description#>
 */
@property (assign, nonatomic) IBInspectable BOOL    durationInsideBubble;

@property (assign, nonatomic) IBOutlet id<CFVoiceBubbleDelegate> delegate;



- (void)prepareToPlay;
- (void)play;
- (void)pause;
- (void)stop;

- (void)startAnimating;
- (void)stopAnimating;

@end

