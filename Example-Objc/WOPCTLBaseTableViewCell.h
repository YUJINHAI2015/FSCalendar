//
//  WOPCTLBaseTableViewCell.h
//  FSCalendarExample
//
//  Created by yujinhai on 2019/12/18.
//  Copyright © 2019 wenchaoios. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WOPCTLBaseHelper.h"
#import "Masonry.h"
#import "WOPCTLBaseCellHeaderView.h"

NS_ASSUME_NONNULL_BEGIN

@interface WOPCTLBaseTableViewCell : UITableViewCell

@property (nonatomic, strong) WOPCTLBaseCellHeaderView *headerView;
@property (nonatomic, strong) UIImageView *tableBackgroundView;
@property (nonatomic, strong) UIView *bottomContentView;
@property (nonatomic, strong) UIView *lineView;

@end

NS_ASSUME_NONNULL_END
