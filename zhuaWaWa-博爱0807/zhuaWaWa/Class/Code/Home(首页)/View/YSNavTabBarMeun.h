//
//  YSNavTabBarMeun.h
//  丰食买家
//
//  Created by linda on 14-12-25.
//  Copyright (c) 2014年 yskj. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YSNavTabBarMeun,YSDishesDetailTypeModel;
@protocol YSNavTabBarMeunDelegate <NSObject>
@optional
//- (void)itemPressed:(YSNavTabBarMeun *)nav withGoodsMoedl:(NSArray *)goodsModel withIndex:(NSInteger)index;

- (void)navTabBar:(YSNavTabBarMeun *)tabBar withGoodsMoedl:(NSString *)goodsType withIndex:(NSInteger)index;

@end
@interface YSNavTabBarMeun : UIView

/**保存所有按钮的数组*/
@property (nonatomic, strong) NSArray *buttonArray;

@property (nonatomic, strong)   NSArray *itemTitles;  // all items' title
@property (nonatomic, assign)   NSInteger   currentItemIndex;    // current selected item's index
@property (nonatomic, assign) id<YSNavTabBarMeunDelegate> navTabBarDelegate;

@property (nonatomic, strong) YSDishesDetailTypeModel *dataModel;
// 保存typeID
@property (nonatomic, strong) NSArray *typeIDArray;
/**
 提供一个创建按钮的方法
 */
- (void)createNewButton;
- (void)itemPressClick:(NSInteger)btnTag;
@end
