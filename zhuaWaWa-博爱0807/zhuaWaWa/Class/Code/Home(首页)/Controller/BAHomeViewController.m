#import "BAHomeViewController.h"
#import "SDCycleScrollView.h"
#import "DemoVC10_CollectionView.h"
#import "DemoVC10Cell.h"
#import "PLPlayerViewController.h"

#import "BAProfileViewController.h"

#import "BANewsNetManager.h"
#import "BAURLsPath.h"
#import "YSWaWaModel.h"
#import "YSMainModel.h"
#import "YSRoomTypeModel.h"
#import "YSAdList.h"
#import "BAHomeMoneyView.h"
#import "PopListTableViewController.h"
#import "YSRoomTypeModel.h"

#import "YSHomeNavView.h"
#define inputW 230 // 输入框宽度
#define inputH 35  // 输入框高度
@interface BAHomeViewController ()<UIScrollViewDelegate,SDCycleScrollViewDelegate,AccountDelegate>
{
    int page;
    YSHomeNavView *_homeNav;
    NSString *order_sn ;

}
@property (nonatomic, strong) SDCycleScrollView *myHeadView; // 轮播view

@property (nonatomic, strong) NSMutableArray *dataList;
@property (nonatomic, strong) DemoVC10_CollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIView *myScrollView;

@property (weak, nonatomic) IBOutlet UIButton *baoxiangTime;

@property (weak, nonatomic) IBOutlet UIButton *myGold;

@property (nonatomic, strong) NSTimer  *myGold_timer;

@property (nonatomic, strong) YSMainModel *modelArray;

@property (nonatomic, strong) BAHomeMoneyView *moneyView;

@property (nonatomic, strong) BAAlert *tempView;

/**
 * 账号数据
 */
@property (nonatomic) NSMutableArray *dataSource;

/**
 * 房间分类按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *curAccount;


/**
 *  当前选中账号
 */
@property (nonatomic, strong) id curAcc;

/**
 * 当前账号头像
 */
@property (nonatomic, copy) UIImageView *icon;

/**
 *  账号下拉列表
 */
@property (nonatomic, strong) PopListTableViewController *accountList;

/**
 *  下拉列表的frame
 */
@property (nonatomic) CGRect listFrame;
@end

@implementation BAHomeViewController


- (void)ba_base_viewWillAppear
{
    self.collectionView.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)ba_base_setupUI
{
    [self setupLayout];
    self.collectionView.dataArray = self.dataList;
    [self setMyNavView];
}
- (void)setMyNavView{
    _homeNav = [[YSHomeNavView alloc] init];
    self.navigationItem.titleView = _homeNav;
}
/**
 * 设置下拉菜单
 */
- (void)setPopMenu {
    
    // 默认当前账号为已有账号的第一个
    YSRoomTypeModel *acc = _dataSource[0];
    [_curAccount setTitle:acc.typeName forState:UIControlStateNormal];
    // 字体
    [_curAccount setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _curAccount.titleLabel.font = [UIFont systemFontOfSize:12.0];
    // 边框
    _curAccount.layer.borderWidth = 0.5;
    
    [_curAccount addTarget:self action:@selector(openAccountList) forControlEvents:UIControlEventTouchUpInside];
    // 1.2图标
    _icon = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, inputH-10, inputH-10)];
    _icon.layer.cornerRadius = (inputH-10)/2;
    [_icon setImage:[UIImage imageNamed:acc.typePic]];
    [_curAccount addSubview:_icon];
   
    // 1.3下拉菜单弹出按钮
    UIButton *openBtn = [[UIButton alloc]initWithFrame:CGRectMake(_curAccount.width-32, -5, inputH, inputH)];
    [openBtn addTarget:self action:@selector(openAccountList) forControlEvents:UIControlEventTouchUpInside];
    [_curAccount addSubview:openBtn];
    
    // 2.设置账号弹出菜单(最后添加显示在顶层)
    _accountList = [[PopListTableViewController alloc] init];
    // 设置弹出菜单的代理为当前这个类
    _accountList.delegate = self;
    // 数据
    _accountList.accountSource = _dataSource;
    // 初始化frame
    [self updateListH];
    // 隐藏下拉菜单
    _accountList.view.frame = CGRectZero;
    // 将下拉列表作为子页面添加到当前视图，同时添加子控制器
    [self addChildViewController:_accountList];
    [self.view addSubview:_accountList.view];
}

/**
 *  监听代理更新下拉菜单
 */
- (void)updateListH {
    CGFloat listH;
    // 数据大于3个现实3个半的高度，否则显示完整高度
    if (_dataSource.count > 3) {
        listH = inputH * 3.5;
    }else{
        listH = inputH * _dataSource.count;
    }
    _listFrame = CGRectMake(_curAccount.superview.frame.origin.x, _curAccount.superview.frame.origin.y + _curAccount.frame.size.height +10, _curAccount.width, listH);
    _accountList.view.frame = _listFrame;
}
/**
 * 弹出关闭账号选择列表
 */
- (void)openAccountList {
    _accountList.isOpen = !_accountList.isOpen;
    if (_accountList.isOpen) {
        _accountList.view.frame = _listFrame;
    }else {
        _accountList.view.frame = CGRectZero;
    }
}
/**
 * 监听代理选定cell获取选中账号
 */
- (void)selectedCell:(NSInteger)index {
    // 更新当前选中账号
    YSRoomTypeModel *acc = _dataSource[index];
    [_icon setImage:[UIImage imageNamed:acc.typePic]];
    [_curAccount setTitle:acc.typeName forState:UIControlStateNormal];
    // 关闭菜单
    [self openAccountList];
}

- (void)createTimer {
    
    self.myGold_timer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(timerEvent) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:_myGold_timer forMode:NSRunLoopCommonModes];
}

// b宝箱的倒计时
- (void)timerEvent {
    [self countDown];
}
- (void)countDown {

    BAUserModel *model = self.modelArray.userDic;
    long long _m_countNum = [model.boxRemainTime longLongValue];
    if (_m_countNum <= 0) {
        _m_countNum = 0;
    }else
    {
        _m_countNum -= 1000;
    }
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

    [self.baoxiangTime setTitle:[NSString stringWithFormat:@"%@:%@:%@",hourStr,minuteStr,secondStr] forState:UIControlStateNormal];
    BALog(@"boxRemainTime%@",model.boxRemainTime);
    model.boxRemainTime = [NSString stringWithFormat:@"%lld",_m_countNum];
    self.modelArray.userDic = model;
}

- (void)setupLayout
{
    self.collectionView.hidden = NO;
    /*! 添加上下拉刷新 */
    [self setupRefreshView];
}
#pragma mark - ***** 添加上下拉刷新
- (void)setupRefreshView
{
    BA_WEAKSELF;
    // 设置回调（一旦进入刷新状态就会调用这个refreshingBlock）
        [self.collectionView.collectionView ba_addHeaderRefresh:^{
            [weakSelf loadNewData];
        }];
    // 马上进入刷新状态
    [self.collectionView.collectionView.mj_header beginRefreshing];
    
    // 设置回调（一旦进入刷新状态就会调用这个refreshingBlock）
    [self.collectionView.collectionView ba_addFooterRefresh:^{
        [weakSelf loadMoreData];
    }];
    
    self.collectionView.collectionView.mj_footer.automaticallyHidden = true;
}


- (void)loadNewData
{
    [self getDataWithHead:YES];
}

- (void)loadMoreData
{
    [self getDataWithHead:NO];
}

#pragma mark - *****  接口数据
- (void)getDataWithHead:(BOOL)isHead
{
    if (isHead)
    {
        page = 1;
    }
    else
    {
        if (page < 2)
        {
            page = 2;
        }
    }
    //URL_roomList
    NSDate *dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a = [dat timeIntervalSince1970] * 1000;
    NSString *timeString = [NSString stringWithFormat:@"%.0f",a];
    NSDictionary *parameters = @{@"auid":[YSAccountTool account].auid,
                                 @"M0":@"IMMC",
                                 @"M9":timeString};
    NSString *postUrl = [NSString stringWithFormat:@"%@%@",[YSAccountTool account].server,URL_Main];
    BA_WEAKSELF;
    [BANewsNetManager getStatusWithURL:postUrl withPostText:parameters success:^(id response) {
        
        if (isHead)
        {
            [weakSelf.collectionView.collectionView.mj_header endRefreshing];
        }
        else
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf.collectionView.collectionView.mj_footer endRefreshing];
            });
        }
        
            if(response)
            {
                YSMainModel *modelArray = [[YSMainModel alloc] init];
                modelArray.adList = [YSAdList BAMJParse:response[@"data"][@"adList"]];
                modelArray.roomList = [YSWaWaModel BAMJParse:response[@"data"][@"roomList"]];
                modelArray.roomType = [YSRoomTypeModel BAMJParse:response[@"data"][@"roomType"]];
                BAUserModel *model = [BAUserModel BAMJParse:response[@"data"][@"userInfo"]];
                [self.myGold setTitle:model.userRemainGold forState:UIControlStateNormal];
                modelArray.userDic = model;
                self.modelArray = modelArray;
                [self createTimer];//初始化宝箱定时器
                
                if (isHead){
                    [weakSelf.dataList removeAllObjects];
                    weakSelf.collectionView.dataArray = modelArray.roomList;
                }else page++;
                
                NSArray *array = (NSArray *)modelArray.roomList;
                [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    [weakSelf.dataList addObject:obj];
                    weakSelf.collectionView.dataArray = weakSelf.dataList;
                    
                }];
                NSArray *adListArray = (NSArray *)modelArray.adList;
                NSMutableArray *imageArray = @[].mutableCopy;
                [adListArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    YSAdList *adList =(YSAdList *)obj;
                    [imageArray addObject:adList.pic];
                }];
                _dataSource = modelArray.roomType;
                
                [self setPopMenu];
                
                [self setMyScrollviewWith:imageArray];
                
                [GCDQueue executeInMainQueue:^{
                    weakSelf.collectionView.collectionView.contentOffset = CGPointZero;
                    [weakSelf.collectionView.collectionView reloadData];
                }];
            }
            else
            {
                if (page > 1)
                {
                    [(MJRefreshAutoGifFooter *)weakSelf.collectionView.collectionView.mj_footer setTitle:@"空空如也" forState:MJRefreshStateIdle];
                }
                else
                {
                    [(MJRefreshAutoGifFooter *)weakSelf.collectionView.collectionView.mj_footer setTitle:@"" forState:MJRefreshStateIdle];
                }
            }
    } failure:^(NSError *error) {
        
    }];

}

- (void)setMyScrollviewWith:(NSArray *)urlArray{
    self.cycleScrollView = [self setupUploadViewWithFrame:CGRectMake(0, 0, BA_SCREEN_WIDTH, 200)  imageUrlsArray:urlArray withBlock:^(NSInteger index) {
        BALog(@"点击了%d",index);
        
    }];
    self.cycleScrollView.infiniteLoop = YES;
    self.cycleScrollView.autoScroll = YES;
    self.cycleScrollView.currentPageDotImage = [UIImage imageNamed:@"change-point.png"];
    self.cycleScrollView.pageDotImage = [UIImage imageNamed:@"point.png"];
    [self.myScrollView addSubview:self.cycleScrollView];
}
- (IBAction)account:(id)sender {
    BAProfileViewController *profile = [[BAProfileViewController alloc] init];
    [self.navigationController pushViewController:profile animated:YES];
    
}

// 点击充值
- (void)creatMoenyView{
    BAHomeMoneyView *moneyVie = [[BAHomeMoneyView alloc] init];
    self.moneyView  = moneyVie;
    self.moneyView.frame = CGRectMake(0, 0, BA_SCREEN_WIDTH, BA_SCREEN_HEIGHT);
    BAKit_SharedApplication.keyWindow.backgroundColor = BAKit_Color_Translucent;
    [BAKit_SharedApplication.keyWindow addSubview:self.moneyView];
}

#pragma mark - ***** setter / getter
- (DemoVC10_CollectionView *)collectionView
{
    if (!_collectionView)
    {
        BAKit_WeakSelf
        _collectionView = [[DemoVC10_CollectionView alloc] initWithFrame:CGRectZero withblock:^(UICollectionView *collection, NSIndexPath *indexPath, YSWaWaModel *model) {
            
            BAKit_StrongSelf
            
            [self.tempView ba_alertHidden];

            // 判断是否可以进入房间. model.roomId
            [self isCanGoRoomWithRoomId:model];

        }];
        [self.view addSubview:_collectionView];
        
        _collectionView.sd_layout.spaceToSuperView(UIEdgeInsetsMake(200, 0, 60, 0));
        
    }
    return _collectionView;
}

- (void)isCanGoRoomWithRoomId:(YSWaWaModel *)model{
    
    NSDate *dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a = [dat timeIntervalSince1970] * 1000;
    NSString *timeString = [NSString stringWithFormat:@"%.0f",a];
    NSDictionary *parameters = @{@"auid":@"201706070000000010000000003",
                                 @"jid":model.jid,
                                 @"M0":@"IMMC",
                                 @"M9":timeString};
    NSString *postUrl = [NSString stringWithFormat:@"%@%@",@"http://api1.wawazhua.com/jvvserver/",URL_EnterRoomCheck];

    [BANewsNetManager getStatusWithURL:postUrl withPostText:parameters success:^(id response) {
        NSNumber *code = response[@"code"];
        if ([code isEqualToNumber:@1]){
            PLPlayerViewController *player = [[PLPlayerViewController alloc] init];
            player.jid = model.jid;
            [self.navigationController pushViewController:player animated:YES];
        }
        
    } failure:^(NSError *error) {
        
    }];
}
// 充值按钮被点击
- (IBAction)topUpClick:(UIButton *)sender {
    
    [self creatMoenyView];
    
//    NSDate *dat = [NSDate dateWithTimeIntervalSinceNow:0];
//    NSTimeInterval a = [dat timeIntervalSince1970] * 1000;
//    NSString *timeString = [NSString stringWithFormat:@"%.0f",a];
//    NSDictionary *parma = @{@"auid":[YSAccountTool account].auid,
//                            @"dataid":@"1",
//                            @"payType":@"204001",/*充值支付方式 204001 微信 204002 支付宝*/
//                            @"amount":@"微信支付",//充值金额
//                            @"M0":@"IMMC",
//                            @"M9":timeString,
//                             };
//    NSString *postUrl = [NSString stringWithFormat:@"%@%@",[YSAccountTool account].server,URL_PayApply];
//    
//    [BANewsNetManager getStatusWithURL:postUrl withPostText:parma success:^(id response) {
//        [self ByWeiXinBuy:[response objectForKey:@"data"]];
//    } failure:^(NSError *error) {
//        
//    }];
}
-(void)GZPay:(UIButton *)sender{
    if (sender.tag == 111) {
        NSDictionary *parma = @{@"user_id":@"209",
                                @"amount":@"1",
                                @"money":@"0.1",
                                @"payment":@"支付宝支付"
                                };
        NSString *url = @"http://www.88meichou.com/api/alipay/getPayment.php";
        [BANewsNetManager getStatusWithURL:url withPostText:parma success:^(id response) {
            order_sn = [response objectForKey:@"order_sn"];
            [self buyproduct];
        } failure:^(NSError *error) {
        }];
        
    }else if (sender.tag == 112) {
        NSDictionary *parma1 = @{@"auid":[YSAccountTool account].auid,
                                 @"amount":@"1",
                                 @"money":@"0.1",
                                 @"payment":@"微信支付"
                                 };
    NSString *postUrl = [NSString stringWithFormat:@"%@%@",[YSAccountTool account].server,URL_PayApply];
        [BANewsNetManager getStatusWithURL:postUrl withPostText:parma1 success:^(id response) {
            
            [self ByWeiXinBuy:response[@"data"]];
        } failure:^(NSError *error) {
            
        }];

        
    }else{
        NSString *str =  [NSString stringWithFormat:@"http://www.88meichou.com/share.php?id=%@",@"836"];
        NSString *shareText = [NSString stringWithFormat:@"%@ 我为自己代言",@"刚子"];
        NSString  *ShareTitle = [NSString stringWithFormat:@"%@,%@",@"刚子",@"友盟分享功能实现"];
        NSString *urlSrt = [NSString stringWithFormat:@"%@",str];
        BAShareManage *manger = [BAShareManage ba_shareManage];
        
        manger.shareTitle = ShareTitle ;
        manger.shareText = shareText ;
        manger.shareImageUrl = @"http://tupian.enterdesk.com/2012/0606/gha/10/11285966_1334673509285.jpg" ;
        manger.shareWebpageUrl = urlSrt ;
        
        [manger ba_shareListWithShareType:BAUM_SHARE_TYPE_WEB_LINK viewController:self];
    }
    
}

-(void)buyproduct{
    //四美坊app商户ID 用户ID 私钥
    NSString *pid = @"2088421263479877";
    NSString *appID = @"2016092201949956";
    NSString *privateKey = @"MIICeAIBADANBgkqhkiG9w0BAQEFAASCAmIwggJeAgEAAoGBALhNuoy6DrIF27wxQXT1JarZIhCleLbGZIKi/xLGb0KMP6m9xP17GJ0asqhDqIPQOos2vmwmeA8ast2gQQWzbtaKMyqsrxQgrlTvYomwo3579JwOS29wgpjAWn2YQ9t3YGlECpFtoX3KtyJ7JPhtTcfJqPpHiNFjujmPCU83s9qJAgMBAAECgYAw4y1gttm/Dx7CRK6AP6bGMuJ+V+Y1VVrD7EiMymYo2NrqQ5RFSKm2wqYxTAEfNdTRqKvKNEoUd5iKgT++K2JywugECubbv/2hSzUqsr1VhQ/buzIwSTTPFJHrG2WSL+c8hqgsxk3Fn79vKarRnPdYj7r+7xZ43uwfxx/mzaXnoQJBANtyF6P8vjJLazCwrX+bg7CS447c/38Nsai6CTOr4GyvEzd+sIUkFahTGzk83qBdU4ksMGfGrv7Bwvk5X2c4AcMCQQDXAQ9067qOtGsWXiDgNqDe2+CgNotXwhBOKGlbv3t9xYi89K2u9hqIz3yUWBbbxOaolCJvpFREJV4mmtXQiEHDAkEAr1tijMZg7ivaQhRM8FXDTAx1DyqGeG7m8t+GjuXf9rmIb6YrRJlrPRD8Bicf96HcKRdIrwTTvfvz49f25rKYpQJBAK+OvRlCdlWZ+isMdxm9YYQ30+XeQ89Htdqr4sO4ydQ73Fg2Di/j4my9x0K13wxabeFO/ANfEjOGs6cgHOCmsdMCQQCNyYE6MloO1xaHkFIRuzMjUJB94Wkaip/DzZE5a/vIsm6mk6JcaPDCGAm2yf2xd6f/1y0WViaSLv6jLcdwZCZ8";
    //pid和appID获取失败,提示
    if ([pid length] == 0 ||
        [appID length] == 0 ||
        [privateKey length] == 0)
    {
//        [self.view gz_showAlertView:@"提示" message:@"缺少pid或者appID或者私钥。"];
        return ;
    }
    /*
     *生成订单信息及签名
     */
    Order* order = [Order new];
    //将商品信息赋予AlixPayOrder的成员变liang
    // NOTE: app_id设置
    order.app_id = appID;
    order.notify_url  = @"http://www.88meichou.com/api/alipay/alipay.php";
    order.biz_content.seller_id = pid ;
    
    // NOTE: 支付接口名称
    order.method = @"alipay.trade.app.pay";
    // NOTE: 参数编码格式
    order.charset = @"utf-8";
    // NOTE: 当前时间点
    NSDateFormatter* formatter = [NSDateFormatter new];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    order.timestamp = [formatter stringFromDate:[NSDate date]];
    
    // NOTE: 支付版本
    order.version = @"1.0";
    
    // NOTE: sign_type设置
    order.sign_type = @"RSA";
    // NOTE: 商品数据
    order.biz_content = [BizContent new];
    order.biz_content.body = @"刚子支付Demo";
    order.biz_content.subject = [NSString stringWithFormat:@"购买%@美豆",@"1"];
    order.biz_content.out_trade_no = order_sn ;
    //    order.biz_content.out_trade_no = [self generateTradeNO]; //订单ID（由商家自行制定）
    order.biz_content.timeout_express = @"30m"; //超时时间设置
    //    order.biz_content.total_amount = [NSString stringWithFormat:@"%.2f",0.01];
    
    order.biz_content.total_amount = [NSString stringWithFormat:@"%@", @"0.1"]; //商品价格
    //将商品信息拼接成字符串
    NSString *orderInfo = [order orderInfoEncoded:NO];
    NSString *orderInfoEncoded = [order orderInfoEncoded:YES];
    //    NSLog(@"orderSpec = %@",orderInfo);
    
    // NOTE: 获取私钥并将商户信息签名，外部商户的加签过程请务必放在服务端，防止公私钥数据泄露；
    //       需要遵循RSA签名规范，并将签名字符串base64编码和UrlEncode
    id<DataSigner> signer = CreateRSADataSigner(privateKey);
    NSString *signedString = [signer signString:orderInfo];
    
    // NOTE: 如果加签成功，则继续执行支付
    if (signedString != nil) {
        //应用注册scheme,在AliSDKDemo-Info.plist定义URL types
        NSString *appScheme = @"ap2016092201949956";
        
        // NOTE: 将签名成功字符串格式化为订单字符串,请严格按照该格式
        NSString *orderString = [NSString stringWithFormat:@"%@&sign=%@",
                                 orderInfoEncoded, signedString];
        //          NSLog(@"~~~~~~~~~~~!!~~~~~~~~~~%@",orderString);签名
        // NOTE: 调用支付结果开始支付
        [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
            // NSLog(@"reslut = %@",resultDic);
            NSString * str = resultDic[@"memo"];
            // NSLog(@"~~~~~!!~~%@",str);
            NSString *result = resultDic[@"resultStatus"];
            if ([result isEqualToString:@"9000"]) {
#pragma 回掉函数
            }
        }];
        
        
    }
}


-(void)ByWeiXinBuy:(NSDictionary *)dict{
    
    [self weXinAplyPayOrderName:@"linda支付Demo" PayPrice:dict];
    
}

#pragma mark--微信支付
-(void)weXinAplyPayOrderName:(NSString *)OrderName PayPrice:(NSDictionary *)PayPrice{
    
    if (![WXApi isWXAppInstalled]) {
      //  [self.view gz_showAlertView:@"温馨提示" message:@"未检测到客户端，请安装"];
    }else{
            [self sendRepweixin:PayPrice];//提交支付
    }
}
-(void)sendRepweixin:(NSDictionary *)dict{
    NSMutableString *stamp  = [dict objectForKey:@"timestamp"];
    //调起微信支付
    PayReq* req             = [[PayReq alloc] init];
    req.openID              = [dict objectForKey:@"appid"];
    req.partnerId           = [dict objectForKey:@"partnerid"];
    req.prepayId            = [dict objectForKey:@"prepayid"];
    req.nonceStr            = [dict objectForKey:@"noncestr"];
    req.timeStamp           = stamp.intValue;
    req.package             = [dict objectForKey:@"package"];
    req.sign                = [dict objectForKey:@"sign"];
    [WXApi sendReq:req];
}
- (NSMutableArray *)dataList
{
    if (!_dataList) {
        _dataList = @[].mutableCopy;
    }
    return _dataList;
}


@end
