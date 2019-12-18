//
//  WOPCTLBaseTableViewCell.m
//  FSCalendarExample
//
//  Created by yujinhai on 2019/12/18.
//  Copyright © 2019 wenchaoios. All rights reserved.
//

#import "WOPCTLBaseTableViewCell.h"

@interface WOPCTLBaseTableViewCell ()


@end
@implementation WOPCTLBaseTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self p_initUI];
    }
    return self;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)p_initUI {
    self.backgroundColor = [UIColor clearColor];
    
    [self.tableBackgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView).offset(ctl_marge);
        make.right.mas_equalTo(self.contentView).offset(-ctl_marge);
        make.bottom.mas_equalTo(self.contentView).offset(-ctl_marge);
        make.top.mas_equalTo(self.contentView);
    }];
    [self.headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.tableBackgroundView);
        make.top.mas_equalTo(self.tableBackgroundView);
        make.right.mas_equalTo(self.tableBackgroundView);
        make.height.mas_equalTo(40);
    }];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.tableBackgroundView);
        make.top.mas_equalTo(self.headerView.mas_bottom);
        make.right.mas_equalTo(self.tableBackgroundView);
        make.height.mas_equalTo(1);
    }];
    [self.bottomContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.tableBackgroundView);
        make.top.mas_equalTo(self.lineView.mas_bottom);
        make.right.mas_equalTo(self.tableBackgroundView);
        make.bottom.mas_equalTo(self.tableBackgroundView);
    }];
}

- (void)layoutSubviews {
    [super layoutSubviews];
}

#pragma mark - setter/getter
- (UIImageView *)tableBackgroundView {
    if (!_tableBackgroundView) {
        _tableBackgroundView = [[UIImageView alloc] init];
        _tableBackgroundView.backgroundColor = [UIColor whiteColor];
        _tableBackgroundView = (UIImageView *)[WOPCTLBaseHelper ctl_addShadowForView:_tableBackgroundView];
        _tableBackgroundView = (UIImageView *)[WOPCTLBaseHelper ctl_addRoundingCorners:_tableBackgroundView];
        [self.contentView addSubview:_tableBackgroundView];
    }
    return _tableBackgroundView;
}
- (UIView *)bottomContentView {
    if (!_bottomContentView) {
        _bottomContentView = [[UIView alloc] init];
        _bottomContentView.backgroundColor = [UIColor clearColor];
        [self.tableBackgroundView addSubview:_bottomContentView];
    }
    return _bottomContentView;
}
- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = ctl_color_black333333(0.1);
        [self.tableBackgroundView addSubview:_lineView];
    }
    return _lineView;
}
- (WOPCTLBaseCellHeaderView *)headerView {
    if (!_headerView) {
        _headerView = [[WOPCTLBaseCellHeaderView alloc] init];
        [self.tableBackgroundView addSubview:_headerView];
    }
    return _headerView;
}
@end
