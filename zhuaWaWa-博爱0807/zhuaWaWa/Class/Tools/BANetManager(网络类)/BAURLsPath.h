//
//  BAURLsPath.h
//  BABaseProject
//
//  Created by apple on 16/1/13.
//  Copyright © 2016年 博爱之家. All rights reserved.
//

#ifndef BAURLsPath_h
#define BAURLsPath_h

#if DEBUG
#define NET_HEADER    @"http://api1.wawazhua.com/jvvserver/"
#else
#define NET_HEADER    @"http://m100.melepark.com:8033/pbmedi/" // 苹果的正式平台
#endif


#define URL_Login @"http://api1.wawazhua.com/jvvserver/HIService.y?cmd=loginByWX"
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

#define URL_MyAddressList @"UserService.y?cmd=myAddressList"

#define URL_PayApply  @"PayService.y?cmd=payApply"//支付









#endif /* BAURLsPath_h */
