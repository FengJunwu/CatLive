//
//  CLChatManager.h
//  CatLive
//
//  Created by 平凡 on 17/8/19.
//  Copyright © 2017年 Yahaw Lee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Hyphenate/Hyphenate.h>
#import "CLChatViewController.h"
#import "ChatMessage.h"


typedef void(^ChatResultBlock)(EMMessage *messgae,EMError *error);

@interface CLChatManager : NSObject

@property (nonatomic,strong) HomeViewController *homeVC;


+ (CLChatManager *)manager;

- (void)showChatVC;


#pragma mrak - 会话与消息
- (EMConversation *)creatAndGetConversationWithUserId:(NSString *)userId;//获取一个会话，没有时则进行创建
- (NSArray *)getAllConversation;//获取所有的会话列表


- (void)deleteConversationWithUserId:(NSString *)userId andIsDeleteMessages:(BOOL)isDelete;//删除会话与消息

- (void)sendMessageWithChatUser:(NSString *)userId andContent:(NSString *)content andOtherInfo:(NSDictionary *)extInfo andResult:(ChatResultBlock)result;//发送文字聊天消息

- (void)sendImageMessageWithChatUser:(NSString *)userId andImageData:(NSData *)data andOtherInfo:(NSDictionary *)extInfo andResult:(ChatResultBlock)result;//发送图片聊天消息

- (void)sendVoiceMessageWithChatUser:(NSString *)userId andLocalPath:(NSString *)path andDuration:(NSTimeInterval)duration andOtherInfo:(NSDictionary *)extInfo andResult:(ChatResultBlock)result;//发送语音聊天消息



@end
