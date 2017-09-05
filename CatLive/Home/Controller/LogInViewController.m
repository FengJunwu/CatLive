//
//  LogInViewController.m
//  CatLive
//
//  Created by 平凡 on 17/8/15.
//  Copyright © 2017年 Yahaw Lee. All rights reserved.
//

#import "LogInViewController.h"

@interface LogInViewController ()<UITextFieldDelegate>{

    __weak IBOutlet UITextField *_phoneNumberField;

    __weak IBOutlet UITextField *_codeField;
    
    __weak IBOutlet UIButton *_getCodeBtn;
    
    __weak IBOutlet UIButton *_logInBtn;
    
    
    __weak IBOutlet UIButton *_qqLogInBtn;
    
    __weak IBOutlet UIButton *_weChatLogInBtn;

    __weak IBOutlet UIButton *_sinaLogInBtn;
    
    NSString *_phoneNumber;
    NSString *_authCodeStr;//验证码
    NSTimer *_timer;
    int _timerValue;
    
}

@end

@implementation LogInViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [_phoneNumberField setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [_phoneNumberField setValue:[UIFont boldSystemFontOfSize:16] forKeyPath:@"_placeholderLabel.font"];
    
    _getCodeBtn.layer.cornerRadius = 15.0;
    _getCodeBtn.layer.masksToBounds = YES;
    
    [_codeField setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [_codeField setValue:[UIFont boldSystemFontOfSize:16] forKeyPath:@"_placeholderLabel.font"];
    
    _logInBtn.layer.cornerRadius = 21.0;
    _logInBtn.layer.masksToBounds = YES;
    
    
}

- (void)startTimer{
    _timerValue = 60;
    _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self
                                            selector:@selector(timerAction:)
                                            userInfo:nil
                                             repeats:YES];
}

- (void)timerAction:(NSTimer *)timer{
    
    _timerValue --;
    [_getCodeBtn setTitle:[NSString stringWithFormat:@"%ds",_timerValue] forState:UIControlStateNormal];
    if (_timerValue == 0) {
        [self closeTimer];
        [_getCodeBtn setTitle:@"重新获取" forState:UIControlStateNormal];
        _getCodeBtn.enabled = YES;
    }
}

- (void)closeTimer{
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
    }
}


- (IBAction)tapAction:(UITapGestureRecognizer *)sender {
    [_phoneNumberField resignFirstResponder];
    [_codeField resignFirstResponder];
    
}


- (IBAction)getAuthCodeAction:(UIButton *)sender {
    _getCodeBtn.enabled = NO;
    
    if (_phoneNumberField.text.length != 11) {
        [NoticeView showWithMsg:@"手机号码输入有误"];
        return;
    }
    
    _phoneNumber = _phoneNumberField.text;
    _authCodeStr = @"";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:_phoneNumberField.text forKey:@"phone"];
    [params setObject:@"1" forKey:@"type"];
    
    __weak typeof(self)weakSelf = self;
    [DataService GET:APIAuthCode params:params process:^(NSProgress *process) {
        
    } finishBlock:^(NSURLSessionDataTask *operation, id result) {
        NSDictionary *resultDic = result;
        if ([resultDic[@"status"] integerValue] == 0) {
            //获取验证码成功
            _authCodeStr = resultDic[@"data"];
            //计时开始
            __strong typeof(self)strongSelf = weakSelf;
            [strongSelf startTimer];
            
        } else {
            _getCodeBtn.enabled = YES;
            //请求出错
            [NoticeView showWithMsg:@"获取验证码失败"];
        }
        
    } FailuerBlock:^(NSURLSessionDataTask *operation, NSError *error) {
        _getCodeBtn.enabled = YES;
    }];
}

- (IBAction)logInAction:(UIButton *)sender {
    
    //验证
//    if (_phoneNumberField.text.length == 0) {
//        [NoticeView showWithMsg:@"请输入手机号码"];
//        return;
//    }
//    if (_codeField.text.length == 0) {
//        [NoticeView showWithMsg:@"请输入验证码"];
//        return;
//    }
//    if (_phoneNumberField.text.length != 11) {
//        [NoticeView showWithMsg:@"手机号码输入有误"];
//        return;
//    }
//    
//    if (_codeField.text.length != 11) {
//        [NoticeView showWithMsg:@"验证码输入有误"];
//        return;
//    }
//    if (_authCodeStr.length == 0) {
//        [NoticeView showWithMsg:@"请先获取验证码"];
//        return;
//    }
//    
//    if (_phoneNumber.length != 0 && ![_phoneNumberField.text isEqualToString:_phoneNumber]) {
//        [NoticeView showWithMsg:@"请重新获取验证码"];
//        return;
//    }
//    
//    if (_authCodeStr.length != 0 && ![_authCodeStr isEqualToString:_codeField.text]) {
//        [NoticeView showWithMsg:@"验证码输入有误"];
//        return;
//    }
    
    [[LoginManager manager] loginWithIdentify:_phoneNumberField.text andType:@"mobile"];
    
}


- (IBAction)qqLoginAction:(UIButton *)sender {
    
}

- (IBAction)weChatLogInAction:(UIButton *)sender {
    
}

- (IBAction)sinaLogInAction:(UIButton *)sender {
    
    
}




#pragma mark - UITextFieldDelegate















- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
