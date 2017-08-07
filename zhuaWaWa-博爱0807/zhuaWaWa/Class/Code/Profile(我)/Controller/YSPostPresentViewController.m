//
//  YSPostPresentViewController.m
//  BABaseProject
//
//  Created by linda on 2017/7/23.
//  Copyright © 2017年 博爱之家. All rights reserved.
//
#define BAProfile_CellID2 @"BAProfileCell"
#define BAPresent_MyCellID @"YSPostPresentCell"
#import "YSPostPresentViewController.h"
#import "YSPostPresentCell.h"
#import "BAMyAddressModel.h"
#import "shoppingDetailVC.h"
#import "YSPostAddressView.h"
@interface YSPostPresentViewController ()<UITableViewDataSource,UITableViewDelegate,YSPostPresentCellDelegate,UIAlertViewDelegate,YSPostAddressViewDelegate>
{
    int page;
}
@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property (nonatomic, strong) NSMutableArray *addressArray;

// 需要删除的model
@property (nonatomic, strong) BAMyAddressModel *model;

@property (nonatomic, strong) YSPostAddressView *postView;

@property (nonatomic, strong) BAAlert *tempView;
@end

@implementation YSPostPresentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self ba_base_setupUI];
}

- (void)ba_base_setupUI
{
    [self setupUI];
    [self setupLayout];
    
}
- (void)setupUI
{
    self.title                     = @"我 的 地 址";
    self.myTableView.delegate        = self;
    self.myTableView.dataSource      = self;
    self.myTableView.tableFooterView = [UIView new];
    
    [_myTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:BAProfile_CellID2];
}
- (void)setupLayout
{
    /*! 添加上下拉刷新 */
    [self setupRefreshView];
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
                                 @"M0":@"IMMC",
                                 @"M9":timeString};
    NSString *postUrl = [NSString stringWithFormat:@"%@%@",[YSAccountTool account].server,URL_MyAddressList];
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
         
        NSNumber *code = response[@"code"];
        if([code isEqualToNumber:@1])
        {
            NSMutableArray *addRessModelArray = [BAMyAddressModel BAMJParse:response[@"data"]];
            if (isHead){
                [weakSelf.addressArray removeAllObjects];
                weakSelf.addressArray = addRessModelArray;
            }else page++;
            
            weakSelf.addressArray = addRessModelArray;
            
            
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
- (IBAction)addNewAddress:(id)sender {
    BALog(@"点击了新增地址");
    shoppingDetailVC *detailVC = [[shoppingDetailVC alloc] init];
    detailVC.isEdit = NO;
    [self.navigationController pushViewController:detailVC animated:YES];
}

- (IBAction)postPresentClick:(id)sender {
    BALog(@"点击了邮寄礼物");
    YSPostAddressView *postView = [[YSPostAddressView alloc] init];
    postView.centerY = self.view.centerY;
    postView.delegate = self;
    for (NSInteger i = 0; i<[self.addressArray count]; i++) {
        BAMyAddressModel *itemViewModel = self.addressArray[i];
        if (itemViewModel.isSelected) {
            postView.addressModel = itemViewModel;
            
            [BAAlert ba_alertShowCustomView:postView configuration:^(BAAlert *tempView) {
                tempView.isTouchEdgeHide = YES;
                self.tempView = tempView;
            }];
        }
    }
}
#pragma mark YSPostAddressViewDelegate
- (void)postBtnClick:(YSPostAddressView *)postView withAddressModel:(BAMyAddressModel *)addressModel{
    // 点击了邮寄
    NSDate *dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a = [dat timeIntervalSince1970] * 1000;
    NSString *timeString = [NSString stringWithFormat:@"%.0f",a];
    NSDictionary *parameters = @{@"auid":[YSAccountTool account].auid,
                                 @"giftIdList":self.giftIdList,
                                 @"addressId":addressModel.addressId,
                                 @"M0":@"IMMC",
                                 @"M9":timeString};
    NSString *postUrl = [NSString stringWithFormat:@"%@%@",[YSAccountTool account].server,URL_AddOrder];
    BA_WEAKSELF;
    [BANewsNetManager getStatusWithURL:postUrl withPostText:parameters success:^(id response) {
        [self.tempView ba_alertHidden];
    } failure:^(NSError *error) {
        
    }];
}
#pragma mark YSPostPresentCellDelegate
- (void)editButtonClick:(YSPostPresentCell *)posetCell withModel:(BAMyAddressModel *)model{
    
    shoppingDetailVC *detailVC = [[shoppingDetailVC alloc] init];
    detailVC.model = model;
    detailVC.isEdit = YES;
    [self.navigationController pushViewController:detailVC animated:YES];
    
}

- (void)deleteButtonClick:(YSPostPresentCell *)posetCell withModel:(BAMyAddressModel *)model{
    self.model = model;
    UIAlertView* alert=[[UIAlertView alloc]initWithTitle:@""message:@"是否确认删除？" delegate:self cancelButtonTitle:@"确认"otherButtonTitles:@"取消",nil];
    [alert show];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{   BA_WEAKSELF;
    switch (buttonIndex) {
        case 0:
            [self deleteModel];
            break;
    }
}
- (void)deleteModel{
    NSDate *dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a = [dat timeIntervalSince1970] * 1000;
    NSString *timeString = [NSString stringWithFormat:@"%.0f",a];
    NSDictionary *parameters = @{@"auid":[YSAccountTool account].auid,
                                 @"addressId":self.model.addressId,
                                 @"M0":@"IMMC",
                                 @"M9":timeString};
    NSString *postUrl = [NSString stringWithFormat:@"%@%@",[YSAccountTool account].server,URL_DelAddress];
    BA_WEAKSELF;
    [BANewsNetManager getStatusWithURL:postUrl withPostText:parameters success:^(id response) {
        [GCDQueue executeInMainQueue:^{
            [weakSelf.addressArray removeObject:self.model];
            [weakSelf.myTableView reloadData];
        }];
    } failure:^(NSError *error) {
        
    }];
}
#pragma mark - UITableView Delegate / UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    BALog(@"%d",self.addressArray.count);
    return self.addressArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YSPostPresentCell *profileCell = [YSPostPresentCell ba_cellDequeueFromNibIndex:0 identify:BAPresent_MyCellID tableView:tableView];
    profileCell.model = self.addressArray[indexPath.row];
    profileCell.delegate = self;
    return profileCell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    //遍历viewModel的数组，如果点击的行数对应的viewModel相同，将isSelected变为Yes，反之为No
    for (NSInteger i = 0; i<[self.addressArray count]; i++) {
        BAMyAddressModel *itemViewModel = self.addressArray[i];
        if (i!=indexPath.row) {
            itemViewModel.isSelected = NO;
        }else if (i == indexPath.row){
            itemViewModel.isSelected = !itemViewModel.isSelected;
        }
    }
    
    [self.myTableView reloadData];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120;
}
- (NSMutableArray *)addressArray
{
    if (!_addressArray) {
        _addressArray = [NSMutableArray array];
    }
    return _addressArray;
}

@end
