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

@interface WOPCTLHomeBaseViewController ()<UIGestureRecognizerDelegate>
@property (strong, nonatomic) WOPCTLHomeHeaderView *homeHeaderView;
@property (strong, nonatomic) WOPCTLHomeSubViewController *homeSubViewController;
@property (strong, nonatomic) UIPanGestureRecognizer *gesture;
@property (assign, nonatomic) BOOL homeViewToTop;

@end

@implementation WOPCTLHomeBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = ctl_color_grayf9f9f9(1);
    self.automaticallyAdjustsScrollViewInsets = NO;

    [self p_initUI];

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
                    make.top.mas_equalTo(self.view).offset(88);
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
    
    BOOL shouldBegin = _homeSubViewController.tableView.contentOffset.y <= -_homeSubViewController.tableView.contentInset.top;
    
    NSLog(@"offset %f",_homeSubViewController.tableView.contentOffset.y);
    NSLog(@"insert %f",_homeSubViewController.tableView.contentInset.top);
    
    if (shouldBegin) {
        CGPoint velocity = [self.gesture velocityInView:self.view];
        NSLog(@"velocity %f",velocity.y);
        if (self.homeViewToTop) {
            return velocity.y > 0;
        } else {
            return velocity.y < 0;
        }
    }
    return shouldBegin;

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
@end
