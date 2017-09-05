//
//  UserInfoModel.h
//  CatLive
//
//  Created by 平凡 on 17/8/15.
//  Copyright © 2017年 Yahaw Lee. All rights reserved.
//

#import "BaseModel.h"

@interface UserInfoModel : BaseModel


@property (nonatomic,copy) NSString *account;
@property (nonatomic,copy) NSString *activeCode;
@property (nonatomic,copy) NSString *anchorCode;
@property (nonatomic,copy) NSString *avatar;
@property (nonatomic,copy) NSString *background;
@property (nonatomic,copy) NSString *brithday;
@property (nonatomic,assign) BOOL certification;
@property (nonatomic,copy) NSString *city;
@property (nonatomic,copy) NSString *createAt;
@property (nonatomic,assign) NSInteger diamonds;
@property (nonatomic,copy) NSString *district;
@property (nonatomic,copy) NSString *email;
@property (nonatomic,assign) NSInteger follow;
@property (nonatomic,assign) NSInteger gender;
@property (nonatomic,assign) NSInteger userId;
@property (nonatomic,copy) NSString *invitationCode;
@property (nonatomic,copy) NSString *latitude;
@property (nonatomic,assign) NSInteger level;
@property (nonatomic,copy) NSString *longitude;
@property (nonatomic,copy) NSString *nickname;
@property (nonatomic,assign) NSInteger onlineStatus;
@property (nonatomic,copy) NSString *password;
@property (nonatomic,assign) NSString *phone;
@property (nonatomic,assign) NSInteger popularity;
@property (nonatomic,assign) NSInteger profit;
@property (nonatomic,assign) NSString *province;
@property (nonatomic,assign) NSInteger userType;
@property (nonatomic,assign) NSInteger videoMaxPrice;
@property (nonatomic,assign) NSInteger videoPrice;
@property (nonatomic,assign) NSInteger voiceMaxPrice;
@property (nonatomic,assign) NSInteger voicePrice;

@property (nonatomic,copy) NSString *EMUserName;//环信登录账号
@property (nonatomic,copy) NSString *EMUserPass;//环信登录密码
@property (nonatomic,assign) BOOL isFirstRegister;//是否是初次注册







- (instancetype)initWithDictionary:(NSDictionary *)dic;


@end
