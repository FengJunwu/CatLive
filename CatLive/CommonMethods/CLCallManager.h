//
//  CLCallManager.h
//  CatLive
//
//  Created by 平凡 on 17/8/19.
//  Copyright © 2017年 Yahaw Lee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Hyphenate/Hyphenate.h>



typedef void(^CallCompletion)(EMCallSession *aCallSession, EMError *aError);


@interface CLCallManager : NSObject

@property (nonatomic,strong) HomeViewController *homeVC;


+ (CLCallManager *)manager;


- (void)showAudioVC;
- (void)showVideoVC;


- (void)makeCallWithCallType:(EMCallType)callType andRemoteUser:(NSString *)userId andExtInfo:(NSString *)ext andCompletion:(CallCompletion)completionBlock;//发起视频或语音通话

- (EMError *)answerThcallWithCallUserId:(NSString *)userId;//统一进行音视频通话


//typedef enum{
//    EMCallEndReasonHangup   = 0,    /*! 对方挂断 */
//    EMCallEndReasonNoResponse,      /*! 对方没有响应 */
//    EMCallEndReasonDecline,         /*! 对方拒接 */
//    EMCallEndReasonBusy,            /*! 对方占线 */
//    EMCallEndReasonFailed,          /*! 失败 */
//    EMCallEndReasonUnsupported,     /*! 功能不支持 */
//}EMCallEndReason;


- (EMError *)endCall:(NSString *)callUserId andReson:(EMCallEndReason)reason;//挂断通话


/*!
 *  暂停语音数据传输
 *
 *  @result 错误
 */
- (EMError *)pauseVoice;

/*!
 *  恢复语音数据传输
 *
 *  @result 错误
 */
- (EMError *)resumeVoice;

/*!
 *  暂停视频图像数据传输
 *
 *  @result 错误
 */
- (EMError *)pauseVideo;

/*!
 *  恢复视频图像数据传输
 *
 *  @result 错误
 */
- (EMError *)resumeVideo;


@end
