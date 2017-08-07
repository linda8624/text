
/*!
 *  @header BAKit.h
 *          BABaseProject
 *
 *  @brief  BAKit
 *
 *  @author 博爱
 *  @copyright    Copyright © 2016年 博爱. All rights reserved.
 *  @version    V1.0
 */

//                            _ooOoo_
//                           o8888888o
//                           88" . "88
//                           (| -_- |)
//                            O\ = /O
//                        ____/`---'\____
//                      .   ' \\| |// `.
//                       / \\||| : |||// \
//                     / _||||| -:- |||||- \
//                       | | \\\ - /// | |
//                     | \_| ''\---/'' | |
//                      \ .-\__ `-` ___/-. /
//                   ___`. .' /--.--\ `. . __
//                ."" '< `.___\_<|>_/___.' >'"".
//               | | : `- \`.;`\ _ /`;.`/ - ` : | |
//                 \ \ `-. \_ __\ /__ _/ .-` / /
//         ======`-.____`-.___\_____/___.-`____.-'======
//                            `=---='
//
//         .............................................
//                  佛祖镇楼                  BUG辟易
//          佛曰:
//                  写字楼里写字间，写字间里程序员；
//                  程序人员写程序，又拿程序换酒钱。
//                  酒醒只在网上坐，酒醉还来网下眠；
//                  酒醉酒醒日复日，网上网下年复年。
//                  但愿老死电脑间，不愿鞠躬老板前；
//                  奔驰宝马贵者趣，公交自行程序员。
//                  别人笑我忒疯癫，我笑自己命太贱；
//                  不见满街漂亮妹，哪个归得程序员？

/*
 
 *********************************************************************************
 *
 * 在使用BAKit的过程中如果出现bug请及时以以下任意一种方式联系我，我会及时修复bug
 *
 * QQ     : 可以添加ios开发技术群 479663605 在这里找到我(博爱1616【137361770】)
 * 微博    : 博爱1616
 * Email  : 137361770@qq.com
 * GitHub : https://github.com/boai
 * 博客    : http://boaihome.com
 
 *********************************************************************************
 
 */

#import <UIKit/UIKit.h>

@class BAKitViewModel;
@interface UIView (BAKit)

@property (nonatomic, strong) BAKitViewModel *model;

/**
 给 UIView 添加点击事件

 @param target target
 @param action SEL
 */
- (void)ba_viewAddTarget:(id)target
                  action:(SEL)action;

/**
 快速创建 view

 @param frame frame
 @param backgroundColor backgroundColor
 @return view
 */
+ (UIView *)ba_viewCreatWithFrame:(CGRect)frame
                  backgroundColor:(UIColor *)backgroundColor;

/**
 快速设置 view 的边框

 @param color 边框颜色
 @param cornerRadius 边框角度
 @param width 边框线宽度
 */
- (void)ba_viewSetBorderWithColor:(UIColor *)color
                     cornerRadius:(CGFloat)cornerRadius
                            width:(CGFloat)width;

/**
 删除边框
 */
- (void)ba_viewRemoveBorder;

/**
 创建阴影

 @param offset offset
 @param opacity opacity
 @param radius radius
 */
- (void)ba_viewSetRectShadowWithOffset:(CGSize)offset
                               opacity:(CGFloat)opacity
                                radius:(CGFloat)radius;

/**
 删除阴影
 */
- (void)ba_viewRemoveShadow;

/**
 创建圆角半径阴影
 */
- (void)ba_viewSetRoundShadowWithCornerRadius:(CGFloat)cornerRadius
                                       offset:(CGSize)offset
                                      opacity:(CGFloat)opacity
                                       radius:(CGFloat)radius;

/**
 *  添加子 View
 *
 *  @param array 添加子的ViewArray
 */
- (void)ba_viewAddSubViewsWithArray:(NSArray *)array;

/**
 *  移除所有 subviews
 *
 */
- (void)ba_viewRemoveAllSubviews;

/**
 *  获取当前 View 的 VC
 *
 *  @return 获取当前 View 的 VC
 */
- (UIViewController *)ba_viewGetCurrentViewController;

- (UIViewController *)ba_viewGetCurrentParentController;

/*!
 *  显示警告框
 *
 *  @param title   title description
 *  @param message message description
 */
- (void)ba_viewShowAlertViewWithTitle:(NSString *)title
                              message:(NSString *)message;

/**
 UIView：创建一条线，frame、color
 
 @param frame frame description
 @param color color description
 @return UIView
 */
+ (UIView *)ba_viewAddLineViewWithFrame:(CGRect)frame
                                  color:(UIColor *)color;

/**
 UIView：创建一条线，frame、color、tag
 
 @param frame frame description
 @param color color description
 @param tag tag description
 @return UIView
 */
+ (UIView *)ba_viewAddLineViewWithFrame:(CGRect)frame
                                  color:(UIColor *)color
                                    tag:(NSInteger)tag;
@end

@interface BAKitViewModel : NSObject

@property (nonatomic, strong) UIButton *ba_alertDot_button;
/** 当文字较多时maxHeight限制小圆点高度从而呈现椭圆式形状 */
@property (nonatomic, assign) CGFloat ba_alertDot_maxHeight;


@end
