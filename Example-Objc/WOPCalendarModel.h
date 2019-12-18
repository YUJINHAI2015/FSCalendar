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


@property (nonatomic, strong) NSString *hotelName;               // 酒店名称
@property (nonatomic, strong) NSString *hotelRoomNumber;         // 酒店房间号码
@property (nonatomic, strong) NSString *hotelAddress;            // 酒店地址
@property (nonatomic, strong) NSString *hotelFirstDay;           // 酒店入住第一天
@property (nonatomic, strong) NSString *hotelLastDay;            // 酒店入住最后一天
@property (nonatomic, strong) NSString *hotelTotalDays;          // 酒店入住总共天数
@property (nonatomic, strong) NSString *otherMessage;            // 酒店其他信息
@property (nonatomic, strong) NSArray  *hotelOccupancy;          // 酒店入住人数


@property (nonatomic, assign) WOPCalendarCellType type;



@end

NS_ASSUME_NONNULL_END
