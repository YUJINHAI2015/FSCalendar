//
//  WOPCTLBaseHelper.m
//  FSCalendarExample
//
//  Created by yujinhai on 2019/12/18.
//  Copyright © 2019 wenchaoios. All rights reserved.
//

#import "WOPCTLBaseHelper.h"

@implementation WOPCTLBaseHelper

+ (UIView *)ctl_addShadowForView:(UIView *)view {
    
    view.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    view.layer.shadowOffset = CGSizeMake(5, 5);
    view.layer.shadowOpacity = 0.4;
    view.layer.shadowRadius = 3.0;
    return view;
}
+ (UIView *)ctl_addRoundingCorners:(UIView *)view {
    view.layer.cornerRadius = 8;
    return view;
}

+ (CAShapeLayer *)ctl_addRoundingCorners:(UIRectCorner)corners rect:(CGRect)rect {
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect
                                               byRoundingCorners:(UIRectCornerTopRight | UIRectCornerTopLeft )
                                                     cornerRadii:CGSizeMake(8, 8)];
    CAShapeLayer *layer = [[CAShapeLayer alloc] init];
    layer.frame = rect;
    layer.path = path.CGPath;
    return layer;
}
@end
