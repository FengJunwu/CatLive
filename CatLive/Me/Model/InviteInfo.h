//
//  InviteInfo.h
//  CatLive
//
//  Created by 平凡 on 17/8/22.
//  Copyright © 2017年 Yahaw Lee. All rights reserved.
//

#import "BaseModel.h"

@interface InviteInfo : BaseModel

@property (nonatomic,copy) NSString *userImage;
@property (nonatomic,copy) NSString *userNick;
@property (nonatomic,assign) NSInteger inviteTime;
@property (nonatomic,assign) NSInteger earnning;//收益

@property (nonatomic,copy) NSString *timeStr;//2017-08-20 13:14
@end
