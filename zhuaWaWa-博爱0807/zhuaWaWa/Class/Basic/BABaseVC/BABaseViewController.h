//
//  BABaseViewController.h
//  BAQMUIDemo
//
//  Created by 博爱 on 2017/1/6.
//  Copyright © 2017年 boaihome. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SDCycleScrollView, BAKit_ClearCacheManager;
typedef void (^BannerBlock)(NSInteger index);

@interface BABaseViewController : UIViewController

@property(nonatomic, copy)   BannerBlock bannerBlock;
@property(nonatomic, strong) SDCycleScrollView *cycleScrollView;


#pragma mark - custome method

- (void)ba_base_viewWillAppear;
- (void)ba_base_viewWillDisappear;
- (void)ba_base_viewDidDisappear;

- (void)ba_base_setupUI;
- (void)ba_base_setupNavi;


- (void)gotoScanVC;

- (void)gotoWebWithUrl:(NSString *)url;
- (void)gotoWebWithHtmlString:(NSString *)htmlString
                        title:(NSString *)title;
- (void)gotoWebWithRequest:(NSURLRequest *)request;
- (void)gotoWebWithHtmlFileName:(NSString *)htmlFileName;

- (SDCycleScrollView *)setupBannerViewWithFrame:(CGRect)frame
                                 imageUrlsArray:(NSArray *)imageUrlsArray
                                    titlesArray:(NSArray *)titlesArray
                                withBannerBlock:(BannerBlock)bannerBlock;
- (SDCycleScrollView *)setupUploadViewWithFrame:(CGRect)frame
                                 imageUrlsArray:(NSArray *)imageUrlsArray
                                      withBlock:(BannerBlock)block;
/*！
 自定义动画样式

 @param type 动画样式
 @param animationView 需要动画的 View
 */
- (void)ba_animationWithBATransitionType:(BAKit_ViewTransitionType)type
                           animationView:(UIView *)animationView;

#pragma mark - 清理缓存
- (void)ba_clearCacheWithBlock:(void (^)(NSInteger buttonIndex, BAKit_ClearCacheManager *clearCacheManager, CGFloat cacheSize))block;


@end
