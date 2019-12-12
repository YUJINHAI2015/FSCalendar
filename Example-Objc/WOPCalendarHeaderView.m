//
//  WOPCalendarHeaderView.m
//  FSCalendarExample
//
//  Created by yujinhai on 2019/12/12.
//  Copyright © 2019 wenchaoios. All rights reserved.
//

#import "WOPCalendarHeaderView.h"
#import "FSCalendar.h"
#import "FSCalendarExtensions.h"
#import "FSCalendarDynamicHeader.h"

@interface WOPCalendarHeaderView ()

@property (weak, nonatomic) IBOutlet UILabel *monthLabel;
@property (weak, nonatomic) IBOutlet UILabel *yearLabel;
@property (weak, nonatomic) IBOutlet UIView *headerContentView;

@property (strong, nonatomic) NSDateFormatter *yearDateFormatter;
@property (strong, nonatomic) NSDateFormatter *monthDateFormatter;

@end

@implementation WOPCalendarHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil] firstObject];
        self.yearDateFormatter = [[NSDateFormatter alloc] init];
        self.yearDateFormatter.dateFormat = @"yyyy";
        self.monthDateFormatter = [[NSDateFormatter alloc] init];
        self.monthDateFormatter.dateFormat = @"MMMM";

    }
    return self;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    [self bringSubviewToFront:self.headerContentView];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                               byRoundingCorners:(UIRectCornerTopRight | UIRectCornerTopLeft )
                                                     cornerRadii:CGSizeMake(8, 8)];
    CAShapeLayer *layer = [[CAShapeLayer alloc] init];
    layer.frame = self.bounds;
    layer.path = path.CGPath;
    self.layer.mask = layer;

}

- (void)reloadData {
    
    self.yearLabel.text = [self.yearDateFormatter stringFromDate:self.calendar.currentPage];
    self.monthLabel.text = [self.monthDateFormatter stringFromDate:self.calendar.currentPage];
}
@end
