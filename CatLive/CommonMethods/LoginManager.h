//
//  LoginManager.h
//  iStarLive
//
//  Created by 平凡 on 16/10/31.
//  Copyright © 2016年 lyh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HomeViewController.h"
#import "LogInViewController.h"
#import "UserInfoModel.h"

#pragma mark - 登录管理
@interface LoginManager : NSObject{
    
}
@property (nonatomic,strong) HomeViewController *homeVC;

@property (nonatomic,assign) BOOL isLogin;//是否已经登陆

@property (nonatomic,strong) UserInfoModel *userInfo;//用户信息

+ (LoginManager *)manager;
- (void)autoLogIn;//自动登录
- (void)showLoginVC;//弹出登录界面
- (void)loginWithIdentify:(NSString *)identity andType:(NSString *)type;
- (void)logOut;

@end
