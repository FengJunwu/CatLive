//
//  UserInfoViewController.m
//  CatLive
//
//  Created by 平凡 on 17/8/12.
//  Copyright © 2017年 Yahaw Lee. All rights reserved.
//

#import "UserInfoViewController.h"
#import "CLChatViewController.h"
#import "CLAudioCallViewController.h"
#import "CLVideoCallViewController.h"
@interface UserInfoTableViewCell : UITableViewCell{
    
    __weak IBOutlet UIImageView *_userImageIcon;
    
    __weak IBOutlet UILabel *_userNickLabel;
    
    __weak IBOutlet UILabel *_userIdLabel;
    
    __weak IBOutlet UIButton *_fallowBtn;

}
@property (nonatomic,strong) AnchorInfo *anchor;

@end
@implementation UserInfoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _userImageIcon.layer.cornerRadius = 35.0;
    _userImageIcon.layer.masksToBounds = YES;
    
}
- (void)setAnchor:(AnchorInfo *)anchor{
    if (_anchor != anchor) {
        _anchor = anchor;
        [_userImageIcon sd_setImageWithURL:[NSURL URLWithString:_anchor.avatar] placeholderImage:[UIImage imageNamed:@"userHeaderPlace"]];
        _userNickLabel.text = _anchor.nickname;
        _userIdLabel.text = [NSString stringWithFormat:@"直聊号：%ld",_anchor.anchorId];
    }
}


- (IBAction)fallowAction:(UIButton *)sender {
    //关注事件
}


@end


@interface UserPriceInfoTableViewCell : UITableViewCell{

    __weak IBOutlet UILabel *_titleLabel;

    __weak IBOutlet UILabel *_priceLabel;
    
}
@property (nonatomic,assign) NSInteger type;//0:视频通话 1:语音通话
@property (nonatomic,assign) NSInteger price;//价格

@end
@implementation UserPriceInfoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    
}

- (void)setPrice:(NSInteger)price{
    _price = price;
    if (_type == 1) {
        _titleLabel.text = @"视频聊天";
        
    } else if (_type == 2){
        _titleLabel.text = @"语音聊天";

    }
    _priceLabel.text = [NSString stringWithFormat:@"%ld钻石/分钟",price];
}

@end


@interface UserInfoViewController ()<UITableViewDelegate,UITableViewDataSource>{

    __weak IBOutlet UITableView *_tableView;
    
    __weak IBOutlet UIView *_tableHeadView;
    
    __weak IBOutlet UIImageView *_userImage;
    
    
    __weak IBOutlet UIView *_chatView;
    __weak IBOutlet UIButton *_messageChatBtn;
    __weak IBOutlet UIButton *_videoCallBtn;
    __weak IBOutlet UIButton *_audioCallBtn;
    
}

@end

@implementation UserInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setBasicView];
}
- (void)setBasicView{
    self.title = _anchor.nickname;
    
    [_userImage sd_setImageWithURL:[NSURL URLWithString:_anchor.avatar] placeholderImage:[UIImage imageNamed:@"userHeaderPlace"]];
    
    
    
    

}
- (IBAction)messageChatAction:(UIButton *)sender {
    [[CLChatManager manager] showChatVC];
    
}
- (IBAction)videoCallAction:(UIButton *)sender {
    [[CLCallManager manager] showVideoVC];
    
}

- (IBAction)audioCallAction:(UIButton *)sender {
    [[CLCallManager manager] showAudioVC];
}




#pragma mrak - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;

}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    } else {
        return 2;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        UserInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UserInfoTableViewCell"];
        cell.anchor = _anchor;
        return cell;
    } else if(indexPath.section == 1){
        UserPriceInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UserPriceInfoTableViewCell"];
        cell.type = indexPath.row;
        if (indexPath.row == 0) {
            cell.price = _anchor.videoMaxPrice;
        } else {
            cell.price = _anchor.voicePrice;
        }
        return cell;
    }
    
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 100;
    } else {
        return 52;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 0) {
        return 10;
    }
    return 0;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

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






