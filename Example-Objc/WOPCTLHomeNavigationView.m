//
//  WOPCTLHomeNavigationView.m
//  FSCalendarExample
//
//  Created by yujinhai on 2019/12/23.
//  Copyright © 2019 wenchaoios. All rights reserved.
//

#import "WOPCTLHomeNavigationView.h"
#import "Masonry.h"

@interface WOPCTLHomeNavigationView ()
@property (nonatomic, strong) UIButton *leftButton;
@property (nonatomic, strong) UIButton *rightFirstButton;
@property (nonatomic, strong) UIButton *rightSecondButton;

@end
@implementation WOPCTLHomeNavigationView


- (instancetype)init
{
    self = [super init];
    if (self) {
        [self p_initUI];
        self.leftButton.backgroundColor = [UIColor blueColor];
        self.rightFirstButton.backgroundColor = [UIColor blueColor];
        self.rightSecondButton.backgroundColor = [UIColor blueColor];
    }
    return self;
}
- (void)p_initUI {
    [self.leftButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(30);
        make.bottom.mas_equalTo(self);
        make.size.mas_equalTo(CGSizeMake(40, 24));
    }];
    
    [self.rightFirstButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.mas_right).offset(-20);
        make.centerY.mas_equalTo(self.leftButton.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(24, 24));
    }];
    [self.rightSecondButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.rightFirstButton.mas_left).offset(-26);
        make.centerY.mas_equalTo(self.leftButton.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(24, 24));
    }];

}
- (UIButton *)leftButton {
    if (!_leftButton) {
        _leftButton = [[UIButton alloc] init];
        [self addSubview:_leftButton];
    }
    return _leftButton;
}
- (UIButton *)rightFirstButton {
    if (!_rightFirstButton) {
        _rightFirstButton = [[UIButton alloc] init];
        [self addSubview:_rightFirstButton];
    }
    return _rightFirstButton;
}

- (UIButton *)rightSecondButton {
    if (!_rightSecondButton) {
        _rightSecondButton = [[UIButton alloc] init];
        [self addSubview:_rightSecondButton];
    }
    return _rightSecondButton;
}

@end
