//
//  WOPCTLBaseHelper.h
//  FSCalendarExample
//
//  Created by yujinhai on 2019/12/18.
//  Copyright © 2019 wenchaoios. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


//获取系统版本
#define ctl_IOS_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]
#define ctl_IS_IOS_VERSION(v) ((ctl_IOS_VERSION >= v) ? YES : NO)

// 颜色
#define ctl_color_black333333(a) [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:a];
#define ctl_color_blue2768f3(a) [UIColor colorWithRed:54/255.0 green:106/255.0 blue:234/255.0 alpha:a];
#define ctl_color_green5EAC0C(a) [UIColor colorWithRed:94/255.0 green:172/255.0 blue:12/255.0 alpha:a];

#define ctl_marge 20
// 字体
#define ctl_FontPingFangSC_Regular(s) ctl_IS_IOS_VERSION(9.0)?[UIFont fontWithName:@"PingFangSC-Regular" size:s]:[UIFont systemFontOfSize:s/1.0f]
#define ctl_FontPingFangSC_Light(s) ctl_IS_IOS_VERSION(9.0)?[UIFont fontWithName:@"PingFangSC-Light" size:s]:[UIFont systemFontOfSize:s/1.0f]
#define ctl_FontPingFangSC_Medium(s) ctl_IS_IOS_VERSION(9.0)?[UIFont fontWithName:@"PingFangSC-Medium" size:s]:[UIFont systemFontOfSize:s/1.0f]
#define ctl_FontPingFangSC_Semibold(s) ctl_IS_IOS_VERSION(9.0)?[UIFont fontWithName:@"PingFangSC-Semibold" size:s]:[UIFont systemFontOfSize:s/1.0f]


@interface WOPCTLBaseHelper : NSObject
// 添加
+ (UIView *)ctl_addShadowForView:(UIView *)view;
+ (UIView *)ctl_addRoundingCorners:(UIView *)view;
+ (CAShapeLayer *)ctl_addRoundingCorners:(UIRectCorner)corners rect:(CGRect)rect;
@end

NS_ASSUME_NONNULL_END
