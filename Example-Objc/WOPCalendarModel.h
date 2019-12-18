//
//  WOPCalendarModel.h
//  FSCalendarExample
//
//  Created by yujinhai on 2019/12/18.
//  Copyright © 2019 wenchaoios. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, WOPCalendarCellType) {
    WOPCalendarCellTypePart,
    WOPCalendarCellTypeAll
};

@interface WOPCalendarModel : NSObject
@property (nonatomic, strong) NSString *name;
@property (nonatomic, assign) WOPCalendarCellType type;
@end

NS_ASSUME_NONNULL_END
