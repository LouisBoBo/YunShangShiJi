//
//  YFLaunchView.m
//  YunShangShiJi
//
//  Created by zgl on 16/7/4.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import "YFLaunchView.h"
#import "LaunchModel.h"
#import "YFImageCache.h"
#import "SDWebImageDownloader.h"
#import "UIView+Animation.h"

NSString * const LaunchImg = @"LaunchImg";
NSString * const YFLaunchViewDisappearTime = @"YFLaunchViewDisappearTime";
NSString * const YFLaunchViewDisappear = @"YFLaunchViewDisappear";

@implementation YFLaunchView {
    UIImageView *_imgView;
    UIButton *_btn;
    dispatch_block_t _block;
}

/// 显示
+ (void)show {
    [DataManager sharedManager].isLaunch = YES;
    [DataManager sharedManager].Startpage = YES;
    
//    YFLaunchView *launchView = [[self alloc] initWithFrame:[UIScreen mainScreen].bounds];
//    launchView -> _imgView .image = [self launchImage];
//    [self update];
//    UIWindow *view = [UIApplication sharedApplication].keyWindow;
//    [view addSubview:launchView];
//    [launchView countdownTime];
    
    [UIView animateWithDuration:1 animations:^{
        
    } completion:^(BOOL finished) {
        
        [DataManager sharedManager].isLaunch = NO;
        [[NSNotificationCenter defaultCenter] postNotificationName:YFLaunchViewDisappear object:nil];
    }];
}

/// 获取图片
+ (UIImage *)launchImage {
    UIImage *image = nil;
    NSString *key = [[NSUserDefaults standardUserDefaults] objectForKey:LaunchImg];
    if (key.length) {
        image = [[YFImageCache sharedImageCache] diskImageForKey:key];
    }
    
    if (image == nil) {
        NSString *imgPath = [NSString stringWithFormat:@"%@/%@", [[NSBundle mainBundle] resourcePath], @"launch_1.jpg"];
        image = [UIImage imageWithContentsOfFile:imgPath];
        
    }
    return image;
}

/// 更新数据
+ (void)update {
    [LaunchModel getLaunchModelWithSuccess:^(LaunchModel *data) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            if (data.status == 1) {
                [self storeImageWithData:data.data];
            }
        });
    }];
}

/// 下载并保存图片
+ (BOOL)storeImageWithData:(LaunchImgModel *)model {
    //取出图片名
    NSString *pic = [NSString stringWithFormat:@"%@%@",[NSObject baseURLStr_Upy], model.pic];
    NSString *key = [NSString stringWithFormat:@"%@%@",[self fileNameWithSourcePath:model.pic],model.time];
    //是否已经下载了
    BOOL exist = [[YFImageCache sharedImageCache] diskImageExistsWithKey:key];
    //没有下载则下载图片
    if (!exist) {
        UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:pic]]];
        if (image) {
            NSString *oldKey = [[NSUserDefaults standardUserDefaults] objectForKey:LaunchImg];
            if (oldKey.length) {
                //删除之前的图片
                [[YFImageCache sharedImageCache] removeImageForKey:[[NSUserDefaults standardUserDefaults] objectForKey:LaunchImg]];
            }
            //将图片保存到本地
            [[YFImageCache sharedImageCache] storeImage:image forKey:key];
            [[NSUserDefaults standardUserDefaults] setObject:key forKey:LaunchImg];
        }
    }
    return exist;
}

/// 获取文件名称
+ (NSString *)fileNameWithSourcePath:(NSString *)sourcePath {
    NSString *fullFileName = [[sourcePath componentsSeparatedByString:@"/"] lastObject];
    return [[fullFileName componentsSeparatedByString:@"."] firstObject];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setUI];
    }
    return self;
}

#pragma mark - 创建UI
- (void)setUI {
    [self addSubview:self.imgView];
    [self addSubview:self.btn];
}

#pragma mark - 点击
- (void)btnClick:(UIButton *)sender {
    [self viewAnimation];
}

- (void)viewAnimation {
    [UIView animateWithDuration:1 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        [DataManager sharedManager].isLaunch = NO;
        [[NSNotificationCenter defaultCenter] postNotificationName:YFLaunchViewDisappear object:nil];
    }];
}

/// 倒计时
- (void)countdownTime {
    [self.imgView scaleStatus:YES time:6];
    __block int timeout = 1;
    kSelfWeak;
    [NSTimer weakTimerWithTimeInterval:1.0 target:self userInfo:nil repeats:YES block:^(id target, NSTimer *timer) {
        if(timeout<=0){ //倒计时结束，关闭
            [weakSelf viewAnimation];
            [timer invalidate];
        } else {
            NSString *strTime = [NSString stringWithFormat:@"跳过 %ds", timeout];
            NSLog(@"%@",strTime);
            [weakSelf.btn setTitle:strTime forState:UIControlStateNormal];
            timeout--;
        }
    }];
}

#pragma mark - getter
- (UIImageView *)imgView {
    if (nil == _imgView) {
        _imgView = [[UIImageView alloc] initWithFrame:self.bounds];
        _imgView.userInteractionEnabled = YES;
    }
    return _imgView;
}

- (UIButton *)btn {
    if (nil == _btn) {
        _btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btn setBackgroundColor:[UIColor colorWithWhite:0 alpha:0.3]];
        [_btn setTintColor:[UIColor blackColor]];
        _btn.titleLabel.font = [UIFont systemFontOfSize:16];
        [_btn setTitle:@"跳过 5s" forState:UIControlStateNormal];
        _btn.frame = CGRectMake(self.width - 80 - 15, self.height - 30 - 110, 80, 30);
        _btn.layer.cornerRadius = 15;
        [_btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btn;
}

- (void)settouchesEndedBlock:(dispatch_block_t)block {
    _block = block;
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"点击");
    if (_block) {
        _block();
    }
    [self viewAnimation];
}

@end
