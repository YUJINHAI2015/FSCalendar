//
//  WOPDistanceDotView.h
//  FSCalendarExample
//
//  Created by yujinhai on 2019/12/18.
//  Copyright © 2019 wenchaoios. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WOPCTLBaseHelper.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, WOPDistanceDotViewStatus) {
    WOPDistanceDotViewStatusVertical = 0, // 垂直
    WOPDistanceDotViewStatusHorizontal, // 水平
};

@interface WOPDistanceDotView : UIView
@property (assign, nonatomic) WOPDistanceDotViewStatus viewStatus;

@property (strong, nonatomic) UIColor *firstDotColor;
@property (strong, nonatomic) UIColor *secondDotColor;

@end

NS_ASSUME_NONNULL_END
