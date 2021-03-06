//
//  WOPCalendarBaseViewController.m
//  FSCalendarExample
//
//  Created by yujinhai on 2019/12/11.
//  Copyright © 2019 wenchaoios. All rights reserved.
//

#import "WOPCalendarBaseViewController.h"
#import "FSCalendar.h"
#import "Masonry.h"
#import "FSCalendarCollectionView.h"
#import "WOPCalendarSubViewController.h"
#import "WOPCTLBaseHelper.h"
#import "LunarFormatter.h"


@interface WOPCalendarBaseViewController ()<FSCalendarDataSource,FSCalendarDelegate,UIGestureRecognizerDelegate>
{
    void * _KVOContext;
}

@property (strong, nonatomic) FSCalendar *calendar;
@property (strong, nonatomic) NSDateFormatter *dateFormatter;
@property (strong, nonatomic) UIPanGestureRecognizer *scopeGesture;
@property (strong, nonatomic) WOPCalendarSubViewController *calendarSubViewController;
@property (strong, nonatomic) LunarFormatter *lunarFormatter;

#define Calendar_Header_BackgroundColor ctl_color_blue2768f3(1);
#define Calendar_Normal_TextColor       ctl_color_black333333(1);
#define Calendar_Selected_TextColor(ap) ctl_color_blue2768f3(ap);
#define Calendar_Today_TextColor        ctl_color_green5EAC0C(1);
#define Calendar_ContentView_BackgroundColor [UIColor whiteColor];

#define Calendar_Marge ctl_marge
#define Calendar_Header_Height 66
#define Calendar_Weekday_Height 44
@end

@implementation WOPCalendarBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = ctl_color_grayf9f9f9(1);

    __weak typeof(self) weakSelf = self;

    [self p_initUI];
    // 默认选中今天
    NSString *today = [self.dateFormatter stringFromDate:self.calendar.today];
    [self.calendarSubViewController didSelectedDates:@[today]];

    _lunarFormatter = [[LunarFormatter alloc] init];
    
    [self.lunarFormatter loadCalendarEventsWithStartDate:self.calendar.minimumDate endDate:self.calendar.maximumDate completed:^{
        [weakSelf.calendar reloadData];
    }];

}
- (void)p_initUI {
    [self.calendar mas_makeConstraints:^(MASConstraintMaker *make) {
        // 450 for iPad and 300 for iPhone
        CGFloat height = [[UIDevice currentDevice].model hasPrefix:@"iPad"] ? 450 : 250;
        make.height.mas_equalTo(height);
        make.top.mas_equalTo(self.view.mas_top).offset(0);
        make.leading.mas_equalTo(self.view.mas_leading);
        make.trailing.mas_equalTo(self.view.mas_trailing);
    }];

    [self.calendarSubViewController.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.calendar.mas_bottom).offset(Calendar_Marge);
        make.bottom.mas_equalTo(self.view.mas_bottom);
        make.leading.mas_equalTo(self.view.mas_leading);
        make.trailing.mas_equalTo(self.view.mas_trailing);
    }];
    
}

- (void)dealloc
{
    [self.calendar removeObserver:self forKeyPath:@"scope" context:_KVOContext];
    NSLog(@"%s",__FUNCTION__);
}

#pragma mark - KVO
    
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    if (context == _KVOContext) {
        FSCalendarScope oldScope = [change[NSKeyValueChangeOldKey] unsignedIntegerValue];
        FSCalendarScope newScope = [change[NSKeyValueChangeNewKey] unsignedIntegerValue];
        NSLog(@"From %@ to %@",(oldScope==FSCalendarScopeWeek?@"week":@"month"),(newScope==FSCalendarScopeWeek?@"week":@"month"));
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

#pragma mark - <UIGestureRecognizerDelegate>

// Whether scope gesture should begin
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    BOOL shouldBegin = _calendarSubViewController.tableView.contentOffset.y <= -_calendarSubViewController.tableView.contentInset.top;
    
    NSLog(@"offset %f",_calendarSubViewController.tableView.contentOffset.y);
    NSLog(@"insert %f",_calendarSubViewController.tableView.contentInset.top);

    if (shouldBegin) {
        CGPoint velocity = [self.scopeGesture velocityInView:self.view];
        NSLog(@"velocity %f",velocity.y);

        switch (self.calendar.scope) {
            case FSCalendarScopeMonth:
                return velocity.y < 0;
            case FSCalendarScopeWeek:
                return velocity.y > 0;
        }
    }
    return shouldBegin;
}
#pragma mark - FSCalendarDataSource

- (NSDate *)minimumDateForCalendar:(FSCalendar *)calendar
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-MM-dd";
    
    NSDate *minimumDate = [self.dateFormatter dateFromString:@"2020-01-01"];

    return minimumDate;
}

- (NSDate *)maximumDateForCalendar:(FSCalendar *)calendar
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-MM-dd";
    
    NSDate *maximumDate = [self.dateFormatter dateFromString:@"2020-04-01"];

    return maximumDate;
}

- (NSString *)calendar:(FSCalendar *)calendar subtitleForDate:(NSDate *)date
{
    return [self.lunarFormatter stringFromDate:date];
}

#pragma mark - <FSCalendarDelegate>

- (void)calendar:(FSCalendar *)calendar boundingRectWillChange:(CGRect)bounds animated:(BOOL)animated
{
    [self.calendar mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(CGRectGetHeight(bounds));
    }];
    [self.view layoutIfNeeded];
}

- (void)calendar:(FSCalendar *)calendar didSelectDate:(NSDate *)date atMonthPosition:(FSCalendarMonthPosition)monthPosition
{
    NSLog(@"did select date %@",[self.dateFormatter stringFromDate:date]);

    NSMutableArray *selectedDates = [NSMutableArray arrayWithCapacity:calendar.selectedDates.count];
    [calendar.selectedDates enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [selectedDates addObject:[self.dateFormatter stringFromDate:obj]];
    }];
    NSLog(@"selected dates is %@",selectedDates);
    if (monthPosition == FSCalendarMonthPositionNext || monthPosition == FSCalendarMonthPositionPrevious) {
        [calendar setCurrentPage:date animated:YES];
    }
    [self.calendarSubViewController didSelectedDates:[selectedDates copy]];
}

- (void)calendarCurrentPageDidChange:(FSCalendar *)calendar
{
    NSLog(@"%s %@", __FUNCTION__, [self.dateFormatter stringFromDate:calendar.currentPage]);

}
- (void)calendar:(FSCalendar *)calendar willDisplayCell:(FSCalendarCell *)cell forDate:(NSDate *)date atMonthPosition:(FSCalendarMonthPosition)monthPosition {

}
- (nullable UIColor *)calendar:(FSCalendar *)calendar appearance:(FSCalendarAppearance *)appearance titleDefaultColorForDate:(NSDate *)date {
    
    NSCalendar * myCalendar = [NSCalendar currentCalendar];
    myCalendar.timeZone = [NSTimeZone systemTimeZone];
    NSInteger week = [[myCalendar components:NSCalendarUnitWeekday fromDate:date] weekday];
    
    if (week == 1 || week == 7) {
        return [UIColor lightGrayColor];
    }
    return nil;
}
- (nullable UIColor *)calendar:(FSCalendar *)calendar appearance:(FSCalendarAppearance *)appearance subtitleDefaultColorForDate:(NSDate *)date {
    NSCalendar * myCalendar = [NSCalendar currentCalendar];
    myCalendar.timeZone = [NSTimeZone systemTimeZone];
    NSInteger week = [[myCalendar components:NSCalendarUnitWeekday fromDate:date] weekday];
    
    if (week == 1 || week == 7) {
        return [UIColor lightGrayColor];
    }
    return nil;
}
- (nullable UIColor *)calendar:(FSCalendar *)calendar appearance:(FSCalendarAppearance *)appearance titleSelectionColorForDate:(NSDate *)date {
    
    if ([[self.dateFormatter stringFromDate:date] isEqualToString:[self.dateFormatter stringFromDate:[NSDate date]]]) {

        return Calendar_Today_TextColor;
    } else {
        return Calendar_Normal_TextColor;
    }
}
#pragma mark - setter/getter
- (WOPCalendarSubViewController *)calendarSubViewController {
    if (!_calendarSubViewController) {
        _calendarSubViewController = [[WOPCalendarSubViewController alloc] init];
        // While the scope gesture begin, the pan gesture of tableView should cancel.
        [_calendarSubViewController.tableView.panGestureRecognizer requireGestureRecognizerToFail:self.scopeGesture];
        [self addChildViewController:_calendarSubViewController];
        [self.view addSubview:_calendarSubViewController.view];
    }
    return _calendarSubViewController;
}
-(UIPanGestureRecognizer *)scopeGesture {
    if (!_scopeGesture) {
        UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self.calendar action:@selector(handleScopeGesture:)];
        panGesture.delegate = self;
        panGesture.minimumNumberOfTouches = 1;
        panGesture.maximumNumberOfTouches = 2;
        [self.view addGestureRecognizer:panGesture];
        _scopeGesture = panGesture;
    }
    return _scopeGesture;
}
- (FSCalendar *)calendar {
    if (!_calendar) {
        _calendar = [[FSCalendar alloc] initWithFrame:CGRectZero];
        [_calendar addObserver:self forKeyPath:@"scope" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:_KVOContext];
        _calendar.dataSource = self;
        _calendar.delegate = self;
        _calendar.backgroundColor = [UIColor colorWithRed:241.0/255.0 green:242.0/255.0 blue:243.0/255.0 alpha:1];
        _calendar.allowsMultipleSelection = YES;
        _calendar.swipeToChooseGesture.enabled = YES;
//        _calendar.floatingMode = YES;
//        _calendar = (FSCalendar *)[WOPCTLBaseHelper ctl_addShadowForView:_calendar];
//        _calendar = (FSCalendar *)[WOPCTLBaseHelper ctl_addRoundingCorners:_calendar];
        // 星期一
        _calendar.firstWeekday = 1;
        _calendar.calendarHeaderView.hidden = YES;
        _calendar.headerHeight = 0;
        _calendar.scrollDirection = FSCalendarScrollDirectionVertical;
        _calendar.rowHeight = 40;
        _calendar.weekdayHeight = 20;
        // 每月未显示日期
        _calendar.placeholderType = FSCalendarPlaceholderTypeFillSixRows;
        // 星期缩写
        _calendar.appearance.caseOptions = FSCalendarCaseOptionsWeekdayUsesUpperCase;
        // 显示月份
        _calendar.scope = FSCalendarScopeMonth;
        // 显示今日
//        [_calendar selectDate:[NSDate date] scrollToDate:YES];
        // For UITest
        _calendar.accessibilityIdentifier = @"calendar";
        // 星期数字颜色
        _calendar.appearance.weekdayTextColor = Calendar_Normal_TextColor;
        // 星期数字大小
        _calendar.appearance.weekdayFont = ctl_FontPingFangSC_Semibold(14);
        // 星期大写
        _calendar.appearance.headerDateFormat = @"MMMM";
        // 默认数字颜色
//        _calendar.appearance.subtitleWeekendColor = [UIColor lightGrayColor];
        _calendar.appearance.titleDefaultColor = [UIColor blackColor];
        _calendar.appearance.subtitlePlaceholderColor = [UIColor blackColor];
        _calendar.appearance.subtitleDefaultColor = [UIColor blackColor];
        _calendar.appearance.titlePlaceholderColor = [UIColor blackColor];
        // 选中数字颜色
        _calendar.appearance.titleSelectionColor = Calendar_Normal_TextColor;
        // 数字大小
        _calendar.appearance.titleFont = ctl_FontPingFangSC_Regular(18);
        // 选中背景颜色
        _calendar.appearance.selectionColor = Calendar_Selected_TextColor(0.2);
        // 点击今日背景颜色
        _calendar.appearance.todayColor = Calendar_Selected_TextColor(0.2);
        // 选中今日背景颜色
        _calendar.appearance.todaySelectionColor = Calendar_Selected_TextColor(0.2);
        // 星期六的颜色
        _calendar.calendarWeekdayView.weekdayLabels[6].textColor = [UIColor lightGrayColor];
        // 星期日的颜色
        _calendar.calendarWeekdayView.weekdayLabels[0].textColor = [UIColor lightGrayColor];
        
        [self.view addSubview:_calendar];
    }
    return _calendar;
}
- (NSDateFormatter *)dateFormatter {
    if (!_dateFormatter) {
        _dateFormatter = [[NSDateFormatter alloc] init];
        _dateFormatter.dateFormat = @"yyyy/MM/dd";
    }
    return _dateFormatter;
}
@end
