//
//  EarningsViewController.m
//  CatLive
//
//  Created by 平凡 on 17/8/14.
//  Copyright © 2017年 Yahaw Lee. All rights reserved.
//

#import "EarningsViewController.h"

@interface EarningsViewController (){

    __weak IBOutlet UILabel *_accountLabel;
    
    __weak IBOutlet UILabel *_invateMoneyLabel;
    
    __weak IBOutlet UILabel *_liveMoneyLabel;
    
    __weak IBOutlet UIButton *_getCashBtn;

}

@end

@implementation EarningsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"我的收益";
    
    _accountLabel.text = [NSString stringWithFormat:@"%ld",[LoginManager manager].userInfo.diamonds];
    
    
    _getCashBtn.layer.cornerRadius = 21.0;
    _getCashBtn.layer.masksToBounds = YES;
    
}



- (IBAction)getCashAction:(UIButton *)sender {
    //提现事件
    
    
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
