//
//  PLPlayerViewController.m
//  BABaseProject
//
//  Created by linda on 2017/7/22.
//  Copyright © 2017年 博爱之家. All rights reserved.
//

#import "PLPlayerViewController.h"
#import "XHLetouHeaderView.h"
#import "YSWaWaZhuaView.h"
#import "BANewsNetManager.h"
#import "BAURLsPath.h"
#import "XHViewController.h"
#import "YSWaWaHeard.h"
#import "XHViewController.h"
#import "YSBaJiView.h"
#import "YSGameSucceedView.h"
#import "YSGameFaildView.h"
#import "YSWaWaNavView.h"
#import "YSWaWaWaittingView.h"
#import "YSRoomInfoModel.h"
#import "YSMyGiftView.h"
#import "YSMyGiftModel.h"
#import "UIView+HUD.h"
@interface PLPlayerViewController ()<PLPlayerDelegate,YSWaWaZhuaViewDelegate,XHViewControllerDelegate,XHLetouHeaderViewDelegate>
{
    // 是否已经有游戏控制的定时器了
    BOOL isHaveGameControlTimer;
    // 当前是游戏界面
    BOOL _isGameControl;
}
@property (nonatomic, strong) PLPlayer  *player;
// 游戏控制界面
@property (nonatomic, strong) XHLetouHeaderView *gameControlView;
// 游戏默认状态底部视图
@property (nonatomic, strong) YSWaWaZhuaView *joinView;
// 游戏默认状态底部视图
@property (nonatomic, strong) YSWaWaWaittingView *waittingView;
// 房间信息模型
@property (nonatomic, strong) YSRoomInfoModel *model ;
// 等待我开始游戏视图
@property (nonatomic, strong) XHViewController *myStartViews;
// 头部视图
@property (nonatomic, strong) YSWaWaHeard *gameHeadView;
// 霸机视图
@property (nonatomic, strong)  YSBaJiView *bajiView;

@property (nonatomic, strong) YSGameSucceedView *successView;

@property (nonatomic, strong) YSGameFaildView *failView;

// 房间状态定时器
@property (nonatomic, strong) NSTimer  *play_timer;

// 游戏控制定时器
@property (nonatomic, strong) NSTimer  *gameControl_timer;

// 方向控制标识
@property (nonatomic, assign) NSInteger command;

@property (nonatomic, strong) YSWaWaNavView *navView;
// 全局的游戏倒计时
@property (nonatomic, strong) UIButton *gameTime;

@property (nonatomic, strong) YSMyGiftView *myGiftView;
@end

@implementation PLPlayerViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self initMySubViews];

    [self loadRoomGameInfo];
}
// 只调用一次
- (void)loadRoomGameInfo{
    
    NSDate *dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a = [dat timeIntervalSince1970] * 1000;
    NSString *timeString = [NSString stringWithFormat:@"%.0f",a];
    NSString *auid = [YSAccountTool account].auid;
    NSDictionary *parameters = @{@"auid":auid,
                                 @"jid":self.jid,
                                 @"M0":@"IMMC",
                                 @"M9":timeString};
    NSString *postUrl = [NSString stringWithFormat:@"%@%@",@"http://api1.wawazhua.com/jvvserver/",URL_RoomGameInfo];
    [BANewsNetManager getStatusWithURL:postUrl withPostText:parameters success:^(id response) {
        NSNumber *code = response[@"code"];
        if ([code isEqualToNumber:@1]){
            YSRoomInfoModel *model = [YSRoomInfoModel BAMJParse:response[@"data"]];
            self.model = model;
            
           // [self.navView.myGold setTitle:model.userRemainGold forState:UIControlStateNormal];
            [self.gameHeadView.roomUserNum setTitle:[NSString stringWithFormat:@"围观%@人 排队%@人",model.totalUserNum,model.waittingUserNum] forState:UIControlStateNormal];
            
            [self.gameHeadView.curGamer setTitle:[NSString stringWithFormat:@"当前玩家:%@",model.curGamer] forState:UIControlStateNormal];
            
            //初始化播放器
            [self createPlayer];
            
            // 初始化房间信息
            [self initRoomStatusWithModel:model];
            
            // 房间状态定时器
            [self createQueryRoomStatusTimer];
        }
    } failure:^(NSError *error) {
    }];
}
// 房间状态定时器,每秒执行
- (void)createQueryRoomStatusTimer {
    
    self.play_timer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(queryRoomStatus) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.play_timer forMode:NSRunLoopCommonModes];
}

// 定时器,每秒执行
- (void)queryRoomStatus{
    [self playTime];
    
    NSDate *dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a = [dat timeIntervalSince1970] * 1000;
    NSString *timeString = [NSString stringWithFormat:@"%.0f",a];
    NSDictionary *parameters = @{@"auid":[YSAccountTool account].auid,
                                 @"jid":self.jid,
                                 @"M0":@"IMMC",
                                 @"M9":timeString};
    NSString *postUrl = [NSString stringWithFormat:@"%@%@",@"http://api1.wawazhua.com/jvvserver/",URL_QueryRoomStatus];
    
    BALog(@"queryRoomStatus%@",self.model.curGamerAuid);
     BA_WEAKSELF;
    [BANewsNetManager getStatusWithURL:postUrl withPostText:parameters success:^(id response) {
        NSNumber *code = response[@"code"];
        if ([code isEqualToNumber:@1]){
            weakSelf.model.totalUserNum = response[@"data"][@"totalUserNum"];
            weakSelf.model.waittingUserNum = response[@"data"][@"waittingUserNum"];//当前排队人数
            weakSelf.model.myWaittingIndex = response[@"data"][@"myWaittingIndex"];//当前我之前的人数
            BALog(@"%@",weakSelf.model.myWaittingIndex);
            int index = [weakSelf.model.myWaittingIndex intValue];
            if(index >=0){
                [weakSelf.waittingView.btnWaitingStatus setTitle:[NSString stringWithFormat:@"排队中 前方%@个玩家", weakSelf.model.myWaittingIndex] forState:UIControlStateNormal];
            }
            weakSelf.model.gameStatus = response[@"data"][@"gameStatus"];
            
            [weakSelf.gameHeadView.roomUserNum setTitle:[NSString stringWithFormat:@"围观%@人 排队%@人",weakSelf.model.totalUserNum,weakSelf.model.waittingUserNum] forState:UIControlStateNormal];
            
            
            BALog(@"BA_WEAKSELFqueryRoomStatus%@",self.model.curGamerAuid);
            if(![weakSelf.model.curGamerAuid isEqualToString:response[@"data"][@"curGamerAuid"]]){
                
                weakSelf.model.curGamerAuid = response[@"data"][@"curGamerAuid"];
                
                if([weakSelf.model.gameStatus isEqualToNumber:@0]){
                //显示文字为当前娃娃机空闲
                    [weakSelf.gameHeadView.curGamer setTitle:[NSString stringWithFormat:@"当前娃娃机空闲"] forState:UIControlStateNormal];
                }
                if(index==0 && [self.model.gameStatus isEqualToNumber:@301001]){
                    // 等待我开始界面
                    [weakSelf loadStartView];
                }
                if([weakSelf.model.gameStatus isEqualToNumber:@301002]){
                    // 请求queryGameDetail 接口
                    [weakSelf loadQueryGameDetail];
                }
            }
        }
    } failure:^(NSError *error) {
    }];
    
}
// 请求当前玩家信息
- (void)loadQueryGameDetail{
    
    NSDate *dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a = [dat timeIntervalSince1970] * 1000;
    NSString *timeString = [NSString stringWithFormat:@"%.0f",a];
    NSDictionary *parameters = @{@"auid":[YSAccountTool account].auid,
                                 @"jid":self.jid,
                                 @"M0":@"IMMC",
                                 @"M9":timeString};
    NSString *postUrl = [NSString stringWithFormat:@"%@%@",@"http://api1.wawazhua.com/jvvserver/",URL_QueryGameDetail];
    [BANewsNetManager getStatusWithURL:postUrl withPostText:parameters success:^(id response) {
        NSNumber *code = response[@"code"];
        if ([code isEqualToNumber:@1]){
            self.model.curGid = response[@"data"][@"curGid"];
            self.model.curGameStartTime = response[@"data"][@"curGameStartTime"];
            self.model.curGameEndTime = response[@"data"][@"curGameEndTime"];
            self.model.curGamerAuid = response[@"data"][@"curGamerAuid"];
            self.model.curGamer = response[@"data"][@"curGamer"];
            self.model.curGameExpendGold = response[@"data"][@"curGameExpendGold"];
            self.model.curGamerHoldRemainCount = response[@"data"][@"curGamerHoldRemainCount"];
            self.model.curGamerHoldExpendGold = response[@"data"][@"curGamerHoldExpendGold"];
            self.model.nextGamerAuid = response[@"data"][@"nextGamerAuid"];
            [self.gameHeadView.curGamer setTitle:[NSString stringWithFormat:@"当前玩家:%@",self.model.curGamer] forState:UIControlStateNormal];
        }
    } failure:^(NSError *error) {
    }];
}
// 房间信息初始化.
- (void)initRoomStatusWithModel:(YSRoomInfoModel *)model{
    
    int myWaittingIndex = [model.myWaittingIndex intValue];
    
    if([model.gameStatus isEqualToNumber:@0]){
        //显示文字为当前娃娃机空闲
        [self.gameHeadView.curGamer setTitle:[NSString stringWithFormat:@"当前娃娃机空闲"] forState:UIControlStateNormal];
    }
    if([model.myWaittingIndex isEqualToNumber:@-1]){//我也要玩
        [self setGameViewShow:NO withWaitViewIsShow:NO];//显示出来我也要玩这个界面
    }else if(myWaittingIndex>0){//等待队列中
        
        [self.waittingView.btnWaitingStatus setTitle:[NSString stringWithFormat:@"当前排队人数%@",model.myWaittingIndex] forState:UIControlStateNormal];
        [self setGameViewShow:NO withWaitViewIsShow:YES];//显示出来排队这个界面
        
    }else if(myWaittingIndex==0 && [model.gameStatus isEqualToNumber:@301002]){//比如退出了程序,重新进来的时候显示我正在玩
        [self setGameViewShow:YES withWaitViewIsShow:NO];//显示正在玩游戏界面并判断倒计时
        // 开始显示倒计时gameStatusRemainDuration
        
        
    }else if(myWaittingIndex==0 && [model.gameStatus isEqualToNumber:@301004]){//我正在玩,等待结果中 控制层都灰掉
        [self setGameViewShow:NO withWaitViewIsShow:NO];//显示出来排队这个界面
        self.gameControlView.userInteractionEnabled = NO;
        self.gameControlView.unEnableButton.hidden = NO;
        
        [self loadGameResult];
    }else if(myWaittingIndex==0 && [model.gameStatus isEqualToNumber:@301001]){//等待我开始玩
        //显示5.抓娃娃界面(竖屏)3.jpg 消耗的游戏币在上个界面的模型
        
    }

}

#pragma  mark  点击了我也要玩
- (void)joinButtonClick:(UIButton *)btn{
    //调用加入游戏接口URL_JoinGame
    NSDate *dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a = [dat timeIntervalSince1970] * 1000;
    NSString *timeString = [NSString stringWithFormat:@"%.0f",a];
    NSDictionary *parameters = @{@"auid":[YSAccountTool account].auid,
                                 @"jid":self.jid,
                                 @"M0":@"IMMC",
                                 @"M9":timeString};
    NSString *postUrl = [NSString stringWithFormat:@"%@%@",@"http://api1.wawazhua.com/jvvserver/",URL_JoinGame];
    [BANewsNetManager getStatusWithURL:postUrl withPostText:parameters success:^(id response) {
        NSNumber *code = response[@"code"];
        if ([code isEqualToNumber:@1]){
            NSString *myGameStatus = response[@"data"][@"myGameStatus"];
            if([myGameStatus isEqualToString:@"302002"]){ /*用户游戏状态 302002:队列中 302010:开始游戏*/
                //显示排队人数
                [self.waittingView.btnWaitingStatus setTitle:[NSString stringWithFormat:@"当前排队人数%@", self.model.myWaittingIndex] forState:UIControlStateNormal];
                [self setGameViewShow:NO withWaitViewIsShow:YES];
                
            }else if ([myGameStatus isEqualToString:@"302010"]){
                //显示等待开始倒计时界面
                //显示5.抓娃娃界面(竖屏)3.jpg 消耗的游戏币在上个界面的模型
                //点击5之后开始出现出现抓娃娃界面(竖屏)4这个界面
                self.model.curGamerAuid = [YSAccountTool account].auid;
                [self loadQueryGameDetail];
                [self loadStartView];
            }
        }
    } failure:^(NSError *error) {
    }];
}

// 点击了倒计时5秒的按钮开始霸机
- (void)bajiGameBtnClick:(UIButton *)startBtn
{
    [self.bajiView.timeButton ba_cancelTimer];//在5秒之内点击了倒计时,就关掉倒计时
    [self startGameWithIsBaji:@"1"];
}
// 加载等待我开始界面5秒倒计时开始
- (void)loadStartView
{
    self.myStartViews.hidden = NO;
    self.myStartViews.startBtn.hidden = NO;
    self.myStartViews.GoGameImage.hidden = YES;
    self.myStartViews.noGoldView.hidden= YES;
    [self.myStartViews.startBtn ba_countDownWithTimeInterval:5 countDownFormat:@" %zd "];
    [self.myStartViews.startBtn setTimeStoppedCallback:^{
        // 开始游戏按钮倒计时结束回调事件
        if(!_isGameControl){
            [self.myStartViews hiddenView];
            // 显示我还要玩界面
            [self setGameViewShow:NO withWaitViewIsShow:NO];
        }
    }];
}
// 点击了倒计时5秒的按钮
- (void)startGameBtnClick:(UIButton *)startBtn
{
    _isGameControl = YES;
    //点击了开始游戏界面
    [self startGameWithIsBaji:@"0"];
    [self.myStartViews.startBtn ba_cancelTimer];//在5秒之内点击了倒计时,就关掉倒计时
    // 开始小鸟动画界面3秒动画倒计时
    self.myStartViews.startBtn.hidden = YES;
    self.myStartViews.GoGameImage.hidden = NO;
    [self.myStartViews.GoGameBtn ba_countDownWithTimeInterval:3 countDownFormat:@" %zd "];
    [self.myStartViews.GoGameBtn setTimeStoppedCallback:^{
        // 开始游戏按钮倒计时结束回调事件
        [self.myStartViews hiddenView];
    }];
    
}
// 开始玩游戏,并且状态分为霸机或者是没有霸机
- (void)startGameWithIsBaji:(NSString *)isBaji{
    // 显示出游戏控制界面隐藏等待游戏的界面
    [self setGameViewShow:YES withWaitViewIsShow:NO];
    
    NSDate *dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a = [dat timeIntervalSince1970] * 1000;
    NSString *timeString = [NSString stringWithFormat:@"%.0f",a];
    NSDictionary *parameters = @{@"auid":[YSAccountTool account].auid,
                                 @"jid":self.jid,
                                 @"isBaji":isBaji,
                                 @"M0":@"IMMC",
                                 @"M9":timeString};
    NSString *postUrl = [NSString stringWithFormat:@"%@%@",@"http://api1.wawazhua.com/jvvserver/",URL_GameStart];
    [BANewsNetManager getStatusWithURL:postUrl withPostText:parameters success:^(id response) {
        NSNumber *code = response[@"code"];
        if ([code isEqualToNumber:@1]){
            self.model.curGid = response[@"data"][@"gid"];
            self.model.userRemainGold = response[@"data"][@"userRemainGold"];
            self.model.boxRemainTime = response[@"data"][@"boxRemainTime"];
            //[self.navView.myGold setTitle:self.model.userRemainGold forState:UIControlStateNormal];
            
            // 开始显示倒计时gameDuration
            NSString *gameDuration = self.model.gameDuration;
        }
    } failure:^(NSError *error) {
        
    }];

}

// 控制游戏操作定时器,每100ms执行
- (void)createGameControlTimer {
    
    self.gameControl_timer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(gameControlSend) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:_gameControl_timer forMode:NSRunLoopCommonModes];
}
#pragma mark XHLetouHeaderViewDelegate
// 失去焦点
- (void)gameControlBtnTouchOut:(UIButton *)controlBtn
{
    [self.gameControl_timer setFireDate:[NSDate distantFuture]];
    
}
// 按下 点击7之后,其他按钮不能操作
- (void)gameControlBtnTouchIn:(UIButton *)controlBtn
{
    NSInteger btnTag = controlBtn.tag;
    self.command = btnTag;
    if(controlBtn.tag==7){//按下了抓按钮 不需要开启定时器 其他控制按钮都置灰包括自己
        // 设置游戏控制界面都灰掉
        self.gameControlView.userInteractionEnabled = NO;
        self.gameControlView.unEnableButton.hidden = NO;
        [self gameControlSend];
        
    }else{
        // 每一百毫秒请求一次 开启定时器
        if(!isHaveGameControlTimer){
            isHaveGameControlTimer = YES;
            [self createGameControlTimer];
        }else{
            [self.gameControl_timer setFireDate:[NSDate distantPast]];
        }
    }
}
// 发送游戏控制
- (void)gameControlSend{
    
    NSString *btnTag = [NSString stringWithFormat:@"%ld",self.command];
    NSDate *dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a = [dat timeIntervalSince1970] * 1000;
    NSString *timeString = [NSString stringWithFormat:@"%.0f",a];
    NSDictionary *parameters = @{@"auid":[YSAccountTool account].auid,
                                 @"jid":self.jid,
                                 @"gid":self.model.curGid,
                                 @"command":btnTag,
                                 @"M0":@"IMMC",
                                 @"M9":timeString};
    NSString *postUrl = [NSString stringWithFormat:@"%@%@",@"http://api1.wawazhua.com/jvvserver/",URL_GameControl];
    [BANewsNetManager getStatusWithURL:postUrl withPostText:parameters success:^(id response) {
        NSNumber *code = response[@"code"];
        if ([code isEqualToNumber:@1]){
            if(self.command == 7){
                // 请求游戏结果
                [self loadGameResult];
            }
        }
    } failure:^(NSError *error) {
        
    }];
}
// 查询游戏结果
- (void)loadGameResult{
    
    NSDate *dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a = [dat timeIntervalSince1970] * 1000;
    NSString *timeString = [NSString stringWithFormat:@"%.0f",a];
    NSDictionary *parameters = @{@"auid":[YSAccountTool account].auid,
                                 @"jid":self.jid,
                                 @"gid":self.model.curGid,
                                 @"M0":@"IMMC",
                                 @"M9":timeString};
    NSString *postUrl = [NSString stringWithFormat:@"%@%@",[YSAccountTool account].server,URL_GameResult];
    BA_WEAKSELF;
    [BANewsNetManager getStatusWithURL:postUrl withPostText:parameters success:^(id response) {
        NSNumber *code = response[@"code"];
        if ([code isEqualToNumber:@1]){
            /*游戏结果 -1:游戏未结束 303001:抓取成功 303002:抓取失败*/
            NSNumber *gameResult =response[@"data"][@"gameResult"];
            
            self.model.userRemainGold = response[@"data"][@"userRemainGold"];
            self.model.boxRemainTime = response[@"data"][@"boxRemainTime"];
            
          //  [self.navView.myGold setTitle:self.model.userRemainGold forState:UIControlStateNormal];
            if([gameResult isEqualToNumber:@-1]){
                // 休眠500毫秒继续掉当前接口请求结果
                [weakSelf loadGameResult];
            }else if ([gameResult isEqualToNumber:@303001]){
                [self loadSucceedView];
            
            }else if ([gameResult isEqualToNumber:@303002]){
                
                 NSNumber *gameHoldFlag =response[@"data"][@"gameHoldFlag"];
                if([gameHoldFlag isEqualToNumber:@1]){
                    [self loadBajiView];
                }else{
                    [self loadFailView];
                }
            }
        }
    } failure:^(NSError *error) {
        
    }];
}
// 加载失败界面
- (void)loadFailView
{
    self.failView.hidden = NO;
    [self setGameViewShow:NO withWaitViewIsShow:NO];
}
// 加载霸机界面
- (void)loadBajiView
{
    self.bajiView.hidden = NO;
    [self.bajiView.timeButton ba_countDownWithTimeInterval:5 countDownFormat:@" %zd "];
    [self.bajiView.timeButton setTimeStoppedCallback:^{
        //倒计时结束 一种是5秒之内点击了游戏一种是倒计时结束没有点击都会走
        [self.bajiView hiddenView];
        // 显示失败界面
        [self loadFailView];
    }];
}
// 加载游戏成功界面
- (void)loadSucceedView
{
    self.successView.hidden = NO;
}
 //创建播放器
- (void)createPlayer{
    PLPlayerOption *option = [PLPlayerOption defaultOption];
    [option setOptionValue:@10 forKey:PLPlayerOptionKeyTimeoutIntervalForMediaPackets];
    
    //播放url
    NSURL *playUrl = [NSURL URLWithString:self.model.videoUrlA];
    //播放本地文件
    self.player = [PLPlayer playerWithURL:playUrl option:option];
    self.player.delegate = self;
    
    self.player.playerView.frame = CGRectMake(0, 64, BA_SCREEN_WIDTH, BA_SCREEN_HEIGHT-190);
    [self.view addSubview:self.player.playerView];

    self.player.delegateQueue = dispatch_get_main_queue();
    
    UIButton *timeCount = [[UIButton alloc]initWithFrame: CGRectMake(0, 100, 100, 100)];
    self.gameTime = timeCount;
    [timeCount ba_buttonSetborderColor:[UIColor whiteColor] forState:UIControlStateNormal animated:YES];
    timeCount.titleLabel.font = [UIFont systemFontOfSize:30];
    [timeCount setTitle:@"200" forState:UIControlStateNormal];
    self.gameTime.backgroundColor = [UIColor clearColor];
    timeCount.hidden = YES;
    [self.view insertSubview:timeCount aboveSubview:self.player.playerView];
    
    [self.view insertSubview:self.gameHeadView aboveSubview:self.player.playerView];
    
    [self.player play];
    
}
// 实现 <PLPlayerDelegate> 来控制流状态的变更
- (void)player:(nonnull PLPlayer *)player statusDidChange:(PLPlayerStatus)state {
    // 这里会返回流的各种状态，你可以根据状态做 UI 定制及各类其他业务操作
    // 除了 Error 状态，其他状态都会回调这个方法
    BALog(@"%d",state);
    
}

- (void)player:(nonnull PLPlayer *)player stoppedWithError:(nullable NSError *)error {
    // 当发生错误时，会回调这个方法
        BALog(@"%@",error);
}
- (void)player:(nonnull PLPlayer *)player codecError:(nonnull NSError *)error {
    // 当解码器发生错误时，会回调这个方法
    // 当 videotoolbox 硬解初始化或解码出错时
    // error.code 值为 PLPlayerErrorHWCodecInitFailed/PLPlayerErrorHWDecodeFailed
    // 播发器也将自动切换成软解，继续播放
}
- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
}
- (void)initMySubViews{
    
    YSWaWaNavView *navView = [[YSWaWaNavView alloc] init];
    navView.frame = CGRectMake(0, 0, BA_SCREEN_WIDTH, 40);
    self.navView = navView;
    navView.backgroundColor = [UIColor clearColor];
    [self.navigationItem setTitleView:self.navView];
    
    YSWaWaZhuaView *joinView = [[YSWaWaZhuaView alloc]init];
    self.joinView = joinView;
    joinView.delegate = self;
    joinView.frame = CGRectMake(0, BA_SCREEN_HEIGHT-140, BA_SCREEN_WIDTH, 140);
    [joinView.giftButton addTarget:self action:@selector(giftButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [joinView.loveButton addTarget:self action:@selector(colllectButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:joinView];
    
    YSWaWaWaittingView *waittingView = [[YSWaWaWaittingView alloc]init];
    self.waittingView = waittingView;
    self.waittingView.hidden = YES;
    waittingView.frame = CGRectMake(0, BA_SCREEN_HEIGHT-140, BA_SCREEN_WIDTH, 140);
    [self.view addSubview:waittingView];
    
    
    XHLetouHeaderView *gameControlView = [[XHLetouHeaderView alloc]init];
    gameControlView.frame = CGRectMake(0, BA_SCREEN_HEIGHT-140, BA_SCREEN_WIDTH, 140);
    self.gameControlView = gameControlView;
    gameControlView.hidden= YES;
    gameControlView.delegate = self;
    gameControlView.unEnableButton.hidden = YES;
    [self.view addSubview:gameControlView];
    
    
    UIWindow* window = [UIApplication sharedApplication].keyWindow;
    NSArray *views;
    // 点击之后弹出的纵头视图
    views = [[NSBundle mainBundle] loadNibNamed:@"YSGameSucceedView" owner:nil options:nil]; //&1
    self.successView  = [views lastObject];
    self.successView.frame = window.bounds;
    self.successView.hidden = YES;
    [window insertSubview:self.successView aboveSubview:self.view];
    
    // 点击之后弹出的霸机视图
    views = [[NSBundle mainBundle] loadNibNamed:@"YSBaJiView" owner:nil options:nil]; //&1
    self.bajiView  = [views lastObject];
    self.bajiView.frame = window.bounds;
    self.bajiView.delegate = self;
    self.bajiView.hidden = YES;
    [window insertSubview:self.bajiView aboveSubview:self.view];
    
    // 点击之后弹出的失败视图
    views = [[NSBundle mainBundle] loadNibNamed:@"YSGameFaildView" owner:nil options:nil]; //&1
    self.failView  = [views lastObject];
    self.failView.frame = window.bounds;
    //    self.bajiView.delegate = self;
    self.failView.hidden = YES;
    [window insertSubview:self.failView aboveSubview:self.view];
    
    // 点击之后弹出的开始玩游戏倒计时视图
    views = [[NSBundle mainBundle] loadNibNamed:@"XHViewController" owner:nil options:nil]; //&1
    self.myStartViews  = [views lastObject];
    self.myStartViews.frame = window.bounds;
    self.myStartViews.delegate = self;
    self.myStartViews.hidden = YES;
    [window insertSubview:self.myStartViews aboveSubview:self.view];
    
    YSWaWaHeard *gameHeadView = [[YSWaWaHeard alloc]init];
    gameHeadView.frame = CGRectMake(0, 64, BA_SCREEN_WIDTH, 40);
    self.gameHeadView = gameHeadView;
    gameHeadView.backgroundColor = [UIColor clearColor];
    
    YSMyGiftView *myGiftView = [[YSMyGiftView alloc] init];
    myGiftView.frame = CGRectMake(0, 0, BA_SCREEN_WIDTH, BA_SCREEN_HEIGHT);
    self.myGiftView = myGiftView;
    myGiftView.hidden = YES;
    [window insertSubview:myGiftView aboveSubview:self.view];
    

}
- (void)colllectButtonClick:(UIButton *)btn{
    
    NSDate *dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a = [dat timeIntervalSince1970] * 1000;
    NSString *timeString = [NSString stringWithFormat:@"%.0f",a];
    NSDictionary *parameters = @{@"auid":[YSAccountTool account].auid,
                                 @"jid":self.jid,
                                 @"collectFlag":@"0",//1 关注  0 取消关注*/
                                 @"M0":@"IMMC",
                                 @"M9":timeString};
    NSString *postUrl = [NSString stringWithFormat:@"%@%@",[YSAccountTool account].server,URL_Colllect];
    BA_WEAKSELF;
    [BANewsNetManager getStatusWithURL:postUrl withPostText:parameters success:^(id response) {
        NSNumber *code = response[@"code"];
        if ([code isEqualToNumber:@1]){
            [weakSelf.view ba_showHudWithText:response[@"msg"] hideAfterTime:2];
        }else if([code isEqualToNumber:@2]){
            [weakSelf.view ba_showHudWithText:response[@"msg"] hideAfterTime:2];
        }
    } failure:^(NSError *error) {
        
    }];
}
// 房间内娃娃详情接口被点击
- (void)giftButtonClick:(UIButton *)btn{
    BALog(@"按钮被点击");//URL_GiftDetail
    NSDate *dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a = [dat timeIntervalSince1970] * 1000;
    NSString *timeString = [NSString stringWithFormat:@"%.0f",a];
    NSDictionary *parameters = @{@"auid":[YSAccountTool account].auid,
                                 @"jid":self.jid,
                                 @"M0":@"IMMC",
                                 @"M9":timeString};
    NSString *postUrl = [NSString stringWithFormat:@"%@%@",[YSAccountTool account].server,URL_GiftDetail];
    BA_WEAKSELF;
    [BANewsNetManager getStatusWithURL:postUrl withPostText:parameters success:^(id response) {
        NSNumber *code = response[@"code"];
        if ([code isEqualToNumber:@1]){
            self.myGiftView.hidden = NO;
            NSArray *adList = [YSMyGiftModel BAMJParse:response[@"data"]];
            self.myGiftView.giftModelArray = adList;
        }else if([code isEqualToNumber:@2]){
            
            [weakSelf.view ba_showHudWithText:response[@"msg"] hideAfterTime:2];

        }
    } failure:^(NSError *error) {
        
    }];
    
}
// 设置底部游戏视图显示或者不显示
- (void)setGameViewShow:(BOOL)isShow withWaitViewIsShow:(BOOL)WaitIsShow {
    if (WaitIsShow) {   //隐藏掉这个等待游戏界面 只要WaitIsShow 是YES 其他的两个都是不显示的
        self.waittingView.hidden = !WaitIsShow;
        self.joinView.hidden = WaitIsShow;
        self.gameControlView.hidden = WaitIsShow;
    }else{ //只要这个 等待界面都是需要隐藏的
        _isGameControl = isShow;
        self.waittingView.hidden = YES;
        self.joinView.hidden = isShow;
        self.gameControlView.unEnableButton.hidden = YES;
        self.gameControlView.userInteractionEnabled = YES;
        self.gameControlView.hidden = !isShow;
    }
}
- (void)playTime{

    long long _m_countNum = [self.model.boxRemainTime longLongValue];
    if (_m_countNum <= 0) {
        _m_countNum = 0;
        [self.navView.myBoxTime setTitle:@"0" forState:UIControlStateNormal];
    }else
    {
        _m_countNum -= 1000;
    long long  ms = (_m_countNum);
    long long ss = 1000;
    long long mi = ss * 60;
    long long hh = mi * 60;
    long long dd = hh * 24;
    long long day = ms / dd;
    long long hour = (ms - day * dd) / hh;
    long long minute = (ms - day * dd - hour * hh) / mi;
    long long second = (ms - day * dd - hour * hh - minute * mi) / ss;
    
    NSString *hourStr =  [NSString stringWithFormat:@"%lld",hour];
    NSString *minuteStr =  [NSString stringWithFormat:@"%lld",minute];
    NSString *secondStr =  [NSString stringWithFormat:@"%lld",second];
    [self.navView.myBoxTime setTitle:[NSString stringWithFormat:@"%@:%@:%@",hourStr,minuteStr,secondStr] forState:UIControlStateNormal];
    }
    self.model.boxRemainTime = [NSString stringWithFormat:@"%lld",_m_countNum];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.play_timer invalidate];
    self.play_timer = nil;
    
}
- (void)dealloc{
}
@end
