//
//  YSPresentViewController.m
//  BABaseProject
//
//  Created by linda on 2017/7/23.
//  Copyright © 2017年 博爱之家. All rights reserved.
//
#define BAProfile_CellID2 @"BAProfileCell"
#define BAPresent_MyCellID @"YSPresentTableViewCell"
#import "YSPresentViewController.h"
#import "YSPresentTableViewCell.h"
#import "YSPostPresentViewController.h"
#import "BANewsNetManager.h"
#import "YSMyGiftModel.h"
#import "YSHistoryView.h"
@interface YSPresentViewController ()<UITableViewDelegate,UITableViewDataSource,YSPresentTableViewCellDelegate>
{
    int page;
}
@property (weak, nonatomic) IBOutlet UITableView *myTableView;

@property (weak, nonatomic) IBOutlet UIView *myBottemView;

// 当前礼物的个数
@property (weak, nonatomic) IBOutlet UILabel *currentGiftN;

@property (nonatomic, strong) NSMutableArray *dataList;

@property (nonatomic, strong) NSMutableArray *giftIDlist;
@property (nonatomic, strong) YSHistoryView *historyView;
@end

@implementation YSPresentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setupUI];
}
// 点击了查看历史奖品
- (IBAction)showHistoryGift:(UIButton *)sender{
    self.historyView.y = BA_SCREEN_HEIGHT-240;
    self.historyView.hidden = NO;
}

// 点击了我要邮寄
- (IBAction)postButtonClick:(id)sender {
    YSPostPresentViewController *postVC = [[YSPostPresentViewController alloc] init];
    NSString *giftIdStr = [self.giftIDlist componentsJoinedByString:@"`"];
    postVC.giftIdList = giftIdStr;
    [self.navigationController pushViewController:postVC animated:YES];
}
- (void)setupUI
{
    self.title                     = @"我 的 奖 品";
    self.myTableView.delegate        = self;
    self.myTableView.dataSource      = self;
    self.myTableView.tableFooterView = [UIView new];
    
    [_myTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:BAProfile_CellID2];
    
    
    /*! 添加上下拉刷新 */
    [self setupRefreshView];
    [self addSubViews];
}
- (void)addSubViews{
    
    YSHistoryView *historyView = [[YSHistoryView alloc] initWithFrame:CGRectMake(0, BA_SCREEN_HEIGHT, BA_SCREEN_WIDTH, 200)];
    self.historyView = historyView;
    [self.view addSubview:historyView];
}
#pragma mark - ***** 添加上下拉刷新
- (void)setupRefreshView
{
    BA_WEAKSELF;
    // 设置回调（一旦进入刷新状态就会调用这个refreshingBlock）
        [self.myTableView ba_addHeaderRefresh:^{
            [weakSelf loadNewData];
        }];
    // 马上进入刷新状态
    [self.myTableView.mj_header beginRefreshing];
    
    // 设置回调（一旦进入刷新状态就会调用这个refreshingBlock）
    [self.myTableView ba_addFooterRefresh:^{
        [weakSelf loadMoreData];
    }];
    
    self.myTableView.mj_footer.automaticallyHidden = true;
    
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
                                 @"giftStatus":@"303001",
                                 @"M0":@"IMMC",
                                 @"M9":timeString};
    NSString *postUrl = [NSString stringWithFormat:@"%@%@",[YSAccountTool account].server,URL_MyGiftList];
    BA_WEAKSELF;
    [BANewsNetManager getStatusWithURL:postUrl withPostText:parameters success:^(id response) {
        
        if (isHead)
        {
            [weakSelf.myTableView.mj_header endRefreshing];
        }
        else
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf.myTableView.mj_footer endRefreshing];
            });
        }
        
        if(response)
        {
            id modelArray = [YSMyGiftModel BAMJParse:response[@"data"]];
            if (isHead){
                [weakSelf.dataList removeAllObjects];
            }else page++;
            
            NSArray *array = (NSArray *)modelArray;
            NSMutableArray *tempArray = @[].mutableCopy;
            [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [tempArray addObject:obj];
                weakSelf.dataList = tempArray;
                YSMyGiftModel *model = (YSMyGiftModel *)obj;
                [weakSelf.giftIDlist addObject:model.giftId];
            }];
            
            [GCDQueue executeInMainQueue:^{
                weakSelf.myTableView.contentOffset = CGPointZero;
                [weakSelf.myTableView reloadData];
            }];
        }
        else
        {
            if (page > 1)
            {
                [(MJRefreshAutoGifFooter *)weakSelf.myTableView.mj_footer setTitle:@"空空如也" forState:MJRefreshStateIdle];
            }
            else
            {
                [(MJRefreshAutoGifFooter *)weakSelf.myTableView.mj_footer setTitle:@"" forState:MJRefreshStateIdle];
            }
        }
    } failure:^(NSError *error) {
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)shareBtnClick:(YSMyGiftModel *)giftModel
{
    BALog(@"点击了分享按钮");
}
#pragma mark - UITableView Delegate / UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    self.currentGiftN.text = [NSString stringWithFormat:@"当前可邮寄%lu个奖品",(unsigned long)self.dataList.count];
    return self.dataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YSPresentTableViewCell *profileCell = [YSPresentTableViewCell ba_cellDequeueFromNibIndex:0 identify:BAPresent_MyCellID tableView:tableView];
    profileCell.giftModel = self.dataList[indexPath.row];
    profileCell.delegate = self;
    return profileCell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 110;
}
- (NSMutableArray *)dataList
{
    if (!_dataList) {
        _dataList = @[].mutableCopy;
    }
    return _dataList;
}

- (NSMutableArray *)giftIDlist
{
    if (!_giftIDlist) {
        _giftIDlist = [NSMutableArray array];
    }
    return _giftIDlist;
}

@end
