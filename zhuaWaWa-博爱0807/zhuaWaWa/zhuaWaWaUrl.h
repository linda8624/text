
//
//  zhuaWaWaUrl.h
//  zhuaWaWa
//
//  Created by linda on 2017/7/28.
//  Copyright © 2017年 boai. All rights reserved.
//

#ifndef zhuaWaWaUrl_h
#define zhuaWaWaUrl_h


#define URL_LoginByWX @"http://api1.wawazhua.com/jvvserver/HIService.y?cmd=loginByWX"// 微信登录

#define URL_Login @"http://api1.wawazhua.com/jvvserver/HIService.y?cmd=login"// 手机号登录

#define URL_SendCodeToPhone @"http://api1.wawazhua.com/jvvserver/HIService.y?cmd=sendCodeToPhone" //发送验证码

#define URL_Main @"MainService.y?cmd=main"

#define URL_roomList @"JRoomService.y?cmd=roomList"

#define URL_EnterRoomCheck @"JRoomService.y?cmd=enterRoomCheck"
#define URL_RoomGameInfo @"JRoomService.y?cmd=roomGameInfo"
#define URL_JoinGame @"GameService.y?cmd=join"

#define URL_QueryRoomStatus @"JRoomService.y?cmd=queryRoomStatus"

#define URL_QueryGameDetail @"JRoomService.y?cmd=queryGameDetail"


#define URL_GameStart @"GameService.y?cmd=start" //开始（霸机）游戏接口

#define URL_GameControl @"GameService.y?cmd=control"

#define URL_GameResult @"GameService.y?cmd=gameResult"

#define URL_MyGiftList @"GiftService.y?cmd=myGiftList"//我的奖品列表接口

#define URL_MyAddressList @"UserService.y?cmd=myAddressList"// 我的地址列表

#define URL_AddOrEditAddress @"UserService.y?cmd=addOrEditAddress"//添加（修改）地址接口

#define URL_DelAddress @"UserService.y?cmd=delAddress" //删除地址接口

#define URL_MyBoxList @"GBoxService.y?cmd=myBoxList" //我的宝箱列表显示接口

#define URL_OpenBox @"GBoxService.y?cmd=openBox" //打开宝箱接口

#define URL_UserInfo @"UserService.y?cmd=userInfo" //我的账户信息接口

#define URL_AddOrder @"OrderService.y?cmd=addOrder" // 申请邮寄奖品接口

#define URL_GiftDetail @"JRoomService.y?cmd=detail" // 房间内娃娃详情接口

#define URL_Colllect @"JRoomService.y?cmd=colllect" //关注房间（取消关注）接口

#define URL_Chargelist @"UserService.y?cmd=chargelist" //充值金额列表显示接口

#endif /* zhuaWaWaUrl_h */
