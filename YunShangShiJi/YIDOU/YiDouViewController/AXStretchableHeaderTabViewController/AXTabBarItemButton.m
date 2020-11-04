//
//  AXTabBarItemButton.m
//  Pods
//

#import "AXTabBarItemButton.h"

#define BarBtnNormalColor [UIColor colorWithRed:62/255.0 green:62/255.0 blue:62/255.0 alpha:1.0]

#define SNN ([UIScreen mainScreen].bounds.size.width)/(375)
#define ZOOMPT(pt) ((pt)*(SNN))

@implementation AXTabBarItemButton

- (id)initWithFrame:(CGRect)frame
{
  self = [super initWithFrame:frame];
  if (self) {
    // Initialization code
    [self setTitleColor:BarBtnNormalColor forState:UIControlStateNormal];
    [self setTitleColor:BarBtnSelectedColor forState:UIControlStateSelected];
    [self setTitleColor:BarBtnSelectedColor forState:UIControlStateHighlighted];
      [self addSubview:self.redBadge];
  }
  return self;
}

- (UILabel *)redBadge {
    if (_redBadge==nil) {
        _redBadge = [[UILabel alloc]init];
        //    badgeView.layer.borderWidth=1.f;
        _redBadge.layer.borderColor=[UIColor whiteColor].CGColor;
        _redBadge.backgroundColor = BarBtnSelectedColor;
        _redBadge.textColor=[UIColor whiteColor];
        _redBadge.font=[UIFont systemFontOfSize:10];
        _redBadge.textAlignment=NSTextAlignmentCenter;
        _redBadge.layer.cornerRadius = ZOOMPT(4);
        _redBadge.layer.masksToBounds = YES;
        _redBadge.hidden=YES;
    }
    return _redBadge;
}
- (void)layoutSubviews
{
  [super layoutSubviews];
    self.redBadge.frame = CGRectMake(self.frame.size.width/3*2,self.frame.size.height/2-ZOOMPT(4), ZOOMPT(8), ZOOMPT(8));

}

- (void)sizeToFit
{
  [super sizeToFit];
  CGFloat padding = 16.0;
  [self setBounds:(CGRect){CGPointZero, CGRectGetWidth(self.frame) + padding, CGRectGetHeight(self.frame) + padding}];
}

- (void)setBadgeValue:(NSString *)badgeValue
{
  if ([_badgeValue isEqualToString:badgeValue] == NO) {
    _badgeValue = [badgeValue copy];
    
    // TODO: implement this.
  }
}

@end
