//
//  WOPCalendarHeaderView.h
//  FSCalendarExample
//
//  Created by yujinhai on 2019/12/12.
//  Copyright © 2019 wenchaoios. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FSCalendarHeaderView.h"
#import "WOPCTLBaseHelper.h"

NS_ASSUME_NONNULL_BEGIN

@protocol WOPCalendarHeaderViewDelegate <NSObject>

typedef NS_ENUM(NSUInteger, WOPCalendarHeaderViewMonthStatus) {
    WOPCalendarHeaderViewMonthLast,
    WOPCalendarHeaderViewMonthNext
};

@optional

- (void)calendarHeaderView:(FSCalendarHeaderView *)headerView
                 didSelect:(FSCalendar *)currentCalendar
               monthStatus:(WOPCalendarHeaderViewMonthStatus)monthStatus;
//- (void)calendarHeaderView:(FSCalendarHeaderView *)headerView didSelect:(FSCalendar *)currentCalendar;

@end

@interface WOPCalendarHeaderView : FSCalendarHeaderView

@property (nonatomic, assign) id<WOPCalendarHeaderViewDelegate> delegate;

@end
NS_ASSUME_NONNULL_END
