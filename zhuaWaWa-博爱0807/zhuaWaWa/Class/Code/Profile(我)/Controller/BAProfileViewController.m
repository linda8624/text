//
//  BAProfileViewController.m
//  BABaseProject
//
//  Created by 博爱 on 16/5/3.
//  Copyright © 2016年 博爱之家. All rights reserved.
//

#import "BAProfileViewController.h"
#import "BAProfileHeadCell.h"
#import "BALoginViewController.h"
#import "BAProfileMyCell.h"
#import "YSPresentViewController.h"
#import "YSMyBoxTableViewController.h"
#define BAProfile_Title   @"title"
#define BAProfile_Image   @"image"
#define BAProfile_DetailImage @"detail"
#define BAProfile_DetailViewISShow @"isShow"

#define BAProfile_CellID  @"BAProfileHeadCell"
#define BAProfile_CellID2 @"BAProfileCell"
#define BAProfile_MyCellID  @"BAProfileMyCell"


@interface BAProfileViewController ()
<
    UITableViewDelegate,
    UITableViewDataSource
>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) BALoginViewController *loginVC;
@property (nonatomic, strong) NSArray *dataArray;

@end

@implementation BAProfileViewController

#pragma mark - life cycle
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];


}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    

    [self setupUI];
}

#pragma mark - 私有方法
- (void)setupUI
{
    self.title                     = @"我 的 账 户";
    self.tableView.delegate        = self;
    self.tableView.dataSource      = self;
    self.tableView.tableFooterView = [UIView new];
    
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:BAProfile_CellID2];

    _loginVC = [BALoginViewController new];
    
    self.tableView.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"accoutBackImage.png"]];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    [self addNoti];
}
#pragma mark - 通知
- (void)addNoti
{
    [BA_NotiCenter addObserver:self selector:@selector(loginFinishAction:) name:BANotioKey_LoginFinish object:nil];
}

#pragma mark - UITableView Delegate / UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (0 == indexPath.row)
    {
        BAProfileHeadCell *headCell = [BAProfileHeadCell ba_cellDequeueFromNibIndex:indexPath.section identify:BAProfile_CellID tableView:tableView];
        headCell.backgroundColor = [UIColor purpleColor];
        headCell.model =  [YSAccountTool account];
        return headCell;
    }
    else
    {
        BAProfileMyCell *profileCell = [BAProfileMyCell ba_cellDequeueFromNibIndex:0 identify:BAProfile_MyCellID tableView:tableView];
        profileCell.dict = self.dataArray[indexPath.row];
        profileCell.backgroundColor = [UIColor clearColor];
        return profileCell;
    }
    return [UITableViewCell new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return (0 == indexPath.row) ? 100:80;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if(indexPath.row==1){
        
        YSPresentViewController *present = [[YSPresentViewController alloc] init];
        [self.navigationController pushViewController:present animated:YES];
    }else if(indexPath.row==2){
        YSMyBoxTableViewController *myBox = [[YSMyBoxTableViewController alloc] init];
        [self.navigationController pushViewController:myBox animated:YES];
        
    }
    
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (1 == indexPath.row)
    {
        if ([cell respondsToSelector:@selector(setSeparatorInset:)])
        {
            [cell setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, 0)];
        }
        if ([cell respondsToSelector:@selector(setLayoutMargins:)])
        {
            [cell setLayoutMargins:UIEdgeInsetsMake(0, 0, 0, 0)];
        }
    }
}

#pragma mark - Custom Delegate


#pragma mark - event response
- (void)loginFinishAction:(NSNotification *)noti
{
    NSDictionary *dict = noti.userInfo;
    if ([dict[@"isLogin"] isEqualToString:@"1"])
    {
        [self.tableView reloadData];
    }
}

#pragma mark - getters and setters
- (NSArray *)dataArray
{
    if (!_dataArray)
    {
        _dataArray = @[
                       @{
                           BAProfile_Title : @"我的奖品",
                           BAProfile_Image : @"gift.png",
                           BAProfile_DetailImage : @"postman.png",
                           BAProfile_DetailViewISShow : @"0"
                           },
                       @{
                           BAProfile_Title : @"我的奖品",
                           BAProfile_Image : @"gift.png",
                           BAProfile_DetailImage : @"postman.png",
                           BAProfile_DetailViewISShow : @"1"
                           },
                       @{
                           BAProfile_Title : @"每日宝箱",
                           BAProfile_Image : @"goldBox.png",
                           BAProfile_DetailImage:@"postman.png",
                           BAProfile_DetailViewISShow : @"0"
                           },
                       @{
                           BAProfile_Title : @"更多详情",
                           BAProfile_Image : @"moreDetailIcon.png",
                           BAProfile_DetailImage:@"postman.png",
                           BAProfile_DetailViewISShow : @"0"
                           },
                       ];
        
    }
    return _dataArray;
}

#pragma mark - dealloc
- (void)dealloc
{
//    [BA_NotiCenter removeObserver:self];
    [BA_NotiCenter removeObserver:self name:BANotioKey_LoginFinish object:nil];

}

@end
