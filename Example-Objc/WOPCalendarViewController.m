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

@interface WOPCalendarViewController ()<UITableViewDataSource,UITableViewDelegate,FSCalendarDataSource,FSCalendarDelegate,UIGestureRecognizerDelegate>
{
    void * _KVOContext;
}

@property (strong, nonatomic) FSCalendar *calendar;
@property (strong, nonatomic) UIPanGestureRecognizer *scopeGesture;
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSDateFormatter *dateFormatter;

@property (strong, nonatomic) WOPCalendarHeaderView *calendarHeaderView;

@end

@implementation WOPCalendarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self p_initUI];
    self.dateFormatter = [[NSDateFormatter alloc] init];
    self.dateFormatter.dateFormat = @"yyyy/MM/dd";

}
- (void)loadView
{
    UIView *view = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.view = view;
}
- (void)p_initUI {
    [self.calendar mas_makeConstraints:^(MASConstraintMaker *make) {
        // 450 for iPad and 300 for iPhone
        CGFloat height = [[UIDevice currentDevice].model hasPrefix:@"iPad"] ? 450 : 316;
        make.height.mas_equalTo(height);
        make.top.mas_equalTo(self.view.mas_top).offset(5);
        make.leading.mas_equalTo(self.view.mas_leading).offset(15);
        make.trailing.mas_equalTo(self.view.mas_trailing).offset(-15);
    }];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.calendar.mas_bottom).offset(20);
        make.bottom.mas_equalTo(self.view.mas_bottom);
        make.leading.mas_equalTo(self.view.mas_leading);
        make.trailing.mas_equalTo(self.view.mas_trailing);
    }];
    
    [self.calendarHeaderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(66);
        make.top.mas_equalTo(self.calendar);
        make.leading.mas_equalTo(self.calendar);
        make.trailing.mas_equalTo(self.calendar);
    }];
    
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
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
        // While the scope gesture begin, the pan gesture of tableView should cancel.
        [_tableView.panGestureRecognizer requireGestureRecognizerToFail:self.scopeGesture];
        [self.view addSubview:_tableView];
    }
    return _tableView;
}
- (WOPCalendarHeaderView *)calendarHeaderView {
    if (!_calendarHeaderView) {
        WOPCalendarHeaderView *headerView = [[WOPCalendarHeaderView alloc] initWithFrame:CGRectZero];
        headerView.backgroundColor = [UIColor colorWithRed:54/255.0 green:106/255.0 blue:234/255.0 alpha:1];
        headerView.calendar = self.calendar;
        headerView.scrollEnabled = YES;
        _calendarHeaderView = headerView;
        // 隐藏默认的头部
        self.calendar.calendarHeaderView.collectionView.hidden = YES;
        self.calendar.calendarHeaderView.hidden = YES;
        self.calendar.headerHeight = 66;
        self.calendar.weekdayHeight = 44;
        self.calendar.layer.cornerRadius = 10;
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
        _calendar.backgroundColor = [UIColor whiteColor];
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
        _calendar.appearance.weekdayTextColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
        // 星期数字大小
        _calendar.appearance.weekdayFont = [UIFont fontWithName:@"PingFangSC-Semibold" size:14];
        // 星期大写
        _calendar.appearance.headerDateFormat = @"MMMM";
        // 默认数字颜色
        _calendar.appearance.titleDefaultColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
        // 选中数字颜色
        _calendar.appearance.titleSelectionColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
        // 数字大小
        _calendar.appearance.titleFont = [UIFont fontWithName:@"PingFangSC-Semibold" size:14];
        // 选中背景颜色
        _calendar.appearance.selectionColor = [UIColor colorWithRed:39/255.0 green:104/255.0 blue:243/255.0 alpha:0.2];
        // 点击今日背景颜色
        _calendar.appearance.todayColor = [UIColor colorWithRed:39/255.0 green:104/255.0 blue:243/255.0 alpha:0.2];
        // 选中今日背景颜色
        _calendar.appearance.todaySelectionColor = [UIColor colorWithRed:39/255.0 green:104/255.0 blue:243/255.0 alpha:0.2];
        // 星期六的颜色
        _calendar.calendarWeekdayView.weekdayLabels[6].textColor = [UIColor colorWithRed:39/255.0 green:104/255.0 blue:243/255.0 alpha:0.6];
        // 星期日的颜色
        _calendar.calendarWeekdayView.weekdayLabels[5].textColor = [UIColor colorWithRed:39/255.0 green:104/255.0 blue:243/255.0 alpha:0.6];

        [self.view addSubview:_calendar];
    }
    return _calendar;
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
    BOOL shouldBegin = self.tableView.contentOffset.y <= -self.tableView.contentInset.top;
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
        return [UIColor colorWithRed:39/255.0 green:104/255.0 blue:243/255.0 alpha:0.6];
    }
    return nil;
}

- (nullable UIColor *)calendar:(FSCalendar *)calendar appearance:(FSCalendarAppearance *)appearance titleSelectionColorForDate:(NSDate *)date {
    
    if ([[self.dateFormatter stringFromDate:date] isEqualToString:[self.dateFormatter stringFromDate:[NSDate date]]]) {
        return [UIColor colorWithRed:94/255.0 green:172/255.0 blue:12/255.0 alpha:1];
    } else {
        return [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
    }
}

#pragma mark - <UITableViewDataSource>

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.textLabel.text = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
    return cell;

}

#pragma mark - <UITableViewDelegate>

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        FSCalendarScope selectedScope = indexPath.row == 0 ? FSCalendarScopeMonth : FSCalendarScopeWeek;
        [self.calendar setScope:selectedScope animated:YES];
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20;
}

@end
