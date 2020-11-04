//
//  AXSampleHeaderView.m
//  StretchableHeaderTabViewExample
//

#import "AXSampleSwipableHeaderView.h"


@interface AXSampleSwipableHeaderView ()


@end


@implementation AXSampleSwipableHeaderView {
  
}

- (id)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
//  UINib *nib = [UINib nibWithNibName:NSStringFromClass([self class]) bundle:nil];
//  self = [[nib instantiateWithOwner:self options:nil] firstObject];
  if (self) {
    self.delegate = self;
//    _interactiveSubviews = @[self.backButton];
      [self setUI];
  }
  return self;
}
- (void)setUI {
    self.backgroundColor=[UIColor groupTableViewBackgroundColor];

}

- (NSArray *)interactiveSubviewsInStretchableHeaderView:(AXStretchableHeaderView *)stretchableHeaderView
{
  return self.interactiveSubviews;
}

@end
