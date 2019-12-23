//
//  WOPCTLHomeSubViewController.m
//  FSCalendarExample
//
//  Created by yujinhai on 2019/12/23.
//  Copyright © 2019 wenchaoios. All rights reserved.
//

#import "WOPCTLHomeSubViewController.h"
#import "WOPCalendarPartTableViewCell.h"
#import "WOPCalendarAllTableViewCell.h"

@interface WOPCTLHomeSubViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation WOPCTLHomeSubViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
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
- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.tableView.frame = self.view.bounds;
}
#pragma mark - <UITableViewDataSource>

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 30;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    WOPCalendarModel *model = self.events[indexPath.row];
//    
//    if (model.type == WOPCalendarCellTypePart) {
//
//        WOPCalendarPartTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([WOPCalendarPartTableViewCell class])];
//        [cell configureWithCalendarModel:model];
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        return cell;
//    }
    WOPCalendarAllTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([WOPCalendarAllTableViewCell class])];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    [cell configureWithCalendarModel:model];
    return cell;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 246;
}

@end
