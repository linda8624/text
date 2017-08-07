//
//  BAHomeCollectionView.h
//  zhuaWaWa
//
//  Created by linda on 2017/7/29.
//  Copyright © 2017年 boai. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^selectItemIndexBlock)(UICollectionView *collection, NSIndexPath *indexPath,  id model);

typedef NS_ENUM(NSUInteger, DemoVC10_cellState) {
    /*! 右上角编辑按钮的两种状态 */
    /*! 正常的状态，按钮显示“编辑” */
    DemoVC10_cellStateNormal,
    /*! 正在删除时候的状态，按钮显示“完成” */
    DemoVC10_cellStateDelete
};

@interface BAHomeCollectionView : UIView

@property (nonatomic, strong) UICollectionView      *collectionView;
@property (nonatomic, copy  ) selectItemIndexBlock   indexBlock;
@property (nonatomic, assign) DemoVC10_cellState     cellState;
@property (nonatomic, strong) NSMutableArray  *dataArray;


- (instancetype)initWithFrame:(CGRect)frame withblock:(selectItemIndexBlock)block;
@end
