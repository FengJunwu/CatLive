//
//  PersonalInfoViewController.m
//  CatLive
//
//  Created by 平凡 on 17/8/13.
//  Copyright © 2017年 Yahaw Lee. All rights reserved.
//

#import "PersonalInfoViewController.h"
#import "EditNickViewController.h"

@interface PersonalInfoTableCell : UITableViewCell{
    
    __weak IBOutlet UILabel *_titleLabel;
    
    __weak IBOutlet UILabel *_contentLabel;
    
}
@property (nonatomic,assign) NSInteger index;

@end
@implementation PersonalInfoTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setIndex:(NSInteger)index{
    if (index == 0) {
        _titleLabel.text = @"昵称";
        _contentLabel.hidden = NO;
        _contentLabel.text = [LoginManager manager].userInfo.nickname;
    } else if (index == 2){
        _titleLabel.text = @"修改密码";
        _contentLabel.hidden = YES;
    }
}

@end


@interface PersonalInfoHeaderTableCell : UITableViewCell{
    
    __weak IBOutlet UILabel *_titleLabel;
    __weak IBOutlet UIImageView *_imageView;
    
}


@end
@implementation PersonalInfoHeaderTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    _imageView.layer.cornerRadius = 31.0;
    _imageView.layer.masksToBounds = YES;
    
    
    [_imageView sd_setImageWithURL:[NSURL URLWithString:[LoginManager manager].userInfo.avatar] placeholderImage:[UIImage imageNamed:@"userHeaderPlace"]];
}

@end

@interface PersonalInfoViewController ()<UITableViewDelegate,UITableViewDataSource>{

    __weak IBOutlet UITableView *_tableView;
}

@end

@implementation PersonalInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _tableView.tableFooterView = [[UIView alloc] init];
    
}


#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 1) {
        return 72;
    }
    return 52;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 1) {
        PersonalInfoHeaderTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PersonalInfoHeaderTableCell"];
        return cell;
    } else {
        PersonalInfoTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PersonalInfoTableCell"];
        cell.index = indexPath.row;
        return cell;
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    EditNickViewController *editVC = [self.storyboard instantiateViewControllerWithIdentifier:@"EditNickViewController"];
    [self.navigationController pushViewController:editVC animated:YES];
    
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







