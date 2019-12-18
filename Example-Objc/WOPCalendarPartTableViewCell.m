//
//  WOPCalendarPartTableViewCell.m
//  FSCalendarExample
//
//  Created by yujinhai on 2019/12/18.
//  Copyright © 2019 wenchaoios. All rights reserved.
//

#import "WOPCalendarPartTableViewCell.h"

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
- (void)updateConstraints {
    [super updateConstraints];
//    [self.headerView mas_remakeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(self.tableBackgroundView);
//        make.top.mas_equalTo(self.tableBackgroundView);
//        make.right.mas_equalTo(self.tableBackgroundView);
//        make.height.mas_equalTo(40);
//        
//    }];

}
@end
