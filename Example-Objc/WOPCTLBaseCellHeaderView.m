//
//  WOPCTLBaseCellHeaderView.m
//  FSCalendarExample
//
//  Created by yujinhai on 2019/12/18.
//  Copyright © 2019 wenchaoios. All rights reserved.
//

#import "WOPCTLBaseCellHeaderView.h"
#import "Masonry.h"

@interface WOPCTLBaseCellHeaderView ()

@end

@implementation WOPCTLBaseCellHeaderView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self p_initUI];
    }
    return self;
}
- (void)p_initUI {
    self.backgroundColor = [UIColor whiteColor];
    self.leftImageView = [[UIImageView alloc] init];
    [self addSubview:self.leftImageView];
    
    self.firstTitleLabel = [[UILabel alloc] init];
    [self addSubview:self.firstTitleLabel];
    self.secondTitleLabel = [[UILabel alloc] init];
    [self addSubview:self.secondTitleLabel];
    self.thirdTitleLabel = [[UILabel alloc] init];
    [self addSubview:self.thirdTitleLabel];
    
    self.firstTitleLabel.textColor = [UIColor whiteColor];
    self.firstTitleLabel.font = ctl_FontPingFangSC_Semibold(14);
    
    self.secondTitleLabel.textColor = [UIColor whiteColor];
    self.secondTitleLabel.font = ctl_FontPingFangSC_Semibold(14);
    
    self.thirdTitleLabel.textColor = [UIColor whiteColor];
    self.thirdTitleLabel.font = ctl_FontPingFangSC_Semibold(14);
    
    [self.leftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).offset(14);
        make.centerY.mas_equalTo(self);
        make.size.mas_equalTo(CGSizeMake(24, 24));
    }];
    
    [self.firstTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.leftImageView.mas_right).offset(-10);
        make.centerY.mas_equalTo(self);
    }];

    [self.secondTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.firstTitleLabel.mas_right).offset(-20);
        make.centerY.mas_equalTo(self);
        make.right.mas_lessThanOrEqualTo(self.thirdTitleLabel.mas_left).offset(0);
    }];

    [self.thirdTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self).offset(-14);
        make.centerY.mas_equalTo(self);
    }];


}
- (void)awakeFromNib {
    [super awakeFromNib];

}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.layer.mask = [WOPCTLBaseHelper ctl_addRoundingCorners:(UIRectCornerTopRight | UIRectCornerTopLeft) rect:self.bounds];
}

@end
