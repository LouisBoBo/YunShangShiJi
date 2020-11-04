//
//  AXStretchableHeaderTabViewController.h
//  Pods
//

#import <UIKit/UIKit.h>
#import "AXStretchableHeaderView.h"
#import "AXTabBar.h"

typedef NS_ENUM(NSInteger,YDPageVCType) {
    YDPageVCTypeYidou = 1 << 0,
    YDPageVCTypeYidouFromMessage = 1 << 1,
    YDPageVCTypeMoney = 1 << 2,
};

@class AXStretchableHeaderTabViewController;

@protocol AXStretchableSubViewControllerViewSource <NSObject>
@optional
- (UIScrollView *)stretchableSubViewInSubViewController:(id)subViewController;
@end

@interface AXStretchableHeaderTabViewController : UIViewController <UIScrollViewDelegate, AXTabBarDelegate>
@property (nonatomic) NSUInteger selectedIndex;
@property (readwrite, nonatomic) UIViewController *selectedViewController;
@property (copy, nonatomic) NSArray *viewControllers;

@property (strong, nonatomic) AXStretchableHeaderView *headerView;
@property (readonly, nonatomic) AXTabBar *tabBar;
@property (weak, nonatomic) IBOutlet UIScrollView *containerView;
@property (nonatomic) BOOL shouldBounceHeaderView;
@property (nonatomic,assign)CGFloat bottomInset;
// Layout
- (void)layoutHeaderViewAndTabBar;
- (void)layoutViewControllers;
- (void)layoutSubViewControllerToSelectedViewController;

- (void)changeSelectedIndex:(NSInteger)selectedIndex;

@end
