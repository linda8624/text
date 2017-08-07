//
//  AppDelegate.m
//  zhuaWaWa
//
//  Created by boai on 2017/7/28.
//  Copyright © 2017年 boai. All rights reserved.
//

#import "AppDelegate.h"

#import "BAHomeViewController.h"
#import "BANavigationController.h"
#import "BALoginViewController.h"
#import "IQKeyboardManager.h"
#import "AppDelegate+BACategory.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [self isBATabVC:YES];
    [self completionHandleIQKeyboard];
    [self BA_YMShareSetting];
    
    return YES;
}

#pragma mark -  键盘处理
- (void)completionHandleIQKeyboard
{
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enable = YES;
    manager.shouldResignOnTouchOutside = YES;
    manager.shouldToolbarUsesTextFieldTintColor = YES;
    manager.enableAutoToolbar = YES;
}

// NOTE: 9.0以后使用新API接口
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary*)options
{
    
    if ([url.host isEqualToString:@"safepay"]) {
        // 支付跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            // NSLog(@"result = %@",resultDic);
            [[NSNotificationCenter defaultCenter]postNotificationName:@"alipayResult" object:[resultDic objectForKey:@"resultStatus"]];
        }];
        return YES ;
        
    }else if ([url.host isEqualToString:@"pay"]) {
        return [WXApi handleOpenURL:url delegate:self];
    }else{
        return [[UMSocialManager defaultManager] handleOpenURL:url];
    }
}
/**
 这里处理新浪微博SSO授权之后跳转回来，和微信分享完成之后跳转回来
 */
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    if ([url.host isEqualToString:@"safepay"]) {
        // 支付跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            //   NSLog(@"result = %@",resultDic);
            [[NSNotificationCenter defaultCenter]postNotificationName:@"alipayResult" object:[resultDic objectForKey:@"resultStatus"]];
        }];
        return YES ;
        
    }else if ([url.host isEqualToString:@"pay"]) {
        return [WXApi handleOpenURL:url delegate:self];
    }else{
        return [[UMSocialManager defaultManager] handleOpenURL:url];
    }
    
}
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    
    if ([url.host isEqualToString:@"safepay"]) {
        // 支付跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            [[NSNotificationCenter defaultCenter]postNotificationName:@"alipayResult" object:[resultDic objectForKey:@"resultStatus"]];
        }];
        return YES ;
        
    }else if ([url.host isEqualToString:@"pay"]) {
        return [WXApi handleOpenURL:url delegate:self];
    }else{
        return [[UMSocialManager defaultManager] handleOpenURL:url];
    }
    
    
}

//微信支付结果
- (void) onResp:(BaseResp*)resp
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"weixinPay" object:resp];
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
