//
//  BAHomeCollectionView.m
//  zhuaWaWa
//
//  Created by linda on 2017/7/29.
//  Copyright © 2017年 boai. All rights reserved.


static NSString * const cellID = @"BAMoenyCell";

static NSString * const headerID = @"DemoVC10_ReusableView";
#import "BAHomeCollectionView.h"
#import "BAMoenyCell.h"
#import "DemoVC10_ReusableView.h"

#import "YSGoldModel.h"
@interface BAHomeCollectionView ()
<
UICollectionViewDataSource,
UICollectionViewDelegate,
UICollectionViewDelegateFlowLayout
>
@property (nonatomic, strong) UICollectionViewFlowLayout  *flowLayout;

@end

@implementation BAHomeCollectionView


- (instancetype)initWithFrame:(CGRect)frame withblock:(selectItemIndexBlock)block
{
    if (self = [super initWithFrame:frame])
    {
        self.indexBlock = block;
        [self setupSubViews];
        [self loadChargelist];
    }
    return self;
}
- (void)loadChargelist{
    NSDate *dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a = [dat timeIntervalSince1970] * 1000;
    NSString *timeString = [NSString stringWithFormat:@"%.0f",a];
    NSDictionary *parameters = @{@"auid":[YSAccountTool account].auid,
                                 @"M0":@"IMMC",
                                 @"M9":timeString};
    NSString *postUrl = [NSString stringWithFormat:@"%@%@",[YSAccountTool account].server,URL_Chargelist];
    
    [BANewsNetManager getStatusWithURL:postUrl withPostText:parameters success:^(id response) {
        NSNumber *code = response[@"code"];
        if ([code isEqualToNumber:@1]){
          id goldModelArray = [YSGoldModel BAMJParse:response[@"data"]];
            self.dataArray = (NSMutableArray *)goldModelArray;
            [self.collectionView reloadData];
        }
        
    } failure:^(NSError *error) {
        
    }];
}
- (void)setupSubViews
{
    self.collectionView.hidden = NO;
}
#pragma mark - ***** setter / getter
- (UICollectionView *)collectionView
{
    if (!_collectionView)
    {
        _flowLayout = [[UICollectionViewFlowLayout alloc] init];
        /*! 横向滑动请改这里：UICollectionViewScrollDirectionHorizontal */
        _flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:_flowLayout];
        
        _collectionView.backgroundColor = [UIColor clearColor];
        [self addSubview:_collectionView];
        
        /*! SD用法 */
        _collectionView.sd_layout.spaceToSuperView(UIEdgeInsetsMake(0, 0, 0, 0));
        
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        
        UINib *cellNib=[UINib nibWithNibName:@"BAMoenyCell" bundle:nil];
        [_collectionView registerNib:cellNib forCellWithReuseIdentifier:@"BAMoenyCell"];
        [_collectionView registerClass:[DemoVC10_ReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerID];
        /*! 默认是正常状态 */
        _cellState = DemoVC10_cellStateNormal;
    }
    return _collectionView;
}
- (void)setDataArray:(NSMutableArray *)dataArray
{
    _dataArray = dataArray;
    
}
#pragma mark - ***** UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    BAMoenyCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"BAMoenyCell" forIndexPath:indexPath];
    
    cell.model = self.dataArray[indexPath.row];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
        YSGoldModel *model = self.dataArray[indexPath.row];
        self.indexBlock(self.collectionView, indexPath, model);
}
#pragma mark - ***** UICollectionViewDelegateFlowLayout
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(5, 5, 5, 5);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((BA_SCREEN_WIDTH - 70)/3, (BA_SCREEN_WIDTH-30)/2);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(200, 20);
}



@end

