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

@property (nonatomic, strong) NSString *companyName;          // 公司名称
@property (nonatomic, strong) NSString *airplaneName;         // 飞机名称
@property (nonatomic, strong) NSString *airplaneNumber;       // 飞机编号
@property (nonatomic, strong) NSString *departureAdsress;     // 起飞地点
@property (nonatomic, strong) NSString *destinationAddress;   // 降落地点
@property (nonatomic, strong) NSString *departureTime;        // 降落时间
@property (nonatomic, strong) NSString *destinationTime;      // 降落时间
@property (nonatomic, strong) NSString *departureAirport;     // 起飞port
@property (nonatomic, strong) NSString *destinationAirport;   // 降落port
@property (nonatomic, strong) NSArray  *passengers;           // 乘客


@property (nonatomic, assign) WOPCalendarCellType type;



@end

NS_ASSUME_NONNULL_END
