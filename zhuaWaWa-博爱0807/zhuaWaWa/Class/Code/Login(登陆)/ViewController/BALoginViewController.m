//
//  BALoginViewController.m
//  test
//
//  Created by 博爱 on 2016/11/25.
//  Copyright © 2016年 博爱. All rights reserved.
//
#import "BALoginViewController.h"
#import "BAUserModel.h"
#import "BANewsNetManager.h"

#import "AppDelegate.h"
#import "BANavigationController.h"
#import "BAHomeViewController.h"

@interface BALoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *phoneNumTextField;
@property (weak, nonatomic) IBOutlet UITextField *pwdTextField;
@property (weak, nonatomic) IBOutlet UIButton    *loginButton;
@property (nonatomic) NSMutableDictionary *dict;

@property (nonatomic, strong) NSString *yanzhengzi;
@property (nonatomic, strong) NSString *loginPw;


- (IBAction)loginButtonAction:(UIButton *)sender;

@end

@implementation BALoginViewController

- (void)ba_base_viewWillAppear
{
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)ba_base_setupUI
{
    self.title = @"登  录";
}
- (IBAction)yanzhengmClick:(UIButton *)sender
{
    if ([BACommon ba_isNSStringNULL:_phoneNumTextField.text])
    {
        BAKit_ShowAlertWithMsg(@"手机号码不能为空！");
        return;
    }
    sender.userInteractionEnabled = NO;
    __block UIButton *btn = sender;
    [sender ba_countDownWithTimeInterval:60 countDownFormat:@"剩余 %zd s"];
    [sender setTimeStoppedCallback:^{
        [btn setTitle:@"获取验证码" forState:UIControlStateNormal];
    }];
    NSDate *dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a = [dat timeIntervalSince1970] * 1000;
    NSString *timeString = [NSString stringWithFormat:@"%.0f",a];
    NSDictionary *parameters = @{@"phone":_phoneNumTextField.text,
                                 @"seq":@"138012",
                                 @"M0":@"IMMC",
                                 @"M9":timeString};
    [BANewsNetManager getStatusWithURL:URL_SendCodeToPhone withPostText:parameters success:^(id response) {
        NSNumber *code = response[@"code"];
        if ([code isEqualToNumber:@1]) {
            
            NSString *yanzhengzi = [response[@"data"] substringToIndex:6];//截取掉下标2之前的字符串
            self.yanzhengzi = yanzhengzi;
            self.loginPw  =  [response[@"data"] substringFromIndex:6];//登录密码
        }else{
             BAKit_ShowAlertWithMsg(response[@"msg"]);
        }
    } failure:^(NSError *error) {
        
    }];
}
- (IBAction)loginButtonAction:(UIButton *)sender
{
    if ([BACommon ba_isNSStringNULL:_phoneNumTextField.text] || [BACommon ba_isNSStringNULL:_pwdTextField.text])
    {
        BAKit_ShowAlertWithMsg(@"手机号码或验证不能为空！");
        return;
    }
    NSDate *dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a = [dat timeIntervalSince1970] * 1000;
    NSString *timeString = [NSString stringWithFormat:@"%.0f",a];
    NSDictionary *parameters = @{@"phone":_phoneNumTextField.text,
                                 @"password":self.loginPw,
                                 @"M0":@"IMMC",
                                 @"M9":timeString};
    [BANewsNetManager getStatusWithURL:URL_Login withPostText:parameters success:^(id response) {
        NSNumber *code = response[@"code"];
        if ([code isEqualToNumber:@1]) {
            BAUserModel *userModel = [BAUserModel BAMJParse:response[@"data"]];
            [YSAccountTool saveAccount:userModel];
    
            AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
            BAHomeViewController *homeVc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"homeView"];
            
            BANavigationController *nav = [[BANavigationController alloc] initWithRootViewController:homeVc];
            [delegate.window setRootViewController:nav];
            
        }

    } failure:^(NSError *error) {

    }];
}
- (IBAction)weixinLogin:(id)sender {
    BAKit_WeakSelf;
    /*! 友盟登陆 */
        
        [BASHAREMANAGER ba_loginListWithViewController:self isGetAuthWithUserInfo:YES loginCallback:^(UMSocialUserInfoResponse *response) {
            
            BAKit_StrongSelf
            // 授权信息【具体返回参数要看平台，每个平台返回的数据不一样！如：新浪微博没有返回 openid 】
            NSString *msg = [NSString stringWithFormat:@"登陆成功，获取用户名：%@", response.name];
            self.dict = response;
            NSLog(@"登陆返回信息 uid: %@", response.uid);
            NSLog(@"登陆返回信息 openid: %@", response.openid);
            NSLog(@"登陆返回信息 accessToken: %@", response.accessToken);
            NSLog(@"登陆返回信息 refreshToken: %@", response.refreshToken);
            NSLog(@"登陆返回信息 expiration: %@", response.expiration);
            
            // 用户信息
            NSLog(@"登陆返回信息 name: %@", response.name);
            NSLog(@"登陆返回信息 iconurl: %@", response.iconurl);
            NSLog(@"登陆返回信息 gender: %@", response.gender);
            
            // 第三方平台SDK源数据
            NSLog(@"登陆返回信息 originalResponse: %@", response.originalResponse);
            
            
            NSDate *dat = [NSDate dateWithTimeIntervalSinceNow:0];
            NSTimeInterval a = [dat timeIntervalSince1970] * 1000;
            NSString *timeString = [NSString stringWithFormat:@"%.0f",a];
            
            NSDictionary *parameters = @{@"auid":response.uid,
                                         @"openid":response.openid,
                                         @"unionid":response.unionId,
                                         @"nickName":response.name,
                                         @"face":response.iconurl,
                                         @"city":@"",
                                         @"sex":response.gender,
                                         @"M0":@"IMMC",
                                         @"M9":timeString};
            
            [BANewsNetManager getStatusWithURL:URL_LoginByWX withPostText:parameters success:^(id response) {
                NSNumber *code = response[@"code"];
                if ([code isEqualToNumber:@1]) {
                    BAUserModel *userModel = [BAUserModel BAMJParse:response[@"data"]];
                    [YSAccountTool saveAccount:userModel];
                    
                    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
                    BAHomeViewController *homeVc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"homeView"];
                    
                    BANavigationController *nav = [[BANavigationController alloc] initWithRootViewController:homeVc];
                    [delegate.window setRootViewController:nav];
                    
                }else if([code isEqual:@"2"]){
                }
                
            } failure:^(NSError *error) {
                
            }];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                if (self.dict)
                {
                    [BASHAREMANAGER ba_cancelAuthWithPlatformType:UMSocialPlatformType_QQ];
                    BASHAREMANAGER.authOpFinish = ^{
                        NSString *msg = [NSString stringWithFormat:@"清除授权成功！"];
                    };
                }
                
            });
            
        }];
    
}

- (void)dealloc
{
    /*! 移除监听 */
//    [self.phoneNumTextField removeObserver:self forKeyPath:@"text"];
    
}

@end
