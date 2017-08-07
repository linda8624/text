//
//  YSMyBoxTableViewController.m
//  BABaseProject
//
//  Created by linda on 2017/7/27.
//  Copyright © 2017年 博爱之家. All rights reserved.
//

#import "YSMyBoxTableViewController.h"
#import "YSBoxTableViewCell.h"
#import "BAMyGBox.h"
#import "YSOpenBoxView.h"
#import "YSBoxCountdownView.h"
#import "YSOpneGoldView.h"
#import "YSShareBoxView.h"

#define YSBox_MyCellID @"YSBoxTableViewCell"
@interface YSMyBoxTableViewController ()
{
    int page;
}
@property (nonatomic, strong) NSMutableArray *dataList;

@property (nonatomic, strong) YSOpneGoldView *gold;

@property (nonatomic, strong) YSOpenBoxView *boxView;

@property (nonatomic, strong) YSBoxCountdownView *boxCountDown;

@property (nonatomic, strong) YSShareBoxView *shareBox;
@end

@implementation YSMyBoxTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor purpleColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self setupRefreshView];
    [self addRightBarBtn];
    [self addShowMsgView];
}
// 创建右边的按钮
- (void)addRightBarBtn{
    NSString *str = @"分享";
    UIBarButtonItem *buttonItem = [[UIBarButtonItem alloc] initWithTitle:str style:UIBarButtonItemStylePlain target:self action:@selector(shareWaWaBtn)];
    self.navigationItem.rightBarButtonItem = buttonItem;
}
- (void)shareWaWaBtn{
    // 点击了分享到朋友圈
}
#pragma mark - ***** 添加上下拉刷新
- (void)setupRefreshView
{
    BA_WEAKSELF;
    // 设置回调（一旦进入刷新状态就会调用这个refreshingBlock）
    [self.tableView ba_addHeaderRefresh:^{
        [weakSelf loadNewData];
    }];
    // 马上进入刷新状态
    [self.tableView.mj_header beginRefreshing];
    
    // 设置回调（一旦进入刷新状态就会调用这个refreshingBlock）
    [self.tableView ba_addFooterRefresh:^{
        [weakSelf loadMoreData];
    }];
    
    self.tableView.mj_footer.automaticallyHidden = true;
    
}
- (void)loadNewData
{
    [self getDataWithHead:YES];
}

- (void)loadMoreData
{
    [self getDataWithHead:NO];
}

#pragma mark - *****  接口数据
- (void)getDataWithHead:(BOOL)isHead
{
    if (isHead)
    {
        page = 1;
    }
    else
    {
        if (page < 2)
        {
            page = 2;
        }
    }
    //URL_roomList
    NSDate *dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a = [dat timeIntervalSince1970] * 1000;
    NSString *timeString = [NSString stringWithFormat:@"%.0f",a];
    NSDictionary *parameters = @{@"auid":[YSAccountTool account].auid,
                                 @"M0":@"IMMC",
                                 @"M9":timeString};
    NSString *postUrl = [NSString stringWithFormat:@"%@%@",[YSAccountTool account].server,URL_MyBoxList];
    BA_WEAKSELF;
    [BANewsNetManager getStatusWithURL:postUrl withPostText:parameters success:^(id response) {
        
        if (isHead)
        {
            [weakSelf.tableView.mj_header endRefreshing];
        }
        else
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf.tableView.mj_footer endRefreshing];
            });
        }
        
        if(response)
        {
            id modelArray = [BAMyGBox BAMJParse:response[@"data"]];
            if (isHead){
                [weakSelf.dataList removeAllObjects];
            }else page++;
            
            NSArray *array = (NSArray *)modelArray;
            NSMutableArray *tempArray = @[].mutableCopy;
            [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [tempArray addObject:obj];
                weakSelf.dataList = tempArray;
            }];
            
            [GCDQueue executeInMainQueue:^{
                weakSelf.tableView.contentOffset = CGPointZero;
                [weakSelf.tableView reloadData];
            }];
        }
        else
        {
            if (page > 1)
            {
                [(MJRefreshAutoGifFooter *)weakSelf.tableView.mj_footer setTitle:@"空空如也" forState:MJRefreshStateIdle];
            }
            else
            {
                [(MJRefreshAutoGifFooter *)weakSelf.tableView.mj_footer setTitle:@"" forState:MJRefreshStateIdle];
            }
        }
    } failure:^(NSError *error) {
        BALog(@"%@",error);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YSBoxTableViewCell *boxCell = [YSBoxTableViewCell ba_cellDequeueFromNibIndex:0 identify:YSBox_MyCellID tableView:tableView];
    boxCell.backgroundColor = [UIColor clearColor];
    boxCell.selectionStyle = UITableViewCellSelectionStyleNone;
    boxCell.myGBox = self.dataList[indexPath.row];
    return boxCell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 110;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    BAMyGBox *myBox = self.dataList[indexPath.row];
    NSNumber *action =  myBox.ctype;
    UIView *showView = nil;
    if ([action isEqualToNumber:@234001]) {
        showView = self.gold;
    }else if ([action isEqualToNumber:@234002]){
        showView = self.shareBox;
    }else if([action isEqualToNumber:@234003]){
        showView = self.boxView;
    }else if ([action isEqualToNumber:@234005]){
        showView = self.boxCountDown;
    }
    [BAAlert ba_alertShowCustomView:showView configuration:^(BAAlert *tempView) {
    }];
}
- (void)addShowMsgView{
    
    YSOpneGoldView *gold = [[YSOpneGoldView alloc] init];
    gold.frame = CGRectMake(0, 0, 231, 276);
    gold.centerY = self.view.centerY;
    gold.centerX = self.view.centerX;
    self.gold = gold;
    
    YSBoxCountdownView *boxCountDown = [[YSBoxCountdownView alloc] init];
    boxCountDown.frame = CGRectMake(0, 0, 231, 276);
    self.boxCountDown = boxCountDown;
    boxCountDown.centerY = self.view.centerY;
    boxCountDown.centerX = self.view.centerX;
    
    YSOpenBoxView *openBox = [[YSOpenBoxView alloc] init];
    openBox.frame = CGRectMake(0, 0, 231, 276);
    self.boxView = openBox;
    openBox.centerY = self.view.centerY;
    openBox.centerX = self.view.centerX;
    
    YSShareBoxView *shareBox = [[YSShareBoxView alloc] init];
    shareBox.frame = CGRectMake(0, 0, 231, 276);
    self.shareBox = shareBox;
    shareBox.centerY = self.view.centerY;
    shareBox.centerX = self.view.centerX;

    
    
}
- (NSMutableArray *)dataList
{
    if (!_dataList) {
        _dataList = [NSMutableArray array];
    }
    return _dataList;
}

@end
