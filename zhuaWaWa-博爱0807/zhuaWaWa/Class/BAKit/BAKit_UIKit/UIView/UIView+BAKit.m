
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

#import "UIView+BAKit.h"
#import <objc/runtime.h>


@implementation BAKitViewModel

- (UIButton *)ba_alertDot_button
{
    if (!_ba_alertDot_button)
    {
        _ba_alertDot_button = [[UIButton alloc] init];
    }
    return _ba_alertDot_button;
}

@end

@implementation UIView (BAKit)

/**
 给 UIView 添加点击事件
 
 @param target target
 @param action SEL
 */
- (void)ba_viewAddTarget:(id)target
                  action:(SEL)action
{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:target
                                                                         action:action];
    self.userInteractionEnabled = YES;
    [self addGestureRecognizer:tap];
}

/**
 快速创建 view
 
 @param frame frame
 @param backgroundColor backgroundColor
 @return view
 */
+ (UIView *)ba_viewCreatWithFrame:(CGRect)frame
                  backgroundColor:(UIColor *)backgroundColor
{
    UIView *view = [[UIView alloc] initWithFrame:frame];
    view.backgroundColor = backgroundColor;
    
    return view;
}

/**
 快速设置 view 的边框
 
 @param color 边框颜色
 @param cornerRadius 边框角度
 @param width 边框线宽度
 */
- (void)ba_viewSetBorderWithColor:(UIColor *)color
                     cornerRadius:(CGFloat)cornerRadius
                            width:(CGFloat)width
{
    [self ba_view_setViewRectCornerType:BAKit_ViewRectCornerTypeAllCorners viewCornerRadius:cornerRadius borderWidth:width borderColor:color];
//    // 设置边框宽度
//    self.layer.borderWidth = width;
//    // 设置圆角半径
//    self.layer.cornerRadius = cornerRadius;
//    // 设置是否栅格化
//    self.layer.shouldRasterize = NO;
//    // 设置栅格化规模
//    self.layer.rasterizationScale = 2;
//    // 设置边缘抗锯齿遮盖
//    self.layer.edgeAntialiasingMask = kCALayerLeftEdge | kCALayerRightEdge | kCALayerBottomEdge | kCALayerTopEdge;
//    // 设置边界剪切
//    self.clipsToBounds = YES;
//    // 设置边界是否遮盖
//    self.layer.masksToBounds = YES;
//    
//    // 创建颜色空间
//    CGColorSpaceRef space = CGColorSpaceCreateDeviceRGB();
//    CGColorRef cgColor = [color CGColor];
//    self.layer.borderColor = cgColor;
//    CGColorSpaceRelease(space);
}

/**
 删除边框
 */
- (void)ba_viewRemoveBorder
{
    [self ba_viewSetBorderWithColor:nil cornerRadius:0 width:0];
}

/**
 创建阴影
 
 @param offset offset
 @param opacity opacity
 @param radius radius
 */
- (void)ba_viewSetRectShadowWithOffset:(CGSize)offset
                               opacity:(CGFloat)opacity
                                radius:(CGFloat)radius
{
    // 设置阴影的颜色
    self.layer.shadowColor = [UIColor blackColor].CGColor;
    // 设置阴影的透明度
    self.layer.shadowOpacity = opacity;
    // 设置阴影的偏移量
    self.layer.shadowOffset = offset;
    // 设置阴影的模糊程度
    self.layer.shadowRadius = radius;
    // 设置边界是否遮盖
    self.layer.masksToBounds = NO;
}

/**
 删除阴影
 */
- (void)ba_viewRemoveShadow
{
    [self.layer setShadowColor:[[UIColor clearColor] CGColor]];
    [self ba_viewSetRectShadowWithOffset:CGSizeMake(0.0f, 0.0f) opacity:0.0f radius:0.f];
}

/**
 创建圆角半径阴影
 */
- (void)ba_viewSetRoundShadowWithCornerRadius:(CGFloat)cornerRadius
                                       offset:(CGSize)offset
                                      opacity:(CGFloat)opacity
                                       radius:(CGFloat)radius
{
    // 设置阴影的颜色
    self.layer.shadowColor = [UIColor blackColor].CGColor;
    // 设置阴影的透明度
    self.layer.shadowOpacity = opacity;
    // 设置阴影的偏移量
    self.layer.shadowOffset = offset;
    // 设置阴影的模糊程度
    self.layer.shadowRadius = radius;
    // 设置是否栅格化
    self.layer.shouldRasterize = YES;
    // 设置圆角半径
    self.layer.cornerRadius = cornerRadius;
    // 设置阴影的路径
    self.layer.shadowPath = [[UIBezierPath bezierPathWithRoundedRect:[self bounds]
                                                        cornerRadius:cornerRadius] CGPath];
    // 设置边界是否遮盖
    self.layer.masksToBounds = NO;
}

/**
 *  添加子 View
 *
 *  @param array 添加子的ViewArray
 */
- (void)ba_viewAddSubViewsWithArray:(NSArray *)array
{
    if (array)
    {
        [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [self addSubview:obj];
        }];
    }
    else
    {
        NSLog(@"数组 %@ 为空！", array);
    }
}

/**
 *  移除所有 subviews
 *
 */
- (void)ba_viewRemoveAllSubviews
{
    [[self subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
}

/**
 *  获取当前View的VC
 *
 *  @return 获取当前View的VC
 */
- (UIViewController *)ba_viewGetCurrentViewController
{
    for (UIView *view = self; view; view = view.superview)
    {
        UIResponder *nextResponder = [view nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]])
        {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}

- (UIViewController *)ba_viewGetCurrentParentController
{
    UIResponder *responder = [self nextResponder];
    while (responder) {
        if ([responder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)responder;
        }
        responder = [responder nextResponder];
    }
    return nil;
}

/*!
 *  显示警告框
 *
 *  @param title   title description
 *  @param message message description
 */
- (void)ba_viewShowAlertViewWithTitle:(NSString *)title
                              message:(NSString *)message
{
    [[[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:@"确 定" otherButtonTitles: nil] show];
}

- (BAKitViewModel *)model
{
    BAKitViewModel *viewModel = objc_getAssociatedObject(self, _cmd);
    if (!viewModel)
    {
        viewModel = [[BAKitViewModel alloc] init];
//        BAKit_Objc_setObj(@selector(model), viewModel);
        objc_setAssociatedObject(self, _cmd, viewModel, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return viewModel;
}

/**
 UIView：创建一条线，frame、color

 @param frame frame description
 @param color color description
 @return UIView
 */
+ (UIView *)ba_viewAddLineViewWithFrame:(CGRect)frame
                                  color:(UIColor *)color
{
    UIView *line         = [[UIView alloc] initWithFrame:frame];
    line.backgroundColor = color;
    
    return line;
}

/**
 UIView：创建一条线，frame、color、tag

 @param frame frame description
 @param color color description
 @param tag tag description
 @return UIView
 */
+ (UIView *)ba_viewAddLineViewWithFrame:(CGRect)frame
                                  color:(UIColor *)color
                                    tag:(NSInteger)tag
{
    UIView *line         = [[UIView alloc] initWithFrame:frame];
    line.backgroundColor = color;
    line.tag             = tag;
    
    return line;
}

@end

