//
//  LunarFormatter.h
//  FSCalendar
//
//  Created by Wenchao Ding on 25/07/2017.
//  Copyright © 2017 wenchaoios. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LunarFormatter : NSObject

- (NSString *)stringFromDate:(NSDate *)date;

- (void)loadCalendarEventsWithStartDate:(NSDate *)startDate
                                endDate:(NSDate *)endDate
                              completed:(void (^)(void))completed;
@end

NS_ASSUME_NONNULL_END
