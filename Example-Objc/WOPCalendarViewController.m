//
//  WOPCalendarViewController.m
//  FSCalendarExample
//
//  Created by yujinhai on 2019/12/11.
//  Copyright © 2019 wenchaoios. All rights reserved.
//

#import "WOPCalendarViewController.h"
#import "FSCalendar.h"
#import "WOPCalendarHeaderView.h"
#import "Masonry.h"
#import "FSCalendarCollectionView.h"
#import "WOPCalendarSubViewController.h"
@interface WOPCalendarViewController ()<FSCalendarDataSource,FSCalendarDelegate,UIGestureRecognizerDelegate>
{
    void * _KVOContext;
}

@property (strong, nonatomic) FSCalendar *calendar;
@property (strong, nonatomic) NSDateFormatter *dateFormatter;
@property (strong, nonatomic) WOPCalendarHeaderView *calendarHeaderView;
@property (strong, nonatomic) WOPCalendarSubViewController *calendarSubViewController;

#define Calendar_Header_BackgroundColor [UIColor colorWithRed:54/255.0 green:106/255.0 blue:234/255.0 alpha:1];
#define Calendar_Normal_TextColor [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
#define Calendar_Selected_TextColor(x) [UIColor colorWithRed:39/255.0 green:104/255.0 blue:243/255.0 alpha:x];
#define Calendar_Today_TextColor [UIColor colorWithRed:94/255.0 green:172/255.0 blue:12/255.0 alpha:1];
#define Calendar_ContentView_BackgroundColor [UIColor whiteColor];

#define Calendar_Marge 20
#define Calendar_Header_Height 66
#define Calendar_Weekday_Height 44
#define Calendar_CornerRadius 8
@end

@implementation WOPCalendarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self p_initUI];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
}
- (void)p_initUI {
    [self.calendar mas_makeConstraints:^(MASConstraintMaker *make) {
        // 450 for iPad and 300 for iPhone
        CGFloat height = [[UIDevice currentDevice].model hasPrefix:@"iPad"] ? 450 : 316;
        make.height.mas_equalTo(height);
        make.top.mas_equalTo(self.view.mas_top).offset(0);
        make.leading.mas_equalTo(self.view.mas_leading).offset(Calendar_Marge);
        make.trailing.mas_equalTo(self.view.mas_trailing).offset(-Calendar_Marge);
    }];
    [self.calendarHeaderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(Calendar_Header_Height);
        make.top.mas_equalTo(self.calendar);
        make.leading.mas_equalTo(self.calendar);
        make.trailing.mas_equalTo(self.calendar);
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
    if (shouldBegin) {
        CGPoint velocity = [self.scopeGesture velocityInView:self.view];
        switch (self.calendar.scope) {
            case FSCalendarScopeMonth:
                return velocity.y < 0;
            case FSCalendarScopeWeek:
                return velocity.y > 0;
        }
    }
    return shouldBegin;
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
}

- (void)calendarCurrentPageDidChange:(FSCalendar *)calendar
{
    NSLog(@"%s %@", __FUNCTION__, [self.dateFormatter stringFromDate:calendar.currentPage]);
    [self.calendarHeaderView reloadData];
}
- (void)calendar:(FSCalendar *)calendar willDisplayCell:(FSCalendarCell *)cell forDate:(NSDate *)date atMonthPosition:(FSCalendarMonthPosition)monthPosition {

}
- (nullable UIColor *)calendar:(FSCalendar *)calendar appearance:(FSCalendarAppearance *)appearance titleDefaultColorForDate:(NSDate *)date {
    
    NSCalendar * myCalendar = [NSCalendar currentCalendar];
    myCalendar.timeZone = [NSTimeZone systemTimeZone];
    NSInteger week = [[myCalendar components:NSCalendarUnitWeekday fromDate:date] weekday];
    
    if (week == 1 || week == 7) {
        return Calendar_Selected_TextColor(0.6);
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
- (WOPCalendarHeaderView *)calendarHeaderView {
    if (!_calendarHeaderView) {
        WOPCalendarHeaderView *headerView = [[WOPCalendarHeaderView alloc] initWithFrame:CGRectZero];
        headerView.backgroundColor = Calendar_Header_BackgroundColor;
        headerView.calendar = self.calendar;
        headerView.scrollEnabled = YES;
        _calendarHeaderView = headerView;
        // 隐藏默认的头部
        self.calendar.calendarHeaderView.collectionView.hidden = YES;
        self.calendar.calendarHeaderView.hidden = YES;
        self.calendar.headerHeight = Calendar_Header_Height;
        self.calendar.weekdayHeight = Calendar_Weekday_Height;
        self.calendar.layer.cornerRadius = Calendar_CornerRadius;
        self.calendar.layer.masksToBounds = YES;
        
        [self.view bringSubviewToFront:self.calendarHeaderView];
        [self.view addSubview:self.calendarHeaderView];
    }
    return _calendarHeaderView;
}
- (FSCalendar *)calendar {
    if (!_calendar) {
        _calendar = [[FSCalendar alloc] initWithFrame:CGRectZero];
        [_calendar addObserver:self forKeyPath:@"scope" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:_KVOContext];
        _calendar.dataSource = self;
        _calendar.delegate = self;
        _calendar.backgroundColor = Calendar_ContentView_BackgroundColor;
        _calendar.allowsMultipleSelection = YES;
        _calendar.swipeToChooseGesture.enabled = YES;
        // 星期一
        _calendar.firstWeekday = 2;
        // 每月未显示日期
        _calendar.placeholderType = FSCalendarPlaceholderTypeFillHeadTail;
        // 星期缩写
        _calendar.appearance.caseOptions = FSCalendarCaseOptionsWeekdayUsesUpperCase;
        // 显示月份
        _calendar.scope = FSCalendarScopeMonth;
        // 显示今日
        [_calendar selectDate:[NSDate date] scrollToDate:YES];
        // For UITest
        _calendar.accessibilityIdentifier = @"calendar";
        // 星期数字颜色
        _calendar.appearance.weekdayTextColor = Calendar_Normal_TextColor;
        // 星期数字大小
        _calendar.appearance.weekdayFont = [UIFont fontWithName:@"PingFangSC-Semibold" size:14];
        // 星期大写
        _calendar.appearance.headerDateFormat = @"MMMM";
        // 默认数字颜色
        _calendar.appearance.titleDefaultColor = Calendar_Normal_TextColor;
        // 选中数字颜色
        _calendar.appearance.titleSelectionColor = Calendar_Normal_TextColor;
        // 数字大小
        _calendar.appearance.titleFont = [UIFont fontWithName:@"PingFangSC-Semibold" size:14];
        // 选中背景颜色
        _calendar.appearance.selectionColor = Calendar_Selected_TextColor(0.2);
        // 点击今日背景颜色
        _calendar.appearance.todayColor = Calendar_Selected_TextColor(0.2);
        // 选中今日背景颜色
        _calendar.appearance.todaySelectionColor = Calendar_Selected_TextColor(0.2);
        // 星期六的颜色
        _calendar.calendarWeekdayView.weekdayLabels[6].textColor = Calendar_Selected_TextColor(0.6);
        // 星期日的颜色
        _calendar.calendarWeekdayView.weekdayLabels[5].textColor = Calendar_Selected_TextColor(0.6);
        
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
