//
//  WOPCalendarAllTableViewCell.m
//  FSCalendarExample
//
//  Created by yujinhai on 2019/12/18.
//  Copyright © 2019 wenchaoios. All rights reserved.
//

#import "WOPCalendarAllTableViewCell.h"
#import "WOPDistanceDotView.h"

@interface WOPCalendarAllTableViewCell ()
@property (nonatomic, strong) UIImageView *locationImageView;
@property (nonatomic, strong) UIImageView *persionImageView;
@property (nonatomic, strong) UILabel *locationLabel;
@property (nonatomic, strong) UILabel *hotelFirstDayLabel;
@property (nonatomic, strong) UILabel *hotelFinalDayLabel;
@property (nonatomic, strong) UILabel *hotelTotalDayLabel;
@property (nonatomic, strong) UILabel *hotelOtherMessageLabel;
@property (nonatomic, strong) UILabel *hotelPersionLabel;
@property (nonatomic, strong) WOPDistanceDotView *dotView;

@end
@implementation WOPCalendarAllTableViewCell

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
- (void)configureWithCalendarModel:(WOPCalendarModel *)model {
    self.headerView.leftImageView.backgroundColor = [UIColor yellowColor];
    self.headerView.firstTitleLabel.text = model.hotelName;
    self.headerView.secondTitleLabel.text = @"";
    self.headerView.thirdTitleLabel.text = model.hotelRoomNumber;
    self.headerView.firstTitleLabel.textColor = ctl_color_black333333(0.5);
    self.headerView.secondTitleLabel.textColor = ctl_color_black333333(1);
    self.headerView.thirdTitleLabel.textColor = ctl_color_black333333(1);

    self.locationLabel.text = model.hotelAddress;
    self.hotelFirstDayLabel.text = model.hotelFirstDay;
    self.dotView.viewStatus = WOPDistanceDotViewStatusVertical;
    self.dotView.firstDotColor = ctl_color_green5EAC0C(1);
    self.hotelFinalDayLabel.text = model.hotelLastDay;
    self.hotelTotalDayLabel.text = [NSString stringWithFormat:@"%@ days",model.hotelTotalDays];
    self.hotelOtherMessageLabel.text = model.otherMessage;
    self.hotelPersionLabel.text = [model.hotelOccupancy componentsJoinedByString:@","];
    [self.locationImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.bottomContentView).offset(21);
        make.top.mas_equalTo(self.bottomContentView).offset(20);
        make.height.mas_equalTo(13);
        make.width.mas_equalTo(10);
    }];
    
    [self.locationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.bottomContentView).offset(48);
        make.top.mas_equalTo(self.bottomContentView).offset(16);
        make.right.mas_equalTo(self.bottomContentView).offset(-44);
    }];

    [self.hotelFirstDayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.bottomContentView).offset(48);
        make.top.mas_equalTo(self.locationLabel.mas_bottom).offset(10);
    }];
    [self.dotView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.hotelFirstDayLabel.mas_right).offset(10);
        make.centerY.mas_equalTo(self.hotelFirstDayLabel.mas_centerY);
        make.width.mas_equalTo(48);
    }];

    [self.hotelFinalDayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.dotView.mas_right).offset(10);
        make.centerY.mas_equalTo(self.hotelFirstDayLabel.mas_centerY);
    }];

    [self.hotelTotalDayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.hotelFinalDayLabel.mas_right).offset(20);
        make.centerY.mas_equalTo(self.hotelFirstDayLabel.mas_centerY);
    }];
    [self.hotelOtherMessageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.bottomContentView).offset(48);
        make.right.mas_equalTo(self.bottomContentView).offset(-44);
        make.top.mas_equalTo(self.hotelTotalDayLabel.mas_bottom).offset(10);
    }];
    [self.persionImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.bottomContentView).offset(21);
        make.bottom.mas_equalTo(self.bottomContentView).offset(-24);
        make.height.mas_equalTo(13);
        make.width.mas_equalTo(10);
    }];
    [self.hotelPersionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.bottomContentView).offset(48);
        make.bottom.mas_equalTo(self.bottomContentView).offset(-20);
        make.right.mas_equalTo(self.bottomContentView).offset(-44);
    }];

}

- (UIImageView *)locationImageView {
    if (!_locationImageView) {
        _locationImageView = [[UIImageView alloc] init];
        _locationImageView.backgroundColor= [UIColor redColor];
        [self.bottomContentView addSubview:_locationImageView];
    }
    return _locationImageView;
}
- (UIImageView *)persionImageView {
    if (!_persionImageView) {
        _persionImageView = [[UIImageView alloc] init];
        _persionImageView.backgroundColor= [UIColor redColor];
        [self.bottomContentView addSubview:_persionImageView];
    }
    return _persionImageView;
}

- (UILabel *)locationLabel {
    if (!_locationLabel) {
        _locationLabel = [[UILabel alloc] init];
        _locationLabel.numberOfLines = 0;
        [self.bottomContentView addSubview:_locationLabel];
    }
    return _locationLabel;
}
- (UILabel *)hotelFirstDayLabel {
    if (!_hotelFirstDayLabel) {
        _hotelFirstDayLabel = [[UILabel alloc] init];
        [self.bottomContentView addSubview:_hotelFirstDayLabel];
    }
    return _hotelFirstDayLabel;
}
- (UILabel *)hotelFinalDayLabel {
    if (!_hotelFinalDayLabel) {
        _hotelFinalDayLabel = [[UILabel alloc] init];
        [self.bottomContentView addSubview:_hotelFinalDayLabel];
    }
    return _hotelFinalDayLabel;
}
- (UILabel *)hotelTotalDayLabel {
    if (!_hotelTotalDayLabel) {
        _hotelTotalDayLabel = [[UILabel alloc] init];
        [self.bottomContentView addSubview:_hotelTotalDayLabel];
    }
    return _hotelTotalDayLabel;
}
- (UILabel *)hotelOtherMessageLabel {
    if (!_hotelOtherMessageLabel) {
        _hotelOtherMessageLabel = [[UILabel alloc] init];
        [self.bottomContentView addSubview:_hotelOtherMessageLabel];
    }
    return _hotelOtherMessageLabel;
}
- (UILabel *)hotelPersionLabel {
    if (!_hotelPersionLabel) {
        _hotelPersionLabel = [[UILabel alloc] init];
        [self.bottomContentView addSubview:_hotelPersionLabel];
    }
    return _hotelPersionLabel;
}
- (WOPDistanceDotView *)dotView {
    if (!_dotView) {
        _dotView = [[WOPDistanceDotView alloc] init];
        [self.bottomContentView addSubview:_dotView];
    }
    return _dotView;
}

@end
