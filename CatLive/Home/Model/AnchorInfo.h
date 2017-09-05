//
//  AnchorInfo.h
//  CatLive
//
//  Created by 平凡 on 17/8/13.
//  Copyright © 2017年 Yahaw Lee. All rights reserved.
//

#import <Foundation/Foundation.h>
//主播信息
@interface AnchorInfo : BaseModel

@property (nonatomic,copy) NSString *account;
@property (nonatomic,copy) NSString *activeCode;
@property (nonatomic,copy) NSString *anchorCode;
@property (nonatomic,copy) NSString *avatar;
@property (nonatomic,copy) NSString *background;
@property (nonatomic,copy) NSString *brithday;
@property (nonatomic,assign) BOOL certification;
@property (nonatomic,copy) NSString *city;
@property (nonatomic,copy) NSString *createAt;
@property (nonatomic,assign) NSInteger diamonds;//钻石
@property (nonatomic,copy) NSString *district;
@property (nonatomic,copy) NSString *email;
@property (nonatomic,assign) NSInteger follow;
@property (nonatomic,assign) NSInteger gender;
@property (nonatomic,assign) NSInteger anchorId;
@property (nonatomic,copy) NSString *invitationCode;
@property (nonatomic,copy) NSString *latitude;
@property (nonatomic,assign) NSInteger level;
@property (nonatomic,copy) NSString *longitude;
@property (nonatomic,copy) NSString *nickname;
@property (nonatomic,assign) NSInteger onlineStatus;
@property (nonatomic,copy) NSString *password;
@property (nonatomic,assign) NSString *phone;
@property (nonatomic,assign) NSInteger popularity;
@property (nonatomic,assign) NSInteger profit;//收益
@property (nonatomic,assign) NSString *province;
@property (nonatomic,assign) NSInteger userType;
@property (nonatomic,assign) NSInteger videoMaxPrice;
@property (nonatomic,assign) NSInteger videoPrice;
@property (nonatomic,assign) NSInteger voiceMaxPrice;
@property (nonatomic,assign) NSInteger voicePrice;


- (instancetype)initWithDictionary:(NSDictionary *)dic;


@end
