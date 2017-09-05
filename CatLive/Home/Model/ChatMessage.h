//
//  ChatMessage.h
//  CatLive
//
//  Created by 平凡 on 17/8/20.
//  Copyright © 2017年 Yahaw Lee. All rights reserved.
//

#import "BaseModel.h"

@interface ChatMessage : BaseModel

@property (nonatomic,copy) NSString *chatUserId;
@property (nonatomic,copy) NSString *chatEMUserName;
@property (nonatomic,copy) NSString *chatUserNick;
@property (nonatomic,copy) NSString *chatUserImage;
@property (nonatomic,assign) NSInteger chatType;
@property (nonatomic,copy) NSString *chatContent;

@end
