//
//  WOPCalendarPartTableViewCell.m
//  FSCalendarExample
//
//  Created by yujinhai on 2019/12/18.
//  Copyright © 2019 wenchaoios. All rights reserved.
//

#import "WOPCalendarPartTableViewCell.h"
#import "WOPDistanceDotView.h"

@interface WOPCalendarPartTableViewCell ()
@property (nonatomic, strong) WOPDistanceDotView *dotView;
@property (nonatomic, strong) UILabel *firstBlackLabel;
@property (nonatomic, strong) UILabel *secondBlackLabel;
@property (nonatomic, strong) UILabel *firstGrayLabel;
@property (nonatomic, strong) UILabel *secondGrayLabel;

@end
@implementation WOPCalendarPartTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {

    }
    return self;
}
- (void)configureWithCalendarModel:(WOPCalendarModel*)model {
    self.headerView.leftImageView.backgroundColor = [UIColor yellowColor];
    self.headerView.firstTitleLabel.text = model.companyName;
    self.headerView.secondTitleLabel.text = model.airplaneName;
    self.headerView.thirdTitleLabel.text = model.airplaneNumber;
    self.headerView.firstTitleLabel.textColor = ctl_color_black333333(0.5);
    self.headerView.secondTitleLabel.textColor = ctl_color_black333333(1);
    self.headerView.thirdTitleLabel.textColor = ctl_color_black333333(1);

    
    self.firstBlackLabel.text = [NSString stringWithFormat:@"%@ %@",model.departureTime,model.departureAdsress];
    self.secondBlackLabel.text = [NSString stringWithFormat:@"%@ %@",model.destinationTime,model.destinationAddress];
    self.firstGrayLabel.text = model.departureAirport;
    self.secondGrayLabel.text = model.destinationAirport;

    self.firstBlackLabel.textColor = ctl_color_black333333(1);
    self.firstBlackLabel.font = ctl_FontPingFangSC_Semibold(16);
    self.secondBlackLabel.textColor = ctl_color_black333333(1);
    self.secondBlackLabel.font = ctl_FontPingFangSC_Semibold(16);
    self.firstGrayLabel.textColor = ctl_color_black333333(0.5);
    self.firstGrayLabel.font = ctl_FontPingFangSC_Regular(16);
    self.secondGrayLabel.textColor = ctl_color_black333333(0.5);
    self.secondGrayLabel.font = ctl_FontPingFangSC_Regular(16);
    self.dotView.firstDotColor = ctl_color_green5EAC0C(1);
    self.dotView.viewStatus = WOPDistanceDotViewStatusHorizontal;

    [self.firstBlackLabel setContentCompressionResistancePriority:UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisHorizontal];
    [self.firstGrayLabel setContentCompressionResistancePriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
    [self.secondBlackLabel setContentCompressionResistancePriority:UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisHorizontal];
    [self.secondGrayLabel setContentCompressionResistancePriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];

    [self.dotView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.bottomContentView).offset(24);
        make.top.mas_equalTo(self.bottomContentView).offset(22);
        make.bottom.mas_equalTo(self.bottomContentView).offset(-24);
        make.width.mas_equalTo(9);
    }];
    
    [self.firstBlackLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.bottomContentView).offset(48);
        make.top.mas_equalTo(self.bottomContentView).offset(15);
        make.right.mas_lessThanOrEqualTo(self.firstGrayLabel.mas_left).offset(0);
    }];
    [self.secondBlackLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.bottomContentView).offset(48);
        make.bottom.mas_equalTo(self.bottomContentView).offset(-19);
        make.right.mas_lessThanOrEqualTo(self.secondGrayLabel.mas_left).offset(0);
    }];
    [self.firstGrayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.bottomContentView).offset(-18);
        make.top.mas_equalTo(self.bottomContentView).offset(15);
        make.left.mas_lessThanOrEqualTo(self.firstBlackLabel.mas_right).offset(0).priorityLow();

    }];
    [self.secondGrayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.bottomContentView).offset(-18);
        make.bottom.mas_equalTo(self.bottomContentView).offset(-19);
        make.left.mas_lessThanOrEqualTo(self.secondBlackLabel.mas_right).offset(0).priorityLow();
    }];
}

- (WOPDistanceDotView *)dotView {
    if (!_dotView) {
        _dotView = [[WOPDistanceDotView alloc] init];
        [self.bottomContentView addSubview:_dotView];
    }
    return _dotView;
}
- (UILabel *)firstBlackLabel {
    if (!_firstBlackLabel) {
        _firstBlackLabel = [[UILabel alloc] init];
        [self.bottomContentView addSubview:_firstBlackLabel];
    }
    return _firstBlackLabel;
}
- (UILabel *)secondBlackLabel {
    if (!_secondBlackLabel) {
        _secondBlackLabel = [[UILabel alloc] init];
        [self.bottomContentView addSubview:_secondBlackLabel];
    }
    return _secondBlackLabel;
}
- (UILabel *)firstGrayLabel {
    if (!_firstGrayLabel) {
        _firstGrayLabel = [[UILabel alloc] init];
        [self.bottomContentView addSubview:_firstGrayLabel];
    }
    return _firstGrayLabel;
}
- (UILabel *)secondGrayLabel {
    if (!_secondGrayLabel) {
        _secondGrayLabel = [[UILabel alloc] init];
        [self.bottomContentView addSubview:_secondGrayLabel];
    }
    return _secondGrayLabel;
}

@end
