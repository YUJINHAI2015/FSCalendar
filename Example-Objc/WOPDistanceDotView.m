//
//  WOPDistanceDotView.m
//  FSCalendarExample
//
//  Created by yujinhai on 2019/12/18.
//  Copyright © 2019 wenchaoios. All rights reserved.
//

#import "WOPDistanceDotView.h"

@interface WOPDistanceDotView ()
@property (strong, nonatomic) UIView *firstDot;
@property (strong, nonatomic) UIView *secondDot;
@property (strong, nonatomic) UIView *lineView;
@property (assign, nonatomic) CGFloat dotHeigh;

@end

@implementation WOPDistanceDotView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.dotHeigh = 9;

    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    [self p_initUI];

}
- (void)p_initUI {
    self.lineView.frame = self.bounds;

    if (self.viewStatus == WOPDistanceDotViewStatusVertical) {
        self.firstDot.frame = CGRectMake((self.frame.size.width - self.dotHeigh) / 2, 0, self.dotHeigh, self.dotHeigh);
        self.secondDot.frame = CGRectMake(0, self.frame.size.height - self.dotHeigh, self.dotHeigh, self.dotHeigh);
    } else {
        self.firstDot.frame = CGRectMake(0, (self.frame.size.height - self.dotHeigh)/2, self.dotHeigh, self.dotHeigh);
        self.secondDot.frame = CGRectMake(self.frame.size.width - self.dotHeigh, (self.frame.size.height - self.dotHeigh)/2, self.dotHeigh, self.dotHeigh);
    }
    
    [self.lineView.layer addSublayer:[self drawLineRect:self.lineView.bounds dotColor:nil]];
    [self.firstDot.layer addSublayer:[self drawOvalRect:self.firstDot.bounds dotColor:self.firstDotColor]];
    [self.secondDot.layer addSublayer:[self drawOvalRect:self.secondDot.bounds dotColor:self.secondDotColor]];
}
- (CAShapeLayer *)drawOvalRect:(CGRect)rect dotColor:(UIColor *)color {
    if (color == nil) {
        color = ctl_color_grayd8d8d8(1);
    }
    // 线的路径
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:rect];
    CAShapeLayer *pathLayer = [CAShapeLayer layer];
    pathLayer.lineWidth = 1;
    pathLayer.strokeColor = color.CGColor;
    pathLayer.path = path.CGPath;
    pathLayer.fillColor = color.CGColor; // 默认为blackColor
    return pathLayer;
}

- (CAShapeLayer*)drawLineRect:(CGRect)rect dotColor:(UIColor *)color {
    if (color == nil) {
        color = ctl_color_grayd8d8d8(1);
    }
    // 线的路径
    UIBezierPath *linePath = [UIBezierPath bezierPath];
    if (self.viewStatus == WOPDistanceDotViewStatusVertical) {
        // 起点
        [linePath moveToPoint:CGPointMake(rect.size.width / 2, 0)];
        // 其他点
        [linePath addLineToPoint:CGPointMake(rect.size.width / 2, rect.size.height)];
    } else {
        // 起点
        [linePath moveToPoint:CGPointMake(0, rect.size.height / 2)];
        // 其他点
        [linePath addLineToPoint:CGPointMake(rect.size.width, rect.size.height / 2)];
    }
    
    CAShapeLayer *lineLayer = [CAShapeLayer layer];
    
    lineLayer.lineWidth = 1;
    lineLayer.strokeColor = color.CGColor;
    lineLayer.path = linePath.CGPath;
    lineLayer.fillColor = nil; // 默认为blackColor
    //  设置线宽，线间距
    [lineLayer setLineDashPattern:[NSArray arrayWithObjects:[NSNumber numberWithInt:3], [NSNumber numberWithInt:4], nil]];

    return lineLayer;
}

- (void)setFirstDotColor:(UIColor *)firstDotColor {
    _firstDotColor = firstDotColor;
}
- (void)setSecondDotColor:(UIColor *)secondDotColor {
    _secondDotColor = secondDotColor;
}
- (UIView *)firstDot {
    if (!_firstDot) {
        _firstDot = [[UIView alloc] init];
        [self addSubview:_firstDot];
    }
    return _firstDot;
}
- (UIView *)secondDot {
    if (!_secondDot) {
        _secondDot = [[UIView alloc] init];
        [self addSubview:_secondDot];
    }
    return _secondDot;
}
- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        [self addSubview:_lineView];
    }
    return _lineView;
}
@end
