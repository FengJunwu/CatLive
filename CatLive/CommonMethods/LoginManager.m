
//
//  LoginManager.m
//  iStarLive
//
//  Created by 平凡 on 16/10/31.
//  Copyright © 2016年 lyh. All rights reserved.
//

#import "LoginManager.h"
#import <Hyphenate/Hyphenate.h>
#import "RegistureUserInfoViewController.h"
@interface LoginManager (){
    LogInViewController *_logInVC;
}

@end

@implementation LoginManager


+ (id)manager{
    static id instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[LoginManager alloc] init];
    });
    return instance;
}
- (void)autoLogIn{
    //自动登录逻辑
    if (!_isLogin) {
        NSDictionary *dic = [[NSUserDefaults standardUserDefaults] objectForKey:USERDEFLoginInfo];
        if (dic) {
            //自动登录
            [self loginWithIdentify:dic[@"identity"] andType:dic[@"type"]];
        } else {
            [self showLoginVC];
        }
    }

}


- (void)showLoginVC{
    if (!_logInVC) {
        _logInVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"LogInViewController"];
    }
    [self.homeVC presentViewController:_logInVC animated:YES completion:^{
    }];
}


- (void)loginWithIdentify:(NSString *)identity andType:(NSString *)type{
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:identity forKey:@"phone"];
    [params setObject:type forKey:@"type"];
    
    [DataService GET:APIUserLogIn params:params process:^(NSProgress *process) {
        
    } finishBlock:^(NSURLSessionDataTask *operation, id result) {
        NSDictionary *resultDic = result;
        if ([resultDic[@"status"] integerValue] == 0) {
            
            [self loginSuccessWithData:resultDic[@"data"] andLoginInfo:@{@"identity":identity,@"type":type}];
            
        } else {
            //请求出错
            [self loginFaield];
        }
        
    } FailuerBlock:^(NSURLSessionDataTask *operation, NSError *error) {
        [self loginFaield];
    }];


}


- (void)loginSuccessWithData:(NSDictionary *)dataDic andLoginInfo:(NSDictionary *)loginInfo{
    _isLogin = YES;
    _userInfo = [[UserInfoModel alloc] initWithDictionary:dataDic];
    
    //登录环信
    EMError *error = [[EMClient sharedClient] loginWithUsername:_userInfo.EMUserName password:_userInfo.EMUserPass];
    if (!error) {
        NSLog(@"环信登录成功");
    }
    
    
    //保存登录信息
    [[NSUserDefaults standardUserDefaults] setObject:loginInfo forKey:USERDEFLoginInfo];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    if (_logInVC) {
        [NoticeView showWithMsg:@"登录成功"];
        [_logInVC closeTimer];
        [_logInVC dismissViewControllerAnimated:YES completion:^{
            _logInVC = nil;
            [self presentRegisterVC];
        }];
    } else {
        //自动登录成功
    
    }
}

- (void)loginFaield{
    
    if (!_logInVC) {
        [self showLoginVC];
    } else {
        [NoticeView showWithMsg:@"登录失败"];
    }

}

- (void)logOut{
    _isLogin = NO;
    _userInfo = nil;
    
    //登出环信
    EMError *error = [[EMClient sharedClient] logout:YES];
    if (!error) {
        NSLog(@"退出成功");
    }
    
    
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:USERDEFLoginInfo];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [self showLoginVC];
}


- (void)presentRegisterVC {
    RegistureUserInfoViewController *registureVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"RegistureUserInfoViewController"];
    [self.homeVC presentViewController:registureVC animated:YES completion:^{
    }];


}



@end

