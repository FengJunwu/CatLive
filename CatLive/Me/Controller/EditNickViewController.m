//
//  EditNickViewController.m
//  CatLive
//
//  Created by 平凡 on 17/8/17.
//  Copyright © 2017年 Yahaw Lee. All rights reserved.
//

#import "EditNickViewController.h"

@interface EditNickViewController (){

    __weak IBOutlet UITextField *_textField;

}

@end

@implementation EditNickViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"昵称";
    
    _textField.text = [LoginManager manager].userInfo.nickname;
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(sureAction)];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    
    
}

- (void)sureAction{
    //提交修改昵称
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:_textField.text forKey:@"nikeName"];
    [params setObject:@([LoginManager manager].userInfo.userId) forKey:@"userId"];
    
    [DataService POST:APIUpdateInfo params:params process:^(NSProgress *process) {
        
    } finishBlock:^(NSURLSessionDataTask *operation, id result) {
        NSDictionary *resultDic = result;
        if ([resultDic[@"status"] integerValue] == 0) {
            
        } else {
            //请求出错
            
        }
    } FailuerBlock:^(NSURLSessionDataTask *operation, NSError *error) {
        
    }];
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
