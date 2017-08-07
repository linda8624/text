//
//  zhuaWaWaDefin.h
//  zhuaWaWa
//
//  Created by linda on 2017/7/28.
//  Copyright © 2017年 boai. All rights reserved.
//

#ifndef zhuaWaWaDefin_h
#define zhuaWaWaDefin_h

#pragma mark - ***** AppDelegate

/*! 友盟统计 SDK */
#define BA_UMengAnalyticskey     @"58199af182b635155d0028cd"

/*! 字体 */
#define BA_FontSize(fontSize) [UIFont systemFontOfSize:fontSize]

/*! Loading */
#define BA_Loading @"Loading..."

/*! 用safari打开URL */
#define BA_OpenUrl(urlStr) [BASharedApplication openURL:[NSURL URLWithString:urlStr]]

/*! 复制文字内容 */
#define BA_CopyContent(content) [[UIPasteboard generalPasteboard] setString:content]

/*! 随机数据 */
#define BA_RandomData arc4random_uniform(5)

/*! weakSelf */
#define BA_WEAKSELF typeof(self) __weak weakSelf = self
#define BA_WeakSelf(type)  __weak typeof(type) weak##type = type;

/*! strongSelf */
#define BA_StrongSelf(type)  __strong typeof(type) type = weak##type;

/*! 通知 */
#define BA_NotiCenter [NSNotificationCenter defaultCenter]

#define BA_UserDefault [NSUserDefaults standardUserDefaults]

/*! 图片 */
#define BA_ImageName(imageName) [UIImage imageNamed:imageName]

/*! 获取图片资源 */
#define BA_GetImage(imageName) [UIImage imageNamed:[NSString stringWithFormat:@"%@",imageName]]

/*! 定义 UIImage 对象 */
#define BA_ImageFromBundle(fileName) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:A ofType:nil]]

/*! 获取当前语言 */
#define BA_CurrentLanguage ([[NSLocale preferredLanguages] objectAtIndex:0])



#pragma mark - 通知类
#define BANotioKey_LoginFinish   @"BANotioKey_LoginFinish"



/*! 其他 */
#pragma mark - ***** 应用内相关设置
#define BA_placeHolder_Image @"placeHolder"


/*! 警告框-一个按钮【VC】 */
#define BA_SHOW_ALERT(title, msg)  UIAlertController *alert = [UIAlertController alertControllerWithTitle:title  message:msg preferredStyle:UIAlertControllerStyleAlert];\
[alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {\
BALog(@"你点击了确定按钮！");\
}]];\
[self presentViewController:alert animated:YES completion:nil];\

/*! 警告框-一个按钮【View】 */
#define BA_AlertAtView(msg) [[[UIAlertView alloc] initWithTitle:@"温馨提示：" message:msg delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil] show];





#endif /* BADefin_h */
