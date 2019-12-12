//
//  WOPCalendarSubViewController.h
//  FSCalendarExample
//
//  Created by yujinhai on 2019/12/12.
//  Copyright © 2019 wenchaoios. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WOPCalendarSubViewController : UIViewController

@property (strong, nonatomic) UITableView *tableView;
- (void)didSelectedDates:(NSArray *)dates;
@end

NS_ASSUME_NONNULL_END
