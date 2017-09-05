//
//  MeViewController.h
//  CatLive
//
//  Created by 平凡 on 17/8/12.
//  Copyright © 2017年 Yahaw Lee. All rights reserved.
//

#import "BaseViewController.h"

typedef NS_ENUM(NSUInteger, MeCellType) {
    MeCellTypeAccount,//账户充值
    MeCellTypeEarnings,//我的收益
    MeCellTypeInvite,//邀请赚钱
    MeCellTypeBeHost,//成为主播
    MeCellTypeSetting//设置
};


@interface MeViewController : BaseViewController


@end
