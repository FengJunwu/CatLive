//
//  FeedbackViewController.m
//  CatLive
//
//  Created by 平凡 on 17/8/18.
//  Copyright © 2017年 Yahaw Lee. All rights reserved.
//

#import "FeedbackViewController.h"

@interface FeedbackViewController ()<UITextViewDelegate,UITextFieldDelegate>{
    
    __weak IBOutlet UILabel *_placeHolderLabel;
    __weak IBOutlet UITextView *_textView;
    __weak IBOutlet UILabel *_valueLabel;
    __weak IBOutlet UITextField *_textField;
    __weak IBOutlet UIButton *_submitBtn;
    
}

@end

@implementation FeedbackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"用户反馈";
    
    
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    [self.view addGestureRecognizer:tapGes];
    
    
}

- (void)uploadFeedback{
    
    
    //上传反馈内容
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:@([LoginManager manager].userInfo.userId) forKey:@"id"];
    [params setObject:_textView.text forKey:@"content"];
    [params setObject:_textField.text forKey:@"contact"];
    NSString *timInterval = [NSString stringWithFormat:@"%ld", (long)[[NSDate date] timeIntervalSince1970]];
    [params setObject:timInterval forKey:@"createAt"];

    
    __weak typeof(self)weakSelf = self;
    [DataService GET:APIFeedback params:params process:^(NSProgress *process) {
        
    } finishBlock:^(NSURLSessionDataTask *operation, id result) {
        NSDictionary *resultDic = result;
        __strong typeof(self)strongSelf = weakSelf;
        if ([resultDic[@"status"] integerValue] == 0) {
            [NoticeView showWithMsg:@"提交反馈成功"];
            [strongSelf popoverPresentationController];
        } else {
            //请求出错
            [NoticeView showWithMsg:@"提交反馈失败"];
        }
        
    } FailuerBlock:^(NSURLSessionDataTask *operation, NSError *error) {
        
    }];
    
    
    
}


- (void)tapAction:(UIGestureRecognizer *)ges{
    [_textView resignFirstResponder];
    [_textField resignFirstResponder];
}

- (void)checkAllowSubmit{
    if (_textView.text.length > 0  && _textField.text.length > 0) {
        _submitBtn.backgroundColor = CommonColor;
        _submitBtn.selected = YES;
    } else {
        _submitBtn.backgroundColor = [Common colorWithHexString:@"#E1E1E1" alpha:1.0];
        _submitBtn.selected = NO;
    }

}

#pragma mark - UITextViewDelegate
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    _placeHolderLabel.hidden = YES;
    return YES;
}
- (BOOL)textViewShouldEndEditing:(UITextView *)textView{
    if (_textView.text.length > 0 ) {
        _placeHolderLabel.hidden = YES;
    } else {
        _placeHolderLabel.hidden = NO;
    }

    return YES;
}
- (void)textViewDidEndEditing:(UITextView *)textView{
    //输入内容结束
    [self checkAllowSubmit];

}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    [self checkAllowSubmit];
    
    if (textView.text.length + text.length - range.length  > 200 && ![text isEqualToString:@""]) {
        [NoticeView showWithMsg:@"输入内容过长"];
        return NO;
    }
    _valueLabel.text = [NSString stringWithFormat:@"%ld",textView.text.length + text.length - range.length];

    return YES;
}


#pragma mark - UITextFieldDelegate

- (void)textFieldDidEndEditing:(UITextField *)textField{
    [self checkAllowSubmit];

}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    [self checkAllowSubmit];
    
    return YES;
}





- (IBAction)submitAction:(UIButton *)sender {
    //提交反馈内容
    if (sender.selected) {
        //当检测输入内容都不为空时提交
        [self uploadFeedback];
    }
}


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



