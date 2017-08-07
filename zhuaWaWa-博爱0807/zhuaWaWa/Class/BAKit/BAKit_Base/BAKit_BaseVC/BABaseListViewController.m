//
//  BABaseListViewController.m
//  BAKit
//
//  Created by boai on 2017/7/3.
//  Copyright © 2017年 boai. All rights reserved.
//

#import "BABaseListViewController.h"

static NSString * const kCellID = @"BABaseListViewControllerCell";

@interface BABaseListViewController ()<UITableViewDelegate, UITableViewDataSource>


@end

@implementation BABaseListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)ba_base_setupUI
{
    self.view.backgroundColor = BAKit_Color_White;
    
}

#pragma mark - UITableViewDelegate, UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (self.dataArray)
    {
        return self.dataArray.count;
    }
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    BABaseListViewSectionModel *sectionModel = self.dataArray[section];
    if (sectionModel)
    {
        return sectionModel.sectionDataArray.count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellID];
    if (!self.tableView.ba_tableViewCellStyle)
    {
        self.tableView.ba_tableViewCellStyle = UITableViewCellStyleValue1;
    }
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:self.tableView.ba_tableViewCellStyle reuseIdentifier:kCellID];
    }
    cell.backgroundColor = BAKit_Color_Clear;

    if (self.ba_tabelViewCellConfig_block)
    {
        self.ba_tabelViewCellConfig_block(tableView, indexPath, cell);
    }
    BABaseListViewSectionModel *sectionModel = self.dataArray[indexPath.section];
    BABaseListViewCellModel *model = sectionModel.sectionDataArray[indexPath.row];
    NSString *msg = [@(indexPath.row + 1).stringValue stringByAppendingString:@"、"];
    
    cell.textLabel.text = [msg stringByAppendingString:model.title];
    cell.textLabel.numberOfLines = 0;
    
    if (model.detailString)
    {
        cell.detailTextLabel.text = model.detailString;
    }
    if (model.imageName)
    {
        cell.imageView.image = BAKit_ImageName(model.imageName);
        CGSize imageSize = CGSizeMake(30, 30);
        [UIImage ba_imageToChangeCellNormalImageViewSizeWithCell:cell image:cell.imageView.image imageSize:imageSize];

    }

    cell.imageView.backgroundColor = BAKit_Color_Clear;
    cell.textLabel.backgroundColor = BAKit_Color_Yellow;
    cell.detailTextLabel.backgroundColor = BAKit_Color_Green;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    BABaseListViewSectionModel *model = self.dataArray[indexPath.section];

    if (self.ba_tabelViewDidSelectBlock)
    {
        self.ba_tabelViewDidSelectBlock(tableView, indexPath, model);
    }
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(nonnull UITableViewCell *)cell forRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    // FB 动画
//    POPSpringAnimation *scaleAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPViewScaleXY];
//    scaleAnimation.toValue             = [NSValue valueWithCGPoint:CGPointMake(1, 1)];
//    scaleAnimation.velocity            = [NSValue valueWithCGPoint:CGPointMake(2, 2)];
//    scaleAnimation.springBounciness    = 20.f;
//    [cell pop_addAnimation:scaleAnimation forKey:@"scaleAnimation"];
    
    // 博爱专属动画 1
    cell.contentView.transform =  CGAffineTransformScale(cell.contentView.transform, 0.3f, 0.3f);
    [cell ba_animation_springWithDuration:0.8f delay:0.f damping:0.8f initialSpringVelocity:2 startOptions:UIViewAnimationOptionCurveEaseInOut finishOptions:UIViewAnimationOptionCurveEaseInOut startBlock:^{
        cell.contentView.transform = CGAffineTransformIdentity;
    } finishBlock:nil];
    
    /*! 博爱专属动画 2：卡片式动画 */
//    static CGFloat initialDelay = 0.2f;
//    static CGFloat stutter = 0.06f;
//    
//    cell.contentView.transform =  CGAffineTransformMakeTranslation(BAKit_SCREEN_WIDTH, 0);
//    
//    [cell ba_animation_springWithDuration:0.8f delay:(initialDelay + indexPath.row * stutter) damping:0.8f initialSpringVelocity:0 startOptions:UIViewAnimationOptionCurveEaseInOut finishOptions:UIViewAnimationOptionCurveEaseInOut startBlock:^{
//        cell.contentView.transform = CGAffineTransformIdentity;
//    } finishBlock:nil];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    BABaseListViewSectionModel *model = self.dataArray[section];
    if (!BAKit_stringIsBlank(model.sectionTitle))
    {
        return BAKit_Margin_44;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return FLT_MIN;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    BABaseListViewSectionModel *model = self.dataArray[section];
    if (!BAKit_stringIsBlank(model.sectionTitle))
    {
        UIView *headerView = [UIView new];
        [headerView ba_animation_createGradientWithColorArray:@[BAKit_Color_White, BAKit_Color_Green_LightGreen, BAKit_Color_Green, BAKit_Color_Green_LightGreen, BAKit_Color_White] frame:CGRectMake(0, 0, BAKit_SCREEN_WIDTH, BAKit_Margin_44) direction:UIViewLinearGradientDirectionHorizontal];
        
        UILabel *titleLabel = [UILabel new];
        titleLabel.text = model.sectionTitle;
        titleLabel.frame = CGRectMake(20, 5, BAKit_SCREEN_WIDTH - 20 * 2, 30);
        titleLabel.textAlignment = NSTextAlignmentCenter;
        
        [headerView addSubview:titleLabel];
        return headerView;
    }
    return [UIView new];
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    self.tableView.frame = self.view.bounds;
}

#pragma mark - setter / getter
- (UITableView *)tableView
{
    if (!_tableView)
    {
        _tableView = [[UITableView alloc] init];
        self.tableView.backgroundColor = BAKit_Color_Clear;
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        
        BAKit_UITableViewSetEstimatedRowHeight(self.tableView, 44);

        if (BAKit_ObjectIsNull(self.dataArray))
        {
            self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        }
        [self.view addSubview:self.tableView];
    }
    return _tableView;
}

@end

@implementation BABaseListViewSectionModel

@end

@implementation BABaseListViewCellModel

@end

