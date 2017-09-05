//
//  MeViewController.m
//  CatLive
//
//  Created by 平凡 on 17/8/12.
//  Copyright © 2017年 Yahaw Lee. All rights reserved.
//

#import "MeViewController.h"
#import "PersonalInfoViewController.h"
#import "TopUpViewController.h"
#import "EarningsViewController.h"
#import "AttentionViewController.h"
#import "SettingViewController.h"
#import "InviteViewController.h"
#import "AuthViewController.h"
#import "ChargeSettingViewController.h"
@interface MeUserInfoTableCell : UITableViewCell{

    __weak IBOutlet UIImageView *_userImage;
    __weak IBOutlet UILabel *_userNickLabel;
    __weak IBOutlet UILabel *_userIdLabel;
    
}

@end
@implementation MeUserInfoTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _userImage.layer.cornerRadius = 35.0;
    _userImage.layer.masksToBounds = YES;
    
    [_userImage sd_setImageWithURL:[NSURL URLWithString:[LoginManager manager].userInfo.avatar] placeholderImage:[UIImage imageNamed:@"userHeaderPlace"]];
    _userNickLabel.text = [LoginManager manager].userInfo.nickname;
    _userIdLabel.text = [NSString stringWithFormat:@"直聊号：%ld",[LoginManager manager].userInfo.userId];
}

@end

@protocol MeFansTableCellDelegate <NSObject>

- (void)userEnterAttentionVC;
- (void)userEnterFansVC;

@end
@interface MeFansTableCell : UITableViewCell{

    __weak IBOutlet UIButton *_attentionBtn;
    
    __weak IBOutlet UIButton *_fansBtn;
    
}
@property (nonatomic,weak) id<MeFansTableCellDelegate> delegate;
@end
@implementation MeFansTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [_attentionBtn setTitle:[NSString stringWithFormat:@"关注 %ld",[LoginManager manager].userInfo.follow] forState:UIControlStateNormal];
    [_fansBtn setTitle:[NSString stringWithFormat:@"人气 %ld",[LoginManager manager].userInfo.popularity] forState:UIControlStateNormal];
}
- (IBAction)enterAttentionView:(UIButton *)sender {
    //关注的人的界面
    if (_delegate && [_delegate respondsToSelector:@selector(userEnterAttentionVC)]) {
        [_delegate userEnterAttentionVC];
    }
}

- (IBAction)enterFansView:(UIButton *)sender {
    //人气
    if (_delegate && [_delegate respondsToSelector:@selector(userEnterFansVC)]) {
        [_delegate userEnterFansVC];
    }
    
    
}

@end


@interface MeOtherTableCell : UITableViewCell{
    

    __weak IBOutlet UIImageView *_icon;
    __weak IBOutlet UILabel *_titleLabel;
    
    __weak IBOutlet UILabel *_contentLabel;
    
}
@property (nonatomic,assign) MeCellType cellType;
@end
@implementation MeOtherTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setCellType:(MeCellType)cellType{
    switch (cellType) {
        case MeCellTypeAccount:{
            _icon.image = [UIImage imageNamed:@"meAccount"];
            _titleLabel.text = @"账户充值";
            _contentLabel.hidden = NO;
            _contentLabel.text = [NSString stringWithFormat:@"%ld 钻石",[LoginManager manager].userInfo.diamonds];
        }
            break;
        case MeCellTypeEarnings:{
            _icon.image = [UIImage imageNamed:@"meEarnings"];
            _titleLabel.text = @"我的收益";
            _contentLabel.hidden = NO;
            _contentLabel.text = [NSString stringWithFormat:@"%ld 元",[LoginManager manager].userInfo.profit];
        }
            break;
        case MeCellTypeInvite:{
            _icon.image = [UIImage imageNamed:@"meInvite"];
            _titleLabel.text = @"邀请赚钱";
            _contentLabel.hidden = YES;
        }
            break;
        case MeCellTypeBeHost:{
            _icon.image = [UIImage imageNamed:@"hostCertification"];
            _titleLabel.text = @"成为主播";
            _contentLabel.hidden = NO;
            if ([LoginManager manager].userInfo.certification) {
                //认证主播
                _contentLabel.text = @"收费设置";
            } else {
                _contentLabel.text = @"主播认证";
            }
        }
            break;
        case MeCellTypeSetting:{
            _icon.image = [UIImage imageNamed:@"meSetting"];
            _titleLabel.text = @"设置";
            _contentLabel.hidden = YES;
        }
            break;
        default:
            break;
    }
}


@end


@interface MeViewController ()<UITableViewDataSource,UITableViewDelegate,MeFansTableCellDelegate>{

    __weak IBOutlet UITableView *_tableView;
    
}

@end

@implementation MeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"我的";
    
    _tableView.tableFooterView = [[UIView alloc] init];
    
}
#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 2;
    } else {
        return 5;
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            return 100;
        } else {
            return 60;
        }
    } else {
        return 54;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 0) {
        return 10;
    }
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            MeUserInfoTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MeUserInfoTableCell"];
            return cell;
        } else {
            MeFansTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MeFansTableCell"];
            cell.delegate = self;
            return cell;
        }
    } else {
        MeOtherTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MeOtherTableCell"];
        cell.cellType = indexPath.row;
        return cell;
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0 && indexPath.row == 0) {
        //用户信息设置
        PersonalInfoViewController *personalVC = [self.storyboard instantiateViewControllerWithIdentifier:@"PersonalInfoViewController"];
        [self.navigationController pushViewController:personalVC animated:YES];
        
    } else if (indexPath.section == 1){
        switch (indexPath.row) {
            case 0:{
                //充值
                TopUpViewController *topUpVC = [self.storyboard instantiateViewControllerWithIdentifier:@"TopUpViewController"];
                [self.navigationController pushViewController:topUpVC animated:YES];
            }
                break;
            case 1:{
                //收益
                EarningsViewController *earnVC = [self.storyboard instantiateViewControllerWithIdentifier:@"EarningsViewController"];
                [self.navigationController pushViewController:earnVC animated:YES];
            }
                break;
            case 2:{
                //邀请
                InviteViewController *inviteVC = [self.storyboard instantiateViewControllerWithIdentifier:@"InviteViewController"];
                [self.navigationController pushViewController:inviteVC animated:YES];
            }
                break;
            case 3:{
                //认证
                if ([LoginManager manager].userInfo.certification) {
                    //跳转收费设置
                    ChargeSettingViewController *chargeVC = [self.storyboard instantiateViewControllerWithIdentifier:@"ChargeSettingViewController"];
                    [self.navigationController pushViewController:chargeVC animated:YES];
                } else {
                    //跳转认证
                    AuthViewController *authVC = [self.storyboard instantiateViewControllerWithIdentifier:@"AuthViewController"];
                    [self.navigationController pushViewController:authVC animated:YES];
                }
            }
                break;
            case 4:{
                //设置
                SettingViewController *settingVC = [self.storyboard instantiateViewControllerWithIdentifier:@"SettingViewController"];
                [self.navigationController pushViewController:settingVC animated:YES];
            }
                break;
            default:
                break;
        }
    
    }
    
}

#pragma mark - MeFansTableCellDelegate

- (void)userEnterAttentionVC{
    AttentionViewController *attenttionVC = [self.storyboard instantiateViewControllerWithIdentifier:@"AttentionViewController"];
    attenttionVC.type = 1;
    [self.navigationController pushViewController:attenttionVC animated:YES];
}

- (void)userEnterFansVC{
    AttentionViewController *attenttionVC = [self.storyboard instantiateViewControllerWithIdentifier:@"AttentionViewController"];
    attenttionVC.type = 2;
    [self.navigationController pushViewController:attenttionVC animated:YES];
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







