
#ifndef zhuaWaWaFrameHeader_h
#define zhuaWaWaFrameHeader_h

#pragma mark - ***** frame设置
// 2. >> 屏幕的宽度
/////*! 当前设备的屏幕宽度 */
#define BA_SCREEN_WIDTH    ((([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortrait) || ([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortraitUpsideDown)) ? [[UIScreen mainScreen] bounds].size.width : [[UIScreen mainScreen] bounds].size.height)

/*! 当前设备的屏幕高度 */
#define BA_SCREEN_HEIGHT   ((([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortrait) || ([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortraitUpsideDown)) ? [[UIScreen mainScreen] bounds].size.height : [[UIScreen mainScreen] bounds].size.width)

/*! 黄金比例的宽 */
#define BA_WIDTH_0_618           BA_SCREEN_WIDTH * 0.618

/*! Status bar height. */
#define  BA_StatusBarHeight      20.f

/*! Navigation bar height. */
#define  BA_NavigationBarHeight  44.f

/*! Tabbar height. self.tabBarController.tabBar.height */
#define  BA_TabbarHeight         49.f

/*! Status bar & navigation bar height. */
#define  BA_StatusBarAndNavigationBarHeight   (20.f + 44.f)

/*! iPhone4 or iPhone4s */
#define  BA_iPhone4_4s     (Width == 320.f && Height == 480.f)

/*! iPhone5 or iPhone5s */
#define  BA_iPhone5_5s     (Width == 320.f && Height == 568.f)

/*! iPhone6 or iPhone6s */
#define  BA_iPhone6_6s     (Width == 375.f && Height == 667.f)

/*! iPhone6Plus or iPhone6sPlus */
#define  BA_iPhone6_6sPlus (Width == 414.f && Height == 736.f)

/*! cell 的间距：10 */
#define BAStatusCellMargin 10

/*! 设置 view 圆角和边框 */
#define BA_ViewBorderRadius(View, Radius, Width, Color)\
\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES];\
[View.layer setBorderWidth:(Width)];\
[View.layer setBorderColor:[Color CGColor]]

/*! 由角度转换弧度 */
#define BA_DegreesToRadian(x) (M_PI * (x) / 180.0)

/*! 由弧度转换角度 */
#define BA_RadianToDegrees(radian) (radian*180.0)/(M_PI)

#define FNColor(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:255/255.0]




#define FONT_10 [UIFont systemFontOfSize:10.0f]
#define FONT_11 [UIFont systemFontOfSize:11.0f]
#define FONT_12 [UIFont systemFontOfSize:12.0f]
#define FONT_13 [UIFont systemFontOfSize:13.0f]
#define FONT_14 [UIFont systemFontOfSize:14.0f]
#define FONT_16 [UIFont systemFontOfSize:16.0f]
#define FONT_17 [UIFont systemFontOfSize:17.0f]
#define FONT_18 [UIFont systemFontOfSize:18.0f]
#define FONT_20 [UIFont systemFontOfSize:20.0f]
#define FONT_21 [UIFont systemFontOfSize:21.0f]
#define FONT_22 [UIFont systemFontOfSize:22.0f]
#define FONT_24 [UIFont systemFontOfSize:24.0f]


#define TOP_HEIGHT 44.0f


#endif /* BAFrameHeader_h */
