//
//  WOPCTLHomeBaseViewController.m
//  FSCalendarExample
//
//  Created by yujinhai on 2019/12/23.
//  Copyright © 2019 wenchaoios. All rights reserved.
//

#import "WOPCTLHomeBaseViewController.h"
#import "WOPCTLHomeHeaderView.h"
#import "WOPCTLHomeSubViewController.h"
#import "Masonry.h"
#import "WOPCTLHomeNavigationView.h"

@interface WOPCTLHomeBaseViewController ()<UIGestureRecognizerDelegate>
@property (strong, nonatomic) WOPCTLHomeHeaderView *homeHeaderView;
@property (strong, nonatomic) WOPCTLHomeSubViewController *homeSubViewController;
@property (strong, nonatomic) UIPanGestureRecognizer *gesture;
@property (assign, nonatomic) BOOL homeViewToTop;
@property (strong, nonatomic) WOPCTLHomeNavigationView *navigationView;

@property (strong, nonatomic) UIScrollView *tripScrollView;

@end

@implementation WOPCTLHomeBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = ctl_color_grayf9f9f9(1);
    self.automaticallyAdjustsScrollViewInsets = NO;

    [self p_initUI];
    self.tripScrollView.backgroundColor = [UIColor whiteColor];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:true animated:animated];
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:false animated:animated];
}
- (void)p_initUI {
    [self.homeHeaderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(368);
        make.top.mas_equalTo(self.view);
        make.leading.mas_equalTo(self.view);
        make.trailing.mas_equalTo(self.view);
    }];
    [self.homeSubViewController.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.homeHeaderView.mas_bottom).offset(0);
        make.bottom.mas_equalTo(self.view.mas_bottom);
        make.leading.mas_equalTo(self.view.mas_leading);
        make.trailing.mas_equalTo(self.view.mas_trailing);
    }];
    [self.navigationView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(84);
        make.top.mas_equalTo(self.view);
        make.leading.mas_equalTo(self.view);
        make.trailing.mas_equalTo(self.view);
    }];
    [self.tripScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.homeHeaderView.mas_leading);
        make.trailing.mas_equalTo(self.homeHeaderView.mas_trailing);
        make.top.mas_equalTo(self.navigationView.mas_bottom).offset(24);
        make.bottom.mas_equalTo(self.homeHeaderView.mas_bottom).offset(-20);
    }];
}
#pragma mark - Target actions

- (void)handleScopeGesture:(UIPanGestureRecognizer *)sender
{
    
    switch (sender.state) {
        case UIGestureRecognizerStateBegan: {
            if (self.homeViewToTop == YES) {
                [self.homeSubViewController.view mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.top.mas_equalTo(self.homeHeaderView.mas_bottom).offset(0);
                    make.bottom.mas_equalTo(self.view.mas_bottom);
                    make.leading.mas_equalTo(self.view.mas_leading);
                    make.trailing.mas_equalTo(self.view.mas_trailing);
                    self.homeViewToTop = NO;
                }];

            } else {
                [self.homeSubViewController.view mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.top.mas_equalTo(self.tripScrollView.mas_top).offset(0);
                    make.bottom.mas_equalTo(self.view.mas_bottom);
                    make.leading.mas_equalTo(self.view.mas_leading);
                    make.trailing.mas_equalTo(self.view.mas_trailing);
                    self.homeViewToTop = YES;
                }];

            }
            
            [UIView animateWithDuration:0.8 animations:^{
                [self.homeSubViewController.view.superview layoutIfNeeded];
            }];

            break;
        }
        case UIGestureRecognizerStateChanged: {
            break;
        }
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateFailed:{
//            [self scopeTransitionDidEnd:sender];
            break;
        }
        default: {
            break;
        }
    }
}
#pragma mark - <UIGestureRecognizerDelegate>

// Whether scope gesture should begin
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    CGPoint location = [self.gesture locationInView:self.homeSubViewController.tableView];
    
    if (CGRectContainsPoint(self.homeSubViewController.tableView.frame, location)) {
        BOOL shouldBegin = _homeSubViewController.tableView.contentOffset.y <= -_homeSubViewController.tableView.contentInset.top;
        
        if (shouldBegin) {
            CGPoint velocity = [self.gesture velocityInView:self.view];
            if (self.homeViewToTop) {
                return velocity.y > 0;
            } else {
                return velocity.y < 0;
            }
        }
        return shouldBegin;
    }
    return NO;
}


#pragma mark - setter/getter
-(UIPanGestureRecognizer *)gesture {
    if (!_gesture) {
        UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleScopeGesture:)];
        panGesture.delegate = self;
        panGesture.minimumNumberOfTouches = 1;
        panGesture.maximumNumberOfTouches = 2;
        [self.view addGestureRecognizer:panGesture];
        _gesture = panGesture;
    }
    return _gesture;
}

- (WOPCTLHomeHeaderView *)homeHeaderView {
    if (!_homeHeaderView) {
        _homeHeaderView = [[WOPCTLHomeHeaderView alloc] init];
        _homeHeaderView.backgroundColor = [UIColor redColor];
        [self.view addSubview:_homeHeaderView];
    }
    return _homeHeaderView;
}
- (WOPCTLHomeSubViewController *)homeSubViewController {
    if (!_homeSubViewController) {
        _homeSubViewController = [[WOPCTLHomeSubViewController alloc] init];
        [_homeSubViewController.tableView.panGestureRecognizer requireGestureRecognizerToFail:self.gesture];
        [self addChildViewController:_homeSubViewController];
        [self.view addSubview:_homeSubViewController.view];
        _homeSubViewController.view.backgroundColor = [UIColor yellowColor];
    }
    return _homeSubViewController;
}
- (WOPCTLHomeNavigationView *)navigationView {
    if (!_navigationView) {
        _navigationView = [[WOPCTLHomeNavigationView alloc] init];
        [self.view addSubview:_navigationView];
    }
    return _navigationView;
}
- (UIScrollView *)tripScrollView {
    if (!_tripScrollView) {
        _tripScrollView = [[UIScrollView alloc] init];
        [self.homeHeaderView addSubview:_tripScrollView];
    }
    return _tripScrollView;
}
@end
