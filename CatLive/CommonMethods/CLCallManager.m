//
//  CLCallManager.m
//  CatLive
//
//  Created by 平凡 on 17/8/19.
//  Copyright © 2017年 Yahaw Lee. All rights reserved.
//

#import "CLCallManager.h"
#import "CLAudioCallViewController.h"
#import "CLVideoCallViewController.h"


@interface CLCallManager ()<EMCallManagerDelegate> {

}

@property (nonatomic,strong) CLAudioCallViewController *audioVC;
@property (nonatomic,strong) CLVideoCallViewController *videoVC;
@property (nonatomic,strong) EMCallSession *currentSession;

@end

@implementation CLCallManager

+ (id)manager{
    static id instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[CLCallManager alloc] init];
    });
    return instance;
}

- (instancetype)init{
    self = [super init];
    if (self) {
        
        EMCallOptions *options = [[EMClient sharedClient].callManager getCallOptions];
        //当对方不在线时，是否给对方发送离线消息和推送，并等待对方回应
        options.isSendPushIfOffline = YES;
        [[EMClient sharedClient].callManager setCallOptions:options];
        [[EMClient sharedClient].callManager addDelegate:self delegateQueue:nil];
    }
    return self;
}


- (void)showAudioVC {
    if (!_audioVC) {
        _audioVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"CLAudioCallViewController"];
    }
    [_homeVC presentViewController:_audioVC animated:YES completion:^{
        
    }];
}
- (void)showVideoVC {
    if (!_videoVC) {
        _videoVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"CLVideoCallViewController"];
    }
    [_homeVC presentViewController:_videoVC animated:YES completion:^{
        
    }];
}


- (void)makeCallWithCallType:(EMCallType)callType andRemoteUser:(NSString *)userId andExtInfo:(NSString *)ext andCompletion:(CallCompletion)completionBlock {
    [[EMClient sharedClient].callManager startCall:callType remoteName:userId ext:ext completion:^(EMCallSession *aCallSession, EMError *aError) {
        if (aError == nil) {
            _currentSession = aCallSession;
        }
        if (completionBlock) {
            completionBlock(aCallSession,aError);
        }
    }];
}//发起视频或语音通话

- (EMError *)answerThcallWithCallUserId:(NSString *)userId {
    
    EMError *error = [[EMClient sharedClient].callManager answerIncomingCall:@"sessionId"];
     return error;
    
}//统一进行音视频通话

- (EMError *)endCall:(NSString *)callUserId andReson:(EMCallEndReason)reason {
    
    return [[EMClient sharedClient].callManager endCall:callUserId reason:reason];
    
}


/*!
 *  暂停语音数据传输
 *
 *  @result 错误
 */
- (EMError *)pauseVoice {
    return nil;
}

/*!
 *  恢复语音数据传输
 *
 *  @result 错误
 */
- (EMError *)resumeVoice{
    return nil;
}

/*!
 *  暂停视频图像数据传输
 *
 *  @result 错误
 */
- (EMError *)pauseVideo {
    return nil;
}

/*!
 *  恢复视频图像数据传输
 *
 *  @result 错误
 */
- (EMError *)resumeVideo {
    return nil;

}





#pragma mark - EMCallManagerDelegate
/*!
 *  用户A拨打用户B，用户B会收到这个回调
 *
 *  @param aSession  会话实例
 */
- (void)callDidReceive:(EMCallSession *)aSession {
    
}

/*!
 *  通话通道建立完成，用户A和用户B都会收到这个回调
 *
 *  @param aSession  会话实例
 */
- (void)callDidConnect:(EMCallSession *)aSession {

}

/*!
 *  用户B同意用户A拨打的通话后，用户A会收到这个回调
 *
 *  @param aSession  会话实例
 */
- (void)callDidAccept:(EMCallSession *)aSession {

}

/*!
 *  1. 用户A或用户B结束通话后，对方会收到该回调
 *  2. 通话出现错误，双方都会收到该回调
 *
 *  @param aSession  会话实例
 *  @param aReason   结束原因
 *  @param aError    错误
 */
- (void)callDidEnd:(EMCallSession *)aSession
            reason:(EMCallEndReason)aReason
             error:(EMError *)aError {

}

/*!
 *  用户A和用户B正在通话中，用户A中断或者继续数据流传输时，用户B会收到该回调
 *
 *  @param aSession  会话实例
 *  @param aType     改变类型
 */
- (void)callStateDidChange:(EMCallSession *)aSession
                      type:(EMCallStreamingStatus)aType {

}





@end


