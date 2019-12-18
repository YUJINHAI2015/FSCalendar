//
//  WOPCalendarSubViewController.m
//  FSCalendarExample
//
//  Created by yujinhai on 2019/12/12.
//  Copyright © 2019 wenchaoios. All rights reserved.
//

#import "WOPCalendarSubViewController.h"
#import "Masonry.h"
#import "WOPCalendarPartTableViewCell.h"
#import "WOPCalendarAllTableViewCell.h"
#import "WOPCalendarModel.h"
@interface WOPCalendarSubViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic) NSMutableArray<WOPCalendarModel*> *events;

@end

//static inline NSString *fetchCellIdentifierWithCalendarType(WOPCalendarModel *model) {
//    if (model.type == WOPCalendarCellTypePart) {
//        return NSStringFromClass([WOPCalendarPartTableViewCell class]);
//    }
//    if (model.type == WOPCalendarCellTypeAll) {
//        return NSStringFromClass([WOPCalendarAllTableViewCell class]);
//    }
//    return NSStringFromClass([WOPCTLBaseTableViewCell class]);
//}
@implementation WOPCalendarSubViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.events = [NSMutableArray array];
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
        _tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[WOPCalendarAllTableViewCell class] forCellReuseIdentifier:NSStringFromClass([WOPCalendarAllTableViewCell class])];
        [_tableView registerClass:[WOPCalendarPartTableViewCell class] forCellReuseIdentifier:NSStringFromClass([WOPCalendarPartTableViewCell class])];
        [self.view addSubview:_tableView];

    }
    return _tableView;
}
- (void)didSelectedDates:(NSArray *)dates {
    [self p_request];
}
- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.tableView.frame = self.view.bounds;
}
// 请求数据
- (void)p_request {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        WOPCalendarModel *model1 = [[WOPCalendarModel alloc] init];
        model1.companyName = @"China Southern Airli";
        model1.airplaneName = @"CZ3102";
        model1.airplaneNumber = @"Nov.5";
        model1.departureAdsress = @"Guangzhou";
        model1.destinationAddress = @"Shanghai";
        model1.departureTime = @"10:30";
        model1.departureTime = @"10:30";
        model1.destinationTime = @"13:00";
        model1.departureAirport = @"Baiyun Airport T1";
        model1.destinationAirport = @"Pudong Airport T1";
        model1.passengers = @[@"Jimmy.Chen",@"Eason.Lia"];
        model1.type = WOPCalendarCellTypePart;
        
        WOPCalendarModel *model2 = [[WOPCalendarModel alloc] init];
        model2.companyName = @"2222";
        model2.type = WOPCalendarCellTypeAll;

        WOPCalendarModel *model3 = [[WOPCalendarModel alloc] init];
        model3.companyName = @"3333";
        model3.type = WOPCalendarCellTypeAll;

        WOPCalendarModel *model4 = [[WOPCalendarModel alloc] init];
        model4.companyName = @"4444";
        model4.type = WOPCalendarCellTypeAll;
        
//        [self.events removeAllObjects];
        [self.events addObjectsFromArray:@[model1,model2,model3,model4]];

        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    });
}
#pragma mark - <UITableViewDataSource>

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.events.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WOPCalendarModel *model = self.events[indexPath.row];
    
    if (model.type == WOPCalendarCellTypePart) {
        
        WOPCalendarPartTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([WOPCalendarPartTableViewCell class])];
        [cell configureWithCalendarModel:model];
        return cell;
    }
    WOPCalendarAllTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([WOPCalendarAllTableViewCell class])];
    return cell;

}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    WOPCalendarModel *model = self.events[indexPath.row];
//    fetchCellIdentifierWithCalendarType(model);
    if (model.type == WOPCalendarCellTypePart) {
        return 159;
    }
    return 226;
}
#pragma mark - <UITableViewDelegate>

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    if (indexPath.section == 0) {
//        FSCalendarScope selectedScope = indexPath.row == 0 ? FSCalendarScopeMonth : FSCalendarScopeWeek;
//        [self.calendar setScope:selectedScope animated:YES];
//    }
//
}
@end
