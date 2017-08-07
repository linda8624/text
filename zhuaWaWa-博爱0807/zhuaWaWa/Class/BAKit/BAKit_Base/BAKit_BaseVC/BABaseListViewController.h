//
//  BABaseListViewController.h
//  BAKit
//
//  Created by boai on 2017/7/3.
//  Copyright © 2017年 boai. All rights reserved.
//

#import "BABaseViewController.h"

@class BABaseListViewSectionModel, BABaseListViewCellModel;

typedef void (^BABaseListViewController_didSelectBlock)(UITableView *tableView, NSIndexPath *indexPath, BABaseListViewSectionModel *model);
typedef void (^BABaseListViewControllerCellConfig_block)(UITableView *tableView, NSIndexPath *indexPath, UITableViewCell *cell);

@interface BABaseListViewController : BABaseViewController

@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) NSArray *dataArray;

@property(nonatomic, strong) UIImage *ba_tableViewBackgroundImageView;

@property(nonatomic, copy) BABaseListViewController_didSelectBlock ba_tabelViewDidSelectBlock;
@property(nonatomic, copy) BABaseListViewControllerCellConfig_block ba_tabelViewCellConfig_block;

@end

@interface BABaseListViewSectionModel : NSObject

@property(nonatomic, copy) NSString *sectionTitle;
@property(nonatomic, strong) NSArray <BABaseListViewCellModel *>*sectionDataArray;

@end

@interface BABaseListViewCellModel : NSObject

@property(nonatomic, copy) NSString *title;
@property(nonatomic, copy) NSString *imageName;
@property(nonatomic, copy) NSString *detailString;

@end
