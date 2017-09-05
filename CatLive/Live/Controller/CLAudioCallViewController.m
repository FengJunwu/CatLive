//
//  CLAudioCallViewController.m
//  CatLive
//
//  Created by 平凡 on 17/8/19.
//  Copyright © 2017年 Yahaw Lee. All rights reserved.
//

#import "CLAudioCallViewController.h"
#import "UIButton+Ext.h"
@interface CLAudioCallViewController (){
    
    __weak IBOutlet UIView *_audioView;

    __weak IBOutlet UIImageView *_userPoster;//用户海报图片
    __weak IBOutlet UIImageView *_userImage;//用户头像
    __weak IBOutlet UILabel *_userNickLabel;
    
    __weak IBOutlet UILabel *_disLabel;
    
    __weak IBOutlet UILabel *_callTimeLabel;
    
    __weak IBOutlet UIButton *_scaleScreenBtn;
    
    __weak IBOutlet UIButton *_hangUpBtn;
    
    __weak IBOutlet UIButton *_handFreeBtn;
    
    __weak IBOutlet UIButton *_allowCallBtn;
    __weak IBOutlet UIButton *_refuseCallBtn;
}

@end

@implementation CLAudioCallViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    
    


}

- (void)reSetBasicView {

    [_scaleScreenBtn chanegStyleTopImageBottomTitle];
    [_hangUpBtn chanegStyleTopImageBottomTitle];
    [_handFreeBtn chanegStyleTopImageBottomTitle];
    [_allowCallBtn chanegStyleTopImageBottomTitle];
    [_refuseCallBtn chanegStyleTopImageBottomTitle];
    _callTimeLabel.hidden = YES;
    if (_isRecever) {
        _disLabel.hidden = NO;
        _allowCallBtn.hidden = NO;
        _refuseCallBtn.hidden = NO;
        _scaleScreenBtn.hidden = YES;
        _hangUpBtn.hidden = YES;
        _handFreeBtn.hidden = YES;
        
    } else {
        _disLabel.hidden = YES;
        _allowCallBtn.hidden = YES;
        _refuseCallBtn.hidden = YES;
        _scaleScreenBtn.hidden = NO;
        _hangUpBtn.hidden = NO;
        _handFreeBtn.hidden = NO;
    }
}





- (IBAction)scaleScreenAction:(UIButton *)sender {
    
}

- (IBAction)hangUpAction:(UIButton *)sender {
    
}

- (IBAction)handFreeAction:(UIButton *)sender {
    //免提
    
}
- (IBAction)allowCallAction:(UIButton *)sender {
    
    _disLabel.hidden = YES;
    _scaleScreenBtn.hidden = NO;
    _hangUpBtn.hidden = NO;
    _handFreeBtn.hidden = NO;
    
}
- (IBAction)refuseCallAction:(UIButton *)sender {
    
    
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
