//
//  ChargeSettingViewController.m
//  CatLive
//
//  Created by 平凡 on 17/8/22.
//  Copyright © 2017年 Yahaw Lee. All rights reserved.
//

#import "ChargeSettingViewController.h"
#import "ListenTimeSettingViewController.h"



@interface ChargeTimeTableViewCell : UITableViewCell {

    __weak IBOutlet UILabel *_titleLabel;
    __weak IBOutlet UILabel *_disLabel;
}

@end

@implementation ChargeTimeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

@end

@interface ChargeSettingTableViewCell : UITableViewCell <UITextFieldDelegate> {

    __weak IBOutlet UILabel *_titleLabel;
    
}
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (nonatomic,assign) NSInteger type;//0:语音收取  1：视频收取

@end

@implementation ChargeSettingTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _textField.delegate = self;
    if (_type == 0) {
        _textField.text = [NSString stringWithFormat:@"%ld",[LoginManager manager].userInfo.voicePrice];
    } else if (_type == 1){
        _textField.text = [NSString stringWithFormat:@"%ld",[LoginManager manager].userInfo.videoPrice];
    }
}

- (IBAction)subAction:(UIButton *)sender {
    NSInteger currenValue = [_textField.text integerValue] - 10;
    if (currenValue <= 0) {
        currenValue = 0;
    }
    _textField.text = [NSString stringWithFormat:@"%ld",currenValue];
    
}
- (IBAction)addAction:(UIButton *)sender {
    NSInteger currenValue = [_textField.text integerValue] + 10;
    if (_type == 0 && currenValue > [LoginManager manager].userInfo.voiceMaxPrice) {
        currenValue = [LoginManager manager].userInfo.voiceMaxPrice;
    } else if (_type == 1 && currenValue > [LoginManager manager].userInfo.videoPrice ) {
        currenValue = [LoginManager manager].userInfo.videoPrice;
    }
    _textField.text = [NSString stringWithFormat:@"%ld",currenValue];
}

#pragma mark - UITextFieldDelegate

- (void)textFieldDidEndEditing:(UITextField *)textField {
    if (_type == 0 && [textField.text integerValue] > [LoginManager manager].userInfo.voiceMaxPrice) {
        textField.text = [NSString stringWithFormat:@"%ld",[LoginManager manager].userInfo.voiceMaxPrice];
    }

    if (_type == 1 && [textField.text integerValue] > [LoginManager manager].userInfo.videoPrice) {
        textField.text = [NSString stringWithFormat:@"%ld",[LoginManager manager].userInfo.videoPrice];
    }
}


//- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
//    return YES;
//}







@end


@interface ChargeSettingViewController ()<UITableViewDelegate,UITableViewDataSource> {

    __weak IBOutlet UITableView *_tableView;

}

@end

@implementation ChargeSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"收费设置";
    
    [self initRithtBar];
}

- (void)initRithtBar {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 70, 44);
    [btn setTitle:@"确定" forState:UIControlStateNormal];
    btn.titleLabel.textColor = [UIColor whiteColor];
    btn.titleLabel.font = [UIFont systemFontOfSize:16];
    [btn addTarget:self action:@selector(rightBarButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.rightBarButtonItem = item;
}

- (void)rightBarButtonAction:(UIButton *)btn {
    ChargeSettingTableViewCell *voiceSetcCell = [_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
    [voiceSetcCell.textField resignFirstResponder];
    ChargeSettingTableViewCell *videoCell = [_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
    [videoCell.textField resignFirstResponder];
    if ([voiceSetcCell.textField.text integerValue] != [LoginManager manager].userInfo.voicePrice || [videoCell.textField.text integerValue] != [LoginManager manager].userInfo.videoPrice) {
        //提交数据 voiceSetcCell.textField.text  videoCell.textField.text
    }
}






#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self == 0) {
        return 1;
    } else {
        return 2;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        ChargeTimeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ChargeTimeTableViewCell"];
        return cell;
    } else {
        ChargeSettingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ChargeSettingTableViewCell"];
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 52;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        ListenTimeSettingViewController *timeSetVC = [self.storyboard instantiateViewControllerWithIdentifier:@"ListenTimeSettingViewController"];
        [self.navigationController pushViewController:timeSetVC animated:YES];
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 0) {
        return 10;
    }
    return 0;
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


