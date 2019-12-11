//
//  WOPCalendarViewController.m
//  FSCalendarExample
//
//  Created by yujinhai on 2019/12/11.
//  Copyright © 2019 wenchaoios. All rights reserved.
//

#import "WOPCalendarViewController.h"
#import "FSCalendar.h"
#import "Masonry.h"

@interface WOPCalendarViewController ()<UITableViewDataSource,UITableViewDelegate,FSCalendarDataSource,FSCalendarDelegate,UIGestureRecognizerDelegate>
{
    void * _KVOContext;
}

@property (strong, nonatomic) FSCalendar *calendar;
@property (strong, nonatomic) UIPanGestureRecognizer *scopeGesture;
@property (strong, nonatomic) UITableView *tableView;

@end

@implementation WOPCalendarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self p_initUI];

}
- (void)loadView
{
    UIView *view = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.view = view;
}
- (void)p_initUI {
    [self.calendar mas_makeConstraints:^(MASConstraintMaker *make) {
        CGFloat height = [[UIDevice currentDevice].model hasPrefix:@"iPad"] ? 450 : 300;
        make.height.mas_equalTo(height);
        make.top.mas_equalTo(self.view.mas_top);
        make.leading.mas_equalTo(self.view.mas_leading);
        make.trailing.mas_equalTo(self.view.mas_trailing);
    }];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.calendar.mas_bottom);
        make.bottom.mas_equalTo(self.view.mas_bottom);
        make.leading.mas_equalTo(self.view.mas_leading);
        make.trailing.mas_equalTo(self.view.mas_trailing);
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
- (FSCalendar *)calendar {
    if (!_calendar) {
        // 450 for iPad and 300 for iPhone
        _calendar = [[FSCalendar alloc] initWithFrame:CGRectZero];
        _calendar.dataSource = self;
        _calendar.delegate = self;
        _calendar.backgroundColor = [UIColor whiteColor];
        _calendar.appearance.headerMinimumDissolvedAlpha = 0;
        _calendar.appearance.caseOptions = FSCalendarCaseOptionsHeaderUsesUpperCase;
        [_calendar addObserver:self forKeyPath:@"scope" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:_KVOContext];
        _calendar.placeholderType = FSCalendarPlaceholderTypeNone;
        _calendar.scope = FSCalendarScopeWeek;
        
        [_calendar selectDate:[NSDate date] scrollToDate:YES];
        
        // For UITest
        _calendar.accessibilityIdentifier = @"calendar";

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
    //    NSLog(@"%@",(calendar.scope==FSCalendarScopeWeek?@"week":@"month"));
//    _calendarHeightConstraint.constant = CGRectGetHeight(bounds);
    [self.view layoutIfNeeded];
}

- (void)calendar:(FSCalendar *)calendar didSelectDate:(NSDate *)date atMonthPosition:(FSCalendarMonthPosition)monthPosition
{
//    NSLog(@"did select date %@",[self.dateFormatter stringFromDate:date]);
//
//    NSMutableArray *selectedDates = [NSMutableArray arrayWithCapacity:calendar.selectedDates.count];
//    [calendar.selectedDates enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
//        [selectedDates addObject:[self.dateFormatter stringFromDate:obj]];
//    }];
//    NSLog(@"selected dates is %@",selectedDates);
//    if (monthPosition == FSCalendarMonthPositionNext || monthPosition == FSCalendarMonthPositionPrevious) {
//        [calendar setCurrentPage:date animated:YES];
//    }
}

- (void)calendarCurrentPageDidChange:(FSCalendar *)calendar
{
//    NSLog(@"%s %@", __FUNCTION__, [self.dateFormatter stringFromDate:calendar.currentPage]);
}

#pragma mark - <UITableViewDataSource>

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger numbers[2] = {2,20};
    return numbers[section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    if (indexPath.section == 0) {
//        NSString *identifier = @[@"cell_month",@"cell_week"][indexPath.row];
//        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
//        return cell;
//    } else {
//        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
//        return cell;
//    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    return cell;

}

#pragma mark - <UITableViewDelegate>

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    if (indexPath.section == 0) {
//        FSCalendarScope selectedScope = indexPath.row == 0 ? FSCalendarScopeMonth : FSCalendarScopeWeek;
//        [self.calendar setScope:selectedScope animated:self.animationSwitch.on];
//    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20;
}

@end
