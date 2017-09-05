//
//  CLChatManager.m
//  CatLive
//
//  Created by 平凡 on 17/8/19.
//  Copyright © 2017年 Yahaw Lee. All rights reserved.
//

#import "CLChatManager.h"

@interface CLChatManager ()<EMChatManagerDelegate>
@property (nonatomic,strong) CLChatViewController *chatVC;
@end

@implementation CLChatManager

+ (id)manager{
    static id instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[CLChatManager alloc] init];
    });
    return instance;
}

- (instancetype)init{
    self = [super init];
    if (self) {
        [[EMClient sharedClient].chatManager addDelegate:self delegateQueue:nil];
    }
    return self;
}

- (void)showChatVC {
    if (!_chatVC) {
        _chatVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"CLChatViewController"];
    }
    [_homeVC presentViewController:_chatVC animated:YES completion:^{
        
    }];
}


#pragma mark - 聊天模块
//  [[EMClient sharedClient].chatManager updateMessage:aMessage];  //查询消息是否发送成功

- (EMConversation *)creatAndGetConversationWithUserId:(NSString *)userId {
    EMConversation *conversation = [[EMClient sharedClient].chatManager getConversation:userId type:EMConversationTypeChat createIfNotExist:YES];
    return conversation;
}//获取一个会话，没有时则进行创建
- (NSArray *)getAllConversation {
    NSArray *conversations = [[EMClient sharedClient].chatManager getAllConversations];
    return conversations;
}//获取所有的会话列表


- (void)sendMessageWithChatUser:(NSString *)userId andContent:(NSString *)content andOtherInfo:(NSDictionary *)extInfo andResult:(ChatResultBlock)result {
    EMTextMessageBody *body = [[EMTextMessageBody alloc] initWithText:content];
    NSString *from = [[EMClient sharedClient] currentUsername];
    
    //生成Message
    EMMessage *message = [[EMMessage alloc] initWithConversationID:userId from:from to:userId body:body ext:extInfo];
    message.chatType = EMChatTypeChat;// 设置为单聊消息
    [[EMClient sharedClient].chatManager sendMessage:message progress:^(int progress) {
        
    } completion:^(EMMessage *message, EMError *error) {
        if (result) {
            result(message,error);
        }
    }];
}

- (void)sendImageMessageWithChatUser:(NSString *)userId andImageData:(NSData *)data andOtherInfo:(NSDictionary *)extInfo andResult:(ChatResultBlock)result {
    
    EMImageMessageBody *body = [[EMImageMessageBody alloc] initWithData:data displayName:@"image.png"];
    NSString *from = [[EMClient sharedClient] currentUsername];
    
    //生成Message
    EMMessage *message = [[EMMessage alloc] initWithConversationID:userId from:from to:userId body:body ext:extInfo];
    message.chatType = EMChatTypeChat;// 设置为单聊消息
    [[EMClient sharedClient].chatManager sendMessage:message progress:^(int progress) {
        
    } completion:^(EMMessage *message, EMError *error) {
        if (result) {
            result(message,error);
        }
    }];
}

- (void)sendVoiceMessageWithChatUser:(NSString *)userId andLocalPath:(NSString *)path andDuration:(NSTimeInterval)duration andOtherInfo:(NSDictionary *)extInfo andResult:(ChatResultBlock)result {
    
    EMVoiceMessageBody *body = [[EMVoiceMessageBody alloc] initWithLocalPath:path displayName:@"audio"];
    body.duration = duration;
    NSString *from = [[EMClient sharedClient] currentUsername];
    
    // 生成message
    EMMessage *message = [[EMMessage alloc] initWithConversationID:userId from:from to:userId body:body ext:extInfo];
    message.chatType = EMChatTypeChat;// 设置为单聊消息
    [[EMClient sharedClient].chatManager sendMessage:message progress:^(int progress) {
        
    } completion:^(EMMessage *message, EMError *error) {
        if (result) {
            result(message,error);
        }
    }];
}

- (void)deleteConversationWithUserId:(NSString *)userId andIsDeleteMessages:(BOOL)isDelete {
    [[EMClient sharedClient].chatManager deleteConversation:@"8001" isDeleteMessages:YES completion:^(NSString *aConversationId, EMError *aError){
        //code
    }];
}



#pragma mark - EMChatManagerDelegate
/*!
 @method
 @brief 接收到一条及以上非cmd消息
 */
- (void)messagesDidReceive:(NSArray *)aMessages {
    for (EMMessage *message in aMessages) {
        EMMessageBody *msgBody = message.body;
        switch (msgBody.type) {
            case EMMessageBodyTypeText:
            {
                // 收到的文字消息
                EMTextMessageBody *textBody = (EMTextMessageBody *)msgBody;
                NSString *txt = textBody.text;
                NSDictionary *ext = message.ext;//扩展内容
                NSLog(@"收到的文字是 txt -- %@",txt);
            }
                break;
            case EMMessageBodyTypeImage:
            {
                // 得到一个图片消息body
                EMImageMessageBody *body = ((EMImageMessageBody *)msgBody);
                NSLog(@"大图remote路径 -- %@"   ,body.remotePath);
                NSLog(@"大图local路径 -- %@"    ,body.localPath); // // 需要使用sdk提供的下载方法后才会存在
                NSLog(@"大图的secret -- %@"    ,body.secretKey);
                NSLog(@"大图的W -- %f ,大图的H -- %f",body.size.width,body.size.height);
                NSLog(@"大图的下载状态 -- %lu",body.downloadStatus);
                NSDictionary *ext = message.ext;
                
                // 缩略图sdk会自动下载
                NSLog(@"小图remote路径 -- %@"   ,body.thumbnailRemotePath);
                NSLog(@"小图local路径 -- %@"    ,body.thumbnailLocalPath);
                NSLog(@"小图的secret -- %@"    ,body.thumbnailSecretKey);
                NSLog(@"小图的W -- %f ,大图的H -- %f",body.thumbnailSize.width,body.thumbnailSize.height);
                NSLog(@"小图的下载状态 -- %lu",body.thumbnailDownloadStatus);
            }
                break;
            case EMMessageBodyTypeVoice:
            {
                // 音频sdk会自动下载
                EMVoiceMessageBody *body = (EMVoiceMessageBody *)msgBody;
                NSLog(@"音频remote路径 -- %@"      ,body.remotePath);
                NSLog(@"音频local路径 -- %@"       ,body.localPath); // 需要使用sdk提供的下载方法后才会存在（音频会自动调用）
                NSLog(@"音频的secret -- %@"        ,body.secretKey);
                NSLog(@"音频文件大小 -- %lld"       ,body.fileLength);
                NSLog(@"音频文件的下载状态 -- %lu"   ,body.downloadStatus);
                NSLog(@"音频的时间长度 -- %lu"      ,body.duration);
                NSDictionary *ext = message.ext;
            }
                break;
            default:
                break;
        }
//        if (<#condition#>) {
//            <#statements#>
//        }
//        [self creatAndGetConversationWithUserId:message.to];

    }
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIReceivedNewMessage object:nil];
}

/*!
 @method
 @brief 接收到一条及以上cmd消息
 */
- (void)cmdMessagesDidReceive:(NSArray *)aCmdMessages {
    for (EMMessage *message in aCmdMessages) {
        // cmd消息中的扩展属性
        NSDictionary *ext = message.ext;
        NSLog(@"cmd消息中的扩展属性是 -- %@",ext);
    }
}








@end

