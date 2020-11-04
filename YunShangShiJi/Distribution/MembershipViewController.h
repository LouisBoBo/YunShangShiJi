//
//  MembershipViewController.h
//  YunShangShiJi
//
//  Created by yssj on 15/10/27.
//  Copyright © 2015年 ios-1. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,MembersType) {
    MembersGroup,
    MembersPlain,
    MembersOrder
};
@interface MembershipViewController : UIViewController

@property(nonatomic)MembersType membersType;
@property(nonatomic,strong)NSString *store_code;
@property(nonatomic,strong)NSString *user_id;


@end
