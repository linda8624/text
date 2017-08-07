//
//  YSHistoryView.m
//  zhuaWaWa
//
//  Created by linda on 2017/8/3.
//  Copyright © 2017年 boai. All rights reserved.
//

#define BAHisetory_MyCellID @"YHistoryTableViewCell"
#import "YSHistoryView.h"
#import "YHistoryTableViewCell.h"
@interface YSHistoryView()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *historyTableView;
@end
@implementation YSHistoryView
- (void)layoutSubviews{
    [super layoutSubviews];
    [self loadHistroyGift];
    [self addSubview:self.historyTableView];
    [self addHeaderView];
}
- (void)addHeaderView{
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, BA_SCREEN_WIDTH, 40)];
    [btn addTarget:self action:@selector(closeTable) forControlEvents:UIControlEventTouchUpInside];
    [btn setBackgroundImage:[UIImage imageNamed:@"showButton.png"] forState:UIControlStateNormal];
    [btn setTitle:@"历史奖品" forState:UIControlStateNormal];
    [self addSubview:btn];
}
- (void)closeTable{
    self.hidden = YES;
}
- (void)loadHistroyGift{
    NSDate *dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a = [dat timeIntervalSince1970] * 1000;
    NSString *timeString = [NSString stringWithFormat:@"%.0f",a];
    NSDictionary *parameters = @{@"auid":[YSAccountTool account].auid,
                                 @"giftStatus":@"303002",
                                 @"M0":@"IMMC",
                                 @"M9":timeString};
    NSString *postUrl = [NSString stringWithFormat:@"%@%@",[YSAccountTool account].server,URL_MyGiftList];
    BA_WEAKSELF;
    [BANewsNetManager getStatusWithURL:postUrl withPostText:parameters success:^(id response) {
        
        if(response)
        {
            id modelArray = [YSMyGiftModel BAMJParse:response[@"data"]];
            NSArray *array = (NSArray *)modelArray;
            NSMutableArray *tempArray = @[].mutableCopy;
            [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [tempArray addObject:obj];
                weakSelf.giftArray = tempArray;
                [weakSelf.historyTableView reloadData];
            }];
            
        }
    } failure:^(NSError *error) {
        
    }];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.giftArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YHistoryTableViewCell *historyCell = [YHistoryTableViewCell ba_cellDequeueFromNibIndex:0 identify:BAHisetory_MyCellID tableView:tableView];
    historyCell.giftModel = self.giftArray[indexPath.row];
    historyCell.selectionStyle = UITableViewCellSelectionStyleNone;
    historyCell.backgroundColor = [UIColor clearColor];
    return historyCell;
}
- (UITableView *)historyTableView
{
    if (!_historyTableView) {
        _historyTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 40, self.width, self.height-40) style:UITableViewStylePlain];
        _historyTableView.delegate = self;
        _historyTableView.dataSource = self;
        _historyTableView.tableFooterView = [[UIView alloc] init];
        _historyTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
    }
    return _historyTableView;
}

@end
