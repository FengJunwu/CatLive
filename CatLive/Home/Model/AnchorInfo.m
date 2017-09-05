//
//  AnchorInfo.m
//  CatLive
//
//  Created by 平凡 on 17/8/13.
//  Copyright © 2017年 Yahaw Lee. All rights reserved.
//

#import "AnchorInfo.h"

@implementation AnchorInfo

- (instancetype)initWithDictionary:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        _account = [dic safeStringForKey:@"account"];
        _activeCode = [dic safeStringForKey:@"activeCode"];
        _anchorCode = [dic safeStringForKey:@"anchorCode"];
        _avatar = [dic safeStringForKey:@"avatar"];
        _background = [dic safeStringForKey:@"background"];
        _brithday = [dic safeStringForKey:@"brithday"];
        _certification = [dic safeBoolForKey:@"certification"];
        _city = [dic safeStringForKey:@"city"];
        _createAt = [dic safeStringForKey:@"createAt"];
        _diamonds = [dic safeIntegerForKey:@"diamonds"];
        _district = [dic safeStringForKey:@"district"];
        _email = [dic safeStringForKey:@"email"];
        _follow = [dic safeIntegerForKey:@"follow"];
        _gender = [dic safeIntegerForKey:@"gender"];
        _anchorId = [dic safeIntegerForKey:@"id"];
        _invitationCode = [dic safeStringForKey:@"invitationCode"];
        _latitude = [dic safeStringForKey:@"latitude"];
        _level = [dic safeIntegerForKey:@"level"];
        _longitude = [dic safeStringForKey:@"longitude"];
        _nickname = [dic safeStringForKey:@"nickname"];
        _onlineStatus = [dic safeIntegerForKey:@"onlineStatus"];
        _password = [dic safeStringForKey:@"password"];
        _phone = [dic safeStringForKey:@"phone"];
        _popularity = [dic safeIntegerForKey:@"popularity"];
        _profit = [dic safeIntegerForKey:@"profit"];
        _province = [dic safeStringForKey:@"province"];
        _userType = [dic safeIntegerForKey:@"userType"];
        _videoMaxPrice = [dic safeIntegerForKey:@"videoMaxPrice"];
        _videoPrice = [dic safeIntegerForKey:@"videoPrice"];
        _voiceMaxPrice = [dic safeIntegerForKey:@"voiceMaxPrice"];
        _voicePrice = [dic safeIntegerForKey:@"voicePrice"];
    }
    return self;
}

@end
