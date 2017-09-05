//
//  SettingViewController.m
//  CatLive
//
//  Created by 平凡 on 17/8/14.
//  Copyright © 2017年 Yahaw Lee. All rights reserved.
//

#import "SettingViewController.h"
#import "FeedbackViewController.h"


@interface SettingTableViewCell : UITableViewCell{

    __weak IBOutlet UILabel *_titleLabel;
    
    __weak IBOutlet UILabel *_contentLabel;
    
    __weak IBOutlet UIImageView *_rightArrow;
    
}
@property (nonatomic,assign) SettingCellType cellType;

@end
@implementation SettingTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}
- (void)setCellType:(SettingCellType)cellType{
    switch (cellType) {
        case SettingCellTypeClear:{
            _titleLabel.text = @"清除缓存";
            _contentLabel.text = [[Common getInstance] getCacheSize];
            _contentLabel.hidden = NO;
            _rightArrow.hidden = YES;
        }
            break;
        case SettingCellTypeFeadBack:{
            _titleLabel.text = @"问题反馈";
            _contentLabel.hidden = YES;
            _rightArrow.hidden = NO;
        }
            break;
        case SettingCellTypeAboutUs:{
            _titleLabel.text = @"关于我们";
            _contentLabel.hidden = YES;
            _rightArrow.hidden = NO;
        }
            break;
        default:
            break;
    }

}

@end


@interface SettingLogOutTableViewCell : UITableViewCell{

}

@end
@implementation SettingLogOutTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}
@end
@interface SettingViewController ()<UITableViewDelegate,UITableViewDataSource>{
    
    __weak IBOutlet UITableView *_tableView;

}

@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _tableView.tableFooterView = [[UIView alloc] init];
//    [_tableView reloadData];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0 ) {
        return 3;
    } else {
        return 1;
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
        SettingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SettingTableViewCell"];
        cell.cellType = indexPath.row;
        return cell;
    } else {
        SettingLogOutTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SettingLogOutTableViewCell"];
        return cell;
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:{
                //清理缓存
                [self clearCache];
            }
                break;
            case 1:{
                //问题反馈
                FeedbackViewController *feedVC = [self.storyboard instantiateViewControllerWithIdentifier:@"FeedbackViewController"];
                [self.navigationController pushViewController:feedVC animated:YES];
            }
                break;
            case 2:{
                //关于我们
                
            }
                break;
                
            default:
                break;
        }
    } else if (indexPath.section == 1){
        [[LoginManager manager] logOut];
    }
}


//清除Library/Caches文件夹下缓存大小
- (void)clearCache{
    NSString *cachesPath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
    
    //拿到path路径的下一级目录的子文件夹
    NSArray *subPathArr = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:cachesPath error:nil];
    
    NSString *filePath = nil;
    
    NSError *error = nil;
    
    for (NSString *subPath in subPathArr) {
        filePath = [cachesPath stringByAppendingPathComponent:subPath];
        //删除子文件夹
        [[NSFileManager defaultManager] removeItemAtPath:filePath error:&error];
        //        if (error) {
        //            return NO;
        //        }
    }
    //    return YES;
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



