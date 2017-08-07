//
//  DemoVC10_CollectionView.m
//  BABaseProject
//
//  Created by 博爱 on 16/5/27.
//  Copyright © 2016年 博爱之家. All rights reserved.
//

#import "DemoVC10_CollectionView.h"
#import "DemoVC10Cell.h"
#import "DemoVC10_ReusableView.h"
static NSString * const cellID = @"DemoVC10Cell";
static NSString * const headerID = @"DemoVC10_ReusableView";

@interface DemoVC10_CollectionView ()
<
    UICollectionViewDataSource,
    UICollectionViewDelegate,
    UICollectionViewDelegateFlowLayout
>
@property (nonatomic, strong) UICollectionViewFlowLayout  *flowLayout;

@end

@implementation DemoVC10_CollectionView


- (instancetype)initWithFrame:(CGRect)frame withblock:(selectItemIndexBlock)block
{
    if (self = [super initWithFrame:frame])
    {
        self.indexBlock = block;
        [self setupSubViews];
    }
    return self;
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
        
        _collectionView.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cellBakcImage.png"]];
        [self addSubview:_collectionView];
        
        /*! SD用法 */
        _collectionView.sd_layout.spaceToSuperView(UIEdgeInsetsMake(0, 0, 0, 0));
        
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        
        UINib *cellNib=[UINib nibWithNibName:@"DemoVC10Cell" bundle:nil];
        [_collectionView registerNib:cellNib forCellWithReuseIdentifier:@"DemoVC10Cell"];
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
    DemoVC10Cell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"DemoVC10Cell" forIndexPath:indexPath];
    
    cell.model = self.dataArray[indexPath.row];
    cell.backgroundColor = [UIColor clearColor];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    YSWaWaModel *model = self.dataArray[indexPath.row];
    self.indexBlock(self.collectionView, indexPath, model);
}

#pragma mark - ***** UICollectionViewDelegateFlowLayout
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10, 5, 10, 5);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((BA_SCREEN_WIDTH - 20)/2, 230);
}

@end
