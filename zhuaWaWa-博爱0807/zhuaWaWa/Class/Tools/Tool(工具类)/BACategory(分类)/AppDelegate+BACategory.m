//
//  AppDelegate+BACategory.m
//  BABaseProject
//
//  Created by 博爱 on 16/5/7.
//  Copyright © 2016年 博爱之家. All rights reserved.
//

#import "AppDelegate+BACategory.h"
#import "AFNetworkActivityIndicatorManager.h"

#import "BANavigationController.h"
#import "NSObject+BAProgressHUD.h"

#import "AFNetworkReachabilityManager.h"
/*! 第三种tabbar */

/*! 用RDVTabBarController，使用此头文件 */
#import "BAHomeViewController.h"
#import "BAProfileViewController.h"
#import "BALoginViewController.h"
/*! 友盟分享 */
#import "BAShareManage.h"
#import <UMSocialCore/UMSocialCore.h>

/*! 本地通知VC */
#import "MJExtension.h"

@implementation AppDelegate (BACategory)

#pragma mark - ***** TabVC 设置
/*!
 *  是否使用自定义TabVC
 *
 *  @param is YES:使用，NO:使用RDVTabVC
 */
- (void)isBATabVC:(BOOL)is
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    // 自定义配置：tabbar 的背景颜色 和 item 颜色
    [BAKit_Helper ba_helperSetTabbarSelectedTintColor:BAKit_Color_AliPayBlue
                                      normalTintColor:BAKit_Color_White
                                      backgroundImage:nil
                                      backgroundColor:nil];
    // 自定义配置：状态栏颜色
    [BAKit_Helper ba_helperIsSetStatusBarStyleUIStatusBarStyleDefault:YES];
    BAUserModel *userModel = [YSAccountTool account];
    
    if (userModel) {
        
        BAHomeViewController *homeVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"homeView"];
        BANavigationController *homeVavi = [[BANavigationController alloc] initWithRootViewController:homeVC];
        homeVavi.tabBarItem = [UITabBarItem ba_tabBarItemWithTitle:@"首页" image:BAKit_ImageName(@"tabbar_mainframe") selectedImage:BAKit_ImageName(@"tabbar_mainframeHL") selectedTitleColor:nil tag:1];
        // tabBarItem：默认非选中颜色，注意：只需在第一个 VC 后面设置即可，其他 VC 无需设置
        homeVavi.tabBarItem.ba_tabBarItem_titleColor = BAKit_Color_LightGray;
        // tabBarItem：默认选中颜色，注意：只需在第一个 VC 后面设置即可，其他 VC 无需设置
        homeVavi.tabBarItem.ba_tabBarItem_titleSelectedColor = BAKit_Color_AliPayBlue;
        homeVC.title = homeVavi.tabBarItem.title;
        
        //    tabbarVC.selectedIndex = 3;
        self.window.rootViewController = homeVavi;
        [self.window makeKeyAndVisible];
    }else{
        BALoginViewController *loginVC = [[BALoginViewController alloc] init];
        [self.window setRootViewController:loginVC];
        [self.window makeKeyAndVisible];
    }
}
#pragma mark - ***** 设置3Dtouch
- (void)ba_setup3DTouch
{
    /**
     *  通过代码实现动态菜单
     *  一般情况下设置主标题、图标、type等，副标题是不设置的 - 简约原则
     *  iconWithTemplateImageName 自定义的icon
     *  iconWithType 系统的icon
     */
    /*! 系统ShortcutIcon */
    UIApplicationShortcutIcon *favrite = [UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypeFavorite];
    
    UIApplicationShortcutItem *itemOne = [[UIApplicationShortcutItem alloc] initWithType:@"favrite" localizedTitle:@"博爱3D Touch 测试1" localizedSubtitle:nil icon:favrite userInfo:nil];
    
    UIApplicationShortcutIcon *bookMark = [UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypeBookmark];
    
    UIApplicationShortcutItem *itemTwo = [[UIApplicationShortcutItem alloc] initWithType:@"book" localizedTitle:@"博爱3D Touch 测试2" localizedSubtitle:nil icon:bookMark userInfo:nil];
    
    /*! 自定义ShortcutIcon */
    UIApplicationShortcutIcon *iconContact = [UIApplicationShortcutIcon iconWithTemplateImageName:@"otherImages.bundle/扫一扫"];
    
    UIApplicationShortcutItem *itemThree = [[UIApplicationShortcutItem alloc] initWithType:@"contact" localizedTitle:@"博爱3D Touch 测试3" localizedSubtitle:nil icon:iconContact userInfo:nil];
    
    /*! 将items 添加到app图标 */
    [UIApplication sharedApplication].shortcutItems = @[itemOne, itemTwo, itemThree];
}

/*! 
 当点击AppIcon弹窗口,点击标题时调用，shortcutItem点击的是哪一个Item
 */
- (void)application:(UIApplication *)application performActionForShortcutItem:(nonnull UIApplicationShortcutItem *)shortcutItem completionHandler:(nonnull void (^)(BOOL))completionHandler
{
    UITabBarController *tabBarVC = (UITabBarController *)self.window.rootViewController;
    
    /*
     *  方式one - localizedTitle
     if ([shortcutItem.localizedTitle isEqualToString:@"时尚之都"]) {
     tabBarVC.selectedIndex = 0;
     }else if ([shortcutItem.localizedTitle isEqualToString:@"知识海洋"]){ //知识海洋
     tabBarVC.selectedIndex = 1;
     }else{
     tabBarVC.selectedIndex = 2; //联系的人
     }
     */
    
    /*! 方式two - type */
    if ([shortcutItem.type isEqualToString:@"movie"])
    {
        tabBarVC.selectedIndex = 0;
    }
    else if ([shortcutItem.type isEqualToString:@"book"])
    {
        tabBarVC.selectedIndex = 1;
    }
    else
    {
        tabBarVC.selectedIndex = 2; //联系的人
    }
}

#pragma mark - ***** 设置默认缓存大小
- (void)ba_setNSURLCache
{
    /*! 
     
     首先要知道，POST请求不能被缓存，只有 GET 请求能被缓存。因为从数学的角度来讲，GET 的结果是 幂等 的，就好像字典里的 key 与 value 就是幂等的，而 POST 不 幂等 。缓存的思路就是将查询的参数组成的值作为 key ，对应结果作为value。从这个意义上说，一个文件的资源链接，也叫 GET 请求，下文也会这样看待。
     80%的缓存需求：两行代码就可满足
     设置缓存只需要三个步骤：
     
     第一个步骤：请使用 GET 请求。
     
     第二个步骤：
     
     如果你已经使用 了 GET 请求，iOS 系统 SDK 已经帮你做好了缓存。你需要的仅仅是设置下内存缓存大小、磁盘缓存大小、以及缓存路径。甚至这两行代码不设置也是可以的，会有一个默认值。代码如下：
     
     要注意
     
     iOS 5.0开始，支持磁盘缓存，但仅支持 HTTP
     iOS 6.0开始，支持 HTTPS 缓存
     
     */
    NSURLCache *urlCache = [[NSURLCache alloc] initWithMemoryCapacity:4 * 1024 * 1024 diskCapacity:20 * 1024 * 1024 diskPath:nil];
    [NSURLCache setSharedURLCache:urlCache];
}

#pragma mark - ***** 设备各种信息获取 设置
- (void)test
{
    /*! 1、获取APP的名字 */
    NSString *appName = [NSString stringWithFormat:@"1、获取APP的名字：%@", BA_APP_Name];
    
    /*! 2、获取APP的版本号 */
    NSString *appVersion = [NSString stringWithFormat:@"2、获取APP的版本号：%@", BA_APP_Version];
    
    /*! 3、获取App短式版本号 */
    NSString *appVersionShort = [NSString stringWithFormat:@"3、获取App短式版本号：%@", BA_APP_VersionShort];
    
    /*! 4、使用BALocalizedString检索本地化字符串 */
    // 详见首页VC
    
    
    BALog(appName);
    BALog(appVersion);
    BALog(appVersionShort);
    
}


#pragma mark - ***** 网络监测 设置
- (void)BA_initializeWithApplication:(UIApplication *)application
{
//    // 注册DDLog
//    [DDLog addLogger:[DDASLLogger sharedInstance]];
//    [DDLog addLogger:[DDTTYLogger sharedInstance]];
//    [[DDTTYLogger sharedInstance] setColorsEnabled:YES];
    
    // 当使用AF发送网络请求时,只要有网络操作,那么在状态栏(电池条)wifi符号旁边显示  菊花提示
    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
    
    // 能够检测当前网络是wifi,蜂窝网络,没有网
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
      
        switch (status)
        {
            case AFNetworkReachabilityStatusReachableViaWiFi:
                BALog(@"当前是WiFi环境！");
                BAKit_ShowAlertWithMsg(@"当前是WiFi环境！");
                break;
            case AFNetworkReachabilityStatusNotReachable:
                BALog(@"当前无网络！");
                BAKit_ShowAlertWithMsg(@"当前无网络！");
                break;
            case AFNetworkReachabilityStatusUnknown:
                BALog(@"当前网络未知！");
                BAKit_ShowAlertWithMsg(@"当前网络未知！");
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                BALog(@"当前是蜂窝网络！");
                BAKit_ShowAlertWithMsg(@"当前是蜂窝网络！");
                break;
                
            default:
                break;
        }
    }];
    
    // 开启网络检测
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    
    // 网络活动发生变化时,会发送下方key 的通知, 可以在通知中心中添加检测
    // AFNetworkingReachabilityDidChangeNotification
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:nil name:AFNetworkingReachabilityDidChangeNotification object:nil];
}

#pragma mark - ***** 友盟分享/登陆 设置
- (void)BA_YMShareSetting
{
    // ************* 友盟分享 *************
    [BASHAREMANAGER ba_setupShareConfig];
}

//#define __IPHONE_10_0    100000
#if __IPHONE_OS_VERSION_MAX_ALLOWED > 100000
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey, id> *)options
{
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url];
    if (!result) {
        // 其他如支付等SDK的回调
    }
    return result;
}

#endif

/*！
 这里处理新浪微博SSO授权之后跳转回来，和微信分享完成之后跳转回来
 */
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url];
    if (!result) {
        //调用其他SDK，例如支付宝SDK等
        NSLog(@"Calling Application Bundle ID: %@", sourceApplication);
        NSLog(@"URL scheme:%@", [url scheme]);
        NSLog(@"URL query: %@", [url query]);
        NSString *jsonText = [[url query] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        NSDictionary *dict = [jsonText mj_JSONObject];

        BAProfileViewController *vc = [BAProfileViewController new];
        [vc openAppWithAlert:dict[@"parmeter"][@"msg"]];
        return YES;
    }
    return result;
}

//- (NSDictionary *)parseQueryString:(NSString *)query
//{
//    NSMutableDictionary *paramDict = [[NSMutableDictionary alloc] initWithDictionary:0];
//    
//    NSArray *paramArr = [query componentsSeparatedByString:@"&"];
//    for (NSString *param in paramArr)
//    {
//        NSArray * elements = [param componentsSeparatedByString:@"="];
//        if ([elements count] <= 1)
//        {
//            return nil;
//        }
//        
//        NSString *key = [[elements objectAtIndex:0] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//        NSString *value = [[elements objectAtIndex:1] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//        
//        [paramDict setObject:value forKey:key];
//    }
//    
//    return paramDict;
//}
//
//- (NSDictionary*)dictionaryFromQuery:(NSString *)query usingEncoding:(NSStringEncoding)encoding {
//    NSCharacterSet* delimiterSet = [NSCharacterSet characterSetWithCharactersInString:@"&;"];
//    NSMutableDictionary* pairs = [NSMutableDictionary dictionary];
//    NSScanner* scanner = [[NSScanner alloc] initWithString:query];
//    while (![scanner isAtEnd]) {
//        NSString* pairString = nil;
//        [scanner scanUpToCharactersFromSet:delimiterSet intoString:&pairString];
//        [scanner scanCharactersFromSet:delimiterSet intoString:NULL];
//        NSArray* kvPair = [pairString componentsSeparatedByString:@"="];
//        if (kvPair.count == 2) {
//            NSString* key = [[kvPair objectAtIndex:0]
//                             stringByReplacingPercentEscapesUsingEncoding:encoding];
//            NSString* value = [[kvPair objectAtIndex:1]
//                               stringByReplacingPercentEscapesUsingEncoding:encoding];
//            [pairs setObject:value forKey:key];
//        }
//    }
//    
//    return [NSDictionary dictionaryWithDictionary:pairs];
//}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
//    NSString *urlString = [url absoluteString];
//    if ([urlString isEqualToString:@"openBoaiApp://"])
//    {
//        BAProfileViewController *vc = [BAProfileViewController new];
//        [vc openAppWithAlert:@"我是博爱！"];
//        return YES;
//    }
    
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url];
    if (!result) {
        //调用其他SDK，例如支付宝SDK等
        NSString *urlString = [url absoluteString];
        if ([urlString isEqualToString:@"openBoaiApp://"])
        {
            BAProfileViewController *vc = [BAProfileViewController new];
            [vc openAppWithAlert:@"我是博爱！"];
            return YES;
        }
    }
    return result;
}

/*！
 这里处理新浪微博SSO授权进入新浪微博客户端后进入后台，再返回原来应用
 */
- (void)applicationDidBecomeActive:(UIApplication *)application
{
    BALog(@"程序已经进入前台！");
//    [UMSocialSnsService  applicationDidBecomeActive];
    [application setApplicationIconBadgeNumber:0];
    return;
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    BALog(@"程序即将进入后台！");

    [application setApplicationIconBadgeNumber:0];
    [application cancelAllLocalNotifications];
}

- (void)customizeInterface {
    UINavigationBar *navigationBarAppearance = [UINavigationBar appearance];
    
    UIImage *backgroundImage = nil;
    NSDictionary *textAttributes = nil;
    
    if (NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_6_1) {
        backgroundImage = [UIImage imageNamed:@"navigationbar_background_tall"];
        
        textAttributes = @{
                           NSFontAttributeName: [UIFont boldSystemFontOfSize:18],
                           NSForegroundColorAttributeName: [UIColor blackColor],
                           };
    } else {
#if __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_7_0
        backgroundImage = [UIImage imageNamed:@"navigationbar_background"];
        
        textAttributes = @{
                           UITextAttributeFont: [UIFont boldSystemFontOfSize:18],
                           UITextAttributeTextColor: [UIColor blackColor],
                           UITextAttributeTextShadowColor: [UIColor clearColor],
                           UITextAttributeTextShadowOffset: [NSValue valueWithUIOffset:UIOffsetZero],
                           };
#endif
    }
    
    [navigationBarAppearance setBackgroundImage:backgroundImage
                                  forBarMetrics:UIBarMetricsDefault];
    [navigationBarAppearance setTitleTextAttributes:textAttributes];
}

#pragma mark - ***** 其他

- (void)applicationWillResignActive:(UIApplication *)application {

    BALog(@"程序即将进入后台！");

}

- (void)applicationDidEnterBackground:(UIApplication *)application {

    BALog(@"程序已进入后台！");

}

- (void)applicationWillTerminate:(UIApplication *)application {

    
}

#pragma mark - ***** 本地通知回调

#pragma mark 调用过用户注册通知方法之后执行（也就是调用完registerUserNotificationSettings:方法之后执行）
- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings
{
    if (notificationSettings.types!=UIUserNotificationTypeNone)
    {
//        [self addLocalNotification];
    }
}

- (void)application:(UIApplication *)application
didReceiveLocalNotification:(UILocalNotification *)notification
{
    NSLog(@"noti:%@",notification);
    
    NSDictionary *userInfo = notification.userInfo;
    
    if (userInfo[@"userNoti"])
    {
        // 这里真实需要处理交互的地方
        // 获取通知所带的数据
        if (self.LocalNotificationDic)
        {
            self.LocalNotificationDic = nil;
        }
        self.LocalNotificationDic = userInfo[@"userNoti"];
        
//        [self.window.rootViewController BAAlertWithTitle:@"温馨提示：" message:self.LocalNotificationDic[@"userKey"] andOthers:@[@"取消", @"确定"] animated:YES action:^(NSInteger index) {
//            
//            if (index == 0)
//            {
//                return ;
//            }
//            
//        }];
        // 7-28 by linda
//        BAKit_ShowAlertWithMsg_ios8(self.LocalNotificationDic[@"userKey"]);
        // 图标上的数字减1
        //    application.applicationIconBadgeNumber -= 1;
        //    NSLog(@"didReceiveLocalNotification");
        
        // 更新显示的badge个数
        NSInteger badge = [UIApplication sharedApplication].applicationIconBadgeNumber;
        badge--;
        badge = badge >= 0 ? badge : 0;
        [UIApplication sharedApplication].applicationIconBadgeNumber = badge;
    }

    // 在不需要再推送时，可以取消推送
    [BALocalNotification cancelLocalNotificationWithKey:@"userKey"];
}
#pragma mark - *****
#pragma mark - 获取当前屏幕的控制器
- (UIViewController *)getCurrentTabViewController
{
    return self.window.rootViewController;
}


@end
