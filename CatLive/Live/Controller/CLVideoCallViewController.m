//
//  CLVideoCallViewController.m
//  CatLive
//
//  Created by 平凡 on 17/8/19.
//  Copyright © 2017年 Yahaw Lee. All rights reserved.
//

#import "CLVideoCallViewController.h"
#import "UIButton+Ext.h"
@interface CLVideoCallViewController () {

    __weak IBOutlet UIView *_startCallView;
    __weak IBOutlet UIImageView *_bgUserImage;
    __weak IBOutlet UIImageView *_userImage;
    __weak IBOutlet UILabel *_nickLabel;
    __weak IBOutlet UILabel *_disLabel;
    __weak IBOutlet UIButton *_hangUpBtn;
    __weak IBOutlet UIButton *_refuseBtn;
    __weak IBOutlet UIButton *_answerBtn;
    
    __weak IBOutlet UIView *_contentView;
    __weak IBOutlet UIView *_remotVideoView;
    __weak IBOutlet UIView *_localVideoView;
    __weak IBOutlet UIButton *_giftBtn;
    __weak IBOutlet UIButton *_shareBtn;
    __weak IBOutlet UIButton *_closeBtn;
    
    
}

@end

@implementation CLVideoCallViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self reSetBasicView];
}

- (void)reSetBasicView {
    [_hangUpBtn chanegStyleTopImageBottomTitle];
    [_refuseBtn chanegStyleTopImageBottomTitle];
    [_answerBtn chanegStyleTopImageBottomTitle];
    if (_isRecever) {
        _disLabel.hidden = NO;
        _refuseBtn.hidden = NO;
        _answerBtn.hidden = NO;
        _hangUpBtn.hidden = YES;
    } else {
        _disLabel.hidden = YES;
        _refuseBtn.hidden = YES;
        _answerBtn.hidden = YES;
        _hangUpBtn.hidden = NO;
    }
}



//开始界面
- (IBAction)hangUpAction:(UIButton *)sender {
    
}

- (IBAction)refuseCallAction:(UIButton *)sender {
    
}

- (IBAction)anserCallAction:(UIButton *)sender {
    _startCallView.hidden = YES;
}


//内容界面
- (IBAction)showGiftViewAction:(UIButton *)sender {
    
}

- (IBAction)shareAction:(UIButton *)sender {
    
}

- (IBAction)closeRoomAction:(UIButton *)sender {
    
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
