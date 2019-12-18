//
//  WOPCalendarAllTableViewCell.h
//  FSCalendarExample
//
//  Created by yujinhai on 2019/12/18.
//  Copyright © 2019 wenchaoios. All rights reserved.
//

#import "WOPCTLBaseTableViewCell.h"
#import "WOPCalendarModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface WOPCalendarAllTableViewCell : WOPCTLBaseTableViewCell
- (void)configureWithCalendarModel:(WOPCalendarModel*)model;

@end

NS_ASSUME_NONNULL_END
