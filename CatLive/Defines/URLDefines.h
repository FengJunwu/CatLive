//
//  URLDefines.h
//  CatLive
//
//  Created by 平凡 on 17/8/10.
//  Copyright © 2017年 Yahaw Lee. All rights reserved.
//

#ifndef URLDefines_h
#define URLDefines_h






#define APIPopularPage @"user/getPopularPage"//获取热门列表


//登录和用户信息

#define APIAuthCode @"account/getVerifyCode"//获取验证码
#define APIUserLogIn @"account/login"//用户登录接口
#define APIUpdateInfo @"account/updateInfo"//更新用户信息



#define APIUserAttention @"user/getFoucsOnPage"//用户关注列表



//消息
#define APIMessageUnRead @"msg/getUuRead"//获取用户未读消息
#define APIMessageUnReadCount @"msg/getUuReadCount"//获取用户未读消息数
#define APIMessageList @"msg/getMsgList"//用户消息列表


#define APIFeedback @"feedback/AddFeedbackTab"//问题反馈
































#endif /* URLDefines_h */
