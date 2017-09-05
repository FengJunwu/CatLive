//
//  InviteViewController.m
//  CatLive
//
//  Created by 平凡 on 17/8/21.
//  Copyright © 2017年 Yahaw Lee. All rights reserved.
//

#import "InviteViewController.h"
#import "InviteInfo.h"
@interface InviteTableViewCell : UITableViewCell {

    __weak IBOutlet UIImageView *_userHeader;
    __weak IBOutlet UILabel *_userNick;
    
    __weak IBOutlet UILabel *_timeLabel;
    
    __weak IBOutlet UILabel *_earnningLabel;

    
}
@property (nonatomic,strong) InviteInfo *inviteInfo;
@end
@implementation InviteTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _userHeader.layer.masksToBounds = YES;
    _userHeader.layer.cornerRadius = 23.0;
}

- (void)setInviteInfo:(InviteInfo *)inviteInfo {
    if (_inviteInfo != inviteInfo) {
        _inviteInfo = inviteInfo;
        
        [_userHeader sd_setImageWithURL:[NSURL URLWithString:_inviteInfo.userImage] placeholderImage:[UIImage imageNamed:@"userHeaderPlace"]];
        _userNick.text = _inviteInfo.userNick;
        _timeLabel.text = _inviteInfo.timeStr;
        _earnningLabel.text = [NSString stringWithFormat:@"累计%ld元",_inviteInfo.earnning];
    }
}

@end


@interface InviteViewController ()<UITableViewDelegate,UITableViewDataSource> {
    
    __weak IBOutlet UITableView *_tableView;

    __weak IBOutlet UIButton *_firstInviteBtn;
    
    __weak IBOutlet UIButton *_secondInviteBtn;
    
    __weak IBOutlet NSLayoutConstraint *_lineLeft;
    
    __weak IBOutlet NSLayoutConstraint *_lineWidth;
    
    
    __weak IBOutlet UIView *_bottomView;
    
    __weak IBOutlet UIButton *_inviteBtn;
    
    
    
    NSMutableArray *_dataArr;

}


@end

@implementation InviteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"邀请赚钱";
    
    [self initRithtBar];
    [self updateTitleBtn];
    [self updateBottomView];
    _tableView.tableFooterView = [[UIView alloc] init];
}

- (void)updateTitleBtn {
    _lineWidth.constant = kScreenWidth / 2.0;
    
    NSString *str1 = [NSString stringWithFormat:@"直接邀请%ld人",10];
    NSString *str2 = [NSString stringWithFormat:@"累计收入%ld元",20.00];
    
    NSMutableAttributedString *mulStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@\n%@",str1,str2]];
    [mulStr addAttributes:@{NSForegroundColorAttributeName:[Common colorWithHexString:@"#646464" alpha:1.0]} range:NSMakeRange(0, mulStr.length)];
    [mulStr addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} range:NSMakeRange(0, str1.length)];
    [mulStr addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]} range:NSMakeRange(0, mulStr.length - str1.length)];
    [_firstInviteBtn setAttributedTitle:mulStr forState:UIControlStateNormal];
    [mulStr addAttributes:@{NSForegroundColorAttributeName:CommonColor} range:NSMakeRange(0, mulStr.length)];
    [_firstInviteBtn setAttributedTitle:mulStr forState:UIControlStateSelected];
    
    NSString *str3 = [NSString stringWithFormat:@"二次分销邀请%ld人",10];
    NSString *str4 = [NSString stringWithFormat:@"累计收入%ld元",20.00];
    
    NSMutableAttributedString *mulStr2 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@\n%@",str3,str4]];
    [mulStr2 addAttributes:@{NSForegroundColorAttributeName:[Common colorWithHexString:@"#646464" alpha:1.0]} range:NSMakeRange(0, mulStr2.length)];
    [mulStr2 addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} range:NSMakeRange(0, str3.length)];
    [mulStr2 addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]} range:NSMakeRange(0, mulStr2.length - str3.length)];
    [_secondInviteBtn setAttributedTitle:mulStr2 forState:UIControlStateNormal];
    [mulStr2 addAttributes:@{NSForegroundColorAttributeName:CommonColor} range:NSMakeRange(0, mulStr.length)];
    [_secondInviteBtn setAttributedTitle:mulStr2 forState:UIControlStateSelected];

}
- (void)updateBottomView {
    _inviteBtn.layer.cornerRadius = 21.0;
    _inviteBtn.layer.masksToBounds = YES;
    
    _bottomView.layer.shadowColor = [UIColor whiteColor].CGColor;
    _bottomView.layer.shadowOffset = CGSizeMake(0, - 4);
    _bottomView.layer.shadowOpacity = 0.6;
    _bottomView.layer.shadowRadius= 4.0;
}

- (void)initRithtBar {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 70, 44);
    [btn setTitle:@"邀请规则" forState:UIControlStateNormal];
    btn.titleLabel.textColor = [UIColor whiteColor];
    btn.titleLabel.font = [UIFont systemFontOfSize:16];
    [btn addTarget:self action:@selector(rightBarButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.rightBarButtonItem = item;
}

- (void)rightBarButtonAction:(UIButton *)btn {
    
    
}

- (IBAction)inviteAction:(UIButton *)sender {
    //邀请好友
    
}


- (IBAction)firstInviteAction:(UIButton *)sender {
    //查看邀请列表
    if (!sender.selected) {
        sender.selected = YES;
        _lineLeft.constant = 0;
        [UIView animateWithDuration:0.25 animations:^{
            [self.view layoutIfNeeded];
        }];
        _secondInviteBtn.selected = NO;
        //请求数据
    }
}
- (IBAction)secondInviteAction:(UIButton *)sender {
    if (!sender.selected) {
        sender.selected = YES;
        _lineLeft.constant = kScreenWidth / 2.0;
        _firstInviteBtn.selected = NO;
        [UIView animateWithDuration:0.25 animations:^{
            [self.view layoutIfNeeded];
        }];
        //请求数据
    }
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    InviteTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"InviteTableViewCell"];
    cell.inviteInfo = _dataArr[indexPath.row];
    return cell;
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







