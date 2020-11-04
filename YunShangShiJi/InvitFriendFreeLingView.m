//
//  InvitFriendFreeLingView.m
//  YunShangShiJi
//
//  Created by hebo on 2019/5/17.
//  Copyright © 2019年 ios-1. All rights reserved.
//

#import "InvitFriendFreeLingView.h"
#import "GlobalTool.h"
@implementation InvitFriendFreeLingView

-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        [self mainview:frame];
    }
    return self;
}

- (void)mainview:(CGRect)frame{
    UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[NSObject baseURLStr_XCX_Upy],@"small-iconImages/qingfengpic/InviteFriends_img2.jpg"]]]];
    
    UIImage *closeimage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[NSObject baseURLStr_XCX_Upy],@"small-iconImages/heboImg/task_icon_close.png"]]]];
    
    UIImageView *imageview = [[UIImageView alloc]initWithFrame:frame];
    imageview.image = image;
    imageview.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(inviteclick:)];
    [imageview addGestureRecognizer:tap];
    [self addSubview:imageview];
    
    UIButton *closebtn = [UIButton buttonWithType:UIButtonTypeSystem];
    closebtn.frame = CGRectMake(CGRectGetMaxX(imageview.frame)-ZOOM6(80), 0, ZOOM6(80), ZOOM6(80));
    [closebtn addTarget:self action:@selector(closeview) forControlEvents:UIControlEventTouchUpInside];
    [imageview addSubview:closebtn];
    
    UIImageView *closeimageview = [[UIImageView alloc]initWithFrame:CGRectMake(ZOOM6(40), ZOOM6(10), ZOOM6(30), ZOOM6(30))];
    closeimageview.userInteractionEnabled = YES;
    closeimageview.image = closeimage;
    [closebtn addSubview:closeimageview];
    
    UITapGestureRecognizer *closetap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(closeview)];
    [closeimageview addGestureRecognizer:closetap];
}

- (void)inviteclick:(UITapGestureRecognizer*)tap
{
    if(self.invitFreeLingBlock)
    {
        self.invitFreeLingBlock();
    }
}

- (void)closeview
{
    if(self.closeFreeLingBlock)
    {
        self.closeFreeLingBlock();
    }
}
@end
