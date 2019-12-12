//
//  WOPCalendarSubViewController.m
//  FSCalendarExample
//
//  Created by yujinhai on 2019/12/12.
//  Copyright © 2019 wenchaoios. All rights reserved.
//

#import "WOPCalendarSubViewController.h"
#import "Masonry.h"

@interface WOPCalendarSubViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic) NSArray *selectedDates;

@end

@implementation WOPCalendarSubViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
        [self.view addSubview:_tableView];

    }
    return _tableView;
}
- (void)didSelectedDates:(NSArray *)dates {
    self.selectedDates = dates;
    [self.tableView reloadData];
}
#pragma mark - <UITableViewDataSource>

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.selectedDates.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    NSString *text = self.selectedDates[indexPath.row];
    cell.textLabel.text =text;
    return cell;
    
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

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20;
}


@end